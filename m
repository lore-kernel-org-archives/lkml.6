Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeDMFIe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:08:34 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54957 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752223AbeDMFIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:30 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lg0029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/30] kconfig: remove string expansion for mainmenu after yyparse()
Date: Fri, 13 Apr 2018 14:06:15 +0900
Message-Id: <1523595999-27433-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
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
