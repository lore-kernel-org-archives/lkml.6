Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5410C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADFD241BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rD6yPOro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADFD241BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753469AbeGEClx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:41:53 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:44282 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753430AbeGEClt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:41:49 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w652duZh028145;
        Thu, 5 Jul 2018 11:40:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w652duZh028145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530758405;
        bh=ff2I2ZXiCD//Ov0MDFFTpaElbwzFiTPXI1cCDc6X+Vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rD6yPOrokJFMl6tCmwQzlSYzzrbcN4XgTmcO7vLDqFnrsxIhfU4a0jjfPEfYk+VGa
         IQcJao70r76VRLQH+zvCg74Vpe1wsJ6Era6blWG7w8DP+Ashqmk302QN9PNa8fyEbR
         EQuJVSeAEfgYrAkCIwdNnqwZXgrBU0s6fc6C0mG/GLD+LXDNmQDtIaxlYS1lyHSmS8
         tLT6Xb0GUTELQ0AiI6TyBt/AiVD1xIW5UmcQWGxCFXhtTAWe9XMJFCoUA4haTnVB7e
         JFUHcTTa0rsE5kiqldt5w5iBr1wN8SnZunHYlvXP3xejsTaVHV8Xuf/d8k59o1s09d
         OQq0qEeBq/1VA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/12] kbuild: remove auto.conf and tristate.conf from prerequisites
Date:   Thu,  5 Jul 2018 11:39:48 +0900
Message-Id: <1530758389-30862-12-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The top-level Makefile adds include/config/auto.conf as
prerequisites of 'scripts', 'prepare1', etc.

They were needed to terminate the build when include/config/auto.conf
is missing.

Now that the inclusion of include/config/auto.conf is mandatory
in the top-level Makefile if dot-config is 1 (Note 'include' directive
is used instead of '-include').

Make terminates the build by itself if it fails to create or update
include/config/auto.conf so we are sure that include/config/auto.conf
exists in the very first stage of make.

We do not have to explicitly list include/config/auto.conf as
prerequisites any more.

include/config/tristate.conf is generated as a side-effect of
syncconfig; if auto.conf exists, tristate.conf exists as well
(unless a user does 'rm include/config/tristate.conf')

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index c258937..c6ab38c4 100644
--- a/Makefile
+++ b/Makefile
@@ -649,10 +649,6 @@ include/config/auto.conf:
 	/bin/false)
 
 endif # may-sync-config
-
-else
-# Dummy target needed, because used as prerequisite
-include/config/auto.conf: ;
 endif # $(dot-config)
 
 KBUILD_CFLAGS	+= $(call cc-option,-fno-delete-null-pointer-checks,)
@@ -1047,15 +1043,14 @@ define filechk_kernel.release
 endef
 
 # Store (new) KERNELRELEASE string in include/config/kernel.release
-include/config/kernel.release: include/config/auto.conf FORCE
+include/config/kernel.release: $(srctree)/Makefile FORCE
 	$(call filechk,kernel.release)
 
 # Additional helpers built in scripts/
 # Carefully list dependencies so we do not try to build scripts twice
 # in parallel
 PHONY += scripts
-scripts: scripts_basic include/config/auto.conf include/config/tristate.conf \
-	 asm-generic gcc-plugins $(autoksyms_h)
+scripts: scripts_basic asm-generic gcc-plugins $(autoksyms_h)
 	$(Q)$(MAKE) $(build)=$(@)
 
 # Things we need to do before we recursively start building the kernel
@@ -1085,8 +1080,7 @@ endif
 # that need to depend on updated CONFIG_* values can be checked here.
 prepare2: prepare3 outputmakefile asm-generic
 
-prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h \
-                   include/config/auto.conf
+prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h
 	$(cmd_crmodverdir)
 
 archprepare: archheaders archscripts prepare1 scripts_basic
@@ -1224,7 +1218,7 @@ modules: $(vmlinux-dirs) $(if $(KBUILD_BUILTIN),vmlinux) modules.builtin
 modules.builtin: $(vmlinux-dirs:%=%/modules.builtin)
 	$(Q)$(AWK) '!x[$$0]++' $^ > $(objtree)/modules.builtin
 
-%/modules.builtin: include/config/auto.conf
+%/modules.builtin:
 	$(Q)$(MAKE) $(modbuiltin)=$*
 
 
-- 
2.7.4

