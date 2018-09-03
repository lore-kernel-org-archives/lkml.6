Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12BAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594EC20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZIEAe1b5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594EC20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeICOWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:22:54 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:36731 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbeICOWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:22:53 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w83A2AsZ026175;
        Mon, 3 Sep 2018 19:02:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w83A2AsZ026175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535968933;
        bh=5DEAVLYNT2UxIc616OOqQRoQO73TpNyg7DB67C2ydDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZIEAe1b5hVqzmTTdqTk65ggCp/B91lTLI3PlR2aJpElNlFIwFVjhtSO1N/ALniKyW
         jlX32qyPjiR01h5/6PEKd62ptEh5l7One5QyuU4HIukZZyC9a98trw7r7j3nYQx50h
         bWfnyy71L8YJED3tEjnkkJ8DlsKBIZ49pSJSso+oi23++Va/7TjpJGhku6dONzC7MO
         vd4vRc8wnwpJUR6wWdr51GOhguuRyTxjmZE5yh2ITznAvaWvPz79Z8XvUmIqDDP3Xi
         c7CMO25i9kfBXJuAnmokTZokzG9YG6pfe4dadXu98By3Tfq3YNAQFLnSeKkxaVPL7z
         luWiR1boZZdeQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        =?UTF-8?q?Michal=20Such=8F=AB=A1nek?= <msuchanek@suse.de>,
        Takashi Iwai <tiwai@suse.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] kbuild: rpm-pkg: hard-code ARCH in RPM SPEC file
Date:   Mon,  3 Sep 2018 19:01:55 +0900
Message-Id: <1535968916-9159-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535968916-9159-1-git-send-email-yamada.masahiro@socionext.com>
References: <1535968916-9159-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel source package contains the .config, which is ARCH-specific.
Obviously, the target architecture is specified when you create a
source package, instead of build-time.

Record ARCH= in the spec file in order to avoid uncertainty about
what ARCH should be given for building.

Add 'ExclusiveArch' tag to stop building immediately in case a user
tries to build it for an unintended architecture.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/package/mkspec | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index e05646d..f72c46a 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -26,6 +26,14 @@ if grep -q CONFIG_DRM=y .config; then
 	PROVIDES=kernel-drm
 fi
 
+if [ "$ARCH" = ia64 ]; then
+	INSTALL_IMAGE="mkdir -p %{buildroot}/boot/efi
+	cp $KBUILD_IMAGE %{buildroot}/boot/efi/vmlinuz-$KERNELRELEASE
+	ln -s efi/vmlinuz-$KERNELRELEASE %{buildroot}/boot/"
+else
+	INSTALL_IMAGE="cp $KBUILD_IMAGE %{buildroot}/boot/vmlinuz-$KERNELRELEASE"
+fi
+
 PROVIDES="$PROVIDES kernel-$KERNELRELEASE"
 __KERNELRELEASE=$(echo $KERNELRELEASE | sed -e "s/-/_/g")
 EXCLUDES="$RCS_TAR_IGNORE --exclude=.tmp_versions --exclude=*vmlinux* \
@@ -47,6 +55,7 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
 	Vendor: The Linux Community
 	URL: http://www.kernel.org
 $S	Source: kernel-$__KERNELRELEASE.tar.gz
+	ExclusiveArch: $UTS_MACHINE
 	Provides: $PROVIDES
 	%define __spec_install_post /usr/lib/rpm/brp-compress || :
 	%define debug_package %{nil}
@@ -78,19 +87,13 @@ $S	%prep
 $S	%setup -q
 $S
 $S	%build
-$S	make %{?_smp_mflags} KBUILD_BUILD_VERSION=%{release}
+$S	make %{?_smp_mflags} ARCH=$ARCH KBUILD_BUILD_VERSION=%{release}
 $S
 	%install
 	mkdir -p %{buildroot}/boot
-	%ifarch ia64
-	mkdir -p %{buildroot}/boot/efi
-	cp \$(make image_name) %{buildroot}/boot/efi/vmlinuz-$KERNELRELEASE
-	ln -s efi/vmlinuz-$KERNELRELEASE %{buildroot}/boot/
-	%else
-	cp \$(make image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
-	%endif
-$M	make %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} KBUILD_SRC= modules_install
-	make %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr KBUILD_SRC= headers_install
+	$INSTALL_IMAGE
+$M	make %{?_smp_mflags} ARCH=$ARCH INSTALL_MOD_PATH=%{buildroot} KBUILD_SRC= modules_install
+	make %{?_smp_mflags} ARCH=$ARCH INSTALL_HDR_PATH=%{buildroot}/usr KBUILD_SRC= headers_install
 	cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
 	cp .config %{buildroot}/boot/config-$KERNELRELEASE
 	bzip2 -9 --keep vmlinux
-- 
2.7.4

