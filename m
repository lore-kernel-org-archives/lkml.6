Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B66C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CE5208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CE5208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbeISNDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 09:03:31 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46661 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730980AbeISNDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 09:03:30 -0400
X-UUID: 1689d5698d434394983a8a5855474a7a-20180919
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 28138720; Wed, 19 Sep 2018 15:26:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 19 Sep 2018 15:26:37 +0800
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
Subject: [PATCH 2/4] soc: mediatek: use group of bits for pwrap capability
Date:   Wed, 19 Sep 2018 15:25:59 +0800
Message-ID: <1537341961-20736-3-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537341961-20736-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1537341961-20736-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use group of bits for pwrap capability instead of
elements of structure.
This patch is preparing for adding mt8183 pwrap support.

Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 248 ++++++++++++++++++-----------------
 1 file changed, 129 insertions(+), 119 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 4e931fd..337a163 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -76,6 +76,11 @@
 #define PWRAP_SLV_CAP_SECURITY	BIT(2)
 #define HAS_CAP(_c, _x)	(((_c) & (_x)) == (_x))
 
+/* Group of bits used for shown pwrap capability */
+#define PWRAP_CAP_BRIDGE	BIT(0)
+#define PWRAP_CAP_RESET		BIT(1)
+#define PWRAP_CAP_DCM		BIT(2)
+
 /* defines for slave device wrapper registers */
 enum dew_regs {
 	PWRAP_DEW_BASE,
@@ -91,6 +96,10 @@ enum dew_regs {
 	PWRAP_DEW_CIPHER_MODE,
 	PWRAP_DEW_CIPHER_SWRST,
 
+	/* MT6323 only regs */
+	PWRAP_DEW_CIPHER_EN,
+	PWRAP_DEW_RDDMY_NO,
+
 	/* MT6397 only regs */
 	PWRAP_DEW_EVENT_OUT_EN,
 	PWRAP_DEW_EVENT_SRC_EN,
@@ -100,10 +109,6 @@ enum dew_regs {
 	PWRAP_DEW_EVENT_TEST,
 	PWRAP_DEW_CIPHER_LOAD,
 	PWRAP_DEW_CIPHER_START,
-
-	/* MT6323 only regs */
-	PWRAP_DEW_CIPHER_EN,
-	PWRAP_DEW_RDDMY_NO,
 };
 
 static const u32 mt6323_regs[] = {
@@ -123,6 +128,21 @@ enum dew_regs {
 	[PWRAP_DEW_RDDMY_NO] =		0x01a4,
 };
 
+static const u32 mt6351_regs[] = {
+	[PWRAP_DEW_DIO_EN] =		0x02F2,
+	[PWRAP_DEW_READ_TEST] =		0x02F4,
+	[PWRAP_DEW_WRITE_TEST] =	0x02F6,
+	[PWRAP_DEW_CRC_EN] =		0x02FA,
+	[PWRAP_DEW_CRC_VAL] =		0x02FC,
+	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x0300,
+	[PWRAP_DEW_CIPHER_IV_SEL] =	0x0302,
+	[PWRAP_DEW_CIPHER_EN] =		0x0304,
+	[PWRAP_DEW_CIPHER_RDY] =	0x0306,
+	[PWRAP_DEW_CIPHER_MODE] =	0x0308,
+	[PWRAP_DEW_CIPHER_SWRST] =	0x030A,
+	[PWRAP_DEW_RDDMY_NO] =		0x030C,
+};
+
 static const u32 mt6397_regs[] = {
 	[PWRAP_DEW_BASE] =		0xbc00,
 	[PWRAP_DEW_EVENT_OUT_EN] =	0xbc00,
@@ -146,21 +166,6 @@ enum dew_regs {
 	[PWRAP_DEW_CIPHER_SWRST] =	0xbc24,
 };
 
-static const u32 mt6351_regs[] = {
-	[PWRAP_DEW_DIO_EN] =		0x02F2,
-	[PWRAP_DEW_READ_TEST] =		0x02F4,
-	[PWRAP_DEW_WRITE_TEST] =	0x02F6,
-	[PWRAP_DEW_CRC_EN] =		0x02FA,
-	[PWRAP_DEW_CRC_VAL] =		0x02FC,
-	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x0300,
-	[PWRAP_DEW_CIPHER_IV_SEL] =	0x0302,
-	[PWRAP_DEW_CIPHER_EN] =		0x0304,
-	[PWRAP_DEW_CIPHER_RDY] =	0x0306,
-	[PWRAP_DEW_CIPHER_MODE] =	0x0308,
-	[PWRAP_DEW_CIPHER_SWRST] =	0x030A,
-	[PWRAP_DEW_RDDMY_NO] =		0x030C,
-};
-
 enum pwrap_regs {
 	PWRAP_MUX_SEL,
 	PWRAP_WRAP_EN,
@@ -526,6 +531,79 @@ enum pwrap_regs {
 	[PWRAP_SPI2_CTRL] =		0x244,
 };
 
+static int mt8135_regs[] = {
+	[PWRAP_MUX_SEL] =		0x0,
+	[PWRAP_WRAP_EN] =		0x4,
+	[PWRAP_DIO_EN] =		0x8,
+	[PWRAP_SIDLY] =			0xc,
+	[PWRAP_CSHEXT] =		0x10,
+	[PWRAP_CSHEXT_WRITE] =		0x14,
+	[PWRAP_CSHEXT_READ] =		0x18,
+	[PWRAP_CSLEXT_START] =		0x1c,
+	[PWRAP_CSLEXT_END] =		0x20,
+	[PWRAP_STAUPD_PRD] =		0x24,
+	[PWRAP_STAUPD_GRPEN] =		0x28,
+	[PWRAP_STAUPD_MAN_TRIG] =	0x2c,
+	[PWRAP_STAUPD_STA] =		0x30,
+	[PWRAP_EVENT_IN_EN] =		0x34,
+	[PWRAP_EVENT_DST_EN] =		0x38,
+	[PWRAP_WRAP_STA] =		0x3c,
+	[PWRAP_RRARB_INIT] =		0x40,
+	[PWRAP_RRARB_EN] =		0x44,
+	[PWRAP_RRARB_STA0] =		0x48,
+	[PWRAP_RRARB_STA1] =		0x4c,
+	[PWRAP_HARB_INIT] =		0x50,
+	[PWRAP_HARB_HPRIO] =		0x54,
+	[PWRAP_HIPRIO_ARB_EN] =		0x58,
+	[PWRAP_HARB_STA0] =		0x5c,
+	[PWRAP_HARB_STA1] =		0x60,
+	[PWRAP_MAN_EN] =		0x64,
+	[PWRAP_MAN_CMD] =		0x68,
+	[PWRAP_MAN_RDATA] =		0x6c,
+	[PWRAP_MAN_VLDCLR] =		0x70,
+	[PWRAP_WACS0_EN] =		0x74,
+	[PWRAP_INIT_DONE0] =		0x78,
+	[PWRAP_WACS0_CMD] =		0x7c,
+	[PWRAP_WACS0_RDATA] =		0x80,
+	[PWRAP_WACS0_VLDCLR] =		0x84,
+	[PWRAP_WACS1_EN] =		0x88,
+	[PWRAP_INIT_DONE1] =		0x8c,
+	[PWRAP_WACS1_CMD] =		0x90,
+	[PWRAP_WACS1_RDATA] =		0x94,
+	[PWRAP_WACS1_VLDCLR] =		0x98,
+	[PWRAP_WACS2_EN] =		0x9c,
+	[PWRAP_INIT_DONE2] =		0xa0,
+	[PWRAP_WACS2_CMD] =		0xa4,
+	[PWRAP_WACS2_RDATA] =		0xa8,
+	[PWRAP_WACS2_VLDCLR] =		0xac,
+	[PWRAP_INT_EN] =		0xb0,
+	[PWRAP_INT_FLG_RAW] =		0xb4,
+	[PWRAP_INT_FLG] =		0xb8,
+	[PWRAP_INT_CLR] =		0xbc,
+	[PWRAP_SIG_ADR] =		0xc0,
+	[PWRAP_SIG_MODE] =		0xc4,
+	[PWRAP_SIG_VALUE] =		0xc8,
+	[PWRAP_SIG_ERRVAL] =		0xcc,
+	[PWRAP_CRC_EN] =		0xd0,
+	[PWRAP_EVENT_STA] =		0xd4,
+	[PWRAP_EVENT_STACLR] =		0xd8,
+	[PWRAP_TIMER_EN] =		0xdc,
+	[PWRAP_TIMER_STA] =		0xe0,
+	[PWRAP_WDT_UNIT] =		0xe4,
+	[PWRAP_WDT_SRC_EN] =		0xe8,
+	[PWRAP_WDT_FLG] =		0xec,
+	[PWRAP_DEBUG_INT_SEL] =		0xf0,
+	[PWRAP_CIPHER_KEY_SEL] =	0x134,
+	[PWRAP_CIPHER_IV_SEL] =		0x138,
+	[PWRAP_CIPHER_LOAD] =		0x13c,
+	[PWRAP_CIPHER_START] =		0x140,
+	[PWRAP_CIPHER_RDY] =		0x144,
+	[PWRAP_CIPHER_MODE] =		0x148,
+	[PWRAP_CIPHER_SWRST] =		0x14c,
+	[PWRAP_DCM_EN] =		0x15c,
+	[PWRAP_DCM_DBC_PRD] =		0x160,
+};
+
 static int mt8173_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
@@ -608,79 +686,6 @@ enum pwrap_regs {
 	[PWRAP_DCM_DBC_PRD] =		0x148,
 };
 
-static int mt8135_regs[] = {
-	[PWRAP_MUX_SEL] =		0x0,
-	[PWRAP_WRAP_EN] =		0x4,
-	[PWRAP_DIO_EN] =		0x8,
-	[PWRAP_SIDLY] =			0xc,
-	[PWRAP_CSHEXT] =		0x10,
-	[PWRAP_CSHEXT_WRITE] =		0x14,
-	[PWRAP_CSHEXT_READ] =		0x18,
-	[PWRAP_CSLEXT_START] =		0x1c,
-	[PWRAP_CSLEXT_END] =		0x20,
-	[PWRAP_STAUPD_PRD] =		0x24,
-	[PWRAP_STAUPD_GRPEN] =		0x28,
-	[PWRAP_STAUPD_MAN_TRIG] =	0x2c,
-	[PWRAP_STAUPD_STA] =		0x30,
-	[PWRAP_EVENT_IN_EN] =		0x34,
-	[PWRAP_EVENT_DST_EN] =		0x38,
-	[PWRAP_WRAP_STA] =		0x3c,
-	[PWRAP_RRARB_INIT] =		0x40,
-	[PWRAP_RRARB_EN] =		0x44,
-	[PWRAP_RRARB_STA0] =		0x48,
-	[PWRAP_RRARB_STA1] =		0x4c,
-	[PWRAP_HARB_INIT] =		0x50,
-	[PWRAP_HARB_HPRIO] =		0x54,
-	[PWRAP_HIPRIO_ARB_EN] =		0x58,
-	[PWRAP_HARB_STA0] =		0x5c,
-	[PWRAP_HARB_STA1] =		0x60,
-	[PWRAP_MAN_EN] =		0x64,
-	[PWRAP_MAN_CMD] =		0x68,
-	[PWRAP_MAN_RDATA] =		0x6c,
-	[PWRAP_MAN_VLDCLR] =		0x70,
-	[PWRAP_WACS0_EN] =		0x74,
-	[PWRAP_INIT_DONE0] =		0x78,
-	[PWRAP_WACS0_CMD] =		0x7c,
-	[PWRAP_WACS0_RDATA] =		0x80,
-	[PWRAP_WACS0_VLDCLR] =		0x84,
-	[PWRAP_WACS1_EN] =		0x88,
-	[PWRAP_INIT_DONE1] =		0x8c,
-	[PWRAP_WACS1_CMD] =		0x90,
-	[PWRAP_WACS1_RDATA] =		0x94,
-	[PWRAP_WACS1_VLDCLR] =		0x98,
-	[PWRAP_WACS2_EN] =		0x9c,
-	[PWRAP_INIT_DONE2] =		0xa0,
-	[PWRAP_WACS2_CMD] =		0xa4,
-	[PWRAP_WACS2_RDATA] =		0xa8,
-	[PWRAP_WACS2_VLDCLR] =		0xac,
-	[PWRAP_INT_EN] =		0xb0,
-	[PWRAP_INT_FLG_RAW] =		0xb4,
-	[PWRAP_INT_FLG] =		0xb8,
-	[PWRAP_INT_CLR] =		0xbc,
-	[PWRAP_SIG_ADR] =		0xc0,
-	[PWRAP_SIG_MODE] =		0xc4,
-	[PWRAP_SIG_VALUE] =		0xc8,
-	[PWRAP_SIG_ERRVAL] =		0xcc,
-	[PWRAP_CRC_EN] =		0xd0,
-	[PWRAP_EVENT_STA] =		0xd4,
-	[PWRAP_EVENT_STACLR] =		0xd8,
-	[PWRAP_TIMER_EN] =		0xdc,
-	[PWRAP_TIMER_STA] =		0xe0,
-	[PWRAP_WDT_UNIT] =		0xe4,
-	[PWRAP_WDT_SRC_EN] =		0xe8,
-	[PWRAP_WDT_FLG] =		0xec,
-	[PWRAP_DEBUG_INT_SEL] =		0xf0,
-	[PWRAP_CIPHER_KEY_SEL] =	0x134,
-	[PWRAP_CIPHER_IV_SEL] =		0x138,
-	[PWRAP_CIPHER_LOAD] =		0x13c,
-	[PWRAP_CIPHER_START] =		0x140,
-	[PWRAP_CIPHER_RDY] =		0x144,
-	[PWRAP_CIPHER_MODE] =		0x148,
-	[PWRAP_CIPHER_SWRST] =		0x14c,
-	[PWRAP_DCM_EN] =		0x15c,
-	[PWRAP_DCM_DBC_PRD] =		0x160,
-};
-
 enum pmic_type {
 	PMIC_MT6323,
 	PMIC_MT6351,
@@ -733,7 +738,8 @@ struct pmic_wrapper_type {
 	u32 int_en_all;
 	u32 spi_w;
 	u32 wdt_src;
-	unsigned int has_bridge:1;
+	/* Flags indicating the capability for the target pwrap */
+	u32 caps;
 	int (*init_reg_clock)(struct pmic_wrapper *wrp);
 	int (*init_soc_specific)(struct pmic_wrapper *wrp);
 };
@@ -1348,7 +1354,7 @@ static int pwrap_init(struct pmic_wrapper *wrp)
 	pwrap_writel(wrp, 1, PWRAP_INIT_DONE0);
 	pwrap_writel(wrp, 1, PWRAP_INIT_DONE1);
 
-	if (wrp->master->has_bridge) {
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_BRIDGE)) {
 		writel(1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_INIT_DONE3);
 		writel(1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_INIT_DONE4);
 	}
@@ -1398,6 +1404,15 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 	.pwrap_write = pwrap_write16,
 };
 
+static const struct pwrap_slv_type pmic_mt6351 = {
+	.dew_regs = mt6351_regs,
+	.type = PMIC_MT6351,
+	.regmap = &pwrap_regmap_config16,
+	.caps = 0,
+	.pwrap_read = pwrap_read16,
+	.pwrap_write = pwrap_write16,
+};
+
 static const struct pwrap_slv_type pmic_mt6380 = {
 	.dew_regs = NULL,
 	.type = PMIC_MT6380,
@@ -1417,20 +1432,14 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 	.pwrap_write = pwrap_write16,
 };
 
-static const struct pwrap_slv_type pmic_mt6351 = {
-	.dew_regs = mt6351_regs,
-	.type = PMIC_MT6351,
-	.regmap = &pwrap_regmap_config16,
-	.caps = 0,
-	.pwrap_read = pwrap_read16,
-	.pwrap_write = pwrap_write16,
-};
-
 static const struct of_device_id of_slave_match_tbl[] = {
 	{
 		.compatible = "mediatek,mt6323",
 		.data = &pmic_mt6323,
 	}, {
+		.compatible = "mediatek,mt6351",
+		.data = &pmic_mt6351,
+	}, {
 		/* The MT6380 PMIC only implements a regulator, so we bind it
 		 * directly instead of using a MFD.
 		 */
@@ -1440,9 +1449,6 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 		.compatible = "mediatek,mt6397",
 		.data = &pmic_mt6397,
 	}, {
-		.compatible = "mediatek,mt6351",
-		.data = &pmic_mt6351,
-	}, {
 		/* sentinel */
 	}
 };
@@ -1455,7 +1461,7 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 	.int_en_all = ~(u32)(BIT(31) | BIT(2)),
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE_NEW,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
-	.has_bridge = 0,
+	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
 	.init_reg_clock = pwrap_mt2701_init_reg_clock,
 	.init_soc_specific = pwrap_mt2701_init_soc_specific,
 };
@@ -1467,7 +1473,7 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 	.int_en_all = 0xffffffc6,
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
-	.has_bridge = 0,
+	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
 	.init_reg_clock = pwrap_common_init_reg_clock,
 	.init_soc_specific = NULL,
 };
@@ -1479,7 +1485,7 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 	.int_en_all = ~(u32)BIT(31),
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
-	.has_bridge = 0,
+	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
 	.init_reg_clock = pwrap_common_init_reg_clock,
 	.init_soc_specific = pwrap_mt7622_init_soc_specific,
 };
@@ -1491,7 +1497,7 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 	.int_en_all = ~(u32)(BIT(31) | BIT(1)),
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
-	.has_bridge = 1,
+	.caps = PWRAP_CAP_BRIDGE | PWRAP_CAP_RESET | PWRAP_CAP_DCM,
 	.init_reg_clock = pwrap_common_init_reg_clock,
 	.init_soc_specific = pwrap_mt8135_init_soc_specific,
 };
