Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbeFDKkJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:40:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39085 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbeFDKkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:40:06 -0400
Date: Mon, 4 Jun 2018 12:40:03 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] x86/cache updates for 4.18
Message-ID: <alpine.DEB.2.21.1806041227480.2646@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-cache-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cache-for-linus

An update for the Intel Resource Director Technolgy (RDT) which adds a
feedback driven software controller to runtime adjust the bandwidth
allocation MSRs. This makes the allocations more accurate and allows to use
bandwidth values in understandable units (MB/s) instead of using percentage
based allocations as the original, still available, interface. The software
controller can be enabled with a new mount option for the resctrl
filesystem.

Thanks,

	tglx

------------------>
Vikas Shivappa (6):
      x86/intel_rdt/mba_sc: Documentation for MBA software controller(mba_sc)
      x86/intel_rdt/mba_sc: Enable/disable MBA software controller
      x86/intel_rdt/mba_sc: Add initialization support
      x86/intel_rdt/mba_sc: Add schemata support
      x86/intel_rdt/mba_sc: Prepare for feedback loop
      x86/intel_rdt/mba_sc: Feedback loop to dynamically update mem bandwidth


 Documentation/x86/intel_rdt_ui.txt          |  75 ++++++++++--
 arch/x86/kernel/cpu/intel_rdt.c             |  50 +++++---
 arch/x86/kernel/cpu/intel_rdt.h             |  18 +++
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c |  24 +++-
 arch/x86/kernel/cpu/intel_rdt_monitor.c     | 170 ++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    |  33 ++++++
 6 files changed, 337 insertions(+), 33 deletions(-)

diff --git a/Documentation/x86/intel_rdt_ui.txt b/Documentation/x86/intel_rdt_ui.txt
index 71c30984e94d..a16aa2113840 100644
--- a/Documentation/x86/intel_rdt_ui.txt
+++ b/Documentation/x86/intel_rdt_ui.txt
@@ -17,12 +17,14 @@ MBA (Memory Bandwidth Allocation) - "mba"
 
 To use the feature mount the file system:
 
- # mount -t resctrl resctrl [-o cdp[,cdpl2]] /sys/fs/resctrl
+ # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps]] /sys/fs/resctrl
 
 mount options are:
 
 "cdp": Enable code/data prioritization in L3 cache allocations.
 "cdpl2": Enable code/data prioritization in L2 cache allocations.
+"mba_MBps": Enable the MBA Software Controller(mba_sc) to specify MBA
+ bandwidth in MBps
 
 L2 and L3 CDP are controlled seperately.
 
@@ -270,10 +272,11 @@ and 0xA are not.  On a system with a 20-bit mask each bit represents 5%
 of the capacity of the cache. You could partition the cache into four
 equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
 
-Memory bandwidth(b/w) percentage
---------------------------------
-For Memory b/w resource, user controls the resource by indicating the
-percentage of total memory b/w.
+Memory bandwidth Allocation and monitoring
+------------------------------------------
+
+For Memory bandwidth resource, by default the user controls the resource
+by indicating the percentage of total memory bandwidth.
 
 The minimum bandwidth percentage value for each cpu model is predefined
 and can be looked up through "info/MB/min_bandwidth". The bandwidth
@@ -285,7 +288,47 @@ to the next control step available on the hardware.
 The bandwidth throttling is a core specific mechanism on some of Intel
 SKUs. Using a high bandwidth and a low bandwidth setting on two threads
 sharing a core will result in both threads being throttled to use the
-low bandwidth.
+low bandwidth. The fact that Memory bandwidth allocation(MBA) is a core
+specific mechanism where as memory bandwidth monitoring(MBM) is done at
+the package level may lead to confusion when users try to apply control
+via the MBA and then monitor the bandwidth to see if the controls are
+effective. Below are such scenarios:
+
+1. User may *not* see increase in actual bandwidth when percentage
+   values are increased:
+
+This can occur when aggregate L2 external bandwidth is more than L3
+external bandwidth. Consider an SKL SKU with 24 cores on a package and
+where L2 external  is 10GBps (hence aggregate L2 external bandwidth is
+240GBps) and L3 external bandwidth is 100GBps. Now a workload with '20
+threads, having 50% bandwidth, each consuming 5GBps' consumes the max L3
+bandwidth of 100GBps although the percentage value specified is only 50%
+<< 100%. Hence increasing the bandwidth percentage will not yeild any
+more bandwidth. This is because although the L2 external bandwidth still
+has capacity, the L3 external bandwidth is fully used. Also note that
+this would be dependent on number of cores the benchmark is run on.
+
+2. Same bandwidth percentage may mean different actual bandwidth
+   depending on # of threads:
+
+For the same SKU in #1, a 'single thread, with 10% bandwidth' and '4
+thread, with 10% bandwidth' can consume upto 10GBps and 40GBps although
+they have same percentage bandwidth of 10%. This is simply because as
+threads start using more cores in an rdtgroup, the actual bandwidth may
+increase or vary although user specified bandwidth percentage is same.
+
+In order to mitigate this and make the interface more user friendly,
+resctrl added support for specifying the bandwidth in MBps as well.  The
+kernel underneath would use a software feedback mechanism or a "Software
+Controller(mba_sc)" which reads the actual bandwidth using MBM counters
+and adjust the memowy bandwidth percentages to ensure
+
+	"actual bandwidth < user specified bandwidth".
+
+By default, the schemata would take the bandwidth percentage values
+where as user can switch to the "MBA software controller" mode using
+a mount option 'mba_MBps'. The schemata format is specified in the below
+sections.
 
 L3 schemata file details (code and data prioritization disabled)
 ----------------------------------------------------------------
