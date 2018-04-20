Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbeDTWjz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 18:39:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:60382 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752900AbeDTWjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 18:39:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,303,1520924400";
   d="scan'208";a="34982641"
From: Vikas Shivappa <vikas.shivappa@linux.intel.com>
To: vikas.shivappa@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        tglx@linutronix.de, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, ak@linux.intel.com,
        vikas.shivappa@linux.intel.com
Subject: [PATCH 4/6] x86/intel_rdt/mba_sc: Add schemata support
Date: Fri, 20 Apr 2018 15:36:19 -0700
Message-Id: <1524263781-14267-5-git-send-email-vikas.shivappa@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524263781-14267-1-git-send-email-vikas.shivappa@linux.intel.com>
References: <1524263781-14267-1-git-send-email-vikas.shivappa@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when user updates the "schemata" with new MBA percentage
values, kernel writes the corresponding bandwidth percentage values to
the IA32_MBA_THRTL_MSR.

When MBA is expressed in MBps, the schemata format is changed to have
the per package memory bandwidth in MBps instead of being specified in
percentage. We do not write the IA32_MBA_THRTL_MSRs when the schemata
is updated as that is handled separately.

Signed-off-by: Vikas Shivappa <vikas.shivappa@linux.intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.c             |  2 +-
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 24 +++++++++++++++++++-----
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 07f6b3b..85805d7 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -179,7 +179,7 @@ struct rdt_resource rdt_resources_all[] = {
 		.msr_update		= mba_wrmsr,
 		.cache_level		= 3,
 		.parse_ctrlval		= parse_bw,
-		.format_str		= "%d=%*d",
+		.format_str		= "%d=%*u",
 		.fflags			= RFTYPE_RES_MB,
 	},
 };
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 23e1d5c..116d57b 100644
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
-- 
1.9.1
