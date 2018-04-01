Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754244AbeDAUlo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:41:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753951AbeDAUll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:41:41 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 14/45] C++: x86: Turn put_user(),
 get_user() & co. into inline template functions
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:41:39 +0100
Message-ID: <152261529959.30503.12922752484575508631.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn put_user(), get_user() and similar functions into C++ inline template
functions as the source for this is simpler and more obvious and not
heavily macroised.

Note that it is unnecessary to stick an extension on the load or store
instruction that does the protected access to memory as the assembler can
work that out from the size of the source/destination register.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/include/asm/uaccess.h    |  630 ++++++++++++++++++++-----------------
 arch/x86/include/asm/uaccess_64.h |   66 +---
 2 files changed, 361 insertions(+), 335 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index aae77eb8491c..64bd782c87c6 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -12,6 +12,10 @@
 #include <asm/smap.h>
 #include <asm/extable.h>
 
+/* FIXME: this hack is definitely wrong -AK */
+struct __large_struct { unsigned long buf[100]; };
+#define __m(x) (*(struct __large_struct __user *)(x))
+
 /*
  * The fs value determines whether argument validity checking should be
  * performed or not.  If get_fs() == USER_DS, checking is performed, with
@@ -101,6 +105,12 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
 	likely(!__range_not_ok(addr, size, user_addr_max()));		\
 })
 
+extern void __put_user_bad(void);
+extern void __get_user_unsupported_size(void)
+	__compiletime_error("Bad argument size for get_user");
+extern void __put_user_unsupported_size(void)
+	__compiletime_error("Bad argument size for put_user");
+
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
@@ -130,13 +140,6 @@ extern int __get_user_bad(void);
 	barrier_nospec();		\
 })
 
-/*
- * This is a type: either unsigned long, if the argument fits into
- * that type, or otherwise unsigned long long.
- */
-#define __inttype(x) \
-__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
-
 /**
  * get_user: - Get a simple variable from user space.
  * @x:   Variable to store result.
@@ -168,62 +171,21 @@ __typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
  * Clang/LLVM cares about the size of the register, but still wants
  * the base register for something that ends up being a pair.
  */
-#define get_user(x, ptr)						\
-({									\
-	int __ret_gu;							\
-	register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);		\
-	__chk_user_ptr(ptr);						\
-	might_fault();							\
-	asm volatile("call __get_user_%P4"				\
-		     : "=a" (__ret_gu), "=r" (__val_gu),		\
-			ASM_CALL_CONSTRAINT				\
-		     : "0" (ptr), "i" (sizeof(*(ptr))));		\
-	(x) = (__force __typeof__(*(ptr))) __val_gu;			\
-	__builtin_expect(__ret_gu, 0);					\
-})
-
-#define __put_user_x(size, x, ptr, __ret_pu)			\
-	asm volatile("call __put_user_" #size : "=a" (__ret_pu)	\
-		     : "0" ((typeof(*(ptr)))(x)), "c" (ptr) : "ebx")
-
-
-
-#ifdef CONFIG_X86_32
-#define __put_user_asm_u64(x, addr, err, errret)			\
-	asm volatile("\n"						\
-		     "1:	movl %%eax,0(%2)\n"			\
-		     "2:	movl %%edx,4(%2)\n"			\
-		     "3:"						\
-		     ".section .fixup,\"ax\"\n"				\
-		     "4:	movl %3,%0\n"				\
-		     "	jmp 3b\n"					\
-		     ".previous\n"					\
-		     _ASM_EXTABLE(1b, 4b)				\
-		     _ASM_EXTABLE(2b, 4b)				\
-		     : "=r" (err)					\
-		     : "A" (x), "r" (addr), "i" (errret), "0" (err))
-
-#define __put_user_asm_ex_u64(x, addr)					\
-	asm volatile("\n"						\
-		     "1:	movl %%eax,0(%1)\n"			\
-		     "2:	movl %%edx,4(%1)\n"			\
-		     "3:"						\
-		     _ASM_EXTABLE_EX(1b, 2b)				\
-		     _ASM_EXTABLE_EX(2b, 3b)				\
-		     : : "A" (x), "r" (addr))
-
-#define __put_user_x8(x, ptr, __ret_pu)				\
-	asm volatile("call __put_user_8" : "=a" (__ret_pu)	\
-		     : "A" ((typeof(*(ptr)))(x)), "c" (ptr) : "ebx")
-#else
-#define __put_user_asm_u64(x, ptr, retval, errret) \
-	__put_user_asm(x, ptr, retval, "q", "", "er", errret)
-#define __put_user_asm_ex_u64(x, addr)	\
-	__put_user_asm_ex(x, addr, "q", "", "er")
-#define __put_user_x8(x, ptr, __ret_pu) __put_user_x(8, x, ptr, __ret_pu)
-#endif
-
-extern void __put_user_bad(void);
+template <typename VAL, typename TYPE>
+static inline int get_user(VAL &x, TYPE *ptr)
+{
+	register TYPE val asm("%" _ASM_DX);
+	int ret;
+
+	__chk_user_ptr(ptr);
+	might_fault();
+	asm volatile("call __get_user_%P4"
+		     : "=a" (ret), "=r" (val),
+			ASM_CALL_CONSTRAINT
+		     : "0" (ptr), "i" (sizeof(*(ptr))));
+	x = val;
+	return __builtin_expect(ret, 0);
+}
 
 /*
  * Strange magic calling convention: pointer in %ecx,
@@ -251,157 +213,47 @@ extern void __put_user_8(void);
  *
  * Returns zero on success, or -EFAULT on error.
  */
