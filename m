Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F21C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B4020866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tt8y3Cpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B4020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeILTti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:49:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeILTti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IhrlbwAYHCJno77tbEwPguc7UofQ9XmFiwd2aW0HdE8=; b=Tt8y3Cpt6c9bZ0sHFRbPKMSFi
        kaf4uo6+GG95vklCk1G/Zn2ktWqeggInb9vdTzsco+P1Ccy63br9er5zI+LnKeLUczpT4DDS6SbqC
        QGBG9RhQXwnEmyWQVhUw31jAuhqOS8BbqhvJwBGUQFsfhZofyKgahVgK0xagnQj5AHlLYHNWk3+6h
        yCNyjw9AJ+R2AQVAMIOrlYCY3L5sTd6sFnCYGqIiuIw+L55TvH3ZVFZlBd51mezgTeDlWpHh5kRo1
        +RTajf8m3Npr69PbtHb8thCoGqa60A0CBPFxeDUMF/ot/E5fdTAdppdN3XqCVBa7ES7bj033Z4hhY
        CDYHRgfkg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g06Nr-0007dC-62; Wed, 12 Sep 2018 14:44:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>
Subject: [PATCH 1/2] x86: Use named address spaces in asm/percpu.h
Date:   Wed, 12 Sep 2018 07:44:41 -0700
Message-Id: <20180912144442.29271-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180912144442.29271-1-willy@infradead.org>
References: <20180912144442.29271-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Henderson <rth@twiddle.net>

GCC 6 adds support for __seg_fs and __seg_gs as named address spaces,
producing the obvious segment overrides for objects so marked.

Exposing the memory reference allows slightly better code generation
in some cases (and in others, merely affects the scheduling).  E.g.:

[1]
- mov    %gs:0x0(%rip),%eax
-        R_X86_64_PC32      context_tracking+0x4
- cmp    $0x1,%eax
+ cmpl   $0x1,%gs:0x0(%rip)
+        R_X86_64_PC32      context_tracking+0x3

[2]
- mov    %gs:0x0(%rip),%ebx
-        R_X86_64_PC32      cpu_number-0x4
- movslq %ebx,%rax
+ movslq %gs:0x0(%rip),%rax
+        R_X86_64_PC32      cpu_number-0x4

[3]
- mov    %gs:0x0(%rip),%rdx
-        R_X86_64_PC32      cpu_info+0x20
- test   $0x1000000,%edx
+ testb  $0x1,%gs:0x0(%rip)
+        R_X86_64_PC32      cpu_info+0x22

[4]
- mov    $0x0,%rax
-        R_X86_64_32S       __uv_hub_info
- mov    %rax,%rcx
- add    %gs:0x0(%rip),%rcx
-        R_X86_64_PC32      this_cpu_off-0x4
- movzbl 0x15(%rcx),%ecx
...
- mov    %rax,%rdx
- add    %gs:0x0(%rip),%rdx
-        R_X86_64_PC32      this_cpu_off-0x4
- or     (%rdx),%rcx
+ mov    %gs:0x0(%rip),%r9
+        R_X86_64_PC32      this_cpu_off-0x4
+ mov    $0x0,%rax
+        R_X86_64_32S       __uv_hub_info
...
+ movzbl 0x15(%rax,%r9,1),%ecx
...
+ or     (%rax,%r9,1),%rdx

The final vmlinux text size is reduced by about 5k for a standard
Fedora configure.

Signed-off-by: Richard Henderson <rth@twiddle.net>
[changes as requested by Ingo]
Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 arch/x86/include/asm/percpu.h | 141 ++++++++++++++++++++--------------
 1 file changed, 82 insertions(+), 59 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index e9202a0de8f0..30a08d0d95ee 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -47,6 +47,19 @@
 
 #ifdef CONFIG_SMP
 #define __percpu_prefix		"%%"__stringify(__percpu_seg)":"
