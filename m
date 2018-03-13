Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3447179-1520955863-2-6214673509091824176
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520955862; b=LKyo3kpQEdcZYlONbT/nedTsm0xMj4TMJif3GehDJk2CmA8
    sDeNOspwOVnPwW2WKzYmVuEDHaE6xwBSy3Hq2iZzc/EDbuOjjNf5ETKx6cPOiFCX
    7ovt7mvYl9kR3ConNABI77FZpgYSwYKyW/yada5ijGAvjy6i4QEkfKZdlJwsQAli
    HYOHLelLSywGJvuZhjPZ2o3nc4Ss+S1PiQzxRyfIbejBSKVdQn+Twqi7HupjKgKa
    2MnEOB4fWgRoGxpyMd4cJThDIzErKW/UaQCFDkXvM+PgljF1EA8Jb3ITtEwovHoO
    neQkcailoXWBgSlbAUufzAwRBbu1gdSIU71btjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955862; bh=mMnFvDISPLnIS7VzaUc5L0idku
    HY16U7ziTcWA8vhqY=; b=U+crYYkox5Dpzui1Xh+lA3nrc9b1f6QuMmcjkpRub6
    DY+IliN69n3St62ebjBzo3BFHN5Nc/7TgvutKr1Ol6f8v2hj9CaNa9cwmwbrej35
    egfDMMVeimER+QsGbQ2a1r29ozTae/lxvLBNXWeLsqLkxsO/3K7GC/lRZJMYrIVR
    uhM9lobK4/tFzcTSZlXVDvghm2Dr8N8uyljLgwpNOWQMndKuWTFHq/UvPhFyFn9u
    bM59mptV91OSeJBeW713wEq5C9oJV6kxQCzoUa0Qkb83gHxWIr3ai8SibGZETHtJ
    FzVCgCYv1GkXB+N/IjGM53tWteE+W1BJp2PHt6Cu6gPw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935014AbeCMPlj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:41:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37044 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934720AbeCMPlg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:41:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4.14 133/140] kbuild: re-order the code to not parse unnecessary variables
Date: Tue, 13 Mar 2018 16:25:36 +0100
Message-Id: <20180313152507.111200268@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit 2c1f4f125159f10521944cea23e33a00fcf85ede upstream.

The top Makefile is divided into some sections such as mixed targets,
config targets, build targets, etc.

When we build mixed targets, Kbuild just invokes submake to process
them one by one.  In this case, compiler-related variables like CC,
KBUILD_CFLAGS, etc. are unneeded.

Check what kind of targets we are building first, and parse variables
for building only when necessary.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile |  233 +++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 118 insertions(+), 115 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -187,15 +187,6 @@ ifeq ("$(origin M)", "command line")
   KBUILD_EXTMOD := $(M)
 endif
 
-# If building an external module we do not care about the all: rule
-# but instead _all depend on modules
-PHONY += all
-ifeq ($(KBUILD_EXTMOD),)
-_all: all
-else
-_all: modules
-endif
-
 ifeq ($(KBUILD_SRC),)
         # building in the source tree
         srctree := .
@@ -207,6 +198,9 @@ else
                 srctree := $(KBUILD_SRC)
         endif
 endif
+
+export KBUILD_CHECKSRC KBUILD_EXTMOD KBUILD_SRC
+
 objtree		:= .
 src		:= $(srctree)
 obj		:= $(objtree)
