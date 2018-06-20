Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B42C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DC620693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DC620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754206AbeFTATi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:19:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32927 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbeFTATe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:19:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0JTqi3297109
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:19:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0JTAl3297106;
        Tue, 19 Jun 2018 17:19:29 -0700
Date:   Tue, 19 Jun 2018 17:19:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-0a1ad189dfd4680e7c05273f43d39623b6bc4c66@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        reinette.chatre@intel.com, hpa@zytor.com
Reply-To: reinette.chatre@intel.com, mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <0108de9c39225ff2e8359115f9283c4e410510de.1527593970.git.reinette.chatre@intel.com>
References: <0108de9c39225ff2e8359115f9283c4e410510de.1527593970.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Introduce "bit_usage" to display
 cache allocations details
Git-Commit-ID: 0a1ad189dfd4680e7c05273f43d39623b6bc4c66
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

Commit-ID:  0a1ad189dfd4680e7c05273f43d39623b6bc4c66
Gitweb:     https://git.kernel.org/tip/0a1ad189dfd4680e7c05273f43d39623b6bc4c66
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:57:38 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:31 +0200

x86/intel_rdt: Introduce "bit_usage" to display cache allocations details

With cache regions now explicitly marked as "shareable" or "exclusive"
we would like to communicate to the user how portions of the cache
are used.

Introduce "bit_usage" that indicates for each resource
how portions of the cache are configured to be used.

To assist the user to distinguish whether the sharing is from software or
hardware we add the following annotation:

0 - currently unused
X - currently available for sharing and used by software and hardware
H - currently used by hardware only but available for software use
S - currently used and shareable by software only
E - currently used exclusively by one resource group

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/0108de9c39225ff2e8359115f9283c4e410510de.1527593970.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 79 ++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 4574bb1cbd94..833bfce9146c 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -714,6 +714,78 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+/**
+ * rdt_bit_usage_show - Display current usage of resources
+ *
+ * A domain is a shared resource that can now be allocated differently. Here
+ * we display the current regions of the domain as an annotated bitmask.
+ * For each domain of this resource its allocation bitmask
+ * is annotated as below to indicate the current usage of the corresponding bit:
+ *   0 - currently unused
+ *   X - currently available for sharing and used by software and hardware
+ *   H - currently used by hardware only but available for software use
+ *   S - currently used and shareable by software only
+ *   E - currently used exclusively by one resource group
+ */
+static int rdt_bit_usage_show(struct kernfs_open_file *of,
+			      struct seq_file *seq, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	u32 sw_shareable, hw_shareable, exclusive;
+	struct rdt_domain *dom;
+	int i, hwb, swb, excl;
+	enum rdtgrp_mode mode;
+	bool sep = false;
+	u32 *ctrl;
+
+	mutex_lock(&rdtgroup_mutex);
+	hw_shareable = r->cache.shareable_bits;
+	list_for_each_entry(dom, &r->domains, list) {
+		if (sep)
+			seq_putc(seq, ';');
+		ctrl = dom->ctrl_val;
+		sw_shareable = 0;
+		exclusive = 0;
+		seq_printf(seq, "%d=", dom->id);
+		for (i = 0; i < r->num_closid; i++, ctrl++) {
+			if (!closid_allocated(i))
+				continue;
+			mode = rdtgroup_mode_by_closid(i);
+			switch (mode) {
+			case RDT_MODE_SHAREABLE:
+				sw_shareable |= *ctrl;
+				break;
+			case RDT_MODE_EXCLUSIVE:
+				exclusive |= *ctrl;
+				break;
+			case RDT_NUM_MODES:
+				WARN(1,
+				     "invalid mode for closid %d\n", i);
+				break;
+			}
+		}
+		for (i = r->cache.cbm_len - 1; i >= 0; i--) {
+			hwb = test_bit(i, (unsigned long *)&hw_shareable);
+			swb = test_bit(i, (unsigned long *)&sw_shareable);
+			excl = test_bit(i, (unsigned long *)&exclusive);
+			if (hwb && swb)
+				seq_putc(seq, 'X');
+			else if (hwb && !swb)
+				seq_putc(seq, 'H');
+			else if (!hwb && swb)
+				seq_putc(seq, 'S');
+			else if (excl)
+				seq_putc(seq, 'E');
+			else /* Unused bits remain */
+				seq_putc(seq, '0');
+		}
+		sep = true;
+	}
+	seq_putc(seq, '\n');
+	mutex_unlock(&rdtgroup_mutex);
+	return 0;
+}
+
 static int rdt_min_bw_show(struct kernfs_open_file *of,
 			     struct seq_file *seq, void *v)
 {
@@ -995,6 +1067,13 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdt_shareable_bits_show,
 		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
+	{
+		.name		= "bit_usage",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdt_bit_usage_show,
+		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
+	},
 	{
 		.name		= "min_bandwidth",
 		.mode		= 0444,
