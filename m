Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6EDC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 00:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD672088E
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 00:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kbajHju/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD672088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757006AbeFQAIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 20:08:21 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:58220 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756959AbeFQAIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 20:08:18 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w5H07Em5031999;
        Sun, 17 Jun 2018 09:07:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w5H07Em5031999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529194034;
        bh=p0EFGLD4zKKj6NeSDvgqjzAXMBy48Lv2VXcTzdRiPcQ=;
        h=From:To:Cc:Subject:Date:From;
        b=kbajHju/5iT5y6VCfskonkN7/dDnefmjJkWdSpXDaGDNOMzXB3/fc8I9NnEBnfooi
         mxKN4LSc3teArDspN8WkHWfJOihKmzQv4jwq63ihUROO6mraflEP/czZfczBTLLMcE
         ZvqGbR8ucOfBMa/1OZRQ1hjpXrkvA4lHf8jQJjnc/Uif3vfWXGSa7Cp+Wsu8UAkC58
         XiJxH5YBGqhK5SqfiHUZh0tiDgY7iiW9juF3kVnUiUcwD8MNjsyHQQX+X6N/9J7gEd
         2vhyinjIv1/jEEqAEBa7Tfzl1lyz15pEmq9NWK1ul3CnYJfdDLfSUx9cWzBxFty5eu
         NAC/gfk3k+0qQ==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH 1/2] kbuild: do not update config when running install targets
Date:   Sun, 17 Jun 2018 09:07:06 +0900
Message-Id: <1529194027-15752-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
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

To solve this, we can make the configuration read-only when running
install targets.  We already do this for external modules.

Install targets need the configuration.  "make modules_install" refer
to some config options such as CONFIG_MODULES.  "make dtbs_install"
also needs CONFIG_ARCH_* to decide which dtb files to install.
But, do not update it.

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

 Makefile | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 8a26b59..f934a81 100644
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
@@ -611,7 +623,7 @@ ARCH_CFLAGS :=
 include arch/$(SRCARCH)/Makefile
 
 ifeq ($(dot-config),1)
-ifeq ($(KBUILD_EXTMOD),)
+ifeq ($(may-sync-config),1)
 # Read in dependencies to all Kconfig* files, make sure to run syncconfig if
 # changes are detected. This should be included after arch/$(SRCARCH)/Makefile
 # because some architectures define CROSS_COMPILE there.
@@ -639,7 +651,7 @@ include/config/auto.conf:
 	echo >&2 ;							\
 	/bin/false)
 
-endif # KBUILD_EXTMOD
+endif # may-sync-config
 
 else
 # Dummy target needed, because used as prerequisite
-- 
2.7.4

