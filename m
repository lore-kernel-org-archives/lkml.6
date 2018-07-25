Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2B9C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE892088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE892088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbeGYPsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:48:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49345 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbeGYPs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:48:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEa8WU403677
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:36:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEa8FF403672;
        Wed, 25 Jul 2018 07:36:08 -0700
Date:   Wed, 25 Jul 2018 07:36:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-fd2efaa4eb5317c3a86357a83a7d456a1b86a0ac@git.kernel.org>
Cc:     parri.andrea@gmail.com, tglx@linutronix.de, hpa@zytor.com,
        boqun.feng@gmail.com, torvalds@linux-foundation.org,
        mingo@kernel.org, mark.rutland@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Reply-To: boqun.feng@gmail.com, hpa@zytor.com,
          torvalds@linux-foundation.org, parri.andrea@gmail.com,
          tglx@linutronix.de, peterz@infradead.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          mark.rutland@arm.com, will.deacon@arm.com
In-Reply-To: <20180716113017.3909-7-mark.rutland@arm.com>
References: <20180716113017.3909-7-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomics: Rework ordering barriers
Git-Commit-ID: fd2efaa4eb5317c3a86357a83a7d456a1b86a0ac
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fd2efaa4eb5317c3a86357a83a7d456a1b86a0ac
Gitweb:     https://git.kernel.org/tip/fd2efaa4eb5317c3a86357a83a7d456a1b86a0ac
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Mon, 16 Jul 2018 12:30:11 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:53:59 +0200

locking/atomics: Rework ordering barriers

Currently architectures can override __atomic_op_*() to define the barriers
used before/after a relaxed atomic when used to build acquire/release/fence
variants.

This has the unfortunate property of requiring the architecture to define the
full wrapper for the atomics, rather than just the barriers they care about,
and gets in the way of generating atomics which can be easily read.

Instead, this patch has architectures define an optional set of barriers:

* __atomic_acquire_fence()
* __atomic_release_fence()
* __atomic_pre_full_fence()
* __atomic_post_full_fence()

... which <linux/atomic.h> uses to build the wrappers.

It would be nice if we could undef these, along with the __atomic_op_*()
wrappers, but that would break the cmpxchg() wrappers, which are written
in preprocessor. Undefs would have been nice, but alas.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: andy.shevchenko@gmail.com
Cc: arnd@arndb.de
Cc: aryabinin@virtuozzo.com
Cc: catalin.marinas@arm.com
Cc: dvyukov@google.com
Cc: glider@google.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: peter@hurleysoftware.com
Link: http://lkml.kernel.org/r/20180716113017.3909-7-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/alpha/include/asm/atomic.h   |  8 ++++----
 arch/powerpc/include/asm/atomic.h | 17 +++++------------
 arch/riscv/include/asm/atomic.h   | 17 +++++------------
 include/linux/atomic.h            | 38 ++++++++++++++++++++++----------------
 4 files changed, 36 insertions(+), 44 deletions(-)

diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index 4a6a8f58c9c9..150a1c5d6a2c 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -18,11 +18,11 @@
  * To ensure dependency ordering is preserved for the _relaxed and
  * _release atomics, an smp_read_barrier_depends() is unconditionally
  * inserted into the _relaxed variants, which are used to build the
- * barriered versions. To avoid redundant back-to-back fences, we can
- * define the _acquire and _fence versions explicitly.
+ * barriered versions. Avoid redundant back-to-back fences in the
+ * _acquire and _fence versions.
  */
-#define __atomic_op_acquire(op, args...)	op##_relaxed(args)
-#define __atomic_op_fence			__atomic_op_release
+#define __atomic_acquire_fence()
+#define __atomic_post_full_fence()
 
 #define ATOMIC_INIT(i)		{ (i) }
 #define ATOMIC64_INIT(i)	{ (i) }
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index a0156cb43d1f..963abf8bf1c0 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -18,18 +18,11 @@
  * a "bne-" instruction at the end, so an isync is enough as a acquire barrier
  * on the platform without lwsync.
  */
-#define __atomic_op_acquire(op, args...)				\
-({									\
-	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
-	__asm__ __volatile__(PPC_ACQUIRE_BARRIER "" : : : "memory");	\
-	__ret;								\
-})
-
-#define __atomic_op_release(op, args...)				\
-({									\
-	__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory");	\
-	op##_relaxed(args);						\
-})
+#define __atomic_acquire_fence()					\
+	__asm__ __volatile__(PPC_ACQUIRE_BARRIER "" : : : "memory")
+
+#define __atomic_release_fence()					\
+	__asm__ __volatile__(PPC_RELEASE_BARRIER "" : : : "memory")
 
 static __inline__ int atomic_read(const atomic_t *v)
 {
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 512b89485790..c452359c9cb8 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -25,18 +25,11 @@
 
 #define ATOMIC_INIT(i)	{ (i) }
 
-#define __atomic_op_acquire(op, args...)				\
-({									\
-	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
-	__asm__ __volatile__(RISCV_ACQUIRE_BARRIER "" ::: "memory");	\
-	__ret;								\
-})
-
-#define __atomic_op_release(op, args...)				\
-({									\
-	__asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory");	\
-	op##_relaxed(args);						\
-})
+#define __atomic_acquire_fence()					\
+	__asm__ __volatile__(RISCV_ACQUIRE_BARRIER "" ::: "memory")
+
+#define __atomic_release_fence()					\
+	__asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory");
 
 static __always_inline int atomic_read(const atomic_t *v)
 {
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 8e04f1f69bd9..1e8e88bdaf09 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -38,40 +38,46 @@
  * barriers on top of the relaxed variant. In the case where the relaxed
  * variant is already fully ordered, no additional barriers are needed.
  *
- * Besides, if an arch has a special barrier for acquire/release, it could
- * implement its own __atomic_op_* and use the same framework for building
- * variants
- *
- * If an architecture overrides __atomic_op_acquire() it will probably want
- * to define smp_mb__after_spinlock().
+ * If an architecture overrides __atomic_acquire_fence() it will probably
+ * want to define smp_mb__after_spinlock().
  */
-#ifndef __atomic_op_acquire
+#ifndef __atomic_acquire_fence
+#define __atomic_acquire_fence		smp_mb__after_atomic
+#endif
+
+#ifndef __atomic_release_fence
+#define __atomic_release_fence		smp_mb__before_atomic
+#endif
+
+#ifndef __atomic_pre_full_fence
+#define __atomic_pre_full_fence		smp_mb__before_atomic
+#endif
+
+#ifndef __atomic_post_full_fence
+#define __atomic_post_full_fence	smp_mb__after_atomic
+#endif
+
 #define __atomic_op_acquire(op, args...)				\
 ({									\
 	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
-	smp_mb__after_atomic();						\
+	__atomic_acquire_fence();					\
 	__ret;								\
 })
-#endif
 
-#ifndef __atomic_op_release
 #define __atomic_op_release(op, args...)				\
 ({									\
-	smp_mb__before_atomic();					\
+	__atomic_release_fence();					\
 	op##_relaxed(args);						\
 })
-#endif
 
-#ifndef __atomic_op_fence
 #define __atomic_op_fence(op, args...)					\
 ({									\
 	typeof(op##_relaxed(args)) __ret;				\
-	smp_mb__before_atomic();					\
+	__atomic_pre_full_fence();					\
 	__ret = op##_relaxed(args);					\
-	smp_mb__after_atomic();						\
+	__atomic_post_full_fence();					\
 	__ret;								\
 })
-#endif
 
 /* atomic_add_return_relaxed */
 #ifndef atomic_add_return_relaxed
