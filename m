Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9492C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645D620844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zF8CJD0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645D620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeGYG2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 02:28:12 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:28719 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbeGYG2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 02:28:12 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w6P5Gs8I018750;
        Wed, 25 Jul 2018 14:16:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w6P5Gs8I018750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532495816;
        bh=s8GyG+1gOk1oIIEW6Ve60Hw/YCvJwi+om/gh+CBcOWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zF8CJD0o5DRHJoSUgoL6FnAUaW5sBhK8lEnXpEVCCkmX5fabkJ/qJr9l6gCiZx9q6
         u0htOgo1C91rWuICrSZd3uUlo55C80CpfZD+2paRZMW41rREjjHFlvGElX1tcbhBY+
         9RbDszAX2AVKTiT+Enep6tNga0SYhdgLh1p6SIt5tYhDi4dCplHhZZxJs4wmWMeUsj
         if4wETihFKNexwy5TdcAM+V9YmzVglt5ZrFPBBmppsMOSeSG36Enx/JyXMpFealmgl
         4iJr54BOCu68l9jBpjOb+VnB9zbahWh3scdLEe5op2X2m5Cz/iZ/qMPjWmMGqX/xHy
         +HelxWXRk/wWw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Richard Weinberger <richard@nod.at>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jeff Dike <jdike@addtoit.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 2/2] kbuild: do not redirect the first prerequisite for filechk
Date:   Wed, 25 Jul 2018 14:16:11 +0900
Message-Id: <1532495771-10255-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532495771-10255-1-git-send-email-yamada.masahiro@socionext.com>
References: <1532495771-10255-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, filechk unconditionally opens the first prerequisite and
redirects it as the stdin of a filechk_* rule.  Hence, every target
using $(call filechk,...) must list something as the first prerequisite
even if it is unneeded.

'< $<' is actually unneeded in most cases.  Each rule can explicitly
adds it if necessary.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                           | 2 +-
 arch/s390/kernel/syscalls/Makefile | 6 +++---
 arch/um/Makefile                   | 2 +-
 scripts/Kbuild.include             | 2 +-
 scripts/Makefile.lib               | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 67d9d20..af863f1 100644
--- a/Makefile
+++ b/Makefile
@@ -1116,7 +1116,7 @@ define filechk_version.h
 	echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))';)
 endef
 
-$(version_h): $(srctree)/Makefile FORCE
+$(version_h): FORCE
 	$(call filechk,version.h)
 	$(Q)rm -f $(old_version_h)
 
diff --git a/arch/s390/kernel/syscalls/Makefile b/arch/s390/kernel/syscalls/Makefile
index 8ff96c0..4d929ed 100644
--- a/arch/s390/kernel/syscalls/Makefile
+++ b/arch/s390/kernel/syscalls/Makefile
@@ -25,15 +25,15 @@ _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)') \
 	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
 
 define filechk_syshdr
-	$(CONFIG_SHELL) '$(systbl)' -H -a $(syshdr_abi_$(basetarget)) -f "$2"
+	$(CONFIG_SHELL) '$(systbl)' -H -a $(syshdr_abi_$(basetarget)) -f "$2" < $<
 endef
 
 define filechk_sysnr
-	$(CONFIG_SHELL) '$(systbl)' -N -a $(sysnr_abi_$(basetarget))
+	$(CONFIG_SHELL) '$(systbl)' -N -a $(sysnr_abi_$(basetarget)) < $<
 endef
 
 define filechk_syscalls
-	$(CONFIG_SHELL) '$(systbl)' -S
+	$(CONFIG_SHELL) '$(systbl)' -S < $<
 endef
 
 syshdr_abi_unistd_32 := common,32
diff --git a/arch/um/Makefile b/arch/um/Makefile
index e54dda8..8c35261 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -169,7 +169,7 @@ define filechk_gen-asm-offsets
          echo " *"; \
          echo " */"; \
          echo ""; \
-         sed -ne "/^->/{s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}"; \
+         sed -ne "/^->/{s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}" < $<; \
          echo ""; )
 endef
 
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 86321f0..0bee89c 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -56,7 +56,7 @@ kecho := $($(quiet)kecho)
 define filechk
 	$(Q)set -e;				\
 	mkdir -p $(dir $@);			\
-	$(filechk_$(1)) < $< > $@.tmp;		\
+	$(filechk_$(1)) > $@.tmp;		\
 	if [ -r $@ ] && cmp -s $@ $@.tmp; then	\
 		rm -f $@.tmp;			\
 	else					\
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1bb594f..4b2f89f 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -416,7 +416,7 @@ define filechk_offsets
 	 echo " * This file was generated by Kbuild"; \
 	 echo " */"; \
 	 echo ""; \
-	 sed -ne $(sed-offsets); \
+	 sed -ne $(sed-offsets) < $<; \
 	 echo ""; \
 	 echo "#endif" )
 endef
-- 
2.7.4

