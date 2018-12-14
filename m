Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0F0C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD4A21508
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789723;
	bh=UdhPBpqfEXz7abn6W07loQKl/DGWhOA93ia67GajPAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TOoyblkOAT/5dhCr3nd1hq35EZusdvrQv/vEZdC2okZHi9h6HqEHppitfJf/jb0Zz
	 100581q/n6HZrmH1lE34y1EhLZ62SeZ6RQZG3ggdlGc22NrxF3euqurmnwATQjNzLZ
	 4MO0/iXQJFOWyfxvCdvFjig4kb3NNjXMNFKz8cOc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD4A21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbeLNMPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:15:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732237AbeLNMPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:15:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A4F2214F1;
        Fri, 14 Dec 2018 12:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789719;
        bh=UdhPBpqfEXz7abn6W07loQKl/DGWhOA93ia67GajPAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXwty0+PPgu7K1wxx2RePz+EX4HGj7463TrkINesvL4Xj6Gjw5RFxJGCOj8vJQvdC
         V30yDit5AL2LDy10F3QleRnb8xjlJPmB/1hOJPG6w0V1XvO+rwe1ECobCeVsaI0oQv
         7qEbgzsftE8VzjlKoJuZNplvSmGvsYSDD2hs80Xs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 51/88] x86: reorganize SMAP handling in user space accesses
Date:   Fri, 14 Dec 2018 13:00:25 +0100
Message-Id: <20181214115706.508353827@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 11f1a4b9755f5dbc3e822a96502ebe9b044b14d8 upstream.

This reorganizes how we do the stac/clac instructions in the user access
code.  Instead of adding the instructions directly to the same inline
asm that does the actual user level access and exception handling, add
them at a higher level.

This is mainly preparation for the next step, where we will expose an
interface to allow users to mark several accesses together as being user
space accesses, but it does already clean up some code:

 - the inlined trivial cases of copy_in_user() now do stac/clac just
   once over the accesses: they used to do one pair around the user
   space read, and another pair around the write-back.

 - the {get,put}_user_ex() macros that are used with the catch/try
   handling don't do any stac/clac at all, because that happens in the
   try/catch surrounding them.

Other than those two cleanups that happened naturally from the
re-organization, this should not make any difference. Yet.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/uaccess.h    |   53 ++++++++++++++-------
 arch/x86/include/asm/uaccess_64.h |   94 ++++++++++++++++++++++++++------------
 2 files changed, 101 insertions(+), 46 deletions(-)

--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -144,6 +144,9 @@ extern int __get_user_4(void);
 extern int __get_user_8(void);
 extern int __get_user_bad(void);
 
