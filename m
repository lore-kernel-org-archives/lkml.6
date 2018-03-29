Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeC2W3w (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:29:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:60715 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751935AbeC2W3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:29:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,378,1517904000";
   d="scan'208";a="28690106"
From: Vikas Shivappa <vikas.shivappa@linux.intel.com>
To: vikas.shivappa@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com,
        sai.praneeth.prakhya@intel.com, x86@kernel.org, tglx@linutronix.de,
        hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, ak@linux.intel.com,
        vikas.shivappa@linux.intel.com
Subject: [PATCH 6/6] x86/intel_rdt/mba_sc: Add support to dynamically update the memory b/w
Date: Thu, 29 Mar 2018 15:26:16 -0700
Message-Id: <1522362376-3505-7-git-send-email-vikas.shivappa@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com>
References: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The software controller uses the existing MBM overflow timer calls (once
per second currently) to read the bandwidth to ensure that always

	"current b/w < user specified max b/w"

Similarly when we see that the current b/w is too low, we also try to
increase the b/w. We use a threshold b/w or a delta b/w which is
calculated dynamically to determine what is too low. OS then uses the
"IA32_MBA_THRTL_MSR" to change the b/w. The change itself is currently
linear and is in the increment of decrement of the "b/w granularity"
specified by the SKU. The values written to the MSR are also cached so
that we donot do a rdmsr for every 1s.

Signed-off-by: Vikas Shivappa <vikas.shivappa@linux.intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.c         |  2 +-
 arch/x86/kernel/cpu/intel_rdt.h         |  1 +
 arch/x86/kernel/cpu/intel_rdt_monitor.c | 71 +++++++++++++++++++++++++++++++--
 3 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 78beb64..700e957 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -341,7 +341,7 @@ static int get_cache_id(int cpu, int level)
  * that can be written to QOS_MSRs.
  * There are currently no SKUs which support non linear delay values.
  */
-static u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
+u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
 {
 	if (r->membw.delay_linear)
 		return MAX_MBA_BW - bw;
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index b74619d..aafbc4b 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -474,6 +474,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom,
 				unsigned long delay_ms);
 void mbm_handle_overflow(struct work_struct *work);
 void setup_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm);
+u32 delay_bw_map(unsigned long bw, struct rdt_resource *r);
 void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
diff --git a/arch/x86/kernel/cpu/intel_rdt_monitor.c b/arch/x86/kernel/cpu/intel_rdt_monitor.c
index 509f338..13b6eff 100644
--- a/arch/x86/kernel/cpu/intel_rdt_monitor.c
+++ b/arch/x86/kernel/cpu/intel_rdt_monitor.c
@@ -272,6 +272,10 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr, struct mbm_state **
 
 	rr->val += m->chunks;
 
+	/*
+	 * We only do the bw calculations for the mbm overflow
+	 * periodic timer calls and for local events only.
+	 */
 	if(!md)
 		goto out;
 
@@ -320,10 +324,61 @@ void mon_event_count(void *info)
 	}
 }
 
-static void mbm_update(struct rdt_domain *d, int rmid)
+/*
+ * Check the current b/w using the MBM counters to always ensure that
+ * current b/w < user specified b/w. If the current b/w is way less than
+ * the user defined b/w (determined by the delta b/w)
+ * then try to increase the b/w
+ */
+static void update_mba_bw(struct rdtgroup *rgrp, struct mbm_state *m)
 {
+	u32 closid, rmid, cur_msr, cur_msr_val, new_msr_val;
+	struct rdt_resource *r_mba;
+	u64 cur_bw, user_bw, thrshl_bw;
+	struct rdt_domain *dom_mba;
+
+	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA];
+	closid = rgrp->closid;
+	rmid = rgrp->mon.rmid;
+
+	dom_mba = get_domain_from_cpu(smp_processor_id(), r_mba);
+	if (!dom_mba) {
+		pr_warn_once("Failure to get domain for MBA update\n");
+		return;
+	}
+
+	cur_bw = m->prev_bw;
+	user_bw = dom_mba->ctrl_val[closid];
+	thrshl_bw = m->delta_bw;
+	cur_msr_val = dom_mba->msr_val[closid];
+	/*
+	 * Scale up/down the b/w linearly.
+	 */
+	if (user_bw < cur_bw && cur_msr_val > r_mba->membw.min_bw) {
+		new_msr_val = cur_msr_val - r_mba->membw.bw_gran;
+	} else if ((cur_bw && user_bw > (cur_bw + thrshl_bw)) &&
+		   cur_msr_val < MAX_MBA_BW) {
+		new_msr_val = cur_msr_val + r_mba->membw.bw_gran;
+	} else {
+		return;
+	}
 
+	cur_msr = r_mba->msr_base + closid;
+	wrmsrl(cur_msr, delay_bw_map(new_msr_val, r_mba));
+	dom_mba->msr_val[closid] = new_msr_val;
+
+	/*
+	 * When the counter is read next time, recaliberate the
+	 * threshold since we changed the MSR value.
+	 */
+	m->thrshl_calib = true;
+}
+
+static void mbm_update(struct rdt_domain *d, struct rdtgroup *rgrp, bool prgrp)
+{
+	int rmid = rgrp->mon.rmid;
 	struct rmid_read rr;
+	struct mbm_state *m;
 
 	rr.first = false;
 	rr.d = d;
@@ -338,7 +393,15 @@ static void mbm_update(struct rdt_domain *d, int rmid)
 	}
 	if (is_mbm_local_enabled()) {
 		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
-		__mon_event_count(rmid, &rr, NULL);
+		__mon_event_count(rmid, &rr, &m);
+
+		/*
+		 * Call the MBA software controller core function
+		 * only for the control groups and when user has enabled
+		 * the software controller explicitly.
+		 */
+		if (prgrp && is_mba_MBctrl())
+			update_mba_bw(rgrp, m);
 	}
 }
 
@@ -404,11 +467,11 @@ void mbm_handle_overflow(struct work_struct *work)
 		goto out_unlock;
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-		mbm_update(d, prgrp->mon.rmid);
+		mbm_update(d, prgrp, true);
 
 		head = &prgrp->mon.crdtgrp_list;
 		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
-			mbm_update(d, crgrp->mon.rmid);
+			mbm_update(d, crgrp, false);
 	}
 
 	schedule_delayed_work_on(cpu, &d->mbm_over, delay);
-- 
1.9.1
