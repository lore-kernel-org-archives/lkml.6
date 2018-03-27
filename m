Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AG47ELtgcOblNYiYqxn1FVrFz9qexnCtxQtxp0pdA6ssMRUdlh+bnwLA9VlQXpCDJe1uzGQXdqt3
ARC-Seal: i=1; a=rsa-sha256; t=1522128618; cv=none;
        d=google.com; s=arc-20160816;
        b=CYQ/JS4gevmCsWGzUkT3JyvUDW5koIZDs/bfwKr9orvNeiZaUI3ZusAoDj8ukVlvMq
         MpeGao72vT5U2K/ac3IPTlbNQy0chsO2lXzeIvreGTygYmGoxFNNY9kkPgbpjj2931Nq
         vUhLaBbNL8NI7kPVFYcuAnmGZBaplYbv7bpCmiAhiZjW8yRTF+oah9MytFy9X9qbhmbF
         sWpK5bxDWNDPI95U+yNeKl5JcFK2ppLBOkx8fLVZeeeHkyidtXGC/XuAnga3Mp+KeQJ6
         rwuLq+8lfBoti6KYJ7kXKLCqSm/1OHASybwcCkIFwGzHLlNVi9qIsrkVGvriGr58La32
         59uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=hfxSFq+yfNF9k+XV5X1In6K3Q3h/kBskgYYt0vXrL38=;
        b=NNZ7x/L7DFRgPRfsIhH1dYfycMgDtkHGic9PgJ1Mblh56n5CsrVhez0du2yQQRYRPo
         jLTXCQ5chMWFswJBhlk9xRghfgRVPzMwQiRzNqVBwAnCiPZSJs6TCHCq80jqcoeWTUP/
         5A8y9065R97roChy6pBfG/xEkQYoY8WemW2lWXA8Saw3Gxp4fU0Gg6PjqZIMbW+P8XW7
         oCre2Z9Su+nfw6FLeRy5N+M7fLtw+e8Q+Y7oA2LsUtUtJVBLGBQIjrGN2mWEr4iv8aBU
         S0t5rV5BhC4nP3bkg336YroscH14Jcttp1aq27dBo+O7AgyVelus09ZcQnJ528nV23rG
         jXqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Oy8mxPFr;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Oy8mxPFr;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaLs011947
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
Subject: [PATCH v2 09/21] kconfig: add 'macro' keyword to support user-defined function
Date: Tue, 27 Mar 2018 14:29:23 +0900
Message-Id: <1522128575-5326-10-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067537988116489?=
X-GMAIL-MSGID: =?utf-8?q?1596067537988116489?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now, we got a basic ability to test compiler capability in Kconfig.

config CC_HAS_STACKPROTECTOR
        def_bool $(shell (($CC -Werror -fstack-protector -c -x c /dev/null -o /dev/null) && echo y) || echo n)

This works, but it is ugly to repeat this long boilerplate.

We want to describe like this:

config CC_HAS_STACKPROTECTOR
        bool
        default $(cc-option -fstack-protector)

It is straight-forward to add a new function, but I do not like to
hard-code specialized functions like this.  Hence, here is another
feature to add functions from Kconfig files.

A user-defined function is defined with a special keyword 'macro'.
It can be referenced in the same way as built-in functions.  This
feature was also inspired by Makefile where user-defined functions
are referenced by $(call func-name, args...), but I omitted the 'call'
to makes it shorter.

The macro definition can contain $(1), $(2), ... which will be replaced
with arguments from the caller.  The macro works just as a textual
shorthand, which is also expanded in the lexer phase.

[Example Code]

  macro success $(shell ($(1) && echo y) || echo n)

  config TRUE
          bool "true"
          default $(success true)

  config FALSE
          bool "false"
          default $(success false)

[Result]

  $ make -s alldefconfig
  $ tail -n 2 .config
  CONFIG_TRUE=y
  # CONFIG_FALSE is not set

[Example Code]

  macro success $(shell ($(1) && echo y) || echo n)

  macro cc-option $(success $CC -Werror $(1) -c -x c /dev/null -o /dev/null)

  config CC_HAS_STACKPROTECTOR
          def_bool $(cc-option -fstack-protector)

[Result]
  $ make -s alldefconfig
  $ tail -n 1 .config
  CONFIG_CC_HAS_STACKPROTECTOR=y

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Reminder for myself:
Update Documentation/kbuild/kconfig-language.txt

Changes in v2:
  - Use 'macro' directly instead of inside the string type symbol.

 scripts/kconfig/function.c  | 59 +++++++++++++++++++++++++++++++++++++++++++--
 scripts/kconfig/lkc_proto.h |  1 +
 scripts/kconfig/zconf.l     | 31 ++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/function.c b/scripts/kconfig/function.c
