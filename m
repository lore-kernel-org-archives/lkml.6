Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753962AbeBFV3O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 16:29:14 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:42547 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753172AbeBFV3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 16:29:12 -0500
X-Google-Smtp-Source: AH8x226+9wNT1rTeBjjLOJIUe4mrbrVJHd4alpnDnu7YimngzMCpShH8Oqvjg+WEA8KHEpzYxRPuQQ==
Date: Tue, 6 Feb 2018 22:29:08 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20180206212908.ldvni3cfay365rkn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 59410f5ac70a0949a6f06ba43eecb8f99be31291 Merge tag 'perf-urgent-for-mingo-4.16-20180205' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

Tooling fixes, plus add missing interval sampling to certain x86 PEBS events.

 Thanks,

	Ingo

------------------>
Arnaldo Carvalho de Melo (5):
      tools headers: Synchronize sound/asound.h
      tooling headers: Synchronize updated s390 kvm UAPI headers
      tools headers: Sync {tools/,}arch/powerpc/include/uapi/asm/kvm.h
      tools headers: Synchronize uapi/linux/sched.h
      tools headers: Synchoronize x86 features UAPI headers

Jiri Olsa (3):
      perf evsel: Fix period/freq terms setup
      perf record: Fix period option handling
      x86/events/intel/ds: Add PERF_SAMPLE_PERIOD into PEBS_FREERUNNING_FLAGS

