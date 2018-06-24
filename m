Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7C0C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E04224EAB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E04224EAB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbeFXLTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 07:19:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44827 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeFXLTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 07:19:33 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fX33L-000467-RG; Sun, 24 Jun 2018 13:19:32 +0200
Date:   Sun, 24 Jun 2018 13:19:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] locking updates for 4.18
Message-ID: <alpine.DEB.2.21.1806241305540.8650@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

A set of fixes and updates for the locking code:

  - Prevent lockdep from updating irq state within its own code and thereby
    confusing itself.

  - Buid fix for older GCCs which mistreat anonymous unions

  - Add a missing lockdep annotation in down_read_non_onwer() which causes
    up_read_non_owner() to emit a lockdep splat

  - Remove the custom alpha dec_and_lock() implementation which is
    incorrect in terms of ordering and use the generic one.

  The remaining two commits are not strictly fixes. They provide irqsave
  variants of atomic_dec_and_lock() and refcount_dec_and_lock().  These are
  required to merge the relevant updates and cleanups into different
  maintainer trees for 4.19, so routing them into mainline without actual
  users is the sanest approach. They should have been in -rc1, but last
  weekend I took the liberty to just avoid computers in order to regain
  some mental sanity.

Thanks,

	tglx

------------------>
Anna-Maria Gleixner (2):
      atomic: Add irqsave variant of atomic_dec_and_lock()
      locking/refcounts: Implement refcount_dec_and_lock_irqsave()

Sebastian Andrzej Siewior (1):
      alpha: Remove custom dec_and_lock() implementation

Steven Rostedt (VMware) (2):
      locking/lockdep: Do not record IRQ state within lockdep code
      locking/qspinlock: Fix build for anonymous union in older GCC compilers

Waiman Long (1):
      locking/rwsem: Fix up_read_non_owner() warning with DEBUG_RWSEMS


 arch/alpha/Kconfig                    |  5 ----
 arch/alpha/lib/Makefile               |  2 --
 arch/alpha/lib/dec_and_lock.c         | 44 -----------------------------------
 include/asm-generic/qspinlock_types.h |  2 +-
 include/linux/refcount.h              |  4 +++-
 include/linux/spinlock.h              |  5 ++++
 kernel/locking/lockdep.c              | 12 +++++-----
 kernel/locking/rwsem.c                |  1 +
 lib/Makefile                          |  6 +----
 lib/dec_and_lock.c                    | 16 +++++++++++++
 lib/refcount.c                        | 28 ++++++++++++++++++++++
 11 files changed, 61 insertions(+), 64 deletions(-)
 delete mode 100644 arch/alpha/lib/dec_and_lock.c

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 0c4805a572c8..04a4a138ed13 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -555,11 +555,6 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
-config HAVE_DEC_LOCK
-	bool
-	depends on SMP
-	default y
-
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
 	range 2 32
diff --git a/arch/alpha/lib/Makefile b/arch/alpha/lib/Makefile
index 04f9729de57c..854d5e79979e 100644
--- a/arch/alpha/lib/Makefile
+++ b/arch/alpha/lib/Makefile
@@ -35,8 +35,6 @@ lib-y =	__divqu.o __remqu.o __divlu.o __remlu.o \
 	callback_srm.o srm_puts.o srm_printk.o \
 	fls.o
 
-lib-$(CONFIG_SMP) += dec_and_lock.o
-
 # The division routines are built from single source, with different defines.
 AFLAGS___divqu.o = -DDIV
 AFLAGS___remqu.o =       -DREM
diff --git a/arch/alpha/lib/dec_and_lock.c b/arch/alpha/lib/dec_and_lock.c
deleted file mode 100644
index a117707f57fe..000000000000
--- a/arch/alpha/lib/dec_and_lock.c
+++ /dev/null
@@ -1,44 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * arch/alpha/lib/dec_and_lock.c
- *
- * ll/sc version of atomic_dec_and_lock()
- * 
- */
-
-#include <linux/spinlock.h>
-#include <linux/atomic.h>
-#include <linux/export.h>
-
-  asm (".text					\n\
-	.global _atomic_dec_and_lock		\n\
-	.ent _atomic_dec_and_lock		\n\
-	.align	4				\n\
-_atomic_dec_and_lock:				\n\
-	.prologue 0				\n\
-1:	ldl_l	$1, 0($16)			\n\
-	subl	$1, 1, $1			\n\
-	beq	$1, 2f				\n\
-	stl_c	$1, 0($16)			\n\
-	beq	$1, 4f				\n\
-	mb					\n\
-	clr	$0				\n\
-	ret					\n\
-2:	br	$29, 3f				\n\
-3:	ldgp	$29, 0($29)			\n\
-	br	$atomic_dec_and_lock_1..ng	\n\
-	.subsection 2				\n\
-4:	br	1b				\n\
-	.previous				\n\
-	.end _atomic_dec_and_lock");
-
-static int __used atomic_dec_and_lock_1(atomic_t *atomic, spinlock_t *lock)
-{
-	/* Slow path */
-	spin_lock(lock);
-	if (atomic_dec_and_test(atomic))
-		return 1;
-	spin_unlock(lock);
-	return 0;
-}
-EXPORT_SYMBOL(_atomic_dec_and_lock);
diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index 0763f065b975..d10f1e7d6ba8 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -63,7 +63,7 @@ typedef struct qspinlock {
 /*
  * Initializier
  */
-#define	__ARCH_SPIN_LOCK_UNLOCKED	{ .val = ATOMIC_INIT(0) }
+#define	__ARCH_SPIN_LOCK_UNLOCKED	{ { .val = ATOMIC_INIT(0) } }
 
 /*
  * Bitfields in the atomic value:
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 4193c41e383a..a685da2c4522 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -98,5 +98,7 @@ extern __must_check bool refcount_dec_if_one(refcount_t *r);
 extern __must_check bool refcount_dec_not_one(refcount_t *r);
 extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct mutex *lock);
 extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock);
-
+extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
+						       spinlock_t *lock,
+						       unsigned long *flags);
 #endif /* _LINUX_REFCOUNT_H */
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 1e8a46435838..fd57888d4942 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -427,6 +427,11 @@ extern int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock);
 #define atomic_dec_and_lock(atomic, lock) \
 		__cond_lock(lock, _atomic_dec_and_lock(atomic, lock))
 
