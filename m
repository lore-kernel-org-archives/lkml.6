Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD26ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C41D20858
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G/csEoCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C41D20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388477AbeGTNTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:19:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36390 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732142AbeGTNTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yca4/uww9hjY67fZ8ME2TF9ad1KeTQ7IKz9qexw/6a8=; b=G/csEoCXxPATD9fEPRyNLgA45
        S2nOJrwdFE1qmFJmtrzL2+a/32sGAKMnfjQBt4+BwWc3XffYFc+6F6NoNIRjKY4U2IYzJuSBNM6sK
        r0fy535OlNmw4/ixb1ryTr22zNRhgM+qC9eKHhtFogvsP+EYLmnqjJavkA/BrgsN6qoiETeW/ifyi
        J+CjbXVg+KBavpSHnDTHEdnzRx5lJ564uYb2ewG0U6YOgM6R/bXDgDI6wdVcItjQ81NpQD6thefUg
        clvXlS6oWyi3s67mWYsgEuuU23rKqi0YZ6gRm1hPE7YOPhYZ8+DEzrrmYfL7IGjXqzHHXcsxE7JlK
        h9o3EG+jA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgUZY-0007DX-0e; Fri, 20 Jul 2018 12:31:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32BCB20275F4A; Fri, 20 Jul 2018 14:31:46 +0200 (CEST)
Date:   Fri, 20 Jul 2018 14:31:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org
Subject: Re: [PATCH] sched/fair: remove #ifdefs from scale_rt_capacity
Message-ID: <20180720123146.GL2476@hirez.programming.kicks-ass.net>
References: <1532001606-6689-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532001606-6689-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 02:00:06PM +0200, Vincent Guittot wrote:
> But the compiler is not able to optimize the sequence (at least with
> aarch64 GCC 7.2.1)
> 	free *= (max - irq);
> 	free /= max;
> when irq is fixed to 0

So much for compilers.... I though those things were supposed to be
'clever'.

> +#if defined(SMP) \
> + && (defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING))

That's atrocious :-)

Fixed it with the below.


--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -135,7 +135,7 @@ static void update_rq_clock_task(struct
  * In theory, the compile should just see 0 here, and optimize out the call
  * to sched_rt_avg_update. But I don't trust it...
  */
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+#ifdef HAVE_SCHED_AVG_IRQ
 	s64 steal = 0, irq_delta = 0;
 #endif
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
@@ -177,7 +177,7 @@ static void update_rq_clock_task(struct
 
 	rq->clock_task += delta;
 
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+#ifdef HAVE_SCHED_AVG_IRQ
 	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
 		update_irq_load_avg(rq, irq_delta + steal);
 #endif
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -856,6 +856,7 @@ struct rq {
 	struct sched_avg	avg_rt;
 	struct sched_avg	avg_dl;
 #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+#define HAVE_SCHED_AVG_IRQ
 	struct sched_avg	avg_irq;
 #endif
 	u64			idle_stamp;
@@ -2212,8 +2213,7 @@ static inline unsigned long cpu_util_rt(
 }
 #endif
 
-#if defined(SMP) \
- && (defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING))
+#ifdef HAVE_SCHED_AVG_IRQ
 static inline unsigned long cpu_util_irq(struct rq *rq)
 {
 	return rq->avg_irq.util_avg;
