Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PAe2KGPMGVvoIwAAmS7hNA
	; Fri, 08 Jun 2018 00:22:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8C36E6074D; Fri,  8 Jun 2018 00:22:59 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UtqXo+Aw"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 31189601D2;
	Fri,  8 Jun 2018 00:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 31189601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeFHAW4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 20:22:56 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:55490 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeFHAWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 20:22:54 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w580LmFG000891;
        Fri, 8 Jun 2018 09:21:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w580LmFG000891
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528417309;
        bh=avjwhE/WevHv+QiaUB43qqYeepyYvCoMSn+3y8zkiCQ=;
        h=From:To:Cc:Subject:Date:From;
        b=UtqXo+AwpX4SWV4jhr5JCVuYLt+50Q/y7bW8mpZbDUgQNt+pWq+TVebcISimdlhW6
         p0JIptYAcgsZh8aFWJAUo4k/jIz5QIhoJazp1bmqgKCjkcBsk3/mL7sXWE4DJUL/P2
         +bx/4h7a0StZ7nX8eIIVSgIzuOhBsecmMtY8UvvFTRcClhyRd7S6lytPP15edri9++
         aCX31pt4o8eBN9QtPY+XoFiI6fTUjnnYHWZNmtEGVSIErccVUMHWPt4j9fk1bj7BOi
         FzdwBZmHNAFsdJLfcBoj+Kzl3UlD1TdJhtgeCB0oycKaLwFWSFx1a9QCPDF1dh+SS1
         6w2weHhmeRgSg==
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH] kbuild: fix endless syncconfig in case arch Makefile sets CROSS_COMPILE
Date: Fri,  8 Jun 2018 09:21:43 +0900
Message-Id: <1528417303-14842-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 21c54b774744 ("kconfig: show compiler version text in the top
comment") was intended to detect the compiler upgrade, but Geert
reported a breakage on the m68k build.

The compiler upgrade is detected by the change of the environment
variable, CC_VERSION_TEXT, which contains the first line of the output
from $(CC) --version.  Currently, this works well when CROSS_COMPILE
is given via the environment variable or the Make command line.

However, some architectures such as m68k can specify CROSS_COMPILE
from arch/$(SRCARCH)/Makefile as well.  In this case, "make ARCH=m68k"
ends up with endless syncconfig loop.

  $ make ARCH=m68k defconfig
  *** Default configuration is based on 'multi_defconfig'
  #
  # configuration written to .config
  #
  $ make ARCH=m68k
  scripts/kconfig/conf  --syncconfig Kconfig
  scripts/kconfig/conf  --syncconfig Kconfig
  scripts/kconfig/conf  --syncconfig Kconfig
  scripts/kconfig/conf  --syncconfig Kconfig

Things are happening like this:

Because arch/$(SRCARCH)/Makefile is included after CC_VERSION_TEXT
is set, it contains the host compiler version in the defconfig phase.

To create or update auto.conf, the following line is triggered:

include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
        $(Q)$(MAKE) -f $(srctree)/Makefile syncconfig

This recurses the top Makefile after arch/$(SRCARCH)/Makefile is
included.  CROSS_COMPILE is set to a m68k toolchain prefix and
exported to the recursed Make.  Then, syncconfig is invoked with
the target compiler version in CC_VERSION_TEXT.

The Make will restart because auto.conf and auto.conf.cmd have been
updated.  At this point, CROSS_COMPILE is reset, so CC_VERSION_TEXT
is set to the host compiler version again.  Then, syncconfig is
triggered due to the change of CC_VERSION_TEXT.  This loop continues
eternally.

To fix this problem, $(CC_VERSION_TEXT) must be evaluated only after
arch/$(SRCARCH)/Makefile.  Setting it earlier is OK as long as it is
defined by using the '=' operator instead of ':='.

For the defconfig phase, $(CC_VERSION_TEXT) is evaluated when Kbuild
descends into scripts/kconfig/, so it contains the target compiler
version correctly.

include/config/auto.conf.cmd references $(CC_VERSION_TEXT) as well,
so it must be included after arch/$(SRCARCH)/Makefile.

Fixes: 21c54b774744 ("kconfig: show compiler version text in the top comment")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 54 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/Makefile b/Makefile
index 019a5a0..747edaf 100644
--- a/Makefile
+++ b/Makefile
@@ -442,8 +442,6 @@ export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
 export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
 export KBUILD_ARFLAGS
 
-export CC_VERSION_TEXT := $(shell $(CC) --version | head -n 1)
-
 # When compiling out-of-tree modules, put MODVERDIR in the module
 # tree rather than in the kernel tree. The kernel tree might
 # even be read-only.
@@ -514,6 +512,12 @@ ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/cc-can-link.sh $(CC)), y)
   export CC_CAN_LINK
 endif
 
