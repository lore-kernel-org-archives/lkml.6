Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754620AbeDAUsO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:48:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754292AbeDAUl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:41:59 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 17/45] C++: Turn READ_ONCE(),
 WRITE_ONCE() & co. into inline template functions
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:41:57 +0100
Message-ID: <152261531782.30503.2451449805347145060.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn READ_ONCE(), WRITE_ONCE() and similar into inline template functions.
This allows the source to be simplified since there doesn't need to be
magic casting and switch-statements inside macroisation.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/compiler.h |   93 ++++++++++++++--------------------------------
 1 file changed, 29 insertions(+), 64 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index ab4711c63601..f9be82b93e20 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -3,6 +3,8 @@
 #define __LINUX_COMPILER_H
 
 #include <linux/compiler_types.h>
+#include <linux/kasan-checks.h>
+#include <asm/barrier.h>
 
 #ifndef __ASSEMBLY__
 
@@ -168,26 +170,6 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 
 #include <uapi/linux/types.h>
 
-#define __READ_ONCE_SIZE						\
-({									\
-	switch (size) {							\
-	case 1: *(__u8 *)res = *(volatile __u8 *)p; break;		\
-	case 2: *(__u16 *)res = *(volatile __u16 *)p; break;		\
-	case 4: *(__u32 *)res = *(volatile __u32 *)p; break;		\
-	case 8: *(__u64 *)res = *(volatile __u64 *)p; break;		\
-	default:							\
-		barrier();						\
-		__builtin_memcpy((void *)res, (const void *)p, size);	\
-		barrier();						\
-	}								\
-})
-
-static __always_inline
-void __read_once_size(const volatile void *p, void *res, int size)
-{
-	__READ_ONCE_SIZE;
-}
-
 #ifdef CONFIG_KASAN
 /*
  * We can't declare function 'inline' because __no_sanitize_address confilcts
@@ -200,26 +182,6 @@ void __read_once_size(const volatile void *p, void *res, int size)
 # define __no_kasan_or_inline __always_inline
 #endif
 
-static __no_kasan_or_inline
-void __read_once_size_nocheck(const volatile void *p, void *res, int size)
-{
-	__READ_ONCE_SIZE;
-}
-
-static __always_inline void __write_once_size(volatile void *p, void *res, int size)
-{
-	switch (size) {
-	case 1: *(volatile __u8 *)p = *(__u8 *)res; break;
-	case 2: *(volatile __u16 *)p = *(__u16 *)res; break;
-	case 4: *(volatile __u32 *)p = *(__u32 *)res; break;
-	case 8: *(volatile __u64 *)p = *(__u64 *)res; break;
-	default:
-		barrier();
-		__builtin_memcpy((void *)p, (const void *)res, size);
-		barrier();
-	}
-}
-
 /*
  * Prevent the compiler from merging or refetching reads or writes. The
  * compiler is also forbidden from reordering successive instances of
@@ -242,27 +204,30 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
  * with an explicit memory barrier or atomic instruction that provides the
  * required ordering.
  */
-#include <asm/barrier.h>
-#include <linux/kasan-checks.h>
+template <typename P>
+static inline P READ_ONCE(P &ptr)
+{
+	barrier();
+	P val = *(volatile P *)&ptr;
+	smp_read_barrier_depends(); /* Enforce dependency ordering from x */
+	return val;
+}
 
-#define __READ_ONCE(x, check)						\
-({									\
-	union { typeof(x) __val; char __c[1]; } __u;			\
-	if (check)							\
-		__read_once_size(&(x), __u.__c, sizeof(x));		\
-	else								\
-		__read_once_size_nocheck(&(x), __u.__c, sizeof(x));	\
-	smp_read_barrier_depends(); /* Enforce dependency ordering from x */ \
-	__u.__val;							\
-})
-#define READ_ONCE(x) __READ_ONCE(x, 1)
+template <typename P>
+static __no_kasan_or_inline P READ_ONCE_NOCHECK(P &ptr)
+{
+	barrier();
+	P val = *(volatile P *)&ptr;
+	smp_read_barrier_depends(); /* Enforce dependency ordering from x */
+	return val;
+}
 
 /*
- * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need
- * to hide memory access from KASAN.
+ * This function is not 'inline' because __no_sanitize_address confilcts
+ * with inlining. Attempt to inline it may cause a build failure.
+ * 	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
+ * '__maybe_unused' allows us to avoid defined-but-not-used warnings.
  */
-#define READ_ONCE_NOCHECK(x) __READ_ONCE(x, 0)
-
 static __no_kasan_or_inline
 unsigned long read_word_at_a_time(const void *addr)
 {
@@ -270,13 +235,13 @@ unsigned long read_word_at_a_time(const void *addr)
 	return *(unsigned long *)addr;
 }
 
-#define WRITE_ONCE(x, val) \
-({							\
-	union { typeof(x) __val; char __c[1]; } __u =	\
-		{ .__val = (__force typeof(x)) (val) }; \
-	__write_once_size(&(x), __u.__c, sizeof(x));	\
-	__u.__val;					\
-})
+template <typename P, typename T>
+static inline void WRITE_ONCE(P &ptr, T val)
+{
+	barrier();
+	*(volatile P *)&ptr = val;
+	barrier();
+}
 
 #endif /* __KERNEL__ */
 
