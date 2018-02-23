Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeBWI2w (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:28:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35879 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbeBWI2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:28:50 -0500
Date: Fri, 23 Feb 2018 00:28:21 -0800
From: tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-472e8c55cf6622d1c112dc2bc777f68bbd4189db@git.kernel.org>
Cc: ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org,
        mingo@kernel.org, akpm@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, hpa@zytor.com, tglx@linutronix.de,
        mattst88@gmail.com, parri.andrea@gmail.com, will.deacon@arm.com,
        rth@twiddle.net, stern@rowland.harvard.edu,
        torvalds@linux-foundation.org, peterz@infradead.org
Reply-To: parri.andrea@gmail.com, will.deacon@arm.com, rth@twiddle.net,
        stern@rowland.harvard.edu, torvalds@linux-foundation.org,
        peterz@infradead.org, ink@jurassic.park.msu.ru, mingo@kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tglx@linutronix.de, paulmck@linux.vnet.ibm.com, hpa@zytor.com,
        mattst88@gmail.com
In-Reply-To: <1519291488-5752-1-git-send-email-parri.andrea@gmail.com>
References: <1519291488-5752-1-git-send-email-parri.andrea@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/xchg/alpha: Fix xchg() and cmpxchg()
 memory ordering bugs
Git-Commit-ID: 472e8c55cf6622d1c112dc2bc777f68bbd4189db
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

Commit-ID:  472e8c55cf6622d1c112dc2bc777f68bbd4189db
Gitweb:     https://git.kernel.org/tip/472e8c55cf6622d1c112dc2bc777f68bbd4189db
Author:     Andrea Parri <parri.andrea@gmail.com>
AuthorDate: Thu, 22 Feb 2018 10:24:48 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 23 Feb 2018 08:38:16 +0100

locking/xchg/alpha: Fix xchg() and cmpxchg() memory ordering bugs

Successful RMW operations are supposed to be fully ordered, but
Alpha's xchg() and cmpxchg() do not meet this requirement.

Will Deacon noticed the bug:

  > So MP using xchg:
  >
  > WRITE_ONCE(x, 1)
  > xchg(y, 1)
  >
  > smp_load_acquire(y) == 1
  > READ_ONCE(x) == 0
  >
  > would be allowed.

... which thus violates the above requirement.

Fix it by adding a leading smp_mb() to the xchg() and cmpxchg() implementations.

Reported-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-alpha@vger.kernel.org
Link: http://lkml.kernel.org/r/1519291488-5752-1-git-send-email-parri.andrea@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/alpha/include/asm/xchg.h | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/include/asm/xchg.h b/arch/alpha/include/asm/xchg.h
index e1facf6fc244..e2b59fac5257 100644
--- a/arch/alpha/include/asm/xchg.h
+++ b/arch/alpha/include/asm/xchg.h
@@ -12,6 +12,10 @@
  * Atomic exchange.
  * Since it can be used to implement critical sections
  * it must clobber "memory" (also for interrupts in UP).
+ *
+ * The leading and the trailing memory barriers guarantee that these
+ * operations are fully ordered.
+ *
  */
 
 static inline unsigned long
@@ -19,6 +23,7 @@ ____xchg(_u8, volatile char *m, unsigned long val)
 {
 	unsigned long ret, tmp, addr64;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"	andnot	%4,7,%3\n"
 	"	insbl	%1,%4,%1\n"
@@ -43,6 +48,7 @@ ____xchg(_u16, volatile short *m, unsigned long val)
 {
 	unsigned long ret, tmp, addr64;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"	andnot	%4,7,%3\n"
 	"	inswl	%1,%4,%1\n"
@@ -67,6 +73,7 @@ ____xchg(_u32, volatile int *m, unsigned long val)
 {
 	unsigned long dummy;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"1:	ldl_l %0,%4\n"
 	"	bis $31,%3,%1\n"
@@ -87,6 +94,7 @@ ____xchg(_u64, volatile long *m, unsigned long val)
 {
 	unsigned long dummy;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"1:	ldq_l %0,%4\n"
 	"	bis $31,%3,%1\n"
@@ -128,9 +136,12 @@ ____xchg(, volatile void *ptr, unsigned long x, int size)
  * store NEW in MEM.  Return the initial value in MEM.  Success is
  * indicated by comparing RETURN with OLD.
  *
- * The memory barrier is placed in SMP unconditionally, in order to
- * guarantee that dependency ordering is preserved when a dependency
- * is headed by an unsuccessful operation.
+ * The leading and the trailing memory barriers guarantee that these
+ * operations are fully ordered.
+ *
+ * The trailing memory barrier is placed in SMP unconditionally, in
+ * order to guarantee that dependency ordering is preserved when a
+ * dependency is headed by an unsuccessful operation.
  */
 
 static inline unsigned long
@@ -138,6 +149,7 @@ ____cmpxchg(_u8, volatile char *m, unsigned char old, unsigned char new)
 {
 	unsigned long prev, tmp, cmp, addr64;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"	andnot	%5,7,%4\n"
 	"	insbl	%1,%5,%1\n"
@@ -165,6 +177,7 @@ ____cmpxchg(_u16, volatile short *m, unsigned short old, unsigned short new)
 {
 	unsigned long prev, tmp, cmp, addr64;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"	andnot	%5,7,%4\n"
 	"	inswl	%1,%5,%1\n"
@@ -192,6 +205,7 @@ ____cmpxchg(_u32, volatile int *m, int old, int new)
 {
 	unsigned long prev, cmp;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"1:	ldl_l %0,%5\n"
 	"	cmpeq %0,%3,%1\n"
@@ -215,6 +229,7 @@ ____cmpxchg(_u64, volatile long *m, unsigned long old, unsigned long new)
 {
 	unsigned long prev, cmp;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"1:	ldq_l %0,%5\n"
 	"	cmpeq %0,%3,%1\n"