-#define put_user(x, ptr)					\
-({								\
-	int __ret_pu;						\
-	__typeof__(*(ptr)) __pu_val;				\
-	__chk_user_ptr(ptr);					\
-	might_fault();						\
-	__pu_val = x;						\
-	switch (sizeof(*(ptr))) {				\
-	case 1:							\
-		__put_user_x(1, __pu_val, ptr, __ret_pu);	\
-		break;						\
-	case 2:							\
-		__put_user_x(2, __pu_val, ptr, __ret_pu);	\
-		break;						\
-	case 4:							\
-		__put_user_x(4, __pu_val, ptr, __ret_pu);	\
-		break;						\
-	case 8:							\
-		__put_user_x8(__pu_val, ptr, __ret_pu);		\
-		break;						\
-	default:						\
-		__put_user_x(X, __pu_val, ptr, __ret_pu);	\
-		break;						\
-	}							\
-	__builtin_expect(__ret_pu, 0);				\
-})
-
-#define __put_user_size(x, ptr, size, retval, errret)			\
-do {									\
-	retval = 0;							\
-	__chk_user_ptr(ptr);						\
-	switch (size) {							\
-	case 1:								\
-		__put_user_asm(x, ptr, retval, "b", "b", "iq", errret);	\
-		break;							\
-	case 2:								\
-		__put_user_asm(x, ptr, retval, "w", "w", "ir", errret);	\
-		break;							\
-	case 4:								\
-		__put_user_asm(x, ptr, retval, "l", "k", "ir", errret);	\
-		break;							\
-	case 8:								\
-		__put_user_asm_u64((__typeof__(*ptr))(x), ptr, retval,	\
-				   errret);				\
-		break;							\
-	default:							\
-		__put_user_bad();					\
-	}								\
-} while (0)
-
-/*
- * This doesn't do __uaccess_begin/end - the exception handling
- * around it must do that.
- */
-#define __put_user_size_ex(x, ptr, size)				\
-do {									\
-	__chk_user_ptr(ptr);						\
-	switch (size) {							\
-	case 1:								\
-		__put_user_asm_ex(x, ptr, "b", "b", "iq");		\
-		break;							\
-	case 2:								\
-		__put_user_asm_ex(x, ptr, "w", "w", "ir");		\
-		break;							\
-	case 4:								\
-		__put_user_asm_ex(x, ptr, "l", "k", "ir");		\
-		break;							\
-	case 8:								\
-		__put_user_asm_ex_u64((__typeof__(*ptr))(x), ptr);	\
-		break;							\
-	default:							\
-		__put_user_bad();					\
-	}								\
-} while (0)
+template <typename VAL, typename TYPE>
+static inline int put_user(VAL x, TYPE *ptr)
+{
+	register TYPE val asm("%" _ASM_DX);
+	int ret;
 
+	__chk_user_ptr(ptr);
+	might_fault();
+	switch (sizeof(*(ptr))) {
+	case 8:
 #ifdef CONFIG_X86_32
-#define __get_user_asm_u64(x, ptr, retval, errret)			\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	asm volatile("\n"					\
-		     "1:	movl %2,%%eax\n"			\
-		     "2:	movl %3,%%edx\n"			\
-		     "3:\n"				\
-		     ".section .fixup,\"ax\"\n"				\
-		     "4:	mov %4,%0\n"				\
-		     "	xorl %%eax,%%eax\n"				\
-		     "	xorl %%edx,%%edx\n"				\
-		     "	jmp 3b\n"					\
-		     ".previous\n"					\
-		     _ASM_EXTABLE(1b, 4b)				\
-		     _ASM_EXTABLE(2b, 4b)				\
-		     : "=r" (retval), "=&A"(x)				\
-		     : "m" (__m(__ptr)), "m" __m(((u32 __user *)(__ptr)) + 1),	\
-		       "i" (errret), "0" (retval));			\
-})
+		asm volatile("call __put_user_%8"
+			     : "=a" (ret), "=r" (val),
+			       ASM_CALL_CONSTRAINT
+			     : "A" (val), "c" (ptr)
+			     : "ebx");
+		break;
+#endif
+		/* Fall through */
+	case 1:
+	case 2:
+	case 4:
+		asm volatile("call __put_user_%P4"
+			     : "=a" (ret), "=r" (val),
+			       ASM_CALL_CONSTRAINT
+			     : "0" (val), "c" (ptr)
+			     : "ebx");
+		break;
+	default:
+		__put_user_unsupported_size();
+	}
+	return __builtin_expect(ret, 0);
+}
 
