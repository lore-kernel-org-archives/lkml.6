Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932994AbeCPDVV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 23:21:21 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:23931 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeCPDVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 23:21:19 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w2G3Ku2k020621
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Pitre <nicolas.pitre@linaro.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 7/7] kbuild: link vmlinux only once for CONFIG_TRIM_UNUSED_KSYMS
Date: Fri, 16 Mar 2018 12:20:49 +0900
Message-Id: <1521170449-31194-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
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
built up the dependency graph.

Because 'if_changed' is implemented based on '$?', this issue can be
narrowed down to how Make handles '$?'.

You can test it with the following simple code:

[Test Makefile]
  A: B
          @echo newer prerequisite: $?
          cp B A

  B: C
          cp C B
          touch A

[Result]
  $ rm -f A B
  $ touch C
  $ make
  cp C B
  touch A
  newer prerequisite: B
  cp B A

Here, 'A' has been touched in the recipe of 'B'.  So, the dependency
'A: B' has already been met before the recipe of 'A' is executed.
However, Make does not notice the fact that the recipe of 'B' also
updates 'A' as a side-effect.

The situation is similar in this case; 'vmlinux' has actually been
updated in the 'vmlinux_prereq' target.  Make cannot predict this, so
judges 'vmlinux' is old.

link-vmlinus.sh is costly, so it is better to not run it when unneeded.
Split CONFIG_TRIM_UNUSED_KSYMS recursion to a dedicated target.

The reason of commit 2441e78b1919 ("kbuild: better abstract vmlinux
sequential prerequisites") was to cater to CONFIG_BUILD_DOCSRC, but
it was later removed by commit 184892925118 ("samples: move blackfin
gptimers-example from Documentation").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - autoksyms_recursive should be surrounded by
    ifdef CONFIG_TRIM_UNUSED_KSYMS

Changes in v2:
  - Discard my wrong change to adjust_autoksyms.sh
  - Add more commit log to explain how Make is working

 Makefile | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index 5fee703..ff62b8e 100644
--- a/Makefile
+++ b/Makefile
@@ -998,17 +998,9 @@ export KBUILD_ALLDIRS := $(sort $(filter-out arch/%,$(vmlinux-alldirs)) arch Doc
 
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
+# Recurse until adjust_autoksyms.sh is satisfied
+PHONY += autoksyms_recursive
+autoksyms_recursive: $(vmlinux-deps)
 ifdef CONFIG_TRIM_UNUSED_KSYMS
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh \
 	  "$(MAKE) -f $(srctree)/Makefile vmlinux"
@@ -1034,7 +1026,13 @@ cmd_link-vmlinux =                                                 \
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
-- 
2.7.4
