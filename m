Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBDAC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB2020693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB2020693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754336AbeFTAdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:33:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48651 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbeFTAdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:33:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0Wtmk3300473
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:32:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0WsLm3300470;
        Tue, 19 Jun 2018 17:32:54 -0700
Date:   Tue, 19 Jun 2018 17:32:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-1333d418c44559936c5079b7785af7bf2582487b@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        reinette.chatre@intel.com, hpa@zytor.com, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, reinette.chatre@intel.com,
          hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <5b91247c6ea44df78ddb18a2d488b86bbd20898c.1527593971.git.reinette.chatre@intel.com>
References: <5b91247c6ea44df78ddb18a2d488b86bbd20898c.1527593971.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Support L3 cache performance event
 of Broadwell
Git-Commit-ID: 1333d418c44559936c5079b7785af7bf2582487b
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

Commit-ID:  1333d418c44559936c5079b7785af7bf2582487b
Gitweb:     https://git.kernel.org/tip/1333d418c44559936c5079b7785af7bf2582487b
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:58:02 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:40 +0200

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
Link: https://lkml.kernel.org/r/5b91247c6ea44df78ddb18a2d488b86bbd20898c.1527593971.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c       | 56 +++++++++++++++++++++++
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h | 10 ++++
 2 files changed, 66 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index acaec07134c7..17ed2e9d4551 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -847,6 +847,8 @@ static int measure_cycles_lat_fn(void *_plr)
 
 static int measure_cycles_perf_fn(void *_plr)
 {
+	unsigned long long l3_hits = 0, l3_miss = 0;
+	u64 l3_hit_bits = 0, l3_miss_bits = 0;
 	struct pseudo_lock_region *plr = _plr;
 	unsigned long long l2_hits, l2_miss;
 	u64 l2_hit_bits, l2_miss_bits;
@@ -880,6 +882,16 @@ static int measure_cycles_perf_fn(void *_plr)
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
@@ -898,6 +910,14 @@ static int measure_cycles_perf_fn(void *_plr)
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
@@ -914,9 +934,21 @@ static int measure_cycles_perf_fn(void *_plr)
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
@@ -934,11 +966,35 @@ static int measure_cycles_perf_fn(void *_plr)
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
