Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFD1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 04:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305F420685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 04:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1HjJs/1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305F420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393207AbeKWPeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 10:34:20 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:48170 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbeKWPeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 10:34:20 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id wAN4pTNM020182;
        Fri, 23 Nov 2018 13:51:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com wAN4pTNM020182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542948689;
        bh=dOs9bDoO5WsxGBpwTJjGsltucWemOPc7mrzxRG/Ehnc=;
        h=From:To:Cc:Subject:Date:From;
        b=1HjJs/1wyjGni0ShlOn6fBLgUbJV/NCtILmQjzNujlVLwb6vbcpz/s6QOhZ4TuUGD
         eE+OSNSdnruBNxAmUD/s8SXhpT3dtWNFWnsvVZmbP/98y30R3e+cOwKnpA9Ha81xJJ
         a55uanI437JNgHwWyoOtdmV6gDDMttcdFCA1CVLY7k4OGcio6JNMyXOlXQwWw3jFCf
         i/tpaZqYygbOIxPiznzVZ/mSkmB23cCGh48s1qi4H0kPCjku2lwutpsqH1/ZSwdQnB
         qVtkpFmjrlSdIMH6FZOpzBKgO1q/w9clr0f3qRbIZ1JKP4Biq+L4fBVZsaVbVBJlBE
         mCHXrMx7XQVng==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kbuild: make 'scripts' depend on 'prepare0'
Date:   Fri, 23 Nov 2018 13:51:26 +0900
Message-Id: <1542948687-7326-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before start descending, Kbuild needs to run 'prepare' and 'scripts',
which were orthogonal to each other prior to this commit.

Let's consider 'scripts' is a part of the preparation. This will allow
more cleanups.

Move 'scripts' to the prerequisite of 'prepare0', which starts compiling
target *.c files.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index 36f3f0e..cee4cec 100644
--- a/Makefile
+++ b/Makefile
@@ -1062,7 +1062,7 @@ $(sort $(vmlinux-deps)): $(vmlinux-dirs) ;
 # Error messages still appears in the original language
 
 PHONY += $(vmlinux-dirs)
-$(vmlinux-dirs): prepare scripts
+$(vmlinux-dirs): prepare
 	$(Q)$(MAKE) $(build)=$@ need-builtin=1
 
 define filechk_kernel.release
@@ -1114,7 +1114,7 @@ macroprepare: prepare1 archmacros
 
 archprepare: archheaders archscripts macroprepare scripts_basic
 
-prepare0: archprepare gcc-plugins
+prepare0: scripts archprepare gcc-plugins
 	$(Q)$(MAKE) $(build)=scripts/mod
 	$(Q)$(MAKE) $(build)=.
 
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

