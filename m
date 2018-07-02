Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F465C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B62248D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AP/6D88E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B62248D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753108AbeGBMo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:44:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41864 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753063AbeGBMov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pRBylj61MqFIBWuF6o1MohAYKIQXpkjLfSsCLlShiZc=; b=AP/6D88EzEtqYGNUPojUlMZu7
        2Fd9YkQmkgo8B7Ud7WaBZ6LJ70wlHRIzVSueGVkyudWr8yJddtQfkzm/lnvY+UbzDqOd3cblQ+SoC
        fgptXeGQsgSzxPownqy8wUTVFfll8jCe0JyhO6rKdVcpYtkurcY1YZl2gld4HOFuQxnwDs1vDq+nW
        Ls+gdtlFmg95+IBm1c8NjLl/JZJZZ+cvKysAstXNRbmdNK1mjDbv4qPSxH9czdQea2OOvf9AwK81i
        RjTGtaYgMaZTJSCKD1NT6vRlug18B35Yhgc5QrDheB1zFh4cErihMrcYZPnVYPq3kAlwfCuQMtv47
        5VFfjGySg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fZyCD-0006I2-87; Mon, 02 Jul 2018 12:44:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD56F2029F1DB; Mon,  2 Jul 2018 14:44:43 +0200 (CEST)
Date:   Mon, 2 Jul 2018 14:44:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Jacek Tomaka <jacekt@dug.com>
Subject: Re: [PATCH] sched/nohz: Skip remote tick on idle task entirely
Message-ID: <20180702124443.GN2494@hirez.programming.kicks-ass.net>
References: <1530203381-31234-1-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530203381-31234-1-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 06:29:41PM +0200, Frederic Weisbecker wrote:
> ---
>  kernel/sched/core.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 78d8fac..da8f121 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3127,16 +3127,18 @@ static void sched_tick_remote(struct work_struct *work)
>  		u64 delta;
>  
>  		rq_lock_irq(rq, &rf);
> -		update_rq_clock(rq);
>  		curr = rq->curr;
> -		delta = rq_clock_task(rq) - curr->se.exec_start;
> +		if (!is_idle_task(curr)) {
> +			update_rq_clock(rq);
> +			delta = rq_clock_task(rq) - curr->se.exec_start;
>  
> -		/*
> -		 * Make sure the next tick runs within a reasonable
> -		 * amount of time.
> -		 */
> -		WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
> -		curr->sched_class->task_tick(rq, curr, 0);
> +			/*
> +			 * Make sure the next tick runs within a reasonable
> +			 * amount of time.
> +			 */
> +			WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
> +			curr->sched_class->task_tick(rq, curr, 0);
> +		}
>  		rq_unlock_irq(rq, &rf);
>  	}

Instead of deep indent, how about we write it like so: ?

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3113,7 +3113,9 @@ static void sched_tick_remote(struct wor
 	struct tick_work *twork = container_of(dwork, struct tick_work, work);
 	int cpu = twork->cpu;
 	struct rq *rq = cpu_rq(cpu);
+	struct task_struct *curr;
 	struct rq_flags rf;
+	u64 delta;
 
 	/*
 	 * Handle the tick only if it appears the remote CPU is running in full
@@ -3122,26 +3124,28 @@ static void sched_tick_remote(struct wor
 	 * statistics and checks timeslices in a time-independent way, regardless
 	 * of when exactly it is running.
 	 */
-	if (!idle_cpu(cpu) && tick_nohz_tick_stopped_cpu(cpu)) {
-		struct task_struct *curr;
-		u64 delta;
-
-		rq_lock_irq(rq, &rf);
-		curr = rq->curr;
-		if (!is_idle_task(curr)) {
-			update_rq_clock(rq);
-			delta = rq_clock_task(rq) - curr->se.exec_start;
-
-			/*
-			 * Make sure the next tick runs within a reasonable
-			 * amount of time.
-			 */
-			WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
-			curr->sched_class->task_tick(rq, curr, 0);
-		}
-		rq_unlock_irq(rq, &rf);
-	}
+	if (idle_cpu(cpu) || !tick_nohz_tick_stopped_cpu(cpu))
+		goto out_requeue;
 
+	rq_lock_irq(rq, &rf);
+	curr = rq->curr;
+	if (is_idle_task(curr))
+		goto out_unlock;
+
+	update_rq_clock(rq);
+	delta = rq_clock_task(rq) - curr->se.exec_start;
+
+	/*
+	 * Make sure the next tick runs within a reasonable
+	 * amount of time.
+	 */
+	WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+	curr->sched_class->task_tick(rq, curr, 0);
+
+out_unlock:
+	rq_unlock_irq(rq, &rf);
+
+out_requeue:
 	/*
 	 * Run the remote tick once per second (1Hz). This arbitrary
 	 * frequency is large enough to avoid overload but short enough
