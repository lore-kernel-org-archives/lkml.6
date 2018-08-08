Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753F0C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B272152A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GO1LCVSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B272152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeHHEcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 00:32:19 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:37728 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeHHEcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 00:32:18 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w782EIlo004152;
        Wed, 8 Aug 2018 11:14:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w782EIlo004152
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533694459;
        bh=lz55LlsaXOwcAuOwTiLk3BFAF92eA/fNIvzieH95kvw=;
        h=From:To:Cc:Subject:Date:From;
        b=GO1LCVSLWopwYoCoiJZX8oZIBU7+wyXtGE5M94hh+4WZmxWofcE3koPRtxGHeBFvx
         R7Sd3AtjKhNxl2Fvmb1YLukqkppsw5qqqhby0ApJ9dK5CI+Lf/h5AgUcGgxLWHsoNE
         IzG2fCNbB1ZSBphDh3CkjI77cHAPFcz89BRd4rgDHBELuVmKf71/lUT3Tsp7MfRwk4
         Cq3YZegLyGdACCMpHqws4H7hqWDY42s5g09odQa/2I3YncB6qbLE5ggqkYOuDvMYG/
         lQwUk32H8w6gFWP/MsCiCubofBDbYm6XY1j66RnxBxwAFDimCnfcUSeuP1H5Qb6HjC
         hCn1eJ0QbOjMg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kbuild: make samples really depend on headers_install
Date:   Wed,  8 Aug 2018 11:14:14 +0900
Message-Id: <1533694454-7086-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel headers must be installed into $(objtree)/usr/include to avoid
the build failure of samples.

Commit ddea05fa148b ("kbuild: make samples depend on headers_install")
addressed this, but "samples/" is only used for the single target build.

"make samples/" properly installs kernel headers, but it does not work
for general building because a phony target "sample" (no trailing slash)
is used.

Reported-by: David Howells <dhowells@redhat.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Correct commit log (backslash -> slash)
  - Fix a typo

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7a3c454..1e47d13 100644
--- a/Makefile
+++ b/Makefile
@@ -1009,9 +1009,10 @@ ifdef CONFIG_GDB_SCRIPTS
 endif
 	+$(call if_changed,link-vmlinux)
 
-# Build samples along the rest of the kernel
+# Build samples along the rest of the kernel. This needs headers_install.
 ifdef CONFIG_SAMPLES
 vmlinux-dirs += samples
+samples: headers_install
 endif
 
 # The actual objects are generated when descending,
-- 
2.7.4

