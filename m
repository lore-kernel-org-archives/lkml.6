Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF513C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9593220844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+4+Lb5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9593220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbeKIHeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:34:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727288AbeKIHeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:34:14 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B69772089F;
        Thu,  8 Nov 2018 21:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714205;
        bh=ryDyM/AZtPD96rDwiU9ezp1JaNXtGBqPIENc75Wzb3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+4+Lb5c1JNpDOpR7vOHK7DbC3BSzZKPjEecYDXicLEd/cfgdr55ykefYh4q8j0JU
         kaCArT68i+3uZvyU0oPUuO9pGX6PyTuRPYYcEE0OnIvnHFgJXUin26185Db2D3bvEj
         wZahqlh4/kBLc/O7aHh7r1O1M9/ziyB6B8OzHyfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephan Mueller <smueller@chronox.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Theodore Tso <tytso@mit.edu>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        mancha security <mancha1@zoho.com>,
        Mark Charlebois <charlebm@gmail.com>,
        Behan Webster <behanw@converseincode.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 100/144] lib: make memzero_explicit more robust against dead store elimination
Date:   Thu,  8 Nov 2018 13:51:11 -0800
Message-Id: <20181108215104.955573610@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7829fb09a2b4268b30dd9bc782fa5ebee278b137 ]

In commit 0b053c951829 ("lib: memzero_explicit: use barrier instead
of OPTIMIZER_HIDE_VAR"), we made memzero_explicit() more robust in
case LTO would decide to inline memzero_explicit() and eventually
find out it could be elimiated as dead store.

While using barrier() works well for the case of gcc, recent efforts
from LLVMLinux people suggest to use llvm as an alternative to gcc,
and there, Stephan found in a simple stand-alone user space example
that llvm could nevertheless optimize and thus elimitate the memset().
A similar issue has been observed in the referenced llvm bug report,
which is regarded as not-a-bug.

Based on some experiments, icc is a bit special on its own, while it
doesn't seem to eliminate the memset(), it could do so with an own
implementation, and then result in similar findings as with llvm.

The fix in this patch now works for all three compilers (also tested
with more aggressive optimization levels). Arguably, in the current
kernel tree it's more of a theoretical issue, but imho, it's better
to be pedantic about it.

It's clearly visible with gcc/llvm though, with the below code: if we
would have used barrier() only here, llvm would have omitted clearing,
not so with barrier_data() variant:

  static inline void memzero_explicit(void *s, size_t count)
  {
    memset(s, 0, count);
    barrier_data(s);
  }

  int main(void)
  {
    char buff[20];
    memzero_explicit(buff, sizeof(buff));
    return 0;
  }

  $ gcc -O2 test.c
  $ gdb a.out
  (gdb) disassemble main
  Dump of assembler code for function main:
   0x0000000000400400  <+0>: lea   -0x28(%rsp),%rax
   0x0000000000400405  <+5>: movq  $0x0,-0x28(%rsp)
   0x000000000040040e <+14>: movq  $0x0,-0x20(%rsp)
   0x0000000000400417 <+23>: movl  $0x0,-0x18(%rsp)
   0x000000000040041f <+31>: xor   %eax,%eax
   0x0000000000400421 <+33>: retq
  End of assembler dump.

  $ clang -O2 test.c
  $ gdb a.out
  (gdb) disassemble main
  Dump of assembler code for function main:
   0x00000000004004f0  <+0>: xorps  %xmm0,%xmm0
   0x00000000004004f3  <+3>: movaps %xmm0,-0x18(%rsp)
   0x00000000004004f8  <+8>: movl   $0x0,-0x8(%rsp)
   0x0000000000400500 <+16>: lea    -0x18(%rsp),%rax
   0x0000000000400505 <+21>: xor    %eax,%eax
   0x0000000000400507 <+23>: retq
  End of assembler dump.

As gcc, clang, but also icc defines __GNUC__, it's sufficient to define
this in compiler-gcc.h only to be picked up. For a fallback or otherwise
unsupported compiler, we define it as a barrier. Similarly, for ecc which
does not support gcc inline asm.

Reference: https://llvm.org/bugs/show_bug.cgi?id=15495
Reported-by: Stephan Mueller <smueller@chronox.de>
Tested-by: Stephan Mueller <smueller@chronox.de>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Stephan Mueller <smueller@chronox.de>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
Cc: mancha security <mancha1@zoho.com>
Cc: Mark Charlebois <charlebm@gmail.com>
Cc: Behan Webster <behanw@converseincode.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/compiler-gcc.h   | 16 +++++++++++++++-
 include/linux/compiler-intel.h |  3 +++
 include/linux/compiler.h       |  4 ++++
 lib/string.c                   |  2 +-
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 633716ef19b0..4d9e673bd76c 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -9,10 +9,24 @@
 		   + __GNUC_MINOR__ * 100 \
 		   + __GNUC_PATCHLEVEL__)
 
-
 /* Optimization barrier */
+
 /* The "volatile" is due to gcc bugs */
 #define barrier() __asm__ __volatile__("": : :"memory")
+/*
+ * This version is i.e. to prevent dead stores elimination on @ptr
+ * where gcc and llvm may behave differently when otherwise using
+ * normal barrier(): while gcc behavior gets along with a normal
+ * barrier(), llvm needs an explicit input variable to be assumed
+ * clobbered. The issue is as follows: while the inline asm might
+ * access any memory it wants, the compiler could have fit all of
+ * @ptr into memory registers instead, and since @ptr never escaped
+ * from that, it proofed that the inline asm wasn't touching any of
+ * it. This version works well with both compilers, i.e. we're telling
+ * the compiler that the inline asm absolutely may see the contents
+ * of @ptr. See also: https://llvm.org/bugs/show_bug.cgi?id=15495
+ */
+#define barrier_data(ptr) __asm__ __volatile__("": :"r"(ptr) :"memory")
 
 /*
  * This macro obfuscates arithmetic on a variable address so that gcc
diff --git a/include/linux/compiler-intel.h b/include/linux/compiler-intel.h
index ba147a1727e6..0c9a2f2c2802 100644
--- a/include/linux/compiler-intel.h
+++ b/include/linux/compiler-intel.h
@@ -13,9 +13,12 @@
 /* Intel ECC compiler doesn't support gcc specific asm stmts.
  * It uses intrinsics to do the equivalent things.
  */
+#undef barrier_data
 #undef RELOC_HIDE
 #undef OPTIMIZER_HIDE_VAR
 
+#define barrier_data(ptr) barrier()
+
 #define RELOC_HIDE(ptr, off)					\
   ({ unsigned long __ptr;					\
      __ptr = (unsigned long) (ptr);				\
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 8cf7a33e1b72..78b27883744c 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -165,6 +165,10 @@ void ftrace_likely_update(struct ftrace_branch_data *f, int val, int expect);
 # define barrier() __memory_barrier()
 #endif
 
+#ifndef barrier_data
+# define barrier_data(ptr) barrier()
+#endif
+
 /* Unreachable code */
 #ifndef unreachable
 # define unreachable() do { } while (1)
diff --git a/lib/string.c b/lib/string.c
index 8e8a2e9e9522..de4bf3778958 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -699,7 +699,7 @@ EXPORT_SYMBOL(memset);
 void memzero_explicit(void *s, size_t count)
 {
 	memset(s, 0, count);
-	barrier();
+	barrier_data(s);
 }
 EXPORT_SYMBOL(memzero_explicit);
 
-- 
2.17.1



