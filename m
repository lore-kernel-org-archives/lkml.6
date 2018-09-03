Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44666C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A7920843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A7920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeICW0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:26:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:31017 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727356AbeICW0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:26:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 11:04:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,326,1531810800"; 
   d="scan'208";a="88629480"
Received: from rajneesh-desk.iind.intel.com ([10.223.86.34])
  by orsmga002.jf.intel.com with ESMTP; 03 Sep 2018 11:04:53 -0700
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org, rajneesh.bhardwaj@intel.com,
        souvik.k.chakravarty@intel.com,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Subject: [PATCH 1/4] platform/x86: intel_pmc_core: Show Latency Tolerance info
Date:   Mon,  3 Sep 2018 23:34:12 +0530
Message-Id: <20180903180415.31575-1-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support to show the Latency Tolerance Reporting for the IPs on
the PCH as reported by the PMC. The format shown here is raw LTR data
payload that can further be decoded as per the PCI specification.

This also fixes some minor alignment issues in the header file by
removing spaces and converting to tabs at some places.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 75 +++++++++++++++++++++++++++
 drivers/platform/x86/intel_pmc_core.h | 55 +++++++++++++++++---
 2 files changed, 123 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 2d272a3e0176..972735bd4c75 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -110,10 +110,38 @@ static const struct pmc_bit_map spt_pfear_map[] = {
 	{},
 };
 
