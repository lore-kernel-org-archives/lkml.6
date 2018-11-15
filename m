Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C79C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F86D223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="L7rqx2ZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F86D223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbeKOSfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:35:23 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:50699 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbeKOSfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:35:23 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAF8RHof022794;
        Thu, 15 Nov 2018 17:27:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAF8RHof022794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542270445;
        bh=DnGgUS0hhg+x1SY/xfxll6SbL2Lqbmk3WkFzwR2jry8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7rqx2ZS6V0DNS+uB7DyfJv3kfc1SQ4bigwyicQgfbYpJvBlIA/Uoljp7yBdPeeTO
         5VmYTeuAcrRgKoPkmkM6ZTTEoGOwDG5+1mecng/bAsPmURhbgYXY84+VM/53IIVH3r
         EPJaUKRNnfGPcFBkV9WGkUCWPJyabs7AllWmyY6cHwOKszbs8Grt6Iz09jm+3MGfj4
         fWYgGMfESUneB7wSMAuHsBLlSFRcf7AYkTu7enF8TFvSbP7RxZES0WiCWZ/W+paMu4
         Szi0Shk28l9NWHsKXOJFmb2xt+JiyaytNfrnbFQip/aIsrfgAmnFmG3+V/+8V5v4MR
         b1w/VrXgVnygw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] kbuild: remove redundant 'set -e' from cmd_* defines
Date:   Thu, 15 Nov 2018 17:27:15 +0900
Message-Id: <1542270435-11181-9-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These three cmd_* are invoked in the $(call cmd,*) form.

Now that 'set -e' moved to the 'cmd' macro, they do not need to
explicitly give 'set -e'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build   | 2 --
 scripts/package/Makefile | 1 -
 2 files changed, 3 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 0f28df2..0bb8d9a 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -134,7 +134,6 @@ cmd_gensymtypes_c =                                                         \
 
 quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
 cmd_cc_symtypes_c =                                                         \
-    set -e;                                                                 \
     $(call cmd_gensymtypes_c,true,$@) >/dev/null;                           \
     test -s $@ || rm -f $@
 
@@ -340,7 +339,6 @@ cmd_gensymtypes_S =                                                         \
 
 quiet_cmd_cc_symtypes_S = SYM $(quiet_modtag) $@
 cmd_cc_symtypes_S =                                                         \
-    set -e;                                                                 \
     $(call cmd_gensymtypes_S,true,$@) >/dev/null;                           \
     test -s $@ || rm -f $@
 
diff --git a/scripts/package/Makefile b/scripts/package/Makefile
index 73503eb..453fece 100644
--- a/scripts/package/Makefile
+++ b/scripts/package/Makefile
@@ -33,7 +33,6 @@ MKSPEC     := $(srctree)/scripts/package/mkspec
 
 quiet_cmd_src_tar = TAR     $(2).tar.gz
       cmd_src_tar = \
-set -e; \
 if test "$(objtree)" != "$(srctree)"; then \
 	echo >&2; \
 	echo >&2 "  ERROR:"; \
-- 
2.7.4

