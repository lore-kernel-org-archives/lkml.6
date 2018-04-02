Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbeDBGOs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 02:14:48 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33208 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeDBGOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 02:14:47 -0400
X-Google-Smtp-Source: AIpwx4972cZvD5895U/YtcqbbLLKgSP9kUim0r8zAZSB7N3b7U5HfmqN4D+QOtmss+X9NefL9I5e3A==
Date: Mon, 2 Apr 2018 08:14:43 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] misc core kernel changes
Message-ID: <20180402061443.yismaal7rly6ctpt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-core-for-linus

   # HEAD: 5ad751053704df3f00d2bb2dc9345c697c212150 panic: Add closing panic marker parenthesis

Two changes:

 - add membarriers to Documentation/features/
 - fix a minor nit in panic printk formatting

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      panic: Add closing panic marker parenthesis

Mathieu Desnoyers (2):
      Documentation/features: Allow comments in arch features files
      Documentation/features, membarriers: Document membarrier-sync-core architecture support


 Documentation/features/list-arch.sh                |  2 +-
 .../sched/membarrier-sync-core/arch-support.txt    | 62 ++++++++++++++++++++++
 kernel/panic.c                                     |  2 +-
 3 files changed, 64 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/features/sched/membarrier-sync-core/arch-support.txt

diff --git a/Documentation/features/list-arch.sh b/Documentation/features/list-arch.sh
index c16b5b595688..1ec47c3bb5fa 100755
--- a/Documentation/features/list-arch.sh
+++ b/Documentation/features/list-arch.sh
@@ -17,7 +17,7 @@ for F in */*/arch-support.txt; do
   N=$(grep -h "^# Feature name:"        $F | cut -c25-)
   C=$(grep -h "^#         Kconfig:"     $F | cut -c25-)
   D=$(grep -h "^#         description:" $F | cut -c25-)
-  S=$(grep -hw $ARCH $F | cut -d\| -f3)
+  S=$(grep -hv "^#" $F | grep -w $ARCH | cut -d\| -f3)
 
   printf "%10s/%-22s:%s| %35s # %s\n" "$SUBSYS" "$N" "$S" "$C" "$D"
 done
diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
new file mode 100644
index 000000000000..2c815a7f1ba7
--- /dev/null
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -0,0 +1,62 @@
+#
+# Feature name:          membarrier-sync-core
+#         Kconfig:       ARCH_HAS_MEMBARRIER_SYNC_CORE
+#         description:   arch supports core serializing membarrier
+#
+# Architecture requirements
+#
+# * arm64
+#
+# Rely on eret context synchronization when returning from IPI handler, and
+# when returning to user-space.
+#
+# * x86
+#
+# x86-32 uses IRET as return from interrupt, which takes care of the IPI.
+# However, it uses both IRET and SYSEXIT to go back to user-space. The IRET
+# instruction is core serializing, but not SYSEXIT.
+#
+# x86-64 uses IRET as return from interrupt, which takes care of the IPI.
+# However, it can return to user-space through either SYSRETL (compat code),
+# SYSRETQ, or IRET.
+#
+# Given that neither SYSRET{L,Q}, nor SYSEXIT, are core serializing, we rely
+# instead on write_cr3() performed by switch_mm() to provide core serialization
+# after changing the current mm, and deal with the special case of kthread ->
+# uthread (temporarily keeping current mm into active_mm) by issuing a
+# sync_core_before_usermode() in that specific case.
+#
+    -----------------------
+    |         arch |status|
+    -----------------------
+    |       alpha: | TODO |
+    |         arc: | TODO |
+    |         arm: | TODO |
+    |       arm64: |  ok  |
+    |    blackfin: | TODO |
+    |         c6x: | TODO |
+    |        cris: | TODO |
+    |         frv: | TODO |
+    |       h8300: | TODO |
+    |     hexagon: | TODO |
+    |        ia64: | TODO |
+    |        m32r: | TODO |
+    |        m68k: | TODO |
+    |       metag: | TODO |
+    |  microblaze: | TODO |
+    |        mips: | TODO |
+    |     mn10300: | TODO |
+    |       nios2: | TODO |
+    |    openrisc: | TODO |
+    |      parisc: | TODO |
+    |     powerpc: | TODO |
+    |        s390: | TODO |
+    |       score: | TODO |
+    |          sh: | TODO |
+    |       sparc: | TODO |
+    |        tile: | TODO |
+    |          um: | TODO |
+    |   unicore32: | TODO |
+    |         x86: |  ok  |
+    |      xtensa: | TODO |
+    -----------------------
diff --git a/kernel/panic.c b/kernel/panic.c
index 2cfef408fec9..9fb023d0cae1 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -289,7 +289,7 @@ void panic(const char *fmt, ...)
 		disabled_wait(caller);
 	}
 #endif
-	pr_emerg("---[ end Kernel panic - not syncing: %s\n", buf);
+	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 	local_irq_enable();
 	for (i = 0; ; i += PANIC_TIMER_STEP) {
 		touch_softlockup_watchdog();
