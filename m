Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5F2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B24E20700
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfBNL5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:57:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:51463 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406900AbfBNL5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:57:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 03:57:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,368,1544515200"; 
   d="scan'208";a="122400554"
Received: from rajneesh-desk.iind.intel.com ([10.223.86.34])
  by fmsmga007.fm.intel.com with ESMTP; 14 Feb 2019 03:57:03 -0800
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "David E. Box" <david.e.box@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 4/5] platform/x86: intel_pmc_core: Add Package cstates residency info
Date:   Thu, 14 Feb 2019 17:27:11 +0530
Message-Id: <20190214115712.19642-5-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214115712.19642-1-rajneesh.bhardwaj@linux.intel.com>
References: <20190214115712.19642-1-rajneesh.bhardwaj@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a new debugfs entry to read current Package
cstate residency counters. A similar variant of this patch was discussed
earlier "https://patchwork.kernel.org/patch/9908563/" but didn't make it
into mainline for various reasons. Current version only adds debugfs
entry which is quite useful for S0ix debug but excludes the exported API
that was there in initial version. Though there are tools like turbostat
and socwatch which can also show this info but sometimes its more
practical to have it here as it's hard to switch between various tools for
S0ix debug when pmc_core driver is the primary debug tool. Internal and
external customers have requested for this patch to be included in the
PMC driver on many occasions and Google Chrome OS team has already included
it in their builds. This becomes handy when requesting logs from external
customers who may not always have above mentioned tools in their integrated
kernel builds.

Package cstate residency MSRs provide useful debug information about
system idle states. In idle states system must enter deeper Package
cstates. Package cstates depend not only on Core cstates but also on
various IP block's power gating status and LTR values.

For Intel Core SoCs Package C10 entry is a must for deeper sleep states
such as S0ix. "Suspend-to-idle"  should ideally take this path:
PC0 -> PC10 -> S0ix. For S0ix debug, its logical to check for
Package C10 residency first if for some reason system fails to enter S0ix.

Please refer to this link for MSR details:
https://software.intel.com/sites/default/files/managed/22/0d/335592-sdm-vol-4.pdf

Usage:
cat /sys/kernel/debug/pmc_core/package_cstate_show
Package C2       : 0xec2e21735f
Package C3       : 0xc30113ba4
Package C6       : 0x9ef4be15c5
Package C7       : 0x1e011904
Package C8       : 0x3c5653cfe5a
Package C9       : 0x0
Package C10      : 0x16fff4289

Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: "David E. Box" <david.e.box@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Anshuman Gupta <anshuman.gupta@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-and-tested-by: Anshuman Gupta <anshuman.gupta@intel.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 38 +++++++++++++++++++++++++++
 drivers/platform/x86/intel_pmc_core.h |  1 +
 2 files changed, 39 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 400946b7a3b5..4e7aa1711148 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -22,11 +22,24 @@
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
+#include <asm/msr.h>
 
 #include "intel_pmc_core.h"
 
 static struct pmc_dev pmc;
 
+/* PKGC MSRs are common across Intel Core SoCs */
+static const struct pmc_bit_map msr_map[] = {
+	{"Package C2",                  MSR_PKG_C2_RESIDENCY},
+	{"Package C3",                  MSR_PKG_C3_RESIDENCY},
+	{"Package C6",                  MSR_PKG_C6_RESIDENCY},
+	{"Package C7",                  MSR_PKG_C7_RESIDENCY},
+	{"Package C8",                  MSR_PKG_C8_RESIDENCY},
+	{"Package C9",                  MSR_PKG_C9_RESIDENCY},
+	{"Package C10",                 MSR_PKG_C10_RESIDENCY},
+	{}
+};
+
 static const struct pmc_bit_map spt_pll_map[] = {
 	{"MIPI PLL",			SPT_PMC_BIT_MPHY_CMN_LANE0},
 	{"GEN2 USB2PCIE2 PLL",		SPT_PMC_BIT_MPHY_CMN_LANE1},
@@ -129,6 +142,7 @@ static const struct pmc_reg_map spt_reg_map = {
 	.mphy_sts = spt_mphy_map,
 	.pll_sts = spt_pll_map,
 	.ltr_show_sts = spt_ltr_show_map,
+	.msr_sts = msr_map,
 	.slp_s0_offset = SPT_PMC_SLP_S0_RES_COUNTER_OFFSET,
 	.ltr_ignore_offset = SPT_PMC_LTR_IGNORE_OFFSET,
 	.regmap_length = SPT_PMC_MMIO_REG_LEN,
@@ -318,6 +332,7 @@ static const struct pmc_reg_map cnp_reg_map = {
 	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
 	.slps0_dbg_maps = cnp_slps0_dbg_maps,
 	.ltr_show_sts = cnp_ltr_show_map,
+	.msr_sts = msr_map,
 	.slps0_dbg_offset = CNP_PMC_SLPS0_DBG_OFFSET,
 	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
 	.regmap_length = CNP_PMC_MMIO_REG_LEN,
@@ -333,6 +348,7 @@ static const struct pmc_reg_map icl_reg_map = {
 	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
 	.slps0_dbg_maps = cnp_slps0_dbg_maps,
 	.ltr_show_sts = cnp_ltr_show_map,
+	.msr_sts = msr_map,
 	.slps0_dbg_offset = CNP_PMC_SLPS0_DBG_OFFSET,
 	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
 	.regmap_length = CNP_PMC_MMIO_REG_LEN,
@@ -709,6 +725,25 @@ static int pmc_core_ltr_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_ltr);
 
+static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
+{
+	struct pmc_dev *pmcdev = s->private;
+	const struct pmc_bit_map *map = pmcdev->map->msr_sts;
+	u64 pcstate_count;
+	int index;
+
+	for (index = 0; map[index].name ; index++) {
+		if (rdmsrl_safe(map[index].bit_mask, &pcstate_count))
+			continue;
+
+		seq_printf(s, "%-8s : 0x%llx\n", map[index].name,
+			   pcstate_count);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc);
+
 static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
 {
 	debugfs_remove_recursive(pmcdev->dbgfs_dir);
@@ -735,6 +770,9 @@ static int pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 
 	debugfs_create_file("ltr_show", 0444, dir, pmcdev, &pmc_core_ltr_fops);
 
+	debugfs_create_file("package_cstate_show", 0444, dir, pmcdev,
+			    &pmc_core_pkgc_fops);
+
 	if (pmcdev->map->pll_sts)
 		debugfs_create_file("pll_status", 0444, dir, pmcdev,
 				    &pmc_core_pll_fops);
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 78dd4229489d..6f1b64808075 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -214,6 +214,7 @@ struct pmc_reg_map {
 	const struct pmc_bit_map *pll_sts;
 	const struct pmc_bit_map **slps0_dbg_maps;
 	const struct pmc_bit_map *ltr_show_sts;
+	const struct pmc_bit_map *msr_sts;
 	const u32 slp_s0_offset;
 	const u32 ltr_ignore_offset;
 	const int regmap_length;
-- 
2.17.1

