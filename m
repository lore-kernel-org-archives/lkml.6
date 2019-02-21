Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67E4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C2E2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="MBsd3o3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfBUWTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:19:34 -0500
Received: from imap.cs.msu.ru ([188.44.42.39]:59130 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfBUWTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SXTs9j7bjGPwnQlQTodGJ6m2ghylAbZ8OqB+UBcpj8M=; b=MBsd3o3SDi87jLQLudYHZ6HTBg
        ytv3HBc2rsnH0pG+R4duyOC7oXTpyPRPbrb6JJFqZlAqyz5OeGj/HH6kVhm9u7/nw1/QidzmcXpjI
        2iG8s2xMUj2BrFlOAPq422DVd0OoQnf8i3pVK3W/vInVnEnnO+7j5aFSY1T7t/pukcFql4cK8nlOC
        CIL3MNNuYIzj1LmLFIjAuhUfCDSr966qu0DkLcKkanAnot/Y2dsi8d1XosgNcYZiPlTy+OVFml18s
        UE65qzAGZCtLDMLhv3GH8ED1rWG2tWsu4DDbmevZ/ZPnQRVaGVylFchFeoLmQZ6VYKmUT4uV6oOhD
        GxsAp79g==;
Received: from [37.204.119.143] (port=58724 helo=localhost.localdomain)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1gwwNm-0004BO-Ka; Fri, 22 Feb 2019 00:59:54 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arseny Maslennikov <ar@cs.msu.ru>,
        Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>
Date:   Fri, 22 Feb 2019 00:58:59 +0300
Message-Id: <20190221215901.23970-3-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221215901.23970-1-ar@cs.msu.ru>
References: <20190221215901.23970-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: [PATCH] scripts/package/mkdebian: expose KCONFIG_CONFIG to debian/rules
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If KCONFIG_CONFIG is passed to `make deb-pkg` as a makeflag or
environment variable, the source tarball produced contains whatever
specified by that variable instead of the usual `.config'.

While `make deb-pkg' yields a correct Debian binary package (at least
on amd64), the generated source package's debian/rules does not pass
KCONFIG_CONFIG to make(1), thus rendering the source package unable to
be rebuilt.

Steps to reproduce the kind of failure being fixed:
1)  Produce a source and binary package with:
	% KCONFIG_CONFIG=my.config make deb-pkg
2)  In the parent directory:
	% dpkg-source -x linux-*.dsc
3)  In the unpacked source directory:
	% debuild -i -us -uc

Here is an excerpt from an example output of `debuild -i -us -uc':

make[2]: *** No rule to make target '.config', needed by 'kernel/config_data.gz'.  Stop.
make[1]: *** [Makefile:1043: kernel] Error 2
make[1]: Leaving directory '/home/ar/linux-kernel/deb/linux-5.0.0-rc5-tks-gitd6ff78479ec5-57-5.0.0-rc5-tks-gitd6ff78479ec5-57'
make: *** [debian/rules:4: build] Error 2
dpkg-buildpackage: error: debian/rules build subprocess returned exit status 2
debuild: fatal error at line 1182:
dpkg-buildpackage -us -uc -ui -i failed

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 scripts/package/mkdebian | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index edcad61fe3cd..130d3f6696eb 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -207,10 +207,12 @@ cat <<EOF > debian/rules
 
 build:
 	\$(MAKE) KERNELRELEASE=${version} ARCH=${ARCH} \
+	KCONFIG_CONFIG=${KCONFIG_CONFIG} \
 	KBUILD_BUILD_VERSION=${revision} KBUILD_SRC=
 
 binary-arch:
 	\$(MAKE) KERNELRELEASE=${version} ARCH=${ARCH} \
+	KCONFIG_CONFIG=${KCONFIG_CONFIG} \
 	KBUILD_BUILD_VERSION=${revision} KBUILD_SRC= intdeb-pkg
 
 clean:
-- 
2.20.1

