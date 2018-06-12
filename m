Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A5B61C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50739208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ifHdByuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50739208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934559AbeFLQ3y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:29:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933378AbeFLQ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XzftzdKV9BNtZOhPNYeIEn0nGZ/MC6RGlTv1nK0uJ+I=; b=ifHdByuGvzznhkH446Xix6eL1L
        kEGBhRv9atE4VfQEe8hq2Q5XnmmSPcAoLUYxDZcI+FeQdBgWIDIkvyz/WlowB16hCqZTrBuHQL522
        5qDDo0r3j2CW2IIf4Qtji+ccSFVHJBZ/qfRysvYqcCAV3jMFdt2Dzvb5MTHo3eSWg40AcH2UycjD1
        fveXBB2ah+WhXxXl7Ik/C47WfvkCJgBD8Z4qjjsMLEEJQ8J6w9rY+NvqWAB9fJn1etDYl9CqHH2Ev
        udT+mVQ/kC/BPOoyrn+jgm/wqXv5drV+m2yDra9WymQpLKgfxxMzNig/3CD+7W6iqlhhOCEBOc9RS
        kd4aH6dA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSmAz-00035Q-UX; Tue, 12 Jun 2018 16:29:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D48BB201EA7D1; Tue, 12 Jun 2018 18:29:43 +0200 (CEST)
Message-Id: <20180612161832.480477516@infradead.org>
User-Agent: quilt/0.63-1
Date:   Tue, 12 Jun 2018 18:12:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, oleg@redhat.com, gkohli@codeaurora.org
Cc:     tglx@linutronix.de, mpe@ellerman.id.au, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org
Subject: [PATCH v2 3/4] smpboot: Remove cpumask from the API
References: <20180612161225.693133662@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-kthread-2.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the sole use of the whole smpboot_*cpumask() API is gone,
remove it.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/smpboot.h |   15 -------------
 kernel/smpboot.c        |   54 ++++--------------------------------------------
 2 files changed, 6 insertions(+), 63 deletions(-)

--- a/include/linux/smpboot.h
+++ b/include/linux/smpboot.h
@@ -25,8 +25,6 @@ struct smpboot_thread_data;
  *			parked (cpu offline)
  * @unpark:		Optional unpark function, called when the thread is
  *			unparked (cpu online)
- * @cpumask:		Internal state.  To update which threads are unparked,
- *			call smpboot_update_cpumask_percpu_thread().
  * @selfparking:	Thread is not parked by the park function.
  * @thread_comm:	The base name of the thread
  */
@@ -40,23 +38,12 @@ struct smp_hotplug_thread {
 	void				(*cleanup)(unsigned int cpu, bool online);
 	void				(*park)(unsigned int cpu);
 	void				(*unpark)(unsigned int cpu);
-	cpumask_var_t			cpumask;
 	bool				selfparking;
 	const char			*thread_comm;
 };
 
-int smpboot_register_percpu_thread_cpumask(struct smp_hotplug_thread *plug_thread,
-					   const struct cpumask *cpumask);
-
-static inline int
-smpboot_register_percpu_thread(struct smp_hotplug_thread *plug_thread)
-{
-	return smpboot_register_percpu_thread_cpumask(plug_thread,
-						      cpu_possible_mask);
-}
+int smpboot_register_percpu_thread(struct smp_hotplug_thread *plug_thread);
 
 void smpboot_unregister_percpu_thread(struct smp_hotplug_thread *plug_thread);
-void smpboot_update_cpumask_percpu_thread(struct smp_hotplug_thread *plug_thread,
-					  const struct cpumask *);
 
 #endif
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -238,8 +238,7 @@ int smpboot_unpark_threads(unsigned int
 
 	mutex_lock(&smpboot_threads_lock);
 	list_for_each_entry(cur, &hotplug_threads, list)
-		if (cpumask_test_cpu(cpu, cur->cpumask))
-			smpboot_unpark_thread(cur, cpu);
+		smpboot_unpark_thread(cur, cpu);
 	mutex_unlock(&smpboot_threads_lock);
 	return 0;
 }
