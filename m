Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D8265C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1752086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1752086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934379AbeFLVhr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:37:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51783 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933637AbeFLVhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:37:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5CLar3a180301
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 12 Jun 2018 14:36:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5CLaq6d180298;
        Tue, 12 Jun 2018 14:36:52 -0700
Date:   Tue, 12 Jun 2018 14:36:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-f2ae67941138a1e53cb1bc6a1b5878a8bdc74d26@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
        ink@jurassic.park.msu.ru, mingo@kernel.org, bigeasy@linutronix.de,
        tglx@linutronix.de, rth@twiddle.net, mattst88@gmail.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          ink@jurassic.park.msu.ru, peterz@infradead.org, hpa@zytor.com,
          rth@twiddle.net, tglx@linutronix.de, bigeasy@linutronix.de,
          mattst88@gmail.com
In-Reply-To: <20180606115918.GG12198@hirez.programming.kicks-ass.net>
References: <20180606115918.GG12198@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] alpha: Remove custom dec_and_lock()
 implementation
Git-Commit-ID: f2ae67941138a1e53cb1bc6a1b5878a8bdc74d26
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

Commit-ID:  f2ae67941138a1e53cb1bc6a1b5878a8bdc74d26
Gitweb:     https://git.kernel.org/tip/f2ae67941138a1e53cb1bc6a1b5878a8bdc74d26
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Tue, 12 Jun 2018 18:16:19 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 12 Jun 2018 23:33:24 +0200

alpha: Remove custom dec_and_lock() implementation

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
in terms of performance. Regarding the different barriers, Peter
Zijlstra says:

|refcount decrement needs to be a RELEASE operation, such that all the
|load/stores to the object happen before we decrement the refcount.
|
|Otherwise things like:
|
|        obj->foo = 5;
|        refcnt_dec(&obj->ref);
|
|can be re-ordered, which then allows fun scenarios like:
|
|        CPU0                            CPU1
|
|        refcnt_dec(&obj->ref);
|                                        if (dec_and_test(&obj->ref))
|                                                free(obj);
|        obj->foo = 5; // oops UaF
|
|
|This means (for alpha) that there should be a memory barrier _before_
|the decrement, however the dec_and_lock asm thing only has one _after_,
|which, per the above, is too late.
|
|The generic version using add_unless will result in memory barrier
|before and after (because that is the rule for atomic ops with a return
|value) which is strictly too many barriers for the refcount story, but
|who knows what other ordering requirements code has.

Remove the custom alpha implementation of dec_and_lock() and if it is an
issue (performance wise) then the fast path could still be inlined.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Link: https://lkml.kernel.org/r/20180606115918.GG12198@hirez.programming.kicks-ass.net
Link: https://lkml.kernel.org/r20180612161621.22645-2-bigeasy@linutronix.de

---
 arch/alpha/Kconfig            |  5 -----
 arch/alpha/lib/Makefile       |  2 --
 arch/alpha/lib/dec_and_lock.c | 44 -------------------------------------------
 lib/Makefile                  |  6 +-----
 4 files changed, 1 insertion(+), 56 deletions(-)

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
