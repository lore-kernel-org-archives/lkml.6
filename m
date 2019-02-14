Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB11C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A25E20811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xa9xx55x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395215AbfBNDGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:06:07 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:64387 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfBNDGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:06:06 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1E35Pg2020814;
        Thu, 14 Feb 2019 12:05:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1E35Pg2020814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550113525;
        bh=yO8RC+IzX+7q6ObGuUgOsgj+kpMFLH2G7hMx94CJuxg=;
        h=From:To:Cc:Subject:Date:From;
        b=xa9xx55x3a46jz1CDBYlsEEOL296PAe7Tgo9BkkXj3NBFmssf4NG8Pentf8AbN9u4
         h1Ozqfic48t7KM6Ws3JxYECl69MbPv1M6bOhoJhCBMUFIADfZRQe18F6FoEcTBar+8
         6jZ/A7ZsKVHwZeTd07VyBFEKRsinWNwH0NszGYxDQTpQQ4vaNWtwvwAG9l5QZbpjP0
         6KBUu56t4sa5xPacF5h7NMvHrVDNqnca/uAge8lEVCxlHuD6VBeqoYoO0+N+/Vt5YC
         NuTl95roarog8CttNiwm6d8vB60wLbk+UXGuCZCg31j9CJg3XOzgP5up7BZOoRuer7
         hW4tYZzpZuC/g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] kbuild: pkg: use -f $(srctree)/Makefile to recurse to top Makefile
Date:   Thu, 14 Feb 2019 12:05:14 +0900
Message-Id: <1550113521-23577-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'$(MAKE) KBUILD_SRC=' changes the working directory back and forth
between objtree and srctree.

It is better to recurse to the top-level Makefile directly.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/package/Makefile |  4 ++--
 scripts/package/builddeb | 10 +++++-----
 scripts/package/buildtar |  2 +-
 scripts/package/mkdebian |  6 ++++--
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/scripts/package/Makefile b/scripts/package/Makefile
index 453fece..aa39c2b 100644
--- a/scripts/package/Makefile
+++ b/scripts/package/Makefile
@@ -59,7 +59,7 @@ rpm-pkg: FORCE
 # binrpm-pkg
 # ---------------------------------------------------------------------------
 binrpm-pkg: FORCE
-	$(MAKE) KBUILD_SRC=
+	$(MAKE) -f $(srctree)/Makefile
 	$(CONFIG_SHELL) $(MKSPEC) prebuilt > $(objtree)/binkernel.spec
 	+rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
 		$(UTS_MACHINE) -bb $(objtree)/binkernel.spec
@@ -102,7 +102,7 @@ clean-dirs += $(objtree)/snap/
 # tarball targets
 # ---------------------------------------------------------------------------
 tar%pkg: FORCE
-	$(MAKE) KBUILD_SRC=
+	$(MAKE) -f $(srctree)/Makefile
 	$(CONFIG_SHELL) $(srctree)/scripts/package/buildtar $@
 
 clean-dirs += $(objtree)/tar-install/
diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index f43a274..8ac25d1 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -86,12 +86,12 @@ cp "$($MAKE -s -f $srctree/Makefile image_name)" "$tmpdir/$installed_image_path"
 if grep -q "^CONFIG_OF_EARLY_FLATTREE=y" $KCONFIG_CONFIG ; then
 	# Only some architectures with OF support have this target
 	if [ -d "${srctree}/arch/$SRCARCH/boot/dts" ]; then
-		$MAKE KBUILD_SRC= INSTALL_DTBS_PATH="$tmpdir/usr/lib/$packagename" dtbs_install
+		$MAKE -f $srctree/Makefile INSTALL_DTBS_PATH="$tmpdir/usr/lib/$packagename" dtbs_install
 	fi
 fi
 
 if grep -q '^CONFIG_MODULES=y' $KCONFIG_CONFIG ; then
-	INSTALL_MOD_PATH="$tmpdir" $MAKE KBUILD_SRC= modules_install
+	INSTALL_MOD_PATH="$tmpdir" $MAKE -f $srctree/Makefile modules_install
 	rm -f "$tmpdir/lib/modules/$version/build"
 	rm -f "$tmpdir/lib/modules/$version/source"
 	if [ "$ARCH" = "um" ] ; then
@@ -113,14 +113,14 @@ if grep -q '^CONFIG_MODULES=y' $KCONFIG_CONFIG ; then
 		# resign stripped modules
 		MODULE_SIG_ALL="$(grep -s '^CONFIG_MODULE_SIG_ALL=y' $KCONFIG_CONFIG || true)"
 		if [ -n "$MODULE_SIG_ALL" ]; then
-			INSTALL_MOD_PATH="$tmpdir" $MAKE KBUILD_SRC= modules_sign
+			INSTALL_MOD_PATH="$tmpdir" $MAKE -f $srctree/Makefile modules_sign
 		fi
 	fi
 fi
 
 if [ "$ARCH" != "um" ]; then
-	$MAKE headers_check KBUILD_SRC=
-	$MAKE headers_install KBUILD_SRC= INSTALL_HDR_PATH="$libc_headers_dir/usr"
+	$MAKE -f $srctree/Makefile headers_check
+	$MAKE -f $srctree/Makefile headers_install INSTALL_HDR_PATH="$libc_headers_dir/usr"
 fi
 
 # Install the maintainer scripts
diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index d624a07..cfd2a4a 100755
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -57,7 +57,7 @@ dirs=boot
 # Try to install modules
 #
 if grep -q '^CONFIG_MODULES=y' "${KCONFIG_CONFIG}"; then
-	make ARCH="${ARCH}" O="${objtree}" KBUILD_SRC= INSTALL_MOD_PATH="${tmpdir}" modules_install
+	make ARCH="${ARCH}" -f ${srctree}/Makefile INSTALL_MOD_PATH="${tmpdir}" modules_install
 	dirs="$dirs lib"
 fi
 
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index edcad61..f030961 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -205,13 +205,15 @@ EOF
 cat <<EOF > debian/rules
 #!$(command -v $MAKE) -f
 
+srctree ?= .
+
 build:
 	\$(MAKE) KERNELRELEASE=${version} ARCH=${ARCH} \
-	KBUILD_BUILD_VERSION=${revision} KBUILD_SRC=
+	KBUILD_BUILD_VERSION=${revision} -f \$(srctree)/Makefile
 
 binary-arch:
 	\$(MAKE) KERNELRELEASE=${version} ARCH=${ARCH} \
-	KBUILD_BUILD_VERSION=${revision} KBUILD_SRC= intdeb-pkg
+	KBUILD_BUILD_VERSION=${revision} -f \$(srctree)/Makefile intdeb-pkg
 
 clean:
 	rm -rf debian/*tmp debian/files
-- 
2.7.4

