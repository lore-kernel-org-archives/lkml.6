Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932206AbeDYSMo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:12:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:41709 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755898AbeDYSMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243621"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 04/39] x86/intel_rdt: Introduce resource group's mode resctrl file
Date: Wed, 25 Apr 2018 03:09:40 -0700
Message-Id: <94b17d4be64092ef8ed4cf48df09a47d16e7c044.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new resctrl file "mode" associated with each resource group
is introduced. This file will display the resource group's current mode
and an administrator can also use it to modify the resource group's
mode.

Only shareable mode is currently supported.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

fixme: merge with Introduce new mode file
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 83 ++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 4683fe2b2118..bc5f98154177 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -147,6 +147,24 @@ enum rdtgrp_mode rdtgroup_mode_by_closid(int closid)
 	return RDT_NUM_MODES;
 }
 
+static const char * const rdt_mode_str[] = {
+	[RDT_MODE_SHAREABLE]	= "shareable",
+};
+
+/**
+ * rdtgroup_mode_str - Return the string representation of mode
+ * @mode: the resource group mode as &enum rdtgroup_mode
+ *
+ * Return: string representation of valid mode, "unknown" otherwise
+ */
+static const char *rdtgroup_mode_str(enum rdtgrp_mode mode)
+{
+	if (mode < RDT_MODE_SHAREABLE || mode >= RDT_NUM_MODES)
+		return "unknown";
+
+	return rdt_mode_str[mode];
+}
+
 /* set uid and gid of rdtgroup dirs and files to that of the creator */
 static int rdtgroup_kn_set_ugid(struct kernfs_node *kn)
 {
@@ -761,6 +779,63 @@ static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+/*
+ * rdtgroup_mode_show - Display mode of this resource group
+ */
+static int rdtgroup_mode_show(struct kernfs_open_file *of,
+			      struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
+
+	seq_printf(s, "%s\n", rdtgroup_mode_str(rdtgrp->mode));
+
+	rdtgroup_kn_unlock(of->kn);
+	return 0;
+}
+
+static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
+				   char *buf, size_t nbytes, loff_t off)
+{
+	struct rdtgroup *rdtgrp;
+	enum rdtgrp_mode mode;
+	int ret = 0;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+	buf[nbytes - 1] = '\0';
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
+
+	rdt_last_cmd_clear();
+
+	mode = rdtgrp->mode;
+
+	if ((!strcmp(buf, "shareable") && mode == RDT_MODE_SHAREABLE))
+		goto out;
+
+	if (!strcmp(buf, "shareable")) {
+		rdtgrp->mode = RDT_MODE_SHAREABLE;
+	} else {
+		rdt_last_cmd_printf("unknown/unsupported mode\n");
+		ret = -EINVAL;
+	}
+
+out:
+	rdtgroup_kn_unlock(of->kn);
+	return ret ?: nbytes;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -874,6 +949,14 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_schemata_show,
 		.fflags		= RF_CTRL_BASE,
 	},
+	{
+		.name		= "mode",
+		.mode		= 0644,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.write		= rdtgroup_mode_write,
+		.seq_show	= rdtgroup_mode_show,
+		.fflags		= RF_CTRL_BASE,
+	},
 };
 
 static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
-- 
2.13.6
