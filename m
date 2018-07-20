Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D37ECDFBD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE84720652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="p39XuK+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE84720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeGTIfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:35:09 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:28749 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeGTIfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:35:08 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w6K7kdj1008048;
        Fri, 20 Jul 2018 16:46:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w6K7kdj1008048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532072805;
        bh=shsXDaqfurwusv+szzzzbnfT8vVFakrXhQ4CFfSL1ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p39XuK+W3wZX9KPTlFx2J7BiJqN0T71i+YiqXYxy21fxR4bvp90QRxfrPpIs5j5pj
         w693ET6Ojs0+4rvyxp0AbGbI4aoDjgrYTop8kPeIdOopIQLJXUAGlw/F4M/Qz0pIxF
         wGetxTC/w5/diPaHot5lrIVEeRLp2GECXe2umChcePny8gPCcOyc++ixW3gL1iU/Ng
         gYQXxp67Pb1NuBgbHXhFGyuMX+voavy9z5s1ZWf/OC26T83llTEa2CmCFh1+auvfCt
         CAAm2wkbyJsKKVxepigpieSrV41gYyRl70psHAK8116K+YFoZ1GsPWiKBBeLaHk2c4
         QuJ2MFtIRR1FQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/11] kbuild: do not update config when running install targets
Date:   Fri, 20 Jul 2018 16:46:34 +0900
Message-Id: <1532072796-7947-10-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
References: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
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

Changes in v4: None

 Makefile | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 2fa9830..ad83917 100644
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
@@ -607,7 +619,7 @@ ARCH_CFLAGS :=
 include arch/$(SRCARCH)/Makefile
 
 ifeq ($(dot-config),1)
-ifeq ($(KBUILD_EXTMOD),)
+ifeq ($(may-sync-config),1)
 # Read in dependencies to all Kconfig* files, make sure to run syncconfig if
 # changes are detected. This should be included after arch/$(SRCARCH)/Makefile
 # because some architectures define CROSS_COMPILE there.
@@ -622,8 +634,9 @@ $(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;
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
@@ -635,7 +648,7 @@ include/config/auto.conf:
 	echo >&2 ;							\
 	/bin/false)
 
-endif # KBUILD_EXTMOD
+endif # may-sync-config
 
 else
 # Dummy target needed, because used as prerequisite
-- 
2.7.4

