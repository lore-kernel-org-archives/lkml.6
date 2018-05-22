Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbeEVTdG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:33:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:16708 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752642AbeEVTcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:32:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="226406447"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V4 37/38] x86/intel_rdt: Support L3 cache performance event of Broadwell
Date: Tue, 22 May 2018 04:29:25 -0700
Message-Id: <3a60f2248a554b13b7dadcfde0135e82ac968e91.1526987654.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Broadwell microarchitecture supports pseudo-locking. Add support for
the L3 cache related performance events of these systems so that
the success of pseudo-locking can be measured more accurately on these
platforms.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c       | 56 +++++++++++++++++++++++
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h | 10 ++++
 2 files changed, 66 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 5cad8986923d..3a2772853f4a 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -832,6 +832,8 @@ static int measure_cycles_lat_fn(void *_plr)
 
 static int measure_cycles_perf_fn(void *_plr)
 {
+	unsigned long long l3_hits = 0, l3_miss = 0;
+	u64 l3_hit_bits = 0, l3_miss_bits = 0;
 	struct pseudo_lock_region *plr = _plr;
 	unsigned long long l2_hits, l2_miss;
 	u64 l2_hit_bits, l2_miss_bits;
@@ -865,6 +867,16 @@ static int measure_cycles_perf_fn(void *_plr)
 	 *     L2_HIT   02H
 	 *     L1_MISS  08H
 	 *     L2_MISS  10H
+	 *
+	 * On Broadwell Microarchitecture the MEM_LOAD_UOPS_RETIRED event
+	 * has two "no fix" errata associated with it: BDM35 and BDM100. On
+	 * this platform we use the following events instead:
+	 *  L2_RQSTS 24H (Documented in https://download.01.org/perfmon/BDW/)
+	 *       REFERENCES FFH
+	 *       MISS       3FH
+	 *  LONGEST_LAT_CACHE 2EH (Documented in SDM)
+	 *       REFERENCE 4FH
+	 *       MISS      41H
 	 */
 
 	/*
@@ -883,6 +895,14 @@ static int measure_cycles_perf_fn(void *_plr)
 		l2_hit_bits = (0x52ULL << 16) | (0x2 << 8) | 0xd1;
 		l2_miss_bits = (0x52ULL << 16) | (0x10 << 8) | 0xd1;
 		break;
+	case INTEL_FAM6_BROADWELL_X:
+		/* On BDW the l2_hit_bits count references, not hits */
+		l2_hit_bits = (0x52ULL << 16) | (0xff << 8) | 0x24;
+		l2_miss_bits = (0x52ULL << 16) | (0x3f << 8) | 0x24;
+		/* On BDW the l3_hit_bits count references, not hits */
+		l3_hit_bits = (0x52ULL << 16) | (0x4f << 8) | 0x2e;
+		l3_miss_bits = (0x52ULL << 16) | (0x41 << 8) | 0x2e;
+		break;
 	default:
 		goto out;
 	}
@@ -899,9 +919,21 @@ static int measure_cycles_perf_fn(void *_plr)
 	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 1, 0x0);
 	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_PERFCTR0, 0x0);
 	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_PERFCTR0 + 1, 0x0);
+	if (l3_hit_bits > 0) {
+		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 2, 0x0);
+		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 3, 0x0);
+		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_PERFCTR0 + 2, 0x0);
+		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_PERFCTR0 + 3, 0x0);
+	}
 	/* Set and enable the L2 counters */
 	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0, l2_hit_bits);
 	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 1, l2_miss_bits);
+	if (l3_hit_bits > 0) {
+		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 2,
+				      l3_hit_bits);
+		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 3,
+				      l3_miss_bits);
+	}
 	mem_r = plr->kmem;
 	size = plr->size;
 	line_size = plr->line_size;
@@ -919,11 +951,35 @@ static int measure_cycles_perf_fn(void *_plr)
 			      l2_hit_bits & ~(0x40ULL << 16));
 	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 1,
 			      l2_miss_bits & ~(0x40ULL << 16));
+	if (l3_hit_bits > 0) {
+		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 2,
+				      l3_hit_bits & ~(0x40ULL << 16));
+		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 3,
+				      l3_miss_bits & ~(0x40ULL << 16));
+	}
 	l2_hits = native_read_pmc(0);
 	l2_miss = native_read_pmc(1);
+	if (l3_hit_bits > 0) {
+		l3_hits = native_read_pmc(2);
+		l3_miss = native_read_pmc(3);
+	}
 	wrmsr(MSR_MISC_FEATURE_CONTROL, 0x0, 0x0);
 	local_irq_enable();
+	/*
+	 * On BDW we count references and misses, need to adjust. Sometimes
+	 * the "hits" counter is a bit more than the references, for
+	 * example, x references but x + 1 hits. To not report invalid
+	 * hit values in this case we treat that as misses eaqual to
+	 * references.
+	 */
+	if (boot_cpu_data.x86_model == INTEL_FAM6_BROADWELL_X)
+		l2_hits -= (l2_miss > l2_hits ? l2_hits : l2_miss);
 	trace_pseudo_lock_l2(l2_hits, l2_miss);
+	if (l3_hit_bits > 0) {
+		if (boot_cpu_data.x86_model == INTEL_FAM6_BROADWELL_X)
+			l3_hits -= (l3_miss > l3_hits ? l3_hits : l3_miss);
+		trace_pseudo_lock_l3(l3_hits, l3_miss);
+	}
 
 out:
 	plr->thread_done = 1;
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
index efad50d2ee2f..2c041e6d9f05 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
@@ -25,6 +25,16 @@ TRACE_EVENT(pseudo_lock_l2,
 	    TP_printk("hits=%llu miss=%llu",
 		      __entry->l2_hits, __entry->l2_miss));
 
+TRACE_EVENT(pseudo_lock_l3,
+	    TP_PROTO(u64 l3_hits, u64 l3_miss),
+	    TP_ARGS(l3_hits, l3_miss),
+	    TP_STRUCT__entry(__field(u64, l3_hits)
+			     __field(u64, l3_miss)),
+	    TP_fast_assign(__entry->l3_hits = l3_hits;
+			   __entry->l3_miss = l3_miss;),
+	    TP_printk("hits=%llu miss=%llu",
+		      __entry->l3_hits, __entry->l3_miss));
+
 #endif /* _TRACE_PSEUDO_LOCK_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.13.6