+#ifdef CONFIG_X86_32
 #define __get_user_asm_ex_u64(x, ptr)			(x) = __get_user_bad()
 #else
-#define __get_user_asm_u64(x, ptr, retval, errret) \
-	 __get_user_asm(x, ptr, retval, "q", "", "=r", errret)
 #define __get_user_asm_ex_u64(x, ptr) \
 	 __get_user_asm_ex(x, ptr, "q", "", "=r")
 #endif
 
-#define __get_user_size(x, ptr, size, retval, errret)			\
-do {									\
-	retval = 0;							\
-	__chk_user_ptr(ptr);						\
-	switch (size) {							\
-	case 1:								\
-		__get_user_asm(x, ptr, retval, "b", "b", "=q", errret);	\
-		break;							\
-	case 2:								\
-		__get_user_asm(x, ptr, retval, "w", "w", "=r", errret);	\
-		break;							\
-	case 4:								\
-		__get_user_asm(x, ptr, retval, "l", "k", "=r", errret);	\
-		break;							\
-	case 8:								\
-		__get_user_asm_u64(x, ptr, retval, errret);		\
-		break;							\
-	default:							\
-		(x) = __get_user_bad();					\
-	}								\
-} while (0)
-
-#define __get_user_asm(x, addr, err, itype, rtype, ltype, errret)	\
-	asm volatile("\n"						\
-		     "1:	mov"itype" %2,%"rtype"1\n"		\
-		     "2:\n"						\
-		     ".section .fixup,\"ax\"\n"				\
-		     "3:	mov %3,%0\n"				\
-		     "	xor"itype" %"rtype"1,%"rtype"1\n"		\
-		     "	jmp 2b\n"					\
-		     ".previous\n"					\
-		     _ASM_EXTABLE(1b, 3b)				\
-		     : "=r" (err), ltype(x)				\
-		     : "m" (__m(addr)), "i" (errret), "0" (err))
-
-#define __get_user_asm_nozero(x, addr, err, itype, rtype, ltype, errret)	\
-	asm volatile("\n"						\
-		     "1:	mov"itype" %2,%"rtype"1\n"		\
-		     "2:\n"						\
-		     ".section .fixup,\"ax\"\n"				\
-		     "3:	mov %3,%0\n"				\
-		     "	jmp 2b\n"					\
-		     ".previous\n"					\
-		     _ASM_EXTABLE(1b, 3b)				\
-		     : "=r" (err), ltype(x)				\
-		     : "m" (__m(addr)), "i" (errret), "0" (err))
-
 /*
  * This doesn't do __uaccess_begin/end - the exception handling
  * around it must do that.
@@ -437,53 +289,6 @@ do {									\
 		     _ASM_EXTABLE_EX(1b, 3b)				\
 		     : ltype(x) : "m" (__m(addr)))
 
-#define __put_user_nocheck(x, ptr, size)			\
-({								\
-	int __pu_err;						\
-	__uaccess_begin();					\
-	__put_user_size((x), (ptr), (size), __pu_err, -EFAULT);	\
-	__uaccess_end();					\
-	__builtin_expect(__pu_err, 0);				\
-})
-
-#define __get_user_nocheck(x, ptr, size)				\
-({									\
-	int __gu_err;							\
-	__inttype(*(ptr)) __gu_val;					\
-	__uaccess_begin_nospec();					\
-	__get_user_size(__gu_val, (ptr), (size), __gu_err, -EFAULT);	\
-	__uaccess_end();						\
-	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
-	__builtin_expect(__gu_err, 0);					\
-})
-
-/* FIXME: this hack is definitely wrong -AK */
-struct __large_struct { unsigned long buf[100]; };
-#define __m(x) (*(struct __large_struct __user *)(x))
-
-/*
- * Tell gcc we read from memory instead of writing: this is because
- * we do not write to any memory gcc knows about, so there are no
- * aliasing issues.
- */
-#define __put_user_asm(x, addr, err, itype, rtype, ltype, errret)	\
-	asm volatile("\n"						\
-		     "1:	mov"itype" %"rtype"1,%2\n"		\
-		     "2:\n"						\
-		     ".section .fixup,\"ax\"\n"				\
-		     "3:	mov %3,%0\n"				\
-		     "	jmp 2b\n"					\
-		     ".previous\n"					\
-		     _ASM_EXTABLE(1b, 3b)				\
-		     : "=r"(err)					\
-		     : ltype(x), "m" (__m(addr)), "i" (errret), "0" (err))
-
-#define __put_user_asm_ex(x, addr, itype, rtype, ltype)			\
-	asm volatile("1:	mov"itype" %"rtype"0,%1\n"		\
-		     "2:\n"						\
-		     _ASM_EXTABLE_EX(1b, 2b)				\
-		     : : ltype(x), "m" (__m(addr)))
-
 /*
  * uaccess_try and catch
  */
