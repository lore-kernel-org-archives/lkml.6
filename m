Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753099AbeDTWjM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 18:39:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:60382 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752937AbeDTWjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 18:39:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,303,1520924400";
   d="scan'208";a="34982647"
From: Vikas Shivappa <vikas.shivappa@linux.intel.com>
To: vikas.shivappa@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        tglx@linutronix.de, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, ak@linux.intel.com,
        vikas.shivappa@linux.intel.com
Subject: [PATCH 6/6] x86/intel_rdt/mba_sc: Feedback loop to dynamically update mem bandwidth
Date: Fri, 20 Apr 2018 15:36:21 -0700
Message-Id: <1524263781-14267-7-git-send-email-vikas.shivappa@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524263781-14267-1-git-send-email-vikas.shivappa@linux.intel.com>
References: <1524263781-14267-1-git-send-email-vikas.shivappa@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mba_sc is a feedback loop where we periodically read MBM counters and
try to restrict the bandwidth below a max value so the below is always
true:

  "current bandwidth(cur_bw) < user specified bandwidth(user_bw)"

The frequency of these checks is currently 1s and we just tag along the
MBM overflow timer to do the updates. Doing it once in a second also
makes the calculation of bandwidth easy. The steps of increase or
decrease of bandwidth is the minimum granularity specified by the
hardware.

Although the MBA's goal is to restrict the bandwidth below a maximum,
there may be a need to even increase the bandwidth. Since MBA controls
the L2 external bandwidth where as MBM measures the L3 external
bandwidth, we may end up restricting some rdtgroups unnecessarily. This
may happen in the sequence where rdtgroup (set of jobs) had high
"L3 <-> memory traffic" in initial phases -> mba_sc kicks in and reduced
bandwidth percentage values -> but after some it has mostly "L2 <-> L3"
traffic. In this scenario mba_sc increases the bandwidth percentage when
there is lesser memory traffic.

Signed-off-by: Vikas Shivappa <vikas.shivappa@linux.intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.c         |   3 +-
 arch/x86/kernel/cpu/intel_rdt.h         |   2 +
 arch/x86/kernel/cpu/intel_rdt_monitor.c | 121 +++++++++++++++++++++++++++++++-
 3 files changed, 123 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 85805d7..6dcd93b 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -33,7 +33,6 @@
 #include <asm/intel_rdt_sched.h>
 #include "intel_rdt.h"
 
-#define MAX_MBA_BW	100u
 #define MBA_IS_LINEAR	0x4
 #define MBA_MAX_MBPS	U32_MAX
 
@@ -350,7 +349,7 @@ static int get_cache_id(int cpu, int level)
  * that can be written to QOS_MSRs.
  * There are currently no SKUs which support non linear delay values.
  */
-static u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
+u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
 {
 	if (r->membw.delay_linear)
 		return MAX_MBA_BW - bw;
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 66a0ba3..3975282 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -28,6 +28,7 @@
 
 #define MBM_CNTR_WIDTH			24
 #define MBM_OVERFLOW_INTERVAL		1000
+#define MAX_MBA_BW			100u
 
 #define RMID_VAL_ERROR			BIT_ULL(63)
 #define RMID_VAL_UNAVAIL		BIT_ULL(62)
@@ -461,6 +462,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom,
 void mbm_handle_overflow(struct work_struct *work);
 bool is_mba_sc(struct rdt_resource *r);
 void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm);
+u32 delay_bw_map(unsigned long bw, struct rdt_resource *r);
 void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
diff --git a/arch/x86/kernel/cpu/intel_rdt_monitor.c b/arch/x86/kernel/cpu/intel_rdt_monitor.c
index 32c9e55..5a26c1c 100644
--- a/arch/x86/kernel/cpu/intel_rdt_monitor.c
+++ b/arch/x86/kernel/cpu/intel_rdt_monitor.c
@@ -330,6 +330,113 @@ void mon_event_count(void *info)
 	}
 }
 
