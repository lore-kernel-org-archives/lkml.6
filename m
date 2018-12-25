Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4305BC07520
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B685218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbeLYEZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 23:25:25 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44532 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725806AbeLYEZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 23:25:24 -0500
X-UUID: 8c966f9564934e5cad4f1eb6a4213bf5-20181225
X-UUID: 8c966f9564934e5cad4f1eb6a4213bf5-20181225
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 679132772; Tue, 25 Dec 2018 12:25:18 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 25 Dec 2018 12:25:16 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 25 Dec 2018 12:25:16 +0800
From:   <chuanjia.liu@mediatek.com>
To:     <sean.wang@kernel.org>, <linus.walleij@linaro.org>,
        <matthias.bgg@gmail.com>, <linux-mediatek@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <youlin.pei@mediatek.com>, <eddie.huang@mediatek.com>,
        <zhiyong.tao@mediatek.com>, <hailong.fan@mediatek.com>,
        Chuanjia Liu <Chuanjia.Liu@mediatek.com>
Subject: [PATCH v3] pinctrl:mediatek:add EINT support to virtual GPIOs
Date:   Tue, 25 Dec 2018 12:23:58 +0800
Message-ID: <1545711838-20444-1-git-send-email-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 709753F672622637475F74091239B3160F9481542974F72D2853B8419EB951A42000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>

Virtual gpio only used inside SOC and not being exported to outside SOC.
Some modules use virtual gpio as eint and doesn't nedd SMT.
So this patch add EINT support to virtual GPIOs.

Signed-off-by: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
---
change note:
v3 : 1. modify subject and description
      2. modify comments
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 4a9e0d4c2bbc..a0db145f798d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -290,7 +290,15 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
 		return err;
 
 	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
-	if (err)
+	/*
+	 *SMT is supposed to be supported by every real GPIO and doesn't
+	 *support virtual GPIOs, so the extra condition err != -ENOTSUPP
+	 *is just for adding EINT support to these virtual GPIOs. It should
+	 *add an extra flag in the pin descriptor when more pins with
+	 *distinctive characteristic come out.
+	 */
+
+	if (err && err != -ENOTSUPP)
 		return err;
 
 	return 0;
-- 
2.19.1

