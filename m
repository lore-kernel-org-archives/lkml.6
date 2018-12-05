Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D492C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9118F20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="w9S4OUbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9118F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeLEL3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:29:12 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:57972 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbeLEL3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:29:11 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wB5BSBlV028064;
        Wed, 5 Dec 2018 20:28:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wB5BSBlV028064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544009292;
        bh=sWyas4YPx7Kc+mWtxj9UKPr4KlAhoGwLASCZp+3wZhU=;
        h=From:To:Cc:Subject:Date:From;
        b=w9S4OUbL7uO43hdC0S5b/isieGpBRChmF2XR3C5LWA5ongMKo1Egv23tDOrWEglsA
         T0G7r7k1uOn0AzftSYsEJk0Gmyw7yvak7t97CLQIEIPpF3/IQBI/yTQw0Aoj/I3Jwc
         m0wK8qvkG+Ug6KHxoLtnFlgxolvu+Kr5nhm6Ewsynifn367SuyIz0i3U1RJrry36KV
         oKApaiNcv4Nc5bgItsFJLZ8yNMEcuUz2lH77Bou6W5QNu3Fg2UbtRKNtCAwvJDAlfC
         E6yD0rC+8ji0kyqfDYZ8scdEMgLdCcO1BshvYncuXyxlm1miohYHcM4dId3MxZIHfC
         t49OPVTaiTT3Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kbuild: refactor Makefile.asm-generic
Date:   Wed,  5 Dec 2018 20:28:04 +0900
Message-Id: <1544009286-15705-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Use conventional $(MAKE) $(asm-generic)=<dir> style
   for directory descending

 - Remove unneeded FORCE since "all" is a phony target

 - Remove unneeded "_dummy :=" assignment

 - Skip $(shell mkdir ...) when headers exist in the directory

 - Misc cleanups

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                     |  8 ++++----
 scripts/Makefile.asm-generic | 37 +++++++++++++++++++------------------
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index ab38eb2..3af0379 100644
--- a/Makefile
+++ b/Makefile
@@ -1122,13 +1122,13 @@ prepare0: archprepare
 prepare: prepare0 prepare-objtool
 
 # Support for using generic headers in asm-generic
+asm-generic := -f $(srctree)/scripts/Makefile.asm-generic obj
+
 PHONY += asm-generic uapi-asm-generic
 asm-generic: uapi-asm-generic
-	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
-	            src=asm obj=arch/$(SRCARCH)/include/generated/asm
+	$(Q)$(MAKE) $(asm-generic)=arch/$(SRCARCH)/include/generated/asm
 uapi-asm-generic:
-	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
-	            src=uapi/asm obj=arch/$(SRCARCH)/include/generated/uapi/asm
+	$(Q)$(MAKE) $(asm-generic)=arch/$(SRCARCH)/include/generated/uapi/asm
 
 PHONY += prepare-objtool
 prepare-objtool: $(objtool_target)
diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generic
index 32ad8e9..760323e 100644
--- a/scripts/Makefile.asm-generic
+++ b/scripts/Makefile.asm-generic
@@ -2,41 +2,42 @@
 # include/asm-generic contains a lot of files that are used
 # verbatim by several architectures.
 #
-# This Makefile reads the file arch/$(SRCARCH)/include/$(src)/Kbuild
+# This Makefile reads the file arch/$(SRCARCH)/include/(uapi/)/asm/Kbuild
 # and for each file listed in this file with generic-y creates
-# a small wrapper file in $(obj) (arch/$(SRCARCH)/include/generated/$(src))
+# a small wrapper file in arch/$(SRCARCH)/include/generated/(uapi/)/asm.
 
 PHONY := all
 all:
 
-kbuild-file := $(srctree)/arch/$(SRCARCH)/include/$(src)/Kbuild
--include $(kbuild-file)
+src := $(subst /generated,,$(obj))
+-include $(src)/Kbuild
 
 include scripts/Kbuild.include
 
-# Create output directory if not already present
-_dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))
+generic-y   := $(addprefix $(obj)/, $(generic-y))
+generated-y := $(addprefix $(obj)/, $(generated-y))
 
-# Stale wrappers when the corresponding files are removed from generic-y
-# need removing.
-generated-y   := $(generic-y) $(generated-y)
-all-files     := $(patsubst %, $(obj)/%, $(generated-y))
-old-headers   := $(wildcard $(obj)/*.h)
-unwanted      := $(filter-out $(all-files),$(old-headers))
+# Remove stale wrappers when the corresponding files are removed from generic-y
+old-headers := $(wildcard $(obj)/*.h)
+unwanted    := $(filter-out $(generic-y) $(generated-y),$(old-headers))
 
 quiet_cmd_wrap = WRAP    $@
-cmd_wrap = echo "\#include <asm-generic/$*.h>" >$@
+      cmd_wrap = echo "\#include <asm-generic/$*.h>" > $@
 
 quiet_cmd_remove = REMOVE  $(unwanted)
-cmd_remove = rm -f $(unwanted)
+      cmd_remove = rm -f $(unwanted)
 
-all: $(patsubst %, $(obj)/%, $(generic-y)) FORCE
-	$(if $(unwanted),$(call cmd,remove),)
+all: $(generic-y)
+	$(if $(unwanted),$(call cmd,remove))
 	@:
 
 $(obj)/%.h:
 	$(call cmd,wrap)
 
-PHONY += FORCE
+# Create output directory. Skip it if at least one old header exists
+# since we know the output directory already exists.
+ifeq ($(old-headers),)
+$(shell mkdir -p $(obj))
+endif
+
 .PHONY: $(PHONY)
-FORCE: ;
-- 
2.7.4

