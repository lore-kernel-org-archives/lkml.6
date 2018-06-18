Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC74BC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1D2208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1D2208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932325AbeFRE4a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 00:56:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:60399 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754672AbeFRE41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 00:56:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BE234AB32;
        Mon, 18 Jun 2018 04:56:25 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Date:   Mon, 18 Jun 2018 14:55:20 +1000
Subject: [PATCH 5/5] kbuild: Add documentation for modobj-m
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Message-ID: <152929772056.17463.10310561149828315203.stgit@noble>
In-Reply-To: <152929708853.17463.17302660556961083137.stgit@noble>
References: <152929708853.17463.17302660556961083137.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for building modules
from multiple directories using modobj-m.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 Documentation/kbuild/makefiles.txt |   65 ++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 048fc39a6b91..985a60cf0663 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -225,17 +225,74 @@ more details, with real examples.
 	part of the composite object ext2.o if $(CONFIG_EXT2_FS_XATTR)
 	evaluates to 'y'.
 
+	If you wish to include code in some other directory into a
+	module, that directory should be configured to create a
+	mod.a target from the relevant code, as described below.
+	The list of components for the module (e.g. foo-y) should
+	then contain the name of the directory (with trailing /).
+	The mod.a from that directory will be built and included
+	into this module.
+
 	Note: Of course, when you are building objects into the kernel,
 	the syntax above will also work. So, if you have CONFIG_EXT2_FS=y,
 	kbuild will build an ext2.o file for you out of the individual
 	parts and then link this into built-in.a, as you would expect.
 
---- 3.4 Objects which export symbols
+--- 3.4 Loadable modules from multiple directories - modobj-m
+
+	One way to build modules with source from multiple directories
+	is to list relative path names of all source files in a
+	single Makefile.
+
+	Example:
+		btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) += tests/free-space-tests.o \
+		        tests/extent-buffer-tests.o tests/btrfs-tests.o \
+		....
+
+	This works, but defeats the ability to build individual
+	directories, or individual target files such as assembly
+	language targets.
+
+	Example:
+		make btrfs/tests/free-space-tests.s
+
+	A more general way is to create a mod.a file using modobj-m
+
+	Example:
+		modobj-$(CONFIG_LUSTRE_FS) += fid_request.o fid_lib.o lproc_fid.o
+
+	modobj-y is treated identically to obj-y so if CONFIG_LUSTRE_FS=y
+	then these objects are built in to the kernel.  If
+	CONFIG_LUSTRE_FS=m then these objects are gathered into an archive
+	called mod.a.  Archives from other directories can be included
+	by listing the directories in modobj-m, so
+
+	Example:
+		modobj-$(CONFIG_LUSTRE_FS) += fid/ fld/
+
+	This will create a mod.a in the same directory as the
+	Makefile, combining the contents of mod.a from the listed
+	directories.  The mod.a can instead be included into a module
+	by listing the directory with any other local object files.
+
+	Example:
+		obj-$(CONFIG_LUSTRE_FS) += lustre.o
+		lustre-y := module.o
+		lustre-y += obdclass/ ldlm/ ptlrpc/ fld/ osc/ mgc/
+
+	When CONFIG_LUSTRE_FS=m, kbuild will build lustre.ko from module.o and
+	the mod.a archives created in the listed directories.
+
+	When components of a module are built in a different directory
+	kbuild cannot determine the name of the module so the
+	KBUILD_MODNAME macro is left undefined.
+
+--- 3.5 Objects which export symbols
 
 	No special notation is required in the makefiles for
 	modules exporting symbols.
 
---- 3.5 Library file goals - lib-y
+--- 3.6 Library file goals - lib-y
 
 	Objects listed with obj-* are used for modules, or
 	combined in a built-in.a for that specific directory.
@@ -263,7 +320,7 @@ more details, with real examples.
 
 	Use of lib-y is normally restricted to lib/ and arch/*/lib.
 
---- 3.6 Descending down in directories
+--- 3.7 Descending down in directories
 
 	A Makefile is only responsible for building objects in its own
 	directory. Files in subdirectories should be taken care of by
@@ -290,7 +347,7 @@ more details, with real examples.
 	names. This allows kbuild to totally skip the directory if the
 	corresponding CONFIG_ option is neither 'y' nor 'm'.
 
---- 3.7 Compilation flags
+--- 3.8 Compilation flags
 
     ccflags-y, asflags-y and ldflags-y
 	These three flags apply only to the kbuild makefile in which they


