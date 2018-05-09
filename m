Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756239AbeEIHY4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:24:56 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:50745 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756211AbeEIHYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:24:50 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w497O36D028852
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] modpost: remove symbol prefix support
Date: Wed,  9 May 2018 16:23:45 +0900
Message-Id: <1525850632-10921-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
References: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX was selected by BLACKFIN, METAG.
They were removed by commit 4ba66a976072 ("arch: remove blackfin port"),
commit bb6fb6dfcc17 ("metag: Remove arch/metag/"), respectively.

No more architecture enables CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX,
hence VMLINUX_SYMBOL_STR(foo) can be simplify replaced with "foo".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/mod/modpost.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 4ff08a0..bc71925 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -19,9 +19,7 @@
 #include <stdbool.h>
 #include <errno.h>
 #include "modpost.h"
-#include "../../include/generated/autoconf.h"
 #include "../../include/linux/license.h"
-#include "../../include/linux/export.h"
 
 /* Are we using CONFIG_MODVERSIONS? */
 static int modversions = 0;
@@ -591,7 +589,7 @@ static void parse_elf_finish(struct elf_info *info)
 static int ignore_undef_symbol(struct elf_info *info, const char *symname)
 {
 	/* ignore __this_module, it will be resolved shortly */
-	if (strcmp(symname, VMLINUX_SYMBOL_STR(__this_module)) == 0)
+	if (strcmp(symname, "__this_module") == 0)
 		return 1;
 	/* ignore global offset table */
 	if (strcmp(symname, "_GLOBAL_OFFSET_TABLE_") == 0)
@@ -617,9 +615,6 @@ static int ignore_undef_symbol(struct elf_info *info, const char *symname)
 	return 0;
 }
 
-#define CRC_PFX     VMLINUX_SYMBOL_STR(__crc_)
-#define KSYMTAB_PFX VMLINUX_SYMBOL_STR(__ksymtab_)
-
 static void handle_modversions(struct module *mod, struct elf_info *info,
 			       Elf_Sym *sym, const char *symname)
 {
@@ -634,7 +629,7 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 		export = export_from_sec(info, get_secindex(info, sym));
 
 	/* CRC'd symbol */
-	if (strncmp(symname, CRC_PFX, strlen(CRC_PFX)) == 0) {
+	if (strncmp(symname, "__crc_", strlen("__crc_")) == 0) {
 		is_crc = true;
 		crc = (unsigned int) sym->st_value;
 		if (sym->st_shndx != SHN_UNDEF && sym->st_shndx != SHN_ABS) {
@@ -647,7 +642,7 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 				info->sechdrs[sym->st_shndx].sh_addr : 0);
 			crc = *crcp;
 		}
-		sym_update_crc(symname + strlen(CRC_PFX), mod, crc,
+		sym_update_crc(symname + strlen("__crc_"), mod, crc,
 				export);
 	}
 
@@ -685,15 +680,10 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 		}
 #endif
 
-#ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
-		if (symname[0] != '_')
-			break;
-		else
-			symname++;
-#endif
 		if (is_crc) {
 			const char *e = is_vmlinux(mod->name) ?"":".ko";
-			warn("EXPORT symbol \"%s\" [%s%s] version generation failed, symbol will not be versioned.\n", symname + strlen(CRC_PFX), mod->name, e);
+			warn("EXPORT symbol \"%s\" [%s%s] version generation failed, symbol will not be versioned.\n",
+			     symname + strlen("__crc_"), mod->name, e);
 		}
 		mod->unres = alloc_symbol(symname,
 					  ELF_ST_BIND(sym->st_info) == STB_WEAK,
@@ -701,13 +691,13 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 		break;
 	default:
 		/* All exported symbols */
-		if (strncmp(symname, KSYMTAB_PFX, strlen(KSYMTAB_PFX)) == 0) {
-			sym_add_exported(symname + strlen(KSYMTAB_PFX), mod,
+		if (strncmp(symname, "__ksymtab_", strlen("__ksymtab_")) == 0) {
+			sym_add_exported(symname + strlen("__ksymtab_"), mod,
 					export);
 		}
-		if (strcmp(symname, VMLINUX_SYMBOL_STR(init_module)) == 0)
+		if (strcmp(symname, "init_module") == 0)
 			mod->has_init = 1;
-		if (strcmp(symname, VMLINUX_SYMBOL_STR(cleanup_module)) == 0)
+		if (strcmp(symname, "cleanup_module") == 0)
 			mod->has_cleanup = 1;
 		break;
 	}
@@ -2230,7 +2220,7 @@ static int add_versions(struct buffer *b, struct module *mod)
 			err = 1;
 			break;
 		}
-		buf_printf(b, "\t{ %#8x, __VMLINUX_SYMBOL_STR(%s) },\n",
+		buf_printf(b, "\t{ %#8x, \"%s\" },\n",
 			   s->crc, s->name);
 	}
 
-- 
2.7.4
