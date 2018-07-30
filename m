Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4414C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3118720873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3118720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeG3HC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 03:02:29 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:33534 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725858AbeG3HC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 03:02:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0T5bsOPs_1532928531;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0T5bsOPs_1532928531)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 30 Jul 2018 13:28:52 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH] sched/fair: sync expires_seq in distribute_cfs_runtime()
To:     Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180728002409.5781-1-xiyou.wangcong@gmail.com>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <ef0e1185-51d6-0707-cda4-6f2ea987b651@linux.alibaba.com>
Date:   Mon, 30 Jul 2018 13:28:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180728002409.5781-1-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cong,

On 7/28/18 8:24 AM, Cong Wang wrote:
> Each time we sync cfs_rq->runtime_expires with cfs_b->runtime_expires,
> we should sync its ->expires_seq too. However it is missing
> for distribute_cfs_runtime(), especially the slack timer call path.

I don't think it's a problem, as expires_seq will get synced in
assign_cfs_rq_runtime().

Thanks,
Xunlei

> 
> Fixes: 512ac999d275 ("sched/fair: Fix bandwidth timer clock drift condition")
> Cc: Xunlei Pang <xlpang@linux.alibaba.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>  kernel/sched/fair.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2f0a0be4d344..910c50db3d74 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4857,7 +4857,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  }
>  
>  static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
> -		u64 remaining, u64 expires)
> +		u64 remaining, u64 expires, int expires_seq)
>  {
>  	struct cfs_rq *cfs_rq;
>  	u64 runtime;
> @@ -4880,6 +4880,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
>  
>  		cfs_rq->runtime_remaining += runtime;
>  		cfs_rq->runtime_expires = expires;
> +		cfs_rq->expires_seq = expires_seq;
>  
>  		/* we check whether we're throttled above */
>  		if (cfs_rq->runtime_remaining > 0)
> @@ -4905,7 +4906,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
>  static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
>  {
>  	u64 runtime, runtime_expires;
> -	int throttled;
> +	int throttled, expires_seq;
>  
>  	/* no need to continue the timer with no bandwidth constraint */
>  	if (cfs_b->quota == RUNTIME_INF)
> @@ -4933,6 +4934,7 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
>  	cfs_b->nr_throttled += overrun;
>  
>  	runtime_expires = cfs_b->runtime_expires;
> +	expires_seq = cfs_b->expires_seq;
>  
>  	/*
>  	 * This check is repeated as we are holding onto the new bandwidth while
> @@ -4946,7 +4948,7 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
>  		raw_spin_unlock(&cfs_b->lock);
>  		/* we can't nest cfs_b->lock while distributing bandwidth */
>  		runtime = distribute_cfs_runtime(cfs_b, runtime,
> -						 runtime_expires);
> +						 runtime_expires, expires_seq);
>  		raw_spin_lock(&cfs_b->lock);
>  
>  		throttled = !list_empty(&cfs_b->throttled_cfs_rq);
> @@ -5055,6 +5057,7 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>  static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>  {
>  	u64 runtime = 0, slice = sched_cfs_bandwidth_slice();
> +	int expires_seq;
>  	u64 expires;
>  
>  	/* confirm we're still not at a refresh boundary */
> @@ -5068,12 +5071,13 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>  		runtime = cfs_b->runtime;
>  
>  	expires = cfs_b->runtime_expires;
> +	expires_seq = cfs_b->expires_seq;
>  	raw_spin_unlock(&cfs_b->lock);
>  
>  	if (!runtime)
>  		return;
>  
> -	runtime = distribute_cfs_runtime(cfs_b, runtime, expires);
> +	runtime = distribute_cfs_runtime(cfs_b, runtime, expires, expires_seq);
>  
>  	raw_spin_lock(&cfs_b->lock);
>  	if (expires == cfs_b->runtime_expires)
> 
