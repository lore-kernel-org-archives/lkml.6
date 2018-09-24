Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268D5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B232821486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B232821486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeIXPCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:02:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50323 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726218AbeIXPCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:02:11 -0400
X-UUID: ca8b7064943b47d78d60755d491bd61e-20180924
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2113029830; Mon, 24 Sep 2018 17:01:05 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 24 Sep 2018 17:00:59 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 24 Sep 2018 17:00:58 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>,
        Daniel Kurtz <djkurtz@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>
Subject: [PATCH v2 06/14] iommu/mediatek: Add mt8183 IOMMU support
Date:   Mon, 24 Sep 2018 16:58:46 +0800
Message-ID: <1537779534-23575-7-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537779534-23575-1-git-send-email-yong.wu@mediatek.com>
References: <1537779534-23575-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B91273E6A170EB4A11AF11878595BD0B5D50C3F7C77CAB0FE5CF1238349A81912000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The M4U IP blocks in mt8183 is MediaTek's generation2 M4U which use
the ARM Short-descriptor like mt8173, and most of the HW registers
are the same.

Here list main changes in mt8183:
1) mt8183 has only one M4U HW like mt8173.
2) mt8183 don't have its "bclk" clock, the M4U use the EMI clock
which has already been enabled before kernel.
3) mt8183 can support the dram over 4GB, but it don't call this "4GB
mode".
4) mt8183 pgtable base register(0x0) extend bit[1:0] which represent
the bit[33:32] in the physical address of the pgtable base, But the
standard ttbr0[1] that means the S bit is enabled defaultly, Hence,
we add a mask.
5) mt8183 HW has a GALS modules, the SMI should add "gals" clock
support.
6) the larb-id in smi-common has been remapped. This means the
larb-id reported in the mtk_iommu_isr is not the real larb-id, here
is the remapping relationship of mt8183:
                       M4U
                        |
---------------------------------------------
|               SMI common                  |
-0-----7-----5-----6-----1-----2------3-----4- <- Id remapped
 |     |     |     |     |     |      |     |
larb0 larb1 IPU0  IPU1 larb4 larb5  larb6  CCU
disp  vdec  img   cam   venc  img    cam
As above, larb0 connects with the id 0 in smi-common.
          larb1 connects with the id 7 in smi-common.
          ...
Take a example, if the larb-id reported in the mtk_iommu_isr is 7,
actually it is larb1(vdec).

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 38 ++++++++++++++++++++++++++++----------
 drivers/iommu/mtk_iommu.h |  5 +++++
 drivers/memory/mtk-smi.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 84a12ed..38d4320 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -36,6 +36,7 @@
 #include "mtk_iommu.h"
 
 #define REG_MMU_PT_BASE_ADDR			0x000
+#define MMU_PT_ADDR_MASK			GENMASK(31, 7)
 
 #define REG_MMU_INVALIDATE			0x020
 #define F_ALL_INVLD				0x2
@@ -54,7 +55,7 @@
 #define REG_MMU_CTRL_REG			0x110
 #define F_MMU_PREFETCH_RT_REPLACE_MOD		BIT(4)
 #define F_MMU_TF_PROTECT_SEL_SHIFT(data) \
-	((data)->plat_data->m4u_plat == M4U_MT2712 ? 4 : 5)
+	((data)->plat_data->m4u_plat == M4U_MT8173 ? 5 : 4)
 /* It's named by F_MMU_TF_PROT_SEL in mt2712. */
 #define F_MMU_TF_PROTECT_SEL(prot, data) \
 	(((prot) & 0x3) << F_MMU_TF_PROTECT_SEL_SHIFT(data))
@@ -220,6 +221,9 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	fault_larb = F_MMU0_INT_ID_LARB_ID(regval);
 	fault_port = F_MMU0_INT_ID_PORT_ID(regval);
 
