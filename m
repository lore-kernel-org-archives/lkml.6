Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB972C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E059214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeLRCcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 21:32:22 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:29677 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726295AbeLRCcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 21:32:22 -0500
X-UUID: 899943ec3ddc4167860c5377a9315dd6-20181218
X-UUID: 899943ec3ddc4167860c5377a9315dd6-20181218
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1124801335; Tue, 18 Dec 2018 10:32:03 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 18 Dec 2018 10:32:01 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 10:32:01 +0800
From:   <chuanjia.liu@mediatek.com>
To:     <sean.wang@kernel.org>, <linus.walleij@linaro.org>,
        <matthias.bgg@gmail.com>, <linux-mediatek@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhiyong.tao@mediatek.com>, <eddie.huang@mediatek.com>,
        <hailong.fan@mediatek.com>, <youlin.pei@mediatek.com>,
        <chuanjia.liu@mediatek.com>,
        Chuanjia Liu <Chuanjia.Liu@mediatek.com>
Subject: [PATCH v2] pinctrl:mediatek:add judgment conditions
Date:   Tue, 18 Dec 2018 10:31:22 +0800
Message-ID: <1545100282-15756-1-git-send-email-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>

This patch avoid return err when virtual gpio set SMT.

Signed-off-by: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
---
change note:
v2 : 1. delete virtual gpio number
     2. add judgment conditions
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 4a9e0d4c2bbc..a576e417744a 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -290,7 +290,11 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
 		return err;
 
 	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
-	if (err)
+
+	/* SMT doesn't support virtual GPIO, add err != -ENOTSUPP is used for
+	 * avoid return err when virtual gpio set SMT.
+	 */
+	if (err && err != -ENOTSUPP)
 		return err;
 
 	return 0;
-- 
2.19.1

