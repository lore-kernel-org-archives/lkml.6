Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E313C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567E120869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfBAIai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:30:38 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:15376 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726786AbfBAIae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:30:34 -0500
X-UUID: f5f8d81320b14c0ab4e21e092eb01459-20190201
X-UUID: f5f8d81320b14c0ab4e21e092eb01459-20190201
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 21759781; Fri, 01 Feb 2019 16:30:26 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 16:30:25 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 16:30:25 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <stable@vger.kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>
Subject: [PATCH v4 01/12] clk: mediatek: Disable tuner_en before change PLL rate
Date:   Fri, 1 Feb 2019 16:30:05 +0800
Message-ID: <20190201083016.25856-3-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190201083016.25856-1-weiyi.lu@mediatek.com>
References: <20190201083016.25856-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Owen Chen <owen.chen@mediatek.com>

PLLs with tuner_en bit, such as APLL1, need to disable
tuner_en before apply new frequency settings, or the new frequency
settings (pcw) will not be applied.
The tuner_en bit will be disabled during changing PLL rate
and be restored after new settings applied.
Another minor change is to correct the macro name of pcw change bit
to CON1_PCW_CHG because PCW_CHG(BIT31) is on CON1.

Fixes: e2f744a82d725 (clk: mediatek: Add MT2712 clock support)
Cc: <stable@vger.kernel.org>
Signed-off-by: Owen Chen <owen.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-pll.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index f54e4015b0b1..f0ff5f535c7e 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -27,7 +27,7 @@
 #define CON0_BASE_EN		BIT(0)
 #define CON0_PWR_ON		BIT(0)
 #define CON0_ISO_EN		BIT(1)
-#define CON0_PCW_CHG		BIT(31)
+#define CON1_PCW_CHG		BIT(31)
 
 #define AUDPLL_TUNER_EN		BIT(31)
 
@@ -93,9 +93,31 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 {
 	u32 con1, val;
 	int pll_en;
+	u32 tuner_en = 0;
+	u32 tuner_en_mask;
+	void __iomem *tuner_en_addr = NULL;
 
 	pll_en = readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
 
+	/* disable tuner */
+	if (pll->tuner_en_addr) {
+		tuner_en_addr = pll->tuner_en_addr;
+		tuner_en_mask = BIT(pll->data->tuner_en_bit);
+	} else if (pll->tuner_addr) {
+		tuner_en_addr = pll->tuner_addr;
+		tuner_en_mask = AUDPLL_TUNER_EN;
+	}
+
+	if (tuner_en_addr) {
+		val = readl(tuner_en_addr);
+		tuner_en = val & tuner_en_mask;
+
+		if (tuner_en) {
+			val &= ~tuner_en_mask;
+			writel(val, tuner_en_addr);
+		}
+	}
+
 	/* set postdiv */
 	val = readl(pll->pd_addr);
 	val &= ~(POSTDIV_MASK << pll->data->pd_shift);
@@ -116,12 +138,19 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 	con1 = readl(pll->base_addr + REG_CON1);
 
 	if (pll_en)
-		con1 |= CON0_PCW_CHG;
+		con1 |= CON1_PCW_CHG;
 
 	writel(con1, pll->base_addr + REG_CON1);
 	if (pll->tuner_addr)
 		writel(con1 + 1, pll->tuner_addr);
 
+	/* restore tuner_en */
+	if (tuner_en_addr && tuner_en) {
+		val = readl(tuner_en_addr);
+		val |= tuner_en_mask;
+		writel(val, tuner_en_addr);
+	}
+
 	if (pll_en)
 		udelay(20);
 }
-- 
2.18.0

