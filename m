Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66BFC2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A806420823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="H14way9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfAUPxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:53:09 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34440 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbfAUPxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:53:08 -0500
Received: by mail-ed1-f68.google.com with SMTP id b3so17040868ede.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=i9uXPij1beQugnLrBOdzpzV9PE0dxUPUixaCfNGxDXg=;
        b=H14way9/XV22ZJPyYdvYdXCbFXR0C32p1UhVuV9ieu52sWyD5/cRrnDCgzTsmoq7tb
         D+26SV3DmQefe6eRCUehUsz/BZpFDkRJI1Pixrm4wQ0KXLtobpDNOrPAeJ0Q8pvGVJAt
         FVt5ZiCcxAdTzHwqDH8S/aIF3OOCUcyfHZkLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i9uXPij1beQugnLrBOdzpzV9PE0dxUPUixaCfNGxDXg=;
        b=n0IdOC5EP6DVzFid/zhGpC+G5y1Nbv+JO4YsVXZ/QYr/q/V0GjM5uZvv8vNTo9DoIl
         v3hpm09av4hG/KA62AQVdvXnraYduxmCNpsQcR+fROieeS40vPWOzzpnTkLF2FPXUHsa
         GgAa/K8QLX9NkUWL7GDDO2Eftc1UVmRVTTRek1oR4Kh9enaMNsqwbvlhaOcYaqZ1timh
         we3f/ld2zHxVz+1TD6QZVbuuZ3QaApy+LL6+lBT10For/hUQutoMl1lSX0O8xlHF/+NK
         aUxkpM3wpIV6ebU3bRXzcAy8ijENlQhoYeUbPvUuE3zNB4FYrmti+xOYfi+P0W7bFV44
         /k9Q==
X-Gm-Message-State: AJcUukdmPom3Sqky3JcMSrFPe4kPyql67V4nSIJKARxGN9YZQhc4hWW3
        2+ftMXJoibenpTCB4KoXWlpPzcj5g5pcqQ==
X-Google-Smtp-Source: ALg8bN7ckAvPPu5EHrXDrI7bdZ2CB/LtAISD1XAxacbSyOfMx0GcOYIhSe9ngIUet5L9G2c/wcD3XA==
X-Received: by 2002:a17:906:1915:: with SMTP id a21-v6mr25189083eje.101.1548085986562;
        Mon, 21 Jan 2019 07:53:06 -0800 (PST)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id z16-v6sm5103096eju.61.2019.01.21.07.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 07:53:05 -0800 (PST)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2] sched: Use READ_ONCE()/WRITE_ONCE() in move_queued_task()/task_rq_lock()
Date:   Mon, 21 Jan 2019 16:52:40 +0100
Message-Id: <20190121155240.27173-1-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move_queued_task() synchronizes with task_rq_lock() as follows:

	move_queued_task()		task_rq_lock()

	[S] ->on_rq = MIGRATING		[L] rq = task_rq()
	WMB (__set_task_cpu())		ACQUIRE (rq->lock);
	[S] ->cpu = new_cpu		[L] ->on_rq

where "[L] rq = task_rq()" is ordered before "ACQUIRE (rq->lock)" by an
address dependency and, in turn, "ACQUIRE (rq->lock)" is ordered before
"[L] ->on_rq" by the ACQUIRE itself.

Use READ_ONCE() to load ->cpu in task_rq() (c.f., task_cpu()) to honor
this address dependency.  Also, mark the accesses to ->cpu and ->on_rq
with READ_ONCE()/WRITE_ONCE() to comply with the LKMM.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
---
 Changes in v2:
 - mark accesses to ->on_rq as well
 - update inline comment for task_rq_lock()
 - minor editing in the subject/changelog
 
 include/linux/sched.h | 4 ++--
 kernel/sched/core.c   | 9 +++++----
 kernel/sched/sched.h  | 6 +++---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d2f90fa924683..41212d725a0eb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1754,9 +1754,9 @@ static __always_inline bool need_resched(void)
 static inline unsigned int task_cpu(const struct task_struct *p)
 {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
-	return p->cpu;
+	return READ_ONCE(p->cpu);
 #else
-	return task_thread_info(p)->cpu;
+	return READ_ONCE(task_thread_info(p)->cpu);
 #endif
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a674c7db2f29d..d6e08faaa2843 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -107,11 +107,12 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 		 *					[L] ->on_rq
 		 *	RELEASE (rq->lock)
 		 *
-		 * If we observe the old CPU in task_rq_lock, the acquire of
+		 * If we observe the old CPU in task_rq_lock(), the acquire of
 		 * the old rq->lock will fully serialize against the stores.
 		 *
-		 * If we observe the new CPU in task_rq_lock, the acquire will
-		 * pair with the WMB to ensure we must then also see migrating.
+		 * If we observe the new CPU in task_rq_lock(), the address
+		 * dependency headed by '[L] rq = task_rq()' and the acquire
+		 * will pair with the WMB to ensure we then also see migrating.
 		 */
 		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p))) {
 			rq_pin_lock(rq, rf);
@@ -915,7 +916,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 {
 	lockdep_assert_held(&rq->lock);
 
-	p->on_rq = TASK_ON_RQ_MIGRATING;
+	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
 	dequeue_task(rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, new_cpu);
 	rq_unlock(rq, rf);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d04530bf251fe..425a5589e5f60 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1460,9 +1460,9 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
 	 */
 	smp_wmb();
 #ifdef CONFIG_THREAD_INFO_IN_TASK
-	p->cpu = cpu;
+	WRITE_ONCE(p->cpu, cpu);
 #else
-	task_thread_info(p)->cpu = cpu;
+	WRITE_ONCE(task_thread_info(p)->cpu, cpu);
 #endif
 	p->wake_cpu = cpu;
 #endif
@@ -1563,7 +1563,7 @@ static inline int task_on_rq_queued(struct task_struct *p)
 
 static inline int task_on_rq_migrating(struct task_struct *p)
 {
-	return p->on_rq == TASK_ON_RQ_MIGRATING;
+	return READ_ONCE(p->on_rq) == TASK_ON_RQ_MIGRATING;
 }
 
 /*
-- 
2.17.1

