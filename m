Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7BCC3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956AA24069
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Q94sf+VA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956AA24069
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753462AbeGECoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:44:12 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:43641 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753161AbeGECl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:41:29 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w652duZa028145;
        Thu, 5 Jul 2018 11:40:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w652duZa028145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530758400;
        bh=HVFBWVGPJQGYBwRsydwk7ExoP+uje8PBFhH82UtKbfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q94sf+VA/fxaMDc08NBZSt1NoKwTsc8rxzDoNGZ6eMSrleytShUncfqvaVtK/IaTW
         M4uhXXlA0J0hZEIl14d3sn1wFLf+CuUwEw77kN0cHDcpJYXspgQG/kqJvuutDkjqla
         t7y16SzP8kiTD2VIc/Mv1N1tMTqWwHPk6j5EW6/Cxg/iDfbUmi2+7mELRdQxRMnZqy
         pMLiX/6HcEMksnf5mzcfPAtzsAkNXEk83RLV/LuzJiYmKg3h8nrYjkEJQ62zVe2FHS
         S8xojYcsAGunofJXadN4fdamIxwjS8GBcIvjNoMFlwkfpE7QxSA/+Wu+hzDExEz4Km
         LJlGMVieEKcvg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/12] kconfig: create directories needed for syncconfig by itself
Date:   Thu,  5 Jul 2018 11:39:41 +0900
Message-Id: <1530758389-30862-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make syncconfig' creates some files such as include/config/auto.conf,
include/generate/autoconf.h, etc. but the necessary directory creation
relies on scripts/kconfig/Makefile.

To make Kconfig self-contained, create directories as needed in
conf_write_autoconf().

This change allows scripts/kconfig/Makefile cleanups; syncconfig can
be merged into simple-targets.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/Makefile   | 15 ++++++---------
 scripts/kconfig/confdata.c | 14 ++++++++++++++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index c9e8cf5..dffe268 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -3,8 +3,7 @@
 # Kernel configuration targets
 # These targets are used from top-level makefile
 
-PHONY += xconfig gconfig menuconfig config syncconfig \
-	localmodconfig localyesconfig
+PHONY += xconfig gconfig menuconfig config localmodconfig localyesconfig
 
 ifdef KBUILD_KCONFIG
 Kconfig := $(KBUILD_KCONFIG)
@@ -34,12 +33,6 @@ config: $(obj)/conf
 nconfig: $(obj)/nconf
 	$< $(silent) $(Kconfig)
 
-# This has become an internal implementation detail and is now deprecated
-# for external use.
-syncconfig: $(obj)/conf
-	$(Q)mkdir -p include/config include/generated
-	$< $(silent) --$@ $(Kconfig)
-
 localyesconfig localmodconfig: $(obj)/conf
 	$(Q)perl $(srctree)/$(src)/streamline_config.pl --$@ $(srctree) $(Kconfig) > .tmp.config
 	$(Q)if [ -f .config ]; then 					\
@@ -55,8 +48,12 @@ localyesconfig localmodconfig: $(obj)/conf
 	$(Q)rm -f .tmp.config
 
 # These targets map 1:1 to the commandline options of 'conf'
+#
+# Note:
+#  syncconfig has become an internal implementation detail and is now
+#  deprecated for external use
 simple-targets := oldconfig allnoconfig allyesconfig allmodconfig \
-	alldefconfig randconfig listnewconfig olddefconfig
+	alldefconfig randconfig listnewconfig olddefconfig syncconfig
 PHONY += $(simple-targets)
 
 $(simple-targets): $(obj)/conf
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 881993e..38b3a6c 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -898,6 +898,9 @@ static int conf_write_dep(const char *name)
 
 	fprintf(out, "\n$(deps_config): ;\n");
 	fclose(out);
+
+	if (mkdir_p(name))
+		return 1;
 	rename("..config.tmp", name);
 	return 0;
 }
@@ -914,6 +917,8 @@ static int conf_split_config(void)
 	conf_read_simple(name, S_DEF_AUTO);
 	sym_calc_value(modules_sym);
 
+	if (mkdir_p("include/config/"))
+		return 1;
 	if (chdir("include/config"))
 		return 1;
 
@@ -990,6 +995,7 @@ static int conf_split_config(void)
 				res = 1;
 				goto out;
 			}
+
 			/* Try it again. */
 			fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
 			if (fd == -1) {
@@ -1062,14 +1068,22 @@ int conf_write_autoconf(void)
 	name = getenv("KCONFIG_AUTOHEADER");
 	if (!name)
 		name = "include/generated/autoconf.h";
+	if (mkdir_p(name))
+		return 1;
 	if (rename(".tmpconfig.h", name))
 		return 1;
+
 	name = getenv("KCONFIG_TRISTATE");
 	if (!name)
 		name = "include/config/tristate.conf";
+	if (mkdir_p(name))
+		return 1;
 	if (rename(".tmpconfig_tristate", name))
 		return 1;
+
 	name = conf_get_autoconfig_name();
+	if (mkdir_p(name))
+		return 1;
 	/*
 	 * This must be the last step, kbuild has a dependency on auto.conf
 	 * and this marks the successful completion of the previous steps.
-- 
2.7.4