@@ -308,13 +351,20 @@ schemata format is always:
 
 	L2:<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
 
-Memory b/w Allocation details
------------------------------
+Memory bandwidth Allocation (default mode)
+------------------------------------------
 
 Memory b/w domain is L3 cache.
 
 	MB:<cache_id0>=bandwidth0;<cache_id1>=bandwidth1;...
 
+Memory bandwidth Allocation specified in MBps
+---------------------------------------------
+
+Memory bandwidth domain is L3 cache.
+
+	MB:<cache_id0>=bw_MBps0;<cache_id1>=bw_MBps1;...
+
 Reading/writing the schemata file
 ---------------------------------
 Reading the schemata file will show the state of all resources
@@ -358,6 +408,15 @@ allocations can overlap or not. The allocations specifies the maximum
 b/w that the group may be able to use and the system admin can configure
 the b/w accordingly.
 
+If the MBA is specified in MB(megabytes) then user can enter the max b/w in MB
+rather than the percentage values.
+
+# echo "L3:0=3;1=c\nMB:0=1024;1=500" > /sys/fs/resctrl/p0/schemata
+# echo "L3:0=3;1=3\nMB:0=1024;1=500" > /sys/fs/resctrl/p1/schemata
+
+In the above example the tasks in "p1" and "p0" on socket 0 would use a max b/w
+of 1024MB where as on socket 1 they would use 500MB.
+
 Example 2
 ---------
 Again two sockets, but this time with a more realistic 20-bit mask.
diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 589b948e6e01..24bfa63e86cf 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -33,8 +33,8 @@
 #include <asm/intel_rdt_sched.h>
 #include "intel_rdt.h"
 
-#define MAX_MBA_BW	100u
 #define MBA_IS_LINEAR	0x4
+#define MBA_MAX_MBPS	U32_MAX
 
 /* Mutex to protect rdtgroup access. */
 DEFINE_MUTEX(rdtgroup_mutex);
@@ -178,7 +178,7 @@ struct rdt_resource rdt_resources_all[] = {
 		.msr_update		= mba_wrmsr,
 		.cache_level		= 3,
 		.parse_ctrlval		= parse_bw,
-		.format_str		= "%d=%*d",
+		.format_str		= "%d=%*u",
 		.fflags			= RFTYPE_RES_MB,
 	},
 };
@@ -230,6 +230,14 @@ static inline void cache_alloc_hsw_probe(void)
 	rdt_alloc_capable = true;
 }
 
+bool is_mba_sc(struct rdt_resource *r)
+{
+	if (!r)
+		return rdt_resources_all[RDT_RESOURCE_MBA].membw.mba_sc;
+
+	return r->membw.mba_sc;
+}
+
 /*
  * rdt_get_mb_table() - get a mapping of bandwidth(b/w) percentage values
  * exposed to user interface and the h/w understandable delay values.
@@ -341,7 +349,7 @@ static int get_cache_id(int cpu, int level)
  * that can be written to QOS_MSRs.
  * There are currently no SKUs which support non linear delay values.
  */
-static u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
+u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
 {
 	if (r->membw.delay_linear)
 		return MAX_MBA_BW - bw;
@@ -431,25 +439,40 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
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
@@ -588,6 +611,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		}
 
 		kfree(d->ctrl_val);
+		kfree(d->mbps_val);
 		kfree(d->rmid_busy_llc);
 		kfree(d->mbm_total);
 		kfree(d->mbm_local);
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 3fd7a70ee04a..39752825e376 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -28,6 +28,7 @@
 
 #define MBM_CNTR_WIDTH			24
 #define MBM_OVERFLOW_INTERVAL		1000
+#define MAX_MBA_BW			100u
 
 #define RMID_VAL_ERROR			BIT_ULL(63)
 #define RMID_VAL_UNAVAIL		BIT_ULL(62)
