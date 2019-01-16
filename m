Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538C4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225FB20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tfopv3kf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbfAPC51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:57:27 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:49547 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfAPC50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:57:26 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x0G2uksS010468;
        Wed, 16 Jan 2019 11:56:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x0G2uksS010468
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547607407;
        bh=IlGcv8kn+7pcad/nWtO0JJAMgDS4Ul+f1F9xFRcEK7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tfopv3kfUnZrL/Td8x/+9NMIWA6dvCq/XCM1R3dEnFOzKcjtrESUhP2rVGSaTE5wO
         rcoAkzhTHsi7kqhLMwueZ3k6YsPgmX7G99bnBWuu1GLmYSa6YyND7/Lf3Y7zzFhkzo
         2d9ZgLYv/lbbKYMlKrAKxv13U7uj8KMkjctySP4TWvhspj4lmq8R61cZUGBXnNcYvG
         wAwyEGqPpe76nKTycAuUQ0bOfv8UgQkY6UpfSP+kW6PIaxTTrDEq8Z0iGkkvnGpR+l
         xrlI5qZEfWkK6zJ02Vm4695FcDKXIO1v7gv9JX4ipEngrZpGbfDGxN3IaPZcajO4y1
         +FQ9gAzOUoBRw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 2/2] kbuild: add -I$(srctree)/$(src) automatically for hostprogs with O=
Date:   Wed, 16 Jan 2019 11:56:41 +0900
Message-Id: <1547607401-20118-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547607401-20118-1-git-send-email-yamada.masahiro@socionext.com>
References: <1547607401-20118-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building kernel objects with the O= option, scripts/Makefile.lib
automatically adds both -I$(srctree)/$(src) and -I$(obj) so each
Makefile does not need to add them explicitly.

In contrast, scripts/Makefile.host adds only -I$(obj) when building
host programs with the O= option. As a result, each Makefile must add
the extra option to include checkin headers from generated C files.

Let's cater to this in the build system for consistency, and drop
extra options from the kconfig, dtc, genksyms Makefiles.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.host     | 4 ++--
 scripts/dtc/Makefile      | 4 ----
 scripts/genksyms/Makefile | 4 ----
 scripts/kconfig/Makefile  | 2 --
 4 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index a115259..c41d5a1d 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -72,8 +72,8 @@ __hostcxx_flags	= $(_hostcxx_flags)
 
 ifeq ($(KBUILD_EXTMOD),)
 ifneq ($(KBUILD_SRC),)
-__hostc_flags	= -I$(obj) $(call flags,_hostc_flags)
-__hostcxx_flags	= -I$(obj) $(call flags,_hostcxx_flags)
+__hostc_flags	= -I $(srctree)/$(src) -I $(obj) $(call flags,_hostc_flags)
+__hostcxx_flags	= -I $(srctree)/$(src) -I $(obj) $(call flags,_hostcxx_flags)
 endif
 endif
 
diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 5f227d8..72d3fa4 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -22,9 +22,5 @@ dtc-objs	+= yamltree.o
 HOSTLDLIBS_dtc	:= -lyaml
 endif
 
-# Generated files need one more search path to include headers in source tree
-HOSTCFLAGS_dtc-lexer.lex.o := -I$(src)
-HOSTCFLAGS_dtc-parser.tab.o := -I$(src)
-
 # dependencies on generated files need to be listed explicitly
 $(obj)/dtc-lexer.lex.o: $(obj)/dtc-parser.tab.h
diff --git a/scripts/genksyms/Makefile b/scripts/genksyms/Makefile
index 03b7ce9..ae5953d 100644
--- a/scripts/genksyms/Makefile
+++ b/scripts/genksyms/Makefile
@@ -30,9 +30,5 @@ $(obj)/parse.tab.h: $(src)/parse.y FORCE
 
 endif
 
-# -I needed for generated C source (shipped source)
-HOSTCFLAGS_parse.tab.o := -I$(src)
-HOSTCFLAGS_lex.lex.o := -I$(src)
-
 # dependencies on generated files need to be listed explicitly
 $(obj)/lex.lex.o: $(obj)/parse.tab.h
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 1819735..12cb5eb 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -146,8 +146,6 @@ help:
 common-objs	:= confdata.o expr.o symbol.o preprocess.o zconf.lex.o zconf.tab.o
 
 $(obj)/zconf.lex.o: $(obj)/zconf.tab.h
-HOSTCFLAGS_zconf.lex.o	:= -I$(src)
-HOSTCFLAGS_zconf.tab.o	:= -I$(src)
 
 # conf: Used for defconfig, oldconfig and related targets
 hostprogs-y	+= conf
-- 
2.7.4

