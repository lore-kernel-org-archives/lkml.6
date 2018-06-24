Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6385CC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196E724F15
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196E724F15
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeFXNlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 09:41:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43447 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbeFXNk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 09:40:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5ODerdp843879
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 24 Jun 2018 06:40:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5ODerJo843876;
        Sun, 24 Jun 2018 06:40:53 -0700
Date:   Sun, 24 Jun 2018 06:40:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-f3be1e7b2cf8bc096386a3588fc640b0db6b28d7@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, reinette.chatre@intel.com
Reply-To: tglx@linutronix.de, reinette.chatre@intel.com, mingo@kernel.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <36c1414e9bd17c3faf440f32b644b9c879bcbae2.1529706536.git.reinette.chatre@intel.com>
References: <36c1414e9bd17c3faf440f32b644b9c879bcbae2.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Support L3 cache performance event
 of Broadwell
Git-Commit-ID: f3be1e7b2cf8bc096386a3588fc640b0db6b28d7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f3be1e7b2cf8bc096386a3588fc640b0db6b28d7
Gitweb:     https://git.kernel.org/tip/f3be1e7b2cf8bc096386a3588fc640b0db6b28d7
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:42:29 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 24 Jun 2018 15:35:48 +0200

x86/intel_rdt: Support L3 cache performance event of Broadwell

Broadwell microarchitecture supports pseudo-locking. Add support for
the L3 cache related performance events of these systems so that
the success of pseudo-locking can be measured more accurately on these
platforms.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/36c1414e9bd17c3faf440f32b644b9c879bcbae2.1529706536.git.reinette.chatre@intel.com


---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c       | 56 +++++++++++++++++++++++
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h | 10 ++++
 2 files changed, 66 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 9e808c07a7f0..dd1341557c9d 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -850,6 +850,8 @@ static int measure_cycles_lat_fn(void *_plr)
 
 static int measure_cycles_perf_fn(void *_plr)
 {
+	unsigned long long l3_hits = 0, l3_miss = 0;
+	u64 l3_hit_bits = 0, l3_miss_bits = 0;
 	struct pseudo_lock_region *plr = _plr;
 	unsigned long long l2_hits, l2_miss;
 	u64 l2_hit_bits, l2_miss_bits;
@@ -883,6 +885,16 @@ static int measure_cycles_perf_fn(void *_plr)
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
@@ -901,6 +913,14 @@ static int measure_cycles_perf_fn(void *_plr)
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
@@ -917,9 +937,21 @@ static int measure_cycles_perf_fn(void *_plr)
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
@@ -937,11 +969,35 @@ static int measure_cycles_perf_fn(void *_plr)
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
