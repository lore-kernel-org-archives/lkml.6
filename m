Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5221EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954DA20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="eqQBQSAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954DA20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeK2PBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 10:01:07 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:35511 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbeK2PBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 10:01:06 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wAT3uW9g014059;
        Thu, 29 Nov 2018 12:56:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wAT3uW9g014059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543463793;
        bh=C1hzWf0P6ycjbnjTosvtbL7ps9IpR2XwGwVlhQ054q0=;
        h=From:To:Cc:Subject:Date:From;
        b=eqQBQSAjitC5AfO7C+zE61yDjZWaDlKwP6obMEzDeqWN1c0PW5splXkW3rW8ivY9a
         YHCbKMaxnqTbLotRumMl2mHT58x3BDgBz7UwCVAkIZESBhV5CL49mbVdU341hVhKiU
         ALoIs+gsuXxdKbMftvJaPGSOfCMnqOCgVdBZswG/vb1aSn1U/VF6wGbzmhROz0pvmn
         NR2KitABK5NRDnJ1z9hXaGv3FZZVWc+0i6VL6LkF4aZMx/dTZzbodhxVbUh8UXn0EY
         Pu2Q3mE0Mf9nLQg0HhnNfaAq4e58Lg7ox5Oy2pyY1vrXGP7DkXpeAIelIP2mtN95T6
         3P1raVRO6GanA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] kbuild: make 'archprepare' depend on 'scripts'
Date:   Thu, 29 Nov 2018 12:56:30 +0900
Message-Id: <1543463791-18391-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before start descending, Kbuild needs to run 'prepare' and 'scripts',
which has been orthogonal to each other.

Going forward, let's consider 'scripts' is a part of the preparation.
This will allow more cleanups.

Move 'scripts' to the prerequisite of 'archprepare', where UML starts
compiling target *.c files.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - It turned out UML + CONFIG_GCC_PLUGINS is broken for a long time.
    https://patchwork.kernel.org/patch/10703853/
    Rebased on the top of the fix-up

 Makefile | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index f7cc3ee..9eb3f4f 100644
--- a/Makefile
+++ b/Makefile
@@ -1062,7 +1062,7 @@ $(sort $(vmlinux-deps)): $(vmlinux-dirs) ;
 # Error messages still appears in the original language
 
 PHONY += $(vmlinux-dirs)
-$(vmlinux-dirs): prepare scripts
+$(vmlinux-dirs): prepare
 	$(Q)$(MAKE) $(build)=$@ need-builtin=1
 
 define filechk_kernel.release
@@ -1112,7 +1112,7 @@ prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h
 
 macroprepare: prepare1 archmacros
 
-archprepare: archheaders archscripts macroprepare scripts_basic gcc-plugins
+archprepare: archheaders archscripts macroprepare scripts gcc-plugins
 
 prepare0: archprepare
 	$(Q)$(MAKE) $(build)=scripts/mod
@@ -1286,7 +1286,7 @@ modules.builtin: $(vmlinux-dirs:%=%/modules.builtin)
 
 # Target to prepare building external modules
 PHONY += modules_prepare
-modules_prepare: prepare scripts
+modules_prepare: prepare
 
 # Target to install modules
 PHONY += modules_install
@@ -1604,11 +1604,9 @@ help:
 	@echo  '  clean           - remove generated files in module directory only'
 	@echo  ''
 
-# Dummies...
-PHONY += prepare scripts
+PHONY += prepare
 prepare:
 	$(cmd_crmodverdir)
-scripts: ;
 endif # KBUILD_EXTMOD
 
 clean: $(clean-dirs)
@@ -1712,33 +1710,33 @@ else
         target-dir = $(if $(KBUILD_EXTMOD),$(dir $<),$(dir $@))
 endif
 
-%.s: %.c prepare scripts FORCE
+%.s: %.c prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.i: %.c prepare scripts FORCE
+%.i: %.c prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.o: %.c prepare scripts FORCE
+%.o: %.c prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.lst: %.c prepare scripts FORCE
+%.lst: %.c prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.s: %.S prepare scripts FORCE
+%.s: %.S prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.o: %.S prepare scripts FORCE
+%.o: %.S prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.symtypes: %.c prepare scripts FORCE
+%.symtypes: %.c prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.ll: %.c prepare scripts FORCE
+%.ll: %.c prepare FORCE
 	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
 
 # Modules
-/: prepare scripts FORCE
+/: prepare FORCE
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
 	$(build)=$(build-dir)
 # Make sure the latest headers are built for Documentation
 Documentation/ samples/: headers_install
-%/: prepare scripts FORCE
+%/: prepare FORCE
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
 	$(build)=$(build-dir)
-%.ko: prepare scripts FORCE
+%.ko: prepare FORCE
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1)   \
 	$(build)=$(build-dir) $(@:.ko=.o)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
-- 
2.7.4

