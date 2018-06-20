Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35886C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA2B20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA2B20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754089AbeFTAOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:14:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52371 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeFTAOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:14:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0EeXQ3296308
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:14:40 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0Eekk3296305;
        Tue, 19 Jun 2018 17:14:40 -0700
Date:   Tue, 19 Jun 2018 17:14:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-417d29b4daa1a7c9f5fc4f0e8205ea7dbc967054@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        reinette.chatre@intel.com, mingo@kernel.org, hpa@zytor.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
          reinette.chatre@intel.com, mingo@kernel.org
In-Reply-To: <902574465439924850a6e7c4cc06b8a79bd7d2b4.1527593970.git.reinette.chatre@intel.com>
References: <902574465439924850a6e7c4cc06b8a79bd7d2b4.1527593970.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Introduce resource group's mode
 resctrl file
Git-Commit-ID: 417d29b4daa1a7c9f5fc4f0e8205ea7dbc967054
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  417d29b4daa1a7c9f5fc4f0e8205ea7dbc967054
Gitweb:     https://git.kernel.org/tip/417d29b4daa1a7c9f5fc4f0e8205ea7dbc967054
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:57:29 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:28 +0200

x86/intel_rdt: Introduce resource group's mode resctrl file

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
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 83 ++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 70d7846041fe..eac60602c87b 100644
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
