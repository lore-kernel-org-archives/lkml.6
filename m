Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421D4C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0889924970
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0889924970
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754829AbeFVWsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:48:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:22310 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754651AbeFVWmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:42:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 15:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="234843389"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2018 15:42:47 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V7 14/41] x86/intel_rdt: Introduce "bit_usage" to display cache allocations details
Date:   Fri, 22 Jun 2018 15:42:05 -0700
Message-Id: <105d44c40e582c2b7e2dccf0ae247e5e61137d4b.1529706536.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 79 ++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index c51d99bfa300..542316dd9ee2 100644
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
-- 
2.17.0

