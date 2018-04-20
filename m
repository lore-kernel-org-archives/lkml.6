Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeDTWjk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 18:39:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:60384 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752924AbeDTWjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 18:39:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,303,1520924400";
   d="scan'208";a="34982644"
From: Vikas Shivappa <vikas.shivappa@linux.intel.com>
To: vikas.shivappa@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        tglx@linutronix.de, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, ak@linux.intel.com,
        vikas.shivappa@linux.intel.com
Subject: [PATCH 5/6] x86/intel_rdt/mba_sc: Prepare for feedback loop
Date: Fri, 20 Apr 2018 15:36:20 -0700
Message-Id: <1524263781-14267-6-git-send-email-vikas.shivappa@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524263781-14267-1-git-send-email-vikas.shivappa@linux.intel.com>
References: <1524263781-14267-1-git-send-email-vikas.shivappa@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory patch for the mba feedback loop. We add support to
measure the "bandwidth in MBps" and the "delta bandwidth". We measure it
reading the MBM IA32_QM_CTR MSRs and calculating the amount of "bytes"
moved. There is no user interface for this and will only be used by the
feedback loop patch.

Signed-off-by: Vikas Shivappa <vikas.shivappa@linux.intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h         | 10 ++++++++
 arch/x86/kernel/cpu/intel_rdt_monitor.c | 45 ++++++++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 91cc310..66a0ba3 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -180,10 +180,20 @@ struct rftype {
  * struct mbm_state - status for each MBM counter in each domain
  * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
  * @prev_msr	Value of IA32_QM_CTR for this RMID last time we read it
+ * @chunks_bw	Total local data moved. Used for bandwidth calculation
+ * @prev_bw_msr:Value of previous IA32_QM_CTR for bandwidth counting
+ * @prev_bw	The most recent bandwidth in MBps
+ * @delta_bw	Difference between the current and previous bandwidth
+ * @delta_comp	Indicates whether to compute the delta_bw
  */
 struct mbm_state {
 	u64	chunks;
 	u64	prev_msr;
+	u64	chunks_bw;
+	u64	prev_bw_msr;
+	u32	prev_bw;
+	u32	delta_bw;
+	bool	delta_comp;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/intel_rdt_monitor.c b/arch/x86/kernel/cpu/intel_rdt_monitor.c
index 681450e..32c9e55 100644
--- a/arch/x86/kernel/cpu/intel_rdt_monitor.c
+++ b/arch/x86/kernel/cpu/intel_rdt_monitor.c
@@ -225,10 +225,18 @@ void free_rmid(u32 rmid)
 		list_add_tail(&entry->list, &rmid_free_lru);
 }
 
+static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr)
+{
+	u64 shift = 64 - MBM_CNTR_WIDTH, chunks;
+
+	chunks = (cur_msr << shift) - (prev_msr << shift);
+	return chunks >>= shift;
+}
+
 static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 {
-	u64 chunks, shift, tval;
 	struct mbm_state *m;
+	u64 chunks, tval;
 
 	tval = __rmid_read(rmid, rr->evtid);
 	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL)) {
@@ -254,14 +262,12 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 	}
 
 	if (rr->first) {
-		m->prev_msr = tval;
-		m->chunks = 0;
+		memset(m, 0, sizeof(struct mbm_state));
+		m->prev_bw_msr = m->prev_msr = tval;
 		return 0;
 	}
 
-	shift = 64 - MBM_CNTR_WIDTH;
-	chunks = (tval << shift) - (m->prev_msr << shift);
-	chunks >>= shift;
+	chunks = mbm_overflow_count(m->prev_msr, tval);
 	m->chunks += chunks;
 	m->prev_msr = tval;
 
@@ -270,6 +276,33 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 }
 
 /*
+ * Supporting function to calculate the memory bandwidth
+ * and delta bandwidth in MBps.
+ */
+static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3];
+	struct mbm_state *m = &rr->d->mbm_local[rmid];
+	u64 tval, cur_bw, chunks;
+
+	tval = __rmid_read(rmid, rr->evtid);
+	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL)) {
+		return;
+	}
+
+	chunks = mbm_overflow_count(m->prev_bw_msr, tval);
+	m->chunks_bw += chunks;
+	m->chunks = m->chunks_bw;
+	cur_bw = (chunks * r->mon_scale) >> 20;
+
+	if (m->delta_comp)
+		m->delta_bw = abs(cur_bw - m->prev_bw);
+	m->delta_comp = false;
+	m->prev_bw = cur_bw;
+	m->prev_bw_msr = tval;
+}
+
+/*
  * This is called via IPI to read the CQM/MBM counters
  * on a domain.
  */
-- 
1.9.1