+extern int _atomic_dec_and_lock_irqsave(atomic_t *atomic, spinlock_t *lock,
+					unsigned long *flags);
+#define atomic_dec_and_lock_irqsave(atomic, lock, flags) \
+		__cond_lock(lock, _atomic_dec_and_lock_irqsave(atomic, lock, &(flags)))
+
 int alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
 			   size_t max_size, unsigned int cpu_mult,
 			   gfp_t gfp);
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index edcac5de7ebc..5fa4d3138bf1 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1265,11 +1265,11 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
 	this.parent = NULL;
 	this.class = class;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_forward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 
 	return ret;
 }
@@ -1292,11 +1292,11 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	this.parent = NULL;
 	this.class = class;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_backward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 
 	return ret;
 }
@@ -4411,7 +4411,7 @@ void debug_check_no_locks_freed(const void *mem_from, unsigned long mem_len)
 	if (unlikely(!debug_locks))
 		return;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	for (i = 0; i < curr->lockdep_depth; i++) {
 		hlock = curr->held_locks + i;
 
@@ -4422,7 +4422,7 @@ void debug_check_no_locks_freed(const void *mem_from, unsigned long mem_len)
 		print_freed_lock_bug(curr, mem_from, mem_from + mem_len, hlock);
 		break;
 	}
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(debug_check_no_locks_freed);
 
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index bc1e507be9ff..776308d2fa9e 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -181,6 +181,7 @@ void down_read_non_owner(struct rw_semaphore *sem)
 	might_sleep();
 
 	__down_read(sem);
+	rwsem_set_reader_owned(sem);
 }
 
 EXPORT_SYMBOL(down_read_non_owner);
diff --git a/lib/Makefile b/lib/Makefile
index 84c6dcb31fbb..8b59f4a7c0e2 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -23,7 +23,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 sha1.o chacha20.o irq_regs.o argv_split.o \
 	 flex_proportions.o ratelimit.o show_mem.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
-	 earlycpio.o seq_buf.o siphash.o \
+	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o nodemask.o win_minmax.o
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
@@ -98,10 +98,6 @@ obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
 obj-$(CONFIG_DEBUG_LIST) += list_debug.o
 obj-$(CONFIG_DEBUG_OBJECTS) += debugobjects.o
 
-ifneq ($(CONFIG_HAVE_DEC_LOCK),y)
-  lib-y += dec_and_lock.o
-endif
-
 obj-$(CONFIG_BITREVERSE) += bitrev.o
 obj-$(CONFIG_RATIONAL)	+= rational.o
 obj-$(CONFIG_CRC_CCITT)	+= crc-ccitt.o
diff --git a/lib/dec_and_lock.c b/lib/dec_and_lock.c
index 347fa7ac2e8a..9555b68bb774 100644
--- a/lib/dec_and_lock.c
+++ b/lib/dec_and_lock.c
@@ -33,3 +33,19 @@ int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
 }
 
 EXPORT_SYMBOL(_atomic_dec_and_lock);
+
+int _atomic_dec_and_lock_irqsave(atomic_t *atomic, spinlock_t *lock,
+				 unsigned long *flags)
+{
+	/* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
+	if (atomic_add_unless(atomic, -1, 1))
+		return 0;
+
+	/* Otherwise do it the slow way */
+	spin_lock_irqsave(lock, *flags);
+	if (atomic_dec_and_test(atomic))
+		return 1;
+	spin_unlock_irqrestore(lock, *flags);
+	return 0;
+}
+EXPORT_SYMBOL(_atomic_dec_and_lock_irqsave);
diff --git a/lib/refcount.c b/lib/refcount.c
index 0eb48353abe3..d3b81cefce91 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -350,3 +350,31 @@ bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
 }
 EXPORT_SYMBOL(refcount_dec_and_lock);
 
+/**
+ * refcount_dec_and_lock_irqsave - return holding spinlock with disabled
+ *                                 interrupts if able to decrement refcount to 0
+ * @r: the refcount
+ * @lock: the spinlock to be locked
+ * @flags: saved IRQ-flags if the is acquired
+ *
+ * Same as refcount_dec_and_lock() above except that the spinlock is acquired
+ * with disabled interupts.
+ *
+ * Return: true and hold spinlock if able to decrement refcount to 0, false
+ *         otherwise
+ */
+bool refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
+				   unsigned long *flags)
+{
+	if (refcount_dec_not_one(r))
+		return false;
+
+	spin_lock_irqsave(lock, *flags);
+	if (!refcount_dec_and_test(r)) {
+		spin_unlock_irqrestore(lock, *flags);
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(refcount_dec_and_lock_irqsave);
