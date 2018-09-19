Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FF0ECE565
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2BA208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2BA208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbeISNDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 09:03:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31470 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730975AbeISNDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 09:03:34 -0400
X-UUID: 9ae1d96ba7de4262ae6409164c559bc7-20180919
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1466927243; Wed, 19 Sep 2018 15:26:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 19 Sep 2018 15:26:38 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 19 Sep 2018 15:26:37 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>
CC:     <argus.lin@mediatek.com>, <sean.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <chenglin.xu@mediatek.com>,
        <chen.zhong@mediatek.com>, <srv_heupstream@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: [PATCH 3/4] soc: mediatek: add mt8183 pwrap support
Date:   Wed, 19 Sep 2018 15:26:00 +0800
Message-ID: <1537341961-20736-4-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537341961-20736-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1537341961-20736-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 856E96017240086E7BEAB22A279861CFA8D0531CD7478C8EF817311BD3BF7DD52000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT6358 is a new power management IC and it is used for
mt8183 SoCs. To define mt6358_regs for pmic register
mapping and pmic_mt6358 for accessing register.
Adding one more interrupt and wdt source.

Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 195 ++++++++++++++++++++++++++++++++++-
 1 file changed, 191 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 337a163..f40d63e 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -80,6 +80,8 @@
 #define PWRAP_CAP_BRIDGE	BIT(0)
 #define PWRAP_CAP_RESET		BIT(1)
 #define PWRAP_CAP_DCM		BIT(2)
