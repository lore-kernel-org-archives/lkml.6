Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754189AbeDAUlZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:41:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753951AbeDAUlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:41:23 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 11/45] C++: x86: Turn cmpxchg() & co. into inline template
 functions
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:41:21 +0100
Message-ID: <152261528152.30503.6660578276914715570.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn cmpxchg() and similar functions into inline C++ template functions.
This produces more robust source as the all the casting the C macros
require is then unnecessary.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/include/asm/atomic.h  |    2 
 arch/x86/include/asm/cmpxchg.h |  222 +++++++++++++---------------------------
 2 files changed, 75 insertions(+), 149 deletions(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 72759f131cc5..20f225cd47e8 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -190,7 +190,7 @@ static __always_inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 #define atomic_try_cmpxchg atomic_try_cmpxchg
 static __always_inline bool atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
-	return try_cmpxchg(&v->counter, old, new);
+	return try_cmpxchg(&v->counter, *old, new);
 }
 
 static inline int atomic_xchg(atomic_t *v, int new)
diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index 5e896c17476d..4bbf947c88a2 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -6,6 +6,12 @@
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h> /* Provides LOCK_PREFIX */
 
+enum cmpxchg_lock {
+	__lock_local,
+	__lock_smp,
+	__lock_always
+};
+
 /*
  * Non-existant functions to indicate usage errors at link time
  * (or compile-time if the compiler implements __compiletime_error().
@@ -20,22 +26,6 @@ extern void __add_wrong_size(void)
 	__compiletime_error("Bad argument size for add");
 
 /*
- * Constants for operation sizes. On 32-bit, the 64-bit size it set to
- * -1 because sizeof will never return -1, thereby making those switch
- * case statements guaranteeed dead code which the compiler will
- * eliminate, and allowing the "missing symbol in the default case" to
- * indicate a usage error.
- */
-#define __X86_CASE_B	1
-#define __X86_CASE_W	2
-#define __X86_CASE_L	4
-#ifdef CONFIG_64BIT
-#define __X86_CASE_Q	8
-#else
-#define	__X86_CASE_Q	-1		/* sizeof will never return -1 */
-#endif
-
-/* 
  * An exchange-type operation, which takes a value and a pointer, and
  * returns the old value.
  */
@@ -107,67 +97,82 @@ static inline P xadd(P *ptr, N inc)
 	return v;
 }
 
+/*
+ * Atomic compare and exchange.
+ */
+template <typename P, typename N>
+static inline bool try_cmpxchg(P *ptr, P &old, N _rep,
+			       enum cmpxchg_lock lock = __lock_smp)
+{
+	bool success;
+	P rep = _rep;
+
+	if (sizeof(P) > sizeof(unsigned long))
+		__cmpxchg_wrong_size();
+
+	switch (lock) {
+	case __lock_local:
+		asm volatile("cmpxchg %[rep], %[ptr]"
+			     CC_SET(z)
+			     : CC_OUT(z) (success),
+			       [ptr] "+m" (*ptr),
+			       [old] "+a" (old)
+			     : [rep] "q" (rep)
+			     : "memory");
+		break;
+	case __lock_smp:
+		asm volatile(LOCK_PREFIX "cmpxchg %[rep], %[ptr]"
+			     CC_SET(z)
+			     : CC_OUT(z) (success),
+			       [ptr] "+m" (*ptr),
+			       [old] "+a" (old)
+			     : [rep] "q" (rep)
+			     : "memory");
+		break;
+	case __lock_always:
+		asm volatile("lock; cmpxchg %[rep], %[ptr]"
+			     CC_SET(z)
+			     : CC_OUT(z) (success),
+			       [ptr] "+m" (*ptr),
+			       [old] "+a" (old)
+			     : [rep] "q" (rep)
+			     : "memory");
+		break;
+	}
+
+	return likely(success);
+}
+
+
 /*
  * Atomic compare and exchange.  Compare OLD with MEM, if identical,
  * store NEW in MEM.  Return the initial value in MEM.  Success is
  * indicated by comparing RETURN with OLD.
  */
-#define __raw_cmpxchg(ptr, old, new, size, lock)			\
-({									\
-	__typeof__(*(ptr)) __ret;					\
-	__typeof__(*(ptr)) __old = (old);				\
-	__typeof__(*(ptr)) __new = (new);				\
-	switch (size) {							\
-	case __X86_CASE_B:						\
-	{								\
-		volatile u8 *__ptr = (volatile u8 *)(ptr);		\
-		asm volatile(lock "cmpxchgb %2,%1"			\
-			     : "=a" (__ret), "+m" (*__ptr)		\
-			     : "q" (__new), "0" (__old)			\
-			     : "memory");				\
-		break;							\
-	}								\
-	case __X86_CASE_W:						\
-	{								\
-		volatile u16 *__ptr = (volatile u16 *)(ptr);		\
-		asm volatile(lock "cmpxchgw %2,%1"			\
-			     : "=a" (__ret), "+m" (*__ptr)		\
-			     : "r" (__new), "0" (__old)			\
-			     : "memory");				\
-		break;							\
-	}								\
-	case __X86_CASE_L:						\
-	{								\
-		volatile u32 *__ptr = (volatile u32 *)(ptr);		\
-		asm volatile(lock "cmpxchgl %2,%1"			\
-			     : "=a" (__ret), "+m" (*__ptr)		\
-			     : "r" (__new), "0" (__old)			\
-			     : "memory");				\
-		break;							\
-	}								\
-	case __X86_CASE_Q:						\
-	{								\
-		volatile u64 *__ptr = (volatile u64 *)(ptr);		\
-		asm volatile(lock "cmpxchgq %2,%1"			\
-			     : "=a" (__ret), "+m" (*__ptr)		\
-			     : "r" (__new), "0" (__old)			\
-			     : "memory");				\
-		break;							\
-	}								\
-	default:							\
-		__cmpxchg_wrong_size();					\
-	}								\
-	__ret;								\
-})
 
