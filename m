Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D79DC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C09E249B2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C09E249B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933993AbeFVWuk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:50:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:52517 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933467AbeFVWmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:42:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 15:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="234843361"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2018 15:42:47 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V7 05/41] x86/intel_rdt: Introduce resource group's mode resctrl file
Date:   Fri, 22 Jun 2018 15:41:56 -0700
Message-Id: <20ab78fda26a8c8d98e18ec555f6a1f728948972.1529706536.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new resctrl file "mode" associated with each resource group is
introduced. This file will display the resource group's current mode and an
administrator can also use it to modify the resource group's mode.

Only shareable mode is currently supported.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/902574465439924850a6e7c4cc06b8a79bd7d2b4.1527593970.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 83 ++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 51e99d1b1caa..e161e52aed3b 100644
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
2.17.0

