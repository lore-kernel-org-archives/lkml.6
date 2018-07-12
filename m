Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0402C780DC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512F320839
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="wtdzvVUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512F320839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732742AbeGLRiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:38:15 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:45026 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732687AbeGLRiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cmpxchg.org
        ; s=x; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NnxyiouhvZnUSydapW5h/V7JQgsuHd8XHvJ9oMKS3Xk=; b=wtdzvVUgqJqLsOamE+IiCIHzcc
        DC7mcWHWJ5F8fOLKva4ASf119JwxbWWcGQ3lll4d47DPWI0KW099OU3EhChOXbhV1bvdqq1O1Afg8
        uu5uqb677Xogl2XOBW5MrqeAxVKM6UB1+2o9AwCuIlcnwD2cl/g9E5IIeOPn9ZHzMgsA=;
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 06/10] sched: sched.h: make rq locking and clock functions available in stats.h
Date:   Thu, 12 Jul 2018 13:29:38 -0400
Message-Id: <20180712172942.10094-7-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712172942.10094-1-hannes@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/sched/sched.h includes "stats.h" half-way through the file. The
next patch introduces users of sched.h's rq locking functions and
update_rq_clock() in kernel/sched/stats.h. Move those definitions up
in the file so they are available in stats.h.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/sched.h | 164 +++++++++++++++++++++----------------------
 1 file changed, 82 insertions(+), 82 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cb467c221b15..b8f038497240 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -919,6 +919,8 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
+extern void update_rq_clock(struct rq *rq);
+
 static inline u64 __rq_clock_broken(struct rq *rq)
 {
 	return READ_ONCE(rq->clock);
@@ -1037,6 +1039,86 @@ static inline void rq_repin_lock(struct rq *rq, struct rq_flags *rf)
 #endif
 }
 
+struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
+	__acquires(rq->lock);
+
+struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
+	__acquires(p->pi_lock)
+	__acquires(rq->lock);
+
+static inline void __task_rq_unlock(struct rq *rq, struct rq_flags *rf)
+	__releases(rq->lock)
+{
+	rq_unpin_lock(rq, rf);
+	raw_spin_unlock(&rq->lock);
+}
+
+static inline void
+task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
+	__releases(rq->lock)
+	__releases(p->pi_lock)
+{
+	rq_unpin_lock(rq, rf);
+	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
+}
+
+static inline void
+rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
+	__acquires(rq->lock)
+{
+	raw_spin_lock_irqsave(&rq->lock, rf->flags);
+	rq_pin_lock(rq, rf);
+}
+
+static inline void
+rq_lock_irq(struct rq *rq, struct rq_flags *rf)
+	__acquires(rq->lock)
+{
+	raw_spin_lock_irq(&rq->lock);
+	rq_pin_lock(rq, rf);
+}
+
+static inline void
+rq_lock(struct rq *rq, struct rq_flags *rf)
+	__acquires(rq->lock)
+{
+	raw_spin_lock(&rq->lock);
+	rq_pin_lock(rq, rf);
+}
+
+static inline void
+rq_relock(struct rq *rq, struct rq_flags *rf)
+	__acquires(rq->lock)
+{
+	raw_spin_lock(&rq->lock);
+	rq_repin_lock(rq, rf);
+}
+
+static inline void
+rq_unlock_irqrestore(struct rq *rq, struct rq_flags *rf)
+	__releases(rq->lock)
+{
+	rq_unpin_lock(rq, rf);
+	raw_spin_unlock_irqrestore(&rq->lock, rf->flags);
+}
+
+static inline void
+rq_unlock_irq(struct rq *rq, struct rq_flags *rf)
+	__releases(rq->lock)
+{
+	rq_unpin_lock(rq, rf);
+	raw_spin_unlock_irq(&rq->lock);
+}
+
+static inline void
+rq_unlock(struct rq *rq, struct rq_flags *rf)
+	__releases(rq->lock)
+{
+	rq_unpin_lock(rq, rf);
+	raw_spin_unlock(&rq->lock);
+}
+
 #ifdef CONFIG_NUMA
 enum numa_topology_type {
 	NUMA_DIRECT,
@@ -1670,8 +1752,6 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 	sched_update_tick_dependency(rq);
 }
 
-extern void update_rq_clock(struct rq *rq);
-
 extern void activate_task(struct rq *rq, struct task_struct *p, int flags);
 extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 
@@ -1752,86 +1832,6 @@ static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta) { }
 static inline void sched_avg_update(struct rq *rq) { }
 #endif
 
-struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
-	__acquires(rq->lock);
-
-struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
-	__acquires(p->pi_lock)
-	__acquires(rq->lock);
-
-static inline void __task_rq_unlock(struct rq *rq, struct rq_flags *rf)
-	__releases(rq->lock)
-{
-	rq_unpin_lock(rq, rf);
-	raw_spin_unlock(&rq->lock);
-}
-
-static inline void
-task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
-	__releases(rq->lock)
-	__releases(p->pi_lock)
-{
-	rq_unpin_lock(rq, rf);
-	raw_spin_unlock(&rq->lock);
-	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
-}
-
-static inline void
-rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
-	__acquires(rq->lock)
-{
-	raw_spin_lock_irqsave(&rq->lock, rf->flags);
-	rq_pin_lock(rq, rf);
-}
-
-static inline void
-rq_lock_irq(struct rq *rq, struct rq_flags *rf)
-	__acquires(rq->lock)
-{
-	raw_spin_lock_irq(&rq->lock);
-	rq_pin_lock(rq, rf);
-}
-
-static inline void
-rq_lock(struct rq *rq, struct rq_flags *rf)
-	__acquires(rq->lock)
-{
-	raw_spin_lock(&rq->lock);
-	rq_pin_lock(rq, rf);
-}
-
-static inline void
-rq_relock(struct rq *rq, struct rq_flags *rf)
-	__acquires(rq->lock)
-{
-	raw_spin_lock(&rq->lock);
-	rq_repin_lock(rq, rf);
-}
-
-static inline void
-rq_unlock_irqrestore(struct rq *rq, struct rq_flags *rf)
-	__releases(rq->lock)
-{
-	rq_unpin_lock(rq, rf);
-	raw_spin_unlock_irqrestore(&rq->lock, rf->flags);
-}
-
-static inline void
-rq_unlock_irq(struct rq *rq, struct rq_flags *rf)
-	__releases(rq->lock)
-{
-	rq_unpin_lock(rq, rf);
-	raw_spin_unlock_irq(&rq->lock);
-}
-
-static inline void
-rq_unlock(struct rq *rq, struct rq_flags *rf)
-	__releases(rq->lock)
-{
-	rq_unpin_lock(rq, rf);
-	raw_spin_unlock(&rq->lock);
-}
-
 #ifdef CONFIG_SMP
 #ifdef CONFIG_PREEMPT
 
-- 
2.18.0

