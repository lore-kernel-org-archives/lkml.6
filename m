Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932261AbeCKUM6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 16:12:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35512 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932144AbeCKUM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 16:12:57 -0400
To: linux-kbuild <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] kbuild: check for pkg-config on make menu/n/g/xconfig
Message-ID: <09cf5537-b2d7-5bf5-0c0b-d0b765e1e75b@infradead.org>
Date: Sun, 11 Mar 2018 13:12:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Each of 'make {menu,n,g,x}config' uses (needs) pkg-config to make sure
that other required files are present, but none of these check that
pkg-config itself is present.  Add a check for all 4 of these targets.

Fixes kernel bugzilla #77511:
https://bugzilla.kernel.org/show_bug.cgi?id=77511

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
I'm also OK with just documenting the pkg-config requirement in
Documentation/Changes (= Documentation/process/changes.rst).

+ chmod +x scripts/kconfig/check-pkgconfig.sh

 scripts/kconfig/Makefile           |   15 ++++++++++++++-
 scripts/kconfig/check-pkgconfig.sh |   13 +++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

--- lnx-416-rc3.orig/scripts/kconfig/Makefile
+++ lnx-416-rc3/scripts/kconfig/Makefile
@@ -160,6 +160,9 @@ help:
 	@echo  '  xenconfig       - Enable additional options for xen dom0 and guest kernel support'
 	@echo  '  tinyconfig	  - Configure the tiniest possible kernel'
 
+# pkg-config check
+check-pkgconfig  := $(srctree)/$(src)/check-pkgconfig.sh
+
 # lxdialog stuff
 check-lxdialog  := $(srctree)/$(src)/lxdialog/check-lxdialog.sh
 
@@ -205,7 +208,17 @@ $(addprefix $(obj)/, mconf.o $(lxdialog)
 $(obj)/dochecklxdialog:
 	$(Q)$(CONFIG_SHELL) $(check-lxdialog) -check $(HOSTCC) $(HOST_EXTRACFLAGS) $(HOSTLOADLIBES_mconf)
 
-always := dochecklxdialog
+# Check that we have pkg-config (used by each of menu/n/g/xconfig)
+PHONY += $(obj)/docheckpkgconfig
+$(addprefix $(obj)/, mconf.o): $(obj)/docheckpkgconfig
+$(addprefix $(obj)/, nconf.o): $(obj)/docheckpkgconfig
+$(addprefix $(obj)/, gconf.o): $(obj)/docheckpkgconfig
+$(addprefix $(obj)/, qconf.o): $(obj)/docheckpkgconfig
+
+$(obj)/docheckpkgconfig:
+	$(Q)$(CONFIG_SHELL) $(check-pkgconfig)
+
+always := docheckpkgconfig dochecklxdialog
 
 # Add environment specific flags
 HOST_EXTRACFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTCC) $(HOSTCFLAGS))
--- /dev/null
+++ lnx-416-rc3/scripts/kconfig/check-pkgconfig.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Check for pkg-config presence
+
+pkgcfg=`which pkg-config >/dev/null 2>&1`
+found=$?
+
+if [ $found -ne 0 ]; then
+	echo "'make *config' requires 'pkg-config'. Please install it." 1>&2
+	exit 1		# error
+fi
+
+exit 0
