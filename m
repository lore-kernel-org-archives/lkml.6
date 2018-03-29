Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752540AbeC2WaI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:30:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:60712 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751893AbeC2W3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:29:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,378,1517904000";
   d="scan'208";a="28690102"
From: Vikas Shivappa <vikas.shivappa@linux.intel.com>
To: vikas.shivappa@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com,
        sai.praneeth.prakhya@intel.com, x86@kernel.org, tglx@linutronix.de,
        hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, ak@linux.intel.com,
        vikas.shivappa@linux.intel.com
Subject: [PATCH 5/6] x86/intel_rdt/mba_sc: Add counting for MBA software controller
Date: Thu, 29 Mar 2018 15:26:15 -0700
Message-Id: <1522362376-3505-6-git-send-email-vikas.shivappa@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com>
References: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we store the per package "total bytes" for each rdtgroup for
Memory bandwidth management which exposed via
"/sys/fs/resctrl/<rdtgrpx>/mon_data/mon_L3_00/mbm_local_bytes".

The above user interface remains while we also add support to measure
the per package b/w in Megabytes and the delta b/w when the b/w MSR
values change. We do this by taking the time stamp every time a the
counter is read and then keeping a history of b/w. This will be used to
support internal queries for the bandwidth in Megabytes.

Signed-off-by: Vikas Shivappa <vikas.shivappa@linux.intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.c         |  1 -
 arch/x86/kernel/cpu/intel_rdt.h         | 24 ++++++++++++++++++++--
 arch/x86/kernel/cpu/intel_rdt_monitor.c | 36 +++++++++++++++++++++++++++------
 3 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 8a12d26..78beb64 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -33,7 +33,6 @@
 #include <asm/intel_rdt_sched.h>
 #include "intel_rdt.h"
 
-#define MAX_MBA_BW	100u
 #define MBA_IS_LINEAR	0x4
 #define MBA_BW_MAX_MB	U32_MAX
 
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 68c7da0..b74619d 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -28,6 +28,18 @@
 
 #define MBM_CNTR_WIDTH			24
 #define MBM_OVERFLOW_INTERVAL		1000
+#define MAX_MBA_BW			100u
+
+/*
+ * This measures a tolerable delta value in MegaBytes between
+ * the expected bandwidth and the actual bandwidth.
+ * This is done so that we dont keep flipping the control
+ * bandwidth to more than and less than the expected bandwidth.
+ *
+ * However note that this is only initial threshold value and
+ * it is adjusted dynamically package wise for each rdtgrp
+ */
+#define MBA_BW_MB_THRSHL		1024
 
 #define RMID_VAL_ERROR			BIT_ULL(63)
 #define RMID_VAL_UNAVAIL		BIT_ULL(62)
@@ -180,10 +192,18 @@ struct rftype {
  * struct mbm_state - status for each MBM counter in each domain
  * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
  * @prev_msr	Value of IA32_QM_CTR for this RMID last time we read it
+ * @prev_read_time:The last time counter was read
+ * @prev_bw:	The most recent bandwidth in Megabytes
+ * @delta_bw:	Difference between the current b/w and previous b/w
+ * @threshl_calib:	Indicates when to calculate the delta_bw
  */
 struct mbm_state {
-	u64	chunks;
-	u64	prev_msr;
+	u64			chunks;
+	u64			prev_msr;
+	unsigned long		prev_read_time;
+	u64			prev_bw;
+	u64			delta_bw;
+	bool			thrshl_calib;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/intel_rdt_monitor.c b/arch/x86/kernel/cpu/intel_rdt_monitor.c
index 681450e..509f338 100644
--- a/arch/x86/kernel/cpu/intel_rdt_monitor.c
+++ b/arch/x86/kernel/cpu/intel_rdt_monitor.c
@@ -225,9 +225,11 @@ void free_rmid(u32 rmid)
 		list_add_tail(&entry->list, &rmid_free_lru);
 }
 
-static int __mon_event_count(u32 rmid, struct rmid_read *rr)
+static int __mon_event_count(u32 rmid, struct rmid_read *rr, struct mbm_state **md)
 {
-	u64 chunks, shift, tval;
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3];
+	u64 chunks, shift, tval, cur_bw = 0;
+	unsigned long delta_time, now;
 	struct mbm_state *m;
 
 	tval = __rmid_read(rmid, rr->evtid);
@@ -256,6 +258,9 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 	if (rr->first) {
 		m->prev_msr = tval;
 		m->chunks = 0;
+		m->prev_read_time = jiffies;
+		m->prev_bw = 0;
+		m->delta_bw = MBA_BW_MB_THRSHL;
 		return 0;
 	}
 
@@ -266,6 +271,24 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 	m->prev_msr = tval;
 
 	rr->val += m->chunks;
+
+	if(!md)
+		goto out;
+
+	now = jiffies;
+	delta_time = jiffies_to_usecs(now - m->prev_read_time);
+	if (delta_time)
+		cur_bw = (chunks * r->mon_scale) / delta_time;
+
+	if (m->thrshl_calib)
+		m->delta_bw = abs(cur_bw - m->prev_bw);
+	m->thrshl_calib = false;
+	m->prev_bw = cur_bw;
+	m->prev_read_time = now;
+
+	*md = m;
+out:
+
 	return 0;
 }
 
@@ -281,7 +304,7 @@ void mon_event_count(void *info)
 
 	rdtgrp = rr->rgrp;
 
-	if (__mon_event_count(rdtgrp->mon.rmid, rr))
+	if (__mon_event_count(rdtgrp->mon.rmid, rr, NULL))
 		return;
 
 	/*
@@ -291,7 +314,7 @@ void mon_event_count(void *info)
 
 	if (rdtgrp->type == RDTCTRL_GROUP) {
 		list_for_each_entry(entry, head, mon.crdtgrp_list) {
-			if (__mon_event_count(entry->mon.rmid, rr))
+			if (__mon_event_count(entry->mon.rmid, rr, NULL))
 				return;
 		}
 	}
@@ -299,6 +322,7 @@ void mon_event_count(void *info)
 
 static void mbm_update(struct rdt_domain *d, int rmid)
 {
+
 	struct rmid_read rr;
 
 	rr.first = false;
@@ -310,11 +334,11 @@ static void mbm_update(struct rdt_domain *d, int rmid)
 	 */
 	if (is_mbm_total_enabled()) {
 		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
-		__mon_event_count(rmid, &rr);
+		__mon_event_count(rmid, &rr, NULL);
 	}
 	if (is_mbm_local_enabled()) {
 		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
-		__mon_event_count(rmid, &rr);
+		__mon_event_count(rmid, &rr, NULL);
 	}
 }
 
-- 
1.9.1
