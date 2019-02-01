Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6A8C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78CA20B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfBAHdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:33:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:57767 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728307AbfBAHc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:32:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 23:32:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,547,1539673200"; 
   d="scan'208";a="114430753"
Received: from rajneesh-desk.iind.intel.com ([10.223.86.34])
  by orsmga008.jf.intel.com with ESMTP; 31 Jan 2019 23:32:56 -0800
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Subject: [PATCH 10/10] platform/x86: intel_pmc_core: Quirk to ignore XTAL shutdown
Date:   Fri,  1 Feb 2019 13:02:34 +0530
Message-Id: <20190201073234.13280-11-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201073234.13280-1-rajneesh.bhardwaj@linux.intel.com>
References: <20190201073234.13280-1-rajneesh.bhardwaj@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms such as HP Elite-x2-1013-g3, the platform BIOS
enforces XTAL to remain off before S0ix state can be achieved. This may
not be optimum when we want to enable use cases like Low Power Audio,
Wake on Voice etc which always need 24mhz clock.

This introduces a new quirk to allow S0ix entry when all other
conditions except for XTAL clock are good on a given platform. The extra
power consumed by XTAL clock is about 2mw but it saves much more
platform power compared to the system that remains in just PC10.

Link: https://bit.ly/2UmnrFf
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201579
Tested-by: "David E. Box" <david.e.box@linux.intel.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 34 +++++++++++++++++++++++++++
 drivers/platform/x86/intel_pmc_core.h |  5 ++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 4e7aa1711148..a27574e3e868 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -15,6 +15,7 @@
 #include <linux/bitfield.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -151,6 +152,7 @@ static const struct pmc_reg_map spt_reg_map = {
 	.pm_cfg_offset = SPT_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = SPT_PMC_READ_DISABLE_BIT,
 	.ltr_ignore_max = SPT_NUM_IP_IGN_ALLOWED,
+	.pm_vric1_offset = SPT_PMC_VRIC1_OFFSET,
 };
 
 /* Cannonlake: PGD PFET Enable Ack Status Register(s) bitmap */
@@ -821,6 +823,37 @@ static const struct pci_device_id pmc_pci_ids[] = {
 	{ 0, },
 };
 
+/*
+ * This quirk can be used on those platforms where
+ * the platform BIOS enforces 24Mhx Crystal to shutdown
+ * before PMC can assert SLP_S0#.
+ */
+int quirk_xtal_ignore(const struct dmi_system_id *id)
+{
+	struct pmc_dev *pmcdev = &pmc;
+	u32 value;
+
+	value = pmc_core_reg_read(pmcdev, pmcdev->map->pm_vric1_offset);
+	/* 24MHz Crystal Shutdown Qualification Disable */
+	value |= SPT_PMC_VRIC1_XTALSDQDIS;
+	/* Low Voltage Mode Enable */
+	value &= ~SPT_PMC_VRIC1_SLPS0LVEN;
+	pmc_core_reg_write(pmcdev, pmcdev->map->pm_vric1_offset, value);
+	return 0;
+}
+
+static const struct dmi_system_id pmc_core_dmi_table[]  = {
+	{
+	.callback = quirk_xtal_ignore,
+	.ident = "HP Elite x2 1013 G3",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "HP Elite x2 1013 G3"),
+		},
+	},
+	{}
+};
+
 static int __init pmc_core_probe(void)
 {
 	struct pmc_dev *pmcdev = &pmc;
@@ -862,6 +895,7 @@ static int __init pmc_core_probe(void)
 		return err;
 	}
 
+	dmi_check_system(pmc_core_dmi_table);
 	pr_info(" initialized\n");
 	return 0;
 }
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 6f1b64808075..88d9c0653a5f 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -25,6 +25,7 @@
 #define SPT_PMC_MTPMC_OFFSET			0x20
 #define SPT_PMC_MFPMC_OFFSET			0x38
 #define SPT_PMC_LTR_IGNORE_OFFSET		0x30C
+#define SPT_PMC_VRIC1_OFFSET			0x31c
 #define SPT_PMC_MPHY_CORE_STS_0			0x1143
 #define SPT_PMC_MPHY_CORE_STS_1			0x1142
 #define SPT_PMC_MPHY_COM_STS_0			0x1155
@@ -136,6 +137,9 @@ enum ppfear_regs {
 #define SPT_PMC_BIT_MPHY_CMN_LANE2		BIT(2)
 #define SPT_PMC_BIT_MPHY_CMN_LANE3		BIT(3)
 
+#define SPT_PMC_VRIC1_SLPS0LVEN			BIT(13)
+#define SPT_PMC_VRIC1_XTALSDQDIS		BIT(22)
+
 /* Cannonlake Power Management Controller register offsets */
 #define CNP_PMC_SLPS0_DBG_OFFSET		0x10B4
 #define CNP_PMC_PM_CFG_OFFSET			0x1818
@@ -224,6 +228,7 @@ struct pmc_reg_map {
 	const int pm_read_disable_bit;
 	const u32 slps0_dbg_offset;
 	const u32 ltr_ignore_max;
+	const u32 pm_vric1_offset;
 };
 
 /**
-- 
2.17.1

