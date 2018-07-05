Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FFDC3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EABA241BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NDLdMTCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EABA241BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeGEClc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:41:32 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:43642 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeGECl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:41:29 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w652duZf028145;
        Thu, 5 Jul 2018 11:40:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w652duZf028145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530758404;
        bh=aKZ/y86rj+Ea3TF1jUMYEhW+7zXkg8xpFB++9mhoS9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NDLdMTCKyTdKDMLMOHII3sdpPsI7b9Dq+pTzhSNpUmK09ORTHk1xJs644NxEDm7q/
         Fm+HA7Dt+r8rdjlBrLv3CA1D6CxGDF6EW+YmUeC9enYvATNB0rrCedl+kAHySMVN27
         x5Bqf1w3Yqa1J2JgzfvPhyAn6+1E0qDNGzLBtrO+wM8t82lwv8cyJG8LfMO5oJyb1+
         kSNt4gfAnnJC1dAHJuNhNV/5alT40lfUH2mU6M67c62wcvVfltWKvK/cjbUM/lU7Lm
         PeUFpm/ZIQvO5SW4HdhaLhxCivaNmYAKzhRU2gpZS2SPrRG0gLUIMWM9CGBl3Eh9oT
         kdcqLmH5OHD9w==
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
Subject: [PATCH v3 09/12] kbuild: do not update config when running install targets
Date:   Thu,  5 Jul 2018 11:39:46 +0900
Message-Id: <1530758389-30862-10-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"make syncconfig" is automatically invoked when any of the following
happens:

 - .config is updated
 - any of Kconfig files is updated
 - any of environment variables referenced in Kconfig is changed

Then, it updates configuration files such as include/config/auto.conf
include/generated/autoconf.h, etc.

Even install targets (install, modules_install, etc.) are no exception.
However, they should never ever modify the source tree.  Install
targets are often run with root privileges.  Once those configuration
files are owned by root, "make mrproper" would end up with permission
error.

Install targets should just copy things blindly.  They should not care
whether the configuration is up-to-date or not.  This makes more sense
because we are interested in the configuration that was used in the
previous kernel building.

This issue has existed since before, but rarely happened.  I expect
more chance where people are hit by this; with the new Kconfig syntax
extension, the .config now contains the compiler information.  If you
cross-compile the kernel with CROSS_COMPILE, but forget to pass it
for "make install", you meet "any of environment variables referenced
in Kconfig is changed" because $(CC) is referenced in Kconfig.
Another scenario is the compiler upgrade before the installation.

Install targets need the configuration.  "make modules_install" refer
to CONFIG_MODULES etc.  "make dtbs_install" also needs CONFIG_ARCH_*
to decide which dtb files to install.  However, the auto-update of
the configuration files should be avoided.  We already do this for
external modules.

Now, Make targets are categorized into 3 groups:

[1] Do not need the kernel configuration at all

    help, coccicheck, headers_install etc.

[2] Need the latest kernel configuration

    If new config options are added, Kconfig will show prompt to
    ask user's selection.

    Build targets such as vmlinux, in-kernel modules are the cases.

[3] Need the kernel configuration, but do not want to update it

    Install targets except headers_install, and external modules
    are the cases.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index ef24068..f0663c8 100644
--- a/Makefile
+++ b/Makefile
@@ -225,10 +225,12 @@ no-dot-config-targets := $(clean-targets) \
 			 cscope gtags TAGS tags help% %docs check% coccicheck \
 			 $(version_h) headers_% archheaders archscripts \
 			 kernelversion %src-pkg
+no-sync-config-targets := $(no-dot-config-targets) install %install
 
-config-targets := 0
-mixed-targets  := 0
-dot-config     := 1
+config-targets  := 0
+mixed-targets   := 0
+dot-config      := 1
+may-sync-config := 1
 
 ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
 	ifeq ($(filter-out $(no-dot-config-targets), $(MAKECMDGOALS)),)
@@ -236,6 +238,16 @@ ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
 	endif
 endif
 
+ifneq ($(filter $(no-sync-config-targets), $(MAKECMDGOALS)),)
+	ifeq ($(filter-out $(no-sync-config-targets), $(MAKECMDGOALS)),)
+		may-sync-config := 0
+	endif
+endif
+
+ifneq ($(KBUILD_EXTMOD),)
+	may-sync-config := 0
+endif
+
 ifeq ($(KBUILD_EXTMOD),)
         ifneq ($(filter config %config,$(MAKECMDGOALS)),)
                 config-targets := 1
@@ -606,7 +618,7 @@ ARCH_CFLAGS :=
 include arch/$(SRCARCH)/Makefile
 
 ifeq ($(dot-config),1)
-ifeq ($(KBUILD_EXTMOD),)
+ifeq ($(may-sync-config),1)
 # Read in dependencies to all Kconfig* files, make sure to run syncconfig if
 # changes are detected. This should be included after arch/$(SRCARCH)/Makefile
 # because some architectures define CROSS_COMPILE there.
@@ -621,8 +633,9 @@ $(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;
 include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
 	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
 else
-# external modules needs include/generated/autoconf.h and include/config/auto.conf
-# but do not care if they are up-to-date. Use auto.conf to trigger the test
+# External modules and some install targets need include/generated/autoconf.h
+# and include/config/auto.conf but do not care if they are up-to-date.
+# Use auto.conf to trigger the test
 PHONY += include/config/auto.conf
 
 include/config/auto.conf:
@@ -634,7 +647,7 @@ include/config/auto.conf:
 	echo >&2 ;							\
 	/bin/false)
 
-endif # KBUILD_EXTMOD
+endif # may-sync-config
 
 else
 # Dummy target needed, because used as prerequisite
-- 
2.7.4