@@ -501,6 +306,111 @@ struct __large_struct { unsigned long buf[100]; };
 	(err) |= (current->thread.uaccess_err ? -EFAULT : 0);		\
 } while (0)
 
+/**
+ * __get_user_unsafe_nozero - Read a value from userspace with no uaccess check
+ */
+template <typename VAL, typename TYPE>
+static inline int __get_user_unsafe_nozero(VAL &x, const TYPE *ptr, int err=-EFAULT)
+{
+	TYPE val;
+	int ret = 0;
+
+	__chk_user_ptr(ptr);
+	switch (sizeof(TYPE)) {
+	case 8:
+#if __LONG_WIDTH__ == 32
+		asm volatile("\n"
+			     "1:	mov %2,%%eax\n"
+			     "2:	mov %3,%%edx\n"
+			     "3:\n"
+			     ".section .fixup,\"ax\"\n"
+			     "4:	mov %4,%0\n"
+			     "		jmp 3b\n"
+			     ".previous\n"
+			     _ASM_EXTABLE(1b, 4b)
+			     _ASM_EXTABLE(2b, 4b)
+			     : "=r" (ret), "=&A"(val)
+			     : "m" (__m(ptr)),
+			       "m" (__m((const char *)ptr + 4)),
+			       "i" (err), "0" (ret));
+		break;
+#endif
+	case 1:
+	case 2:
+	case 4:
+		asm volatile("\n"
+			     "1:	mov %2,%1\n"
+			     "2:\n"
+			     ".section .fixup,\"ax\"\n"
+			     "3:	mov %3,%0\n"
+			     "		jmp 2b\n"
+			     ".previous\n"
+			     _ASM_EXTABLE(1b, 3b)
+			     : "=r" (ret), "=r"(val)
+			     : "m" (__m(ptr)), "i" (err), "0" (ret));
+		break;
+	default:
+		__get_user_unsupported_size();
+	}
+
+	x = val;
+	return __builtin_expect(ret, 0);
+}
+
+/**
+ * __get_user_unsafe - Read a value from userspace with no uaccess check
+ */
+template <typename VAL, typename TYPE>
+static inline int __get_user_unsafe(VAL &x, const TYPE *ptr, int err=-EFAULT)
+{
+	TYPE val;
+	int ret = 0;
+
+	__chk_user_ptr(ptr);
+	switch (sizeof(TYPE)) {
+	case 8:
+#if __LONG_WIDTH__ == 32
+		asm volatile("\n"
+			     "1:	mov %2,%%eax\n"
+			     "2:	mov %3,%%edx\n"
+			     "3:\n"
+			     ".section .fixup,\"ax\"\n"
+			     "4:	mov %4,%0\n"
+			     "		xor %%eax,%%eax\n"
+			     "		xor %%edx,%%edx\n"
+			     "		jmp 3b\n"
+			     ".previous\n"
+			     _ASM_EXTABLE(1b, 4b)
+			     _ASM_EXTABLE(2b, 4b)
+			     : "=r" (ret), "=&A"(val)
+			     : "m" (__m(ptr)),
+			       "m" (__m((const char *)ptr + 4)),
+			       "i" (err), "0" (ret));
+		break;
+#endif
+	case 1:
+	case 2:
+	case 4:
+		asm volatile("\n"
+			     "1:	mov %2,%1\n"
+			     "2:\n"
+			     ".section .fixup,\"ax\"\n"
+			     "3:	mov %3,%0\n"
+			     "		xor %1,%1\n"
+			     "		jmp 2b\n"
+			     ".previous\n"
+			     _ASM_EXTABLE(1b, 3b)
+			     : "=r" (ret), "=r"(val)
+			     : "m" (__m(ptr)), "i" (err), "0" (ret));
+		break;
+	default:
+		__get_user_unsupported_size();
+	}
+
+	x = val;
+	return __builtin_expect(ret, 0);
+}
+
 /**
  * __get_user: - Get a simple variable from user space, with less checking.
  * @x:   Variable to store result.
@@ -509,9 +419,9 @@ struct __large_struct { unsigned long buf[100]; };
  * Context: User context only. This function may sleep if pagefaults are
  *          enabled.
  *
- * This macro copies a single simple variable from user space to kernel
- * space.  It supports simple types like char and int, but not larger
- * data types like structures or arrays.
+ * This function copies a single simple variable from user space to kernel
+ * space.  It supports simple types like char and int, but not larger data
+ * types like structures or arrays.
  *
  * @ptr must have pointer-to-simple-variable type, and the result of
  * dereferencing @ptr must be assignable to @x without a cast.
@@ -522,9 +432,68 @@ struct __large_struct { unsigned long buf[100]; };
  * Returns zero on success, or -EFAULT on error.
  * On error, the variable @x is set to zero.
  */
