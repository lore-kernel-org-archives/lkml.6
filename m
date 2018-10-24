Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFB7C7112C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC20207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC20207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeJXXlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:41:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:38292 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeJXXlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:41:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 08:12:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,420,1534834800"; 
   d="scan'208";a="80581153"
Received: from otc-cfl-s-03.jf.intel.com ([10.54.55.152])
  by fmsmga007.fm.intel.com with ESMTP; 24 Oct 2018 08:12:38 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/2] perf/x86/intel: Fix missing physical address in large PEBS
Date:   Wed, 24 Oct 2018 08:11:16 -0700
Message-Id: <20181024151116.30935-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181024151116.30935-1-kan.liang@linux.intel.com>
References: <20181024151116.30935-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The physical addresses for the last several samples are always lost in
large PEBS. For example,
 #perf record -e mem-loads:uP --phys-data -c10000 -- ./dtlb
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.103 MB perf.data (2661 samples) ]
 #perf script -Ftime,event,sym,phys_addr  | tail
  1595.162483: mem-loads:uP: DoDependentLoads 0
  1595.162484: mem-loads:uP: DoDependentLoads 0
  1595.162484: mem-loads:uP: DoDependentLoads 0
  1595.162485: mem-loads:uP: DoDependentLoads 0

The problem happens because the mapping has been removed before walking
through the pages table.
To avoid this, drain the PEBS buffer on munmap.

With the patch,
 #perf script -Ftime,event,sym,phys_addr  | tail
  190.425922: mem-loads:uP: DoDependentLoads 3ce180a80
  190.425922: mem-loads:uP: DoDependentLoads 3c59ef540
  190.425922: mem-loads:uP: DoDependentLoads 3e3c73dc0
  190.425923: mem-loads:uP: DoDependentLoads 3d6c0d440

Fixes: fc7ce9c74c3a ("perf/core, x86: Add PERF_SAMPLE_PHYS_ADDR")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 7 +++++++
 arch/x86/events/intel/core.c | 6 ++++++
 arch/x86/events/intel/ds.c   | 8 ++++++++
 arch/x86/events/perf_event.h | 4 +++-
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index de32741d041a..9b23b49a0778 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2288,6 +2288,12 @@ static void x86_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
 		x86_pmu.sched_task(ctx, sched_in);
 }
 
+static void x86_pmu_munmap(void)
+{
+	if (x86_pmu.munmap)
+		x86_pmu.munmap();
+}
+
 void perf_check_microcode(void)
 {
 	if (x86_pmu.check_microcode)
@@ -2317,6 +2323,7 @@ static struct pmu pmu = {
 
 	.event_idx		= x86_pmu_event_idx,
 	.sched_task		= x86_pmu_sched_task,
+	.munmap			= x86_pmu_munmap,
 	.task_ctx_size          = sizeof(struct x86_perf_task_context),
 };
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0fb8659b20d8..db393f6b3f53 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3548,6 +3548,11 @@ static void intel_pmu_sched_task(struct perf_event_context *ctx,
 	intel_pmu_lbr_sched_task(ctx, sched_in);
 }
 
+static void intel_pmu_munmap(void)
+{
+	intel_pmu_pebs_munmap();
+}
+
 PMU_FORMAT_ATTR(offcore_rsp, "config1:0-63");
 
 PMU_FORMAT_ATTR(ldlat, "config1:0-15");
@@ -3669,6 +3674,7 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.cpu_dying		= intel_pmu_cpu_dying,
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
+	.munmap			= intel_pmu_munmap,
 };
 
 static __init void intel_clovertown_quirk(void)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index b7b01d762d32..a0ca0e7c005c 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -893,6 +893,14 @@ void intel_pmu_pebs_sched_task(struct perf_event_context *ctx, bool sched_in)
 		intel_pmu_drain_pebs_buffer();
 }
 
+void intel_pmu_pebs_munmap(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	if (pebs_needs_sched_cb(cpuc))
+		intel_pmu_drain_pebs_buffer();
+}
+
 static inline void pebs_update_threshold(struct cpu_hw_events *cpuc)
 {
 	struct debug_store *ds = cpuc->ds;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index adae087cecdd..e1a8b8b928e8 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -591,7 +591,7 @@ struct x86_pmu {
 	void		(*check_microcode)(void);
 	void		(*sched_task)(struct perf_event_context *ctx,
 				      bool sched_in);
-
+	void		(*munmap)(void);
 	/*
 	 * Intel Arch Perfmon v2+
 	 */
@@ -932,6 +932,8 @@ void intel_pmu_pebs_disable_all(void);
 
 void intel_pmu_pebs_sched_task(struct perf_event_context *ctx, bool sched_in);
 
+void intel_pmu_pebs_munmap(void);
+
 void intel_pmu_auto_reload_read(struct perf_event *event);
 
 void intel_ds_init(void);
-- 
2.17.1

