Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbeBTIU1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 03:20:27 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:53143 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbeBTIU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 03:20:26 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w1K8Iv28015820
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Petr Vorel <petr.vorel@gmail.com>, Paul Bolle <pebolle@tiscali.nl>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: clean-up reverse dependency help implementation
Date: Tue, 20 Feb 2018 17:18:47 +0900
Message-Id: <1519114728-1084-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit splits out the special E_OR handling ('-' instead of '||')
into a dedicated helper expr_print_revdev().

Restore the original expr_print() prior to commit 1ccb27143360
("kconfig: make "Selected by:" and "Implied by:" readable").

This makes sense because:

  - We need to chop those expressions only when printing the reverse
    dependency, and only when E_OR is encountered

  - Otherwise, it should be printed as before, so fall back to
    expr_print()

This also improves the behavior; for a single line, it was previously
displayed in the same line as "Selected by", like this:

  Selected by: A [=n] && B [=n]

This will be displayed in a new line, consistently:

  Selected by:
  - A [=n] && B [=n]

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/expr.c | 36 +++++++++++++++++++++---------------
 scripts/kconfig/menu.c |  6 ++----
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/scripts/kconfig/expr.c b/scripts/kconfig/expr.c
index d453819..cd3a8f5 100644
--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -1179,7 +1179,9 @@ struct expr *expr_simplify_unmet_dep(struct expr *e1, struct expr *e2)
 	return expr_get_leftmost_symbol(ret);
 }
 
-static void __expr_print(struct expr *e, void (*fn)(void *, struct symbol *, const char *), void *data, int prevtoken, bool revdep)
+void expr_print(struct expr *e,
+		void (*fn)(void *, struct symbol *, const char *),
+		void *data, int prevtoken)
 {
 	if (!e) {
 		fn(data, NULL, "y");
@@ -1234,14 +1236,9 @@ static void __expr_print(struct expr *e, void (*fn)(void *, struct symbol *, con
 		fn(data, e->right.sym, e->right.sym->name);
 		break;
 	case E_OR:
-		if (revdep && e->left.expr->type != E_OR)
-			fn(data, NULL, "\n  - ");
-		__expr_print(e->left.expr, fn, data, E_OR, revdep);
-		if (revdep)
-			fn(data, NULL, "\n  - ");
-		else
-			fn(data, NULL, " || ");
-		__expr_print(e->right.expr, fn, data, E_OR, revdep);
+		expr_print(e->left.expr, fn, data, E_OR);
+		fn(data, NULL, " || ");
+		expr_print(e->right.expr, fn, data, E_OR);
 		break;
 	case E_AND:
 		expr_print(e->left.expr, fn, data, E_AND);
@@ -1274,11 +1271,6 @@ static void __expr_print(struct expr *e, void (*fn)(void *, struct symbol *, con
 		fn(data, NULL, ")");
 }
 
-void expr_print(struct expr *e, void (*fn)(void *, struct symbol *, const char *), void *data, int prevtoken)
-{
-	__expr_print(e, fn, data, prevtoken, false);
-}
-
 static void expr_print_file_helper(void *data, struct symbol *sym, const char *str)
 {
 	xfwrite(str, strlen(str), 1, data);
@@ -1329,7 +1321,21 @@ void expr_gstr_print(struct expr *e, struct gstr *gs)
  * line with a minus. This makes expressions much easier to read.
  * Suitable for reverse dependency expressions.
  */
+static void expr_print_revdep(struct expr *e,
+			      void (*fn)(void *, struct symbol *, const char *),
+			      void *data)
+{
+	if (e->type == E_OR) {
+		expr_print_revdep(e->left.expr, fn, data);
+		expr_print_revdep(e->right.expr, fn, data);
+	} else {
+		fn(data, NULL, "  - ");
+		expr_print(e, fn, data, E_NONE);
+		fn(data, NULL, "\n");
+	}
+}
+
 void expr_gstr_print_revdep(struct expr *e, struct gstr *gs)
 {
-	__expr_print(e, expr_print_gstr_helper, gs, E_NONE, true);
+	expr_print_revdep(e, expr_print_gstr_helper, gs);
 }
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 9922285..7e70be3 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -827,16 +827,14 @@ static void get_symbol_str(struct gstr *r, struct symbol *sym,
 
 	get_symbol_props_str(r, sym, P_SELECT, _("  Selects: "));
 	if (sym->rev_dep.expr) {
-		str_append(r, _("  Selected by: "));
+		str_append(r, _("  Selected by: \n"));
 		expr_gstr_print_revdep(sym->rev_dep.expr, r);
-		str_append(r, "\n");
 	}
 
 	get_symbol_props_str(r, sym, P_IMPLY, _("  Implies: "));
 	if (sym->implied.expr) {
-		str_append(r, _("  Implied by: "));
+		str_append(r, _("  Implied by: \n"));
 		expr_gstr_print_revdep(sym->implied.expr, r);
-		str_append(r, "\n");
 	}
 
 	str_append(r, "\n\n");
-- 
2.7.4
