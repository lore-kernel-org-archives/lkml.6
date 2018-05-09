Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934513AbeEIJu4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:50:56 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:53968 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934133AbeEIJuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:50:52 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w499oiPM018127
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] modpost: pass struct elf_info pointer to get_modinfo()
Date: Wed,  9 May 2018 18:50:37 +0900
Message-Id: <1525859440-29583-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_(next_)modinfo takes a pointer and length pair of the .modinfo
section.  Instead, pass struct elf_info pointer to reduce the number
of function arguments.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/mod/modpost.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index bc71925..37a6a0b4 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -724,16 +724,17 @@ static char *next_string(char *string, unsigned long *secsize)
 	return string;
 }
 
-static char *get_next_modinfo(void *modinfo, unsigned long modinfo_len,
-			      const char *tag, char *info)
+static char *get_next_modinfo(struct elf_info *info, const char *tag,
+			      char *prev)
 {
 	char *p;
 	unsigned int taglen = strlen(tag);
-	unsigned long size = modinfo_len;
+	char *modinfo = info->modinfo;
+	unsigned long size = info->modinfo_len;
 
-	if (info) {
-		size -= info - (char *)modinfo;
-		modinfo = next_string(info, &size);
+	if (prev) {
+		size -= prev - modinfo;
+		modinfo = next_string(prev, &size);
 	}
 
 	for (p = modinfo; p; p = next_string(p, &size)) {
@@ -743,11 +744,10 @@ static char *get_next_modinfo(void *modinfo, unsigned long modinfo_len,
 	return NULL;
 }
 
-static char *get_modinfo(void *modinfo, unsigned long modinfo_len,
-			 const char *tag)
+static char *get_modinfo(struct elf_info *info, const char *tag)
 
 {
-	return get_next_modinfo(modinfo, modinfo_len, tag, NULL);
+	return get_next_modinfo(info, tag, NULL);
 }
 
 /**
@@ -1951,7 +1951,7 @@ static void read_symbols(char *modname)
 		mod->skip = 1;
 	}
 
-	license = get_modinfo(info.modinfo, info.modinfo_len, "license");
+	license = get_modinfo(&info, "license");
 	if (!license && !is_vmlinux(modname))
 		warn("modpost: missing MODULE_LICENSE() in %s\n"
 		     "see include/linux/module.h for "
@@ -1963,8 +1963,7 @@ static void read_symbols(char *modname)
 			mod->gpl_compatible = 0;
 			break;
 		}
-		license = get_next_modinfo(info.modinfo, info.modinfo_len,
-					   "license", license);
+		license = get_next_modinfo(&info, "license", license);
 	}
 
 	for (sym = info.symtab_start; sym < info.symtab_stop; sym++) {
@@ -1977,7 +1976,7 @@ static void read_symbols(char *modname)
 	     (is_vmlinux(modname) && vmlinux_section_warnings))
 		check_sec_ref(mod, modname, &info);
 
-	version = get_modinfo(info.modinfo, info.modinfo_len, "version");
+	version = get_modinfo(&info, "version");
 	if (version)
 		maybe_frob_rcs_version(modname, version, info.modinfo,
 				       version - (char *)info.hdr);
-- 
2.7.4