+template <typename VAL, typename TYPE>
+static inline int __get_user(VAL &x, const TYPE *ptr)
+{
+	int ret;
 
-#define __get_user(x, ptr)						\
-	__get_user_nocheck((x), (ptr), sizeof(*(ptr)))
+	__uaccess_begin_nospec();
+	ret = __get_user_unsafe(x, ptr);
+	__uaccess_end();
+	return ret;
+}
+
+/**
+ * __put_user_unsafe - Copy a value to userspace with no uaccess check
+ */
+template <typename VAL, typename TYPE>
+static inline int __put_user_unsafe(VAL x, TYPE *ptr, int err=-EFAULT)
+{
+	TYPE val;
+	int ret = 0;
+
+	__chk_user_ptr(ptr);
+	switch (sizeof(TYPE)) {
+	case 8:
+#if __LONG_WIDTH__ == 32
+		asm volatile("\n"
+			     "1:	mov %%eax,%2\n"
+			     "2:	mov %%edx,%3\n"
+			     "3:\n"
+			     ".section .fixup,\"ax\"\n"
+			     "4:	mov %4,%0\n"
+			     "		jmp 3b\n"
+			     ".previous\n"
+			     _ASM_EXTABLE(1b, 4b)
+			     _ASM_EXTABLE(2b, 4b)
+			     : "=r" (ret)
+			     : "A"(val),
+			       "m" (__m(ptr)),
+			       "m" (__m((const char *)ptr + 4)),
+			       "i" (err), "0" (ret));
+		break;
+#endif
+	case 1:
+	case 2:
+	case 4:
+		asm volatile("\n"
+			     "1:	mov %1,%2\n"
+			     "2:\n"
+			     ".section .fixup,\"ax\"\n"
+			     "3:	mov %3,%0\n"
+			     "		jmp 2b\n"
+			     ".previous\n"
+			     _ASM_EXTABLE(1b, 3b)
+			     : "=r" (ret), "=r"(val)
+			     : "m" (__m(ptr)), "i" (err), "0" (ret));
+		break;
+	default:
+		__put_user_unsupported_size();
+	}
+
+	x = val;
+	return __builtin_expect(ret, 0);
+}
 
 /**
  * __put_user: - Write a simple value into user space, with less checking.
@@ -546,32 +515,117 @@ struct __large_struct { unsigned long buf[100]; };
  *
  * Returns zero on success, or -EFAULT on error.
  */