+#define PWRAP_CAP_INT1_EN	BIT(3)
+#define PWRAP_CAP_WDT_SRC1	BIT(4)
 
 /* defines for slave device wrapper registers */
 enum dew_regs {
@@ -100,6 +102,23 @@ enum dew_regs {
 	PWRAP_DEW_CIPHER_EN,
 	PWRAP_DEW_RDDMY_NO,
 
+	/* MT6358 only regs */
+	PWRAP_SMT_CON1,
+	PWRAP_DRV_CON1,
+	PWRAP_FILTER_CON0,
+	PWRAP_GPIO_PULLEN0_CLR,
+	PWRAP_RG_SPI_CON0,
+	PWRAP_RG_SPI_RECORD0,
+	PWRAP_RG_SPI_CON2,
+	PWRAP_RG_SPI_CON3,
+	PWRAP_RG_SPI_CON4,
+	PWRAP_RG_SPI_CON5,
+	PWRAP_RG_SPI_CON6,
+	PWRAP_RG_SPI_CON7,
+	PWRAP_RG_SPI_CON8,
+	PWRAP_RG_SPI_CON13,
+	PWRAP_SPISLV_KEY,
+
 	/* MT6397 only regs */
 	PWRAP_DEW_EVENT_OUT_EN,
 	PWRAP_DEW_EVENT_SRC_EN,
@@ -143,6 +162,34 @@ enum dew_regs {
 	[PWRAP_DEW_RDDMY_NO] =		0x030C,
 };
 
+static const u32 mt6358_regs[] = {
+	[PWRAP_SMT_CON1] =		0x0030,
+	[PWRAP_DRV_CON1] =		0x0038,
+	[PWRAP_FILTER_CON0] =		0x0040,
+	[PWRAP_GPIO_PULLEN0_CLR] =	0x0098,
+	[PWRAP_RG_SPI_CON0] =		0x0408,
+	[PWRAP_RG_SPI_RECORD0] =	0x040a,
+	[PWRAP_DEW_DIO_EN] =		0x040c,
+	[PWRAP_DEW_READ_TEST]	=	0x040e,
+	[PWRAP_DEW_WRITE_TEST]	=	0x0410,
+	[PWRAP_DEW_CRC_EN] =		0x0414,
+	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x041a,
+	[PWRAP_DEW_CIPHER_IV_SEL] =	0x041c,
+	[PWRAP_DEW_CIPHER_EN]	=	0x041e,
+	[PWRAP_DEW_CIPHER_RDY] =	0x0420,
+	[PWRAP_DEW_CIPHER_MODE] =	0x0422,
+	[PWRAP_DEW_CIPHER_SWRST] =	0x0424,
+	[PWRAP_RG_SPI_CON2] =		0x0432,
+	[PWRAP_RG_SPI_CON3] =		0x0434,
+	[PWRAP_RG_SPI_CON4] =		0x0436,
+	[PWRAP_RG_SPI_CON5] =		0x0438,
+	[PWRAP_RG_SPI_CON6] =		0x043a,
+	[PWRAP_RG_SPI_CON7] =		0x043c,
+	[PWRAP_RG_SPI_CON8] =		0x043e,
+	[PWRAP_RG_SPI_CON13] =		0x0448,
+	[PWRAP_SPISLV_KEY] =		0x044a,
+};
+
 static const u32 mt6397_regs[] = {
 	[PWRAP_DEW_BASE] =		0xbc00,
 	[PWRAP_DEW_EVENT_OUT_EN] =	0xbc00,
@@ -226,6 +273,8 @@ enum pwrap_regs {
 	PWRAP_CIPHER_SWRST,
 	PWRAP_DCM_EN,
 	PWRAP_DCM_DBC_PRD,
+	PWRAP_EINT_STA0_ADR,
+	PWRAP_EINT_STA1_ADR,
 
 	/* MT2701 only regs */
 	PWRAP_ADC_CMD_ADDR,
@@ -235,8 +284,6 @@ enum pwrap_regs {
 	PWRAP_ADC_RDATA_ADDR2,
 
 	/* MT7622 only regs */
-	PWRAP_EINT_STA0_ADR,
-	PWRAP_EINT_STA1_ADR,
 	PWRAP_STA,
 	PWRAP_CLR,
 	PWRAP_DVFS_ADR8,
@@ -298,6 +345,27 @@ enum pwrap_regs {
 	PWRAP_DVFS_WDATA7,
 	PWRAP_SPMINF_STA,
 	PWRAP_CIPHER_EN,
+
+	/* MT8183 only regs */
+	PWRAP_SI_SAMPLE_CTRL,
+	PWRAP_CSLEXT_WRITE,
+	PWRAP_CSLEXT_READ,
+	PWRAP_EXT_CK_WRITE,
+	PWRAP_STAUPD_CTRL,
+	PWRAP_WACS_P2P_EN,
+	PWRAP_INIT_DONE_P2P,
+	PWRAP_WACS_MD32_EN,
+	PWRAP_INIT_DONE_MD32,
+	PWRAP_INT1_EN,
+	PWRAP_INT1_FLG,
+	PWRAP_INT1_CLR,
+	PWRAP_WDT_SRC_EN_1,
+	PWRAP_INT_GPS_AUXADC_CMD_ADDR,
+	PWRAP_INT_GPS_AUXADC_CMD,
+	PWRAP_INT_GPS_AUXADC_RDATA_ADDR,
+	PWRAP_EXT_GPS_AUXADC_RDATA_ADDR,
+	PWRAP_GPSINF_0_STA,
+	PWRAP_GPSINF_1_STA,
 };
 
 static int mt2701_regs[] = {
@@ -686,9 +754,61 @@ enum pwrap_regs {
 	[PWRAP_DCM_DBC_PRD] =		0x148,
 };
 
+static int mt8183_regs[] = {
+	[PWRAP_MUX_SEL] =			0x0,
+	[PWRAP_WRAP_EN] =			0x4,
+	[PWRAP_DIO_EN] =			0x8,
+	[PWRAP_SI_SAMPLE_CTRL] =		0xC,
+	[PWRAP_RDDMY] =				0x14,
+	[PWRAP_CSHEXT_WRITE] =			0x18,
+	[PWRAP_CSHEXT_READ] =			0x1C,
+	[PWRAP_CSLEXT_WRITE] =			0x20,
+	[PWRAP_CSLEXT_READ] =			0x24,
+	[PWRAP_EXT_CK_WRITE] =			0x28,
+	[PWRAP_STAUPD_CTRL] =			0x30,
+	[PWRAP_STAUPD_GRPEN] =			0x34,
+	[PWRAP_EINT_STA0_ADR] =			0x38,
+	[PWRAP_HARB_HPRIO] =			0x5C,
+	[PWRAP_HIPRIO_ARB_EN] =			0x60,
+	[PWRAP_MAN_EN] =			0x70,
+	[PWRAP_MAN_CMD] =			0x74,
+	[PWRAP_WACS0_EN] =			0x80,
+	[PWRAP_INIT_DONE0] =			0x84,
+	[PWRAP_WACS1_EN] =			0x88,
+	[PWRAP_INIT_DONE1] =			0x8C,
+	[PWRAP_WACS2_EN] =			0x90,
+	[PWRAP_INIT_DONE2] =			0x94,
+	[PWRAP_WACS_P2P_EN] =			0xA0,
+	[PWRAP_INIT_DONE_P2P] =			0xA4,
+	[PWRAP_WACS_MD32_EN] =			0xA8,
+	[PWRAP_INIT_DONE_MD32] =		0xAC,
+	[PWRAP_INT_EN] =			0xB0,
+	[PWRAP_INT_FLG] =			0xB8,
+	[PWRAP_INT_CLR] =			0xBC,
+	[PWRAP_INT1_EN] =			0xC0,
+	[PWRAP_INT1_FLG] =			0xC8,
+	[PWRAP_INT1_CLR] =			0xCC,
+	[PWRAP_SIG_ADR] =			0xD0,
+	[PWRAP_CRC_EN] =			0xE0,
+	[PWRAP_TIMER_EN] =			0xE4,
+	[PWRAP_WDT_UNIT] =			0xEC,
+	[PWRAP_WDT_SRC_EN] =			0xF0,
+	[PWRAP_WDT_SRC_EN_1] =			0xF4,
+	[PWRAP_INT_GPS_AUXADC_CMD_ADDR] =	0x1DC,
+	[PWRAP_INT_GPS_AUXADC_CMD] =		0x1E0,
+	[PWRAP_INT_GPS_AUXADC_RDATA_ADDR] =	0x1E4,
+	[PWRAP_EXT_GPS_AUXADC_RDATA_ADDR] =	0x1E8,
+	[PWRAP_GPSINF_0_STA] =			0x1EC,
+	[PWRAP_GPSINF_1_STA] =			0x1F0,
+	[PWRAP_WACS2_CMD] =			0xC20,
+	[PWRAP_WACS2_RDATA] =			0xC24,
+	[PWRAP_WACS2_VLDCLR] =			0xC28,
+};
+
 enum pmic_type {
 	PMIC_MT6323,
 	PMIC_MT6351,
+	PMIC_MT6358,
 	PMIC_MT6380,
 	PMIC_MT6397,
 };
@@ -699,6 +819,7 @@ enum pwrap_type {
 	PWRAP_MT7622,
 	PWRAP_MT8135,
 	PWRAP_MT8173,
+	PWRAP_MT8183,
 };
 
 struct pmic_wrapper;
@@ -736,6 +857,7 @@ struct pmic_wrapper_type {
 	enum pwrap_type type;
 	u32 arb_en_all;
 	u32 int_en_all;
+	u32 int1_en_all;
 	u32 spi_w;
 	u32 wdt_src;
 	/* Flags indicating the capability for the target pwrap */
@@ -1130,6 +1252,8 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 	case PWRAP_MT7622:
 		pwrap_writel(wrp, 0, PWRAP_CIPHER_EN);
 		break;
+	case PWRAP_MT8183:
+		break;
 	}
 
 	/* Config cipher mode @PMIC */
@@ -1282,6 +1406,23 @@ static int pwrap_mt7622_init_soc_specific(struct pmic_wrapper *wrp)
 	return 0;
 }
 
+static int pwrap_mt8183_init_soc_specific(struct pmic_wrapper *wrp)
+{
+	pwrap_writel(wrp, 0xf5, PWRAP_STAUPD_GRPEN);
+
+	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CRC_EN], 0x1);
+	pwrap_writel(wrp, 1, PWRAP_CRC_EN);
+	pwrap_writel(wrp, 0x416, PWRAP_SIG_ADR);
+	pwrap_writel(wrp, 0x42e, PWRAP_EINT_STA0_ADR);
+
+	pwrap_writel(wrp, 1, PWRAP_WACS_P2P_EN);
+	pwrap_writel(wrp, 1, PWRAP_WACS_MD32_EN);
+	pwrap_writel(wrp, 1, PWRAP_INIT_DONE_P2P);
+	pwrap_writel(wrp, 1, PWRAP_INIT_DONE_MD32);
+
+	return 0;
+}
+
 static int pwrap_init(struct pmic_wrapper *wrp)
 {
 	int ret;
@@ -1368,11 +1509,15 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 	struct pmic_wrapper *wrp = dev_id;
 
 	rdata = pwrap_readl(wrp, PWRAP_INT_FLG);
-
 	dev_err(wrp->dev, "unexpected interrupt int=0x%x\n", rdata);
-
 	pwrap_writel(wrp, 0xffffffff, PWRAP_INT_CLR);
 
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN)) {
+		rdata = pwrap_readl(wrp, PWRAP_INT1_FLG);
+		dev_err(wrp->dev, "unexpected interrupt int1=0x%x\n", rdata);
+		pwrap_writel(wrp, 0xffffffff, PWRAP_INT1_CLR);
+	}
+
 	return IRQ_HANDLED;
 }
 
@@ -1413,6 +1558,15 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 	.pwrap_write = pwrap_write16,
 };
 
