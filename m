Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754169AbeDAUlS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:41:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753951AbeDAUlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:41:16 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/45] C++: x86: Turn xchg(),
 xadd() & co. into inline template functions
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:41:15 +0100
Message-ID: <152261527543.30503.554397458877242700.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn xchg(), xadd() and similar functions into inline C++ template
functions.  This produces more robust source as the all the casting the C
macros require is then unnecessary.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/include/asm/cmpxchg.h |  109 ++++++++++++++++++++++++----------------
 1 file changed, 65 insertions(+), 44 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index 56bd436ed01b..5e896c17476d 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 -*- c++ -*- */
 #ifndef ASM_X86_CMPXCHG_H
 #define ASM_X86_CMPXCHG_H
 
@@ -39,43 +39,73 @@ extern void __add_wrong_size(void)
  * An exchange-type operation, which takes a value and a pointer, and
  * returns the old value.
  */
-#define __xchg_op(ptr, arg, op, lock)					\
-	({								\
-	        __typeof__ (*(ptr)) __ret = (arg);			\
-		switch (sizeof(*(ptr))) {				\
-		case __X86_CASE_B:					\
-			asm volatile (lock #op "b %b0, %1\n"		\
-				      : "+q" (__ret), "+m" (*(ptr))	\
-				      : : "memory", "cc");		\
-			break;						\
-		case __X86_CASE_W:					\
-			asm volatile (lock #op "w %w0, %1\n"		\
-				      : "+r" (__ret), "+m" (*(ptr))	\
-				      : : "memory", "cc");		\
-			break;						\
-		case __X86_CASE_L:					\
-			asm volatile (lock #op "l %0, %1\n"		\
-				      : "+r" (__ret), "+m" (*(ptr))	\
-				      : : "memory", "cc");		\
-			break;						\
-		case __X86_CASE_Q:					\
-			asm volatile (lock #op "q %q0, %1\n"		\
-				      : "+r" (__ret), "+m" (*(ptr))	\
-				      : : "memory", "cc");		\
-			break;						\
-		default:						\
-			__ ## op ## _wrong_size();			\
-		}							\
-		__ret;							\
-	})
+template <typename P, typename N>
+static inline P xchg(P *ptr, N rep)
+{
+	P v = rep;
+
+	if (sizeof(P) > sizeof(unsigned long))
+		__xchg_wrong_size();
+
+	/* Note: no "lock" prefix even on SMP: xchg always implies lock anyway.
+	 * Since this is generally used to protect other memory information, we
+	 * use "asm volatile" and "memory" clobbers to prevent gcc from moving
+	 * information around.
+	 */
+	asm volatile("xchg %[v], %[ptr]"
+		     : [ptr] "+m" (*ptr),
+		       [v]   "+a" (v)
+		     :
+		     : "memory");
+
+	return v;
+}
 
 /*
- * Note: no "lock" prefix even on SMP: xchg always implies lock anyway.
- * Since this is generally used to protect other memory information, we
- * use "asm volatile" and "memory" clobbers to prevent gcc from moving
- * information around.
+ * __xadd() adds "inc" to "*ptr" and atomically returns the previous
+ * value of "*ptr".
+ *
+ * __xadd() is always locked.
  */
-#define xchg(ptr, v)	__xchg_op((ptr), (v), xchg, "")
+template <typename P, typename N>
+static inline P __xadd(P *ptr, N inc)
+{
+	P v = inc;
+
+	if (sizeof(P) > sizeof(unsigned long))
+		__xadd_wrong_size();
+
+	asm volatile("lock; xadd %[v], %[ptr]"
+		     : [ptr] "+m" (*ptr),
+		       [v]   "+a" (v)
+		     :
+		     : "memory");
+
+	return v;
+}
+
+/*
+ * xadd() adds "inc" to "*ptr" and atomically returns the previous
+ * value of "*ptr".
+ *
+ * xadd() is locked when multiple CPUs are online
+ */
+template <typename P, typename N>
+static inline P xadd(P *ptr, N inc)
+{
+	P v = inc;
+
+	if (sizeof(P) > sizeof(unsigned long))
+		__xadd_wrong_size();
+
+	asm volatile(LOCK_PREFIX "xadd %[v], %[ptr]"
+		     : [ptr] "+m" (*ptr),
+		       [v]   "+a" (v)
+		     :
+		     : "memory");
+
+	return v;
+}
 
 /*
  * Atomic compare and exchange.  Compare OLD with MEM, if identical,
@@ -224,15 +254,6 @@ extern void __add_wrong_size(void)
 #define try_cmpxchg(ptr, pold, new)					\
 	__try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
 
-/*
- * xadd() adds "inc" to "*ptr" and atomically returns the previous
- * value of "*ptr".
- *
- * xadd() is locked when multiple CPUs are online
- */
-#define __xadd(ptr, inc, lock)	__xchg_op((ptr), (inc), xadd, lock)
-#define xadd(ptr, inc)		__xadd((ptr), (inc), LOCK_PREFIX)
-
 #define __cmpxchg_double(pfx, p1, p2, o1, o2, n1, n2)			\
 ({									\
 	bool __ret;							\
