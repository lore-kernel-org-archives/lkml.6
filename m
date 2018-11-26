Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9582FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D88C2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lts3Mj12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D88C2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbeKZV7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:59:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:44658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730306AbeKZV67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:58:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D74C320645;
        Mon, 26 Nov 2018 11:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230313;
        bh=ulFhwUeNe/LluiiySnEZFDa7hjFaG46UL7JSXFWPfF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lts3Mj12vp546juSBocThVdWTTHb6qV/KuX7r+INCxqt83mPkx4SeyZ0Q2cS2jUmb
         oyGrlOH+Hl970pm8Hh57R9s+PbcV4tbbq63E5QVzXX9hKJK8IxPct4lvB+p3xmfWkE
         IXgdYxO7gGZP7/GdceW5XvFHLPKFtlRs2VgZxwZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Smythies <dsmythies@telus.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 089/118] kbuild: deb-pkg: fix too low build version number
Date:   Mon, 26 Nov 2018 11:51:23 +0100
Message-Id: <20181126105105.279445006@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



