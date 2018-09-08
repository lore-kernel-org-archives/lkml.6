Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A61C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA7520869
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA7520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeIHPxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:53:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32416 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726663AbeIHPxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:53:23 -0400
X-UUID: 2d0829568dff47d3ab25230d93eb4318-20180908
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 133472556; Sat, 08 Sep 2018 19:07:44 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sat, 8 Sep 2018 19:07:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sat, 8 Sep 2018 19:07:42 +0800
From:   <sean.wang@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: [PATCH v2 19/22] pinctrl: mediatek: extend advanced pull support in pinctrl-mtk-common-v2.c
Date:   Sat, 8 Sep 2018 19:07:35 +0800
Message-ID: <818dc8145d9b1e193c0c203767d33b11fa69ead4.1536404280.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1536404280.git.sean.wang@mediatek.com>
References: <cover.1536404280.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Extend the advanced pull based on the legacy bias plus additional r0 and r1
to tweak the resistor level.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 37 ++++++++++++++++++++----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 7cdd46f..7d5f570 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -476,6 +476,19 @@ int mtk_pinconf_adv_pull_set(struct mtk_pinctrl *hw,
 
 	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_PUPD, arg);
 
+	/* If PUPD register is not supported for that pin, let's fallback to
+	 * general bias control.
+	 */
+	if (err == -ENOTSUPP) {
+		if (hw->soc->bias_set) {
+			err = hw->soc->bias_set(hw, desc, pullup);
+			if (err)
+				return err;
+		} else {
+			return -ENOTSUPP;
+		}
+	}
+
 	return err;
 }
 
@@ -487,12 +500,26 @@ int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
 	int err;
 
 	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_PUPD, &t);
-	if (err)
-		return err;
 
-	/* t == 0 supposes PULLUP for the customized PULL setup */
-	if (pullup ^ !t)
-		return -EINVAL;
+	/* If PUPD register is not supported for that pin, let's fallback to
+	 * general bias control.
+	 */
+	if (err == -ENOTSUPP) {
+		if (hw->soc->bias_get) {
+			err = hw->soc->bias_get(hw, desc, pullup, val);
+			if (err)
+				return err;
+		} else {
+			return -ENOTSUPP;
+		}
+	} else {
+		/* t == 0 supposes PULLUP for the customized PULL setup */
+		if (err)
+			return err;
+
+		if (pullup ^ !t)
+			return -EINVAL;
+	}
 
 	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_R0, &t);
 	if (err)
-- 
2.7.4

