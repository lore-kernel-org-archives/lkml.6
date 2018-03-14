Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeCNQpo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:45:44 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:38073 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbeCNQou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:44:50 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w2EGiSdV001049
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
        Jarod Wilson <jarod@redhat.com>, Prarit Bhargava <prarit@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] kbuild: move include/config/ksym/* to include/ksym/*
Date: Thu, 15 Mar 2018 01:44:20 +0900
Message-Id: <1521045861-22418-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea of using fixdep was inspired by Kconfig, but autoksyms
is unrelated to Kconfig.  So, I want to get those touched files
out of include/config/.  The directory include/ksym/ is removed
by "make clean".  We do not need to keep it for external module
building.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

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
index e60b16f..1dab647 100644
--- a/Makefile
+++ b/Makefile
@@ -1327,7 +1327,7 @@ endif # CONFIG_MODULES
 # make distclean Remove editor backup files, patch leftover files and the like
 
 # Directories & files removed with 'make clean'
-CLEAN_DIRS  += $(MODVERDIR)
+CLEAN_DIRS  += $(MODVERDIR) include/ksym
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config usr/include include/generated          \
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 065324a..045971e 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -368,7 +368,7 @@ ksym_dep_filter =                                                            \
 	    $(CPP) $(call flags_nodeps,a_flags) -D__KSYM_DEPS__ $< ;;        \
 	  boot*|build*|cpp_its_S|*cpp_lds_S|dtc|host*|vdso*) : ;;            \
 	  *) echo "Don't know how to preprocess $(1)" >&2; false ;;          \
-	esac | tr ";" "\n" | sed -rn 's/^.*=== __KSYM_(.*) ===.*$$/KSYM_\1/p'
+	esac | tr ";" "\n" | sed -rn 's/^.*=== __KSYM_(.*) ===.*$$/\1/p'
 
 cmd_and_fixdep =                                                             \
 	$(echo-cmd) $(cmd_$(1));                                             \
diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index a52210b..7bb3618 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -81,7 +81,7 @@ sort "$cur_ksyms_file" "$new_ksyms_file" | uniq -u |
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