@@ -1503,7 +1509,7 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 	.int_en_all = ~(u32)(BIT(31) | BIT(1)),
 	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
 	.wdt_src = PWRAP_WDT_SRC_MASK_NO_STAUPD,
-	.has_bridge = 0,
+	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
 	.init_reg_clock = pwrap_common_init_reg_clock,
 	.init_soc_specific = pwrap_mt8173_init_soc_specific,
 };
@@ -1561,14 +1567,16 @@ static int pwrap_probe(struct platform_device *pdev)
 	if (IS_ERR(wrp->base))
 		return PTR_ERR(wrp->base);
 
-	wrp->rstc = devm_reset_control_get(wrp->dev, "pwrap");
-	if (IS_ERR(wrp->rstc)) {
-		ret = PTR_ERR(wrp->rstc);
-		dev_dbg(wrp->dev, "cannot get pwrap reset: %d\n", ret);
-		return ret;
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_RESET)) {
+		wrp->rstc = devm_reset_control_get(wrp->dev, "pwrap");
+		if (IS_ERR(wrp->rstc)) {
+			ret = PTR_ERR(wrp->rstc);
+			dev_dbg(wrp->dev, "cannot get pwrap reset: %d\n", ret);
+			return ret;
+		}
 	}
 
-	if (wrp->master->has_bridge) {
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_BRIDGE)) {
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 				"pwrap-bridge");
 		wrp->bridge_base = devm_ioremap_resource(wrp->dev, res);
@@ -1608,8 +1616,10 @@ static int pwrap_probe(struct platform_device *pdev)
 		goto err_out1;
 
 	/* Enable internal dynamic clock */
-	pwrap_writel(wrp, 1, PWRAP_DCM_EN);
-	pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_DCM)) {
+		pwrap_writel(wrp, 1, PWRAP_DCM_EN);
+		pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);
+	}
 
 	/*
 	 * The PMIC could already be initialized by the bootloader.
-- 
1.9.1

