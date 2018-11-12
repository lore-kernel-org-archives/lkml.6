Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA509C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776C022506
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776C022506
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbeKMIPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:15:07 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:41305 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730567AbeKMIPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:15:05 -0500
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 12 Nov 2018 14:19:31 -0800
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id C5CEE40617;
        Mon, 12 Nov 2018 14:19:56 -0800 (PST)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH 1/2] Makefile: Fix distcc compilation with x86 macros
Date:   Mon, 12 Nov 2018 07:02:14 -0800
Message-ID: <20181112150215.508-2-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181112150215.508-1-namit@vmware.com>
References: <20181112150215.508-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing the use of asm macros in c-code broke distcc, since it only
sends the preprocessed source file. The solution is to break the
compilation into two separate phases of compilation and assembly, and
between the two concatanate the assembly macros and the compiled (yet
not assembled) source file. Since this is less efficient, this
compilation mode is only used when make is called with the "DISTCC=y"
parameter.

Note that the assembly stage should also be distributed, if distcc is
configured using "CFLAGS=-DENABLE_REMOTE_ASSEMBLE".

Reported-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 Makefile               |  4 +++-
 arch/x86/Makefile      |  7 +++++--
 scripts/Makefile.build | 29 +++++++++++++++++++++++++++--
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 9fce8b91c15f..c07349fc38c7 100644
--- a/Makefile
+++ b/Makefile
@@ -743,7 +743,9 @@ KBUILD_CFLAGS   += $(call cc-option, -gsplit-dwarf, -g)
 else
 KBUILD_CFLAGS	+= -g
 endif
-KBUILD_AFLAGS	+= -Wa,-gdwarf-2
+AFLAGS_DEBUG_INFO = -Wa,-gdwarf-2
+export AFLAGS_DEBUG_INFO
+KBUILD_AFLAGS	+= $(AFLAGS_DEBUG_INFO)
 endif
 ifdef CONFIG_DEBUG_INFO_DWARF4
 KBUILD_CFLAGS	+= $(call cc-option, -gdwarf-4,)
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f5d7f4134524..b5953cbcc9c8 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -235,10 +235,13 @@ archscripts: scripts_basic
 archheaders:
 	$(Q)$(MAKE) $(build)=arch/x86/entry/syscalls all
 
+ASM_MACRO_FILE = arch/x86/kernel/macros.s
+export ASM_MACRO_FILE
+
 archmacros:
-	$(Q)$(MAKE) $(build)=arch/x86/kernel arch/x86/kernel/macros.s
+	$(Q)$(MAKE) $(build)=arch/x86/kernel $(ASM_MACRO_FILE)
 
-ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s
+ASM_MACRO_FLAGS = -Wa,$(ASM_MACRO_FILE)
 export ASM_MACRO_FLAGS
 KBUILD_CFLAGS += $(ASM_MACRO_FLAGS)
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 6a6be9f440cf..d2213b041408 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -155,8 +155,33 @@ $(obj)/%.ll: $(src)/%.c FORCE
 
 quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
 
+# If distcc is used, then when an assembly macro files is needed, the
+# compilation stage and the assembly stage need to be separated. Providing
+# "DISTCC=y" option enables the separate compilation and assembly.
+cmd_cc_o_c_direct = $(CC) $(c_flags) -c -o $(1) $<
+
+ifeq ($(DISTCC),y)
+a_flags_no_debug = $(filter-out $(AFLAGS_DEBUG_INFO), $(a_flags))
+c_flags_no_macros = $(filter-out $(ASM_MACRO_FLAGS), $(c_flags))
+
+cmd_cc_o_c_two_steps =							\
+	$(CC) $(c_flags_no_macros) $(DISABLE_LTO) -fverbose-asm -S 	\
+		-o $(@D)/.$(@F:.o=.s) $< ;				\
+	cat $(ASM_MACRO_FILE) $(@D)/.$(@F:.o=.s) > 			\
+		$(@D)/.tmp_$(@F:.o=.s);					\
+	$(CC) $(a_flags_no_debug) -c -o $(1) $(@D)/.tmp_$(@F:.o=.s) ; 	\
+	rm -f $(@D)/.$(@F:.o=.s) $(@D)/.tmp_$(@F:.o=.s)			\
+
+cmd_cc_o_c_helper =    							\
+	$(if $(findstring $(ASM_MACRO_FLAGS),$(c_flags)),		\
+		$(call cmd_cc_o_c_two_steps, $(1)),			\
+		$(call cmd_cc_o_c_direct, $(1)))
+else
+cmd_cc_o_c_helper = $(call cmd_cc_o_c_direct, $(1))
+endif
+
 ifndef CONFIG_MODVERSIONS
-cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
+cmd_cc_o_c = $(call cmd_cc_o_c_helper,$@)
 
 else
 # When module versioning is enabled the following steps are executed:
@@ -171,7 +196,7 @@ else
 #   replace the unresolved symbols __crc_exported_symbol with
 #   the actual value of the checksum generated by genksyms
 
-cmd_cc_o_c = $(CC) $(c_flags) -c -o $(@D)/.tmp_$(@F) $<
+cmd_cc_o_c = $(call cmd_cc_o_c_helper,$(@D)/.tmp_$(@F))
 
 cmd_modversions_c =								\
 	if $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then		\
-- 
2.17.1

