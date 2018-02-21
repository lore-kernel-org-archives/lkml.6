Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753754AbeBUKve (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:51:34 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43175 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeBUKvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:51:32 -0500
Date: Wed, 21 Feb 2018 02:49:57 -0800
From: tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-cb13b424e986aed68d74cbaec3449ea23c50e167@git.kernel.org>
Cc: mingo@kernel.org, tglx@linutronix.de, stern@rowland.harvard.edu,
        torvalds@linux-foundation.org, parri.andrea@gmail.com, rth@twiddle.net,
        hpa@zytor.com, mattst88@gmail.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, ink@jurassic.park.msu.ru, will.deacon@arm.com,
        paulmck@linux.vnet.ibm.com
Reply-To: rth@twiddle.net, parri.andrea@gmail.com, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de, stern@rowland.harvard.edu,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, ink@jurassic.park.msu.ru, will.deacon@arm.com,
        paulmck@linux.vnet.ibm.com, mattst88@gmail.com
In-Reply-To: <1519152356-4804-1-git-send-email-parri.andrea@gmail.com>
References: <1519152356-4804-1-git-send-email-parri.andrea@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/xchg/alpha: Add unconditional memory
 barrier to cmpxchg()
Git-Commit-ID: cb13b424e986aed68d74cbaec3449ea23c50e167
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cb13b424e986aed68d74cbaec3449ea23c50e167
Gitweb:     https://git.kernel.org/tip/cb13b424e986aed68d74cbaec3449ea23c50e167
Author:     Andrea Parri <parri.andrea@gmail.com>
AuthorDate: Tue, 20 Feb 2018 19:45:56 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 10:12:29 +0100

locking/xchg/alpha: Add unconditional memory barrier to cmpxchg()

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
---
 arch/alpha/include/asm/xchg.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/include/asm/xchg.h b/arch/alpha/include/asm/xchg.h
index 68dfb3c..e266086 100644
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
