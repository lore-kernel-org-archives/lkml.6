Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752982AbeDMFIg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:08:36 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54961 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbeDMFIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:30 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lg1029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/30] kconfig: remove sym_expand_string_value()
Date: Fri, 13 Apr 2018 14:06:16 +0900
Message-Id: <1523595999-27433-8-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no more caller of sym_expand_string_value().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - newly added

Changes in v2: None

 scripts/kconfig/lkc_proto.h |  1 -
 scripts/kconfig/symbol.c    | 53 ---------------------------------------------
 2 files changed, 54 deletions(-)

diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index 9f465fe..c46929f 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -31,7 +31,6 @@ extern struct symbol * symbol_hash[SYMBOL_HASHSIZE];
 
 struct symbol * sym_lookup(const char *name, int flags);
 struct symbol * sym_find(const char *name);
-char *sym_expand_string_value(const char *in);
 const char * sym_escape_string_value(const char *in);
 struct symbol ** sym_re_search(const char *pattern);
 const char * sym_type_name(enum symbol_type type);
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 2460648..7c9a88e 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -879,59 +879,6 @@ struct symbol *sym_find(const char *name)
 	return symbol;
 }
 
-/*
- * Expand symbol's names embedded in the string given in argument. Symbols'
- * name to be expanded shall be prefixed by a '$'. Unknown symbol expands to
- * the empty string.
- */
-char *sym_expand_string_value(const char *in)
-{
-	const char *src;
-	char *res;
-	size_t reslen;
-
-	/*
-	 * Note: 'in' might come from a token that's about to be
-	 * freed, so make sure to always allocate a new string
-	 */
-	reslen = strlen(in) + 1;
-	res = xmalloc(reslen);
-	res[0] = '\0';
-
-	while ((src = strchr(in, '$'))) {
-		char *p, name[SYMBOL_MAXLENGTH];
-		const char *symval = "";
-		struct symbol *sym;
-		size_t newlen;
-
-		strncat(res, in, src - in);
-		src++;
-
-		p = name;
-		while (isalnum(*src) || *src == '_')
-			*p++ = *src++;
-		*p = '\0';
-
-		sym = sym_find(name);
-		if (sym != NULL) {
-			sym_calc_value(sym);
-			symval = sym_get_string_value(sym);
-		}
-
-		newlen = strlen(res) + strlen(symval) + strlen(src) + 1;
-		if (newlen > reslen) {
-			reslen = newlen;
-			res = xrealloc(res, reslen);
-		}
-
-		strcat(res, symval);
-		in = src;
-	}
-	strcat(res, in);
-
-	return res;
-}
-
 const char *sym_escape_string_value(const char *in)
 {
 	const char *p;
-- 
2.7.4