@@ -180,10 +181,20 @@ struct rftype {
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
@@ -202,6 +213,7 @@ struct mbm_state {
  * @cqm_work_cpu:
  *		worker cpu for CQM h/w counters
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
+ * @mbps_val:	When mba_sc is enabled, this holds the bandwidth in MBps
  * @new_ctrl:	new ctrl value to be loaded
  * @have_new_ctrl: did user provide new_ctrl for this domain
  */
@@ -217,6 +229,7 @@ struct rdt_domain {
 	int			mbm_work_cpu;
 	int			cqm_work_cpu;
 	u32			*ctrl_val;
+	u32			*mbps_val;
 	u32			new_ctrl;
 	bool			have_new_ctrl;
 };
@@ -259,6 +272,7 @@ struct rdt_cache {
  * @min_bw:		Minimum memory bandwidth percentage user can request
  * @bw_gran:		Granularity at which the memory bandwidth is allocated
  * @delay_linear:	True if memory B/W delay is in linear scale
+ * @mba_sc:		True if MBA software controller(mba_sc) is enabled
  * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
  */
 struct rdt_membw {
@@ -266,6 +280,7 @@ struct rdt_membw {
 	u32		min_bw;
 	u32		bw_gran;
 	u32		delay_linear;
+	bool		mba_sc;
 	u32		*mb_map;
 };
 
@@ -445,6 +460,9 @@ void mon_event_read(struct rmid_read *rr, struct rdt_domain *d,
 void mbm_setup_overflow_handler(struct rdt_domain *dom,
 				unsigned long delay_ms);
 void mbm_handle_overflow(struct work_struct *work);
+bool is_mba_sc(struct rdt_resource *r);
+void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm);
+u32 delay_bw_map(unsigned long bw, struct rdt_resource *r);
 void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 23e1d5c249c6..116d57b248d3 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -53,7 +53,8 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 		return false;
 	}
 
-	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
+	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
+	    !is_mba_sc(r)) {
 		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
 				    r->membw.min_bw, r->default_ctrl);
 		return false;
@@ -179,6 +180,8 @@ static int update_domains(struct rdt_resource *r, int closid)
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
+	bool mba_sc;
+	u32 *dc;
 	int cpu;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
@@ -188,13 +191,20 @@ static int update_domains(struct rdt_resource *r, int closid)
 	msr_param.high = msr_param.low + 1;
 	msr_param.res = r;
 
+	mba_sc = is_mba_sc(r);
 	list_for_each_entry(d, &r->domains, list) {
-		if (d->have_new_ctrl && d->new_ctrl != d->ctrl_val[closid]) {
+		dc = !mba_sc ? d->ctrl_val : d->mbps_val;
+		if (d->have_new_ctrl && d->new_ctrl != dc[closid]) {
 			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
-			d->ctrl_val[closid] = d->new_ctrl;
+			dc[closid] = d->new_ctrl;
 		}
 	}
-	if (cpumask_empty(cpu_mask))
+
+	/*
+	 * Avoid writing the control msr with control values when
+	 * MBA software controller is enabled
+	 */
+	if (cpumask_empty(cpu_mask) || mba_sc)
 		goto done;
 	cpu = get_cpu();
 	/* Update CBM on this cpu if it's in cpu_mask. */
@@ -282,13 +292,17 @@ static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
 {
 	struct rdt_domain *dom;
 	bool sep = false;
+	u32 ctrl_val;
 
 	seq_printf(s, "%*s:", max_name_width, r->name);
 	list_for_each_entry(dom, &r->domains, list) {
 		if (sep)
 			seq_puts(s, ";");
+
+		ctrl_val = (!is_mba_sc(r) ? dom->ctrl_val[closid] :
+			    dom->mbps_val[closid]);
 		seq_printf(s, r->format_str, dom->id, max_data_width,
-			   dom->ctrl_val[closid]);
+			   ctrl_val);
 		sep = true;
 	}
 	seq_puts(s, "\n");
diff --git a/arch/x86/kernel/cpu/intel_rdt_monitor.c b/arch/x86/kernel/cpu/intel_rdt_monitor.c
index 681450eee428..b0f3aed76b75 100644
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
 
@@ -269,6 +275,32 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 	return 0;
 }
 
+/*
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
+	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL))
+		return;
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
 /*
  * This is called via IPI to read the CQM/MBM counters
  * on a domain.
@@ -297,6 +329,118 @@ void mon_event_count(void *info)
 	}
 }
 
+/*
+ * Feedback loop for MBA software controller (mba_sc)
+ *
+ * mba_sc is a feedback loop where we periodically read MBM counters and
+ * adjust the bandwidth percentage values via the IA32_MBA_THRTL_MSRs so
+ * that:
+ *
+ *   current bandwdith(cur_bw) < user specified bandwidth(user_bw)
+ *
+ * This uses the MBM counters to measure the bandwidth and MBA throttle
+ * MSRs to control the bandwidth for a particular rdtgrp. It builds on the
+ * fact that resctrl rdtgroups have both monitoring and control.
+ *
+ * The frequency of the checks is 1s and we just tag along the MBM overflow
+ * timer. Having 1s interval makes the calculation of bandwidth simpler.
+ *
+ * Although MBA's goal is to restrict the bandwidth to a maximum, there may
+ * be a need to increase the bandwidth to avoid uncecessarily restricting
+ * the L2 <-> L3 traffic.
+ *
+ * Since MBA controls the L2 external bandwidth where as MBM measures the
+ * L3 external bandwidth the following sequence could lead to such a
+ * situation.
+ *
+ * Consider an rdtgroup which had high L3 <-> memory traffic in initial
+ * phases -> mba_sc kicks in and reduced bandwidth percentage values -> but
+ * after some time rdtgroup has mostly L2 <-> L3 traffic.
+ *
+ * In this case we may restrict the rdtgroup's L2 <-> L3 traffic as its
+ * throttle MSRs already have low percentage values.  To avoid
+ * unnecessarily restricting such rdtgroups, we also increase the bandwidth.
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
+	 * Scale up/down the bandwidth linearly for the ctrl group.  The
+	 * bandwidth step is the bandwidth granularity specified by the
+	 * hardware.
+	 *
+	 * The delta_bw is used when increasing the bandwidth so that we
+	 * dont alternately increase and decrease the control values
+	 * continuously.
+	 *
+	 * For ex: consider cur_bw = 90MBps, user_bw = 100MBps and if
+	 * bandwidth step is 20MBps(> user_bw - cur_bw), we would keep
+	 * switching between 90 and 110 continuously if we only check
+	 * cur_bw < user_bw.
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
+	 * Delta values are updated dynamically package wise for each
+	 * rdtgrp everytime the throttle MSR changes value.
+	 *
+	 * This is because (1)the increase in bandwidth is not perfectly
+	 * linear and only "approximately" linear even when the hardware
+	 * says it is linear.(2)Also since MBA is a core specific
+	 * mechanism, the delta values vary based on number of cores used
+	 * by the rdtgrp.
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
@@ -314,7 +458,16 @@ static void mbm_update(struct rdt_domain *d, int rmid)
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
 
@@ -385,6 +538,9 @@ void mbm_handle_overflow(struct work_struct *work)
 		head = &prgrp->mon.crdtgrp_list;
 		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
 			mbm_update(d, crgrp->mon.rmid);
+
+		if (is_mba_sc(NULL))
+			update_mba_bw(prgrp, d);
 	}
 
 	schedule_delayed_work_on(cpu, &d->mbm_over, delay);
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index fca759d272a1..749856a2e736 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1005,6 +1005,11 @@ static void l2_qos_cfg_update(void *arg)
 	wrmsrl(IA32_L2_QOS_CFG, *enable ? L2_QOS_CDP_ENABLE : 0ULL);
 }
 
+static inline bool is_mba_linear(void)
+{
+	return rdt_resources_all[RDT_RESOURCE_MBA].membw.delay_linear;
+}
+
 static int set_cache_qos_cfg(int level, bool enable)
 {
 	void (*update)(void *arg);
@@ -1041,6 +1046,28 @@ static int set_cache_qos_cfg(int level, bool enable)
 	return 0;
 }
 
+/*
+ * Enable or disable the MBA software controller
+ * which helps user specify bandwidth in MBps.
+ * MBA software controller is supported only if
+ * MBM is supported and MBA is in linear scale.
+ */
+static int set_mba_sc(bool mba_sc)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA];
+	struct rdt_domain *d;
+
+	if (!is_mbm_enabled() || !is_mba_linear() ||
+	    mba_sc == is_mba_sc(r))
+		return -EINVAL;
+
+	r->membw.mba_sc = mba_sc;
+	list_for_each_entry(d, &r->domains, list)
+		setup_default_ctrlval(r, d->ctrl_val, d->mbps_val);
+
+	return 0;
+}
+
 static int cdp_enable(int level, int data_type, int code_type)
 {
 	struct rdt_resource *r_ldata = &rdt_resources_all[data_type];
@@ -1123,6 +1150,10 @@ static int parse_rdtgroupfs_options(char *data)
 			ret = cdpl2_enable();
 			if (ret)
 				goto out;
+		} else if (!strcmp(token, "mba_MBps")) {
+			ret = set_mba_sc(true);
+			if (ret)
+				goto out;
 		} else {
 			ret = -EINVAL;
 			goto out;
@@ -1445,6 +1476,8 @@ static void rdt_kill_sb(struct super_block *sb)
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
+	set_mba_sc(false);
+
 	/*Put everything back to default values. */
 	for_each_alloc_enabled_rdt_resource(r)
 		reset_all_ctrls(r);
