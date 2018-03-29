Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeC2W3Y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:29:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:60714 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751215AbeC2W3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:29:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,378,1517904000";
   d="scan'208";a="28690093"
From: Vikas Shivappa <vikas.shivappa@linux.intel.com>
To: vikas.shivappa@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com,
        sai.praneeth.prakhya@intel.com, x86@kernel.org, tglx@linutronix.de,
        hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, ak@linux.intel.com,
        vikas.shivappa@linux.intel.com
Subject: [PATCH 2/6] x86/intel_rdt/mba_sc: Add support to enable/disable via mount option
Date: Thu, 29 Mar 2018 15:26:12 -0700
Message-Id: <1522362376-3505-3-git-send-email-vikas.shivappa@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com>
References: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify a new mount option "mba_MB" to enable the user to specify MBA
bandwidth in Megabytes(Software Controller/SC) instead of b/w
percentage:

$mount -t resctrl resctrl [-o cdp[,cdpl2][mba_MB]] /sys/fs/resctrl

Signed-off-by: Vikas Shivappa <vikas.shivappa@linux.intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h          |  5 +++++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 31 +++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 3fd7a70..3e9bc3f 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -259,6 +259,7 @@ struct rdt_cache {
  * @min_bw:		Minimum memory bandwidth percentage user can request
  * @bw_gran:		Granularity at which the memory bandwidth is allocated
  * @delay_linear:	True if memory B/W delay is in linear scale
+ * @bw_byte:		True if memory B/W is specified in bytes
  * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
  */
 struct rdt_membw {
@@ -266,6 +267,7 @@ struct rdt_membw {
 	u32		min_bw;
 	u32		bw_gran;
 	u32		delay_linear;
+	bool		bw_byte;
 	u32		*mb_map;
 };
 
@@ -295,6 +297,9 @@ static inline bool is_mbm_event(int e)
 		e <= QOS_L3_MBM_LOCAL_EVENT_ID);
 }
 
+#define is_mba_linear() rdt_resources_all[RDT_RESOURCE_MBA].membw.delay_linear
+#define is_mba_MBctrl() rdt_resources_all[RDT_RESOURCE_MBA].membw.bw_byte
+
 /**
  * struct rdt_resource - attributes of an RDT resource
  * @rid:		The index of the resource
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index fca759d..0707191 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1041,6 +1041,24 @@ static int set_cache_qos_cfg(int level, bool enable)
 	return 0;
 }
 
+static void __set_mba_byte_ctrl(bool byte_ctrl)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA];
+
+	r->membw.bw_byte = byte_ctrl;
+}
+
+/*
+ * MBA allocation in bytes is only supported if
+ * MBM is supported and MBA is in linear scale.
+*/
+static void set_mba_byte_ctrl(bool byte_ctrl)
+{
+	if ((is_mbm_enabled() && is_mba_linear()) &&
+	    byte_ctrl != is_mba_MBctrl())
+		__set_mba_byte_ctrl(byte_ctrl);
+}
+
 static int cdp_enable(int level, int data_type, int code_type)
 {
 	struct rdt_resource *r_ldata = &rdt_resources_all[data_type];
@@ -1104,7 +1122,7 @@ static void cdp_disable_all(void)
 		cdpl2_disable();
 }
 
-static int parse_rdtgroupfs_options(char *data)
+static int parse_rdtgroupfs_options(char *data, bool *mba_MBctrl)
 {
 	char *token, *o = data;
 	int ret = 0;
@@ -1123,6 +1141,8 @@ static int parse_rdtgroupfs_options(char *data)
 			ret = cdpl2_enable();
 			if (ret)
 				goto out;
+		} else if (!strcmp(token, "mba_MB")) {
+			*mba_MBctrl = true;
 		} else {
 			ret = -EINVAL;
 			goto out;
@@ -1209,6 +1229,7 @@ static struct dentry *rdt_mount(struct file_system_type *fs_type,
 				int flags, const char *unused_dev_name,
 				void *data)
 {
+	bool mba_MBctrl = false;
 	struct rdt_domain *dom;
 	struct rdt_resource *r;
 	struct dentry *dentry;
@@ -1224,7 +1245,7 @@ static struct dentry *rdt_mount(struct file_system_type *fs_type,
 		goto out;
 	}
 
-	ret = parse_rdtgroupfs_options(data);
+	ret = parse_rdtgroupfs_options(data, &mba_MBctrl);
 	if (ret) {
 		dentry = ERR_PTR(ret);
 		goto out_cdp;
@@ -1277,6 +1298,9 @@ static struct dentry *rdt_mount(struct file_system_type *fs_type,
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
 	}
 
+	if (mba_MBctrl)
+		set_mba_byte_ctrl(true);
+
 	goto out;
 
 out_mondata:
@@ -1445,6 +1469,9 @@ static void rdt_kill_sb(struct super_block *sb)
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
+	/*Set the control values before the rest of reset*/
+	set_mba_byte_ctrl(false);
+
 	/*Put everything back to default values. */
 	for_each_alloc_enabled_rdt_resource(r)
 		reset_all_ctrls(r);
-- 
1.9.1
