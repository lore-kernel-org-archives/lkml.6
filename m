Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D0EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E5D2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="neO7xi8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E5D2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbeJYWxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729488AbeJYWxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:41 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C99612085B;
        Thu, 25 Oct 2018 14:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477242;
        bh=gcsCV2QfUVXOiJX/Mol1NAyCX2Eh0FHnWXPs6s0Db+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neO7xi8I3I/yIshFdu4uLcdMnmDJdTsB+rWv8ljzLzPPZB/Frr0xi/Zaz4hQGgUBK
         VEfuloyRBC+4xLg/4nzSqbUv4vMIpw7zrN4/8HrsqY0cG9W5RytbsHdriyZSFQmSC3
         /FTqIjwaQplzakN1CFN7gDGw2XkZlzL+wC9O1oJs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Theodore Ts'o <tytso@mit.edu>,
        Stephan Mueller <smueller@chronox.de>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        mancha security <mancha1@zoho.com>,
        Mark Charlebois <charlebm@gmail.com>,
        Behan Webster <behanw@converseincode.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 71/98] lib: make memzero_explicit more robust against dead store elimination
Date:   Thu, 25 Oct 2018 10:18:26 -0400
Message-Id: <20181025141853.214051-71-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

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