+static const struct pwrap_slv_type pmic_mt6358 = {
+	.dew_regs = mt6358_regs,
+	.type = PMIC_MT6358,
+	.regmap = &pwrap_regmap_config16,
+	.caps = PWRAP_SLV_CAP_SPI | PWRAP_SLV_CAP_DUALIO,
+	.pwrap_read = pwrap_read16,
+	.pwrap_write = pwrap_write16,
+};
+
 static const struct pwrap_slv_type pmic_mt6380 = {
 	.dew_regs = NULL,
 	.type = PMIC_MT6380,
@@ -1440,6 +1594,9 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 		.compatible = "mediatek,mt6351",
 		.data = &pmic_mt6351,
 	}, {
+		.compatible = "mediatek,mt6358",
+		.data = &pmic_mt6358,
+	}, {
 		/* The MT6380 PMIC only implements a regulator, so we bind it
 		 * directly instead of using a MFD.
 		 */
@@ -1459,6 +1616,7 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 	.type = PWRAP_MT2701,
 	.arb_en_all = 0x3f,
 	.int_en_all = ~(u32)(BIT(31) | BIT(2)),
+	.int1_en_all = 0,
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE_NEW,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
 	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
@@ -1471,6 +1629,7 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 	.type = PWRAP_MT6797,
 	.arb_en_all = 0x01fff,
 	.int_en_all = 0xffffffc6,
+	.int1_en_all = 0,
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
 	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
@@ -1483,6 +1642,7 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 	.type = PWRAP_MT7622,
 	.arb_en_all = 0xff,
 	.int_en_all = ~(u32)BIT(31),
+	.int1_en_all = 0,
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
 	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
@@ -1495,6 +1655,7 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 	.type = PWRAP_MT8135,
 	.arb_en_all = 0x1ff,
 	.int_en_all = ~(u32)(BIT(31) | BIT(1)),
+	.int1_en_all = 0,
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
 	.caps = PWRAP_CAP_BRIDGE | PWRAP_CAP_RESET | PWRAP_CAP_DCM,
@@ -1507,6 +1668,7 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 	.type = PWRAP_MT8173,
 	.arb_en_all = 0x3f,
 	.int_en_all = ~(u32)(BIT(31) | BIT(1)),
+	.int1_en_all = 0,
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_NO_STAUPD,
 	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
@@ -1514,6 +1676,19 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 	.init_soc_specific = pwrap_mt8173_init_soc_specific,
 };
 
