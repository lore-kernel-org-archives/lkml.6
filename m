Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972083AbeEYBLB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 21:11:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:29713 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966703AbeEYBK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 21:10:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,438,1520924400";
   d="scan'208";a="52010137"
From: "David E. Box" <david.e.box@linux.intel.com>
To: andy@infradead.org, rajneesh.bhardwaj@intel.com,
        vishwanath.somayaji@intel.com, dvhart@infradead.org
Cc: kyle.d.pelton@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] platform/x86: intel_pmc_core: Add CNP SLPS0 debug registers
Date: Thu, 24 May 2018 18:10:56 -0700
Message-Id: <20180525011056.25132-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <CAHp75VfLqvjVPwhcsK4enhsvXSLggX9_pO9AozZT56DWDrkjPg@mail.gmail.com>
References: <CAHp75VfLqvjVPwhcsK4enhsvXSLggX9_pO9AozZT56DWDrkjPg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds debugfs access to registers in the Cannon Point PCH PMC that are
useful for debugging #SLP_S0 signal assertion and other low power related
activities. Device pm states are latched in these registers whenever the
package enters C10 and can be read from slp_s0_debug_status. The pm
states may also be latched by writing 1 to slp_s0_dbg_latch which will
immediately capture the current state on the next read of
slp_s0_debug_status. Also while in intel_pmc_core.h clean up spacing.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V2:
	Per Andy Shevchenko:
	- Clear latch bit after use
	- Pass pmc_dev as parameter
	- Use DEFINE_SHOW_ATTRIBUTE macro

 drivers/platform/x86/intel_pmc_core.c | 112 ++++++++++++++++++++++++++++++++++
 drivers/platform/x86/intel_pmc_core.h |  27 +++++---
 2 files changed, 132 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 43bbe74..ed40999 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -196,9 +196,64 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
 	{}
 };
 
