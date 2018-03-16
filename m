Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753290AbeCPHhr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:37:47 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:20641 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeCPHhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:37:43 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w2G7bOa7029139
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Pitre <nicolas.pitre@linaro.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 4/7] kbuild: restore touching autoksyms.h to the top Makefile
Date: Fri, 16 Mar 2018 16:37:12 +0900
Message-Id: <1521185836-19120-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521185836-19120-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521185836-19120-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d3fc425e819b ("kbuild: make sure autoksyms.h exists early")
moved the code that touches autoksyms.h to scripts/kconfig/Makefile
with obscure reason.

>From Nicolas' comment [1], he did not seem to be sure about the root
cause.

I guess I figured it out, so here is a fix-up I think is more correct.
According to the error log in the original post [2], the build failed
in scripts/mod/devicetable-offsets.c

scripts/mod/Makefile is descended from scripts/Makefile, which is
invoked from the top-level Makefile by the 'scripts' target.

To build vmlinux and/or modules, Kbuild descend into $(vmlinux-dirs).
This depends on 'prepare' and 'scripts' as follows:

  $(vmlinux-dirs): prepare scripts

Because there is no dependency between 'prepare' and 'scripts', the
parallel building can run them simultaneously.

'prepare' depends on 'prepare1', which touched autoksyms.h, whereas
'scripts' descends into script/, then scripts/mod/, which needs
<generated/autoksyms.h> if CONFIG_TRIM_UNUSED_KSYMS.  It was the
reason of the race.

I am not happy to have unrelated code in the Kconfig Makefile, so
getting it back to the top Makefile.

I removed the standalone test target because I want to use it to
create an empty autoksyms.h file.  Here is a little improvement;
unnecessary autoksyms.h is not created when CONFIG_TRIM_UNUSED_KSYMS
is disabled.

[1] https://lkml.org/lkml/2016/11/30/734
[2] https://lkml.org/lkml/2016/11/30/531

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 Makefile                 | 12 +++++++-----
 scripts/kconfig/Makefile |  2 --
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 9bf6697..0a3895c 100644
--- a/Makefile
+++ b/Makefile
@@ -1021,9 +1021,11 @@ ifdef CONFIG_TRIM_UNUSED_KSYMS
 	  "$(MAKE) -f $(srctree)/Makefile vmlinux"
 endif
 
-# standalone target for easier testing
-include/generated/autoksyms.h: FORCE
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh true
+autoksyms_h := $(if $(CONFIG_TRIM_UNUSED_KSYMS), include/generated/autoksyms.h)
+
+$(autoksyms_h):
+	$(Q)mkdir -p $(dir $@)
+	$(Q)touch $@
 
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
@@ -1067,7 +1069,7 @@ include/config/kernel.release: include/config/auto.conf FORCE
 # in parallel
 PHONY += scripts
 scripts: scripts_basic include/config/auto.conf include/config/tristate.conf \
-	 asm-generic gcc-plugins
+	 asm-generic gcc-plugins $(autoksyms_h)
 	$(Q)$(MAKE) $(build)=$(@)
 
 # Things we need to do before we recursively start building the kernel
@@ -1097,7 +1099,7 @@ endif
 # that need to depend on updated CONFIG_* values can be checked here.
 prepare2: prepare3 prepare-compiler-check outputmakefile asm-generic
 
-prepare1: prepare2 $(version_h) include/generated/utsrelease.h \
+prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h \
                    include/config/auto.conf
 	$(cmd_crmodverdir)
 
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 78c96aa..f9bdd02 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -38,8 +38,6 @@ nconfig: $(obj)/nconf
 # for external use.
 syncconfig: $(obj)/conf
 	$(Q)mkdir -p include/config include/generated
-	$(Q)test -e include/generated/autoksyms.h || \
-	    touch   include/generated/autoksyms.h
 	$< $(silent) --$@ $(Kconfig)
 
 localyesconfig localmodconfig: $(obj)/conf
-- 
2.7.4
