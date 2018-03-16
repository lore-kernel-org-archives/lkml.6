Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932747AbeCPCTQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 22:19:16 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:44534 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbeCPCTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:19:12 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w2G2IoBR003525
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] kbuild: move include/config/ksym/* to include/ksym/*
Date: Fri, 16 Mar 2018 11:18:43 +0900
Message-Id: <1521166725-24157-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521166725-24157-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521166725-24157-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea of using fixdep was inspired by Kconfig, but autoksyms
belongs to a different group.  So, I want move those touched files
under include/config/ksym/ to include/ksym/.

The directory include/ksym/ can be removed by "make clean" because
it is meaningless for the external module building.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
 - Rebase on linux-next
   (resolve a conflict to https://patchwork.kernel.org/patch/10204653/)

 .gitignore                  | 1 +
 Makefile                    | 2 +-
 scripts/Kbuild.include      | 2 +-
 scripts/adjust_autoksyms.sh | 2 +-
 scripts/basic/fixdep.c      | 8 ++++----
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/.gitignore b/.gitignore
index 1be78fd..85bcc26 100644
--- a/.gitignore
+++ b/.gitignore
@@ -87,6 +87,7 @@ modules.builtin
 #
 include/config
 include/generated
+include/ksym
 arch/*/include/generated
 
 # stgit generated dirs
diff --git a/Makefile b/Makefile
index ef42adb..5fee703 100644
--- a/Makefile
+++ b/Makefile
@@ -1338,7 +1338,7 @@ endif # CONFIG_MODULES
 # make distclean Remove editor backup files, patch leftover files and the like
 
 # Directories & files removed with 'make clean'
-CLEAN_DIRS  += $(MODVERDIR)
+CLEAN_DIRS  += $(MODVERDIR) include/ksym
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config usr/include include/generated          \
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index f9c2f07..cce31ee 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -366,7 +366,7 @@ ksym_dep_filter =                                                            \
 	    $(CPP) $(call flags_nodeps,a_flags) -D__KSYM_DEPS__ $< ;;        \
 	  boot*|build*|cpp_its_S|*cpp_lds_S|dtc|host*|vdso*) : ;;            \
 	  *) echo "Don't know how to preprocess $(1)" >&2; false ;;          \
-	esac | tr ";" "\n" | sed -n 's/^.*=== __KSYM_\(.*\) ===.*$$/KSYM_\1/p'
+	esac | tr ";" "\n" | sed -n 's/^.*=== __KSYM_\(.*\) ===.*$$/_\1/p'
 
 cmd_and_fixdep =                                                             \
 	$(echo-cmd) $(cmd_$(1));                                             \
diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index e0dd0d5..f11cae6 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -80,7 +80,7 @@ sort "$cur_ksyms_file" "$new_ksyms_file" | uniq -u |
 sed -n 's/^#define __KSYM_\(.*\) 1/\1/p' | tr "A-Z_" "a-z/" |
 while read sympath; do
 	if [ -z "$sympath" ]; then continue; fi
-	depfile="include/config/ksym/${sympath}.h"
+	depfile="include/ksym/${sympath}.h"
 	mkdir -p "$(dirname "$depfile")"
 	touch "$depfile"
 	echo $((count += 1))
diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index 449b68c..f387538 100644
--- a/scripts/basic/fixdep.c
+++ b/scripts/basic/fixdep.c
@@ -113,11 +113,11 @@ static void usage(void)
 /*
  * Print out a dependency path from a symbol name
  */
-static void print_config(const char *m, int slen)
+static void print_dep(const char *m, int slen, const char *dir)
 {
 	int c, i;
 
-	printf("    $(wildcard include/config/");
+	printf("    $(wildcard %s/", dir);
 	for (i = 0; i < slen; i++) {
 		c = m[i];
 		if (c == '_')
@@ -140,7 +140,7 @@ static void do_extra_deps(void)
 			fprintf(stderr, "fixdep: bad data on stdin\n");
 			exit(1);
 		}
-		print_config(buf, len - 1);
+		print_dep(buf, len - 1, "include/ksym");
 	}
 }
 
@@ -208,7 +208,7 @@ static void use_config(const char *m, int slen)
 	    return;
 
 	define_config(m, slen, hash);
-	print_config(m, slen);
+	print_dep(m, slen, "include/config");
 }
 
 /* test if s ends in sub */
-- 
2.7.4
