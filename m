Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id k8A+ApyZHVswEQAAmS7hNA
	; Sun, 10 Jun 2018 21:36:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C27B1606FA; Sun, 10 Jun 2018 21:36:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=2.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	MAILING_LIST_MULTI autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 374D060791;
	Sun, 10 Jun 2018 21:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 374D060791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932430AbeFJVgA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 17:36:00 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:16964 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753345AbeFJVeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 17:34:07 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Sun, 10 Jun 2018 14:33:44 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id E2D0A406F6;
        Sun, 10 Jun 2018 14:34:05 -0700 (PDT)
From: Nadav Amit <namit@vmware.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Nadav Amit <namit@vmware.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kbuild@vger.kernel.org>
Subject: [PATCH v3 1/9] Makefile: Prepare for using macros for inline asm
Date: Sun, 10 Jun 2018 07:19:03 -0700
Message-ID: <20180610141911.52948-2-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180610141911.52948-1-namit@vmware.com>
References: <20180610141911.52948-1-namit@vmware.com>
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

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-kbuild@vger.kernel.org

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 Makefile                 |  9 +++++++--
 arch/x86/Makefile        | 11 +++++++++--
 arch/x86/kernel/Makefile |  6 ++++++
 arch/x86/kernel/macros.S |  7 +++++++
 scripts/Kbuild.include   |  4 +++-
 5 files changed, 32 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/kernel/macros.S

diff --git a/Makefile b/Makefile
index 554dcaddbce4..026586db2f26 100644
--- a/Makefile
+++ b/Makefile
@@ -1085,7 +1085,7 @@ scripts: scripts_basic include/config/auto.conf include/config/tristate.conf \
 # version.h and scripts_basic is processed / created.
 
 # Listed in dependency order
-PHONY += prepare archprepare prepare0 prepare1 prepare2 prepare3
+PHONY += prepare archprepare macroprepare prepare0 prepare1 prepare2 prepare3
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
@@ -1109,7 +1109,9 @@ prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h \
                    include/config/auto.conf
 	$(cmd_crmodverdir)
 
-archprepare: archheaders archscripts prepare1 scripts_basic
+macroprepare: prepare1 archmacros
+
+archprepare: archheaders archscripts macroprepare scripts_basic
 
 prepare0: archprepare gcc-plugins
 	$(Q)$(MAKE) $(build)=.
@@ -1214,6 +1216,9 @@ archheaders:
 PHONY += archscripts
 archscripts:
 
+PHONY += archmacros
+archmacros:
+
 PHONY += __headers
 __headers: $(version_h) scripts_basic uapi-asm-generic archheaders archscripts
 	$(Q)$(MAKE) $(build)=scripts build_unifdef
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 60135cbd905c..6b82314776fd 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -235,8 +235,8 @@ ifdef CONFIG_X86_64
 LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
 endif
 
-# Speed up the build
-KBUILD_CFLAGS += -pipe
+# We cannot use -pipe flag since we give an additional .s file to the compiler
+#KBUILD_CFLAGS += -pipe
 # Workaround for a gcc prelease that unfortunately was shipped in a suse release
 KBUILD_CFLAGS += -Wno-sign-compare
 #
@@ -258,11 +258,18 @@ archscripts: scripts_basic
 archheaders:
 	$(Q)$(MAKE) $(build)=arch/x86/entry/syscalls all
 
+archmacros:
+	$(Q)$(MAKE) $(build)=arch/x86/kernel macros
+
 archprepare:
 ifeq ($(CONFIG_KEXEC_FILE),y)
 	$(Q)$(MAKE) $(build)=arch/x86/purgatory arch/x86/purgatory/kexec-purgatory.c
 endif
 
+ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s
+export ASM_MACRO_FLAGS
+KBUILD_CFLAGS += $(ASM_MACRO_FLAGS)
+
 ###
 # Kernel objects
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 02d6f5cf4e70..fdb6c5b2a922 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -9,6 +9,12 @@ extra-y	+= ebda.o
 extra-y	+= platform-quirks.o
 extra-y	+= vmlinux.lds
 
+$(obj)/macros.s: $(obj)/macros.S FORCE
+	$(call if_changed_dep,cpp_s_S)
+
+macros: $(obj)/macros.s
+	@:
+
 CPPFLAGS_vmlinux.lds += -U$(UTS_MACHINE)
 
 ifdef CONFIG_FUNCTION_TRACER
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
index 50cee534fd64..ad2c02062aa4 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -189,7 +189,9 @@ __cc-option = $(call try-run-cached,\
 
 # Do not attempt to build with gcc plugins during cc-option tests.
 # (And this uses delayed resolution so the flags will be up to date.)
-CC_OPTION_CFLAGS = $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS))
+# In addition, do not include the asm macros which are built later.
+CC_OPTION_FILTERED = $(GCC_PLUGINS_CFLAGS) $(ASM_MACRO_FLAGS)
+CC_OPTION_CFLAGS = $(filter-out $(CC_OPTION_FILTERED),$(KBUILD_CFLAGS))
 
 # cc-option
 # Usage: cflags-y += $(call cc-option,-march=winchip-c6,-march=i586)
-- 
2.17.0
