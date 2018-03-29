Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeC2Wah (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:30:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:60712 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751341AbeC2W3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:29:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,378,1517904000";
   d="scan'208";a="28690096"
From: Vikas Shivappa <vikas.shivappa@linux.intel.com>
To: vikas.shivappa@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com,
        sai.praneeth.prakhya@intel.com, x86@kernel.org, tglx@linutronix.de,
        hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, ak@linux.intel.com,
        vikas.shivappa@linux.intel.com
Subject: [PATCH 3/6] x86/intel_rdt/mba_sc: Add initialization support
Date: Thu, 29 Mar 2018 15:26:13 -0700
Message-Id: <1522362376-3505-4-git-send-email-vikas.shivappa@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com>
References: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When MBA software controller is enabled, we need a per domain storage
for user specified bandwidth in MB and the raw b/w percentage values
which are programmed into the MSR. Add support for these data structures
and initialization.

Signed-off-by: Vikas Shivappa <vikas.shivappa@linux.intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.c          | 37 +++++++++++++++++++++++---------
 arch/x86/kernel/cpu/intel_rdt.h          |  4 ++++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c |  3 +++
 3 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 2b65601..8a32561 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -35,6 +35,7 @@
 
 #define MAX_MBA_BW	100u
 #define MBA_IS_LINEAR	0x4
+#define MBA_BW_MAX_MB	U32_MAX
 
 /* Mutex to protect rdtgroup access. */
 DEFINE_MUTEX(rdtgroup_mutex);
@@ -431,25 +432,40 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 	return NULL;
 }
 
+void setup_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
+{
+	int i;
+
+	/*
+	 * Initialize the Control MSRs to having no control.
+	 * For Cache Allocation: Set all bits in cbm
+	 * For Memory Allocation: Set b/w requested to 100%
+	 * and the b/w in MB to U32_MAX
+	 */
+	for (i = 0; i < r->num_closid; i++, dc++, dm++) {
+		*dc = r->membw.bw_byte ? MBA_BW_MAX_MB : r->default_ctrl;
+		*dm = r->default_ctrl;
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
+	dm = kmalloc_array(r->num_closid, sizeof(*d->msr_val), GFP_KERNEL);
+	if (!dm) {
+		kfree (dc);
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
+	d->msr_val = dm;
+	setup_ctrlval(r, dc, dm);
 
 	m.low = 0;
 	m.high = r->num_closid;
@@ -588,6 +604,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		}
 
 		kfree(d->ctrl_val);
+		kfree(d->msr_val);
 		kfree(d->rmid_busy_llc);
 		kfree(d->mbm_total);
 		kfree(d->mbm_local);
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 3e9bc3f..68c7da0 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -202,6 +202,8 @@ struct mbm_state {
  * @cqm_work_cpu:
  *		worker cpu for CQM h/w counters
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
+ *		When MBA is expressed in MB, this holds number of MegaBytes
+ * @msr_val:	When MBA is expressed in MB, this holds the control MSR value
  * @new_ctrl:	new ctrl value to be loaded
  * @have_new_ctrl: did user provide new_ctrl for this domain
  */
@@ -217,6 +219,7 @@ struct rdt_domain {
 	int			mbm_work_cpu;
 	int			cqm_work_cpu;
 	u32			*ctrl_val;
+	u32			*msr_val;
 	u32			new_ctrl;
 	bool			have_new_ctrl;
 };
@@ -450,6 +453,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_domain *d,
 void mbm_setup_overflow_handler(struct rdt_domain *dom,
 				unsigned long delay_ms);
 void mbm_handle_overflow(struct work_struct *work);
+void setup_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm);
 void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 0707191..d4e8412 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1044,8 +1044,11 @@ static int set_cache_qos_cfg(int level, bool enable)
 static void __set_mba_byte_ctrl(bool byte_ctrl)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA];
+	struct rdt_domain *d;
 
 	r->membw.bw_byte = byte_ctrl;
+	list_for_each_entry(d, &r->domains, list)
+		setup_ctrlval(r, d->ctrl_val, d->msr_val);
 }
 
 /*
-- 
1.9.1
