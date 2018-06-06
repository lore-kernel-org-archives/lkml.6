Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18D40606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeFFLTM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:19:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49751 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbeFFLTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:19:11 -0400
Date: Wed, 6 Jun 2018 13:18:50 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH 0.5/5] alpha: remove custom dec_and_lock() implementation
Message-ID: <20180606111849.4vr2ap2w4mlyqm23@linutronix.de>
References: <20180504154533.8833-1-bigeasy@linutronix.de>
 <20180504154533.8833-2-bigeasy@linutronix.de>
 <20180604102559.2ynbassthjzva62l@linutronix.de>
 <20180604102757.h46feymcfdydl4nz@linutronix.de>
 <20180604114852.GQ12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604114852.GQ12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alpha provides a custom implementation of dec_and_lock(). The functions
is split into two parts:
- atomic_add_unless() + return 0 (fast path in assembly)
- remaining part including locking (slow path in C)

Comparing the result of the alpha implementation with the generic
implementation compiled by gcc it looks like the fast path is optimized
by avoiding a stack frame (and reloading the GP), register store and all
this. This is only done in the slowpath.
After marking the slowpath (atomic_dec_and_lock_1()) as "noinline" and
doing the slowpath in C (the atomic_add_unless(atomic, -1, 1) part) I
noticed differences in the resulting assembly:
- the GP is still reloaded
- atomic_add_unless() adds more memory barriers compared to the custom
  assembly
- the custom assembly here does "load, sub, beq" while
  atomic_add_unless() does "load, cmpeq, add, bne". This is okay because
  it compares against zero after subtraction while the generic code
  compares against 1 before.

I'm not sure if avoiding the stack frame (and GP reloading) brings a lot
in terms of performance. I can't tell if the different memory barriers
are an issue but having the same barriers is probably good.
This implementation forces me however to do the same thing for the
upcoming dec_and_lock_irqsave() which I would like to avoid.

I suggest to remove the custom alpha implementation of dec_and_lock()
and if it is an issue (performance wise) we could still inline the fast
path of dec_and_lock().

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/alpha/Kconfig            |  5 ----
 arch/alpha/lib/Makefile       |  2 --
 arch/alpha/lib/dec_and_lock.c | 44 -----------------------------------
 lib/Makefile                  |  6 +----
 4 files changed, 1 insertion(+), 56 deletions(-)
 delete mode 100644 arch/alpha/lib/dec_and_lock.c

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index f19dc31288c8..786649e0fdf9 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -565,11 +565,6 @@ config SMP
 
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
diff --git a/lib/Makefile b/lib/Makefile
index ce20696d5a92..d0c1531c43f4 100644
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
@@ -96,10 +96,6 @@ obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
 obj-$(CONFIG_DEBUG_LIST) += list_debug.o
 obj-$(CONFIG_DEBUG_OBJECTS) += debugobjects.o
 
-ifneq ($(CONFIG_HAVE_DEC_LOCK),y)
-  lib-y += dec_and_lock.o
-endif
-
 obj-$(CONFIG_BITREVERSE) += bitrev.o
 obj-$(CONFIG_RATIONAL)	+= rational.o
 obj-$(CONFIG_CRC_CCITT)	+= crc-ccitt.o
-- 
2.17.1