+template <typename VAL, typename TYPE>
+static inline int __put_user(VAL x, TYPE *ptr, int err=-EFAULT)
+{
+	int ret;
 
-#define __put_user(x, ptr)						\
-	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
+	__uaccess_begin();
+	ret = __put_user_unsafe(x, ptr, err);
+	__uaccess_end();
+	return ret;
+}
 
-/*
- * {get|put}_user_try and catch
+/**
+ * get_user_ex - Read a value from userspace with indirect error
  *
- * get_user_try {
- *	get_user_ex(...);
- * } get_user_catch(err)
+ * Use as:
+ *	get_user_try {
+ *		get_user_ex(...);
+ *	} get_user_catch(err)
  */
+template <typename VAL, typename TYPE>
+static inline void get_user_ex(VAL &x, const TYPE *ptr)
+{
+	TYPE val;
+
+	__chk_user_ptr(ptr);
+	switch (sizeof(TYPE)) {
+	case 8:
+#if __LONG_WIDTH__ == 32
+		asm volatile("\n"
+			     "1:	mov %1,%%eax\n"
+			     "2:	mov %2,%%edx\n"
+			     "3:\n"
+			     _ASM_EXTABLE(1b, 3b)
+			     _ASM_EXTABLE(2b, 3b)
+			     : "=&A"(val)
+			     : "m" (__m(ptr)),
+			       "m" (__m((const char *)ptr + 4)));
+		break;
+#endif
+	case 1:
+	case 2:
+	case 4:
+		asm volatile("\n"
+			     "1:	mov %1,%0\n"
+			     "2:\n"
+			     _ASM_EXTABLE(1b, 2b)
+			     : "=r"(val)
+			     : "m" (__m(ptr)));
+		break;
+	default:
+		__get_user_unsupported_size();
+	}
+
+	x = val;
+}
 #define get_user_try		uaccess_try_nospec
 #define get_user_catch(err)	uaccess_catch(err)
 
-#define get_user_ex(x, ptr)	do {					\
-	unsigned long __gue_val;					\
-	__get_user_size_ex((__gue_val), (ptr), (sizeof(*(ptr))));	\
-	(x) = (__force __typeof__(*(ptr)))__gue_val;			\
-} while (0)
+/**
+ * put_user_ex - Copy a value to userspace with indirect error
+ *
+ * Use as:
+ *	put_user_try {
+ *		put_user_ex(...);
+ *	} put_user_catch(err)
+ */
+template <typename VAL, typename TYPE>
+static inline void put_user_ex(VAL x, TYPE *ptr)
+{
+	TYPE val;
+
+
+	/* We tell gcc that we're reading from memory instead of writing: this
+	 * is because we do not write to any memory gcc knows about, so there
+	 * are no aliasing issues.
+	 */
+	__chk_user_ptr(ptr);
+	switch (sizeof(TYPE)) {
+	case 8:
+#if __LONG_WIDTH__ == 32
+		asm volatile("\n"
+			     "1:	mov %%eax,%1\n"
+			     "2:	mov %%edx,%2\n"
+			     "3:\n"
+			     _ASM_EXTABLE(1b, 3b)
+			     _ASM_EXTABLE(2b, 3b)
+			     :
+			     : "A"(val),
+			       "m" (__m(ptr)),
+			       "m" (__m((const char *)ptr + 4)));
+		break;
+#endif
+	case 1:
+	case 2:
+	case 4:
+		asm volatile("\n"
+			     "1:	mov %0,%1\n"
+			     "2:\n"
+			     ".previous\n"
+			     _ASM_EXTABLE(1b, 2b)
+			     :
+			     : "=r"(val), "m" (__m(ptr)));
+		break;
+	default:
+		__put_user_unsupported_size();
+	}
+}
 
 #define put_user_try		uaccess_try
 #define put_user_catch(err)	uaccess_catch(err)
 
