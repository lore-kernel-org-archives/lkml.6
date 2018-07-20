Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43645ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08C820673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EtalVolx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08C820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeGTKUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:20:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbeGTKUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8+qzytnsBEglVVyNwjzyOWBLjWMNGkX4t7Jpwiaa4Gc=; b=EtalVolxoXRhMErybeMjnxWc2
        fEjyMeUqV4/CSNF8hYLEg8duKI1EfFAfXek0D2NIYHbhDx0ufmXF1eeQYTZPhbmENWp1dFURAu6pk
        q6ptGd/238L6YR22LZSdxRHE9cg9xa6j/yl8u+v8RaysPeImeLl/BI0VR3YfkwqjY8iMRvNialG++
        2GCtYHOQsfCVTWG/J1WsUncudsd/ONZ6e+WFq33EgTA1U3NdP52aYL3zbgRBAKrUBR6gO7YTTDtQq
        Lf127hG8CEnXc/wrm0G6uKaIP8Uhn/5nVEvYl+/ggBnuZl0rff7PN1zhuXCeUTdihL5hyLT/e+RyU
        SSe/XNRPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgRmE-0004jT-Bi; Fri, 20 Jul 2018 09:32:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA9E120289335; Fri, 20 Jul 2018 11:32:39 +0200 (CEST)
Date:   Fri, 20 Jul 2018 11:32:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Rik van Riel <riel@surriel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
Message-ID: <20180720093239.GO2494@hirez.programming.kicks-ass.net>
References: <20180716190337.26133-1-riel@surriel.com>
 <20180716190337.26133-5-riel@surriel.com>
 <CALCETrUMntRe_LYX5wj9YD4xZ+84QExK+ZNb3yxEBDEKa7nePQ@mail.gmail.com>
 <B6566AA4-2E8A-43BD-A224-0F6D4747B8FB@surriel.com>
 <F93A3335-4830-4E36-9179-D0FA5D640C8A@amacapital.net>
 <B976CC13-D014-433A-83DE-F8DF9AB4F421@surriel.com>
 <CALCETrWDiMhgiR3f8n0jdWcW31EDJ+Waq0wh5sMDutfigANGnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWDiMhgiR3f8n0jdWcW31EDJ+Waq0wh5sMDutfigANGnA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 09:45:47AM -0700, Andy Lutomirski wrote:
> After some grepping, there are very few users.  The
> only nontrivial ones are the ones in kernel/ and mm/mmu_context.c that
> are involved in the rather complicated dance of refcounting active_mm.

Something like so should work I suppose.

It keeps the field, but ensure that for all tasks tsk->active_mm ==
tsk->mm. The implication is that switch_mm(.prev == NULL) should work
(it does for x86, we don't care about @prev).


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d84eafcf5e29..7bfd850c6bf7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2780,12 +2780,8 @@ static __always_inline struct rq *
 context_switch(struct rq *rq, struct task_struct *prev,
 	       struct task_struct *next, struct rq_flags *rf)
 {
-	struct mm_struct *mm, *oldmm;
-
 	prepare_task_switch(rq, prev, next);
 
-	mm = next->mm;
-	oldmm = prev->active_mm;
 	/*
 	 * For paravirt, this is coupled with an exit in switch_to to
 	 * combine the page table reload and the switch backend into
@@ -2800,16 +2796,32 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	 * membarrier after storing to rq->curr, before returning to
 	 * user-space.
 	 */
-	if (!mm) {
-		next->active_mm = oldmm;
-		mmgrab(oldmm);
-		enter_lazy_tlb(oldmm, next);
-	} else
-		switch_mm_irqs_off(oldmm, mm, next);
-
-	if (!prev->mm) {
-		prev->active_mm = NULL;
-		rq->prev_mm = oldmm;
+
+	/*
+	 * kernel -> kernel   lazy + transfer active
+	 *   user -> kernel   lazy + mmgrab() active
+	 *
+	 * kernel ->   user   switch + mmdrop() active
+	 *   user ->   user   switch
+	 */
+	if (!next->mm) {				// to kernel
+		enter_lazy_tlb(prev->active_mm, next);
+
+#ifdef ARCH_NO_ACTIVE_MM
+		next->active_mm = prev->active_mm;
+		if (prev->mm)				// from user
+			mmgrab(prev->active_mm);
+#endif
+	} else {					// to user
+		switch_mm_irqs_off(prev->active_mm, next->mm, next);
+
+#ifdef ARCH_NO_ACTIVE_MM
+		if (!prev->mm) {			// from kernel
+			/* will mmdrop() in finish_task_switch(). */
+			rq->prev_mm = prev->active_mm;
+			prev->active_mm = NULL;
+		}
+#endif
 	}
 
 	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
diff --git a/mm/mmu_context.c b/mm/mmu_context.c
index 3e612ae748e9..770bb615d115 100644
--- a/mm/mmu_context.c
+++ b/mm/mmu_context.c
@@ -12,6 +12,10 @@
 
 #include <asm/mmu_context.h>
 
+#ifndef finish_arch_post_lock_switch
+# define finish_arch_post_lock_switch()	do { } while (0)
+#endif
+
 /*
  * use_mm
  *	Makes the calling kernel thread take on the specified
@@ -33,12 +37,14 @@ void use_mm(struct mm_struct *mm)
 	tsk->mm = mm;
 	switch_mm(active_mm, mm, tsk);
 	task_unlock(tsk);
-#ifdef finish_arch_post_lock_switch
 	finish_arch_post_lock_switch();
-#endif
 
+#ifdef ARCH_NO_ACTIVE_MM
+	WARN_ON_ONCE(active_mm != NULL);
+#else
 	if (active_mm != mm)
 		mmdrop(active_mm);
+#endif
 }
 EXPORT_SYMBOL_GPL(use_mm);
 
@@ -57,8 +63,22 @@ void unuse_mm(struct mm_struct *mm)
 	task_lock(tsk);
 	sync_mm_rss(mm);
 	tsk->mm = NULL;
+
+	WARN_ON_ONCE(tsk->active_mm != mm);
+
+#ifdef ARCH_NO_ACTIVE_MM
+	switch_mm(tsk->active_mm, &init_mm, tsk);
+	mmdrop(tsk->active_mm);
+	tsk->active_mm = NULL;
+#else
 	/* active_mm is still 'mm' */
 	enter_lazy_tlb(mm, tsk);
+#endif
+
 	task_unlock(tsk);
+
+#ifdef ARCH_NO_ACTIVE_MM
+	finish_arch_post_lock_switch();
+#endif
 }
 EXPORT_SYMBOL_GPL(unuse_mm);