@@ -215,6 +209,74 @@ VPATH		:= $(srctree)$(if $(KBUILD_EXTMOD
 
 export srctree objtree VPATH
 
+# To make sure we do not include .config for any of the *config targets
+# catch them early, and hand them over to scripts/kconfig/Makefile
+# It is allowed to specify more targets when calling make, including
+# mixing *config targets and build targets.
+# For example 'make oldconfig all'.
+# Detect when mixed targets is specified, and make a second invocation
+# of make so .config is not included in this case either (for *config).
+
+version_h := include/generated/uapi/linux/version.h
+old_version_h := include/linux/version.h
+
+no-dot-config-targets := clean mrproper distclean \
+			 cscope gtags TAGS tags help% %docs check% coccicheck \
+			 $(version_h) headers_% archheaders archscripts \
+			 kernelversion %src-pkg
+
+config-targets := 0
+mixed-targets  := 0
+dot-config     := 1
+
+ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
+	ifeq ($(filter-out $(no-dot-config-targets), $(MAKECMDGOALS)),)
+		dot-config := 0
+	endif
+endif
+
+ifeq ($(KBUILD_EXTMOD),)
+        ifneq ($(filter config %config,$(MAKECMDGOALS)),)
+                config-targets := 1
+                ifneq ($(words $(MAKECMDGOALS)),1)
+                        mixed-targets := 1
+                endif
+        endif
+endif
+# install and modules_install need also be processed one by one
+ifneq ($(filter install,$(MAKECMDGOALS)),)
+        ifneq ($(filter modules_install,$(MAKECMDGOALS)),)
+	        mixed-targets := 1
+        endif
+endif
+
+ifeq ($(mixed-targets),1)
+# ===========================================================================
+# We're called with mixed targets (*config and build targets).
+# Handle them one by one.
+
+PHONY += $(MAKECMDGOALS) __build_one_by_one
+
+$(filter-out __build_one_by_one, $(MAKECMDGOALS)): __build_one_by_one
+	@:
+
+__build_one_by_one:
+	$(Q)set -e; \
+	for i in $(MAKECMDGOALS); do \
+		$(MAKE) -f $(srctree)/Makefile $$i; \
+	done
+
+else
+
+# We need some generic definitions (do not try to remake the file).
+scripts/Kbuild.include: ;
+include scripts/Kbuild.include
+
+# Read KERNELRELEASE from include/config/kernel.release (if it exists)
+KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
+KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
+export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
+
 # SUBARCH tells the usermode build what the underlying arch is.  That is set
 # first, and if a usermode build is happening, the "ARCH=um" on the command
 # line overrides the setting of ARCH below.  If a native build is happening,
@@ -312,40 +374,6 @@ HOSTCFLAGS  += -Wno-unused-value -Wno-un
 		-Wno-missing-field-initializers -fno-delete-null-pointer-checks
 endif
 
-# Decide whether to build built-in, modular, or both.
-# Normally, just do built-in.
-
-KBUILD_MODULES :=
-KBUILD_BUILTIN := 1
-
-# If we have only "make modules", don't compile built-in objects.
-# When we're building modules with modversions, we need to consider
-# the built-in objects during the descend as well, in order to
-# make sure the checksums are up to date before we record them.
-
-ifeq ($(MAKECMDGOALS),modules)
-  KBUILD_BUILTIN := $(if $(CONFIG_MODVERSIONS),1)
-endif
-
-# If we have "make <whatever> modules", compile modules
-# in addition to whatever we do anyway.
-# Just "make" or "make all" shall build modules as well
-
-ifneq ($(filter all _all modules,$(MAKECMDGOALS)),)
-  KBUILD_MODULES := 1
-endif
-
-ifeq ($(MAKECMDGOALS),)
-  KBUILD_MODULES := 1
-endif
-
-export KBUILD_MODULES KBUILD_BUILTIN
-export KBUILD_CHECKSRC KBUILD_SRC KBUILD_EXTMOD
-
-# We need some generic definitions (do not try to remake the file).
-scripts/Kbuild.include: ;
-include scripts/Kbuild.include
-
 # Make variables (CC, etc...)
 AS		= $(CROSS_COMPILE)as
 LD		= $(CROSS_COMPILE)ld
@@ -405,11 +433,6 @@ KBUILD_CFLAGS_MODULE  := -DMODULE
 KBUILD_LDFLAGS_MODULE := -T $(srctree)/scripts/module-common.lds
 GCC_PLUGINS_CFLAGS :=
 
-# Read KERNELRELEASE from include/config/kernel.release (if it exists)
-KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
-KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
-
-export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
 export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
 export CPP AR NM STRIP OBJCOPY OBJDUMP HOSTLDFLAGS HOST_LOADLIBES
 export MAKE AWK GENKSYMS INSTALLKERNEL PERL PYTHON UTS_MACHINE
@@ -459,73 +482,6 @@ ifneq ($(KBUILD_SRC),)
 	    $(srctree) $(objtree) $(VERSION) $(PATCHLEVEL)
 endif
 
-# Support for using generic headers in asm-generic
-PHONY += asm-generic uapi-asm-generic
-asm-generic: uapi-asm-generic
-	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
-	            src=asm obj=arch/$(SRCARCH)/include/generated/asm
-uapi-asm-generic:
-	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
-	            src=uapi/asm obj=arch/$(SRCARCH)/include/generated/uapi/asm
-
-# To make sure we do not include .config for any of the *config targets
-# catch them early, and hand them over to scripts/kconfig/Makefile
-# It is allowed to specify more targets when calling make, including
-# mixing *config targets and build targets.
-# For example 'make oldconfig all'.
-# Detect when mixed targets is specified, and make a second invocation
-# of make so .config is not included in this case either (for *config).
-
-version_h := include/generated/uapi/linux/version.h
-old_version_h := include/linux/version.h
-
-no-dot-config-targets := clean mrproper distclean \
-			 cscope gtags TAGS tags help% %docs check% coccicheck \
-			 $(version_h) headers_% archheaders archscripts \
-			 kernelversion %src-pkg
-
-config-targets := 0
-mixed-targets  := 0
-dot-config     := 1
-
-ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
-	ifeq ($(filter-out $(no-dot-config-targets), $(MAKECMDGOALS)),)
-		dot-config := 0
-	endif
-endif
-
-ifeq ($(KBUILD_EXTMOD),)
-        ifneq ($(filter config %config,$(MAKECMDGOALS)),)
-                config-targets := 1
-                ifneq ($(words $(MAKECMDGOALS)),1)
-                        mixed-targets := 1
-                endif
-        endif
-endif
-# install and modules_install need also be processed one by one
-ifneq ($(filter install,$(MAKECMDGOALS)),)
-        ifneq ($(filter modules_install,$(MAKECMDGOALS)),)
-	        mixed-targets := 1
-        endif
-endif
-
-ifeq ($(mixed-targets),1)
-# ===========================================================================
-# We're called with mixed targets (*config and build targets).
-# Handle them one by one.
-
-PHONY += $(MAKECMDGOALS) __build_one_by_one
-
-$(filter-out __build_one_by_one, $(MAKECMDGOALS)): __build_one_by_one
-	@:
-
-__build_one_by_one:
-	$(Q)set -e; \
-	for i in $(MAKECMDGOALS); do \
-		$(MAKE) -f $(srctree)/Makefile $$i; \
-	done
-
-else
 ifeq ($(config-targets),1)
 # ===========================================================================
 # *config targets only - make sure prerequisites are updated, and descend
@@ -548,6 +504,44 @@ else
 # Build targets only - this includes vmlinux, arch specific targets, clean
 # targets and others. In general all targets except *config targets.
 
+# If building an external module we do not care about the all: rule
+# but instead _all depend on modules
+PHONY += all
+ifeq ($(KBUILD_EXTMOD),)
+_all: all
+else
+_all: modules
+endif
+
+# Decide whether to build built-in, modular, or both.
+# Normally, just do built-in.
+
+KBUILD_MODULES :=
+KBUILD_BUILTIN := 1
+
+# If we have only "make modules", don't compile built-in objects.
+# When we're building modules with modversions, we need to consider
+# the built-in objects during the descend as well, in order to
+# make sure the checksums are up to date before we record them.
+
+ifeq ($(MAKECMDGOALS),modules)
+  KBUILD_BUILTIN := $(if $(CONFIG_MODVERSIONS),1)
+endif
+
+# If we have "make <whatever> modules", compile modules
+# in addition to whatever we do anyway.
+# Just "make" or "make all" shall build modules as well
+
+ifneq ($(filter all _all modules,$(MAKECMDGOALS)),)
+  KBUILD_MODULES := 1
+endif
+
+ifeq ($(MAKECMDGOALS),)
+  KBUILD_MODULES := 1
+endif
+
+export KBUILD_MODULES KBUILD_BUILTIN
+
 ifeq ($(KBUILD_EXTMOD),)
 # Additional helpers built in scripts/
 # Carefully list dependencies so we do not try to build scripts twice
@@ -1076,6 +1070,15 @@ prepare0: archprepare gcc-plugins
 # All the preparing..
 prepare: prepare0 prepare-objtool
 
+# Support for using generic headers in asm-generic
+PHONY += asm-generic uapi-asm-generic
+asm-generic: uapi-asm-generic
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
+	            src=asm obj=arch/$(SRCARCH)/include/generated/asm
+uapi-asm-generic:
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
+	            src=uapi/asm obj=arch/$(SRCARCH)/include/generated/uapi/asm
+
 PHONY += prepare-objtool
 prepare-objtool: $(objtool_target)
 
