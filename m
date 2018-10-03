Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAEAC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F665213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F665213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeJDEWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:22:44 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:45001 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbeJDEWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:22:41 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 3 Oct 2018 14:32:25 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 71542407D1;
        Wed,  3 Oct 2018 14:32:32 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kbuild@vger.kernel.org>
Subject: [PATCH v9 02/10] Makefile: Prepare for using macros for inline asm
Date:   Wed, 3 Oct 2018 14:30:52 -0700
Message-ID: <20181003213100.189959-3-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003213100.189959-1-namit@vmware.com>
References: <20181003213100.189959-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using macros for inline assembly improves both readability and
compilation decisions that are distorted by big assembly blocks that use
alternative sections. Compile macros.S and use it to assemble all C
files. Currently, only x86 will use it.

Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-kbuild@vger.kernel.org
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 Makefile                 | 9 +++++++--
 arch/x86/Makefile        | 7 +++++++
 arch/x86/kernel/macros.S | 7 +++++++
 scripts/Kbuild.include   | 4 +++-
 scripts/mod/Makefile     | 2 ++
 5 files changed, 26 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/kernel/macros.S

diff --git a/Makefile b/Makefile
index 6c3da3e10f07..6c40d547513c 100644
--- a/Makefile
+++ b/Makefile
@@ -1071,7 +1071,7 @@ scripts: scripts_basic asm-generic gcc-plugins $(autoksyms_h)
 # version.h and scripts_basic is processed / created.
 
 # Listed in dependency order
-PHONY += prepare archprepare prepare0 prepare1 prepare2 prepare3
+PHONY += prepare archprepare macroprepare prepare0 prepare1 prepare2 prepare3
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
@@ -1094,7 +1094,9 @@ prepare2: prepare3 outputmakefile asm-generic
 prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h
 	$(cmd_crmodverdir)
 
-archprepare: archheaders archscripts prepare1 scripts_basic
+macroprepare: prepare1 archmacros
+
+archprepare: archheaders archscripts macroprepare scripts_basic
 
 prepare0: archprepare gcc-plugins
 	$(Q)$(MAKE) $(build)=.
@@ -1162,6 +1164,9 @@ archheaders:
 PHONY += archscripts
 archscripts:
 
+PHONY += archmacros
+archmacros:
+
 PHONY += __headers
 __headers: $(version_h) scripts_basic uapi-asm-generic archheaders archscripts
 	$(Q)$(MAKE) $(build)=scripts build_unifdef
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 8f6e7eb8ae9f..18a0084f134b 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -237,6 +237,13 @@ archscripts: scripts_basic
 archheaders:
 	$(Q)$(MAKE) $(build)=arch/x86/entry/syscalls all
 
+archmacros:
+	$(Q)$(MAKE) $(build)=arch/x86/kernel arch/x86/kernel/macros.s
+
+ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s -Wa,-
+export ASM_MACRO_FLAGS
+KBUILD_CFLAGS += $(ASM_MACRO_FLAGS)
+
 ###
 # Kernel objects
 
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
new file mode 100644
index 000000000000..cfc1c7d1a6eb
--- /dev/null
+++ b/arch/x86/kernel/macros.S
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This file includes headers whose assembly part includes macros which are
+ * commonly used. The macros are precompiled into assmebly file which is later
+ * assembled together with each compiled file.
+ */
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index ce53639a864a..8aeb60eb6ee3 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -115,7 +115,9 @@ __cc-option = $(call try-run,\
 
 # Do not attempt to build with gcc plugins during cc-option tests.
 # (And this uses delayed resolution so the flags will be up to date.)
-CC_OPTION_CFLAGS = $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS))
+# In addition, do not include the asm macros which are built later.
+CC_OPTION_FILTERED = $(GCC_PLUGINS_CFLAGS) $(ASM_MACRO_FLAGS)
+CC_OPTION_CFLAGS = $(filter-out $(CC_OPTION_FILTERED),$(KBUILD_CFLAGS))
 
 # cc-option
 # Usage: cflags-y += $(call cc-option,-march=winchip-c6,-march=i586)
diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index 42c5d50f2bcc..a5b4af47987a 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -4,6 +4,8 @@ OBJECT_FILES_NON_STANDARD := y
 hostprogs-y	:= modpost mk_elfconfig
 always		:= $(hostprogs-y) empty.o
 
+CFLAGS_REMOVE_empty.o := $(ASM_MACRO_FLAGS)
+
 modpost-objs	:= modpost.o file2alias.o sumversion.o
 
 devicetable-offsets-file := devicetable-offsets.h
-- 
2.17.1

