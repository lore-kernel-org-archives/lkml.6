Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1604C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4DA2157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4DA2157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeHXOUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:20:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55450 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeHXOUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:20:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73BBA1682;
        Fri, 24 Aug 2018 03:46:01 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB2D93F5A0;
        Fri, 24 Aug 2018 03:45:59 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 02/20] x86/intel_rdt: Split struct rdt_domain
Date:   Fri, 24 Aug 2018 11:45:01 +0100
Message-Id: <20180824104519.11203-3-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
References: <20180824104519.11203-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl is the defacto Linux ABI for SoC resource partitioning features.
To support it on another architecture, we need to abstract it from
Intel RDT, and move it to /fs/.

Split struct rdt_domain up too. Move everything that that is particular
to resctrl into a new header file. resctrl code paths touching a 'hw'
struct indicates where an abstraction is needed.

No change in behaviour, this patch just moves types around.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/intel_rdt.c             | 87 +++++++++++----------
 arch/x86/kernel/cpu/intel_rdt.h             | 30 ++++---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 12 ++-
 arch/x86/kernel/cpu/intel_rdt_monitor.c     | 55 +++++++------
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 14 +++-
 include/linux/resctrl.h                     | 17 +++-
 6 files changed, 127 insertions(+), 88 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 8cb2639b8a56..c4e6dcdd235b 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -377,21 +377,23 @@ static void
 mba_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
 	unsigned int i;
+	struct rdt_hw_domain *hw_dom = rc_dom_to_rdt(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_rdt(r);
 
 	/*  Write the delay values for mba. */
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(hw_res->msr_base + i, delay_bw_map(d->ctrl_val[i], r));
+		wrmsrl(hw_res->msr_base + i, delay_bw_map(hw_dom->ctrl_val[i], r));
 }
 
 static void
 cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
 	unsigned int i;
+	struct rdt_hw_domain *hw_dom = rc_dom_to_rdt(d);
 	struct rdt_hw_resource *hw_res = resctrl_to_rdt(r);
 
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(hw_res->msr_base + cbm_idx(r, i), d->ctrl_val[i]);
+		wrmsrl(hw_res->msr_base + cbm_idx(r, i), hw_dom->ctrl_val[i]);
 }
 
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
@@ -476,21 +478,22 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_rdt(r);
+	struct rdt_hw_domain *hw_dom = rc_dom_to_rdt(d);
 	struct msr_param m;
 	u32 *dc, *dm;
 
-	dc = kmalloc_array(r->num_closid, sizeof(*d->ctrl_val), GFP_KERNEL);
+	dc = kmalloc_array(r->num_closid, sizeof(*hw_dom->ctrl_val), GFP_KERNEL);
 	if (!dc)
 		return -ENOMEM;
 
-	dm = kmalloc_array(r->num_closid, sizeof(*d->mbps_val), GFP_KERNEL);
+	dm = kmalloc_array(r->num_closid, sizeof(*hw_dom->mbps_val), GFP_KERNEL);
 	if (!dm) {
 		kfree(dc);
 		return -ENOMEM;
 	}
 
-	d->ctrl_val = dc;
-	d->mbps_val = dm;
+	hw_dom->ctrl_val = dc;
+	hw_dom->mbps_val = dm;
 	setup_default_ctrlval(r, dc, dm);
 
 	m.low = 0;
