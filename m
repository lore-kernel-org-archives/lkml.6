Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x225zRwG+pqu9v6lRtyS/maDxPSJdMFUG/J2M9riy+XrglusShLJBPyxUE0kybgBK+h2iSLaM
ARC-Seal: i=1; a=rsa-sha256; t=1518806386; cv=none;
        d=google.com; s=arc-20160816;
        b=rPgJU3Y+r1hYjXiOC8Wcd1XE3syXBymeqGPxntDkumHSLcham42B/1aZgopr+ZlaTy
         rvGM3fxXYPdbpJrERdBpb3s1Hb52a/usr2YXiwLUAkoAO+1mrVXJxSzGGxE3CkdVaDi7
         5krtr5yUbxzejReLIq3z5b2AY2go6WxQXcWp3OMI+NsSGTr0dkhAsV4GtxNTcLnpD9a9
         pDQWl9wfqmpdGIVQKwAn6MgVN6Ix7BWrF/HeCx4N4sbVPcpR1/QJ1nLttpNyRem0Eqan
         cY21G0jsczLbDivHjARz/lebjzfwpsNJDsAoL6gvcM9nYcJIbnXzEaExNpFwGeVoX6eO
         kPog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=6bDWmuezbI5Hm+gjpVvP4x2GJkY1+VLq+ILtVxXeZbM=;
        b=KvGVGZhU0nCIssD/SRDzhCHyWFz7MmZRKmVbnObExTjKvelJOWL8lOkAEGw3DaYW0O
         8R3rpgSISspQMt3T9sPH5ordPWOTbr989NMr9pkx5lnkNbW0zwmoBK6e9j/cOexo6G8L
         0pX0gN1BbU+GAwryx9ytcTXjYggEcLCx+QZmoSN9GtaksdZbeINK9uvPiurYv1s9dZ36
         5KGWKj0yz6XgK5uWwLwvLGYtCTRbY3xK6ugVzeeajz/MshrEtIB4F+ywGSdbx/oMqdwQ
         R4TzHAB/wrNpVdEC9upypX848MCo0XFc9XXgkDe/Y4MftYOwEhJ3IYoeUkhPq3QZheeX
         vH+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=2nv9Jg/J;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=2nv9Jg/J;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1GIdBT8013418
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/23] kconfig: move and rename sym_expand_string_value()
Date: Sat, 17 Feb 2018 03:38:33 +0900
Message-Id: <1518806331-7101-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583924957446413?=
X-GMAIL-MSGID: =?utf-8?q?1592583924957446413?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This helper expands symbols contained in a string.  I am about to
change it to expand environments instead of symbols.  Also, I will
add function expansion later.

Rename it to expand_string_value(), and move it to util.c, which is
a more suitable place.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/lkc.h       |  1 +
 scripts/kconfig/lkc_proto.h |  1 -
 scripts/kconfig/symbol.c    | 53 -------------------------------------------
 scripts/kconfig/util.c      | 55 ++++++++++++++++++++++++++++++++++++++++++++-
 scripts/kconfig/zconf.y     |  2 +-
 5 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index 2d5ec2d..fb2503a 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -110,6 +110,7 @@ void menu_finalize(struct menu *parent);
 void menu_set_type(int type);
 
 /* util.c */
+char *expand_string_value(const char *in);
 struct file *file_lookup(const char *name);
 int file_write_dep(const char *name);
 void *xmalloc(size_t size);
diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index 9dc8abf..9884adc 100644
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
index 2220bc4..e4ccf56 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -894,59 +894,6 @@ struct symbol *sym_find(const char *name)
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
diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index c6f6e21..22201a4 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -10,11 +10,64 @@
 #include <string.h>
 #include "lkc.h"
 
+/*
+ * Expand symbol's names embedded in the string given in argument. Symbols'
+ * name to be expanded shall be prefixed by a '$'. Unknown symbol expands to
+ * the empty string.
+ */
+char *expand_string_value(const char *in)
+{
+	const char *src;
+	char *res;
+	size_t reslen;
+
+	/*
+	 * Note: 'in' might come from a token that's about to be
+	 * freed, so make sure to always allocate a new string
+	 */
+	reslen = strlen(in) + 1;
+	res = xmalloc(reslen);
+	res[0] = '\0';
+
+	while ((src = strchr(in, '$'))) {
+		char *p, name[SYMBOL_MAXLENGTH];
+		const char *symval = "";
+		struct symbol *sym;
+		size_t newlen;
+
+		strncat(res, in, src - in);
+		src++;
+
+		p = name;
+		while (isalnum(*src) || *src == '_')
+			*p++ = *src++;
+		*p = '\0';
+
+		sym = sym_find(name);
+		if (sym != NULL) {
+			sym_calc_value(sym);
+			symval = sym_get_string_value(sym);
+		}
+
+		newlen = strlen(res) + strlen(symval) + strlen(src) + 1;
+		if (newlen > reslen) {
+			reslen = newlen;
+			res = xrealloc(res, reslen);
+		}
+
+		strcat(res, symval);
+		in = src;
+	}
+	strcat(res, in);
+
+	return res;
+}
+
 /* file already present in list? If not add it */
 struct file *file_lookup(const char *name)
 {
 	struct file *file;
-	char *file_name = sym_expand_string_value(name);
+	char *file_name = expand_string_value(name);
 
 	for (file = file_list; file; file = file->next) {
 		if (!strcmp(name, file->name)) {
diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index ad6305b..262c464 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -547,7 +547,7 @@ void conf_parse(const char *name)
 
 	tmp = rootmenu.prompt->text;
 	rootmenu.prompt->text = _(rootmenu.prompt->text);
-	rootmenu.prompt->text = sym_expand_string_value(rootmenu.prompt->text);
+	rootmenu.prompt->text = expand_string_value(rootmenu.prompt->text);
 	free((char*)tmp);
 
 	menu_finalize(&rootmenu);
-- 
2.7.4
