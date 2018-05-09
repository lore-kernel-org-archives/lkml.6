Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756320AbeEIHZr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:25:47 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:50858 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756217AbeEIHYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:24:54 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w497O36I028852
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] kbuild: remove CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
Date: Wed,  9 May 2018 16:23:50 +0900
Message-Id: <1525850632-10921-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
References: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX was selected by BLACKFIN, METAG.
They were removed by commit 4ba66a976072 ("arch: remove blackfin port"),
commit bb6fb6dfcc17 ("metag: Remove arch/metag/"), respectively.

No more architecture enables CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX.
Clean up the rest of scripts, and remove the Kconfig entry.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/Kconfig                | 6 ------
 scripts/Makefile.build      | 7 +------
 scripts/adjust_autoksyms.sh | 3 ---
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 3234b73..c88fa0e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -671,12 +671,6 @@ config MODULES_USE_ELF_REL
 	  Modules only use ELF REL relocations.  Modules with ELF RELA
 	  relocations will give an error.
 
-config HAVE_UNDERSCORE_SYMBOL_PREFIX
-	bool
-	help
-	  Some architectures generate an _ in front of C symbols; things like
-	  module loading and assembly files need to know about this.
-
 config HAVE_IRQ_EXIT_ON_IRQ_STACK
 	bool
 	help
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 22df8d0..753b9ad 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -485,15 +485,10 @@ targets += $(lib-target)
 
 dummy-object = $(obj)/.lib_exports.o
 ksyms-lds = $(dot-target).lds
-ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
-ref_prefix = EXTERN(_
-else
-ref_prefix = EXTERN(
-endif
 
 quiet_cmd_export_list = EXPORTS $@
 cmd_export_list = $(OBJDUMP) -h $< | \
-	sed -ne '/___ksymtab/s/.*+\([^ ]*\).*/$(ref_prefix)\1)/p' >$(ksyms-lds);\
+	sed -ne '/___ksymtab/s/.*+\([^ ]*\).*/EXTERN(\1)/p' >$(ksyms-lds);\
 	rm -f $(dummy-object);\
 	echo | $(CC) $(a_flags) -c -o $(dummy-object) -x assembler -;\
 	$(LD) $(ld_flags) -r -o $@ -T $(ksyms-lds) $(dummy-object);\
diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index 016b3c4..6e6d639 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -61,9 +61,6 @@ for mod in "$MODVERDIR"/*.mod; do
 	sed -n -e '3{s/ /\n/g;/^$/!p;}' "$mod"
 done | sort -u |
 while read sym; do
-	if [ -n "$CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX" ]; then
-		sym="${sym#_}"
-	fi
 	echo "#define __KSYM_${sym} 1"
 done >> "$new_ksyms_file"
 
-- 
2.7.4
