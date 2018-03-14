Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeCNQpS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:45:18 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:38080 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbeCNQou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:44:50 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w2EGiSdW001049
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
        Jarod Wilson <jarod@redhat.com>, Prarit Bhargava <prarit@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] kbuild: link vmlinux just once for CONFIG_TRIM_UNUSED_KSYMS
Date: Thu, 15 Mar 2018 01:44:21 +0900
Message-Id: <1521045861-22418-8-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_TRIM_UNUSED_KSYMS is enabled and the kernel is built from
a pristine state, the vmlinux is linked twice.

[1] A user runs "make"

[2] First build with empty autoksyms.h

[3] adjust_autoksyms.sh updates autoksyms.h and recurses "make vmlinux"

  --------(begin sub-make)--------
  [4] Second build with new autoksyms.h

  [5] link-vmlinux.sh is invoked because "vmlinux" is missing
  ---------(end sub-make)---------

[6] link-vmlinux.sh is invoked again despite "vmlinux" is up-to-date.

The reason of [6] is probably because Make already decided to update
"vmlinux" at the time of [2] because "vmlinux" was missing when Make
generated the dependency list.

link-vmlinus.sh is costly, so it is better to not run it when unneeded.
Split CONFIG_TRIM_UNUSED_KSYMS handling to a dedicated target.

The reason of commit 2441e78b1919 ("kbuild: better abstract vmlinux
sequential prerequisites") was to cater to CONFIG_BUILD_DOCSRC, but
it was later removed by commit 184892925118 ("samples: move blackfin
gptimers-example from Documentation").

I also changed adjust_autoksyms.sh to simply exit with 1 or 0 to make
it look straightforward.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                    | 28 ++++++++++++----------------
 scripts/adjust_autoksyms.sh |  3 +--
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index 1dab647..0a7bab6 100644
--- a/Makefile
+++ b/Makefile
@@ -987,21 +987,11 @@ export KBUILD_ALLDIRS := $(sort $(filter-out arch/%,$(vmlinux-alldirs)) arch Doc
 
 vmlinux-deps := $(KBUILD_LDS) $(KBUILD_VMLINUX_INIT) $(KBUILD_VMLINUX_MAIN) $(KBUILD_VMLINUX_LIBS)
 
-# Include targets which we want to execute sequentially if the rest of the
-# kernel build went well. If CONFIG_TRIM_UNUSED_KSYMS is set, this might be
-# evaluated more than once.
-PHONY += vmlinux_prereq
-vmlinux_prereq: $(vmlinux-deps) FORCE
-ifdef CONFIG_HEADERS_CHECK
-	$(Q)$(MAKE) -f $(srctree)/Makefile headers_check
-endif
-ifdef CONFIG_GDB_SCRIPTS
-	$(Q)ln -fsn $(abspath $(srctree)/scripts/gdb/vmlinux-gdb.py)
-endif
-ifdef CONFIG_TRIM_UNUSED_KSYMS
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh \
-	  "$(MAKE) -f $(srctree)/Makefile vmlinux"
-endif
+# Recurse until adjust_autoksyms.sh is satisfied
+PHONY += autoksyms_recursive
+autoksyms_recursive: $(vmlinux-deps)
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh || \
+	$(MAKE) -f $(srctree)/Makefile autoksyms_recursive
 
 # For the kernel to actually contain only the needed exported symbols,
 # we have to build modules as well to determine what those symbols are.
@@ -1023,7 +1013,13 @@ cmd_link-vmlinux =                                                 \
 	$(CONFIG_SHELL) $< $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) ;    \
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
-vmlinux: scripts/link-vmlinux.sh vmlinux_prereq $(vmlinux-deps) FORCE
+vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) FORCE
+ifdef CONFIG_HEADERS_CHECK
+	$(Q)$(MAKE) -f $(srctree)/Makefile headers_check
+endif
+ifdef CONFIG_GDB_SCRIPTS
+	$(Q)ln -fsn $(abspath $(srctree)/scripts/gdb/vmlinux-gdb.py)
+endif
 	+$(call if_changed,link-vmlinux)
 
 # Build samples along the rest of the kernel
diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index 7bb3618..1377cf8 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -95,8 +95,7 @@ if [ $changed -gt 0 ]; then
 	info "KSYMS" "symbols: before=$old, after=$new, changed=$changed"
 	info "UPD" "$cur_ksyms_file"
 	mv -f "$new_ksyms_file" "$cur_ksyms_file"
-	# Then trigger a rebuild of affected source files
-	exec $@
+	exit 1
 else
 	rm -f "$new_ksyms_file"
 fi
-- 
2.7.4
