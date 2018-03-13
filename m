Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbeCMJ5s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:57:48 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:57997 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752254AbeCMJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:57:44 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w2D9uEJx021254
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
Subject: [PATCH v4 2/2] kconfig: make unmet dependency warnings readable
Date: Tue, 13 Mar 2018 18:56:08 +0900
Message-Id: <1520934968-30406-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520934968-30406-1-git-send-email-yamada.masahiro@socionext.com>
References: <1520934968-30406-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the unmet dependency warnings end up with endlessly long
expressions, most of which are false positives.

Here is test code to demonstrate how it currently works.

[Test Case]

  config DEP1
          def_bool y

  config DEP2
          bool "DEP2"

  config A
          bool "A"
          select E

  config B
          bool "B"
          depends on DEP2
          select E

  config C
          bool "C"
          depends on DEP1 && DEP2
          select E

  config D
          def_bool n
          select E

  config E
          bool
          depends on DEP1 && DEP2

[Result]

  $ make config
  scripts/kconfig/conf  --oldaskconfig Kconfig
  *
  * Linux Kernel Configuration
  *
  DEP2 (DEP2) [N/y/?] (NEW) n
  A (A) [N/y/?] (NEW) y
  warning: (A && B && D) selects E which has unmet direct
  dependencies (DEP1 && DEP2)

Here, I see some points to be improved.

First, '(A || B || D)' would make more sense than '(A && B && D)'.
I am not sure if this is intentional, but expr_simplify_unmet_dep()
turns OR expressions into AND, like follows:

        case E_OR:
                return expr_alloc_and(

Second, we see false positives.  'A' is a real unmet dependency.
'B' is false positive because 'DEP1' is fixed to 'y', and 'B' depends
on 'DEP2'.  'C' was correctly dropped by expr_simplify_unmet_dep().
'D' is also false positive because it has no chance to be enabled.
Current expr_simplify_unmet_dep() cannot avoid those false positives.

After all, I decided to use the same helpers as used for printing
reverse dependencies in the help.

With this commit, unreadable warnings (most of the reported symbols are
false positives) in the real world:

$ make ARCH=score allyesconfig
scripts/kconfig/conf  --allyesconfig Kconfig
warning: (HWSPINLOCK_QCOM && AHCI_MTK && STMMAC_PLATFORM &&
 DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_OXNAS && DWMAC_ROCKCHIP &&
 DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW && PINCTRL_GEMINI &&
 PINCTRL_OXNAS && PINCTRL_ROCKCHIP && PINCTRL_DOVE &&
 PINCTRL_ARMADA_37XX && PINCTRL_STM32 && S3C2410_WATCHDOG &&
 VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK && RTC_DRV_AT91SAM9 &&
 LPC18XX_DMAMUX && VIDEO_OMAP4 && COMMON_CLK_GEMINI &&
 COMMON_CLK_ASPEED && COMMON_CLK_NXP && COMMON_CLK_OXNAS &&
 COMMON_CLK_BOSTON && QCOM_ADSP_PIL && QCOM_Q6V5_PIL && QCOM_GSBI &&
 ATMEL_EBI && ST_IRQCHIP && RESET_IMX7 && PHY_HI6220_USB &&
 PHY_RALINK_USB && PHY_ROCKCHIP_PCIE && PHY_DA8XX_USB) selects
 MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
warning: (PINCTRL_AT91 && PINCTRL_AT91PIO4 && PINCTRL_OXNAS &&
 PINCTRL_PISTACHIO && PINCTRL_PIC32 && PINCTRL_MESON &&
 PINCTRL_NOMADIK && PINCTRL_MTK && PINCTRL_MT7622 && GPIO_TB10X)
 selects OF_GPIO which has unmet direct dependencies (GPIOLIB && OF &&
 HAS_IOMEM)
warning: (FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP && LOCKDEP)
 selects FRAME_POINTER which has unmet direct dependencies
 (DEBUG_KERNEL && (CRIS || M68K || FRV || UML || SUPERH || BLACKFIN ||
 MN10300 || METAG) || ARCH_WANT_FRAME_POINTERS)

will be turned into:

$ make ARCH=score allyesconfig
scripts/kconfig/conf  --allyesconfig Kconfig

WARNING: unmet direct dependencies detected for MFD_SYSCON
  Depends on [n]: HAS_IOMEM [=n]
  Selected by [y]:
  - PINCTRL_STM32 [=y] && PINCTRL [=y] && (ARCH_STM32 ||
 COMPILE_TEST [=y]) && OF [=y]
  - RTC_DRV_AT91SAM9 [=y] && RTC_CLASS [=y] && (ARCH_AT91 ||
 COMPILE_TEST [=y])
  - RESET_IMX7 [=y] && RESET_CONTROLLER [=y]
  - PHY_HI6220_USB [=y] && (ARCH_HISI && ARM64 ||
 COMPILE_TEST [=y])
  - PHY_RALINK_USB [=y] && (RALINK || COMPILE_TEST [=y])
  - PHY_ROCKCHIP_PCIE [=y] && (ARCH_ROCKCHIP && OF [=y] ||
 COMPILE_TEST [=y])

WARNING: unmet direct dependencies detected for OF_GPIO
  Depends on [n]: GPIOLIB [=y] && OF [=y] && HAS_IOMEM [=n]
  Selected by [y]:
  - PINCTRL_MTK [=y] && PINCTRL [=y] && (ARCH_MEDIATEK ||
 COMPILE_TEST [=y]) && OF [=y]
  - PINCTRL_MT7622 [=y] && PINCTRL [=y] && (ARCH_MEDIATEK ||
 COMPILE_TEST [=y]) && OF [=y] && (ARM64 || COMPILE_TEST [=y])

WARNING: unmet direct dependencies detected for FRAME_POINTER
  Depends on [n]: DEBUG_KERNEL [=y] && (CRIS || M68K || FRV || UML ||
 SUPERH || BLACKFIN || MN10300 || METAG) || ARCH_WANT_FRAME_POINTERS [=n]
  Selected by [y]:
  - LATENCYTOP [=y] && DEBUG_KERNEL [=y] && STACKTRACE_SUPPORT [=y] &&
 PROC_FS [=y] && !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM_UNWIND &&
 !ARC && !X86

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
---

Changes in v4:
  - Rename sym_warn_unmet_dependency() to sym_warn_unmet_dep()
  - Shift "Depends on:" and "Selected by" to the right by one space
  - Display value of "Depends on".  This can be '[m]' or '[n]'.

Changes in v3:
  - Remove unused expr_get_leftmost_symbol()
  - Move error message to the same line as 'WARNING'
  - update test case

Changes in v2:
  - update test case

 scripts/kconfig/expr.c   | 42 ------------------------------------------
 scripts/kconfig/expr.h   |  1 -
 scripts/kconfig/symbol.c | 35 +++++++++++++++++++++++------------
 3 files changed, 23 insertions(+), 55 deletions(-)

diff --git a/scripts/kconfig/expr.c b/scripts/kconfig/expr.c
index 49376e1..e1a39e9 100644
--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -1137,48 +1137,6 @@ static int expr_compare_type(enum expr_type t1, enum expr_type t2)
 	return 0;
 }
 