+
+#ifdef __percpu_addrspace
+/* Produce an address-space lvalue for VAR.  */
+#define __percpu_as(VAR) \
+  (*(typeof(VAR) __kernel __force __percpu_addrspace *)(uintptr_t)&(VAR))
+
+/*
+ * We cannot allow __my_cpu_offset to recurse through this_cpu_read, as
+ * this will change based on CONFIG_X86_64, with which games are played
+ * in 32-bit compatibility files.
+ */
+#define __my_cpu_offset		(__percpu_as(this_cpu_off) + 0)
+#else
 #define __my_cpu_offset		this_cpu_read(this_cpu_off)
 
 /*
@@ -61,9 +74,11 @@
 		     : "m" (this_cpu_off), "0" (ptr));	\
 	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;	\
 })
+#endif /* __percpu_addrspace */
 #else
 #define __percpu_prefix		""
-#endif
+#undef __percpu_addrspace
+#endif /* SMP */
 
 #define __percpu_arg(x)		__percpu_prefix "%" #x
 
@@ -87,7 +102,14 @@
  * don't give an lvalue though). */
 extern void __bad_percpu_size(void);
 
-#define percpu_to_op(op, var, val)			\
+#ifdef __percpu_addrspace
+#define percpu_to_op(op, cop, var, val)			\
+do {							\
+	typeof(var) pto_tmp__ = (val);			\
+	__percpu_as(var) cop pto_tmp__;			\
+} while (0)
+#else
+#define percpu_to_op(op, cop, var, val)			\
 do {							\
 	typedef typeof(var) pto_T__;			\
 	if (0) {					\
@@ -119,11 +141,15 @@ do {							\
 	default: __bad_percpu_size();			\
 	}						\
 } while (0)
+#endif /* __percpu_addrspace */
 
 /*
  * Generate a percpu add to memory instruction and optimize code
  * if one is added or subtracted.
  */
+#ifdef __percpu_addrspace
+#define percpu_add_op(var, val)  percpu_to_op("add", +=, var, val)
+#else
 #define percpu_add_op(var, val)						\
 do {									\
 	typedef typeof(var) pao_T__;					\
@@ -179,7 +205,9 @@ do {									\
 	default: __bad_percpu_size();					\
 	}								\
 } while (0)
+#endif /* __percpu_addrspace */
 
+/* ??? Note that percpu_from_op is only ever used with mov.  */
 #define percpu_from_op(op, var)				\
 ({							\
 	typeof(var) pfo_ret__;				\
@@ -238,35 +266,19 @@ do {									\
 	pfo_ret__;					\
 })
 
-#define percpu_unary_op(op, var)			\
-({							\
-	switch (sizeof(var)) {				\
-	case 1:						\
-		asm(op "b "__percpu_arg(0)		\
-		    : "+m" (var));			\
-		break;					\
-	case 2:						\
-		asm(op "w "__percpu_arg(0)		\
-		    : "+m" (var));			\
-		break;					\
-	case 4:						\
-		asm(op "l "__percpu_arg(0)		\
-		    : "+m" (var));			\
-		break;					\
-	case 8:						\
-		asm(op "q "__percpu_arg(0)		\
-		    : "+m" (var));			\
-		break;					\
-	default: __bad_percpu_size();			\
-	}						\
-})
-
 /*
  * Add return operation
  */
+#ifdef __percpu_addrspace
+#define percpu_add_return_op(var, val)			\
+({							\
+	typeof(var) pto_tmp__ = (val);			\
+	__percpu_as(var) += pto_tmp__;			\
+})
+#else
 #define percpu_add_return_op(var, val)					\
 ({									\
-	typeof(var) paro_ret__ = val;					\
+	typeof(var) paro_ret__ = (val);					\
 	switch (sizeof(var)) {						\
 	case 1:								\
 		asm("xaddb %0, "__percpu_arg(1)				\
@@ -293,6 +305,7 @@ do {									\
 	paro_ret__ += val;						\
 	paro_ret__;							\
 })
+#endif /* __percpu_addrspace */
 
 /*
  * xchg is implemented using cmpxchg without a lock prefix. xchg is
@@ -391,41 +404,47 @@ do {									\
  */
 #define this_cpu_read_stable(var)	percpu_stable_op("mov", var)
 
+#ifdef __percpu_addrspace
+#define raw_cpu_read_1(pcp)		({ __percpu_as(pcp); })
+#define raw_cpu_read_2(pcp)		({ __percpu_as(pcp); })
+#define raw_cpu_read_4(pcp)		({ __percpu_as(pcp); })
+#else
 #define raw_cpu_read_1(pcp)		percpu_from_op("mov", pcp)
 #define raw_cpu_read_2(pcp)		percpu_from_op("mov", pcp)
 #define raw_cpu_read_4(pcp)		percpu_from_op("mov", pcp)
+#endif
 
-#define raw_cpu_write_1(pcp, val)	percpu_to_op("mov", (pcp), val)
-#define raw_cpu_write_2(pcp, val)	percpu_to_op("mov", (pcp), val)
-#define raw_cpu_write_4(pcp, val)	percpu_to_op("mov", (pcp), val)
+#define raw_cpu_write_1(pcp, val)	percpu_to_op("mov", =, (pcp), val)
+#define raw_cpu_write_2(pcp, val)	percpu_to_op("mov", =, (pcp), val)
+#define raw_cpu_write_4(pcp, val)	percpu_to_op("mov", =, (pcp), val)
 #define raw_cpu_add_1(pcp, val)		percpu_add_op((pcp), val)
 #define raw_cpu_add_2(pcp, val)		percpu_add_op((pcp), val)
 #define raw_cpu_add_4(pcp, val)		percpu_add_op((pcp), val)
-#define raw_cpu_and_1(pcp, val)		percpu_to_op("and", (pcp), val)
-#define raw_cpu_and_2(pcp, val)		percpu_to_op("and", (pcp), val)
-#define raw_cpu_and_4(pcp, val)		percpu_to_op("and", (pcp), val)
-#define raw_cpu_or_1(pcp, val)		percpu_to_op("or", (pcp), val)
-#define raw_cpu_or_2(pcp, val)		percpu_to_op("or", (pcp), val)
-#define raw_cpu_or_4(pcp, val)		percpu_to_op("or", (pcp), val)
+#define raw_cpu_and_1(pcp, val)		percpu_to_op("and", &=, (pcp), val)
+#define raw_cpu_and_2(pcp, val)		percpu_to_op("and", &=, (pcp), val)
+#define raw_cpu_and_4(pcp, val)		percpu_to_op("and", &=, (pcp), val)
+#define raw_cpu_or_1(pcp, val)		percpu_to_op("or", |=, (pcp), val)
+#define raw_cpu_or_2(pcp, val)		percpu_to_op("or", |=, (pcp), val)
+#define raw_cpu_or_4(pcp, val)		percpu_to_op("or", |=, (pcp), val)
 #define raw_cpu_xchg_1(pcp, val)	percpu_xchg_op(pcp, val)
 #define raw_cpu_xchg_2(pcp, val)	percpu_xchg_op(pcp, val)
 #define raw_cpu_xchg_4(pcp, val)	percpu_xchg_op(pcp, val)
 
-#define this_cpu_read_1(pcp)		percpu_from_op("mov", pcp)
-#define this_cpu_read_2(pcp)		percpu_from_op("mov", pcp)
-#define this_cpu_read_4(pcp)		percpu_from_op("mov", pcp)
-#define this_cpu_write_1(pcp, val)	percpu_to_op("mov", (pcp), val)
-#define this_cpu_write_2(pcp, val)	percpu_to_op("mov", (pcp), val)
-#define this_cpu_write_4(pcp, val)	percpu_to_op("mov", (pcp), val)
-#define this_cpu_add_1(pcp, val)	percpu_add_op((pcp), val)
-#define this_cpu_add_2(pcp, val)	percpu_add_op((pcp), val)
-#define this_cpu_add_4(pcp, val)	percpu_add_op((pcp), val)
-#define this_cpu_and_1(pcp, val)	percpu_to_op("and", (pcp), val)
-#define this_cpu_and_2(pcp, val)	percpu_to_op("and", (pcp), val)
-#define this_cpu_and_4(pcp, val)	percpu_to_op("and", (pcp), val)
-#define this_cpu_or_1(pcp, val)		percpu_to_op("or", (pcp), val)
-#define this_cpu_or_2(pcp, val)		percpu_to_op("or", (pcp), val)
-#define this_cpu_or_4(pcp, val)		percpu_to_op("or", (pcp), val)
+#define this_cpu_read_1(pcp)		raw_cpu_read_1(pcp)
+#define this_cpu_read_2(pcp)		raw_cpu_read_2(pcp)
+#define this_cpu_read_4(pcp)		raw_cpu_read_4(pcp)
+#define this_cpu_write_1(pcp, val)	raw_cpu_write_1(pcp, val)
+#define this_cpu_write_2(pcp, val)	raw_cpu_write_2(pcp, val)
+#define this_cpu_write_4(pcp, val)	raw_cpu_write_4(pcp, val)
+#define this_cpu_add_1(pcp, val)	raw_cpu_add_1(pcp, val)
+#define this_cpu_add_2(pcp, val)	raw_cpu_add_2(pcp, val)
+#define this_cpu_add_4(pcp, val)	raw_cpu_add_4(pcp, val)
+#define this_cpu_and_1(pcp, val)	raw_cpu_and_1(pcp, val)
+#define this_cpu_and_2(pcp, val)	raw_cpu_and_2(pcp, val)
+#define this_cpu_and_4(pcp, val)	raw_cpu_and_4(pcp, val)
+#define this_cpu_or_1(pcp, val)		raw_cpu_or_1(pcp, val)
+#define this_cpu_or_2(pcp, val)		raw_cpu_or_2(pcp, val)
+#define this_cpu_or_4(pcp, val)		raw_cpu_or_4(pcp, val)
 #define this_cpu_xchg_1(pcp, nval)	percpu_xchg_op(pcp, nval)
 #define this_cpu_xchg_2(pcp, nval)	percpu_xchg_op(pcp, nval)
 #define this_cpu_xchg_4(pcp, nval)	percpu_xchg_op(pcp, nval)
@@ -466,20 +485,24 @@ do {									\
  * 32 bit must fall back to generic operations.
  */
 #ifdef CONFIG_X86_64
+#ifdef __percpu_addrspace
+#define raw_cpu_read_8(pcp)			({ __percpu_as(pcp); })
+#else
 #define raw_cpu_read_8(pcp)			percpu_from_op("mov", pcp)
-#define raw_cpu_write_8(pcp, val)		percpu_to_op("mov", (pcp), val)
-#define raw_cpu_add_8(pcp, val)			percpu_add_op((pcp), val)
-#define raw_cpu_and_8(pcp, val)			percpu_to_op("and", (pcp), val)
-#define raw_cpu_or_8(pcp, val)			percpu_to_op("or", (pcp), val)
+#endif
+#define raw_cpu_write_8(pcp, val)		percpu_to_op("mov", =, (pcp), val)
+#define raw_cpu_add_8(pcp, val)			percpu_add_op(pcp, val)
+#define raw_cpu_and_8(pcp, val)			percpu_to_op("and", &=, (pcp), val)
+#define raw_cpu_or_8(pcp, val)			percpu_to_op("or", |=, (pcp), val)
 #define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(pcp, val)
 #define raw_cpu_xchg_8(pcp, nval)		percpu_xchg_op(pcp, nval)
 #define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(pcp, oval, nval)
 
-#define this_cpu_read_8(pcp)			percpu_from_op("mov", pcp)
-#define this_cpu_write_8(pcp, val)		percpu_to_op("mov", (pcp), val)
-#define this_cpu_add_8(pcp, val)		percpu_add_op((pcp), val)
-#define this_cpu_and_8(pcp, val)		percpu_to_op("and", (pcp), val)
-#define this_cpu_or_8(pcp, val)			percpu_to_op("or", (pcp), val)
+#define this_cpu_read_8(pcp)			raw_cpu_read_8(pcp)
+#define this_cpu_write_8(pcp, val)		raw_cpu_write_8(pcp, val)
+#define this_cpu_add_8(pcp, val)		raw_cpu_add_8(pcp, val)
+#define this_cpu_and_8(pcp, val)		raw_cpu_and_8(pcp, val)
+#define this_cpu_or_8(pcp, val)			raw_cpu_or_8(pcp, val)
 #define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(pcp, val)
 #define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(pcp, oval, nval)
-- 
2.18.0