+static const struct pmc_bit_map cnp_slps0_dbg0_map[] = {
+	{"AUDIO_D3",		BIT(0)},
+	{"OTG_D3",		BIT(1)},
+	{"XHCI_D3",		BIT(2)},
+	{"LPIO_D3",		BIT(3)},
+	{"SDX_D3",		BIT(4)},
+	{"SATA_D3",		BIT(5)},
+	{"UFS0_D3",		BIT(6)},
+	{"UFS1_D3",		BIT(7)},
+	{"EMMC_D3",		BIT(8)},
+};
+
+static const struct pmc_bit_map cnp_slps0_dbg1_map[] = {
+	{"SDIO_PLL_OFF",	BIT(0)},
+	{"USB2_PLL_OFF",	BIT(1)},
+	{"AUDIO_PLL_OFF",	BIT(2)},
+	{"OC_PLL_OFF",		BIT(3)},
+	{"MAIN_PLL_OFF",	BIT(4)},
+	{"XOSC_OFF",		BIT(5)},
+	{"LPC_CLKS_GATED",	BIT(6)},
+	{"PCIE_CLKREQS_IDLE",	BIT(7)},
+	{"AUDIO_ROSC_OFF",	BIT(8)},
+	{"HPET_XOSC_CLK_REQ",	BIT(9)},
+	{"PMC_ROSC_SLOW_CLK",	BIT(10)},
+	{"AON2_ROSC_GATED",	BIT(11)},
+	{"CLKACKS_DEASSERTED",	BIT(12)},
+};
+
+static const struct pmc_bit_map cnp_slps0_dbg2_map[] = {
+	{"MPHY_CORE_GATED",	BIT(0)},
+	{"CSME_GATED",		BIT(1)},
+	{"USB2_SUS_GATED",	BIT(2)},
+	{"DYN_FLEX_IO_IDLE",	BIT(3)},
+	{"GBE_NO_LINK",		BIT(4)},
+	{"THERM_SEN_DISABLED",	BIT(5)},
+	{"PCIE_LOW_POWER",	BIT(6)},
+	{"ISH_VNNAON_REQ_ACT",	BIT(7)},
+	{"ISH_VNN_REQ_ACT",	BIT(8)},
+	{"CNV_VNNAON_REQ_ACT",	BIT(9)},
+	{"CNV_VNN_REQ_ACT",	BIT(10)},
+	{"NPK_VNNON_REQ_ACT",	BIT(11)},
+	{"PMSYNC_STATE_IDLE",	BIT(12)},
+	{"ALST_GT_THRES",	BIT(13)},
+	{"PMC_ARC_PG_READY",	BIT(14)},
+};
+
+static const struct slps0_dbg_map cnp_slps0_dbg_maps[] = {
+	{cnp_slps0_dbg0_map, ARRAY_SIZE(cnp_slps0_dbg0_map)},
+	{cnp_slps0_dbg1_map, ARRAY_SIZE(cnp_slps0_dbg1_map)},
+	{cnp_slps0_dbg2_map, ARRAY_SIZE(cnp_slps0_dbg2_map)},
+};
+
 static const struct pmc_reg_map cnp_reg_map = {
 	.pfear_sts = cnp_pfear_map,
 	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
+	.slps0_dbg_maps = cnp_slps0_dbg_maps,
+	.slps0_dbg_offset = CNP_PMC_SLPS0_DBG_OFFSET,
+	.slps0_dbg_num = ARRAY_SIZE(cnp_slps0_dbg_maps),
 	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
 	.regmap_length = CNP_PMC_MMIO_REG_LEN,
 	.ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
@@ -252,6 +307,8 @@ static int pmc_core_check_read_lock_bit(void)
 }
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
+static bool slps0_dbg_latch;
+
 static void pmc_core_display_map(struct seq_file *s, int index,
 				 u8 pf_reg, const struct pmc_bit_map *pf_map)
 {
@@ -481,6 +538,52 @@ static const struct file_operations pmc_core_ltr_ignore_ops = {
 	.release        = single_release,
 };
 
+static void pmc_core_slps0_dbg_latch(struct pmc_dev *pmcdev, bool reset)
+{
+	const struct pmc_reg_map *map = pmcdev->map;
+	u32 fd;
+
+	mutex_lock(&pmcdev->lock);
+
+	if (!reset && !slps0_dbg_latch)
+		goto out_unlock;
+
+	fd = pmc_core_reg_read(pmcdev, map->slps0_dbg_offset);
+	reset ? (fd &= ~CNP_PMC_LATCH_SLPS0_EVENTS) :
+		(fd |= CNP_PMC_LATCH_SLPS0_EVENTS);
+	pmc_core_reg_write(pmcdev, map->slps0_dbg_offset, fd);
+
+	slps0_dbg_latch = 0;
+
+out_unlock:
+	mutex_unlock(&pmcdev->lock);
+}
+
+static int pmc_core_slps0_dbg_show(struct seq_file *s, void *unused)
+{
+	struct pmc_dev *pmcdev = s ? s->private : &pmc;
+	const struct slps0_dbg_map *maps = pmcdev->map->slps0_dbg_maps;
+	int num_slps0_dbg_regs = pmcdev->map->slps0_dbg_num;
+	int i, offset;
+	u32 data;
+
+	pmc_core_slps0_dbg_latch(pmcdev, false);
+	offset = pmcdev->map->slps0_dbg_offset;
+	while (num_slps0_dbg_regs--) {
+		data = pmc_core_reg_read(pmcdev, offset);
+		offset += 4;
+		for (i = 0; i < maps->size; i++)
+			seq_printf(s, "SLP_S0_DBG: %-32s\tState: %s\n",
+				   maps->slps0_dbg_sts[i].name,
+				   data & maps->slps0_dbg_sts[i].bit_mask ?
+				   "Yes" : "No");
+		maps++;
+	}
+	pmc_core_slps0_dbg_latch(pmcdev, true);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(pmc_core_slps0_dbg);
+
 static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
 {
 	debugfs_remove_recursive(pmcdev->dbgfs_dir);
@@ -514,6 +617,15 @@ static int pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 				    0444, dir, pmcdev,
 				    &pmc_core_mphy_pg_ops);
 
+	if (pmcdev->map->slps0_dbg_maps) {
+		debugfs_create_file("slp_s0_debug_status", 0444,
+				    dir, pmcdev,
+				    &pmc_core_slps0_dbg_fops);
+
+		debugfs_create_bool("slp_s0_dbg_latch", 0644,
+				    dir, &slps0_dbg_latch);
+	}
+
 	return 0;
 }
 #else
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 5fa5f97..97e4b5a 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -124,27 +124,35 @@ enum ppfear_regs {
 #define SPT_PMC_BIT_MPHY_CMN_LANE3		BIT(3)
 
 /* Cannonlake Power Management Controller register offsets */
-#define CNP_PMC_SLP_S0_RES_COUNTER_OFFSET      0x193C
-#define CNP_PMC_LTR_IGNORE_OFFSET              0x1B0C
-#define CNP_PMC_PM_CFG_OFFSET                  0x1818
+#define CNP_PMC_SLP_S0_RES_COUNTER_OFFSET	0x193C
+#define CNP_PMC_LTR_IGNORE_OFFSET		0x1B0C
+#define CNP_PMC_PM_CFG_OFFSET			0x1818
+#define CNP_PMC_SLPS0_DBG_OFFSET		0x10B4
 /* Cannonlake: PGD PFET Enable Ack Status Register(s) start */
-#define CNP_PMC_HOST_PPFEAR0A                  0x1D90
+#define CNP_PMC_HOST_PPFEAR0A			0x1D90
 
-#define CNP_PMC_MMIO_REG_LEN                   0x2000
-#define CNP_PPFEAR_NUM_ENTRIES                 8
-#define CNP_PMC_READ_DISABLE_BIT               22
+#define CNP_PMC_MMIO_REG_LEN			0x2000
+#define CNP_PPFEAR_NUM_ENTRIES			8
+#define CNP_PMC_READ_DISABLE_BIT		22
+#define CNP_PMC_LATCH_SLPS0_EVENTS		BIT(31)
 
 struct pmc_bit_map {
 	const char *name;
 	u32 bit_mask;
 };
 
+struct slps0_dbg_map {
+	const struct pmc_bit_map *slps0_dbg_sts;
+	int size;
+};
+
 /**
  * struct pmc_reg_map - Structure used to define parameter unique to a
 			PCH family
  * @pfear_sts:		Maps name of IP block to PPFEAR* bit
  * @mphy_sts:		Maps name of MPHY lane to MPHY status lane status bit
  * @pll_sts:		Maps name of PLL to corresponding bit status
+ * @slps0_dbg_maps:	Array of SLP_S0_DBG* registers containing debug info
  * @slp_s0_offset:	PWRMBASE offset to read SLP_S0 residency
  * @ltr_ignore_offset:	PWRMBASE offset to read/write LTR ignore bit
  * @regmap_length:	Length of memory to map from PWRMBASE address to access
@@ -153,6 +161,8 @@ struct pmc_bit_map {
  *			PPFEAR
  * @pm_cfg_offset:	PWRMBASE offset to PM_CFG register
  * @pm_read_disable_bit: Bit index to read PMC_READ_DISABLE
+ * @slps0_dbg_offset:	PWRMBASE offset to SLP_S0_DEBUG_REG*
+ * @slps0_dbg_num:	Number of SLP_S0_DEBUG_REG registers
  *
  * Each PCH has unique set of register offsets and bit indexes. This structure
  * captures them to have a common implementation.
@@ -161,6 +171,7 @@ struct pmc_reg_map {
 	const struct pmc_bit_map *pfear_sts;
 	const struct pmc_bit_map *mphy_sts;
 	const struct pmc_bit_map *pll_sts;
+	const struct slps0_dbg_map *slps0_dbg_maps;
 	const u32 slp_s0_offset;
 	const u32 ltr_ignore_offset;
 	const int regmap_length;
@@ -168,6 +179,8 @@ struct pmc_reg_map {
 	const int ppfear_buckets;
 	const u32 pm_cfg_offset;
 	const int pm_read_disable_bit;
+	const u32 slps0_dbg_offset;
+	const int slps0_dbg_num;
 };
 
 /**
-- 
2.7.4