Ravi Bangoria (2):
      perf trace: Fix call-graph output
      perf tools: Add trace/beauty/generated/ into .gitignore


 arch/x86/events/perf_event.h                   |  3 ++-
 tools/arch/powerpc/include/uapi/asm/kvm.h      | 25 +++++++++++++++++++++++++
 tools/arch/s390/include/uapi/asm/kvm.h         |  5 ++++-
 tools/arch/x86/include/asm/cpufeatures.h       | 24 ++++++++++++++++++++----
 tools/arch/x86/include/asm/disabled-features.h |  3 ++-
 tools/arch/x86/include/asm/required-features.h |  3 ++-
 tools/include/uapi/linux/kvm.h                 |  4 ++++
 tools/include/uapi/linux/sched.h               |  5 +++++
 tools/include/uapi/sound/asound.h              |  9 +++++++++
 tools/perf/.gitignore                          |  1 +
 tools/perf/builtin-record.c                    |  3 ++-
 tools/perf/builtin-trace.c                     |  5 ++++-
 tools/perf/perf.h                              |  1 +
 tools/perf/util/evsel.c                        | 13 ++++++++++---
 14 files changed, 91 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 8e4ea143ed96..78f91ec1056e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -93,7 +93,8 @@ struct amd_nb {
 	PERF_SAMPLE_ID | PERF_SAMPLE_CPU | PERF_SAMPLE_STREAM_ID | \
 	PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_IDENTIFIER | \
 	PERF_SAMPLE_TRANSACTION | PERF_SAMPLE_PHYS_ADDR | \
-	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)
+	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER | \
+	PERF_SAMPLE_PERIOD)
 
 #define PEBS_REGS \
 	(PERF_REG_X86_AX | \
diff --git a/tools/arch/powerpc/include/uapi/asm/kvm.h b/tools/arch/powerpc/include/uapi/asm/kvm.h
index 61d6049f4c1e..637b7263cb86 100644
--- a/tools/arch/powerpc/include/uapi/asm/kvm.h
+++ b/tools/arch/powerpc/include/uapi/asm/kvm.h
@@ -443,6 +443,31 @@ struct kvm_ppc_rmmu_info {
 	__u32	ap_encodings[8];
 };
 
+/* For KVM_PPC_GET_CPU_CHAR */
+struct kvm_ppc_cpu_char {
+	__u64	character;		/* characteristics of the CPU */
+	__u64	behaviour;		/* recommended software behaviour */
+	__u64	character_mask;		/* valid bits in character */
+	__u64	behaviour_mask;		/* valid bits in behaviour */
+};
+
+/*
+ * Values for character and character_mask.
+ * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
+ */
+#define KVM_PPC_CPU_CHAR_SPEC_BAR_ORI31		(1ULL << 63)
+#define KVM_PPC_CPU_CHAR_BCCTRL_SERIALISED	(1ULL << 62)
+#define KVM_PPC_CPU_CHAR_L1D_FLUSH_ORI30	(1ULL << 61)
+#define KVM_PPC_CPU_CHAR_L1D_FLUSH_TRIG2	(1ULL << 60)
+#define KVM_PPC_CPU_CHAR_L1D_THREAD_PRIV	(1ULL << 59)
+#define KVM_PPC_CPU_CHAR_BR_HINT_HONOURED	(1ULL << 58)
+#define KVM_PPC_CPU_CHAR_MTTRIG_THR_RECONF	(1ULL << 57)
+#define KVM_PPC_CPU_CHAR_COUNT_CACHE_DIS	(1ULL << 56)
+
+#define KVM_PPC_CPU_BEHAV_FAVOUR_SECURITY	(1ULL << 63)
+#define KVM_PPC_CPU_BEHAV_L1D_FLUSH_PR		(1ULL << 62)
+#define KVM_PPC_CPU_BEHAV_BNDS_CHK_SPEC_BAR	(1ULL << 61)
+
 /* Per-vcpu XICS interrupt controller state */
 #define KVM_REG_PPC_ICP_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x8c)
 
diff --git a/tools/arch/s390/include/uapi/asm/kvm.h b/tools/arch/s390/include/uapi/asm/kvm.h
index 38535a57fef8..4cdaa55fabfe 100644
--- a/tools/arch/s390/include/uapi/asm/kvm.h
+++ b/tools/arch/s390/include/uapi/asm/kvm.h
@@ -224,6 +224,7 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_RICCB  (1UL << 7)
 #define KVM_SYNC_FPRS   (1UL << 8)
 #define KVM_SYNC_GSCB   (1UL << 9)
+#define KVM_SYNC_BPBC   (1UL << 10)
 /* length and alignment of the sdnx as a power of two */
 #define SDNXC 8
 #define SDNXL (1UL << SDNXC)
@@ -247,7 +248,9 @@ struct kvm_sync_regs {
 	};
 	__u8  reserved[512];	/* for future vector expansion */
 	__u32 fpc;		/* valid on KVM_SYNC_VRS or KVM_SYNC_FPRS */
-	__u8 padding1[52];	/* riccb needs to be 64byte aligned */
+	__u8 bpbc : 1;		/* bp mode */
+	__u8 reserved2 : 7;
+	__u8 padding1[51];	/* riccb needs to be 64byte aligned */
 	__u8 riccb[64];		/* runtime instrumentation controls block */
 	__u8 padding2[192];	/* sdnx needs to be 256byte aligned */
 	union {
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 21ac898df2d8..1d9199e1c2ad 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -13,7 +13,7 @@
 /*
  * Defines x86 CPU feature bits
  */
-#define NCAPINTS			18	   /* N 32-bit words worth of info */
+#define NCAPINTS			19	   /* N 32-bit words worth of info */
 #define NBUGINTS			1	   /* N 32-bit bug flags */
 
 /*
@@ -203,12 +203,15 @@
 #define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterface */
 #define X86_FEATURE_SME			( 7*32+10) /* AMD Secure Memory Encryption */
 #define X86_FEATURE_PTI			( 7*32+11) /* Kernel Page Table Isolation enabled */
+#define X86_FEATURE_RETPOLINE		( 7*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
+#define X86_FEATURE_RETPOLINE_AMD	( 7*32+13) /* "" AMD Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_INTEL_PPIN		( 7*32+14) /* Intel Processor Inventory Number */
-#define X86_FEATURE_INTEL_PT		( 7*32+15) /* Intel Processor Trace */
-#define X86_FEATURE_AVX512_4VNNIW	( 7*32+16) /* AVX-512 Neural Network Instructions */
-#define X86_FEATURE_AVX512_4FMAPS	( 7*32+17) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_CDP_L2		( 7*32+15) /* Code and Data Prioritization L2 */
 
 #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
+#define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
+
+#define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
@@ -243,6 +246,7 @@
 #define X86_FEATURE_AVX512IFMA		( 9*32+21) /* AVX-512 Integer Fused Multiply-Add instructions */
 #define X86_FEATURE_CLFLUSHOPT		( 9*32+23) /* CLFLUSHOPT instruction */
 #define X86_FEATURE_CLWB		( 9*32+24) /* CLWB instruction */
+#define X86_FEATURE_INTEL_PT		( 9*32+25) /* Intel Processor Trace */
 #define X86_FEATURE_AVX512PF		( 9*32+26) /* AVX-512 Prefetch */
 #define X86_FEATURE_AVX512ER		( 9*32+27) /* AVX-512 Exponential and Reciprocal */
 #define X86_FEATURE_AVX512CD		( 9*32+28) /* AVX-512 Conflict Detection */
@@ -268,6 +272,9 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* Instructions Retired Count */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* Always save/restore FP error pointers */
+#define X86_FEATURE_IBPB		(13*32+12) /* Indirect Branch Prediction Barrier */
+#define X86_FEATURE_IBRS		(13*32+14) /* Indirect Branch Restricted Speculation */
+#define X86_FEATURE_STIBP		(13*32+15) /* Single Thread Indirect Branch Predictors */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
@@ -316,6 +323,13 @@
 #define X86_FEATURE_SUCCOR		(17*32+ 1) /* Uncorrectable error containment and recovery */
 #define X86_FEATURE_SMCA		(17*32+ 3) /* Scalable MCA */
 
+/* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
+#define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
+#define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
+#define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
+
 /*
  * BUG word(s)
  */
@@ -342,5 +356,7 @@
 #define X86_BUG_MONITOR			X86_BUG(12) /* IPI required to wake up remote CPU */
 #define X86_BUG_AMD_E400		X86_BUG(13) /* CPU is among the affected by Erratum 400 */
 #define X86_BUG_CPU_MELTDOWN		X86_BUG(14) /* CPU is affected by meltdown attack and needs kernel page table isolation */
+#define X86_BUG_SPECTRE_V1		X86_BUG(15) /* CPU is affected by Spectre variant 1 attack with conditional branches */
+#define X86_BUG_SPECTRE_V2		X86_BUG(16) /* CPU is affected by Spectre variant 2 attack with indirect branches */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index b027633e7300..33833d1909af 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -77,6 +77,7 @@
 #define DISABLED_MASK15	0
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP)
 #define DISABLED_MASK17	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 18)
+#define DISABLED_MASK18	0
+#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/tools/arch/x86/include/asm/required-features.h b/tools/arch/x86/include/asm/required-features.h
index d91ba04dd007..fb3a6de7440b 100644
--- a/tools/arch/x86/include/asm/required-features.h
+++ b/tools/arch/x86/include/asm/required-features.h
@@ -106,6 +106,7 @@
 #define REQUIRED_MASK15	0
 #define REQUIRED_MASK16	(NEED_LA57)
 #define REQUIRED_MASK17	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 18)
+#define REQUIRED_MASK18	0
+#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
 
 #endif /* _ASM_X86_REQUIRED_FEATURES_H */
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 496e59a2738b..8fb90a0819c3 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -932,6 +932,8 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_SYNIC2 148
 #define KVM_CAP_HYPERV_VP_INDEX 149
 #define KVM_CAP_S390_AIS_MIGRATION 150
+#define KVM_CAP_PPC_GET_CPU_CHAR 151
+#define KVM_CAP_S390_BPB 152
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1261,6 +1263,8 @@ struct kvm_s390_ucas_mapping {
 #define KVM_PPC_CONFIGURE_V3_MMU  _IOW(KVMIO,  0xaf, struct kvm_ppc_mmuv3_cfg)
 /* Available with KVM_CAP_PPC_RADIX_MMU */
 #define KVM_PPC_GET_RMMU_INFO	  _IOW(KVMIO,  0xb0, struct kvm_ppc_rmmu_info)
+/* Available with KVM_CAP_PPC_GET_CPU_CHAR */
+#define KVM_PPC_GET_CPU_CHAR	  _IOR(KVMIO,  0xb1, struct kvm_ppc_cpu_char)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index 30a9e51bbb1e..22627f80063e 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -49,5 +49,10 @@
  */
 #define SCHED_FLAG_RESET_ON_FORK	0x01
 #define SCHED_FLAG_RECLAIM		0x02
+#define SCHED_FLAG_DL_OVERRUN		0x04
+
+#define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
+			 SCHED_FLAG_RECLAIM		| \
+			 SCHED_FLAG_DL_OVERRUN)
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/tools/include/uapi/sound/asound.h b/tools/include/uapi/sound/asound.h
index c227ccba60ae..07d61583fd02 100644
--- a/tools/include/uapi/sound/asound.h
+++ b/tools/include/uapi/sound/asound.h
@@ -214,6 +214,11 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_IMA_ADPCM	((__force snd_pcm_format_t) 22)
 #define	SNDRV_PCM_FORMAT_MPEG		((__force snd_pcm_format_t) 23)
 #define	SNDRV_PCM_FORMAT_GSM		((__force snd_pcm_format_t) 24)
+#define	SNDRV_PCM_FORMAT_S20_LE	((__force snd_pcm_format_t) 25) /* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_S20_BE	((__force snd_pcm_format_t) 26) /* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_U20_LE	((__force snd_pcm_format_t) 27) /* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_U20_BE	((__force snd_pcm_format_t) 28) /* in four bytes, LSB justified */
+/* gap in the numbering for a future standard linear format */
 #define	SNDRV_PCM_FORMAT_SPECIAL	((__force snd_pcm_format_t) 31)
 #define	SNDRV_PCM_FORMAT_S24_3LE	((__force snd_pcm_format_t) 32)	/* in three bytes */
 #define	SNDRV_PCM_FORMAT_S24_3BE	((__force snd_pcm_format_t) 33)	/* in three bytes */
@@ -248,6 +253,8 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_FLOAT		SNDRV_PCM_FORMAT_FLOAT_LE
 #define	SNDRV_PCM_FORMAT_FLOAT64	SNDRV_PCM_FORMAT_FLOAT64_LE
 #define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE
+#define	SNDRV_PCM_FORMAT_S20		SNDRV_PCM_FORMAT_S20_LE
+#define	SNDRV_PCM_FORMAT_U20		SNDRV_PCM_FORMAT_U20_LE
 #endif
 #ifdef SNDRV_BIG_ENDIAN
 #define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_BE
@@ -259,6 +266,8 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_FLOAT		SNDRV_PCM_FORMAT_FLOAT_BE
 #define	SNDRV_PCM_FORMAT_FLOAT64	SNDRV_PCM_FORMAT_FLOAT64_BE
 #define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE
+#define	SNDRV_PCM_FORMAT_S20		SNDRV_PCM_FORMAT_S20_BE
+#define	SNDRV_PCM_FORMAT_U20		SNDRV_PCM_FORMAT_U20_BE
 #endif
 
 typedef int __bitwise snd_pcm_subformat_t;
diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 643cc4ba6872..3e5135dded16 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -31,5 +31,6 @@ config.mak.autogen
 .config-detected
 util/intel-pt-decoder/inat-tables.c
 arch/*/include/generated/
+trace/beauty/generated/
 pmu-events/pmu-events.c
 pmu-events/jevents
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 65681a1a292a..bf4ca749d1ac 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1566,7 +1566,8 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN_SET('T', "timestamp", &record.opts.sample_time,
 			&record.opts.sample_time_set,
 			"Record the sample timestamps"),
-	OPT_BOOLEAN('P', "period", &record.opts.period, "Record the sample period"),
+	OPT_BOOLEAN_SET('P', "period", &record.opts.period, &record.opts.period_set,
+			"Record the sample period"),
 	OPT_BOOLEAN('n', "no-samples", &record.opts.no_samples,
 		    "don't sample"),
 	OPT_BOOLEAN_SET('N', "no-buildid-cache", &record.no_buildid_cache,
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 17d11deeb88d..e7f1b182fc15 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1661,9 +1661,12 @@ static int trace__resolve_callchain(struct trace *trace, struct perf_evsel *evse
 				    struct callchain_cursor *cursor)
 {
 	struct addr_location al;
+	int max_stack = evsel->attr.sample_max_stack ?
+			evsel->attr.sample_max_stack :
+			trace->max_stack;
 
 	if (machine__resolve(trace->host, &al, sample) < 0 ||
-	    thread__resolve_callchain(al.thread, cursor, evsel, sample, NULL, NULL, evsel->attr.sample_max_stack))
+	    thread__resolve_callchain(al.thread, cursor, evsel, sample, NULL, NULL, max_stack))
 		return -1;
 
 	return 0;
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 2357f4ccc9c7..cfe46236a5e5 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -50,6 +50,7 @@ struct record_opts {
 	bool	     sample_time_set;
 	bool	     sample_cpu;
 	bool	     period;
+	bool	     period_set;
 	bool	     running_time;
 	bool	     full_auxtrace;
 	bool	     auxtrace_snapshot_mode;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 66fa45198a11..ff359c9ece2e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -745,12 +745,14 @@ static void apply_config_terms(struct perf_evsel *evsel,
 			if (!(term->weak && opts->user_interval != ULLONG_MAX)) {
 				attr->sample_period = term->val.period;
 				attr->freq = 0;
+				perf_evsel__reset_sample_bit(evsel, PERIOD);
 			}
 			break;
 		case PERF_EVSEL__CONFIG_TERM_FREQ:
 			if (!(term->weak && opts->user_freq != UINT_MAX)) {
 				attr->sample_freq = term->val.freq;
 				attr->freq = 1;
+				perf_evsel__set_sample_bit(evsel, PERIOD);
 			}
 			break;
 		case PERF_EVSEL__CONFIG_TERM_TIME:
@@ -969,9 +971,6 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	if (target__has_cpu(&opts->target) || opts->sample_cpu)
 		perf_evsel__set_sample_bit(evsel, CPU);
 
-	if (opts->period)
-		perf_evsel__set_sample_bit(evsel, PERIOD);
-
 	/*
 	 * When the user explicitly disabled time don't force it here.
 	 */
@@ -1073,6 +1072,14 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	apply_config_terms(evsel, opts, track);
 
 	evsel->ignore_missing_thread = opts->ignore_missing_thread;
+
+	/* The --period option takes the precedence. */
+	if (opts->period_set) {
+		if (opts->period)
+			perf_evsel__set_sample_bit(evsel, PERIOD);
+		else
+			perf_evsel__reset_sample_bit(evsel, PERIOD);
+	}
 }
 
 static int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
