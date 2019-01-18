Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE64C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33C720823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfARQjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:39:06 -0500
Received: from verein.lst.de ([213.95.11.211]:44660 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbfARQjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:39:05 -0500
Received: by newverein.lst.de (Postfix, from userid 2005)
        id CD7BA68CEB; Fri, 18 Jan 2019 17:39:04 +0100 (CET)
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
Subject: [PATCH v7 1/3] arm64: replace -pg with CC_FLAGS_FTRACE in Makefiles
In-Reply-To: <20190118163736.6A99268CEB@newverein.lst.de>
References: <20190118163736.6A99268CEB@newverein.lst.de>
Message-Id: <20190118163904.CD7BA68CEB@newverein.lst.de>
Date:   Fri, 18 Jan 2019 17:39:04 +0100 (CET)
From:   duwe@lst.de (Torsten Duwe)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ftrace instrumentation might also be introduced by
-fpatchable-function-entry, not only -pg. Ensure the Makefiles are
flexible to filter out the respective flags in "notrace" directories.

Signed-off-by: Torsten Duwe <duwe@suse.de>

---
 arch/arm64/kernel/Makefile            |    6 +++---
 drivers/firmware/efi/libstub/Makefile |    3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -7,9 +7,9 @@ CPPFLAGS_vmlinux.lds	:= -DTEXT_OFFSET=$(
 AFLAGS_head.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_armv8_deprecated.o := -I$(src)
 
-CFLAGS_REMOVE_ftrace.o = -pg
-CFLAGS_REMOVE_insn.o = -pg
-CFLAGS_REMOVE_return_address.o = -pg
+CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_insn.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_return_address.o = $(CC_FLAGS_FTRACE)
 
 # Object file lists.
 obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -16,7 +16,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__K
 
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
-cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie \
+cflags-$(CONFIG_ARM64)		:= $(filter-out $(CC_FLAGS_FTRACE)\
+				  ,$(KBUILD_CFLAGS)) -fpie \
 				   $(DISABLE_STACKLEAK_PLUGIN)
 cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
