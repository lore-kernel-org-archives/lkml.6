Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934538AbeEIJva (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:51:30 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:53967 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934150AbeEIJuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:50:52 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w499oiPN018127
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] modpost: use strstarts() helper more widely
Date: Wed,  9 May 2018 18:50:38 +0900
Message-Id: <1525859440-29583-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525859440-29583-1-git-send-email-yamada.masahiro@socionext.com>
References: <1525859440-29583-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, strstarts() is only used in export_from_secname().
Use it more widely to improve the code readability.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/mod/modpost.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 37a6a0b4..8606b6c 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -596,19 +596,19 @@ static int ignore_undef_symbol(struct elf_info *info, const char *symname)
 		return 1;
 	if (info->hdr->e_machine == EM_PPC)
 		/* Special register function linked on all modules during final link of .ko */
-		if (strncmp(symname, "_restgpr_", sizeof("_restgpr_") - 1) == 0 ||
-		    strncmp(symname, "_savegpr_", sizeof("_savegpr_") - 1) == 0 ||
-		    strncmp(symname, "_rest32gpr_", sizeof("_rest32gpr_") - 1) == 0 ||
-		    strncmp(symname, "_save32gpr_", sizeof("_save32gpr_") - 1) == 0 ||
-		    strncmp(symname, "_restvr_", sizeof("_restvr_") - 1) == 0 ||
-		    strncmp(symname, "_savevr_", sizeof("_savevr_") - 1) == 0)
+		if (strstarts(symname, "_restgpr_") ||
+		    strstarts(symname, "_savegpr_") ||
+		    strstarts(symname, "_rest32gpr_") ||
+		    strstarts(symname, "_save32gpr_") ||
+		    strstarts(symname, "_restvr_") ||
+		    strstarts(symname, "_savevr_"))
 			return 1;
 	if (info->hdr->e_machine == EM_PPC64)
 		/* Special register function linked on all modules during final link of .ko */
-		if (strncmp(symname, "_restgpr0_", sizeof("_restgpr0_") - 1) == 0 ||
-		    strncmp(symname, "_savegpr0_", sizeof("_savegpr0_") - 1) == 0 ||
-		    strncmp(symname, "_restvr_", sizeof("_restvr_") - 1) == 0 ||
-		    strncmp(symname, "_savevr_", sizeof("_savevr_") - 1) == 0 ||
+		if (strstarts(symname, "_restgpr0_") ||
+		    strstarts(symname, "_savegpr0_") ||
+		    strstarts(symname, "_restvr_") ||
+		    strstarts(symname, "_savevr_") ||
 		    strcmp(symname, ".TOC.") == 0)
 			return 1;
 	/* Do not ignore this symbol */
@@ -623,13 +623,13 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 	bool is_crc = false;
 
 	if ((!is_vmlinux(mod->name) || mod->is_dot_o) &&
-	    strncmp(symname, "__ksymtab", 9) == 0)
+	    strstarts(symname, "__ksymtab"))
 		export = export_from_secname(info, get_secindex(info, sym));
 	else
 		export = export_from_sec(info, get_secindex(info, sym));
 
 	/* CRC'd symbol */
-	if (strncmp(symname, "__crc_", strlen("__crc_")) == 0) {
+	if (strstarts(symname, "__crc_")) {
 		is_crc = true;
 		crc = (unsigned int) sym->st_value;
 		if (sym->st_shndx != SHN_UNDEF && sym->st_shndx != SHN_ABS) {
@@ -648,7 +648,7 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 
 	switch (sym->st_shndx) {
 	case SHN_COMMON:
-		if (!strncmp(symname, "__gnu_lto_", sizeof("__gnu_lto_")-1)) {
+		if (strstarts(symname, "__gnu_lto_")) {
 			/* Should warn here, but modpost runs before the linker */
 		} else
 			warn("\"%s\" [%s] is COMMON symbol\n", symname, mod->name);
@@ -691,7 +691,7 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 		break;
 	default:
 		/* All exported symbols */
-		if (strncmp(symname, "__ksymtab_", strlen("__ksymtab_")) == 0) {
+		if (strstarts(symname, "__ksymtab_")) {
 			sym_add_exported(symname + strlen("__ksymtab_"), mod,
 					export);
 		}
@@ -1171,13 +1171,13 @@ static int secref_whitelist(const struct sectioncheck *mismatch,
 	/* Check for pattern 1 */
 	if (match(tosec, init_data_sections) &&
 	    match(fromsec, data_sections) &&
-	    (strncmp(fromsym, "__param", strlen("__param")) == 0))
+	    strstarts(fromsym, "__param"))
 		return 0;
 
 	/* Check for pattern 1a */
 	if (strcmp(tosec, ".init.text") == 0 &&
 	    match(fromsec, data_sections) &&
-	    (strncmp(fromsym, "__param_ops_", strlen("__param_ops_")) == 0))
+	    strstarts(fromsym, "__param_ops_"))
 		return 0;
 
 	/* Check for pattern 2 */
@@ -1532,8 +1532,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	from = find_elf_symbol2(elf, r->r_offset, fromsec);
 	fromsym = sym_name(elf, from);
 
-	if (!strncmp(fromsym, "reference___initcall",
-		     sizeof("reference___initcall")-1))
+	if (strstarts(fromsym, "reference___initcall"))
 		return;
 
 	tosec = sec_name(elf, get_secindex(elf, sym));
@@ -2163,9 +2162,7 @@ static void add_retpoline(struct buffer *b)
 
 static void add_staging_flag(struct buffer *b, const char *name)
 {
-	static const char *staging_dir = "drivers/staging";
-
-	if (strncmp(staging_dir, name, strlen(staging_dir)) == 0)
+	if (strstarts(name, "drivers/staging"))
 		buf_printf(b, "\nMODULE_INFO(staging, \"Y\");\n");
 }
 
-- 
2.7.4