-static inline struct expr *
-expr_get_leftmost_symbol(const struct expr *e)
-{
-
-	if (e == NULL)
-		return NULL;
-
-	while (e->type != E_SYMBOL)
-		e = e->left.expr;
-
-	return expr_copy(e);
-}
-
-/*
- * Given expression `e1' and `e2', returns the leaf of the longest
- * sub-expression of `e1' not containing 'e2.
- */
-struct expr *expr_simplify_unmet_dep(struct expr *e1, struct expr *e2)
-{
-	struct expr *ret;
-
-	switch (e1->type) {
-	case E_OR:
-		return expr_alloc_and(
-		    expr_simplify_unmet_dep(e1->left.expr, e2),
-		    expr_simplify_unmet_dep(e1->right.expr, e2));
-	case E_AND: {
-		struct expr *e;
-		e = expr_alloc_and(expr_copy(e1), expr_copy(e2));
-		e = expr_eliminate_dups(e);
-		ret = (!expr_eq(e, e1)) ? e1 : NULL;
-		expr_free(e);
-		break;
-		}
-	default:
-		ret = e1;
-		break;
-	}
-
-	return expr_get_leftmost_symbol(ret);
-}
-
 void expr_print(struct expr *e,
 		void (*fn)(void *, struct symbol *, const char *),
 		void *data, int prevtoken)
diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index 8dbf2a4..94a383b 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -305,7 +305,6 @@ struct expr *expr_transform(struct expr *e);
 int expr_contains_symbol(struct expr *dep, struct symbol *sym);
 bool expr_depends_symbol(struct expr *dep, struct symbol *sym);
 struct expr *expr_trans_compare(struct expr *e, enum expr_type type, struct symbol *sym);
-struct expr *expr_simplify_unmet_dep(struct expr *e1, struct expr *e2);
 
 void expr_fprint(struct expr *e, FILE *out);
 struct gstr; /* forward */
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index def860b..9e7d742 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -333,6 +333,27 @@ static struct symbol *sym_calc_choice(struct symbol *sym)
 	return def_sym;
 }
 
+static void sym_warn_unmet_dep(struct symbol *sym)
+{
+	struct gstr gs = str_new();
+
+	str_printf(&gs,
+		   "\nWARNING: unmet direct dependencies detected for %s\n",
+		   sym->name);
+	str_printf(&gs,
+		   "  Depends on [%c]: ",
+		   sym->dir_dep.tri == mod ? 'm' : 'n');
+	expr_gstr_print(sym->dir_dep.expr, &gs);
+	str_printf(&gs, "\n");
+
+	expr_gstr_print_revdep(sym->rev_dep.expr, &gs, yes,
+			       "  Selected by [y]:\n");
+	expr_gstr_print_revdep(sym->rev_dep.expr, &gs, mod,
+			       "  Selected by [m]:\n");
+
+	fputs(str_get(&gs), stderr);
+}
+
 void sym_calc_value(struct symbol *sym)
 {
 	struct symbol_value newval, oldval;
@@ -414,18 +435,8 @@ void sym_calc_value(struct symbol *sym)
 				}
 			}
 		calc_newval:
-			if (sym->dir_dep.tri < sym->rev_dep.tri) {
-				struct expr *e;
-				e = expr_simplify_unmet_dep(sym->rev_dep.expr,
-				    sym->dir_dep.expr);
-				fprintf(stderr, "warning: (");
-				expr_fprint(e, stderr);
-				fprintf(stderr, ") selects %s which has unmet direct dependencies (",
-					sym->name);
-				expr_fprint(sym->dir_dep.expr, stderr);
-				fprintf(stderr, ")\n");
-				expr_free(e);
-			}
+			if (sym->dir_dep.tri < sym->rev_dep.tri)
+				sym_warn_unmet_dep(sym);
 			newval.tri = EXPR_OR(newval.tri, sym->rev_dep.tri);
 		}
 		if (newval.tri == mod &&
-- 
2.7.4
