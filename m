Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C720C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE13420685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE13420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440270AbeKXCSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:18:07 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47660 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388503AbeKXCSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:18:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A07435CD;
        Fri, 23 Nov 2018 07:33:28 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C37703F5AF;
        Fri, 23 Nov 2018 07:33:26 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mingo@kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH] locking/atomics: build atomic headers as required
Date:   Fri, 23 Nov 2018 15:33:21 +0000
Message-Id: <20181123153321.8561-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew and Ingo report that the check-atomics.sh script is simply too
slow to run for every kernel build, and it's impractical to make it
faster without rewriting it in something other than shell.

Rather than committing the generated headers, let's regenerate these
as-required for a pristine tree.

That ensures they're always up-to-date, allows them to be built in
parallel, and avoid redundant rebuilds, which is a 2-8s saving per
incremental build. Since the results are not committed, it's very
obvious that they should not be modified directly. If we need to
generate more headers in future, it's easy to extend Makefile.genheader
to permit this.

I've verified that this works in the cases we previously had issues with
(out-of-tree builds and where scripts have no execute permissions), and
have tested these cases for both x86_64 and arm64.

The diffstat looks nice, at least...

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org
---
 Kbuild                                    |   18 +-
 Makefile                                  |    8 +-
 arch/arm64/include/asm/atomic.h           |    2 +-
 arch/x86/include/asm/atomic.h             |    2 +-
 include/asm-generic/atomic-instrumented.h | 1787 ----------------------
 include/asm-generic/atomic-long.h         | 1012 -------------
 include/linux/atomic-fallback.h           | 2294 -----------------------------
 include/linux/atomic.h                    |    4 +-
 scripts/Makefile.genheader                |   23 +
 scripts/atomic/check-atomics.sh           |   19 -
 10 files changed, 35 insertions(+), 5134 deletions(-)
 delete mode 100644 include/asm-generic/atomic-instrumented.h
 delete mode 100644 include/asm-generic/atomic-long.h
 delete mode 100644 include/linux/atomic-fallback.h
 create mode 100644 scripts/Makefile.genheader
 delete mode 100755 scripts/atomic/check-atomics.sh

Andrew, Ingo, 

Could you please let me know whether you're happy with this?

This is based on the tip locking/core branch.

Locally, for a -j64 build this saves me ~2s for a pristine tree, and ~5s
for a rebuild:

  # before, pristine
  make -j64 -s  195.32s user 15.65s system 1670% cpu 12.631 total

  # before, rebuild
  make -j64 -s  2.55s user 1.64s system 64% cpu 6.468 total

  # after, pristine
  make -j64 -s  194.46s user 15.82s system 1965% cpu 10.701 total

  # after, rebuild
  make -j64 -s  2.34s user 1.02s system 179% cpu 1.865 total

Thanks,
Mark.

diff --git a/Kbuild b/Kbuild
index 780048056ac5..005304205482 100644
--- a/Kbuild
+++ b/Kbuild
@@ -6,8 +6,7 @@
 # 2) Generate timeconst.h
 # 3) Generate asm-offsets.h (may need bounds.h and timeconst.h)
 # 4) Check for missing system calls
-# 5) check atomics headers are up-to-date
-# 6) Generate constants.py (may need bounds.h)
+# 5) Generate constants.py (may need bounds.h)
 
 #####
 # 1) Generate bounds.h
@@ -73,20 +72,7 @@ missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
 	$(call cmd,syscalls)
 
 #####
-# 5) Check atomic headers are up-to-date
-#
-
-always += old-atomics
-targets += old-atomics
-
-quiet_cmd_atomics = CALL    $<
-      cmd_atomics = $(CONFIG_SHELL) $<
-
-old-atomics: scripts/atomic/check-atomics.sh FORCE
-	$(call cmd,atomics)
-
-#####
-# 6) Generate constants for Python GDB integration
+# 5) Generate constants for Python GDB integration
 #
 
 extra-$(CONFIG_GDB_SCRIPTS) += build_constants_py