+/*
+ * This implements feedback loop for MBA software controller(mba_sc)
+ *
+ * mba_sc is a feedback loop where we periodically read MBM counters
+ * and adjust the bandwidth percentage values via the IA32_MBA_THRTL_MSRs
+ * so that:
+ * "current bandwdith(cur_bw) < user specified bandwidth(user_bw)".
+ * We can simply use the MBM counters to measure the bandwidth and
+ * use MBA throttle MSRs to control the bandwidth for a particular
+ * rdtgrp because we use the same resctrl rdtgroup for both monitoring
+ * and control now as suggested by Thomas Gleixner.
+ *
+ * The frequency of the checks is 1s and we just tag along the
+ * MBM overflow timer. Having 1s interval makes the calculation of
+ * bandwidth simpler.
+ *
+ * Although MBA's goal is to restrict the bandwidth to a maximum,
+ * there may be a need to increase the bandwidth to avoid
+ * uncecessarily restricting the L2 <-> L3 traffic.
+ * Since MBA controls the L2 external bandwidth where as
+ * MBM measures the L3 external bandwidth the following sequence
+ * could lead to such a situation.
+ * Consider an rdtgroup which had high L3 <-> memory traffic
+ * in initial phases -> mba_sc kicks in and reduced bandwidth
+ * percentage values -> but after some time rdtgroup has mostly
+ * L2 <-> L3 traffic.
+ * In this case we may restrict the rdtgroup's L2 <-> L3 traffic
+ * as its throttle MSRs already have low percentage values.
+ * To avoid unnecessarily restricting such rdtgroups,we also
+ * increase the bandwidth.
+ */
+static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
+{
+	u32 closid, rmid, cur_msr, cur_msr_val, new_msr_val;
+	struct mbm_state *pmbm_data, *cmbm_data;
+	u32 cur_bw, delta_bw, user_bw;
+	struct rdt_resource *r_mba;
+	struct rdt_domain *dom_mba;
+	struct list_head *head;
+	struct rdtgroup *entry;
+
+	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA];
+	closid = rgrp->closid;
+	rmid = rgrp->mon.rmid;
+	pmbm_data = &dom_mbm->mbm_local[rmid];
+
+	dom_mba = get_domain_from_cpu(smp_processor_id(), r_mba);
+	if (!dom_mba) {
+		pr_warn_once("Failure to get domain for MBA update\n");
+		return;
+	}
+
+	cur_bw = pmbm_data->prev_bw;
+	user_bw = dom_mba->mbps_val[closid];
+	delta_bw = pmbm_data->delta_bw;
+	cur_msr_val = dom_mba->ctrl_val[closid];
+
+	/*
+	 * For Ctrl groups read data from child monitor groups.
+	 */
+	head = &rgrp->mon.crdtgrp_list;
+	list_for_each_entry(entry, head, mon.crdtgrp_list) {
+		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
+		cur_bw += cmbm_data->prev_bw;
+		delta_bw += cmbm_data->delta_bw;
+	}
+
+	/*
+	 * Scale up/down the bandwidth linearly for the ctrl group.
+	 * The bandwidth step is the bandwidth granularity specified
+	 * by the hardware.
+	 *
+	 * The delta_bw is used when increasing the bandwidth
+	 * so that we dont alternately increase and decrease the control values
+	 * continuously.
+	 * For ex: consider cur_bw = 90MBps, user_bw = 100MBps and if
+	 * bandwidth step is 20MBps(> user_bw - cur_bw), we would keep switching
+	 * between 90 and 110 continuously if we only check cur_bw < user_bw.
+	 */
+	if (cur_msr_val > r_mba->membw.min_bw && user_bw < cur_bw) {
+		new_msr_val = cur_msr_val - r_mba->membw.bw_gran;
+	} else if (cur_msr_val < MAX_MBA_BW &&
+		   (user_bw > (cur_bw + delta_bw))) {
+		new_msr_val = cur_msr_val + r_mba->membw.bw_gran;
+	} else {
+		return;
+	}
+
+	cur_msr = r_mba->msr_base + closid;
+	wrmsrl(cur_msr, delay_bw_map(new_msr_val, r_mba));
+	dom_mba->ctrl_val[closid] = new_msr_val;
+
+	/*
+	 * Delta values are updated dynamically package wise for each rdtgrp
+	 * everytime the throttle MSR changes value.
+	 * This is because (1)the increase in bandwidth is not perfectly
+	 * linear and only "approximately" linear even when the hardware says
+	 * it is linear.(2)Also since MBA is a core specific mechanism, the
+	 * delta values vary based on number of cores used by the rdtgrp.
+	 */
+	pmbm_data->delta_comp = true;
+	list_for_each_entry(entry, head, mon.crdtgrp_list) {
+		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
+		cmbm_data->delta_comp = true;
+	}
+}
+
 static void mbm_update(struct rdt_domain *d, int rmid)
 {
 	struct rmid_read rr;
@@ -347,7 +454,16 @@ static void mbm_update(struct rdt_domain *d, int rmid)
 	}
 	if (is_mbm_local_enabled()) {
 		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
-		__mon_event_count(rmid, &rr);
+
+		/*
+		 * Call the MBA software controller only for the
+		 * control groups and when user has enabled
+		 * the software controller explicitly.
+		 */
+		if (!is_mba_sc(NULL))
+			__mon_event_count(rmid, &rr);
+		else
+			mbm_bw_count(rmid, &rr);
 	}
 }
 
@@ -418,6 +534,9 @@ void mbm_handle_overflow(struct work_struct *work)
 		head = &prgrp->mon.crdtgrp_list;
 		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
 			mbm_update(d, crgrp->mon.rmid);
+
+		if (is_mba_sc(NULL))
+			update_mba_bw(prgrp, d);
 	}
 
 	schedule_delayed_work_on(cpu, &d->mbm_over, delay);
-- 
1.9.1
