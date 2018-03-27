Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx48PeEvbuRrf1CUwgY+UQzEF9E64ICcklLCeoJbiOgORMYezgMQaGM1EB34Ve2HJqbtqWdgf
ARC-Seal: i=1; a=rsa-sha256; t=1522128618; cv=none;
        d=google.com; s=arc-20160816;
        b=Y1vg6eAtJoFC9U1vHAUuMPn21+w6tBa9iffBBxQzUrew+kSXL6hFW0FKtEqdYwm4B/
         9W7cUZB5zVxEwC3Vmr4+huCKQPIC+ByWjM4RGAstdPS6VUfxLBoNqY1buj8GBK0ftvdn
         463anQdvXiblDHdTVMBJ7hmTwUfiL8DLKoz4Kd/+qQwZi38OnbRsAWaLXGQfgQ+saC4q
         JJmiEofAm75w8xdJnEKkVd/kX3bExSM4xHZjI7p+SoV3jhKe63eDsHAD8xzW5G96fr5n
         Aj9IpzPhPPWLrYtKFD3e2tb3/S88E5HmbU1WFj04mPJhO58G9Tn1jOsyJiMQYppwMifz
         ZB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=yADi40SR8/2ChTwsNSAQd580Q6MNTEbsv8czRHjI84U=;
        b=wVTgdGQjlrItIhxJjVnWz7LADxpnhI5l3QUvsC65o2Su2k6sMvVUFvWI3Qbdtd8uP8
         YdLSg2jdrQ14n/GG5N0mt8FvveUuz509j0hAGPPfjuZ99hYyklcgzBlTDYyE7x/IGSd4
         DevDBs+j3hpO4nGR1bbUQfhpX85/o+IXnuFzz7Fwwfyp8W6CdAzf0OiVVENv+VEI11Wq
         wP8FK3Zzf2KhuZbX8feRAcVQMKWNwRcYHai+E6YDJFcwAi1SJwyAzcB+xmk9TTQ7jX+l
         XISkKCyz8FnKQdXSXCUjEr/5o7B6AqkmVxGZKB4V2QibzkNbKoG2SeKLEOkjSMDFvcP2
         1Raw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=pR+nPa2P;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=pR+nPa2P;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaLm011947
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ulf Magnusson <ulfalizer@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Pitre <nico@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/21] kconfig: move and rename sym_expand_string_value()
Date: Tue, 27 Mar 2018 14:29:17 +0900
Message-Id: <1522128575-5326-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067537753773827?=
X-GMAIL-MSGID: =?utf-8?q?1596067537753773827?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This helper expands symbols contained in a string.  I am about to
change it to expand environments instead of symbols.  Also, I will
add function expansion later.

Rename it to expand_string_value(), and move it to util.c, which is
a more suitable place.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 scripts/kconfig/lkc.h       |  1 +
 scripts/kconfig/lkc_proto.h |  1 -
 scripts/kconfig/symbol.c    | 53 -------------------------------------------
 scripts/kconfig/util.c      | 55 ++++++++++++++++++++++++++++++++++++++++++++-
 scripts/kconfig/zconf.y     |  2 +-
 5 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index f4394af..c8d9e55 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -111,6 +111,7 @@ void menu_finalize(struct menu *parent);
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
index f0b2e3b..03143b2 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -906,59 +906,6 @@ struct symbol *sym_find(const char *name)
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
