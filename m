Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752321AbeESLWz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:22:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36999 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeESLWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:22:53 -0400
Date: Sat, 19 May 2018 04:22:47 -0700
From: tip-bot for Vikas Shivappa <tipbot@zytor.com>
Message-ID: <tip-1bd2a63b4f0deefe745aa0fd969c07b2eb9ee99e@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        vikas.shivappa@linux.intel.com, hpa@zytor.com, mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, vikas.shivappa@linux.intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <1524263781-14267-4-git-send-email-vikas.shivappa@linux.intel.com>
References: <1524263781-14267-4-git-send-email-vikas.shivappa@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt/mba_sc: Add initialization support
Git-Commit-ID: 1bd2a63b4f0deefe745aa0fd969c07b2eb9ee99e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1bd2a63b4f0deefe745aa0fd969c07b2eb9ee99e
Gitweb:     https://git.kernel.org/tip/1bd2a63b4f0deefe745aa0fd969c07b2eb9ee99e
Author:     Vikas Shivappa <vikas.shivappa@linux.intel.com>
AuthorDate: Fri, 20 Apr 2018 15:36:18 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 19 May 2018 13:16:43 +0200

x86/intel_rdt/mba_sc: Add initialization support

When MBA software controller is enabled, a per domain storage is required
for user specified bandwidth in "MBps" and the "percentage" values which
are programmed into the IA32_MBA_THRTL_MSR. Add support for these data
structures and initialization.

The MBA percentage values have a default max value of 100 but however the
max value in MBps is not available from the hardware so it's set to
U32_MAX.

This simply says that the control group can use all bandwidth by default
but does not say what is the actual max bandwidth available. The actual
bandwidth that is available may depend on lot of factors like QPI link,
number of memory channels, memory channel frequency, its width and memory
speed, how many channels are configured and also if memory interleaving is
enabled. So there is no way to determine the maximum at runtime reliably.

Signed-off-by: Vikas Shivappa <vikas.shivappa@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: ravi.v.shankar@intel.com
Cc: tony.luck@intel.com
Cc: fenghua.yu@intel.com
Cc: vikas.shivappa@intel.com
Cc: ak@linux.intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/1524263781-14267-4-git-send-email-vikas.shivappa@linux.intel.com

---
 arch/x86/kernel/cpu/intel_rdt.c          | 37 +++++++++++++++++++++++---------
 arch/x86/kernel/cpu/intel_rdt.h          |  3 +++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c |  3 +++
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 53ee6838c496..8c09e9db2fc6 100644
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
index 74aee0fdc97c..91cc31087e8a 100644
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
index 440025446239..749856a2e736 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1055,12 +1055,15 @@ static int set_cache_qos_cfg(int level, bool enable)
 static int set_mba_sc(bool mba_sc)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA];
+	struct rdt_domain *d;
 
 	if (!is_mbm_enabled() || !is_mba_linear() ||
 	    mba_sc == is_mba_sc(r))
 		return -EINVAL;
 
 	r->membw.mba_sc = mba_sc;
+	list_for_each_entry(d, &r->domains, list)
+		setup_default_ctrlval(r, d->ctrl_val, d->mbps_val);
 
 	return 0;
 }