index 913685f..389bb44 100644
--- a/scripts/kconfig/function.c
+++ b/scripts/kconfig/function.c
@@ -15,6 +15,7 @@ static LIST_HEAD(function_list);
 struct function {
 	char *name;
 	char *(*func)(struct function *f, int argc, char *argv[]);
+	char *macro;
 	struct list_head node;
 };
 
@@ -31,7 +32,8 @@ static struct function *func_lookup(const char *name)
 }
 
 static void func_add(const char *name,
-		     char *(*func)(struct function *f, int argc, char *argv[]))
+		     char *(*func)(struct function *f, int argc, char *argv[]),
+		     const char *macro)
 {
 	struct function *f;
 
@@ -44,6 +46,7 @@ static void func_add(const char *name,
 	f = xmalloc(sizeof(*f));
 	f->name = xstrdup(name);
 	f->func = func;
+	f->macro = macro ? xstrdup(macro) : NULL;
 
 	list_add_tail(&f->node, &function_list);
 }
@@ -51,6 +54,7 @@ static void func_add(const char *name,
 static void func_del(struct function *f)
 {
 	list_del(&f->node);
+	free(f->macro);
 	free(f->name);
 	free(f);
 }
@@ -108,6 +112,57 @@ char *func_eval_n(const char *func, size_t n)
 	return res;
 }
 
+/* run user-defined function */
+static char *do_macro(struct function *f, int argc, char *argv[])
+{
+	char *new;
+	char *src, *p, *res;
+	size_t newlen;
+	int n;
+
+	new = xmalloc(1);
+	*new = 0;
+
+	/*
+	 * This is a format string. $(1), $(2), ... must be replaced with
+	 * function arguments.
+	 */
+	src = f->macro;
+	p = src;
+
+	while ((p = strstr(p, "$("))) {
+		if (isdigit(p[2]) && p[3] == ')') {
+			n = p[2] - '0';
+			if (n < argc) {
+				newlen = strlen(new) + (p - src) +
+							strlen(argv[n]) + 1;
+				new = xrealloc(new, newlen);
+				strncat(new, src, p - src);
+				strcat(new, argv[n]);
+				src = p + 4;
+			}
+			p += 2;
+		}
+		p += 2;
+	}
+
+	newlen = strlen(new) + strlen(src) + 1;
+	new = xrealloc(new, newlen);
+	strcat(new, src);
+
+	res = expand_string_value(new);
+
+	free(new);
+
+	return res;
+}
+
+/* add user-defined function (macro) */
+void func_add_macro(const char *name, const char *macro)
+{
+	func_add(name, do_macro, macro);
+}
+
 /* built-in functions */
 static char *do_shell(struct function *f, int argc, char *argv[])
 {
@@ -157,7 +212,7 @@ static char *do_shell(struct function *f, int argc, char *argv[])
 void func_init(void)
 {
 	/* register built-in functions */
-	func_add("shell", do_shell);
+	func_add("shell", do_shell, NULL);
 }
 
 void func_exit(void)
diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index 09a4f53..48699c0 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -50,6 +50,7 @@ const char * prop_get_type_name(enum prop_type type);
 
 /* function.c */
 char *func_eval_n(const char *func, size_t n);
+void func_add_macro(const char *name, const char *macro);
 void func_init(void);
 void func_exit(void);
 
diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 551ca47..6a18c68 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -74,6 +74,36 @@ static void warn_ignored_character(char chr)
 	        "%s:%d:warning: ignoring unsupported character '%c'\n",
 	        zconf_curname(), zconf_lineno(), chr);
 }
+
+static void handle_macro(const char *text)
+{
+	char *p, *q;
+
+	while (isspace(*text))
+		text++;
+
+	p = xstrdup(text);
+
+	q = p;
+	while (isalnum(*q) || *q == '_' || *q == '-')
+		q++;
+
+	if (q == p || !*q) {
+		yyerror("invalid\n");
+		goto free;
+	}
+
+	*q = '\0';
+
+	q++;
+	while (isspace(*q))
+		q++;
+
+	func_add_macro(p, q);
+free:
+	free(p);
+}
+
 %}
 
 n	[A-Za-z0-9_-]
@@ -82,6 +112,7 @@ n	[A-Za-z0-9_-]
 	int str = 0;
 	int ts, i;
 
+"macro"[ \t].*	handle_macro(yytext + 6);
 [ \t]*#.*\n	|
 [ \t]*\n	{
 	return T_EOL;
-- 
2.7.4
