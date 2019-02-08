Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1005C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C2420863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfBHPK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:10:27 -0500
Received: from verein.lst.de ([213.95.11.211]:42883 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbfBHPKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:10:25 -0500
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 676A168DEE; Fri,  8 Feb 2019 16:10:24 +0100 (CET)
To:     Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: [PATCH v8 5/5] arm64: use -fpatchable-function-entry if available
In-Reply-To: <20190208150826.44EBC68DD2@newverein.lst.de>
References: <20190208150826.44EBC68DD2@newverein.lst.de>
Message-Id: <20190208151024.676A168DEE@newverein.lst.de>
Date:   Fri,  8 Feb 2019 16:10:24 +0100 (CET)
From:   duwe@lst.de (Torsten Duwe)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test whether gcc supports -fpatchable-function-entry and use it to promote
DYNAMIC_FTRACE to DYNAMIC_FTRACE_WITH_REGS. Amend support for the new
object section that holds the locations (__patchable_function_entries) and
define a proper "notrace" attribute to switch it off.

Signed-off-by: Torsten Duwe <duwe@suse.de>

---
 arch/arm64/Kconfig                |    2 ++
 arch/arm64/Makefile               |    5 +++++
 include/asm-generic/vmlinux.lds.h |    1 +
 include/linux/compiler_types.h    |    2 ++
 kernel/module.c                   |    7 ++++++-
 5 files changed, 16 insertions(+), 1 deletion(-)
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -132,6 +132,8 @@ config ARM64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_REGS \
+		if $(cc-option,-fpatchable-function-entry=2)
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -89,6 +89,11 @@ ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
 KBUILD_LDFLAGS_MODULE	+= -T $(srctree)/arch/arm64/kernel/module.lds
 endif
 
+ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
+  KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FENTRY
+  CC_FLAGS_FTRACE := -fpatchable-function-entry=2
+endif
+
 # Default value
 head-y		:= arch/arm64/kernel/head.o
 
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -113,6 +113,7 @@
 #define MCOUNT_REC()	. = ALIGN(8);				\
 			__start_mcount_loc = .;			\
 			KEEP(*(__mcount_loc))			\
+			KEEP(*(__patchable_function_entries))	\
 			__stop_mcount_loc = .;
 #else
 #define MCOUNT_REC()
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -112,6 +112,8 @@ struct ftrace_likely_data {
 
 #if defined(CC_USING_HOTPATCH)
 #define notrace			__attribute__((hotpatch(0, 0)))
+#elif defined(CC_USING_PATCHABLE_FENTRY)
+#define notrace			__attribute__((patchable_function_entry(0)))
 #else
 #define notrace			__attribute__((__no_instrument_function__))
 #endif
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3122,7 +3122,12 @@ static int find_module_sections(struct m
 #endif
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 	/* sechdrs[0].sh_size is always zero */
-	mod->ftrace_callsites = section_objs(info, "__mcount_loc",
+	mod->ftrace_callsites = section_objs(info,
+#ifdef CC_USING_PATCHABLE_FENTRY
+					     "__patchable_function_entries",
+#else
+					     "__mcount_loc",
+#endif
 					     sizeof(*mod->ftrace_callsites),
 					     &mod->num_ftrace_callsites);
 #endif
