Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06B8C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B5F20852
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B5F20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964954AbeFSC5X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 22:57:23 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:54937 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934644AbeFSC5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 22:57:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0T2ychIM_1529377025;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T2ychIM_1529377025)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Jun 2018 10:57:06 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH 1/2] sched/fair: Fix bandwidth timer clock drift condition
To:     bsegall@google.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <20180618091618.21480-1-xlpang@linux.alibaba.com>
 <xm26sh5korxh.fsf@bsegall-linux.svl.corp.google.com>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <fb29a5e6-3715-4b30-f852-ea002526615a@linux.alibaba.com>
Date:   Tue, 19 Jun 2018 10:57:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xm26sh5korxh.fsf@bsegall-linux.svl.corp.google.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/18 2:44 AM, bsegall@google.com wrote:
> Xunlei Pang <xlpang@linux.alibaba.com> writes:
> 
>> The current condition to judge clock drift in expire_cfs_rq_runtime()
>> is wrong, the two runtime_expires are actually the same when clock
>> drift happens, so this condtion can never hit. The orginal design was
>> correctly done by commit a9cf55b28610 ("sched: Expire invalid runtime"),
>> but was changed to be the current one due to its locking issue.
>>
>> This patch introduces another way, it adds a new field in both structure
>> cfs_rq and cfs_bandwidth to record the expiration update sequence, and
>> use them to figure out if clock drift happens(true if they equal).
> 
> It might just be simplest to revert the comparison change - if we read a
> torn value, the worst that happens is we extend incorrectly, and that
> is exactly what happens if we just read the old value.
> 
> An extra int isn't exactly the worst thing though, so whichever.

I tried that, it might still consume the old runtime in the worst case,
I choosed this way considering more cfs_b->runtime_expires change in the
2nd patch.

The extra fields added can gurantee the correct control, also it does
not increase the total size of the two structures.

Thanks,
Xunlei

> 
>>
>> This fix is also needed by the following patch.
>>
>> Fixes: 51f2176d74ac ("sched/fair: Fix unlocked reads of some cfs_b->quota/period")
>> Cc: Ben Segall <bsegall@google.com>
>> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
>> ---
>>  kernel/sched/fair.c  | 14 ++++++++------
>>  kernel/sched/sched.h |  6 ++++--
>>  2 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index e497c05aab7f..9f384264e832 100644
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
>> @@ -4629,6 +4631,7 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>>  		}
>>  	}
>>  	expires = cfs_b->runtime_expires;
>> +	expires_seq = cfs_b->expires_seq;
>>  	raw_spin_unlock(&cfs_b->lock);
>>  
>>  	cfs_rq->runtime_remaining += amount;
>> @@ -4637,8 +4640,10 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>>  	 * spread between our sched_clock and the one on which runtime was
>>  	 * issued.
>>  	 */
>> -	if ((s64)(expires - cfs_rq->runtime_expires) > 0)
>> +	if ((s64)(expires - cfs_rq->runtime_expires) > 0) {
>>  		cfs_rq->runtime_expires = expires;
>> +		cfs_rq->expires_seq = expires_seq;
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
