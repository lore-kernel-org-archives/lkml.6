Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C604C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D4823CA9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D4823CA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934483AbeFVDth (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 23:49:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:24161 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S934378AbeFVDt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 23:49:29 -0400
X-UUID: 26c5572205ea49eb8448de3d22a3a642-20180622
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1475995068; Fri, 22 Jun 2018 11:49:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 22 Jun 2018 11:49:14 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 22 Jun 2018 11:49:14 +0800
From:   <sean.wang@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/7] pinctrl: mt7622: fix initialization sequence between eint and gpiochip
Date:   Fri, 22 Jun 2018 11:49:05 +0800
Message-ID: <989f31608d4a85594d3805f966006e1f607ccde3.1529639050.git.sean.wang@mediatek.com>
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

Because gpichip applied in the driver must depend on mtk eint to implement
the input data debouncing and the translation between gpio and irq, it's
better to keep logic consistent with mtk eint being built prior to gpiochip
being added.

Cc: stable@vger.kernel.org
Fixes: e6dabd38d8e7 ("pinctrl: mediatek: add EINT support to MT7622 SoC")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7622.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index 9ad8cb77..e9eba62 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -1713,17 +1713,17 @@ static int mtk_pinctrl_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	err = mtk_build_eint(hw, pdev);
+	if (err)
+		dev_warn(&pdev->dev,
+			 "Failed to add EINT, but pinctrl still can work\n");
+
 	err = mtk_build_gpiochip(hw, pdev->dev.of_node);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add gpio_chip\n");
 		return err;
 	}
 
-	err = mtk_build_eint(hw, pdev);
-	if (err)
-		dev_warn(&pdev->dev,
-			 "Failed to add EINT, but pinctrl still can work\n");
-
 	platform_set_drvdata(pdev, hw);
 
 	return 0;
-- 
2.7.4

