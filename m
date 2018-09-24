Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5928DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4CD21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4CD21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbeIXSaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:30:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57480 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732882AbeIXSae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:30:34 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C84131018;
        Mon, 24 Sep 2018 12:28:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 035/235] kbuild: do not update config when running install targets
Date:   Mon, 24 Sep 2018 13:50:21 +0200
Message-Id: <20180924113108.487694154@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit d79424137a7312d381d131d707a462440c0e8df9 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -225,10 +225,12 @@ no-dot-config-targets := $(clean-targets
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
@@ -236,6 +238,16 @@ ifneq ($(filter $(no-dot-config-targets)
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
@@ -610,7 +622,7 @@ ARCH_CFLAGS :=
 include arch/$(SRCARCH)/Makefile
 
 ifeq ($(dot-config),1)
-ifeq ($(KBUILD_EXTMOD),)
+ifeq ($(may-sync-config),1)
 # Read in dependencies to all Kconfig* files, make sure to run syncconfig if
 # changes are detected. This should be included after arch/$(SRCARCH)/Makefile
 # because some architectures define CROSS_COMPILE there.
@@ -625,8 +637,9 @@ $(KCONFIG_CONFIG) include/config/auto.co
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
@@ -638,7 +651,7 @@ include/config/auto.conf:
 	echo >&2 ;							\
 	/bin/false)
 
-endif # KBUILD_EXTMOD
+endif # may-sync-config
 
 else
 # Dummy target needed, because used as prerequisite


