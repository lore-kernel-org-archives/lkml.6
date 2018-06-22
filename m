Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E28C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B49623CA6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B49623CA6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934373AbeFVDt1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 23:49:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:24161 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S934326AbeFVDtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 23:49:25 -0400
X-UUID: 23b70955c3144c49af73027b5eac1282-20180622
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1091699482; Fri, 22 Jun 2018 11:49:16 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 22 Jun 2018 11:49:14 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 22 Jun 2018 11:49:15 +0800
From:   <sean.wang@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, <stable@vger.kernel.org>
Subject: [PATCH 3/7] pinctrl: mt7622: fix that pinctrl_claim_hogs cannot work
Date:   Fri, 22 Jun 2018 11:49:06 +0800
Message-ID: <3b1fa378e0a83a5f39497fe8efaf4c992507ed5d.1529639050.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

To allow claiming hogs by pinctrl, we cannot enable pinctrl until all
groups and functions are being added done. Also, it's necessary that
the corresponding gpiochip is being added when the pinctrl device is
enabled.

Cc: stable@vger.kernel.org
Fixes: d6ed93551320 ("pinctrl: mediatek: add pinctrl driver for MT7622 SoC")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7622.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index e9eba62..42155d4 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -1695,9 +1695,10 @@ static int mtk_pinctrl_probe(struct platform_device *pdev)
 	mtk_desc.custom_conf_items = mtk_conf_items;
 #endif
 
-	hw->pctrl = devm_pinctrl_register(&pdev->dev, &mtk_desc, hw);
-	if (IS_ERR(hw->pctrl))
-		return PTR_ERR(hw->pctrl);
+	err = devm_pinctrl_register_and_init(&pdev->dev, &mtk_desc, hw,
+					     &hw->pctrl);
+	if (err)
+		return err;
 
 	/* Setup groups descriptions per SoC types */
 	err = mtk_build_groups(hw);
@@ -1713,11 +1714,19 @@ static int mtk_pinctrl_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	/* For able to make pinctrl_claim_hogs, we must not enable pinctrl
+	 * until all groups and functions are being added one.
+	 */
+	err = pinctrl_enable(hw->pctrl);
+	if (err)
+		return err;
+
 	err = mtk_build_eint(hw, pdev);
 	if (err)
 		dev_warn(&pdev->dev,
 			 "Failed to add EINT, but pinctrl still can work\n");
 
+	/* Build gpiochip should be after pinctrl_enable is done */
 	err = mtk_build_gpiochip(hw, pdev->dev.of_node);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add gpio_chip\n");
-- 
2.7.4

