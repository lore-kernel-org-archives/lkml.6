Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880A6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389DD208F7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Wx77KgRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389DD208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbeGPMsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:48:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44918 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731096AbeGPMsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:48:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id d17-v6so17729485eds.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 05:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qu+bT7PO79vqYWmK/HljxHsQAW+8guyzbN9/q2IIU2E=;
        b=Wx77KgRp52cggbrbkIxxAeqouIrDNtpsN15HzRltDqrJiE5APXqULFAHUF3xOKdaMO
         Fy8jTQgJ6im00gve/rIgN0XN7RDMHBPaYKHYUhoHp1GwxtJ/lCYGfKo1hUlDWPE3eexF
         28CrNZZM1sKHUsY4AvmxOt1PqMo1Y3R2vIaMZdBKt0BWKMH41ru15VCV/b/9cMgwe809
         4lQgnDN/z6GJV3t3f+pSnzcEoqDKhI+TaCpd3l3anmmT7cXnLvzGBTzBAttWKSyhfKk9
         W1cukE10fSFxba6/pk0ATzTUfVpSuAoa9bXICvF+wbhhRrUy75kJC5kjNwPR1U0h/kPW
         m46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qu+bT7PO79vqYWmK/HljxHsQAW+8guyzbN9/q2IIU2E=;
        b=ef3EFhqLTu9g2VhS/wPQH2i4pjphwY3hSQi/AXKXqvys2bODKBMWiBYVKIy+46Xzzx
         KOYL4yWIjSaqpHnBTGfRpTqL9g+WRS5H3H7SZ38sMNM73YLt7RoOYc8KLV9R9YQJCubM
         +pfetUtMKsHD7sPdUG2VqdVSIKx8gBDZKOMgtA5pmsHX1EhSPfTJGJsvdzAxu64GshGh
         PEKY4eQQokg+zr003lF76QTCwu9W2OUcWE8x5SIXOB0d5m4JW5CJlHsryKU8LvbLdSDA
         J80DiHeT3ehppXR/7ZYlIW120VwopzH/pSZQnri2GIUBf2MweJ6OkwNii6TwMx406h0p
         SDKw==
X-Gm-Message-State: AOUpUlEKchZXxxiZRSm8/Arl3N11UFdUoKELIwrRkOSJPMOpbx7qCJB8
        7QT0T8UDTGBrRnY09MwCmg8pQHyhU00=
X-Google-Smtp-Source: AAOMgpcZSdUIiA9zKztW4es5dig2R5tins3PQjWL4rRvGpw5dBvqjAWeoBypi1H+j1UsCVyG6/wXwg==
X-Received: by 2002:aa7:c0c9:: with SMTP id j9-v6mr17324330edp.135.1531743699064;
        Mon, 16 Jul 2018 05:21:39 -0700 (PDT)
Received: from maco.fcp3.net (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id a9-v6sm4635471edi.26.2018.07.16.05.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 05:21:38 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Martijn Coenen <maco@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-scsi@vger.kernel.org,
        linux-arch@vger.kernel.org, maco@google.com, sspatil@google.com,
        malchev@google.com, joelaf@google.com
Subject: [PATCH 5/6] scripts: Coccinelle script for namespace dependencies.
Date:   Mon, 16 Jul 2018 14:21:24 +0200
Message-Id: <20180716122125.175792-6-maco@android.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180716122125.175792-1-maco@android.com>
References: <20180716122125.175792-1-maco@android.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A script that uses the '<module>.ns_deps' file generated by modpost to
automatically add the required symbol namespace dependencies to each
module.

Usage:
1) Move some symbols to a namespace with EXPORT_SYMBOL_NS()
2) Run 'make' (or 'make modules'), get warnings about modules not
   importing that namespace
3) Run 'make nsdeps' to automatically add required import statements
   to said modules

This makes it easer for subsystem maintainers to introduce and maintain
symbol namespaces into their codebase.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 Makefile                    | 11 ++++++++++
 scripts/Makefile.modpost    |  4 +++-
 scripts/add_namespace.cocci | 19 +++++++++++++++++
 scripts/nsdeps              | 41 +++++++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 scripts/add_namespace.cocci
 create mode 100644 scripts/nsdeps

diff --git a/Makefile b/Makefile
index 925c55f2524f..96e62d732a3b 100644
--- a/Makefile
+++ b/Makefile
@@ -1391,6 +1391,9 @@ help:
 	@echo  '  headerdep       - Detect inclusion cycles in headers'
 	@echo  '  coccicheck      - Check with Coccinelle'
 	@echo  ''
