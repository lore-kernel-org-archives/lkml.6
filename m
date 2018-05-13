Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeEMMFE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 08:05:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49130 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeEMMFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 08:05:03 -0400
Date: Sun, 13 May 2018 14:05:01 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] perf fixes for 4.17
Message-ID: <alpine.DEB.2.21.1805131402231.1582@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

Another small set of perf tooling fixes and updates:

    . Revert "perf pmu: Fix pmu events parsing rule", as it broke Intel PT
      event description parsing (Arnaldo Carvalho de Melo)
    
    . Sync x86's cpufeatures.h and kvm UAPI headers with the kernel sources,
      suppressing the ABI drift warnings (Arnaldo Carvalho de Melo)
    
    - Remove duplicated entry for westmereep-dp in Intel's mapfile.csv (William Cohen)
    
    - Fix typo in 'perf bench numa' options description (Yisheng Xie)

Thanks,

	tglx

------------------>
Arnaldo Carvalho de Melo (4):
      tools headers: Sync x86 cpufeatures.h with the kernel sources
      tools headers kvm: Sync uapi/linux/kvm.h with the kernel sources
      tools headers kvm: Sync ARM UAPI headers with the kernel sources
      Revert "perf pmu: Fix pmu events parsing rule"

William Cohen (1):
      perf vendor events intel: Remove duplicated entry for westmereep-dp in mapfile.csv

Yisheng Xie (1):
      perf bench numa: Fix typo in options


 tools/arch/arm/include/uapi/asm/kvm.h      | 6 ++++++
 tools/arch/arm64/include/uapi/asm/kvm.h    | 6 ++++++
 tools/arch/x86/include/asm/cpufeatures.h   | 1 +
 tools/include/uapi/linux/kvm.h             | 7 +++++++
 tools/perf/bench/numa.c                    | 2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv | 1 -
 tools/perf/util/parse-events.y             | 8 ++++----
 7 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/tools/arch/arm/include/uapi/asm/kvm.h b/tools/arch/arm/include/uapi/asm/kvm.h
index 2ba95d6fe852..caae4843cb70 100644
--- a/tools/arch/arm/include/uapi/asm/kvm.h
+++ b/tools/arch/arm/include/uapi/asm/kvm.h
@@ -195,6 +195,12 @@ struct kvm_arch_memory_slot {
 #define KVM_REG_ARM_VFP_FPINST		0x1009
 #define KVM_REG_ARM_VFP_FPINST2		0x100A
 
+/* KVM-as-firmware specific pseudo-registers */
+#define KVM_REG_ARM_FW			(0x0014 << KVM_REG_ARM_COPROC_SHIFT)
+#define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM | KVM_REG_SIZE_U64 | \
+					 KVM_REG_ARM_FW | ((r) & 0xffff))
+#define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
+
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
 #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index 9abbf3044654..04b3256f8e6d 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -206,6 +206,12 @@ struct kvm_arch_memory_slot {
 #define KVM_REG_ARM_TIMER_CNT		ARM64_SYS_REG(3, 3, 14, 3, 2)
 #define KVM_REG_ARM_TIMER_CVAL		ARM64_SYS_REG(3, 3, 14, 0, 2)
 
+/* KVM-as-firmware specific pseudo-registers */
+#define KVM_REG_ARM_FW			(0x0014 << KVM_REG_ARM_COPROC_SHIFT)
+#define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
+					 KVM_REG_ARM_FW | ((r) & 0xffff))
+#define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
+
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
 #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index d554c11e01ff..578793e97431 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -320,6 +320,7 @@
 #define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* POPCNT for vectors of DW/QW */
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
+#define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 1065006c9bf5..b02c41e53d56 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -676,6 +676,13 @@ struct kvm_ioeventfd {
 	__u8  pad[36];
 };
 
+#define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
+#define KVM_X86_DISABLE_EXITS_HTL            (1 << 1)
+#define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
+#define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT | \
+                                              KVM_X86_DISABLE_EXITS_HTL | \
+                                              KVM_X86_DISABLE_EXITS_PAUSE)
+
 /* for KVM_ENABLE_CAP */
 struct kvm_enable_cap {
 	/* in */
diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 944070e98a2c..63eb49082774 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -175,7 +175,7 @@ static const struct option options[] = {
 	OPT_UINTEGER('s', "nr_secs"	, &p0.nr_secs,		"max number of seconds to run (default: 5 secs)"),
 	OPT_UINTEGER('u', "usleep"	, &p0.sleep_usecs,	"usecs to sleep per loop iteration"),
 
-	OPT_BOOLEAN('R', "data_reads"	, &p0.data_reads,	"access the data via writes (can be mixed with -W)"),
+	OPT_BOOLEAN('R', "data_reads"	, &p0.data_reads,	"access the data via reads (can be mixed with -W)"),
 	OPT_BOOLEAN('W', "data_writes"	, &p0.data_writes,	"access the data via writes (can be mixed with -R)"),
 	OPT_BOOLEAN('B', "data_backwards", &p0.data_backwards,	"access the data backwards as well"),
 	OPT_BOOLEAN('Z', "data_zero_memset", &p0.data_zero_memset,"access the data via glibc bzero only"),
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 93656f2fd53a..7e3cce3bcf3b 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -29,7 +29,6 @@ GenuineIntel-6-4D,v13,silvermont,core
 GenuineIntel-6-4C,v13,silvermont,core
 GenuineIntel-6-2A,v15,sandybridge,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
-GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v2,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
 GenuineIntel-6-55,v1,skylakex,core
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index d14464c42714..7afeb80cc39e 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -224,15 +224,15 @@ event_def: event_pmu |
 	   event_bpf_file
 
 event_pmu:
-PE_NAME '/' event_config '/'
+PE_NAME opt_event_config
 {
 	struct list_head *list, *orig_terms, *terms;
 
-	if (parse_events_copy_term_list($3, &orig_terms))
+	if (parse_events_copy_term_list($2, &orig_terms))
 		YYABORT;
 
 	ALLOC_LIST(list);
-	if (parse_events_add_pmu(_parse_state, list, $1, $3, false)) {
+	if (parse_events_add_pmu(_parse_state, list, $1, $2, false)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
 		char *pattern;
@@ -262,7 +262,7 @@ PE_NAME '/' event_config '/'
 		if (!ok)
 			YYABORT;
 	}
-	parse_events_terms__delete($3);
+	parse_events_terms__delete($2);
 	parse_events_terms__delete(orig_terms);
 	$$ = list;
 }
