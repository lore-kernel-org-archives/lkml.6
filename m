Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C93C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A8620647
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A8620647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754420AbeFUD5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 23:57:15 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:43295 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754245AbeFUD5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 23:57:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07402;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0T34u4qY_1529553416;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T34u4qY_1529553416)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Jun 2018 11:56:57 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH v2 1/2] sched/fair: Fix bandwidth timer clock drift
 condition
To:     bsegall@google.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20180620101834.24455-1-xlpang@linux.alibaba.com>
 <xm26fu1hpf2b.fsf@bsegall-linux.svl.corp.google.com>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <60638b2b-5044-3653-287b-738f254dbf92@linux.alibaba.com>
Date:   Thu, 21 Jun 2018 11:56:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xm26fu1hpf2b.fsf@bsegall-linux.svl.corp.google.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/18 1:01 AM, bsegall@google.com wrote:
> Xunlei Pang <xlpang@linux.alibaba.com> writes:
> 
>> I noticed the group constantly got throttled even it consumed
>> low cpu usage, this caused some jitters on the response time
>> to some of our business containers enabling cpu quota.
>>
>> It's very simple to reproduce:
>>   mkdir /sys/fs/cgroup/cpu/test
>>   cd /sys/fs/cgroup/cpu/test
>>   echo 100000 > cpu.cfs_quota_us
>>   echo $$ > tasks
>> then repeat:
>>   cat cpu.stat |grep nr_throttled  // nr_throttled will increase
>>
>> After some analysis, we found that cfs_rq::runtime_remaining will
>> be cleared by expire_cfs_rq_runtime() due to two equal but stale
>> "cfs_{b|q}->runtime_expires" after period timer is re-armed.
>>
>> The current condition to judge clock drift in expire_cfs_rq_runtime()
>> is wrong, the two runtime_expires are actually the same when clock
>> drift happens, so this condtion can never hit. The orginal design was
>> correctly done by commit a9cf55b28610 ("sched: Expire invalid runtime"),
>> but was changed to be the current one due to its locking issue.
>>
>> This patch introduces another way, it adds a new field in both structures
>> cfs_rq and cfs_bandwidth to record the expiration update sequence, and
>> use them to figure out if clock drift happens(true if they equal).
>>
>> Fixes: 51f2176d74ac ("sched/fair: Fix unlocked reads of some cfs_b->quota/period")
>> Cc: Ben Segall <bsegall@google.com>
> 
> Reviewed-By: Ben Segall <bsegall@google.com>

Thanks Ben :-)

Hi Peter, could you please have a look at them?

Cc stable@vger.kernel.org

> 
>> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
>> ---
>>  kernel/sched/fair.c  | 14 ++++++++------
>>  kernel/sched/sched.h |  6 ++++--
>>  2 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index e497c05aab7f..e6bb68d52962 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4590,6 +4590,7 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
>>  	now = sched_clock_cpu(smp_processor_id());
>>  	cfs_b->runtime = cfs_b->quota;
>>  	cfs_b->runtime_expires = now + ktime_to_ns(cfs_b->period);
>> +	cfs_b->expires_seq++;
>>  }
>>  
>>  static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
>> @@ -4612,6 +4613,7 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>>  	struct task_group *tg = cfs_rq->tg;
>>  	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(tg);
>>  	u64 amount = 0, min_amount, expires;
>> +	int expires_seq;
>>  
>>  	/* note: this is a positive sum as runtime_remaining <= 0 */
>>  	min_amount = sched_cfs_bandwidth_slice() - cfs_rq->runtime_remaining;
>> @@ -4628,6 +4630,7 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>>  			cfs_b->idle = 0;
>>  		}
>>  	}
>> +	expires_seq = cfs_b->expires_seq;
>>  	expires = cfs_b->runtime_expires;
>>  	raw_spin_unlock(&cfs_b->lock);
>>  
>> @@ -4637,8 +4640,10 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>>  	 * spread between our sched_clock and the one on which runtime was
>>  	 * issued.
>>  	 */
>> -	if ((s64)(expires - cfs_rq->runtime_expires) > 0)
>> +	if (cfs_rq->expires_seq != expires_seq) {
>> +		cfs_rq->expires_seq = expires_seq;
>>  		cfs_rq->runtime_expires = expires;
>> +	}
>>  
>>  	return cfs_rq->runtime_remaining > 0;
>>  }
>> @@ -4664,12 +4669,9 @@ static void expire_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>>  	 * has not truly expired.
>>  	 *
>>  	 * Fortunately we can check determine whether this the case by checking
>> -	 * whether the global deadline has advanced. It is valid to compare
>> -	 * cfs_b->runtime_expires without any locks since we only care about
>> -	 * exact equality, so a partial write will still work.
>> +	 * whether the global deadline(cfs_b->expires_seq) has advanced.
>>  	 */
>> -
>> -	if (cfs_rq->runtime_expires != cfs_b->runtime_expires) {
>> +	if (cfs_rq->expires_seq == cfs_b->expires_seq) {
>>  		/* extend local deadline, drift is bounded above by 2 ticks */
>>  		cfs_rq->runtime_expires += TICK_NSEC;
>>  	} else {
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 6601baf2361c..e977e04f8daf 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -334,9 +334,10 @@ struct cfs_bandwidth {
>>  	u64			runtime;
>>  	s64			hierarchical_quota;
>>  	u64			runtime_expires;
>> +	int			expires_seq;
>>  
>> -	int			idle;
>> -	int			period_active;
>> +	short			idle;
>> +	short			period_active;
>>  	struct hrtimer		period_timer;
>>  	struct hrtimer		slack_timer;
>>  	struct list_head	throttled_cfs_rq;
>> @@ -551,6 +552,7 @@ struct cfs_rq {
>>  
>>  #ifdef CONFIG_CFS_BANDWIDTH
>>  	int			runtime_enabled;
>> +	int			expires_seq;
>>  	u64			runtime_expires;
>>  	s64			runtime_remaining;
