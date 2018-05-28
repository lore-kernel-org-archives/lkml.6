Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031830AbeE1KSq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968814AbeE1KSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:18:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Turner <mattst88@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 103/268] locking/xchg/alpha: Fix xchg() and cmpxchg() memory ordering bugs
Date: Mon, 28 May 2018 12:01:17 +0200
Message-Id: <20180528100213.899241917@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrea Parri <parri.andrea@gmail.com>

[ Upstream commit 472e8c55cf6622d1c112dc2bc777f68bbd4189db ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/alpha/include/asm/xchg.h |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

--- a/arch/alpha/include/asm/xchg.h
+++ b/arch/alpha/include/asm/xchg.h
@@ -11,6 +11,10 @@
  * Atomic exchange.
  * Since it can be used to implement critical sections
  * it must clobber "memory" (also for interrupts in UP).
+ *
+ * The leading and the trailing memory barriers guarantee that these
+ * operations are fully ordered.
+ *
  */
 
 static inline unsigned long
@@ -18,6 +22,7 @@ ____xchg(_u8, volatile char *m, unsigned
 {
 	unsigned long ret, tmp, addr64;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"	andnot	%4,7,%3\n"
 	"	insbl	%1,%4,%1\n"
@@ -42,6 +47,7 @@ ____xchg(_u16, volatile short *m, unsign
 {
 	unsigned long ret, tmp, addr64;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"	andnot	%4,7,%3\n"
 	"	inswl	%1,%4,%1\n"
@@ -66,6 +72,7 @@ ____xchg(_u32, volatile int *m, unsigned
 {
 	unsigned long dummy;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"1:	ldl_l %0,%4\n"
 	"	bis $31,%3,%1\n"
@@ -86,6 +93,7 @@ ____xchg(_u64, volatile long *m, unsigne
 {
 	unsigned long dummy;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"1:	ldq_l %0,%4\n"
 	"	bis $31,%3,%1\n"
@@ -127,9 +135,12 @@ ____xchg(, volatile void *ptr, unsigned
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
@@ -137,6 +148,7 @@ ____cmpxchg(_u8, volatile char *m, unsig
 {
 	unsigned long prev, tmp, cmp, addr64;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"	andnot	%5,7,%4\n"
 	"	insbl	%1,%5,%1\n"
@@ -164,6 +176,7 @@ ____cmpxchg(_u16, volatile short *m, uns
 {
 	unsigned long prev, tmp, cmp, addr64;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"	andnot	%5,7,%4\n"
 	"	inswl	%1,%5,%1\n"
@@ -191,6 +204,7 @@ ____cmpxchg(_u32, volatile int *m, int o
 {
 	unsigned long prev, cmp;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"1:	ldl_l %0,%5\n"
 	"	cmpeq %0,%3,%1\n"
@@ -214,6 +228,7 @@ ____cmpxchg(_u64, volatile long *m, unsi
 {
 	unsigned long prev, cmp;
 
+	smp_mb();
 	__asm__ __volatile__(
 	"1:	ldq_l %0,%5\n"
 	"	cmpeq %0,%3,%1\n"
