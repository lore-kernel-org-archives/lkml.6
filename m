Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754362AbeE1JYS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:24:18 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:21452 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754090AbeE1JYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:24:12 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4S9MInM027506
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
Subject: [PATCH v5 05/31] kconfig: remove string expansion for mainmenu after yyparse()
Date: Mon, 28 May 2018 18:21:42 +0900
Message-Id: <1527499328-13213-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that environments are expanded in the lexer, conf_parse() does
not need to expand them explicitly.

The hack introduced by commit 0724a7c32a54 ("kconfig: Don't leak
main menus during parsing") can go away.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
  - Simplify the patch.  Just remove the text expansion.

 scripts/kconfig/zconf.y | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 3a4a0fa..22e318c 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -109,7 +109,7 @@ static struct menu *current_menu, *current_entry;
 %%
 input: nl start | start;
 
-start: mainmenu_stmt stmt_list | no_mainmenu_stmt stmt_list;
+start: mainmenu_stmt stmt_list | stmt_list;
 
 /* mainmenu entry */
 
@@ -118,19 +118,6 @@ mainmenu_stmt: T_MAINMENU prompt nl
 	menu_add_prompt(P_MENU, $2, NULL);
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
@@ -528,7 +515,6 @@ word_opt: /* empty */			{ $$ = NULL; }
 
 void conf_parse(const char *name)
 {
-	const char *tmp;
 	struct symbol *sym;
 	int i;
 
@@ -544,10 +530,10 @@ void conf_parse(const char *name)
 	if (!modules_sym)
 		modules_sym = sym_find( "n" );
 
-	tmp = rootmenu.prompt->text;
-	rootmenu.prompt->text = _(rootmenu.prompt->text);
-	rootmenu.prompt->text = sym_expand_string_value(rootmenu.prompt->text);
-	free((char*)tmp);
+	if (!menu_has_prompt(&rootmenu)) {
+		current_entry = &rootmenu;
+		menu_add_prompt(P_MENU, "Linux Kernel Configuration", NULL);
+	}
 
 	menu_finalize(&rootmenu);
 	for_all_symbols(i, sym) {
-- 
2.7.4
