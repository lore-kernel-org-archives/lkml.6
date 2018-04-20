Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeDTWkP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 18:40:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:60384 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752890AbeDTWjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 18:39:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,303,1520924400";
   d="scan'208";a="34982637"
From: Vikas Shivappa <vikas.shivappa@linux.intel.com>
To: vikas.shivappa@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        tglx@linutronix.de, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, ak@linux.intel.com,
        vikas.shivappa@linux.intel.com
Subject: [PATCH 3/6] x86/intel_rdt/mba_sc: Add initialization support
Date: Fri, 20 Apr 2018 15:36:18 -0700
Message-Id: <1524263781-14267-4-git-send-email-vikas.shivappa@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524263781-14267-1-git-send-email-vikas.shivappa@linux.intel.com>
References: <1524263781-14267-1-git-send-email-vikas.shivappa@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When MBA software controller is enabled, we need a per domain storage
for user specified bandwidth in "MBps" and the "percentage" values which
are programmed into the IA32_MBA_THRTL_MSR. Add support for these data
structures and initialization.

The MBA percentage values have a default max value of 100 but however
the max value in MBps is not available from the hardware and we keep it
just at U32_MAX. This simply says that user can use all bandwidth by
default but does not say what is the actual max bandwidth available. The
actual bandwidth that is available may depend on lot of factors like QPI
link, number of memory channels, memory channel frequency, its width and
memory speed, how many channels are configured and also if memory
interleaving is enabled.

Signed-off-by: Vikas Shivappa <vikas.shivappa@linux.intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.c          | 37 +++++++++++++++++++++++---------
 arch/x86/kernel/cpu/intel_rdt.h          |  3 +++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c |  3 +++
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 2a0931f..07f6b3b 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -35,6 +35,7 @@
 
 #define MAX_MBA_BW	100u
 #define MBA_IS_LINEAR	0x4
+#define MBA_MAX_MBPS	U32_MAX
 
 /* Mutex to protect rdtgroup access. */
 DEFINE_MUTEX(rdtgroup_mutex);
@@ -439,25 +440,40 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 	return NULL;
 }
 
+void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
+{
+	int i;
+
+	/*
+	 * Initialize the Control MSRs to having no control.
+	 * For Cache Allocation: Set all bits in cbm
+	 * For Memory Allocation: Set b/w requested to 100%
+	 * and the bandwidth in MBps to U32_MAX
+	 */
+	for (i = 0; i < r->num_closid; i++, dc++, dm++) {
+		*dc = r->default_ctrl;
+		*dm = MBA_MAX_MBPS;
+	}
+}
+
 static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 {
 	struct msr_param m;
-	u32 *dc;
-	int i;
+	u32 *dc, *dm;
 
 	dc = kmalloc_array(r->num_closid, sizeof(*d->ctrl_val), GFP_KERNEL);
 	if (!dc)
 		return -ENOMEM;
 
-	d->ctrl_val = dc;
+	dm = kmalloc_array(r->num_closid, sizeof(*d->mbps_val), GFP_KERNEL);
+	if (!dm) {
+		kfree(dc);
+		return -ENOMEM;
+	}
 
-	/*
-	 * Initialize the Control MSRs to having no control.
-	 * For Cache Allocation: Set all bits in cbm
-	 * For Memory Allocation: Set b/w requested to 100
-	 */
-	for (i = 0; i < r->num_closid; i++, dc++)
-		*dc = r->default_ctrl;
+	d->ctrl_val = dc;
+	d->mbps_val = dm;
+	setup_default_ctrlval(r, dc, dm);
 
 	m.low = 0;
 	m.high = r->num_closid;
@@ -596,6 +612,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		}
 
 		kfree(d->ctrl_val);
+		kfree(d->mbps_val);
 		kfree(d->rmid_busy_llc);
 		kfree(d->mbm_total);
 		kfree(d->mbm_local);
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 74aee0f..91cc310 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -202,6 +202,7 @@ struct mbm_state {
  * @cqm_work_cpu:
  *		worker cpu for CQM h/w counters
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
+ * @mbps_val:	When mba_sc is enabled, this holds the bandwidth in MBps
  * @new_ctrl:	new ctrl value to be loaded
  * @have_new_ctrl: did user provide new_ctrl for this domain
  */
@@ -217,6 +218,7 @@ struct rdt_domain {
 	int			mbm_work_cpu;
 	int			cqm_work_cpu;
 	u32			*ctrl_val;
+	u32			*mbps_val;
 	u32			new_ctrl;
 	bool			have_new_ctrl;
 };
@@ -448,6 +450,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom,
 				unsigned long delay_ms);
 void mbm_handle_overflow(struct work_struct *work);
 bool is_mba_sc(struct rdt_resource *r);
+void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm);
 void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index b9ceb13..bfd707d 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1055,12 +1055,15 @@ static int set_cache_qos_cfg(int level, bool enable)
 static int set_mba_sc(bool mba_sc)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA];
+	struct rdt_domain *d;
 
 	if (!is_mbm_enabled() || !is_mba_linear() ||
 	    mba_sc == is_mba_sc(r))
 		return -1;
 
 	r->membw.mba_sc = mba_sc;
+	list_for_each_entry(d, &r->domains, list)
+		setup_default_ctrlval(r, d->ctrl_val, d->mbps_val);
 
 	return 0;
 }
-- 
1.9.1
