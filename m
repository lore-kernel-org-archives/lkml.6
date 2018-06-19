Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4147DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7B220852
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7B220852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937247AbeFSDOo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 23:14:44 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:55749 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S937169AbeFSDOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 23:14:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01429;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0T2z37lI_1529378072;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T2z37lI_1529378072)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Jun 2018 11:14:33 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH 2/2] sched/fair: Advance global expiration when period
 timer is restarted
To:     bsegall@google.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <20180618091657.21939-1-xlpang@linux.alibaba.com>
 <xm26o9g7q5ux.fsf@bsegall-linux.svl.corp.google.com>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <5f5243c0-ff8c-fc11-9320-61313fd40214@linux.alibaba.com>
Date:   Tue, 19 Jun 2018 11:14:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xm26o9g7q5ux.fsf@bsegall-linux.svl.corp.google.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/18 2:58 AM, bsegall@google.com wrote:
> Xunlei Pang <xlpang@linux.alibaba.com> writes:
> 
>> I noticed the group frequently got throttled even it consumed
>> low cpu usage, this caused some jitters on the response time
>> to some of our business containers enabling cpu quota.
>>
>> It's very easy to reproduce:
>> mkdir /sys/fs/cgroup/cpu/test
>> cd /sys/fs/cgroup/cpu/test
>> echo 100000 > cpu.cfs_quota_us
>> echo $$ > tasks
>> then repeat:
>> cat cpu.stat |grep nr_throttled  // nr_throttled will increase
>>
>> After some analysis, we found that cfs_rq::runtime_remaining will
>> be cleared by expire_cfs_rq_runtime() due to two equal but stale
>> "cfs_{b|q}->runtime_expires" after period timer is re-armed.
> 
> If this is after the first patch, then this is no longer what should
> happen, and instead it would incorrectly /keep/ old local cfs_rq
> runtime, and not __refill global runtime until the period.

Exactly, I can improve the changelog.

> 
> 
>>
>> The global expiration should be advanced accordingly when the
>> bandwidth period timer is restarted.
>>
>> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
>> ---
>>  kernel/sched/fair.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 9f384264e832..bb006e671609 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5204,13 +5204,18 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>>  
>>  void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>>  {
>> +	u64 overrun;
>> +
>>  	lockdep_assert_held(&cfs_b->lock);
>>  
>> -	if (!cfs_b->period_active) {
>> -		cfs_b->period_active = 1;
>> -		hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
>> -		hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>> -	}
>> +	if (cfs_b->period_active)
>> +		return;
>> +
>> +	cfs_b->period_active = 1;
>> +	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
>> +	cfs_b->runtime_expires += (overrun + 1) * ktime_to_ns(cfs_b->period);
> 
> I think we actually want if (overrun) __refill_cfs_bandwidth_runtime(),
> much like tg_set_cfs_bandwidth

It's a little different, e.g. periods like below:

           Pm
           |
           v
  |-----|-----|
Pn-1   Pn    Pn+1

Assuming we start_cfs_bandwidth() at some moment Pm between "Pn" and
"Pn+1", cfs_b->runtime_expires we want here should be "Pn+1", while
__refill_cfs_bandwidth_runtime() forces it to be "Pm+period"(hrtimer
expires at "Pn+1").

Regards,
Xunlei

> 
>> +	cfs_b->expires_seq++;
>> +	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>>  }
>>  
>>  static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
