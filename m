Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940241AbeE1Qf5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:35:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934669AbeE1KIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:08:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Turner <mattst88@gmail.com>, Richard Henderson <rth@twiddle.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, linux-alpha@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 063/185] locking/xchg/alpha: Add unconditional memory barrier to cmpxchg()
Date: Mon, 28 May 2018 12:01:44 +0200
Message-Id: <20180528100056.229667403@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrea Parri <parri.andrea@gmail.com>

[ Upstream commit cb13b424e986aed68d74cbaec3449ea23c50e167 ]

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
Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-alpha@vger.kernel.org
Link: http://lkml.kernel.org/r/1519152356-4804-1-git-send-email-parri.andrea@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/alpha/include/asm/xchg.h |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/arch/alpha/include/asm/xchg.h
+++ b/arch/alpha/include/asm/xchg.h
@@ -127,10 +127,9 @@ ____xchg(, volatile void *ptr, unsigned
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
@@ -149,8 +148,8 @@ ____cmpxchg(_u8, volatile char *m, unsig
 	"	or	%1,%2,%2\n"
 	"	stq_c	%2,0(%4)\n"
 	"	beq	%2,3f\n"
-		__ASM__MB
 	"2:\n"
+		__ASM__MB
 	".subsection 2\n"
 	"3:	br	1b\n"
 	".previous"
@@ -176,8 +175,8 @@ ____cmpxchg(_u16, volatile short *m, uns
 	"	or	%1,%2,%2\n"
 	"	stq_c	%2,0(%4)\n"
 	"	beq	%2,3f\n"
-		__ASM__MB
 	"2:\n"
+		__ASM__MB
 	".subsection 2\n"
 	"3:	br	1b\n"
 	".previous"
@@ -199,8 +198,8 @@ ____cmpxchg(_u32, volatile int *m, int o
 	"	mov %4,%1\n"
 	"	stl_c %1,%2\n"
 	"	beq %1,3f\n"
-		__ASM__MB
 	"2:\n"
+		__ASM__MB
 	".subsection 2\n"
 	"3:	br 1b\n"
 	".previous"
@@ -222,8 +221,8 @@ ____cmpxchg(_u64, volatile long *m, unsi
 	"	mov %4,%1\n"
 	"	stq_c %1,%2\n"
 	"	beq %1,3f\n"
-		__ASM__MB
 	"2:\n"
+		__ASM__MB
 	".subsection 2\n"
 	"3:	br 1b\n"
 	".previous"
