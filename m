Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F065C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9FD22513
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftcM1fdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9FD22513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbeKOI2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:28:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729131AbeKOI12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:28 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89C2E22527;
        Wed, 14 Nov 2018 22:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234145;
        bh=PI+hZZNFGUt+emewcGFBoB5orr2rU7k1HOxK1T4GxAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ftcM1fdvpZvicG3uP91MTWZRkdGkDgdl6iFugdrEtxQnKPaStyXMdhoqTriywdBdk
         s4EdZqk5Uk0V4hnDBRXmnVGM8BppX8H4e+lhyx2sC+AvM0ZaEqed5jU0MDa5UrWcWm
         ktq+H4jlA57m0voTZr9gaJhW06tkNHnq8nIzIm1s=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 71/73] kbuild: deb-pkg: fix too low build version number
Date:   Wed, 14 Nov 2018 17:22:05 -0500
Message-Id: <20181114222207.98701-71-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit bbcde0a7241261cd0ca8d8e6b94a4113a4b71443 ]

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
Tested-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/package/mkdebian | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 663a7f343b42..edcad61fe3cd 100755
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
2.17.1