@@ -502,36 +505,37 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 {
 	size_t tsize;
+	struct rdt_hw_domain *hw_dom = rc_dom_to_rdt(d);
 
 	if (is_llc_occupancy_enabled()) {
-		d->rmid_busy_llc = kcalloc(BITS_TO_LONGS(r->num_rmid),
+		hw_dom->rmid_busy_llc = kcalloc(BITS_TO_LONGS(r->num_rmid),
 					   sizeof(unsigned long),
 					   GFP_KERNEL);
-		if (!d->rmid_busy_llc)
+		if (!hw_dom->rmid_busy_llc)
 			return -ENOMEM;
-		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
+		INIT_DELAYED_WORK(&hw_dom->cqm_limbo, cqm_handle_limbo);
 	}
 	if (is_mbm_total_enabled()) {
-		tsize = sizeof(*d->mbm_total);
-		d->mbm_total = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
-		if (!d->mbm_total) {
-			kfree(d->rmid_busy_llc);
+		tsize = sizeof(*hw_dom->mbm_total);
+		hw_dom->mbm_total = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
+		if (!hw_dom->mbm_total) {
+			kfree(hw_dom->rmid_busy_llc);
 			return -ENOMEM;
 		}
 	}
 	if (is_mbm_local_enabled()) {
-		tsize = sizeof(*d->mbm_local);
-		d->mbm_local = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
-		if (!d->mbm_local) {
-			kfree(d->rmid_busy_llc);
-			kfree(d->mbm_total);
+		tsize = sizeof(*hw_dom->mbm_local);
+		hw_dom->mbm_local = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
+		if (!hw_dom->mbm_local) {
+			kfree(hw_dom->rmid_busy_llc);
+			kfree(hw_dom->mbm_total);
 			return -ENOMEM;
 		}
 	}
 
 	if (is_mbm_enabled()) {
-		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
-		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL);
+		INIT_DELAYED_WORK(&hw_dom->mbm_over, mbm_handle_overflow);
+		mbm_setup_overflow_handler(hw_dom, MBM_OVERFLOW_INTERVAL);
 	}
 
 	return 0;
@@ -554,6 +558,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 {
 	int id = get_cache_id(cpu, r->cache_level);
 	struct list_head *add_pos = NULL;
+	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 
 	d = rdt_find_domain(r, id, &add_pos);
@@ -567,10 +572,10 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	d = kzalloc_node(sizeof(*d), GFP_KERNEL, cpu_to_node(cpu));
-	if (!d)
+	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
+	if (!hw_dom)
 		return;
-
+	d = &hw_dom->resctrl;
 	d->id = id;
 	cpumask_set_cpu(cpu, &d->cpu_mask);
 
@@ -597,6 +602,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 {
 	int id = get_cache_id(cpu, r->cache_level);
+	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 
 	d = rdt_find_domain(r, id, NULL);
@@ -604,6 +610,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		pr_warn("Could't find cache id for cpu %d\n", cpu);
 		return;
 	}
+	hw_dom = rc_dom_to_rdt(d);
 
 	cpumask_clear_cpu(cpu, &d->cpu_mask);
 	if (cpumask_empty(&d->cpu_mask)) {
@@ -615,8 +622,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 			rmdir_mondata_subdir_allrdtgrp(r, d->id);
 		list_del(&d->list);
 		if (is_mbm_enabled())
-			cancel_delayed_work(&d->mbm_over);
-		if (is_llc_occupancy_enabled() &&  has_busy_rmid(r, d)) {
+			cancel_delayed_work(&hw_dom->mbm_over);
+		if (is_llc_occupancy_enabled() &&  has_busy_rmid(r, hw_dom)) {
 			/*
 			 * When a package is going down, forcefully
 			 * decrement rmid->ebusy. There is no way to know
@@ -625,28 +632,28 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 			 * the RMID as busy creates RMID leaks if the
 			 * package never comes back.
 			 */
-			__check_limbo(d, true);
-			cancel_delayed_work(&d->cqm_limbo);
+			__check_limbo(hw_dom, true);
+			cancel_delayed_work(&hw_dom->cqm_limbo);
 		}
 
-		kfree(d->ctrl_val);
-		kfree(d->mbps_val);
-		kfree(d->rmid_busy_llc);
-		kfree(d->mbm_total);
-		kfree(d->mbm_local);
-		kfree(d);
+		kfree(hw_dom->ctrl_val);
+		kfree(hw_dom->mbps_val);
+		kfree(hw_dom->rmid_busy_llc);
+		kfree(hw_dom->mbm_total);
+		kfree(hw_dom->mbm_local);
+		kfree(hw_dom);
 		return;
 	}
 
 	if (r == &rdt_resources_all[RDT_RESOURCE_L3].resctrl) {
-		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
-			cancel_delayed_work(&d->mbm_over);
-			mbm_setup_overflow_handler(d, 0);
+		if (is_mbm_enabled() && cpu == hw_dom->mbm_work_cpu) {
+			cancel_delayed_work(&hw_dom->mbm_over);
+			mbm_setup_overflow_handler(hw_dom, 0);
 		}
-		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
-		    has_busy_rmid(r, d)) {
-			cancel_delayed_work(&d->cqm_limbo);
-			cqm_setup_limbo_handler(d, 0);
+		if (is_llc_occupancy_enabled() && cpu == hw_dom->cqm_work_cpu &&
+		    has_busy_rmid(r, hw_dom)) {
+			cancel_delayed_work(&hw_dom->cqm_limbo);
+			cqm_setup_limbo_handler(hw_dom, 0);
 		}
 	}
 }
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 20a6674ac67c..7c17d74fd36c 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -64,7 +64,7 @@ union mon_data_bits {
 
 struct rmid_read {
 	struct rdtgroup		*rgrp;
-	struct rdt_domain	*d;
+	struct rdt_hw_domain	*d;
 	int			evtid;
 	bool			first;
 	u64			val;
@@ -200,9 +200,7 @@ struct mbm_state {
 
 /**
  * struct rdt_domain - group of cpus sharing an RDT resource
- * @list:	all instances of this resource
- * @id:		unique id for this instance
- * @cpu_mask:	which cpus share this resource
+ * @resctrl:	Properties exposed to the resctrl filesystem
  * @rmid_busy_llc:
  *		bitmap of which limbo RMIDs are above threshold
  * @mbm_total:	saved state for MBM total bandwidth
@@ -215,13 +213,9 @@ struct mbm_state {
  *		worker cpu for CQM h/w counters
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
  * @mbps_val:	When mba_sc is enabled, this holds the bandwidth in MBps
- * @new_ctrl:	new ctrl value to be loaded
- * @have_new_ctrl: did user provide new_ctrl for this domain
  */
-struct rdt_domain {
-	struct list_head	list;
-	int			id;
-	struct cpumask		cpu_mask;
+struct rdt_hw_domain {
+	struct rdt_domain	resctrl;
 	unsigned long		*rmid_busy_llc;
 	struct mbm_state	*mbm_total;
 	struct mbm_state	*mbm_local;
@@ -231,10 +225,14 @@ struct rdt_domain {
 	int			cqm_work_cpu;
 	u32			*ctrl_val;
 	u32			*mbps_val;
-	u32			new_ctrl;
-	bool			have_new_ctrl;
 };
 
+static inline struct rdt_hw_domain *rc_dom_to_rdt(struct rdt_domain *r)
+{
+	return container_of(r, struct rdt_hw_domain, resctrl);
+}
+
+
 /**
  * struct msr_param - set a range of MSRs from a domain
  * @res:       The resource to use
@@ -403,15 +401,15 @@ void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 				    struct rdt_domain *d);
 void mon_event_read(struct rmid_read *rr, struct rdt_domain *d,
 		    struct rdtgroup *rdtgrp, int evtid, int first);
-void mbm_setup_overflow_handler(struct rdt_domain *dom,
+void mbm_setup_overflow_handler(struct rdt_hw_domain *dom,
 				unsigned long delay_ms);
 void mbm_handle_overflow(struct work_struct *work);
 bool is_mba_sc(struct rdt_resource *r);
 void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm);
 u32 delay_bw_map(unsigned long bw, struct rdt_resource *r);
-void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
+void cqm_setup_limbo_handler(struct rdt_hw_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
-bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
-void __check_limbo(struct rdt_domain *d, bool force_free);
+bool has_busy_rmid(struct rdt_resource *r, struct rdt_hw_domain *d);
+void __check_limbo(struct rdt_hw_domain *d, bool force_free);
 
 #endif /* _ASM_X86_INTEL_RDT_H */
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 58890612ca8d..e3dcb5161122 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -177,6 +177,7 @@ static int parse_line(char *line, struct rdt_resource *r)
 
 static int update_domains(struct rdt_resource *r, int closid)
 {
+	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
@@ -193,7 +194,8 @@ static int update_domains(struct rdt_resource *r, int closid)
 
 	mba_sc = is_mba_sc(r);
 	list_for_each_entry(d, &r->domains, list) {
-		dc = !mba_sc ? d->ctrl_val : d->mbps_val;
+		hw_dom = rc_dom_to_rdt(d);
+		dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
 		if (d->have_new_ctrl && d->new_ctrl != dc[closid]) {
 			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 			dc[closid] = d->new_ctrl;
@@ -290,17 +292,19 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
 {
+	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *dom;
 	bool sep = false;
 	u32 ctrl_val;
 
 	seq_printf(s, "%*s:", max_name_width, r->name);
 	list_for_each_entry(dom, &r->domains, list) {
+		hw_dom = rc_dom_to_rdt(dom);
 		if (sep)
 			seq_puts(s, ";");
 
-		ctrl_val = (!is_mba_sc(r) ? dom->ctrl_val[closid] :
-			    dom->mbps_val[closid]);
+		ctrl_val = (!is_mba_sc(r) ? hw_dom->ctrl_val[closid] :
+			    hw_dom->mbps_val[closid]);
 		seq_printf(s, r->format_str, dom->id, max_data_width,
 			   ctrl_val);
 		sep = true;
@@ -338,7 +342,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_domain *d,
 	 */
 	rr->rgrp = rdtgrp;
 	rr->evtid = evtid;
-	rr->d = d;
+	rr->d = rc_dom_to_rdt(d);
 	rr->val = 0;
 	rr->first = first;
 
diff --git a/arch/x86/kernel/cpu/intel_rdt_monitor.c b/arch/x86/kernel/cpu/intel_rdt_monitor.c
index 493d264a0dbe..c05f1cecf6cd 100644
--- a/arch/x86/kernel/cpu/intel_rdt_monitor.c
+++ b/arch/x86/kernel/cpu/intel_rdt_monitor.c
@@ -116,7 +116,7 @@ static bool rmid_dirty(struct rmid_entry *entry)
  * decrement the count. If the busy count gets to zero on an RMID, we
  * free the RMID
  */
-void __check_limbo(struct rdt_domain *d, bool force_free)
+void __check_limbo(struct rdt_hw_domain *d, bool force_free)
 {
 	struct rmid_entry *entry;
 	struct rdt_resource *r;
@@ -147,7 +147,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 	}
 }
 
-bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)
+bool has_busy_rmid(struct rdt_resource *r, struct rdt_hw_domain *d)
 {
 	return find_first_bit(d->rmid_busy_llc, r->num_rmid) != r->num_rmid;
 }
@@ -175,6 +175,7 @@ int alloc_rmid(void)
 
 static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
+	struct rdt_hw_domain *hw_dom;
 	struct rdt_resource *r;
 	struct rdt_domain *d;
 	int cpu;
@@ -185,6 +186,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	entry->busy = 0;
 	cpu = get_cpu();
 	list_for_each_entry(d, &r->domains, list) {
+		hw_dom = rc_dom_to_rdt(d);
 		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
 			val = __rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID);
 			if (val <= intel_cqm_threshold)
@@ -195,9 +197,9 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 		 * For the first limbo RMID in the domain,
 		 * setup up the limbo worker.
 		 */
-		if (!has_busy_rmid(r, d))
-			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL);
-		set_bit(entry->rmid, d->rmid_busy_llc);
+		if (!has_busy_rmid(r, hw_dom))
+			cqm_setup_limbo_handler(hw_dom, CQM_LIMBOCHECK_INTERVAL);
+		set_bit(entry->rmid, hw_dom->rmid_busy_llc);
 		entry->busy++;
 	}
 	put_cpu();
@@ -363,9 +365,11 @@ void mon_event_count(void *info)
  */
 static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 {
+	struct rdt_hw_domain *hw_dom_mbm = rc_dom_to_rdt(dom_mbm);
 	u32 closid, rmid, cur_msr, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
 	struct rdt_hw_resource *hw_r_mba;
+	struct rdt_hw_domain *hw_dom_mba;
 	u32 cur_bw, delta_bw, user_bw;
 	struct rdt_resource *r_mba;
 	struct rdt_domain *dom_mba;
@@ -376,25 +380,26 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	r_mba = &hw_r_mba->resctrl;
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
-	pmbm_data = &dom_mbm->mbm_local[rmid];
+	pmbm_data = &hw_dom_mbm->mbm_local[rmid];
 
 	dom_mba = get_domain_from_cpu(smp_processor_id(), r_mba);
 	if (!dom_mba) {
 		pr_warn_once("Failure to get domain for MBA update\n");
 		return;
 	}
+	hw_dom_mba = rc_dom_to_rdt(dom_mba);
 
 	cur_bw = pmbm_data->prev_bw;
-	user_bw = dom_mba->mbps_val[closid];
+	user_bw = hw_dom_mba->mbps_val[closid];
 	delta_bw = pmbm_data->delta_bw;
-	cur_msr_val = dom_mba->ctrl_val[closid];
+	cur_msr_val = hw_dom_mba->ctrl_val[closid];
 
 	/*
 	 * For Ctrl groups read data from child monitor groups.
 	 */
 	head = &rgrp->mon.crdtgrp_list;
 	list_for_each_entry(entry, head, mon.crdtgrp_list) {
-		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
+		cmbm_data = &hw_dom_mbm->mbm_local[entry->mon.rmid];
 		cur_bw += cmbm_data->prev_bw;
 		delta_bw += cmbm_data->delta_bw;
 	}
@@ -424,7 +429,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 
 	cur_msr = hw_r_mba->msr_base + closid;
 	wrmsrl(cur_msr, delay_bw_map(new_msr_val, r_mba));
-	dom_mba->ctrl_val[closid] = new_msr_val;
+	hw_dom_mba->ctrl_val[closid] = new_msr_val;
 
 	/*
 	 * Delta values are updated dynamically package wise for each
@@ -438,17 +443,17 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	 */
 	pmbm_data->delta_comp = true;
 	list_for_each_entry(entry, head, mon.crdtgrp_list) {
-		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
+		cmbm_data = &hw_dom_mbm->mbm_local[entry->mon.rmid];
 		cmbm_data->delta_comp = true;
 	}
 }
 
-static void mbm_update(struct rdt_domain *d, int rmid)
+static void mbm_update(struct rdt_hw_domain *hw_dom, int rmid)
 {
 	struct rmid_read rr;
 
 	rr.first = false;
-	rr.d = d;
+	rr.d = hw_dom;
 
 	/*
 	 * This is protected from concurrent reads from user
@@ -480,6 +485,7 @@ static void mbm_update(struct rdt_domain *d, int rmid)
 void cqm_handle_limbo(struct work_struct *work)
 {
 	unsigned long delay = msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
+	struct rdt_hw_domain *hw_dom;
 	int cpu = smp_processor_id();
 	struct rdt_resource *r;
 	struct rdt_domain *d;
@@ -493,17 +499,18 @@ void cqm_handle_limbo(struct work_struct *work)
 		pr_warn_once("Failure to get domain for limbo worker\n");
 		goto out_unlock;
 	}
+	hw_dom = rc_dom_to_rdt(d);
 
-	__check_limbo(d, false);
+	__check_limbo(hw_dom, false);
 
-	if (has_busy_rmid(r, d))
-		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);
+	if (has_busy_rmid(r, hw_dom))
+		schedule_delayed_work_on(cpu, &hw_dom->cqm_limbo, delay);
 
 out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
+void cqm_setup_limbo_handler(struct rdt_hw_domain *dom, unsigned long delay_ms)
 {
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	struct rdt_resource *r;
@@ -511,7 +518,7 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3].resctrl;
 
-	cpu = cpumask_any(&dom->cpu_mask);
+	cpu = cpumask_any(&dom->resctrl.cpu_mask);
 	dom->cqm_work_cpu = cpu;
 
 	schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
@@ -522,6 +529,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	unsigned long delay = msecs_to_jiffies(MBM_OVERFLOW_INTERVAL);
 	struct rdtgroup *prgrp, *crgrp;
 	int cpu = smp_processor_id();
+	struct rdt_hw_domain *hw_dom;
 	struct list_head *head;
 	struct rdt_domain *d;
 
@@ -533,32 +541,33 @@ void mbm_handle_overflow(struct work_struct *work)
 	d = get_domain_from_cpu(cpu, &rdt_resources_all[RDT_RESOURCE_L3].resctrl);
 	if (!d)
 		goto out_unlock;
+	hw_dom = rc_dom_to_rdt(d);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-		mbm_update(d, prgrp->mon.rmid);
+		mbm_update(hw_dom, prgrp->mon.rmid);
 
 		head = &prgrp->mon.crdtgrp_list;
 		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
-			mbm_update(d, crgrp->mon.rmid);
+			mbm_update(hw_dom, crgrp->mon.rmid);
 
 		if (is_mba_sc(NULL))
 			update_mba_bw(prgrp, d);
 	}
 
-	schedule_delayed_work_on(cpu, &d->mbm_over, delay);
+	schedule_delayed_work_on(cpu, &hw_dom->mbm_over, delay);
 
 out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
+void mbm_setup_overflow_handler(struct rdt_hw_domain *dom, unsigned long delay_ms)
 {
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
 
 	if (!static_branch_likely(&rdt_enable_key))
 		return;
-	cpu = cpumask_any(&dom->cpu_mask);
+	cpu = cpumask_any(&dom->resctrl.cpu_mask);
 	dom->mbm_work_cpu = cpu;
 	schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
 }
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 3afe642e3ede..3ed88d4fedd0 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1057,6 +1057,7 @@ static int set_cache_qos_cfg(int level, bool enable)
 static int set_mba_sc(bool mba_sc)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].resctrl;
+	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 
 	if (!is_mbm_enabled() || !is_mba_linear() ||
@@ -1064,8 +1065,10 @@ static int set_mba_sc(bool mba_sc)
 		return -EINVAL;
 
 	r->membw.mba_sc = mba_sc;
-	list_for_each_entry(d, &r->domains, list)
-		setup_default_ctrlval(r, d->ctrl_val, d->mbps_val);
+	list_for_each_entry(d, &r->domains, list) {
+		hw_dom = rc_dom_to_rdt(d);
+		setup_default_ctrlval(r, hw_dom->ctrl_val, hw_dom->mbps_val);
+	}
 
 	return 0;
 }
@@ -1307,7 +1310,8 @@ static struct dentry *rdt_mount(struct file_system_type *fs_type,
 	if (is_mbm_enabled()) {
 		r = &rdt_resources_all[RDT_RESOURCE_L3].resctrl;
 		list_for_each_entry(dom, &r->domains, list)
-			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
+			mbm_setup_overflow_handler(rc_dom_to_rdt(dom),
+						   MBM_OVERFLOW_INTERVAL);
 	}
 
 	goto out;
@@ -1332,6 +1336,7 @@ static struct dentry *rdt_mount(struct file_system_type *fs_type,
 
 static int reset_all_ctrls(struct rdt_resource *r)
 {
+	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
@@ -1350,10 +1355,11 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	 * from each domain to update the MSRs below.
 	 */
 	list_for_each_entry(d, &r->domains, list) {
+		hw_dom = rc_dom_to_rdt(d);
 		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 
 		for (i = 0; i < r->num_closid; i++)
-			d->ctrl_val[i] = r->default_ctrl;
+			hw_dom->ctrl_val[i] = r->default_ctrl;
 	}
 	cpu = get_cpu();
 	/* Update CBM on this cpu if it's in cpu_mask. */
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8d32b2c6d72b..5950c30fcc30 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -7,7 +7,22 @@
 #include <linux/list.h>
 #include <linux/kernel.h>
 
-struct rdt_domain;
+/**
+ * struct rdt_domain - group of cpus sharing an RDT resource
+ * @list:	all instances of this resource
+ * @id:		unique id for this instance
+ * @cpu_mask:	which cpus share this resource
+ * @new_ctrl:	new ctrl value to be loaded
+ * @have_new_ctrl: did user provide new_ctrl for this domain
+ */
+struct rdt_domain {
+	struct list_head	list;
+	int			id;
+	struct cpumask		cpu_mask;
+
+	u32			new_ctrl;
+	bool			have_new_ctrl;
+};
 
 /**
  * struct resctrl_cache - Cache allocation related data
-- 
2.18.0

