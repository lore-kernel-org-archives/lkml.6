Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753400AbeCRBxW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 21:53:22 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:16278 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752721AbeCRBxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 21:53:20 -0400
X-UUID: 58de6c3999dd4159a08e8a109998dbe9-20180318
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
        Tomasz Figa <tfiga@google.com>, <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <honghui.zhang@mediatek.com>, <youlin.pei@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH] iommu/mediatek: Fix protect memory setting
Date: Sun, 18 Mar 2018 09:52:54 +0800
Message-ID: <1521337974-22112-1-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In MediaTek's IOMMU design, When a iommu translation fault occurs
(HW can NOT translate the destination address to a valid physical
address), the IOMMU HW output the dirty data into a special memory
to avoid corrupting the main memory, this is called "protect memory".
the register(0x114) for protect memory is a little different between
mt8173 and mt2712.

In the mt8173, bit[30:6] in the register represents [31:7] of the
physical address. In the 4GB mode, the register bit[31] should be 1.
While in the mt2712, the bits don't shift. bit[31:7] in the register
represents [31:7] in the physical address, and bit[1:0] in the
register represents bit[33:32] of the physical address if it has.

Fixes: e6dec9230862 ("iommu/mediatek: Add mt2712 IOMMU support")
Reported-by: Honghui Zhang <honghui.zhang@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
After adding the setting above, the macro will be complex, like:
 #define F_MMU_IVRP_PA_SET(data)		({	\
	const struct mtk_iommu_data *_data =  data;	\
	phys_addr_t _pa = data->protect_base;		\
	((_data->m4u_plat == M4U_MT8173) ?		\
	((_pa >> 1) | (_data->enable_4GB << 31)) :	\
	(lower_32_bits(_pa) | (_pa >> 32)));		\
	})
And this macro is called twice(hw_init and resume).

To avoid adding this complex macro or a new function, I put
it in the code and backup its value in the suspend registers.
---
 drivers/iommu/mtk_iommu.c | 15 ++++++++++-----
 drivers/iommu/mtk_iommu.h |  1 +
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index f227d73..f2832a1 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -60,7 +60,7 @@
 	(((prot) & 0x3) << F_MMU_TF_PROTECT_SEL_SHIFT(data))
 
 #define REG_MMU_IVRP_PADDR			0x114
-#define F_MMU_IVRP_PA_SET(pa, ext)		(((pa) >> 1) | ((!!(ext)) << 31))
+
 #define REG_MMU_VLD_PA_RNG			0x118
 #define F_MMU_VLD_PA_RNG(EA, SA)		(((EA) << 8) | (SA))
 
@@ -539,8 +539,13 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
 	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
 
-	writel_relaxed(F_MMU_IVRP_PA_SET(data->protect_base, data->enable_4GB),
-		       data->base + REG_MMU_IVRP_PADDR);
+	if (data->m4u_plat == M4U_MT8173)
+		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
+	else
+		regval = lower_32_bits(data->protect_base) |
+			 upper_32_bits(data->protect_base);
+	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
+
 	if (data->enable_4GB && data->m4u_plat != M4U_MT8173) {
 		/*
 		 * If 4GB mode is enabled, the validate PA range is from
@@ -695,6 +700,7 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
 	reg->ctrl_reg = readl_relaxed(base + REG_MMU_CTRL_REG);
 	reg->int_control0 = readl_relaxed(base + REG_MMU_INT_CONTROL0);
 	reg->int_main_control = readl_relaxed(base + REG_MMU_INT_MAIN_CONTROL);
+	reg->ivrp_paddr = readl_relaxed(base + REG_MMU_IVRP_PADDR);
 	clk_disable_unprepare(data->bclk);
 	return 0;
 }
@@ -717,8 +723,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 	writel_relaxed(reg->ctrl_reg, base + REG_MMU_CTRL_REG);
 	writel_relaxed(reg->int_control0, base + REG_MMU_INT_CONTROL0);
 	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
-	writel_relaxed(F_MMU_IVRP_PA_SET(data->protect_base, data->enable_4GB),
-		       base + REG_MMU_IVRP_PADDR);
+	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
 	if (data->m4u_dom)
 		writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
 		       base + REG_MMU_PT_BASE_ADDR);
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index b4451a1..778498b 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -32,6 +32,7 @@ struct mtk_iommu_suspend_reg {
 	u32				ctrl_reg;
 	u32				int_control0;
 	u32				int_main_control;
+	u32				ivrp_paddr;
 };
 
 enum mtk_iommu_plat {
-- 
1.8.1.1.dirty