+	if (data->plat_data->larbid_remap_enable)
+		fault_larb = data->plat_data->larbid_remapped[fault_larb];
+
 	if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
 			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
 		dev_err_ratelimited(
@@ -344,7 +348,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 	/* Update the pgtable base address register of the M4U HW */
 	if (!data->m4u_dom) {
 		data->m4u_dom = dom;
-		writel(dom->cfg.arm_v7s_cfg.ttbr[0],
+		writel(dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
 		       data->base + REG_MMU_PT_BASE_ADDR);
 	}
 
@@ -509,6 +513,7 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 
 static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 {
+	enum mtk_iommu_plat m4u_plat = data->plat_data->m4u_plat;
 	u32 regval;
 	int ret;
 
@@ -519,7 +524,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	}
 
 	regval = F_MMU_TF_PROTECT_SEL(2, data);
-	if (data->plat_data->m4u_plat == M4U_MT8173)
+	if (m4u_plat == M4U_MT8173)
 		regval |= F_MMU_PREFETCH_RT_REPLACE_MOD;
 	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
 
@@ -540,14 +545,14 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
 	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
 
-	if (data->plat_data->m4u_plat == M4U_MT8173)
+	if (m4u_plat == M4U_MT8173)
 		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
 	else
 		regval = lower_32_bits(data->protect_base) |
 			 upper_32_bits(data->protect_base);
 	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
 
-	if (data->enable_4GB && data->plat_data->m4u_plat != M4U_MT8173) {
+	if (data->enable_4GB && m4u_plat == M4U_MT2712) {
 		/*
 		 * If 4GB mode is enabled, the validate PA range is from
 		 * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
@@ -557,8 +562,11 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	}
 	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
 
-	/* It's MISC control register whose default value is ok except mt8173.*/
-	if (data->plat_data->m4u_plat == M4U_MT8173)
+	/*
+	 * It's MISC control register whose default value is ok
+	 * except mt8173 and mt8183.
+	 */
+	if (m4u_plat == M4U_MT8173 || m4u_plat == M4U_MT8183)
 		writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
 
 	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
@@ -613,7 +621,9 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		return data->irq;
 
 	data->bclk = devm_clk_get(dev, "bclk");
-	if (IS_ERR(data->bclk))
+	if (PTR_ERR(data->bclk) == -ENOENT)
+		data->bclk = NULL;
+	else if (IS_ERR(data->bclk))
 		return PTR_ERR(data->bclk);
 
 	larb_nr = of_count_phandle_with_args(dev->of_node,
@@ -710,6 +720,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
+	struct mtk_iommu_domain *m4u_dom = data->m4u_dom;
 	void __iomem *base = data->base;
 	int ret;
 
@@ -725,8 +736,8 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 	writel_relaxed(reg->int_control0, base + REG_MMU_INT_CONTROL0);
 	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
 	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
-	if (data->m4u_dom)
-		writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
+	if (m4u_dom)
+		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
 		       base + REG_MMU_PT_BASE_ADDR);
 	return 0;
 }
@@ -745,9 +756,16 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 	.has_4gb_mode = true,
 };
 
+static const struct mtk_iommu_plat_data mt8183_data = {
+	.m4u_plat = M4U_MT8183,
+	.larbid_remap_enable = true,
+	.larbid_remapped = {0, 4, 5, 6, 7, 2, 3, 1},
+};
+
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
+	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
 	{}
 };
 
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index a243047..e5fd8ee 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -39,11 +39,16 @@ enum mtk_iommu_plat {
 	M4U_MT2701,
 	M4U_MT2712,
 	M4U_MT8173,
+	M4U_MT8183,
 };
 
 struct mtk_iommu_plat_data {
 	enum mtk_iommu_plat m4u_plat;
 	bool has_4gb_mode;
+
+	/* The larb-id may be remapped in the smi-common. */
+	bool larbid_remap_enable;
+	unsigned int larbid_remapped[MTK_LARB_NR_MAX];
 };
 
 struct mtk_iommu_domain;
diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index e37e54b..979153b 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -59,6 +59,7 @@ struct mtk_smi_larb_gen {
 struct mtk_smi {
 	struct device			*dev;
 	struct clk			*clk_apb, *clk_smi;
+	struct clk			*clk_gals0, *clk_gals1;
 	struct clk			*clk_async; /*only needed by mt2701*/
 	void __iomem			*smi_ao_base;
 };
@@ -93,8 +94,20 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
 	if (ret)
 		goto err_disable_apb;
 
+	ret = clk_prepare_enable(smi->clk_gals0);
+	if (ret)
+		goto err_disable_smi;
+
+	ret = clk_prepare_enable(smi->clk_gals1);
+	if (ret)
+		goto err_disable_gals0;
+
 	return 0;
 
+err_disable_gals0:
+	clk_disable_unprepare(smi->clk_gals0);
+err_disable_smi:
+	clk_disable_unprepare(smi->clk_smi);
 err_disable_apb:
 	clk_disable_unprepare(smi->clk_apb);
 err_put_pm:
@@ -104,6 +117,8 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
 
 static void mtk_smi_disable(const struct mtk_smi *smi)
 {
+	clk_disable_unprepare(smi->clk_gals1);
+	clk_disable_unprepare(smi->clk_gals0);
 	clk_disable_unprepare(smi->clk_smi);
 	clk_disable_unprepare(smi->clk_apb);
 	pm_runtime_put_sync(smi->dev);
@@ -262,6 +277,12 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
 	.larb_special_mask = BIT(8) | BIT(9), /* bdpsys */
 };
 
+static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
+	.need_larbid = true,
+	.config_port = mtk_smi_larb_config_port_gen2_general,
+	.larb_special_mask = BIT(2) | BIT(3) | BIT(7), /* IPU0 | IPU1 | CCU */
+};
+
 static const struct of_device_id mtk_smi_larb_of_ids[] = {
 	{
 		.compatible = "mediatek,mt8173-smi-larb",
@@ -275,6 +296,10 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
 		.compatible = "mediatek,mt2712-smi-larb",
 		.data = &mtk_smi_larb_mt2712
 	},
+	{
+		.compatible = "mediatek,mt8183-smi-larb",
+		.data = &mtk_smi_larb_mt8183
+	},
 	{}
 };
 
@@ -304,6 +329,12 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	larb->smi.clk_smi = devm_clk_get(dev, "smi");
 	if (IS_ERR(larb->smi.clk_smi))
 		return PTR_ERR(larb->smi.clk_smi);
+
+	larb->smi.clk_gals0 = devm_clk_get(dev, "gals");
+	if (PTR_ERR(larb->smi.clk_gals0) == -ENOENT)
+		larb->smi.clk_gals0 = NULL;
+	else if (IS_ERR(larb->smi.clk_gals0))
+		return PTR_ERR(larb->smi.clk_gals0);
 	larb->smi.dev = dev;
 
 	if (larb->larb_gen->need_larbid) {
@@ -364,6 +395,10 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
 		.compatible = "mediatek,mt2712-smi-common",
 		.data = (void *)MTK_SMI_GEN2
 	},
+	{
+		.compatible = "mediatek,mt8183-smi-common",
+		.data = (void *)MTK_SMI_GEN2
+	},
 	{}
 };
 
@@ -388,6 +423,18 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	if (IS_ERR(common->clk_smi))
 		return PTR_ERR(common->clk_smi);
 
+	common->clk_gals0 = devm_clk_get(dev, "gals0");
+	if (PTR_ERR(common->clk_gals0) == -ENOENT)
+		common->clk_gals0 = NULL;
+	else if (IS_ERR(common->clk_gals0))
+		return PTR_ERR(common->clk_gals0);
+
+	common->clk_gals1 = devm_clk_get(dev, "gals1");
+	if (PTR_ERR(common->clk_gals1) == -ENOENT)
+		common->clk_gals1 = NULL;
+	else if (IS_ERR(common->clk_gals1))
+		return PTR_ERR(common->clk_gals1);
+
 	/*
 	 * for mtk smi gen 1, we need to get the ao(always on) base to config
 	 * m4u port, and we need to enable the aync clock for transform the smi
-- 
1.9.1