diff --git a/Makefile b/Makefile
index 6c40d547513c..fd871d2c2f54 100644
--- a/Makefile
+++ b/Makefile
@@ -224,7 +224,7 @@ clean-targets := %clean mrproper cleandocs
 no-dot-config-targets := $(clean-targets) \
 			 cscope gtags TAGS tags help% %docs check% coccicheck \
 			 $(version_h) headers_% archheaders archscripts \
-			 %asm-generic kernelversion %src-pkg
+			 %asm-generic genheader kernelversion %src-pkg
 no-sync-config-targets := $(no-dot-config-targets) install %install \
 			   kernelrelease
 
@@ -1089,7 +1089,7 @@ endif
 # prepare2 creates a makefile if using a separate output directory.
 # From this point forward, .config has been reprocessed, so any rules
 # that need to depend on updated CONFIG_* values can be checked here.
-prepare2: prepare3 outputmakefile asm-generic
+prepare2: prepare3 outputmakefile asm-generic genheader
 
 prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h
 	$(cmd_crmodverdir)
@@ -1113,6 +1113,10 @@ uapi-asm-generic:
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
 	            src=uapi/asm obj=arch/$(SRCARCH)/include/generated/uapi/asm
 
+PHONY += genheader
+genheader:
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.genheader obj=include/generated
+
 PHONY += prepare-objtool
 prepare-objtool: $(objtool_target)
 
diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index 1f4e9ee641c9..57c73cde3a51 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -166,7 +166,7 @@
 
 #define arch_atomic64_dec_if_positive		arch_atomic64_dec_if_positive
 
-#include <asm-generic/atomic-instrumented.h>
+#include <generated/atomic-instrumented.h>
 
 #endif
 #endif
diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index ea3d95275b43..d1e3aca236e2 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -262,6 +262,6 @@ static inline int arch_atomic_fetch_xor(int i, atomic_t *v)
 # include <asm/atomic64_64.h>
 #endif
 
-#include <asm-generic/atomic-instrumented.h>
+#include <generated/atomic-instrumented.h>
 
 #endif /* _ASM_X86_ATOMIC_H */
diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
deleted file mode 100644
index b8f5b35216e1..000000000000
diff --git a/include/asm-generic/atomic-long.h b/include/asm-generic/atomic-long.h
deleted file mode 100644
index a833d385a70b..000000000000
diff --git a/include/linux/atomic-fallback.h b/include/linux/atomic-fallback.h
deleted file mode 100644
index 1c02c0112fbb..000000000000
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 4c0d009a46f0..bea7ceec44af 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -71,8 +71,8 @@
 	__ret;								\
 })
 
-#include <linux/atomic-fallback.h>
+#include <generated/atomic-fallback.h>
 
-#include <asm-generic/atomic-long.h>
+#include <generated/atomic-long.h>
 
 #endif /* _LINUX_ATOMIC_H */
diff --git a/scripts/Makefile.genheader b/scripts/Makefile.genheader
new file mode 100644
index 000000000000..d4cc070c27c9
--- /dev/null
+++ b/scripts/Makefile.genheader
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Generate common headers under include/generated/
+
+include scripts/Kbuild.include
+
+atomics-dir := $(srctree)/scripts/atomic
+atomic-tbl := $(atomics-dir)/atomics.tbl
+
+.PHONY: all
+
+targets += atomic-fallback.h
+targets += atomic-instrumented.h
+targets += atomic-long.h
+
+all: $(addprefix $(obj)/,$(targets))
+
+quiet_cmd_genheader = GENHDR  $@
+cmd_genheader = $(CONFIG_SHELL) $^ >$@
+
+$(obj)/atomic-%.h: $(atomics-dir)/gen-atomic-%.sh $(atomic-tbl)
+	$(call if_changed,genheader)
+
diff --git a/scripts/atomic/check-atomics.sh b/scripts/atomic/check-atomics.sh
deleted file mode 100755
index c30101cddf2d..000000000000
-- 
2.11.0

