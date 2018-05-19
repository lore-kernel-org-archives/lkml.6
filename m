Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbeESLXW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:23:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38179 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752296AbeESLXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:23:21 -0400
Date: Sat, 19 May 2018 04:23:16 -0700
From: tip-bot for Vikas Shivappa <tipbot@zytor.com>
Message-ID: <tip-8205a078ba7819c23558e31af4b3bda04d9b3bae@git.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        hpa@zytor.com, vikas.shivappa@linux.intel.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        tglx@linutronix.de, vikas.shivappa@linux.intel.com
In-Reply-To: <1524263781-14267-5-git-send-email-vikas.shivappa@linux.intel.com>
References: <1524263781-14267-5-git-send-email-vikas.shivappa@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt/mba_sc: Add schemata support
Git-Commit-ID: 8205a078ba7819c23558e31af4b3bda04d9b3bae
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

Commit-ID:  8205a078ba7819c23558e31af4b3bda04d9b3bae
Gitweb:     https://git.kernel.org/tip/8205a078ba7819c23558e31af4b3bda04d9b3bae
Author:     Vikas Shivappa <vikas.shivappa@linux.intel.com>
AuthorDate: Fri, 20 Apr 2018 15:36:19 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 19 May 2018 13:16:44 +0200

x86/intel_rdt/mba_sc: Add schemata support

Currently when user updates the "schemata" with new MBA percentage
values, kernel writes the corresponding bandwidth percentage values to
the IA32_MBA_THRTL_MSR.

When MBA is expressed in MBps, the schemata format is changed to have the
per package memory bandwidth in MBps instead of being specified in
percentage. Do not write the IA32_MBA_THRTL_MSRs when the schemata is
updated as that is handled separately.

Signed-off-by: Vikas Shivappa <vikas.shivappa@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: ravi.v.shankar@intel.com
Cc: tony.luck@intel.com
Cc: fenghua.yu@intel.com
Cc: vikas.shivappa@intel.com
Cc: ak@linux.intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/1524263781-14267-5-git-send-email-vikas.shivappa@linux.intel.com

---
 arch/x86/kernel/cpu/intel_rdt.c             |  2 +-
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 24 +++++++++++++++++++-----
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 8c09e9db2fc6..ad03d975883e 100644
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