-#define __cmpxchg(ptr, old, new, size)					\
-	__raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)
+template <typename P, typename N>
+static inline P cmpxchg_local(P *ptr, P old, N rep)
+{
+	P ret = old;
+	try_cmpxchg(ptr, ret, rep, __lock_local);
+	return ret;
+}
 
-#define __sync_cmpxchg(ptr, old, new, size)				\
-	__raw_cmpxchg((ptr), (old), (new), (size), "lock; ")
+template <typename P, typename N>
+static inline P cmpxchg(P *ptr, P old, N rep)
+{
+	P ret = old;
+	try_cmpxchg(ptr, ret, rep, __lock_smp);
+	return ret;
+}
 
-#define __cmpxchg_local(ptr, old, new, size)				\
-	__raw_cmpxchg((ptr), (old), (new), (size), "")
+template <typename P, typename N>
+static inline P sync_cmpxchg(P *ptr, P old, N rep)
+{
+	P ret = old;
+	try_cmpxchg(ptr, ret, rep, __lock_always);
+	return ret;
+}
 
 #ifdef CONFIG_X86_32
 # include <asm/cmpxchg_32.h>
@@ -175,85 +180,6 @@ static inline P xadd(P *ptr, N inc)
 # include <asm/cmpxchg_64.h>
 #endif
 
-#define cmpxchg(ptr, old, new)						\
-	__cmpxchg(ptr, old, new, sizeof(*(ptr)))
-
-#define sync_cmpxchg(ptr, old, new)					\
-	__sync_cmpxchg(ptr, old, new, sizeof(*(ptr)))
-
-#define cmpxchg_local(ptr, old, new)					\
-	__cmpxchg_local(ptr, old, new, sizeof(*(ptr)))
-
-
-#define __raw_try_cmpxchg(_ptr, _pold, _new, size, lock)		\
-({									\
-	bool success;							\
-	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
-	__typeof__(*(_ptr)) __old = *_old;				\
-	__typeof__(*(_ptr)) __new = (_new);				\
-	switch (size) {							\
-	case __X86_CASE_B:						\
-	{								\
-		volatile u8 *__ptr = (volatile u8 *)(_ptr);		\
-		asm volatile(lock "cmpxchgb %[new], %[ptr]"		\
-			     CC_SET(z)					\
-			     : CC_OUT(z) (success),			\
-			       [ptr] "+m" (*__ptr),			\
-			       [old] "+a" (__old)			\
-			     : [new] "q" (__new)			\
-			     : "memory");				\
-		break;							\
-	}								\
-	case __X86_CASE_W:						\
-	{								\
-		volatile u16 *__ptr = (volatile u16 *)(_ptr);		\
-		asm volatile(lock "cmpxchgw %[new], %[ptr]"		\
-			     CC_SET(z)					\
-			     : CC_OUT(z) (success),			\
-			       [ptr] "+m" (*__ptr),			\
-			       [old] "+a" (__old)			\
-			     : [new] "r" (__new)			\
-			     : "memory");				\
-		break;							\
-	}								\
-	case __X86_CASE_L:						\
-	{								\
-		volatile u32 *__ptr = (volatile u32 *)(_ptr);		\
-		asm volatile(lock "cmpxchgl %[new], %[ptr]"		\
-			     CC_SET(z)					\
-			     : CC_OUT(z) (success),			\
-			       [ptr] "+m" (*__ptr),			\
-			       [old] "+a" (__old)			\
-			     : [new] "r" (__new)			\
-			     : "memory");				\
-		break;							\
-	}								\
-	case __X86_CASE_Q:						\
-	{								\
-		volatile u64 *__ptr = (volatile u64 *)(_ptr);		\
-		asm volatile(lock "cmpxchgq %[new], %[ptr]"		\
-			     CC_SET(z)					\
-			     : CC_OUT(z) (success),			\
-			       [ptr] "+m" (*__ptr),			\
-			       [old] "+a" (__old)			\
-			     : [new] "r" (__new)			\
-			     : "memory");				\
-		break;							\
-	}								\
-	default:							\
-		__cmpxchg_wrong_size();					\
-	}								\
-	if (unlikely(!success))						\
-		*_old = __old;						\
-	likely(success);						\
-})
-
-#define __try_cmpxchg(ptr, pold, new, size)				\
-	__raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
-
-#define try_cmpxchg(ptr, pold, new)					\
-	__try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
-
 #define __cmpxchg_double(pfx, p1, p2, o1, o2, n1, n2)			\
 ({									\
 	bool __ret;							\