+#define __uaccess_begin() stac()
+#define __uaccess_end()   clac()
+
 /*
  * This is a type: either unsigned long, if the argument fits into
  * that type, or otherwise unsigned long long.
@@ -203,10 +206,10 @@ __typeof__(__builtin_choose_expr(sizeof(
 
 #ifdef CONFIG_X86_32
 #define __put_user_asm_u64(x, addr, err, errret)			\
-	asm volatile(ASM_STAC "\n"					\
+	asm volatile("\n"						\
 		     "1:	movl %%eax,0(%2)\n"			\
 		     "2:	movl %%edx,4(%2)\n"			\
-		     "3: " ASM_CLAC "\n"				\
+		     "3:"						\
 		     ".section .fixup,\"ax\"\n"				\
 		     "4:	movl %3,%0\n"				\
 		     "	jmp 3b\n"					\
@@ -217,10 +220,10 @@ __typeof__(__builtin_choose_expr(sizeof(
 		     : "A" (x), "r" (addr), "i" (errret), "0" (err))
 
 #define __put_user_asm_ex_u64(x, addr)					\
-	asm volatile(ASM_STAC "\n"					\
+	asm volatile("\n"						\
 		     "1:	movl %%eax,0(%1)\n"			\
 		     "2:	movl %%edx,4(%1)\n"			\
-		     "3: " ASM_CLAC "\n"				\
+		     "3:"						\
 		     _ASM_EXTABLE_EX(1b, 2b)				\
 		     _ASM_EXTABLE_EX(2b, 3b)				\
 		     : : "A" (x), "r" (addr))
@@ -314,6 +317,10 @@ do {									\
 	}								\
 } while (0)
 
+/*
+ * This doesn't do __uaccess_begin/end - the exception handling
+ * around it must do that.
+ */
 #define __put_user_size_ex(x, ptr, size)				\
 do {									\
 	__chk_user_ptr(ptr);						\
@@ -368,9 +375,9 @@ do {									\
 } while (0)
 
 #define __get_user_asm(x, addr, err, itype, rtype, ltype, errret)	\
-	asm volatile(ASM_STAC "\n"					\
+	asm volatile("\n"						\
 		     "1:	mov"itype" %2,%"rtype"1\n"		\
-		     "2: " ASM_CLAC "\n"				\
+		     "2:\n"						\
 		     ".section .fixup,\"ax\"\n"				\
 		     "3:	mov %3,%0\n"				\
 		     "	xor"itype" %"rtype"1,%"rtype"1\n"		\
@@ -380,6 +387,10 @@ do {									\
 		     : "=r" (err), ltype(x)				\
 		     : "m" (__m(addr)), "i" (errret), "0" (err))
 
+/*
+ * This doesn't do __uaccess_begin/end - the exception handling
+ * around it must do that.
+ */
 #define __get_user_size_ex(x, ptr, size)				\
 do {									\
 	__chk_user_ptr(ptr);						\
@@ -410,7 +421,9 @@ do {									\
 #define __put_user_nocheck(x, ptr, size)			\
 ({								\
 	int __pu_err;						\
+	__uaccess_begin();					\
 	__put_user_size((x), (ptr), (size), __pu_err, -EFAULT);	\
+	__uaccess_end();					\
 	__builtin_expect(__pu_err, 0);				\
 })
 
@@ -418,7 +431,9 @@ do {									\
 ({									\
 	int __gu_err;							\
 	unsigned long __gu_val;						\
+	__uaccess_begin();						\
 	__get_user_size(__gu_val, (ptr), (size), __gu_err, -EFAULT);	\
+	__uaccess_end();						\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 	__builtin_expect(__gu_err, 0);					\
 })
@@ -433,9 +448,9 @@ struct __large_struct { unsigned long bu
  * aliasing issues.
  */
 #define __put_user_asm(x, addr, err, itype, rtype, ltype, errret)	\
-	asm volatile(ASM_STAC "\n"					\
+	asm volatile("\n"						\
 		     "1:	mov"itype" %"rtype"1,%2\n"		\
-		     "2: " ASM_CLAC "\n"				\
+		     "2:\n"						\
 		     ".section .fixup,\"ax\"\n"				\
 		     "3:	mov %3,%0\n"				\
 		     "	jmp 2b\n"					\
@@ -455,11 +470,11 @@ struct __large_struct { unsigned long bu
  */
 #define uaccess_try	do {						\
 	current_thread_info()->uaccess_err = 0;				\
-	stac();								\
+	__uaccess_begin();						\
 	barrier();
 
 #define uaccess_catch(err)						\
-	clac();								\
+	__uaccess_end();						\
 	(err) |= (current_thread_info()->uaccess_err ? -EFAULT : 0);	\
 } while (0)
 
@@ -557,12 +572,13 @@ extern void __cmpxchg_wrong_size(void)
 	__typeof__(ptr) __uval = (uval);				\
 	__typeof__(*(ptr)) __old = (old);				\
 	__typeof__(*(ptr)) __new = (new);				\
+	__uaccess_begin();						\
 	switch (size) {							\
 	case 1:								\
 	{								\
-		asm volatile("\t" ASM_STAC "\n"				\
+		asm volatile("\n"					\
 			"1:\t" LOCK_PREFIX "cmpxchgb %4, %2\n"		\
-			"2:\t" ASM_CLAC "\n"				\
+			"2:\n"						\
 			"\t.section .fixup, \"ax\"\n"			\
 			"3:\tmov     %3, %0\n"				\
 			"\tjmp     2b\n"				\
@@ -576,9 +592,9 @@ extern void __cmpxchg_wrong_size(void)
 	}								\
 	case 2:								\
 	{								\
-		asm volatile("\t" ASM_STAC "\n"				\
+		asm volatile("\n"					\
 			"1:\t" LOCK_PREFIX "cmpxchgw %4, %2\n"		\
-			"2:\t" ASM_CLAC "\n"				\
+			"2:\n"						\
 			"\t.section .fixup, \"ax\"\n"			\
 			"3:\tmov     %3, %0\n"				\
 			"\tjmp     2b\n"				\
@@ -592,9 +608,9 @@ extern void __cmpxchg_wrong_size(void)
 	}								\
 	case 4:								\
 	{								\
-		asm volatile("\t" ASM_STAC "\n"				\
+		asm volatile("\n"					\
 			"1:\t" LOCK_PREFIX "cmpxchgl %4, %2\n"		\
-			"2:\t" ASM_CLAC "\n"				\
+			"2:\n"						\
 			"\t.section .fixup, \"ax\"\n"			\
 			"3:\tmov     %3, %0\n"				\
 			"\tjmp     2b\n"				\
@@ -611,9 +627,9 @@ extern void __cmpxchg_wrong_size(void)
 		if (!IS_ENABLED(CONFIG_X86_64))				\
 			__cmpxchg_wrong_size();				\
 									\
-		asm volatile("\t" ASM_STAC "\n"				\
+		asm volatile("\n"					\
 			"1:\t" LOCK_PREFIX "cmpxchgq %4, %2\n"		\
-			"2:\t" ASM_CLAC "\n"				\
+			"2:\n"						\
 			"\t.section .fixup, \"ax\"\n"			\
 			"3:\tmov     %3, %0\n"				\
 			"\tjmp     2b\n"				\
@@ -628,6 +644,7 @@ extern void __cmpxchg_wrong_size(void)
 	default:							\
 		__cmpxchg_wrong_size();					\
 	}								\
+	__uaccess_end();						\
 	*__uval = __old;						\
 	__ret;								\
 })
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -56,35 +56,49 @@ int __copy_from_user_nocheck(void *dst,
 	if (!__builtin_constant_p(size))
 		return copy_user_generic(dst, (__force void *)src, size);
 	switch (size) {
-	case 1:__get_user_asm(*(u8 *)dst, (u8 __user *)src,
+	case 1:
+		__uaccess_begin();
+		__get_user_asm(*(u8 *)dst, (u8 __user *)src,
 			      ret, "b", "b", "=q", 1);
+		__uaccess_end();
 		return ret;
-	case 2:__get_user_asm(*(u16 *)dst, (u16 __user *)src,
+	case 2:
+		__uaccess_begin();
+		__get_user_asm(*(u16 *)dst, (u16 __user *)src,
 			      ret, "w", "w", "=r", 2);
+		__uaccess_end();
 		return ret;
-	case 4:__get_user_asm(*(u32 *)dst, (u32 __user *)src,
+	case 4:
+		__uaccess_begin();
+		__get_user_asm(*(u32 *)dst, (u32 __user *)src,
 			      ret, "l", "k", "=r", 4);
+		__uaccess_end();
 		return ret;
-	case 8:__get_user_asm(*(u64 *)dst, (u64 __user *)src,
+	case 8:
+		__uaccess_begin();
+		__get_user_asm(*(u64 *)dst, (u64 __user *)src,
 			      ret, "q", "", "=r", 8);
+		__uaccess_end();
 		return ret;
 	case 10:
+		__uaccess_begin();
 		__get_user_asm(*(u64 *)dst, (u64 __user *)src,
 			       ret, "q", "", "=r", 10);
-		if (unlikely(ret))
-			return ret;
-		__get_user_asm(*(u16 *)(8 + (char *)dst),
-			       (u16 __user *)(8 + (char __user *)src),
-			       ret, "w", "w", "=r", 2);
+		if (likely(!ret))
+			__get_user_asm(*(u16 *)(8 + (char *)dst),
+				       (u16 __user *)(8 + (char __user *)src),
+				       ret, "w", "w", "=r", 2);
+		__uaccess_end();
 		return ret;
 	case 16:
+		__uaccess_begin();
 		__get_user_asm(*(u64 *)dst, (u64 __user *)src,
 			       ret, "q", "", "=r", 16);
-		if (unlikely(ret))
-			return ret;
-		__get_user_asm(*(u64 *)(8 + (char *)dst),
-			       (u64 __user *)(8 + (char __user *)src),
-			       ret, "q", "", "=r", 8);
+		if (likely(!ret))
+			__get_user_asm(*(u64 *)(8 + (char *)dst),
+				       (u64 __user *)(8 + (char __user *)src),
+				       ret, "q", "", "=r", 8);
+		__uaccess_end();
 		return ret;
 	default:
 		return copy_user_generic(dst, (__force void *)src, size);
@@ -106,35 +120,51 @@ int __copy_to_user_nocheck(void __user *
 	if (!__builtin_constant_p(size))
 		return copy_user_generic((__force void *)dst, src, size);
 	switch (size) {
-	case 1:__put_user_asm(*(u8 *)src, (u8 __user *)dst,
+	case 1:
+		__uaccess_begin();
+		__put_user_asm(*(u8 *)src, (u8 __user *)dst,
 			      ret, "b", "b", "iq", 1);
+		__uaccess_end();
 		return ret;
-	case 2:__put_user_asm(*(u16 *)src, (u16 __user *)dst,
+	case 2:
+		__uaccess_begin();
+		__put_user_asm(*(u16 *)src, (u16 __user *)dst,
 			      ret, "w", "w", "ir", 2);
+		__uaccess_end();
 		return ret;
-	case 4:__put_user_asm(*(u32 *)src, (u32 __user *)dst,
+	case 4:
+		__uaccess_begin();
+		__put_user_asm(*(u32 *)src, (u32 __user *)dst,
 			      ret, "l", "k", "ir", 4);
+		__uaccess_end();
 		return ret;
-	case 8:__put_user_asm(*(u64 *)src, (u64 __user *)dst,
+	case 8:
+		__uaccess_begin();
+		__put_user_asm(*(u64 *)src, (u64 __user *)dst,
 			      ret, "q", "", "er", 8);
+		__uaccess_end();
 		return ret;
 	case 10:
+		__uaccess_begin();
 		__put_user_asm(*(u64 *)src, (u64 __user *)dst,
 			       ret, "q", "", "er", 10);
-		if (unlikely(ret))
-			return ret;
-		asm("":::"memory");
-		__put_user_asm(4[(u16 *)src], 4 + (u16 __user *)dst,
-			       ret, "w", "w", "ir", 2);
+		if (likely(!ret)) {
+			asm("":::"memory");
+			__put_user_asm(4[(u16 *)src], 4 + (u16 __user *)dst,
+				       ret, "w", "w", "ir", 2);
+		}
+		__uaccess_end();
 		return ret;
 	case 16:
+		__uaccess_begin();
 		__put_user_asm(*(u64 *)src, (u64 __user *)dst,
 			       ret, "q", "", "er", 16);
-		if (unlikely(ret))
-			return ret;
-		asm("":::"memory");
-		__put_user_asm(1[(u64 *)src], 1 + (u64 __user *)dst,
-			       ret, "q", "", "er", 8);
+		if (likely(!ret)) {
+			asm("":::"memory");
+			__put_user_asm(1[(u64 *)src], 1 + (u64 __user *)dst,
+				       ret, "q", "", "er", 8);
+		}
+		__uaccess_end();
 		return ret;
 	default:
 		return copy_user_generic((__force void *)dst, src, size);
@@ -160,39 +190,47 @@ int __copy_in_user(void __user *dst, con
 	switch (size) {
 	case 1: {
 		u8 tmp;
+		__uaccess_begin();
 		__get_user_asm(tmp, (u8 __user *)src,
 			       ret, "b", "b", "=q", 1);
 		if (likely(!ret))
 			__put_user_asm(tmp, (u8 __user *)dst,
 				       ret, "b", "b", "iq", 1);
+		__uaccess_end();
 		return ret;
 	}
 	case 2: {
 		u16 tmp;
+		__uaccess_begin();
 		__get_user_asm(tmp, (u16 __user *)src,
 			       ret, "w", "w", "=r", 2);
 		if (likely(!ret))
 			__put_user_asm(tmp, (u16 __user *)dst,
 				       ret, "w", "w", "ir", 2);
+		__uaccess_end();
 		return ret;
 	}
 
 	case 4: {
 		u32 tmp;
+		__uaccess_begin();
 		__get_user_asm(tmp, (u32 __user *)src,
 			       ret, "l", "k", "=r", 4);
 		if (likely(!ret))
 			__put_user_asm(tmp, (u32 __user *)dst,
 				       ret, "l", "k", "ir", 4);
+		__uaccess_end();
 		return ret;
 	}
 	case 8: {
 		u64 tmp;
+		__uaccess_begin();
 		__get_user_asm(tmp, (u64 __user *)src,
 			       ret, "q", "", "=r", 8);
 		if (likely(!ret))
 			__put_user_asm(tmp, (u64 __user *)dst,
 				       ret, "q", "", "er", 8);
+		__uaccess_end();
 		return ret;
 	}
 	default:


