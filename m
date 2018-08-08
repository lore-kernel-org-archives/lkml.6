Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B82C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31ADD20834
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="AN8Sx5uW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31ADD20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeHHE1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 00:27:03 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:39905 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeHHE1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 00:27:02 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w78294Sr032644;
        Wed, 8 Aug 2018 11:09:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w78294Sr032644
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533694145;
        bh=exAGJKse59mH3XH4EdZSemDwbM/FbaW9BJsM6kcv89I=;
        h=From:To:Cc:Subject:Date:From;
        b=AN8Sx5uWFBeWeH2SBIcKv5nCSWlceQsFR6CThAvuj1rFkp390KJZqN18TqT4Qd+yk
         2JpPdV08QbB7JSB/8F/z6aPLV/FSkhzF6JBzsIHEmiTEZZALK++RJ2Avby88Nn9t1O
         8k6utWWDddDaHl959HhkVywx9QG9W49JEb1iy9T3YFMli0++j+LeQGGb8uxEQacStv
         DExJoVXsctO2TSqThnCQNSQXZUWGfWTU8kxDp2aEfTiAqfhvN70hrdQ05cLH82fzHc
         PSSo6bKl+Ch5hkJTzlaHC4eQLr3qvAPeewf2Yb7U1TEVOZGjGChMavakkZ8UddChP7
         dwcD9IWGBwP/w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: make samples depend on headers_install really
Date:   Wed,  8 Aug 2018 11:08:54 +0900
Message-Id: <1533694134-6703-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel headers must be installed into $(objtree)/usr/include to avoid
the build failure of samples.

Commit ddea05fa148b ("kbuild: make samples depend on headers_install")
addressed this, but "samples/" is only used for the single target build.

"make samples/" correctly installs kernel headers, but it does not
work for general building because a phony target "sample" (no tailing
backslash) is used.

Reported-by: David Howells <dhowells@redhat.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

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

