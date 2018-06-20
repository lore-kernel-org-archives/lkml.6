Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E90C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D7020652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D7020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753872AbeFTGGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 02:06:24 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:50699 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751327AbeFTGGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 02:06:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0T31Pi3M_1529474766;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T31Pi3M_1529474766)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Jun 2018 14:06:07 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH 2/2] sched/fair: Advance global expiration when period
 timer is restarted
To:     bsegall@google.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <20180618091657.21939-1-xlpang@linux.alibaba.com>
 <xm26o9g7q5ux.fsf@bsegall-linux.svl.corp.google.com>
 <5f5243c0-ff8c-fc11-9320-61313fd40214@linux.alibaba.com>
 <xm26k1qupsy0.fsf@bsegall-linux.svl.corp.google.com>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <6023891f-894a-f251-1d39-939f13143886@linux.alibaba.com>
Date:   Wed, 20 Jun 2018 14:06:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xm26k1qupsy0.fsf@bsegall-linux.svl.corp.google.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/18 1:49 AM, bsegall@google.com wrote:
> Xunlei Pang <xlpang@linux.alibaba.com> writes:
> 
>> On 6/19/18 2:58 AM, bsegall@google.com wrote:
>>> Xunlei Pang <xlpang@linux.alibaba.com> writes:
>>>
>>>> I noticed the group frequently got throttled even it consumed
>>>> low cpu usage, this caused some jitters on the response time
>>>> to some of our business containers enabling cpu quota.
>>>>
>>>> It's very easy to reproduce:
>>>> mkdir /sys/fs/cgroup/cpu/test
>>>> cd /sys/fs/cgroup/cpu/test
>>>> echo 100000 > cpu.cfs_quota_us
>>>> echo $$ > tasks
>>>> then repeat:
>>>> cat cpu.stat |grep nr_throttled  // nr_throttled will increase
>>>>
>>>> After some analysis, we found that cfs_rq::runtime_remaining will
>>>> be cleared by expire_cfs_rq_runtime() due to two equal but stale
>>>> "cfs_{b|q}->runtime_expires" after period timer is re-armed.
>>>
>>> If this is after the first patch, then this is no longer what should
>>> happen, and instead it would incorrectly /keep/ old local cfs_rq
>>> runtime, and not __refill global runtime until the period.
>>
>> Exactly, I can improve the changelog.
>>
>>>
>>>
>>>>
>>>> The global expiration should be advanced accordingly when the
>>>> bandwidth period timer is restarted.
>>>>
>>>> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
>>>> ---
>>>>  kernel/sched/fair.c | 15 ++++++++++-----
>>>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 9f384264e832..bb006e671609 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -5204,13 +5204,18 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>>>>  
>>>>  void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>>>>  {
>>>> +	u64 overrun;
>>>> +
>>>>  	lockdep_assert_held(&cfs_b->lock);
>>>>  
>>>> -	if (!cfs_b->period_active) {
>>>> -		cfs_b->period_active = 1;
>>>> -		hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
>>>> -		hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>>>> -	}
>>>> +	if (cfs_b->period_active)
> 
>>>> +		return;
>>>> +
>>>> +	cfs_b->period_active = 1;
>>>> +	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
>>>> +	cfs_b->runtime_expires += (overrun + 1) * ktime_to_ns(cfs_b->period);
>>>
>>> I think we actually want if (overrun) __refill_cfs_bandwidth_runtime(),
>>> much like tg_set_cfs_bandwidth
>>
>> It's a little different, e.g. periods like below:
>>
>>            Pm
>>            |
>>            v
>>   |-----|-----|
>> Pn-1   Pn    Pn+1
>>
>> Assuming we start_cfs_bandwidth() at some moment Pm between "Pn" and
>> "Pn+1", cfs_b->runtime_expires we want here should be "Pn+1", while
>> __refill_cfs_bandwidth_runtime() forces it to be "Pm+period"(hrtimer
>> expires at "Pn+1").
>>
>> Regards,
>> Xunlei
>>
> 
> Hmm, yeah, it would wind up out of sync with the hrtimer unless we
> restarted the period boundaries.
> 
> Now that I look at it even more closely, I don't see how you're getting
> problems like that, besides wasting tiny amounts of cpu time in expire:
> we only disable the period timer when there has been a full period with
> no activity, so we should have a full cfs_b->runtime, and a
> runtime_expires from the period that was spent entirely idle (so it
> should always be in the past). But with a working extend-local-deadline
> check like after patch 1 it shouldn't /matter/ what the actual value of
> runtime_expires is, we'll just waste tiny amounts of cpu time
> incrementing runtime_expires every account_cfs_rq_runtime call rather
> than aborting early.
> 
> Actually, I think arguably the real issue may be in patch 1:

Ben,

Thanks for the comments.

Yes, the problematic throttle issue is solved by patch 1, and it's a
different issue in patch 2. It wants to address another stale runtime
issue(I will update the changelog in v2), specifically:
An ever-running cfs_rq tends to retain some runtime(min_cfs_rq_runtime),
it could be even more(sysctl_sched_cfs_bandwidth_slice) in the worst
case, these runtime should be discarded once the period is advanced.

Without this patch expire_cfs_rq_runtime() will see the two equal
cfs_rq{b}->expires_seq after period gets restarted after some idle,
so it will fall into the "clock drift" branch and go on consuming
the old runtime if any.

With the expiration update done in patch 2, we can ensure the stale
cfs_rq->runtime_remaining gets cleared at expire_cfs_rq_runtime()
once a new period begins.

> 
>>> @@ -4637,8 +4640,10 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>>>  	 * spread between our sched_clock and the one on which runtime was
>>>  	 * issued.
>>>  	 */
>>> -	if ((s64)(expires - cfs_rq->runtime_expires) > 0)
>>> +	if ((s64)(expires - cfs_rq->runtime_expires) > 0) {
>>>  		cfs_rq->runtime_expires = expires;
>>> +		cfs_rq->expires_seq = expires_seq;
>>> +	}
>>>  
>>>  	return cfs_rq->runtime_remaining > 0;
>>>  }
> 
> 
> We don't want to clobber a tick-extended runtime_expires with the
> original one, but we /do/ want update if expires_seq changes, no matter
> what (rather than skipping updating both if we've tick-extended past the
> /next/ period's runtime_expires).
> 
> I think this should actually be
> 
> if (cfs_rq->expires_seq != expires_seq) {
> 	cfs_rq->runtime_expires = expires;
> 	cfs_rq->expires_seq = expires_seq;
> }
> 
> Can you easily check and see if this fixes the issue without this second
> patch? That would clear up how the actual problem is happening, and I
> think it's a change we'd want anyways.

Agree, I will have it in v2.

> 
> That said, we should also just update runtime_expires like this patch
> does regardless, and as mentioned we should have a full cfs_b->runtime
> so we don't need a __refill like I was originally thinking.
>
Regards,
Xunlei
