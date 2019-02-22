Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF3BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B85207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ttIW8bSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfBVH4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:56:30 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:44700 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfBVH4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:56:30 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x1M7uAvx019643;
        Fri, 22 Feb 2019 16:56:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x1M7uAvx019643
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550822171;
        bh=nM21wirB0PuY04024D776TjqtWJ2i0UQNqKT/+OVHEA=;
        h=From:To:Cc:Subject:Date:From;
        b=ttIW8bSiFufmjh+SxEYgR6dIwb+p94kHp+cg7eFoaFS0qJCCJ8Hy74yFjiHpO6abd
         lQ+YqBlYIx9Y3dzsvZWZzTjj0+HPcawfD66/W3qOCy4d3jcB6ieGqxeS8q+Ag10n+c
         547SFA+uWqnuIrJ4oMncgilin8atG77bqw0mqvjQzgYvw3oRRI4sB+FSczqhZ+sGOj
         S0k7soTQv/46RkHUD50ieI5SjZ+/1pGsfgtJvYTcCTOVRFjkvSowJAcOWCbQakmpjt
         IgKWJ/rx/DYNiVSNJZly/Wp+lAh5MdQ14mRhI0qh+dly3hbbPYA8utRVF2nfPvKx0E
         fSGSVYLYdiSLg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: move -gsplit-dwarf, -gdwarf-4 option tests to Kconfig
Date:   Fri, 22 Feb 2019 16:56:09 +0900
Message-Id: <1550822169-2561-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_INFO_SPLIT and CONFIG_DEBUG_INFO_DWARF4 enable extra
dwarf options if supported. You never know if they are really enabled
since Makefile may silently turn them off.

The actual behavior will match to the kernel configuration by
testing those compiler flags in the Kconfig stage.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile          | 4 ++--
 lib/Kconfig.debug | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index bf4e77b..0f86257 100644
--- a/Makefile
+++ b/Makefile
@@ -735,14 +735,14 @@ DEBUG_CFLAGS	:= $(call cc-option, -fno-var-tracking-assignments)
 
 ifdef CONFIG_DEBUG_INFO
 ifdef CONFIG_DEBUG_INFO_SPLIT
-DEBUG_CFLAGS	+= $(call cc-option, -gsplit-dwarf, -g)
+DEBUG_CFLAGS	+= -gsplit-dwarf
 else
 DEBUG_CFLAGS	+= -g
 endif
 KBUILD_AFLAGS	+= -Wa,-gdwarf-2
 endif
 ifdef CONFIG_DEBUG_INFO_DWARF4
-DEBUG_CFLAGS	+= $(call cc-option, -gdwarf-4,)
+DEBUG_CFLAGS	+= -gdwarf-4
 endif
 
 ifdef CONFIG_DEBUG_INFO_REDUCED
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d4df5b2..dfc9949 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -179,6 +179,7 @@ config DEBUG_INFO_REDUCED
 config DEBUG_INFO_SPLIT
 	bool "Produce split debuginfo in .dwo files"
 	depends on DEBUG_INFO
+	depends on $(cc-option,-gsplit-dwarf)
 	help
 	  Generate debug info into separate .dwo files. This significantly
 	  reduces the build directory size for builds with DEBUG_INFO,
@@ -194,6 +195,7 @@ config DEBUG_INFO_SPLIT
 config DEBUG_INFO_DWARF4
 	bool "Generate dwarf4 debuginfo"
 	depends on DEBUG_INFO
+	depends on $(cc-option,-gdwarf-4)
 	help
 	  Generate dwarf4 debug info. This requires recent versions
 	  of gcc and gdb. It makes the debug information larger.
-- 
2.7.4

