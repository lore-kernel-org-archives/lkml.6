Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeBBNtr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:49:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:38331 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752000AbeBBNtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:49:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,448,1511856000";
   d="scan'208";a="14968350"
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
To: platform-driver-x86@vger.kernel.org
Cc: dvhart@infradead.org, andy@infradead.org, linux-kernel@vger.kernel.org,
        vishwanath.somayaji@intel.com, srinivas.pandruvada@linux.intel.com,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Subject: [Patch v2 4/5] platform/x86: intel_pmc_core: Add CannonLake PCH support
Date: Fri,  2 Feb 2018 19:13:36 +0530
Message-Id: <1517579017-19935-5-git-send-email-rajneesh.bhardwaj@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517579017-19935-1-git-send-email-rajneesh.bhardwaj@intel.com>
References: <1517579017-19935-1-git-send-email-rajneesh.bhardwaj@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for Cannonlake PCH which is used by Cannonlake and
Coffeelake SoCs.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 85 +++++++++++++++++++++++++++++++++++
 drivers/platform/x86/intel_pmc_core.h | 11 +++++
 2 files changed, 96 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index bb80aed4c3c1..a255c4b0f7a8 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -122,6 +122,90 @@ static const struct pmc_reg_map spt_reg_map = {
 	.pm_read_disable_bit = SPT_PMC_READ_DISABLE_BIT,
 };
 
+/* Cannonlake: PGD PFET Enable Ack Status Register(s) bitmap */
+static const struct pmc_bit_map cnp_pfear_map[] = {
+	{"PMC",                 BIT(0)},
+	{"OPI-DMI",             BIT(1)},
+	{"SPI/eSPI",            BIT(2)},
+	{"XHCI",                BIT(3)},
+	{"SPA",                 BIT(4)},
+	{"SPB",                 BIT(5)},
+	{"SPC",                 BIT(6)},
+	{"GBE",                 BIT(7)},
+
+	{"SATA",                BIT(0)},
+	{"HDA_PGD0",            BIT(1)},
+	{"HDA_PGD1",            BIT(2)},
+	{"HDA_PGD2",            BIT(3)},
+	{"HDA_PGD3",            BIT(4)},
+	{"SPD",                 BIT(5)},
+	{"LPSS",                BIT(6)},
+	{"LPC",                 BIT(7)},
+
+	{"SMB",                 BIT(0)},
+	{"ISH",                 BIT(1)},
+	{"P2SB",                BIT(2)},
+	{"NPK_VNN",             BIT(3)},
+	{"SDX",                 BIT(4)},
+	{"SPE",                 BIT(5)},
+	{"Fuse",                BIT(6)},
+	{"Res_23",              BIT(7)},
+
+	{"CSME_FSC",            BIT(0)},
+	{"USB3_OTG",            BIT(1)},
+	{"EXI",                 BIT(2)},
+	{"CSE",                 BIT(3)},
+	{"csme_kvm",            BIT(4)},
+	{"csme_pmt",            BIT(5)},
+	{"csme_clink",          BIT(6)},
+	{"csme_ptio",           BIT(7)},
+
+	{"csme_usbr",           BIT(0)},
+	{"csme_susram",         BIT(1)},
+	{"csme_smt1",           BIT(2)},
+	{"CSME_SMT4",           BIT(3)},
+	{"csme_sms2",           BIT(4)},
+	{"csme_sms1",           BIT(5)},
+	{"csme_rtc",            BIT(6)},
+	{"csme_psf",            BIT(7)},
+
+	{"SBR0",                BIT(0)},
+	{"SBR1",                BIT(1)},
+	{"SBR2",                BIT(2)},
+	{"SBR3",                BIT(3)},
+	{"SBR4",                BIT(4)},
+	{"SBR5",                BIT(5)},
+	{"CSME_PECI",           BIT(6)},
+	{"PSF1",                BIT(7)},
+
+	{"PSF2",                BIT(0)},
+	{"PSF3",                BIT(1)},
+	{"PSF4",                BIT(2)},
+	{"CNVI",                BIT(3)},
+	{"UFS0",                BIT(4)},
+	{"EMMC",                BIT(5)},
+	{"Res_6",               BIT(6)},
+	{"SBR6",                BIT(7)},
+
+	{"SBR7",                BIT(0)},
+	{"NPK_AON",             BIT(1)},
+	{"HDA_PGD4",            BIT(2)},
+	{"HDA_PGD5",            BIT(3)},
+	{"HDA_PGD6",            BIT(4)},
+	{}
+};
+
+static const struct pmc_reg_map cnp_reg_map = {
+	.pfear_sts = cnp_pfear_map,
+	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
+	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
+	.regmap_length = CNP_PMC_MMIO_REG_LEN,
+	.ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
+	.ppfear_buckets = CNP_PPFEAR_NUM_ENTRIES,
+	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
+	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+};
+
 static inline u8 pmc_core_reg_read_byte(struct pmc_dev *pmcdev, int offset)
 {
 	return readb(pmcdev->regbase + offset);
@@ -447,6 +531,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP, &spt_reg_map),
 	ICPU(INTEL_FAM6_KABYLAKE_MOBILE, &spt_reg_map),
 	ICPU(INTEL_FAM6_KABYLAKE_DESKTOP, &spt_reg_map),
+	ICPU(INTEL_FAM6_CANNONLAKE_MOBILE, &cnp_reg_map),
 	{}
 };
 
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 9df4a60a179f..8b7731e6dea2 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -121,6 +121,17 @@ enum ppfear_regs {
 #define SPT_PMC_BIT_MPHY_CMN_LANE2		BIT(2)
 #define SPT_PMC_BIT_MPHY_CMN_LANE3		BIT(3)
 
+/* Cannonlake Power Management Controller register offsets */
+#define CNP_PMC_SLP_S0_RES_COUNTER_OFFSET      0x193C
+#define CNP_PMC_LTR_IGNORE_OFFSET              0x1B0C
+#define CNP_PMC_PM_CFG_OFFSET                  0x1818
+/* Cannonlake: PGD PFET Enable Ack Status Register(s) start */
+#define CNP_PMC_HOST_PPFEAR0A                  0x1D90
+
+#define CNP_PMC_MMIO_REG_LEN                   0x2000
+#define CNP_PPFEAR_NUM_ENTRIES                 8
+#define CNP_PMC_READ_DISABLE_BIT               22
+
 struct pmc_bit_map {
 	const char *name;
 	u32 bit_mask;
-- 
2.7.4
