Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752516AbeESLX0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:23:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55657 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752296AbeESLXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:23:23 -0400
Date: Sat, 19 May 2018 04:22:18 -0700
From: tip-bot for Vikas Shivappa <tipbot@zytor.com>
Message-ID: <tip-19c635ab24a1e94a759e82bfb34554a6a0db215e@git.kernel.org>
Cc: hpa@zytor.com, vikas.shivappa@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: vikas.shivappa@linux.intel.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1524263781-14267-3-git-send-email-vikas.shivappa@linux.intel.com>
References: <1524263781-14267-3-git-send-email-vikas.shivappa@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt/mba_sc: Enable/disable MBA software
 controller
Git-Commit-ID: 19c635ab24a1e94a759e82bfb34554a6a0db215e
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

Commit-ID:  19c635ab24a1e94a759e82bfb34554a6a0db215e
Gitweb:     https://git.kernel.org/tip/19c635ab24a1e94a759e82bfb34554a6a0db215e
Author:     Vikas Shivappa <vikas.shivappa@linux.intel.com>
AuthorDate: Fri, 20 Apr 2018 15:36:17 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 19 May 2018 13:16:43 +0200

x86/intel_rdt/mba_sc: Enable/disable MBA software controller

Currently user does memory bandwidth allocation(MBA) by specifying the
bandwidth in percentage via the resctrl schemata file:
	"/sys/fs/resctrl/schemata"

Add a new mount option "mba_MBps" to enable the user to specify MBA
in MBps:

$mount -t resctrl resctrl [-o cdp[,cdpl2][mba_MBps]] /sys/fs/resctrl

Signed-off-by: Vikas Shivappa <vikas.shivappa@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: ravi.v.shankar@intel.com
Cc: tony.luck@intel.com
Cc: fenghua.yu@intel.com
Cc: vikas.shivappa@intel.com
Cc: ak@linux.intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/1524263781-14267-3-git-send-email-vikas.shivappa@linux.intel.com

---
 arch/x86/kernel/cpu/intel_rdt.c          |  8 ++++++++
 arch/x86/kernel/cpu/intel_rdt.h          |  3 +++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 589b948e6e01..53ee6838c496 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
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
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 3fd7a70ee04a..74aee0fdc97c 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -259,6 +259,7 @@ struct rdt_cache {
  * @min_bw:		Minimum memory bandwidth percentage user can request
  * @bw_gran:		Granularity at which the memory bandwidth is allocated
  * @delay_linear:	True if memory B/W delay is in linear scale
+ * @mba_sc:		True if MBA software controller(mba_sc) is enabled
  * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
  */
 struct rdt_membw {
@@ -266,6 +267,7 @@ struct rdt_membw {
 	u32		min_bw;
 	u32		bw_gran;
 	u32		delay_linear;
+	bool		mba_sc;
 	u32		*mb_map;
 };
 
@@ -445,6 +447,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_domain *d,
 void mbm_setup_overflow_handler(struct rdt_domain *dom,
 				unsigned long delay_ms);
 void mbm_handle_overflow(struct work_struct *work);
+bool is_mba_sc(struct rdt_resource *r);
 void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index fca759d272a1..440025446239 100644
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
@@ -1041,6 +1046,25 @@ static int set_cache_qos_cfg(int level, bool enable)
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
+
+	if (!is_mbm_enabled() || !is_mba_linear() ||
+	    mba_sc == is_mba_sc(r))
+		return -EINVAL;
+
+	r->membw.mba_sc = mba_sc;
+
+	return 0;
+}
+
 static int cdp_enable(int level, int data_type, int code_type)
 {
 	struct rdt_resource *r_ldata = &rdt_resources_all[data_type];
@@ -1123,6 +1147,10 @@ static int parse_rdtgroupfs_options(char *data)
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
@@ -1445,6 +1473,8 @@ static void rdt_kill_sb(struct super_block *sb)
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
+	set_mba_sc(false);
+
 	/*Put everything back to default values. */
 	for_each_alloc_enabled_rdt_resource(r)
 		reset_all_ctrls(r);
