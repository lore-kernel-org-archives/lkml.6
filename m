Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B70C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FA620868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lcq0zH6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FA620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeK3UZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:25:49 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:52877 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeK3UZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:25:48 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wAU9GEad028692;
        Fri, 30 Nov 2018 18:16:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wAU9GEad028692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543569377;
        bh=xOuNyYoeaMcUn6Nixk1WwcdLtHqFZIy2LdfvliI/DuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcq0zH6oPO1KNNfYQIiLDFpxW7Usq4ldhYEYaDEsYi49Wj0uydojspOBCSXwUDjSb
         okrAQIBtQdNHnnWa7PnqP1rBkr9iuSjxl9WK8h0lpsIK4ml2iBJzZMPYQGtS2mYuOt
         HWXzI12TVWV+wiPerNA5mtpt5JuDnHvjq6rpdZqGZn0tGOAxxbTiNUCRVI4/w9tyaW
         OGAkdwkhN3IQlaB72mwRy07s5+S9UKERMSNB9jpl4EgFH+X6Ub5hPFzkUPonJ0Peda
         /AwcoR9/lX3Kph8KSOHPTxQCI98CX9hH8rv4THhevz36hUjK3AfmV3Jc40b8fdk0yA
         iYWhEJ+dmNoGA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] kconfig: remove S_OTHER symbol type and correct dependency tracking
Date:   Fri, 30 Nov 2018 18:15:51 +0900
Message-Id: <1543569352-4899-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543569352-4899-1-git-send-email-yamada.masahiro@socionext.com>
References: <1543569352-4899-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The S_OTHER type could be set only when conf_read_simple() is reading
include/config/auto.conf file.

For example, CONFIG_FOO=y exists in include/config/auto.conf but it is
missing from the currently parsed Kconfig files, sym_lookup() allocates
a new symbol, and sets its type to S_OTHER.

Strangely, it will be set to S_STRING by conf_set_sym_val() a few lines
below while it is obviously bool or tristate type. On the other hand,
when CONFIG_BAR="bar" is being dropped from include/config/auto.conf,
its type remains S_OTHER. Because for_all_symbols() omits S_OTHER
symbols, conf_touch_deps() misses to touch include/config/bar.h

This behavior has been a pretty mystery for me, and digging the git
histroy did not help. At least, touching depfiles is broken for string
type symbols.

I removed S_OTHER entirely, and reimplemented it more simply.

If CONFIG_FOO was visible in the previous syncconfig, but is missing
now, what we want to do is quite simple; just call conf_touch_dep()
to touch include/config/foo.h instead of allocating a new symbol data.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/confdata.c | 33 ++++++++++++++-------------------
 scripts/kconfig/expr.h     |  4 ++--
 scripts/kconfig/symbol.c   |  3 ---
 3 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 7263b83..800fb16 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -227,14 +227,6 @@ static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
 			conf_warning("symbol value '%s' invalid for %s",
 				     p, sym->name);
 		return 1;
-	case S_OTHER:
-		if (*p != '"') {
-			for (p2 = p; *p2 && !isspace(*p2); p2++)
-				;
-			sym->type = S_STRING;
-			goto done;
-		}
-		/* fall through */
 	case S_STRING:
 		if (*p++ != '"')
 			break;
@@ -253,7 +245,6 @@ static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
 		/* fall through */
 	case S_INT:
 	case S_HEX:
-	done:
 		if (sym_string_valid(sym, p)) {
 			sym->def[def].val = xstrdup(p);
 			sym->flags |= def_flags;
@@ -434,17 +425,22 @@ int conf_read_simple(const char *name, int def)
 				if (*p2 == '\r')
 					*p2 = 0;
 			}
-			if (def == S_DEF_USER) {
-				sym = sym_find(line + strlen(CONFIG_));
-				if (!sym) {
+
+			sym = sym_find(line + strlen(CONFIG_));
+			if (!sym) {
+				if (def == S_DEF_AUTO)
+					/*
+					 * Reading from include/config/auto.conf
+					 * If CONFIG_FOO previously existed in
+					 * auto.conf but it is missing now,
+					 * include/config/foo.h must be touched.
+					 */
+					conf_touch_dep(line + strlen(CONFIG_));
+				else
 					sym_add_change_count(1);
-					continue;
-				}
-			} else {
-				sym = sym_lookup(line + strlen(CONFIG_), 0);
-				if (sym->type == S_UNKNOWN)
-					sym->type = S_OTHER;
+				continue;
 			}
+
 			if (sym->flags & def_flags) {
 				conf_warning("override: reassigning to symbol %s", sym->name);
 			}
@@ -710,7 +706,6 @@ static void conf_write_symbol(FILE *fp, struct symbol *sym,
 	const char *str;
 
 	switch (sym->type) {
-	case S_OTHER:
 	case S_UNKNOWN:
 		break;
 	case S_STRING:
diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index 7c329e1..2b7e222 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -62,7 +62,7 @@ struct symbol_value {
 };
 
 enum symbol_type {
-	S_UNKNOWN, S_BOOLEAN, S_TRISTATE, S_INT, S_HEX, S_STRING, S_OTHER
+	S_UNKNOWN, S_BOOLEAN, S_TRISTATE, S_INT, S_HEX, S_STRING
 };
 
 /* enum values are used as index to symbol.def[] */
@@ -131,7 +131,7 @@ struct symbol {
 	struct expr_value implied;
 };
 
-#define for_all_symbols(i, sym) for (i = 0; i < SYMBOL_HASHSIZE; i++) for (sym = symbol_hash[i]; sym; sym = sym->next) if (sym->type != S_OTHER)
+#define for_all_symbols(i, sym) for (i = 0; i < SYMBOL_HASHSIZE; i++) for (sym = symbol_hash[i]; sym; sym = sym->next)
 
 #define SYMBOL_CONST      0x0001  /* symbol is const */
 #define SYMBOL_CHECK      0x0008  /* used during dependency checking */
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 703b9b8..2e6bf36 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -61,8 +61,6 @@ const char *sym_type_name(enum symbol_type type)
 		return "string";
 	case S_UNKNOWN:
 		return "unknown";
-	case S_OTHER:
-		break;
 	}
 	return "???";
 }
@@ -757,7 +755,6 @@ const char *sym_get_string_default(struct symbol *sym)
 		return str;
 	case S_STRING:
 		return str;
-	case S_OTHER:
 	case S_UNKNOWN:
 		break;
 	}
-- 
2.7.4

