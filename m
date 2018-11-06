Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2060EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 04:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACF72083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 04:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="WT6p/MHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACF72083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbeKFNmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 08:42:15 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:43919 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeKFNmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 08:42:15 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wA64ICCL015516;
        Tue, 6 Nov 2018 13:18:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wA64ICCL015516
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541477893;
        bh=EzqAHMsSVEO6RvFBEzGv1+Z7UJwHLm3/xZ9Z3getqyE=;
        h=From:To:Cc:Subject:Date:From;
        b=WT6p/MHjg/gv7RANEmNb+0g0dTEMJV+uZFLaqq9n6VsphrVR6pUuZFYWDbnhbFlfd
         SN0IHGAdhF/kkVtjCgbsRN2xnLftDpLHtmaOvz8V9cZ6HZxeSajn0oXU3Qi1/qsMRu
         hKNR2OYuo2xcaKCHhgo6O9Hum64LKq2JmWPfKZY4oRO4VQfBv+L6Yqhs9rt/CkwR8e
         sfnxLQ8adss1+ASk0d0mlg1sqb5WKx83/0BV490j128MI2vd/wrs11v69JF2WkcXxv
         mtFluhzjoHKQUDAVxpl4mo3qS7zjS0R1IwXvnr6pdmfuA+4p9xzPd354sep9ZHfZ0t
         SAjsQFWHcim7g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Riku Voipio <riku.voipio@linaro.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Doug Smythies <dsmythies@telus.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: deb-pkg: fix too low build version number
Date:   Tue,  6 Nov 2018 13:18:05 +0900
Message-Id: <1541477885-24875-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b41d920acff8 ("kbuild: deb-pkg: split generating packaging
and build"), the build version of the kernel contained in a deb package
is too low by 1.

Prior to the bad commit, the kernel was built first, then the number
in .version file was read out, and written into the debian control file.

Now, the debian control file is created before the kernel is actually
compiled, which is causing the version number mismatch.

Let the mkdebian script pass KBUILD_BUILD_VERSION=${revision} to require
the build system to use the specified version number.

Fixes: b41d920acff8 ("kbuild: deb-pkg: split generating packaging and build")
Reported-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/package/mkdebian | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 663a7f3..edcad61 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -88,6 +88,7 @@ set_debarch() {
 version=$KERNELRELEASE
 if [ -n "$KDEB_PKGVERSION" ]; then
 	packageversion=$KDEB_PKGVERSION
+	revision=${packageversion##*-}
 else
 	revision=$(cat .version 2>/dev/null||echo 1)
 	packageversion=$version-$revision
@@ -205,10 +206,12 @@ cat <<EOF > debian/rules
 #!$(command -v $MAKE) -f
 
 build:
-	\$(MAKE) KERNELRELEASE=${version} ARCH=${ARCH} KBUILD_SRC=
+	\$(MAKE) KERNELRELEASE=${version} ARCH=${ARCH} \
+	KBUILD_BUILD_VERSION=${revision} KBUILD_SRC=
 
 binary-arch:
-	\$(MAKE) KERNELRELEASE=${version} ARCH=${ARCH} KBUILD_SRC= intdeb-pkg
+	\$(MAKE) KERNELRELEASE=${version} ARCH=${ARCH} \
+	KBUILD_BUILD_VERSION=${revision} KBUILD_SRC= intdeb-pkg
 
 clean:
 	rm -rf debian/*tmp debian/files
-- 
2.7.4

