Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37661ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E995C2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdHtD86u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E995C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeJYWu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729604AbeJYWu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:27 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51DB920840;
        Thu, 25 Oct 2018 14:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477050;
        bh=CFhqkLOipmXrhGSWBtJvetVY7XM5vBP9t3cwtbPkYeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YdHtD86uYYL6hcVApXq6bYBF3cz9wVFuG0WZ/8FP7W5KG2M65R2Rb42P7oyM66b9B
         RfZ9sz6hX2tD/hE6dcwOMs8d7pUPl/wDR1KX0UKu4iY/fk04m+Hm/iOjIkfMdgqqh7
         EjQfKjXnl2lOQ/7PGf3Yj2T2DiLdd2sXmlzHxE4c=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 13/65] um: Avoid longjmp/setjmp symbol clashes with libpthread.a
Date:   Thu, 25 Oct 2018 10:16:13 -0400
Message-Id: <20181025141705.213937-13-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

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