+	@echo  'Tools:'
+	@echo  '  nsdeps          - Generate missing symbol namespace dependencies'
+	@echo  ''
 	@echo  'Kernel selftest:'
 	@echo  '  kselftest       - Build and run kernel selftest (run as root)'
 	@echo  '                    Build, install, and boot kernel before'
@@ -1566,6 +1569,14 @@ quiet_cmd_tags = GEN     $@
 tags TAGS cscope gtags: FORCE
 	$(call cmd,tags)
 
+# Script to generate missing namespace dependencies
+
+PHONY += nsdeps
+
+nsdeps:
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost nsdeps
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/$@
+
 # Scripts to check various things for consistency
 # ---------------------------------------------------------------------------
 
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index df4174405feb..a9a90c3e3879 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -79,7 +79,8 @@ modpost = scripts/mod/modpost                    \
  $(if $(KBUILD_EXTMOD),-o $(modulesymfile))      \
  $(if $(CONFIG_DEBUG_SECTION_MISMATCH),,-S)      \
  $(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)  \
- $(if $(KBUILD_EXTMOD)$(KBUILD_MODPOST_WARN),-w)
+ $(if $(KBUILD_EXTMOD)$(KBUILD_MODPOST_WARN),-w) \
+ $(if $(filter nsdeps,$(MAKECMDGOALS)),-d)
 
 MODPOST_OPT=$(subst -i,-n,$(filter -i,$(MAKEFLAGS)))
 
@@ -130,6 +131,7 @@ $(modules): %.ko :%.o %.mod.o FORCE
 
 targets += $(modules)
 
+nsdeps: _modpost
 
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
diff --git a/scripts/add_namespace.cocci b/scripts/add_namespace.cocci
new file mode 100644
index 000000000000..a6d33e066067
--- /dev/null
+++ b/scripts/add_namespace.cocci
@@ -0,0 +1,19 @@
+@has_ns_import@
+declarer name MODULE_IMPORT_NS;
+identifier virtual.ns;
+@@
+MODULE_IMPORT_NS(ns);
+
+@has_module_license@
+declarer name MODULE_LICENSE;
+expression license;
+@@
+MODULE_LICENSE(license);
+
+@do_import depends on has_module_license && !has_ns_import@
+declarer name MODULE_LICENSE;
+expression license;
+identifier virtual.ns;
+@@
+MODULE_LICENSE(license);
++ MODULE_IMPORT_NS(ns);
diff --git a/scripts/nsdeps b/scripts/nsdeps
new file mode 100644
index 000000000000..5678e02626b3
--- /dev/null
+++ b/scripts/nsdeps
@@ -0,0 +1,41 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Linux kernel symbol namespace import generator
+#
+# This script requires at least spatch
+# version 1.0.6.
+SPATCH_REQ_VERSION="1.0.6"
+
+DIR="$(dirname $(readlink -f $0))/.."
+SPATCH="`which ${SPATCH:=spatch}`"
+if [ ! -x "$SPATCH" ]; then
+    echo 'spatch is part of the Coccinelle project and is available at http://coccinelle.lip6.fr/'
+    exit 1
+fi
+
+SPATCH_REQ_VERSION_NUM=$(echo $SPATCH_REQ_VERSION | ${DIR}/scripts/ld-version.sh)
+SPATCH_VERSION=$($SPATCH --version | head -1 | awk '{print $3}')
+SPATCH_VERSION_NUM=$(echo $SPATCH_VERSION | ${DIR}/scripts/ld-version.sh)
+
+if [ "$SPATCH_VERSION_NUM" -lt "$SPATCH_REQ_VERSION_NUM" ] ; then
+    echo 'spatch needs to be version 1.06 or higher'
+    exit 1
+fi
+
+generate_deps_for_ns() {
+    $SPATCH --very-quiet --in-place --sp-file $srctree/scripts/add_namespace.cocci -D ns=$1 $2
+}
+
+generate_deps() {
+    local mod_file=`echo $@ | sed -e 's/\.ns_deps/\.mod/'`
+    local mod_name=`cat $mod_file | sed -n 1p | sed -e 's/\/[^.]*$//'`
+    local mod_source_files=`cat $mod_file | sed -n 2p | sed -e 's/\.o/\.c/'`
+    for ns in `cat $@`; do
+	echo "Adding namespace $ns to module $mod_name (if needed)."
+        generate_deps_for_ns $ns $mod_source_files
+    done
+}
+
+for f in `find $srctree/.tmp_versions/ -name *.ns_deps`; do
+    generate_deps $f
+done
-- 
2.18.0.203.gfac676dfb9-goog

