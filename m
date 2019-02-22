Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADD6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA412086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bZ45tHyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfBVHk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:40:28 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:53326 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfBVHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:40:22 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1M7eEN5013122;
        Fri, 22 Feb 2019 16:40:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1M7eEN5013122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550821217;
        bh=bMNe7A0okspALkFQtHY95z2jxYuEKE/+Qu2TtqR/cjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZ45tHyAiCDn0ZbSCd2ozaFFwvONyLP/yPcxp8Ift+vGhhLkCmnbZTsCaMR4E/m1e
         Au6K4v4peI6k1ylEtMhZF5DX8L8aRfvuoTulxSDv+IR1ZEI9fri9l7/UB9XsdYNbht
         eiOq6fs/q7woZuKI1hcnQE9DUN8qJ71SARehfFV+YvCXf2PJDaKw8IZ+NW1N7hw9Wt
         KKi7RAgi8hTiTPrmINfLaASAC4Jr7aobJ8kcoHYXEMy167/kZngPT6sUytmJN+Bk66
         dRof6yoTQC7MWH4WtuDMvFQThYVgEgJTJ74s3vFttUZckyBZQotL7rroQHJMTe/8zi
         c5Hn3zBODqdsA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] kbuild: move ".config not found!" message from Kconfig to Makefile
Date:   Fri, 22 Feb 2019 16:40:11 +0900
Message-Id: <1550821211-30324-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550821211-30324-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550821211-30324-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you run "make" in a pristine source tree, currently Kbuild will
start to build Kconfig to let it show the error message.

It would be more straightforward to check it in Makefile and let
it fail immediately.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - New patch

 Makefile               | 10 ++++++++--
 scripts/kconfig/conf.c | 13 -------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index aa9ff68..84034c5 100644
--- a/Makefile
+++ b/Makefile
@@ -628,8 +628,14 @@ ifeq ($(may-sync-config),1)
 # because some architectures define CROSS_COMPILE there.
 -include include/config/auto.conf.cmd
 
-# To avoid any implicit rule to kick in, define an empty command
-$(KCONFIG_CONFIG): ;
+$(KCONFIG_CONFIG):
+	@echo >&2 '***'
+	@echo >&2 '*** Configuration file "$@" not found!'
+	@echo >&2 '***'
+	@echo >&2 '*** Please run some configurator (e.g. "make oldconfig" or'
+	@echo >&2 '*** "make menuconfig" or "make xconfig").'
+	@echo >&2 '***'
+	@/bin/false
 
 # The actual configuration files used during the build are stored in
 # include/generated/ and include/config/. Update them if .config is newer than
diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index da89ef7..ef3678c 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -488,7 +488,6 @@ int main(int ac, char **av)
 	const char *progname = av[0];
 	int opt;
 	const char *name, *defconfig_file = NULL /* gcc uninit */;
-	struct stat tmpstat;
 	int no_conf_write = 0;
 
 	tty_stdio = isatty(0) && isatty(1);
@@ -560,18 +559,6 @@ int main(int ac, char **av)
 	name = av[optind];
 	conf_parse(name);
 	//zconfdump(stdout);
-	if (sync_kconfig) {
-		name = conf_get_configname();
-		if (stat(name, &tmpstat)) {
-			fprintf(stderr, "***\n"
-				"*** Configuration file \"%s\" not found!\n"
-				"***\n"
-				"*** Please run some configurator (e.g. \"make oldconfig\" or\n"
-				"*** \"make menuconfig\" or \"make xconfig\").\n"
-				"***\n", name);
-			exit(1);
-		}
-	}
 
 	switch (input_mode) {
 	case defconfig:
-- 
2.7.4

