Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F4AC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D19820857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zmOzG5fT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D19820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbeKIHgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:36:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:54372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbeKIHgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:45 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C910A2146D;
        Thu,  8 Nov 2018 21:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714356;
        bh=cGq2Fy3Afm86RV/1+0IxhdzedXplWn8GY07j+NxqGpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zmOzG5fTD5Y59QttTx+YfKjcIrFzMHUGmG5xDvBJLIkQCjwdyVIPl3z72j5A2zB92
         aKoGERLIkqzaSbzaK2U6fDcP+Wt+8QAJRm4uqNVVs7oGCI1gstXY7EDc2yZ+pGbucm
         JIaFf+t/MmyKJ2RpOTXpfH+DTuAYeDUrOZ12IazQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 031/114] um: Avoid longjmp/setjmp symbol clashes with libpthread.a
Date:   Thu,  8 Nov 2018 13:50:46 -0800
Message-Id: <20181108215101.898084090@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f44f1e7da7c8e3f4575d5d61c4df978496903fcc ]

Building a statically linked UML kernel on a Centos 6.9 host resulted in
the following linking failure (GCC 4.4, glibc-2.12):

/usr/lib/gcc/x86_64-redhat-linux/4.4.7/../../../../lib64/libpthread.a(libpthread.o):
In function `siglongjmp':
(.text+0x8490): multiple definition of `longjmp'
arch/x86/um/built-in.o:/local/users/fainelli/openwrt/trunk/build_dir/target-x86_64_musl/linux-uml/linux-4.4.69/arch/x86/um/setjmp_64.S:44:
first defined here
/usr/lib/gcc/x86_64-redhat-linux/4.4.7/../../../../lib64/libpthread.a(libpthread.o):
In function `sem_open':
(.text+0x77cd): warning: the use of `mktemp' is dangerous, better use
`mkstemp'
collect2: ld returned 1 exit status
make[4]: *** [vmlinux] Error 1

Adopt a solution similar to the one done for vmap where we define
longjmp/setjmp to be kernel_longjmp/setjmp. In the process, make sure we
do rename the functions in arch/x86/um/setjmp_*.S accordingly.

Fixes: a7df4716d195 ("um: link with -lpthread")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/Makefile        |  4 ++++
 arch/x86/um/setjmp_32.S | 16 ++++++++--------
 arch/x86/um/setjmp_64.S | 16 ++++++++--------
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 9ccf462131c4..d9cd7ed27834 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -59,10 +59,14 @@ KBUILD_CPPFLAGS += -I$(srctree)/$(HOST_DIR)/um
 # Same things for in6addr_loopback and mktime - found in libc. For these two we
 # only get link-time error, luckily.
 #
+# -Dlongjmp=kernel_longjmp prevents anything from referencing the libpthread.a
+# embedded copy of longjmp, same thing for setjmp.
+#
 # These apply to USER_CFLAGS to.
 
 KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
 	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap	\
+	-Dlongjmp=kernel_longjmp -Dsetjmp=kernel_setjmp \
 	-Din6addr_loopback=kernel_in6addr_loopback \
 	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr
 
diff --git a/arch/x86/um/setjmp_32.S b/arch/x86/um/setjmp_32.S
index b766792c9933..39053192918d 100644
--- a/arch/x86/um/setjmp_32.S
+++ b/arch/x86/um/setjmp_32.S
@@ -16,9 +16,9 @@
 
 	.text
 	.align 4
-	.globl setjmp
-	.type setjmp, @function
-setjmp:
+	.globl kernel_setjmp
+	.type kernel_setjmp, @function
+kernel_setjmp:
 #ifdef _REGPARM
 	movl %eax,%edx
 #else
@@ -35,13 +35,13 @@ setjmp:
 	movl %ecx,20(%edx)		# Return address
 	ret
 
-	.size setjmp,.-setjmp
+	.size kernel_setjmp,.-kernel_setjmp
 
 	.text
 	.align 4
-	.globl longjmp
-	.type longjmp, @function
-longjmp:
+	.globl kernel_longjmp
+	.type kernel_longjmp, @function
+kernel_longjmp:
 #ifdef _REGPARM
 	xchgl %eax,%edx
 #else
@@ -55,4 +55,4 @@ longjmp:
 	movl 16(%edx),%edi
 	jmp *20(%edx)
 
-	.size longjmp,.-longjmp
+	.size kernel_longjmp,.-kernel_longjmp
diff --git a/arch/x86/um/setjmp_64.S b/arch/x86/um/setjmp_64.S
index 45f547b4043e..c56942e1a38c 100644
--- a/arch/x86/um/setjmp_64.S
+++ b/arch/x86/um/setjmp_64.S
@@ -18,9 +18,9 @@
 
 	.text
 	.align 4
-	.globl setjmp
-	.type setjmp, @function
-setjmp:
+	.globl kernel_setjmp
+	.type kernel_setjmp, @function
+kernel_setjmp:
 	pop  %rsi			# Return address, and adjust the stack
 	xorl %eax,%eax			# Return value
 	movq %rbx,(%rdi)
@@ -34,13 +34,13 @@ setjmp:
 	movq %rsi,56(%rdi)		# Return address
 	ret
 
-	.size setjmp,.-setjmp
+	.size kernel_setjmp,.-kernel_setjmp
 
 	.text
 	.align 4
-	.globl longjmp
-	.type longjmp, @function
-longjmp:
+	.globl kernel_longjmp
+	.type kernel_longjmp, @function
+kernel_longjmp:
 	movl %esi,%eax			# Return value (int)
 	movq (%rdi),%rbx
 	movq 8(%rdi),%rsp
@@ -51,4 +51,4 @@ longjmp:
 	movq 48(%rdi),%r15
 	jmp *56(%rdi)
 
-	.size longjmp,.-longjmp
+	.size kernel_longjmp,.-kernel_longjmp
-- 
2.17.1



