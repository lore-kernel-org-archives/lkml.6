Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933734AbeEIHY6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:24:58 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:50743 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755400AbeEIHYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:24:50 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w497O36E028852
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] genksyms: remove symbol prefix support
Date: Wed,  9 May 2018 16:23:46 +0900
Message-Id: <1525850632-10921-3-git-send-email-yamada.masahiro@socionext.com>
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
hence the -s (--symbol-prefix) option is unnecessary.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build      |  2 --
 scripts/genksyms/genksyms.c | 11 +++--------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 8bdb1dc..22df8d0 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -147,7 +147,6 @@ $(obj)/%.i: $(src)/%.c FORCE
 cmd_gensymtypes_c =                                                         \
     $(CPP) -D__GENKSYMS__ $(c_flags) $< |                                   \
     $(GENKSYMS) $(if $(1), -T $(2))                                         \
-     $(patsubst y,-s _,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))             \
      $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
      $(if $(KBUILD_PRESERVE),-p)                                            \
      -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
@@ -355,7 +354,6 @@ cmd_gensymtypes_S =                                                         \
      sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/' ) | \
     $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
     $(GENKSYMS) $(if $(1), -T $(2))                                         \
-     $(patsubst y,-s _,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))             \
      $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
      $(if $(KBUILD_PRESERVE),-p)                                            \
      -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
index c9235d8..e007840 100644
--- a/scripts/genksyms/genksyms.c
+++ b/scripts/genksyms/genksyms.c
@@ -45,7 +45,6 @@ int in_source_file;
 
 static int flag_debug, flag_dump_defs, flag_reference, flag_dump_types,
 	   flag_preserve, flag_warnings, flag_rel_crcs;
-static const char *mod_prefix = "";
 
 static int errors;
 static int nsyms;
@@ -693,10 +692,10 @@ void export_symbol(const char *name)
 			fputs(">\n", debugfile);
 
 		/* Used as a linker script. */
-		printf(!flag_rel_crcs ? "%s__crc_%s = 0x%08lx;\n" :
+		printf(!flag_rel_crcs ? "__crc_%s = 0x%08lx;\n" :
 		       "SECTIONS { .rodata : ALIGN(4) { "
-		       "%s__crc_%s = .; LONG(0x%08lx); } }\n",
-		       mod_prefix, name, crc);
+		       "__crc_%s = .; LONG(0x%08lx); } }\n",
+		       name, crc);
 	}
 }
 
@@ -769,7 +768,6 @@ int main(int argc, char **argv)
 
 #ifdef __GNU_LIBRARY__
 	struct option long_opts[] = {
-		{"symbol-prefix", 1, 0, 's'},
 		{"debug", 0, 0, 'd'},
 		{"warnings", 0, 0, 'w'},
 		{"quiet", 0, 0, 'q'},
@@ -789,9 +787,6 @@ int main(int argc, char **argv)
 	while ((o = getopt(argc, argv, "s:dwqVDr:T:phR")) != EOF)
 #endif				/* __GNU_LIBRARY__ */
 		switch (o) {
-		case 's':
-			mod_prefix = optarg;
-			break;
 		case 'd':
 			flag_debug++;
 			break;
-- 
2.7.4
