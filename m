Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B74C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A3A218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="sSMDKsgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388019AbeLUIdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:33:49 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:38271 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387770AbeLUId3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:33:29 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id wBL8XAI8008714;
        Fri, 21 Dec 2018 17:33:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com wBL8XAI8008714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545381191;
        bh=lekCqo0HXI1jLj/fEfh+Y+Q2bxBEx7hLHGkCSGgoLrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sSMDKsgcLuGvMYguDAHaRMlAcNUntkgB6ID6hZE5Ek5B7X+vzCSsYRAvtu/Msm+Fm
         T70qENoPl0+JuS7CAfTy3ANEut/sdapV+e1AxHWsHnJnICe4Ty85BXy16rIxUYnnWI
         pXvCY+R9IRCxrAKr3T84W4hR6AQPB1kyKCGBv/ms/Y96Mw3QA3sjkAQQ0gOumzU3aM
         1ZX9A7QAWYmpbPi5tuV7wKojMr3tR9iXLmeCogUunqvaZMlM1RJ8ePQv8OuVqvHxf8
         b07bOp6NSWb+Tu5tDtUagBEe0ZxVnxJ2xFBgvNm8mOhDh7JGfutPenLoSFgCmu04st
         6OoHW/q9GfULw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] kconfig: split the lexer out of zconf.y
Date:   Fri, 21 Dec 2018 17:33:05 +0900
Message-Id: <1545381188-514-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545381188-514-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545381188-514-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compile zconf.lex.c independently of the other files.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/Makefile | 8 ++------
 scripts/kconfig/lkc.h    | 3 +++
 scripts/kconfig/zconf.l  | 1 +
 scripts/kconfig/zconf.y  | 2 --
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index d3bd687..65cdf8c 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -143,11 +143,9 @@ help:
 
 # ===========================================================================
 # object files used by all kconfig flavours
-common-objs	:= confdata.o expr.o symbol.o preprocess.o zconf.tab.o
+common-objs	:= confdata.o expr.o symbol.o preprocess.o zconf.lex.o zconf.tab.o
 
-targets		+= zconf.lex.c
-
-# generated files seem to need this to find local include files
+$(obj)/zconf.lex.o: $(obj)/zconf.tab.h
 HOSTCFLAGS_zconf.lex.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
 
@@ -202,8 +200,6 @@ HOSTCFLAGS_gconf.o  = $(shell . $(obj)/.gconf-cfg && echo $$cflags)
 
 $(obj)/gconf.o: $(obj)/.gconf-cfg
 
-$(obj)/zconf.tab.o: $(obj)/zconf.lex.c
-
 # check if necessary packages are available, and configure build flags
 define filechk_conf_cfg
 	$(CONFIG_SHELL) $<
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index 160a931..531ff7c 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -90,6 +90,9 @@ void *xrealloc(void *p, size_t size);
 char *xstrdup(const char *s);
 char *xstrndup(const char *s, size_t n);
 
+/* zconf.l */
+int yylex(void);
+
 struct gstr {
 	size_t len;
 	char  *s;
diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 960e6c6..a9a83eb 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -15,6 +15,7 @@
 #include <unistd.h>
 
 #include "lkc.h"
+#include "zconf.tab.h"
 
 #define YY_DECL		static int yylex1(void)
 
diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 32be913..07719a7 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -20,7 +20,6 @@
 
 int cdebug = PRINTD;
 
-int yylex(void);
 static void yyerror(const char *err);
 static void zconfprint(const char *err, ...);
 static void zconf_error(const char *err, ...);
@@ -728,6 +727,5 @@ void zconfdump(FILE *out)
 	}
 }
 
-#include "zconf.lex.c"
 #include "util.c"
 #include "menu.c"
-- 
2.7.4

