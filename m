Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932202AbeE1J2P (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:28:15 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:21666 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754337AbeE1JYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:24:17 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4S9MInN027506
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v5 06/31] kconfig: remove sym_expand_string_value()
Date: Mon, 28 May 2018 18:21:43 +0900
Message-Id: <1527499328-13213-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no more caller of sym_expand_string_value().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---

Changes in v5: None
Changes in v4: None
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
