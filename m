Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbeBTSqV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:46:21 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41826 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeBTSqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:46:19 -0500
X-Google-Smtp-Source: AH8x227qoDFYw6i6O/WBoV/f75pybZ9DGkJAQI96Hpr5RYOSA6Zi/ihw4IjWCZFmOeUQL9jxwiN4vA==
From: Andrea Parri <parri.andrea@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xchg/alpha: Add unconditional memory barrier to cmpxchg
Date: Tue, 20 Feb 2018 19:45:56 +0100
Message-Id: <1519152356-4804-1-git-send-email-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continuing along with the fight against smp_read_barrier_depends() [1]
(or rather, against its improper use), add an unconditional barrier to
cmpxchg.  This guarantees that dependency ordering is preserved when a
dependency is headed by an unsuccessful cmpxchg.  As it turns out, the
change could enable further simplification of LKMM as proposed in [2].

[1] https://marc.info/?l=linux-kernel&m=150884953419377&w=2
    https://marc.info/?l=linux-kernel&m=150884946319353&w=2
    https://marc.info/?l=linux-kernel&m=151215810824468&w=2
    https://marc.info/?l=linux-kernel&m=151215816324484&w=2

[2] https://marc.info/?l=linux-kernel&m=151881978314872&w=2

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/alpha/include/asm/xchg.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/include/asm/xchg.h b/arch/alpha/include/asm/xchg.h
index 68dfb3cb71454..e2660866ce972 100644
--- a/arch/alpha/include/asm/xchg.h
+++ b/arch/alpha/include/asm/xchg.h
@@ -128,10 +128,9 @@ ____xchg(, volatile void *ptr, unsigned long x, int size)
  * store NEW in MEM.  Return the initial value in MEM.  Success is
  * indicated by comparing RETURN with OLD.
  *
- * The memory barrier should be placed in SMP only when we actually
- * make the change. If we don't change anything (so if the returned
- * prev is equal to old) then we aren't acquiring anything new and
- * we don't need any memory barrier as far I can tell.
+ * The memory barrier is placed in SMP unconditionally, in order to
+ * guarantee that dependency ordering is preserved when a dependency
+ * is headed by an unsuccessful operation.
  */
 
 static inline unsigned long
@@ -150,8 +149,8 @@ ____cmpxchg(_u8, volatile char *m, unsigned char old, unsigned char new)
 	"	or	%1,%2,%2\n"
 	"	stq_c	%2,0(%4)\n"
 	"	beq	%2,3f\n"
-		__ASM__MB
 	"2:\n"
+		__ASM__MB
 	".subsection 2\n"
 	"3:	br	1b\n"
 	".previous"
@@ -177,8 +176,8 @@ ____cmpxchg(_u16, volatile short *m, unsigned short old, unsigned short new)
 	"	or	%1,%2,%2\n"
 	"	stq_c	%2,0(%4)\n"
 	"	beq	%2,3f\n"
-		__ASM__MB
 	"2:\n"
+		__ASM__MB
 	".subsection 2\n"
 	"3:	br	1b\n"
 	".previous"
@@ -200,8 +199,8 @@ ____cmpxchg(_u32, volatile int *m, int old, int new)
 	"	mov %4,%1\n"
 	"	stl_c %1,%2\n"
 	"	beq %1,3f\n"
-		__ASM__MB
 	"2:\n"
+		__ASM__MB
 	".subsection 2\n"
 	"3:	br 1b\n"
 	".previous"
@@ -223,8 +222,8 @@ ____cmpxchg(_u64, volatile long *m, unsigned long old, unsigned long new)
 	"	mov %4,%1\n"
 	"	stq_c %1,%2\n"
 	"	beq %1,3f\n"
-		__ASM__MB
 	"2:\n"
+		__ASM__MB
 	".subsection 2\n"
 	"3:	br 1b\n"
 	".previous"
-- 
2.7.4