+static const struct pmc_bit_map spt_ltr_show_map[] = {
+	{"IP 0	: LTR_SOUTHPORT_A",		SPT_PMC_LTR_SPA},
+	{"IP 1	: LTR_SOUTHPORT_B",		SPT_PMC_LTR_SPB},
+	{"IP 2	: LTR_SATA",			SPT_PMC_LTR_SATA},
+	{"IP 3	: LTR_GIGABIT_ETHERNET",	SPT_PMC_LTR_GBE},
+	{"IP 4	: LTR_XHCI",			SPT_PMC_LTR_XHCI},
+	/* IP 5 is reserved */
+	{"IP 6	: LTR_ME",			SPT_PMC_LTR_ME},
+	/* EVA is Enterprise Value Add, doesn't really exist on PCH */
+	{"IP 7	: LTR_EVA",			SPT_PMC_LTR_EVA},
+	{"IP 8	: LTR_SOUTHPORT_C",		SPT_PMC_LTR_SPC},
+	{"IP 9	: LTR_HD_AUDIO",		SPT_PMC_LTR_AZ},
+	/* IP 10 is reserved */
+	{"IP 11	: LTR_LPSS",			SPT_PMC_LTR_LPSS},
+	{"IP 12	: LTR_SOUTHPORT_D",		SPT_PMC_LTR_SPD},
+	{"IP 13	: LTR_SOUTHPORT_E",		SPT_PMC_LTR_SPE},
+	{"IP 14	: LTR_CAMERA",			SPT_PMC_LTR_CAM},
+	{"IP 15	: LTR_ESPI",			SPT_PMC_LTR_ESPI},
+	{"IP 16	: LTR_SCC",			SPT_PMC_LTR_SCC},
+	{"IP 17	: LTR_ISH",			SPT_PMC_LTR_ISH},
+	/* Below two cannot be for LTR_IGNORE */
+	{"LTR_CURRENT_PLATFORM",		SPT_PMC_LTR_CUR_PLT},
+	{"LTR_AGGREGATED_SYSTEM",		SPT_PMC_LTR_CUR_ASLT},
+	{},
+
+};
+
 static const struct pmc_reg_map spt_reg_map = {
 	.pfear_sts = spt_pfear_map,
 	.mphy_sts = spt_mphy_map,
 	.pll_sts = spt_pll_map,
+	.ltr_show_sts = spt_ltr_show_map,
 	.slp_s0_offset = SPT_PMC_SLP_S0_RES_COUNTER_OFFSET,
 	.ltr_ignore_offset = SPT_PMC_LTR_IGNORE_OFFSET,
 	.regmap_length = SPT_PMC_MMIO_REG_LEN,
@@ -252,10 +280,39 @@ static const struct pmc_bit_map *cnp_slps0_dbg_maps[] = {
 	NULL,
 };
 
+static const struct pmc_bit_map cnp_ltr_show_map[] = {
+	{"IP 0	: LTR_SOUTHPORT_A",		CNP_PMC_LTR_SPA},
+	{"IP 1	: LTR_SOUTHPORT_B",		CNP_PMC_LTR_SPB},
+	{"IP 2	: LTR_SATA",			CNP_PMC_LTR_SATA},
+	{"IP 3	: LTR_GIGABIT_ETHERNET",	CNP_PMC_LTR_GBE},
+	{"IP 4	: LTR_XHCI",			CNP_PMC_LTR_XHCI},
+	/* IP 5 is reserved */
+	{"IP 6	: LTR_ME",			CNP_PMC_LTR_ME},
+	/* EVA is Enterprise Value Add, doesn't really exist on PCH */
+	{"IP 7	: LTR_EVA",			CNP_PMC_LTR_EVA},
+	{"IP 8	: LTR_SOUTHPORT_C",		CNP_PMC_LTR_SPC},
+	{"IP 9	: LTR_HD_AUDIO",		CNP_PMC_LTR_AZ},
+	{"IP 10	: LTR_CNV",			CNP_PMC_LTR_CNV},
+	{"IP 11	: LTR_LPSS",			CNP_PMC_LTR_LPSS},
+	{"IP 12	: LTR_SOUTHPORT_D",		CNP_PMC_LTR_SPD},
+	{"IP 13	: LTR_SOUTHPORT_E",		CNP_PMC_LTR_SPE},
+	{"IP 14	: LTR_CAMERA",			CNP_PMC_LTR_CAM},
+	{"IP 15	: LTR_ESPI",			CNP_PMC_LTR_ESPI},
+	{"IP 16	: LTR_SCC",			CNP_PMC_LTR_SCC},
+	{"IP 17	: LTR_ISH",			CNP_PMC_LTR_ISH},
+	{"IP 18	: LTR_UFSX2",			CNP_PMC_LTR_UFSX2},
+	{"IP 19	: LTR_EMMC",			CNP_PMC_LTR_EMMC},
+	{"LTR_CURRENT_PLATFORM",		CNP_PMC_LTR_CUR_PLT},
+	{"LTR_AGGREGATED_SYSTEM",		CNP_PMC_LTR_CUR_ASLT},
+	{},
+
+};
+
 static const struct pmc_reg_map cnp_reg_map = {
 	.pfear_sts = cnp_pfear_map,
 	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
 	.slps0_dbg_maps = cnp_slps0_dbg_maps,
+	.ltr_show_sts = cnp_ltr_show_map,
 	.slps0_dbg_offset = CNP_PMC_SLPS0_DBG_OFFSET,
 	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
 	.regmap_length = CNP_PMC_MMIO_REG_LEN,
@@ -592,6 +649,21 @@ static int pmc_core_slps0_dbg_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_slps0_dbg);
 
+static int pmc_core_ltr_show(struct seq_file *s, void *unused)
+{
+	struct pmc_dev *pmcdev = s->private;
+	const struct pmc_bit_map *map = pmcdev->map->ltr_show_sts;
+	int index;
+
+	for (index = 0; map[index].name ; index++) {
+		seq_printf(s, "%-32s\tRAW LTR: 0x%x\n",
+			   map[index].name,
+			   pmc_core_reg_read(pmcdev, map[index].bit_mask));
+	}
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(pmc_core_ltr);
+
 static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
 {
 	debugfs_remove_recursive(pmcdev->dbgfs_dir);
@@ -616,6 +688,9 @@ static int pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 	debugfs_create_file("ltr_ignore", 0644, dir, pmcdev,
 			    &pmc_core_ltr_ignore_ops);
 
+	debugfs_create_file("ltr_show", 0644, dir, pmcdev,
+			    &pmc_core_ltr_fops);
+
 	if (pmcdev->map->pll_sts)
 		debugfs_create_file("pll_status", 0444, dir, pmcdev,
 				    &pmc_core_pll_ops);
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 93a7e99e1f8b..b24407048fa1 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -45,6 +45,24 @@
 #define SPT_PMC_MSG_FULL_STS_BIT		0x18
 #define NUM_RETRIES				100
 #define NUM_IP_IGN_ALLOWED			17
+#define SPT_PMC_LTR_CUR_PLT			0x350
+#define SPT_PMC_LTR_CUR_ASLT			0x354
+#define SPT_PMC_LTR_SPA				0x360
+#define SPT_PMC_LTR_SPB				0x364
+#define SPT_PMC_LTR_SATA			0x368
+#define SPT_PMC_LTR_GBE				0x36C
+#define SPT_PMC_LTR_XHCI			0x370
+#define SPT_PMC_LTR_ME				0x378
+#define SPT_PMC_LTR_EVA				0x37C
+#define SPT_PMC_LTR_SPC				0x380
+#define SPT_PMC_LTR_AZ				0x384
+#define SPT_PMC_LTR_LPSS			0x38C
+#define SPT_PMC_LTR_CAM				0x390
+#define SPT_PMC_LTR_SPD				0x394
+#define SPT_PMC_LTR_SPE				0x398
+#define SPT_PMC_LTR_ESPI			0x39C
+#define SPT_PMC_LTR_SCC				0x3A0
+#define SPT_PMC_LTR_ISH				0x3A4
 
 /* Sunrise Point: PGD PFET Enable Ack Status Registers */
 enum ppfear_regs {
@@ -124,17 +142,38 @@ enum ppfear_regs {
 #define SPT_PMC_BIT_MPHY_CMN_LANE3		BIT(3)
 
 /* Cannonlake Power Management Controller register offsets */
-#define CNP_PMC_SLP_S0_RES_COUNTER_OFFSET      0x193C
-#define CNP_PMC_LTR_IGNORE_OFFSET              0x1B0C
-#define CNP_PMC_PM_CFG_OFFSET                  0x1818
+#define CNP_PMC_SLP_S0_RES_COUNTER_OFFSET	0x193C
+#define CNP_PMC_LTR_IGNORE_OFFSET		0x1B0C
+#define CNP_PMC_PM_CFG_OFFSET			0x1818
 #define CNP_PMC_SLPS0_DBG_OFFSET		0x10B4
 /* Cannonlake: PGD PFET Enable Ack Status Register(s) start */
-#define CNP_PMC_HOST_PPFEAR0A                  0x1D90
+#define CNP_PMC_HOST_PPFEAR0A			0x1D90
 
-#define CNP_PMC_MMIO_REG_LEN                   0x2000
-#define CNP_PPFEAR_NUM_ENTRIES                 8
-#define CNP_PMC_READ_DISABLE_BIT               22
+#define CNP_PMC_MMIO_REG_LEN			0x2000
+#define CNP_PPFEAR_NUM_ENTRIES			8
+#define CNP_PMC_READ_DISABLE_BIT		22
 #define CNP_PMC_LATCH_SLPS0_EVENTS		BIT(31)
+#define CNP_PMC_LTR_CUR_PLT			0x1B50
+#define CNP_PMC_LTR_CUR_ASLT			0x1B54
+#define CNP_PMC_LTR_SPA				0x1B60
+#define CNP_PMC_LTR_SPB				0x1B64
+#define CNP_PMC_LTR_SATA			0x1B68
+#define CNP_PMC_LTR_GBE				0x1B6C
+#define CNP_PMC_LTR_XHCI			0x1B70
+#define CNP_PMC_LTR_ME				0x1B78
+#define CNP_PMC_LTR_EVA				0x1B7C
+#define CNP_PMC_LTR_SPC				0x1B80
+#define CNP_PMC_LTR_AZ				0x1B84
+#define CNP_PMC_LTR_LPSS			0x1B8C
+#define CNP_PMC_LTR_CAM				0x1B90
+#define CNP_PMC_LTR_SPD				0x1B94
+#define CNP_PMC_LTR_SPE				0x1B98
+#define CNP_PMC_LTR_ESPI			0x1B9C
+#define CNP_PMC_LTR_SCC				0x1BA0
+#define CNP_PMC_LTR_ISH				0x1BA4
+#define CNP_PMC_LTR_CNV				0x1BF0
+#define CNP_PMC_LTR_EMMC			0x1BF4
+#define CNP_PMC_LTR_UFSX2			0x1BF8
 
 struct pmc_bit_map {
 	const char *name;
@@ -148,6 +187,7 @@ struct pmc_bit_map {
  * @mphy_sts:		Maps name of MPHY lane to MPHY status lane status bit
  * @pll_sts:		Maps name of PLL to corresponding bit status
  * @slps0_dbg_maps:	Array of SLP_S0_DBG* registers containing debug info
+ * @ltr_show_sts:	Maps PCH IP Names to their MMIO register offsets
  * @slp_s0_offset:	PWRMBASE offset to read SLP_S0 residency
  * @ltr_ignore_offset:	PWRMBASE offset to read/write LTR ignore bit
  * @regmap_length:	Length of memory to map from PWRMBASE address to access
@@ -166,6 +206,7 @@ struct pmc_reg_map {
 	const struct pmc_bit_map *mphy_sts;
 	const struct pmc_bit_map *pll_sts;
 	const struct pmc_bit_map **slps0_dbg_maps;
+	const struct pmc_bit_map *ltr_show_sts;
 	const u32 slp_s0_offset;
 	const u32 ltr_ignore_offset;
 	const int regmap_length;
-- 
2.17.1

