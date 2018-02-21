Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeBUFpy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 00:45:54 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:18195 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBUFpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 00:45:52 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1L5iKjR027718
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Petr Vorel <petr.vorel@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH] kconfig: Print reverse dependencies in groups
Date: Wed, 21 Feb 2018 14:44:15 +0900
Message-Id: <1519191855-27943-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

This patch requires the following as a pre-requisite:
https://patchwork.kernel.org/patch/10229545/

These two will work equivalently to the following three:

https://patchwork.kernel.org/patch/10226951/
https://patchwork.kernel.org/patch/10226953/
https://patchwork.kernel.org/patch/10226955/


 scripts/kconfig/expr.c | 18 ++++++++++++------
 scripts/kconfig/expr.h |  3 ++-
 scripts/kconfig/menu.c | 10 ++++++----
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/scripts/kconfig/expr.c b/scripts/kconfig/expr.c
index cd3a8f5..49376e1 100644
--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -1323,19 +1323,25 @@ void expr_gstr_print(struct expr *e, struct gstr *gs)
  */
 static void expr_print_revdep(struct expr *e,
 			      void (*fn)(void *, struct symbol *, const char *),
-			      void *data)
+			      void *data, tristate pr_type, const char **title)
 {
 	if (e->type == E_OR) {
-		expr_print_revdep(e->left.expr, fn, data);
-		expr_print_revdep(e->right.expr, fn, data);
-	} else {
+		expr_print_revdep(e->left.expr, fn, data, pr_type, title);
+		expr_print_revdep(e->right.expr, fn, data, pr_type, title);
+	} else if (expr_calc_value(e) == pr_type) {
+		if (*title) {
+			fn(data, NULL, *title);
+			*title = NULL;
+		}
+
 		fn(data, NULL, "  - ");
 		expr_print(e, fn, data, E_NONE);
 		fn(data, NULL, "\n");
 	}
 }
 
-void expr_gstr_print_revdep(struct expr *e, struct gstr *gs)
+void expr_gstr_print_revdep(struct expr *e, struct gstr *gs,
+			    tristate pr_type, const char *title)
 {
-	expr_print_revdep(e, expr_print_gstr_helper, gs);
+	expr_print_revdep(e, expr_print_gstr_helper, gs, pr_type, &title);
 }
diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index c16e82e..8dbf2a4 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -310,7 +310,8 @@ struct expr *expr_simplify_unmet_dep(struct expr *e1, struct expr *e2);
 void expr_fprint(struct expr *e, FILE *out);
 struct gstr; /* forward */
 void expr_gstr_print(struct expr *e, struct gstr *gs);
-void expr_gstr_print_revdep(struct expr *e, struct gstr *gs);
+void expr_gstr_print_revdep(struct expr *e, struct gstr *gs,
+			    tristate pr_type, const char *title);
 
 static inline int expr_is_yes(struct expr *e)
 {
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 7e70be3..3b9beca 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -827,14 +827,16 @@ static void get_symbol_str(struct gstr *r, struct symbol *sym,
 
 	get_symbol_props_str(r, sym, P_SELECT, _("  Selects: "));
 	if (sym->rev_dep.expr) {
-		str_append(r, _("  Selected by: \n"));
-		expr_gstr_print_revdep(sym->rev_dep.expr, r);
+		expr_gstr_print_revdep(sym->rev_dep.expr, r, yes, "  Selected by [y]\n");
+		expr_gstr_print_revdep(sym->rev_dep.expr, r, mod, "  Selected by [m]\n");
+		expr_gstr_print_revdep(sym->rev_dep.expr, r, no, "  Selected by [n]\n");
 	}
 
 	get_symbol_props_str(r, sym, P_IMPLY, _("  Implies: "));
 	if (sym->implied.expr) {
-		str_append(r, _("  Implied by: \n"));
-		expr_gstr_print_revdep(sym->implied.expr, r);
+		expr_gstr_print_revdep(sym->rev_dep.expr, r, yes, "  Implied by [y]\n");
+		expr_gstr_print_revdep(sym->rev_dep.expr, r, mod, "  Implied by [m]\n");
+		expr_gstr_print_revdep(sym->rev_dep.expr, r, no, "  Implied by [n]\n");
 	}
 
 	str_append(r, "\n\n");
-- 
2.7.4
