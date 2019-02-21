Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B4DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF8420818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="KxX03O/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfBUWTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:19:23 -0500
Received: from imap.cs.msu.ru ([188.44.42.39]:54283 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfBUWTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:19:21 -0500
X-Greylist: delayed 1160 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Feb 2019 17:19:19 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:
        To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6N2j+bNL0gOJ2tzgrtS3/j2GtU2hhi8XT+54g8td/EY=; b=KxX03O/Wc040AkdSOaxPTcdrJ0
        UWTkAeY548ZYK90IhdrEOF/4r2pP+1eCObsk7rmK229I01Be1GdITnF3WHsXon1vF6bBIaNYgETls
        2Nz3HliKIQutyJwflh5+pvrb8uuYfvsbj2Q0sryvbmsCJnhcNMrtGQ0nrtkEkq7Mt9onMbY2iH5LH
        lIJL3w1oeYl1ZVOPPIiJbwhzojfvu1V1uq3pvbQkgBpO7hFJ5HDYIujISJG8YEmTQb2kw6LPUiGfr
        BD3UE/48kxk/90cVuvis/jWYPZvlZsa7JP28+SHFpfFVmI52RiDPAPj9Xiep5ONs1i6fDm4z/Zjec
        iH1UJY2w==;
Received: from [37.204.119.143] (port=58724 helo=localhost.localdomain)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1gwwNh-0004BO-PF; Fri, 22 Feb 2019 00:59:49 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arseny Maslennikov <ar@cs.msu.ru>,
        Riku Voipio <riku.voipio@linaro.org>
Date:   Fri, 22 Feb 2019 00:58:57 +0300
Message-Id: <20190221215901.23970-1-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: [PATCH] scripts/package/Makefile: put proper config in source tarball
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is widely known that one can build a kernel without a .config in the
source tree by setting KCONFIG_CONFIG equal to the actual configuration
file path.

When making a *-pkg target, make(1) prepares a source tarball and tries
to pack `.config' in there regardless of the value of KCONFIG_CONFIG,
failing spectacularly if .config is absent and packing the wrong config
if it exists.
Let's fix that.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 scripts/package/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/Makefile b/scripts/package/Makefile
index 453fecee62f0..100a0d28ad25 100644
--- a/scripts/package/Makefile
+++ b/scripts/package/Makefile
@@ -27,7 +27,7 @@ KDEB_SOURCENAME ?= linux-$(KERNELRELEASE)
 KBUILD_PKG_ROOTCMD ?="fakeroot -u"
 export KDEB_SOURCENAME
 # Include only those top-level files that are needed by make, plus the GPL copy
-TAR_CONTENT := $(KBUILD_ALLDIRS) .config .scmversion Makefile \
+TAR_CONTENT := $(KBUILD_ALLDIRS) $(KCONFIG_CONFIG) .scmversion Makefile \
                Kbuild Kconfig COPYING $(wildcard localversion*)
 MKSPEC     := $(srctree)/scripts/package/mkspec
 
-- 
2.20.1

