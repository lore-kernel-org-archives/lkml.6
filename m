Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x226l0zJ5ZITnmXapWfxhiaUFqn1HO87a4oCmqShZ97qvCZUU6Q8mLr4xOJqlzJMGi2CKPrF6
ARC-Seal: i=1; a=rsa-sha256; t=1518806396; cv=none;
        d=google.com; s=arc-20160816;
        b=rniedtoYeB84G5rCzqBZrGHeqjqKsOzy76s7/rY+FuWhI0JeVZwFz+C3E+z8rqb/rG
         pOvGY1J61N6wVJ/rJQCqUMd7Li/JjZM4ZQyVDqOPbJKqov1rhw+seqwxm1riV9vF83vs
         Ol+oEolJWmNjRQ0+TvN6hcshAg5fl/fwQhOxCIRilydje/RhRFLs1ORRkqFnd+T+p4uf
         fNEkKcBBMlDM3gGAvv6fXB6Lotxu8nofUWETrHeREqsa+wyzybX0NlJrz3EovTbjn1uF
         fRLURgcffDz4RkenZevqQhiktnhPBs8729jVlt6weVzmWC7fi/iOZmBUAhAnMkgl5Ei7
         cqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=6ZKZUGrGKtv5i28aZcukMehAO6Ar8s8CMYxI7ksDKCU=;
        b=CiQ8KKKh6I0roGA/2q1lkfyLa0PDIO5gBrmUTw49ZIujGl+ujyFlzHoMWhZucCyQN7
         tuKDju30ty5nb90aYALv3mBN6dKy9hfdEH5oG+bPTGC5a2HVbwXda3kvJxVHooMyoKzM
         /5xC4h5lbQlewInTuMu7Z6FXOPiWe8N+/FGgo310ROP/5TUUN1Jgus4TQtkB2qyvlt67
         jOV9PTvC4C3Cjg5aXKu6805Dx/J02nQQWjayAF0Kq9XaLZ3CyqV85Vg3DVvxexSfNmnj
         whFZUZPi4Y/VGFpQq1u2Jy6dG20JLzh+Fw8CQlzRFcD/IQYWQFnVe9Hvvvv0GVfpaQ7I
         hDJg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=JcgYXRTI;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=JcgYXRTI;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1GIdBTG013418
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
Subject: [PATCH 13/23] kconfig: expand environments/functions in (main)menu, comment, prompt
Date: Sat, 17 Feb 2018 03:38:41 +0900
Message-Id: <1518806331-7101-14-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583935480830414?=
X-GMAIL-MSGID: =?utf-8?q?1592583935480830414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Expand the prompt passed to menu_add_prompt().  This affects
'mainmenu', 'menu', 'prompt', 'comment'.

Another good thing is, I am fixing the memory leak for the case
without mainmenu.  The 'mainmenu' should be independent of user
configuration.  So, its prompt can be expanded in the first parse
phase.  The ugly hack for no_mainmenu_stmt is gone.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/menu.c  |  2 +-
 scripts/kconfig/zconf.y | 30 +++++++++++-------------------
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index a9d0ccc..462b995 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -176,7 +176,7 @@ static struct property *menu_add_prop(enum prop_type type, char *prompt, struct
 
 struct property *menu_add_prompt(enum prop_type type, char *prompt, struct expr *dep)
 {
-	return menu_add_prop(type, prompt, NULL, dep);
+	return menu_add_prop(type, expand_string_value(prompt), NULL, dep);
 }
 
 void menu_add_visibility(struct expr *expr)
diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 19452b6..ef006be 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -110,28 +110,16 @@ static struct menu *current_menu, *current_entry;
 %%
 input: nl start | start;
 
-start: mainmenu_stmt stmt_list | no_mainmenu_stmt stmt_list;
+start: mainmenu_stmt stmt_list | stmt_list;
 
 /* mainmenu entry */
 
 mainmenu_stmt: T_MAINMENU prompt nl
 {
 	menu_add_prompt(P_MENU, $2, NULL);
+	free($2);
 };
 
-/* Default main menu, if there's no mainmenu entry */
-
-no_mainmenu_stmt: /* empty */
-{
-	/*
-	 * Hack: Keep the main menu title on the heap so we can safely free it
-	 * later regardless of whether it comes from the 'prompt' in
-	 * mainmenu_stmt or here
-	 */
-	menu_add_prompt(P_MENU, xstrdup("Linux Kernel Configuration"), NULL);
-};
-
-
 stmt_list:
 	  /* empty */
 	| stmt_list common_stmt
@@ -217,6 +205,7 @@ config_option: T_TYPE prompt_stmt_opt T_EOL
 config_option: T_PROMPT prompt if_expr T_EOL
 {
 	menu_add_prompt(P_PROMPT, $2, $3);
+	free($2);
 	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
 };
 
@@ -316,6 +305,7 @@ choice_option_list:
 choice_option: T_PROMPT prompt if_expr T_EOL
 {
 	menu_add_prompt(P_PROMPT, $2, $3);
+	free($2);
 	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
 };
 
@@ -385,6 +375,7 @@ menu: T_MENU prompt T_EOL
 {
 	menu_add_entry(NULL);
 	menu_add_prompt(P_MENU, $2, NULL);
+	free($2);
 	printd(DEBUG_PARSE, "%s:%d:menu\n", zconf_curname(), zconf_lineno());
 };
 
@@ -424,6 +415,7 @@ comment: T_COMMENT prompt T_EOL
 {
 	menu_add_entry(NULL);
 	menu_add_prompt(P_COMMENT, $2, NULL);
+	free($2);
 	printd(DEBUG_PARSE, "%s:%d:comment\n", zconf_curname(), zconf_lineno());
 };
 
@@ -489,6 +481,7 @@ prompt_stmt_opt:
 	| prompt if_expr
 {
 	menu_add_prompt(P_PROMPT, $1, $2);
+	free($1);
 };
 
 prompt:	  T_WORD
@@ -536,7 +529,6 @@ word_opt: /* empty */			{ $$ = NULL; }
 
 void conf_parse(const char *name)
 {
-	const char *tmp;
 	struct symbol *sym;
 	int i;
 
@@ -560,10 +552,10 @@ void conf_parse(const char *name)
 	if (!modules_sym)
 		modules_sym = sym_find( "n" );
 
-	tmp = rootmenu.prompt->text;
-	rootmenu.prompt->text = _(rootmenu.prompt->text);
-	rootmenu.prompt->text = expand_string_value(rootmenu.prompt->text);
-	free((char*)tmp);
+	if (!menu_has_prompt(&rootmenu)) {
+		current_entry = &rootmenu;
+		menu_add_prompt(P_MENU, "Linux Kernel Configuration", NULL);
+	}
 
 	menu_finalize(&rootmenu);
 	for_all_symbols(i, sym) {
-- 
2.7.4