-#define put_user_ex(x, ptr)						\
-	__put_user_size_ex((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
-
 extern unsigned long
 copy_from_user_nmi(void *to, const void __user *from, unsigned long n);
 extern __must_check long
@@ -711,22 +765,20 @@ extern struct movsl_mask {
 #define user_access_begin()	__uaccess_begin()
 #define user_access_end()	__uaccess_end()
 
-#define unsafe_put_user(x, ptr, err_label)					\
-do {										\
-	int __pu_err;								\
-	__typeof__(*(ptr)) __pu_val = (x);					\
-	__put_user_size(__pu_val, (ptr), sizeof(*(ptr)), __pu_err, -EFAULT);	\
-	if (unlikely(__pu_err)) goto err_label;					\
-} while (0)
-
-#define unsafe_get_user(x, ptr, err_label)					\
-do {										\
-	int __gu_err;								\
-	__inttype(*(ptr)) __gu_val;						\
-	__get_user_size(__gu_val, (ptr), sizeof(*(ptr)), __gu_err, -EFAULT);	\
-	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
-	if (unlikely(__gu_err)) goto err_label;					\
-} while (0)
+#define unsafe_put_user(x, ptr, err_label)				\
+	do {								\
+		int __pu_err;						\
+		__pu_err = __put_user_unsafe(x, ptr);			\
+		if (unlikely(__gu_err))					\
+			goto err_label;					\
+	} while (0)
+
+#define unsafe_get_user(x, ptr, err_label)				\
+	do {								\
+		int __gu_err;						\
+		__gu_err = __get_user_unsafe(x, ptr);			\
+		if (unlikely(__gu_err))					\
+			goto err_label;					\
+	} while (0)
 
 #endif /* _ASM_X86_UACCESS_H */
-
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 62546b3a398e..24bf7d0a21b6 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -56,46 +56,40 @@ raw_copy_from_user(void *dst, const void __user *src, unsigned long size)
 	switch (size) {
 	case 1:
 		__uaccess_begin_nospec();
-		__get_user_asm_nozero(*(u8 *)dst, (u8 __user *)src,
-			      ret, "b", "b", "=q", 1);
+		ret = __get_user_unsafe_nozero(*(u8 *)dst, (u8 __user *)src, 1);
 		__uaccess_end();
 		return ret;
 	case 2:
 		__uaccess_begin_nospec();
-		__get_user_asm_nozero(*(u16 *)dst, (u16 __user *)src,
-			      ret, "w", "w", "=r", 2);
+		ret = __get_user_unsafe_nozero(*(u16 *)dst, (u16 __user *)src, 2);
 		__uaccess_end();
 		return ret;
 	case 4:
 		__uaccess_begin_nospec();
-		__get_user_asm_nozero(*(u32 *)dst, (u32 __user *)src,
-			      ret, "l", "k", "=r", 4);
+		ret = __get_user_unsafe_nozero(*(u32 *)dst, (u32 __user *)src, 4);
 		__uaccess_end();
 		return ret;
 	case 8:
 		__uaccess_begin_nospec();
-		__get_user_asm_nozero(*(u64 *)dst, (u64 __user *)src,
-			      ret, "q", "", "=r", 8);
+		ret = __get_user_unsafe_nozero(*(u64 *)dst, (u64 __user *)src, 8);
 		__uaccess_end();
 		return ret;
 	case 10:
 		__uaccess_begin_nospec();
-		__get_user_asm_nozero(*(u64 *)dst, (u64 __user *)src,
-			       ret, "q", "", "=r", 10);
+		ret = __get_user_unsafe_nozero(*(u64 *)dst, (u64 __user *)src, 10);
 		if (likely(!ret))
-			__get_user_asm_nozero(*(u16 *)(8 + (char *)dst),
-				       (u16 __user *)(8 + (char __user *)src),
-				       ret, "w", "w", "=r", 2);
+			ret = __get_user_unsafe_nozero(
+				*(u16 *)(8 + (char *)dst),
+				(u16 __user *)(8 + (char __user *)src), 2);
 		__uaccess_end();
 		return ret;
 	case 16:
 		__uaccess_begin_nospec();
-		__get_user_asm_nozero(*(u64 *)dst, (u64 __user *)src,
-			       ret, "q", "", "=r", 16);
+		ret = __get_user_unsafe_nozero(*(u64 *)dst, (u64 __user *)src, 16);
 		if (likely(!ret))
-			__get_user_asm_nozero(*(u64 *)(8 + (char *)dst),
-				       (u64 __user *)(8 + (char __user *)src),
-				       ret, "q", "", "=r", 8);
+			ret = __get_user_unsafe_nozero(
+				*(u64 *)(8 + (char *)dst),
+				(u64 __user *)(8 + (char __user *)src), 8);
 		__uaccess_end();
 		return ret;
 	default:
@@ -112,48 +106,28 @@ raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
 		return copy_user_generic((__force void *)dst, src, size);
 	switch (size) {
 	case 1:
-		__uaccess_begin();
-		__put_user_asm(*(u8 *)src, (u8 __user *)dst,
-			      ret, "b", "b", "iq", 1);
-		__uaccess_end();
-		return ret;
+		return __put_user(*(u8 *)src, (u8 __user *)dst, 1);
 	case 2:
-		__uaccess_begin();
-		__put_user_asm(*(u16 *)src, (u16 __user *)dst,
-			      ret, "w", "w", "ir", 2);
-		__uaccess_end();
-		return ret;
+		return __put_user(*(u16 *)src, (u16 __user *)dst, 2);
 	case 4:
-		__uaccess_begin();
-		__put_user_asm(*(u32 *)src, (u32 __user *)dst,
-			      ret, "l", "k", "ir", 4);
-		__uaccess_end();
-		return ret;
+		return __put_user(*(u32 *)src, (u32 __user *)dst, 4);
 	case 8:
-		__uaccess_begin();
-		__put_user_asm(*(u64 *)src, (u64 __user *)dst,
-			      ret, "q", "", "er", 8);
-		__uaccess_end();
-		return ret;
+		return __put_user(*(u64 *)src, (u64 __user *)dst, 8);
 	case 10:
 		__uaccess_begin();
-		__put_user_asm(*(u64 *)src, (u64 __user *)dst,
-			       ret, "q", "", "er", 10);
+		ret = __put_user_unsafe(*(u64 *)src, (u64 __user *)dst, 10);
 		if (likely(!ret)) {
 			asm("":::"memory");
-			__put_user_asm(4[(u16 *)src], 4 + (u16 __user *)dst,
-				       ret, "w", "w", "ir", 2);
+			ret = __put_user_unsafe(4[(u16 *)src], 4 + (u16 __user *)dst, 2);
 		}
 		__uaccess_end();
 		return ret;
 	case 16:
 		__uaccess_begin();
-		__put_user_asm(*(u64 *)src, (u64 __user *)dst,
-			       ret, "q", "", "er", 16);
+		ret =__put_user_unsafe(*(u64 *)src, (u64 __user *)dst, 16);
 		if (likely(!ret)) {
 			asm("":::"memory");
-			__put_user_asm(1[(u64 *)src], 1 + (u64 __user *)dst,
-				       ret, "q", "", "er", 8);
+			ret = __put_user_unsafe(1[(u64 *)src], 1 + (u64 __user *)dst, 8);
 		}
 		__uaccess_end();
 		return ret;
