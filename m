Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA17C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894C52151B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngEUyN85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894C52151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbeLDLES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:04:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbeLDLEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:04:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B222E214F1;
        Tue,  4 Dec 2018 11:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921454;
        bh=vAG3HuiIfZRBGBJRr83YFDycq/jxzhj/P0xNPzo8nT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ngEUyN85G+Rbq1Wdc+7pLN1tuXJfbCRCf7sIvxUuML4gNg+MkrcWlA5fgQo4HSsjW
         N/wM5Q3WhyvyAcAbRSJxTI/FxljNK97/iVz5AVvCSbEmI/1SLvJOxwGNm9NkgvWdyQ
         Tyy8vo6ctgs/ylV7ROsQN8fYTClzCo37cWL7NR4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Borislav Petkov <bp@suse.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        srinivas.eeda@oracle.com
Subject: [PATCH 4.14 078/146] x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support
Date:   Tue,  4 Dec 2018 11:49:24 +0100
Message-Id: <20181204103729.971223628@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhenzhong Duan zhenzhong.duan@oracle.com

commit 4cd24de3a0980bf3100c9dcb08ef65ca7c31af48 upstream

Since retpoline capable compilers are widely available, make
CONFIG_RETPOLINE hard depend on the compiler capability.

Break the build when CONFIG_RETPOLINE is enabled and the compiler does not
support it. Emit an error message in that case:

 "arch/x86/Makefile:226: *** You are building kernel with non-retpoline
  compiler, please update your compiler..  Stop."

[dwmw: Fail the build with non-retpoline compiler]

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Borislav Petkov <bp@suse.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: <srinivas.eeda@oracle.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/cca0cb20-f9e2-4094-840b-fb0f8810cd34@default
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/Kconfig                     |    4 ----
 arch/x86/Makefile                    |    5 +++--
 arch/x86/include/asm/nospec-branch.h |   10 ++++++----
 arch/x86/kernel/cpu/bugs.c           |    2 +-
 scripts/Makefile.build               |    2 --
 5 files changed, 10 insertions(+), 13 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -440,10 +440,6 @@ config RETPOLINE
 	  branches. Requires a compiler with -mindirect-branch=thunk-extern
 	  support for full protection. The kernel may run slower.
 
-	  Without compiler support, at least indirect branches in assembler
-	  code are eliminated. Since this includes the syscall entry path,
-	  it is not entirely pointless.
-
 config INTEL_RDT
 	bool "Intel Resource Director Technology support"
 	default n
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -241,9 +241,10 @@ KBUILD_CFLAGS += -fno-asynchronous-unwin
 
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
-ifneq ($(RETPOLINE_CFLAGS),)
-  KBUILD_CFLAGS += $(RETPOLINE_CFLAGS) -DRETPOLINE
+ifeq ($(RETPOLINE_CFLAGS),)
+  $(error You are building kernel with non-retpoline compiler, please update your compiler.)
 endif
+  KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
 endif
 
 archscripts: scripts_basic
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -162,11 +162,12 @@
 	_ASM_PTR " 999b\n\t"					\
 	".popsection\n\t"
 
-#if defined(CONFIG_X86_64) && defined(RETPOLINE)
+#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_X86_64
 
 /*
- * Since the inline asm uses the %V modifier which is only in newer GCC,
- * the 64-bit one is dependent on RETPOLINE not CONFIG_RETPOLINE.
+ * Inline asm uses the %V modifier which is only in newer GCC
+ * which is ensured when CONFIG_RETPOLINE is defined.
  */
 # define CALL_NOSPEC						\
 	ANNOTATE_NOSPEC_ALTERNATIVE				\
@@ -181,7 +182,7 @@
 	X86_FEATURE_RETPOLINE_AMD)
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 
-#elif defined(CONFIG_X86_32) && defined(CONFIG_RETPOLINE)
+#else /* CONFIG_X86_32 */
 /*
  * For i386 we use the original ret-equivalent retpoline, because
  * otherwise we'll run out of registers. We don't care about CET
@@ -211,6 +212,7 @@
 	X86_FEATURE_RETPOLINE_AMD)
 
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
+#endif
 #else /* No retpoline for C / inline asm */
 # define CALL_NOSPEC "call *%[thunk_target]\n"
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -251,7 +251,7 @@ static void __init spec2_print_if_secure
 
 static inline bool retp_compiler(void)
 {
-	return __is_defined(RETPOLINE);
+	return __is_defined(CONFIG_RETPOLINE);
 }
 
 static inline bool match_option(const char *arg, int arglen, const char *opt)
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -272,10 +272,8 @@ else
 objtool_args += $(call cc-ifversion, -lt, 0405, --no-unreachable)
 endif
 ifdef CONFIG_RETPOLINE
-ifneq ($(RETPOLINE_CFLAGS),)
   objtool_args += --retpoline
 endif
-endif
 
 
 ifdef CONFIG_MODVERSIONS