+# The expansion should be delayed until arch/$(SRCARCH)/Makefile is included.
+# Some architectures define CROSS_COMPILE in arch/$(SRCARCH)/Makefile.
+# CC_VERSION_TEXT is referenced from Kconfig (so it needs export),
+# and from include/config/auto.conf.cmd to detect the compiler upgrade.
+CC_VERSION_TEXT = $(shell $(CC) --version | head -n 1)
+
 ifeq ($(config-targets),1)
 # ===========================================================================
 # *config targets only - make sure prerequisites are updated, and descend
@@ -523,7 +527,7 @@ ifeq ($(config-targets),1)
 # KBUILD_DEFCONFIG may point out an alternative default configuration
 # used for 'make defconfig'
 include arch/$(SRCARCH)/Makefile
-export KBUILD_DEFCONFIG KBUILD_KCONFIG
+export KBUILD_DEFCONFIG KBUILD_KCONFIG CC_VERSION_TEXT
 
 config: scripts_basic outputmakefile FORCE
 	$(Q)$(MAKE) $(build)=scripts/kconfig $@
@@ -585,12 +589,32 @@ virt-y		:= virt/
 endif # KBUILD_EXTMOD
 
 ifeq ($(dot-config),1)
-# Read in config
 -include include/config/auto.conf
+endif
+
+# The all: target is the default when no target is given on the
+# command line.
+# This allow a user to issue only 'make' to build a kernel including modules
+# Defaults to vmlinux, but the arch makefile usually adds further targets
+all: vmlinux
+
+CFLAGS_GCOV	:= -fprofile-arcs -ftest-coverage \
+	$(call cc-option,-fno-tree-loop-im) \
+	$(call cc-disable-warning,maybe-uninitialized,)
+export CFLAGS_GCOV CFLAGS_KCOV
+
+# The arch Makefile can set ARCH_{CPP,A,C}FLAGS to override the default
+# values of the respective KBUILD_* variables
+ARCH_CPPFLAGS :=
+ARCH_AFLAGS :=
+ARCH_CFLAGS :=
+include arch/$(SRCARCH)/Makefile
 
+ifeq ($(dot-config),1)
 ifeq ($(KBUILD_EXTMOD),)
-# Read in dependencies to all Kconfig* files, make sure to run
-# oldconfig if changes are detected.
+# Read in dependencies to all Kconfig* files, make sure to run syncconfig if
+# changes are detected. This should be included after arch/$(SRCARCH)/Makefile
+# because some architectures define CROSS_COMPILE there.
 -include include/config/auto.conf.cmd
 
 # To avoid any implicit rule to kick in, define an empty command
@@ -622,24 +646,6 @@ else
 include/config/auto.conf: ;
 endif # $(dot-config)
 
-# The all: target is the default when no target is given on the
-# command line.
-# This allow a user to issue only 'make' to build a kernel including modules
-# Defaults to vmlinux, but the arch makefile usually adds further targets
-all: vmlinux
-
-CFLAGS_GCOV	:= -fprofile-arcs -ftest-coverage \
-	$(call cc-option,-fno-tree-loop-im) \
-	$(call cc-disable-warning,maybe-uninitialized,)
-export CFLAGS_GCOV CFLAGS_KCOV
-
-# The arch Makefile can set ARCH_{CPP,A,C}FLAGS to override the default
-# values of the respective KBUILD_* variables
-ARCH_CPPFLAGS :=
-ARCH_AFLAGS :=
-ARCH_CFLAGS :=
-include arch/$(SRCARCH)/Makefile
-
 KBUILD_CFLAGS	+= $(call cc-option,-fno-delete-null-pointer-checks,)
 KBUILD_CFLAGS	+= $(call cc-disable-warning,frame-address,)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
-- 
2.7.4
