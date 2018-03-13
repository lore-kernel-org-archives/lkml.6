Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeCMJ5u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:57:50 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:57996 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752261AbeCMJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:57:44 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w2D9uEJw021254
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Petr Vorel <petr.vorel@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] kconfig: warn unmet direct dependency of tristate symbols selected by y
Date: Tue, 13 Mar 2018 18:56:07 +0900
Message-Id: <1520934968-30406-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 246cf9c26bf1 ("kbuild: Warn on selecting symbols with unmet
direct dependencies") forcibly promoted ->dir_dep.tri to yes from mod.
So, the unmet direct dependencies of tristate symbols are not reported.

[Test Case]

  config MODULES
          def_bool y
          option modules

  config A
          def_bool y
          select B

  config B
          tristate "B"
          depends on m

This causes unmet dependency because 'B' is forced 'y' ignoring
'depends on m'.  This should be warned.

On the other hand, the following case ('B' is bool) should not be
warned, so 'depends on m' for bool symbols should be naturally treated
as 'depends on y'.

[Test Case2 (not unmet dependency)]

  config MODULES
          def_bool y
          option modules

  config A
          def_bool y
          select B

  config B
          bool "B"
          depends on m

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4:
  - newly added


 scripts/kconfig/symbol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 0f7eba7..def860b 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -243,7 +243,7 @@ static void sym_calc_visibility(struct symbol *sym)
 	tri = yes;
 	if (sym->dir_dep.expr)
 		tri = expr_calc_value(sym->dir_dep.expr);
-	if (tri == mod)
+	if (sym->type == S_BOOLEAN && tri == mod)
 		tri = yes;
 	if (sym->dir_dep.tri != tri) {
 		sym->dir_dep.tri = tri;
@@ -414,7 +414,7 @@ void sym_calc_value(struct symbol *sym)
 				}
 			}
 		calc_newval:
-			if (sym->dir_dep.tri == no && sym->rev_dep.tri != no) {
+			if (sym->dir_dep.tri < sym->rev_dep.tri) {
 				struct expr *e;
 				e = expr_simplify_unmet_dep(sym->rev_dep.expr,
 				    sym->dir_dep.expr);
-- 
2.7.4
