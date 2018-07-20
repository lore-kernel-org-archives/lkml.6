Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B65CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B839320652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ebH61TNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B839320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbeGTIfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:35:39 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:28746 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbeGTIfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:35:09 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w6K7kdj3008048;
        Fri, 20 Jul 2018 16:46:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w6K7kdj3008048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532072806;
        bh=0AEHVsWGTyJTmFv8yz8zN2xealBncVG4ABdemn2CJys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ebH61TNe8HjsZTIoHVQ2ZkzzjIKpmcbxPCf40AEu50t8rSvDMs76Dt6nKniwhOB38
         WO3bLS6C35VQ55BMYbKkIZsMEZriIUTSCMXgw9Ru4xqW0qoB43XA1GMb5OQ865/oya
         4ZHj3R1ZaEtrrro/H/og4efQm0wS/oXZDeV0RHuVm6Go+yWj6HYsyKJWZbUcSTRnoL
         tbuFoDkGl/tMmIYpYysC4fpgZpK6d+PbK0sSNUPeCr0r25sEoxBh9yz5lZw1dOAINw
         9+ajZo5c3L6iW5q4rPmP13AeTzWdbHPvrRUDZ/YAgMmA9a0qnuXi9FiqMI1D//cqF6
         rdad4bdXE1/OA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/11] kbuild: remove auto.conf from prerequisite of phony targets
Date:   Fri, 20 Jul 2018 16:46:36 +0900
Message-Id: <1532072796-7947-12-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
References: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
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

I am still keeping include/config/auto.conf as the prerequisite of
%/modules.builtin because modules.builtin is a real file.  According
to commit a6c366324cac ("kbuild: Do not unnecessarily regenerate
modules.builtin"), it is intentional to compare time-stamps between
%/modules.builtin and include/config/auto.conf .  I moved tristate.conf
here because it is only included from scripts/Makefile.modbuiltin.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4: None

 Makefile | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 0ec1c27..ceb9c1e 100644
--- a/Makefile
+++ b/Makefile
@@ -650,10 +650,6 @@ include/config/auto.conf:
 	/bin/false)
 
 endif # may-sync-config
-
-else
-# Dummy target needed, because used as prerequisite
-include/config/auto.conf: ;
 endif # $(dot-config)
 
 KBUILD_CFLAGS	+= $(call cc-option,-fno-delete-null-pointer-checks,)
@@ -1048,15 +1044,14 @@ define filechk_kernel.release
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
@@ -1086,8 +1081,7 @@ endif
 # that need to depend on updated CONFIG_* values can be checked here.
 prepare2: prepare3 outputmakefile asm-generic
 
-prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h \
-                   include/config/auto.conf
+prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h
 	$(cmd_crmodverdir)
 
 archprepare: archheaders archscripts prepare1 scripts_basic
@@ -1225,7 +1219,7 @@ modules: $(vmlinux-dirs) $(if $(KBUILD_BUILTIN),vmlinux) modules.builtin
 modules.builtin: $(vmlinux-dirs:%=%/modules.builtin)
 	$(Q)$(AWK) '!x[$$0]++' $^ > $(objtree)/modules.builtin
 
-%/modules.builtin: include/config/auto.conf
+%/modules.builtin: include/config/auto.conf include/config/tristate.conf
 	$(Q)$(MAKE) $(modbuiltin)=$*
 
 
-- 
2.7.4

