Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3DD72C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78C9208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78C9208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934601AbeFLQQz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:16:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41434 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934016AbeFLQQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:16:53 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fSlyI-0000sL-Ne; Tue, 12 Jun 2018 18:16:38 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH 1/3] alpha: remove custom dec_and_lock() implementation
Date:   Tue, 12 Jun 2018 18:16:19 +0200
Message-Id: <20180612161621.22645-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612161621.22645-1-bigeasy@linutronix.de>
References: <20180612161621.22645-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
in terms of performance. Regarding the different barriers, Peter
Zijlstra says:
|refcount decrement needs to be a RELEASE operation, such that all the
|load/stores to the object happen before we decrement the refcount.
|
|Otherwise things like:
|
|        obj->foo =3D 5;
|        refcnt_dec(&obj->ref);
|
|can be re-ordered, which then allows fun scenarios like:
|
|        CPU0                            CPU1
|
|        refcnt_dec(&obj->ref);
|                                        if (dec_and_test(&obj->ref))
|                                                free(obj);
|        obj->foo =3D 5; // oops UaF
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

I suggest to remove the custom alpha implementation of dec_and_lock()
and if it is an issue (performance wise) we could still inline the fast
path of dec_and_lock().

Link: https://lkml.kernel.org/r/20180606115918.GG12198@hirez.programming.ki=
cks-ass.net
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
=20
 	  If you don't know what to do here, say N.
=20
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
@@ -35,8 +35,6 @@ lib-y =3D	__divqu.o __remqu.o __divlu.o __remlu.o \
 	callback_srm.o srm_puts.o srm_printk.o \
 	fls.o
=20
-lib-$(CONFIG_SMP) +=3D dec_and_lock.o
-
 # The division routines are built from single source, with different defin=
es.
 AFLAGS___divqu.o =3D -DDIV
 AFLAGS___remqu.o =3D       -DREM
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
- *=20
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
@@ -23,7 +23,7 @@ lib-y :=3D ctype.o string.o vsprintf.o cmdline.o \
 	 sha1.o chacha20.o irq_regs.o argv_split.o \
 	 flex_proportions.o ratelimit.o show_mem.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
-	 earlycpio.o seq_buf.o siphash.o \
+	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o nodemask.o win_minmax.o
=20
 lib-$(CONFIG_PRINTK) +=3D dump_stack.o
@@ -96,10 +96,6 @@ obj-$(CONFIG_DEBUG_PREEMPT) +=3D smp_processor_id.o
 obj-$(CONFIG_DEBUG_LIST) +=3D list_debug.o
 obj-$(CONFIG_DEBUG_OBJECTS) +=3D debugobjects.o
=20
-ifneq ($(CONFIG_HAVE_DEC_LOCK),y)
-  lib-y +=3D dec_and_lock.o
-endif
-
 obj-$(CONFIG_BITREVERSE) +=3D bitrev.o
 obj-$(CONFIG_RATIONAL)	+=3D rational.o
 obj-$(CONFIG_CRC_CCITT)	+=3D crc-ccitt.o
--=20
2.17.1

