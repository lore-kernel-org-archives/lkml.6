Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818A1C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFE42082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FFE42082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeLJHdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:33:16 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:45267 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726623AbeLJHdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:33:11 -0500
X-UUID: f49045a3a7924abb96e001ffd4a9d0be-20181210
X-UUID: f49045a3a7924abb96e001ffd4a9d0be-20181210
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 979354706; Mon, 10 Dec 2018 15:32:54 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Dec 2018 15:32:53 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Dec 2018 15:32:53 +0800
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
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v3 12/12] clk: mediatek: Allow changing PLL rate when it is off
Date:   Mon, 10 Dec 2018 15:32:40 +0800
Message-ID: <20181210073240.32278-14-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181210073240.32278-1-weiyi.lu@mediatek.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9CDB393E130637978A39B52F206B72FCFBAF4381EAF1B418F905F316458A4C152000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Liao <jamesjj.liao@mediatek.com>

Some modules may need to change its clock rate before turn on it.
So changing PLL's rate when it is off should be allowed.
This patch removes PLL enabled check before set rate, so that
PLLs can set new frequency even if they are off.

On MT8173 for example, ARMPLL's enable bit can be controlled by
other HW. That means ARMPLL may be turned on even if we (CPU / SW)
set ARMPLL's enable bit as 0. In this case, SW may want and can
still change ARMPLL's rate by changing its pcw and postdiv settings.
But without this patch, new pcw setting will not be applied because
its enable bit is 0.

(am from https://patchwork.kernel.org/patch/9411983/)

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
Acked-by: Michael Turquette <mturuqette@baylibre.com>
Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/clk/mediatek/clk-pll.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 81400601f107..03b20e3bca4e 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -96,13 +96,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 		int postdiv)
 {
 	u32 con1, val;
-	int pll_en;
 	u32 tuner_en = 0;
 	u32 tuner_en_mask;
 	void __iomem *tuner_en_addr = NULL;
 
-	pll_en = readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
-
 	/* disable tuner */
 	if (pll->tuner_en_addr) {
 		tuner_en_addr = pll->tuner_en_addr;
@@ -141,8 +138,7 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 
 	con1 = readl(pll->base_addr + REG_CON1);
 
-	if (pll_en)
-		con1 |= CON1_PCW_CHG;
+	con1 |= CON1_PCW_CHG;
 
 	writel(con1, pll->base_addr + REG_CON1);
 	if (pll->tuner_addr)
@@ -155,8 +151,7 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 		writel(val, tuner_en_addr);
 	}
 
-	if (pll_en)
-		udelay(20);
+	udelay(20);
 }
 
 /*
-- 
2.18.0

