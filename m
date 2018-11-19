Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302D5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAE521104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAE521104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbeKTES7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:18:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:31674 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730274AbeKTES6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:18:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 09:54:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,253,1539673200"; 
   d="scan'208";a="107580423"
Received: from unknown (HELO localhost.jf.intel.com) ([10.54.55.47])
  by fmsmga004.fm.intel.com with ESMTP; 19 Nov 2018 09:54:25 -0800
From:   kan.liang@linux.intel.com
To:     tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, yao.jin@linux.intel.com, sashal@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>, stable@kernel.org
Subject: [PATCH V3] perf/x86/intel/uncore: Fix client IMC events return huge result
Date:   Mon, 19 Nov 2018 09:53:48 -0800
Message-Id: <20181119175348.9976-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The client IMC bandwidth events return very huge result.
  perf stat -e uncore_imc/data_reads/ -e uncore_imc/data_writes/ -I
  10000 -a
  10.000117222 34,788.76 MiB uncore_imc/data_reads/
  10.000117222 8.26 MiB uncore_imc/data_writes/
  20.000374584 34,842.89 MiB uncore_imc/data_reads/
  20.000374584 10.45 MiB uncore_imc/data_writes/
  30.000633299 37,965.29 MiB uncore_imc/data_reads/
  30.000633299 323.62 MiB uncore_imc/data_writes/
  40.000891548 41,012.88 MiB uncore_imc/data_reads/
  40.000891548 6.98 MiB uncore_imc/data_writes/
  50.001142480 1,125,899,906,621,494.75 MiB uncore_imc/data_reads/
  50.001142480 6.97 MiB uncore_imc/data_writes/

The client IMC events are freerunning counters. They still use the
old event encoding format (0x1 for data_read and 0x2 for data write).
The counter bit width is calculated by common code, which assume that
the standard encoding format is used for the freerunning counters.
Error bit width information is calculated.

The patch intends to convert the old client IMC event encoding to the
standard encoding format to apply to the common code.

Current common code uses event->attr.config which directly copy from
user space. We should not implicitly modify it for a converted event.
The event->hw.config is used to replace the event->attr.config in
common code.
For client IMC events, the event->attr.config is used to calculate a
converted event with standard encoding format in the custom event_init().
The converted event is stored in event->hw.config.
For other events of freerunning counters, they already use the standard
encoding format. The same value as event->attr.config is assigned to
event->hw.config in common event_init().

Fixes: commit 9aae1780e7e8 ("perf/x86/intel/uncore: Clean up client IMC uncore")
Reported-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@kernel.org
---

Changes since V2:
- Re-structure the change log.

 arch/x86/events/intel/uncore.c     |  1 +
 arch/x86/events/intel/uncore.h     | 12 ++++++------
 arch/x86/events/intel/uncore_snb.c |  4 +++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 27a461414b30..2690135bf83f 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -740,6 +740,7 @@ static int uncore_pmu_event_init(struct perf_event *event)
 		/* fixed counters have event field hardcoded to zero */
 		hwc->config = 0ULL;
 	} else if (is_freerunning_event(event)) {
+		hwc->config = event->attr.config;
 		if (!check_valid_freerunning_event(box, event))
 			return -EINVAL;
 		event->hw.idx = UNCORE_PMC_IDX_FREERUNNING;
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index e17ab885b1e9..cc6dd4f78158 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -285,8 +285,8 @@ static inline
 unsigned int uncore_freerunning_counter(struct intel_uncore_box *box,
 					struct perf_event *event)
 {
-	unsigned int type = uncore_freerunning_type(event->attr.config);
-	unsigned int idx = uncore_freerunning_idx(event->attr.config);
+	unsigned int type = uncore_freerunning_type(event->hw.config);
+	unsigned int idx = uncore_freerunning_idx(event->hw.config);
 	struct intel_uncore_pmu *pmu = box->pmu;
 
 	return pmu->type->freerunning[type].counter_base +
@@ -360,7 +360,7 @@ static inline
 unsigned int uncore_freerunning_bits(struct intel_uncore_box *box,
 				     struct perf_event *event)
 {
-	unsigned int type = uncore_freerunning_type(event->attr.config);
+	unsigned int type = uncore_freerunning_type(event->hw.config);
 
 	return box->pmu->type->freerunning[type].bits;
 }
@@ -368,7 +368,7 @@ unsigned int uncore_freerunning_bits(struct intel_uncore_box *box,
 static inline int uncore_num_freerunning(struct intel_uncore_box *box,
 					 struct perf_event *event)
 {
-	unsigned int type = uncore_freerunning_type(event->attr.config);
+	unsigned int type = uncore_freerunning_type(event->hw.config);
 
 	return box->pmu->type->freerunning[type].num_counters;
 }
@@ -382,8 +382,8 @@ static inline int uncore_num_freerunning_types(struct intel_uncore_box *box,
 static inline bool check_valid_freerunning_event(struct intel_uncore_box *box,
 						 struct perf_event *event)
 {
-	unsigned int type = uncore_freerunning_type(event->attr.config);
-	unsigned int idx = uncore_freerunning_idx(event->attr.config);
+	unsigned int type = uncore_freerunning_type(event->hw.config);
+	unsigned int idx = uncore_freerunning_idx(event->hw.config);
 
 	return (type < uncore_num_freerunning_types(box, event)) &&
 	       (idx < uncore_num_freerunning(box, event));
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 8527c3e1038b..48d7121f71c7 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -425,9 +425,11 @@ static int snb_uncore_imc_event_init(struct perf_event *event)
 
 	/* must be done before validate_group */
 	event->hw.event_base = base;
-	event->hw.config = cfg;
 	event->hw.idx = idx;
 
+	/* Convert to standard encoding format for free running counters */
+	event->hw.config = ((cfg - 1) << 8) | 0x10ff;
+
 	/* no group validation needed, we have free running counters */
 
 	return 0;
-- 
2.14.5