@@ -280,34 +279,26 @@ static void smpboot_destroy_threads(stru
 }
 
 /**
- * smpboot_register_percpu_thread_cpumask - Register a per_cpu thread related
+ * smpboot_register_percpu_thread - Register a per_cpu thread related
  * 					    to hotplug
  * @plug_thread:	Hotplug thread descriptor
- * @cpumask:		The cpumask where threads run
  *
  * Creates and starts the threads on all online cpus.
  */
-int smpboot_register_percpu_thread_cpumask(struct smp_hotplug_thread *plug_thread,
-					   const struct cpumask *cpumask)
+int smpboot_register_percpu_thread(struct smp_hotplug_thread *plug_thread)
 {
 	unsigned int cpu;
 	int ret = 0;
 
-	if (!alloc_cpumask_var(&plug_thread->cpumask, GFP_KERNEL))
-		return -ENOMEM;
-	cpumask_copy(plug_thread->cpumask, cpumask);
-
 	get_online_cpus();
 	mutex_lock(&smpboot_threads_lock);
 	for_each_online_cpu(cpu) {
 		ret = __smpboot_create_thread(plug_thread, cpu);
 		if (ret) {
 			smpboot_destroy_threads(plug_thread);
-			free_cpumask_var(plug_thread->cpumask);
 			goto out;
 		}
-		if (cpumask_test_cpu(cpu, cpumask))
-			smpboot_unpark_thread(plug_thread, cpu);
+		smpboot_unpark_thread(plug_thread, cpu);
 	}
 	list_add(&plug_thread->list, &hotplug_threads);
 out:
@@ -315,7 +306,7 @@ int smpboot_register_percpu_thread_cpuma
 	put_online_cpus();
 	return ret;
 }
-EXPORT_SYMBOL_GPL(smpboot_register_percpu_thread_cpumask);
+EXPORT_SYMBOL_GPL(smpboot_register_percpu_thread);
 
 /**
  * smpboot_unregister_percpu_thread - Unregister a per_cpu thread related to hotplug
@@ -331,44 +322,9 @@ void smpboot_unregister_percpu_thread(st
 	smpboot_destroy_threads(plug_thread);
 	mutex_unlock(&smpboot_threads_lock);
 	put_online_cpus();
-	free_cpumask_var(plug_thread->cpumask);
 }
 EXPORT_SYMBOL_GPL(smpboot_unregister_percpu_thread);
 
-/**
- * smpboot_update_cpumask_percpu_thread - Adjust which per_cpu hotplug threads stay parked
- * @plug_thread:	Hotplug thread descriptor
- * @new:		Revised mask to use
- *
- * The cpumask field in the smp_hotplug_thread must not be updated directly
- * by the client, but only by calling this function.
- * This function can only be called on a registered smp_hotplug_thread.
- */
-void smpboot_update_cpumask_percpu_thread(struct smp_hotplug_thread *plug_thread,
-					  const struct cpumask *new)
-{
-	struct cpumask *old = plug_thread->cpumask;
-	static struct cpumask tmp;
-	unsigned int cpu;
-
-	lockdep_assert_cpus_held();
-	mutex_lock(&smpboot_threads_lock);
-
-	/* Park threads that were exclusively enabled on the old mask. */
-	cpumask_andnot(&tmp, old, new);
-	for_each_cpu_and(cpu, &tmp, cpu_online_mask)
-		smpboot_park_thread(plug_thread, cpu);
-
-	/* Unpark threads that are exclusively enabled on the new mask. */
-	cpumask_andnot(&tmp, new, old);
-	for_each_cpu_and(cpu, &tmp, cpu_online_mask)
-		smpboot_unpark_thread(plug_thread, cpu);
-
-	cpumask_copy(old, new);
-
-	mutex_unlock(&smpboot_threads_lock);
-}
-
 static DEFINE_PER_CPU(atomic_t, cpu_hotplug_state) = ATOMIC_INIT(CPU_POST_DEAD);
 
 /*