+static const struct pmic_wrapper_type pwrap_mt8183 = {
+	.regs = mt8183_regs,
+	.type = PWRAP_MT8183,
+	.arb_en_all = 0x3fa75,
+	.int_en_all = 0xffffffff,
+	.int1_en_all = 0xeef7ffff,
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
+	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
+	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_WDT_SRC1,
+	.init_reg_clock = pwrap_common_init_reg_clock,
+	.init_soc_specific = pwrap_mt8183_init_soc_specific,
+};
+
 static const struct of_device_id of_pwrap_match_tbl[] = {
 	{
 		.compatible = "mediatek,mt2701-pwrap",
@@ -1531,6 +1706,9 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 		.compatible = "mediatek,mt8173-pwrap",
 		.data = &pwrap_mt8173,
 	}, {
+		.compatible = "mediatek,mt8183-pwrap",
+		.data = &pwrap_mt8183,
+	}, {
 		/* sentinel */
 	}
 };
@@ -1646,8 +1824,17 @@ static int pwrap_probe(struct platform_device *pdev)
 	 * so STAUPD of WDT_SRC which should be turned off
 	 */
 	pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN);
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_WDT_SRC1))
+		pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN_1);
+
 	pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
 	pwrap_writel(wrp, wrp->master->int_en_all, PWRAP_INT_EN);
+	/*
+	 * We add INT1 interrupt to handle starvation and request exception
+	 * If we support it, we should enable it here.
+	 */
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN))
+		pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);
 
 	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(wrp->dev, irq, pwrap_interrupt,
-- 
1.9.1

