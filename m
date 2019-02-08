Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D7FC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD6E217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfBHPKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:10:14 -0500
Received: from verein.lst.de ([213.95.11.211]:42858 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfBHPKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:10:12 -0500
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 0807668DD3; Fri,  8 Feb 2019 16:10:11 +0100 (CET)
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
        live-patching@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH v8 2/5] arm64: replace -pg with CC_FLAGS_FTRACE in efi Makefiles
In-Reply-To: <20190208150826.44EBC68DD2@newverein.lst.de>
References: <20190208150826.44EBC68DD2@newverein.lst.de>
Message-Id: <20190208151011.0807668DD3@newverein.lst.de>
Date:   Fri,  8 Feb 2019 16:10:11 +0100 (CET)
From:   duwe@lst.de (Torsten Duwe)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  In preparation for arm64 supporting ftrace built on other compiler
  options, let's have makefiles remove the $(CC_FLAGS_FTRACE)
  flags, whatever these may be, rather than assuming '-pg'.
  While at it, fix arm32 as well.

  There should be no functional change as a result of this patch.

Signed-off-by: Torsten Duwe <duwe@suse.de>

---
 drivers/firmware/efi/libstub/Makefile |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -16,9 +16,9 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__K
 
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
-cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie \
-				   $(DISABLE_STACKLEAK_PLUGIN)
-cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
+cflags-$(CONFIG_ARM64)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
+				   -fpie $(DISABLE_STACKLEAK_PLUGIN)
+cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
 
