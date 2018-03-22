Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752267AbeCVDAK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 23:00:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:17546 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751765AbeCVC64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 22:58:56 -0400
X-UUID: d5664642f0ad4ac9835454eb4fc84b87-20180322
From: Zhiyong Tao <zhiyong.tao@mediatek.com>
To: <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>
CC: <srv_heupstream@mediatek.com>, <liguo.zhang@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <hongkun.cao@mediatek.com>,
        <biao.huang@mediatek.com>, <yt.shen@mediatek.com>,
        <hongzhou.yang@mediatek.com>, <erin.lo@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: [PATCH v4 4/5] pintcrl: support bias-disable of generic and special pins simultaneously
Date: Thu, 22 Mar 2018 10:58:42 +0800
Message-ID: <1521687523-1604-5-git-send-email-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521687523-1604-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1521687523-1604-1-git-send-email-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For generic pins, parameter "arg" is 0 or 1.
For special pins, bias-disable is set by R0R1,
so we need transmited "00" to set bias-disable
When we set "bias-disable" as high-z property,
the parameter should be "MTK_PUPD_SET_R1R0_00".

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 3cf384f..f991ff3 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -293,7 +293,7 @@ static int mtk_pconf_set_pull_select(struct mtk_pinctrl *pctl,
 		unsigned int pin, bool enable, bool isup, unsigned int arg)
 {
 	unsigned int bit;
-	unsigned int reg_pullen, reg_pullsel;
+	unsigned int reg_pullen, reg_pullsel, r1r0;
 	int ret;
 
 	/* Some pins' pull setting are very different,
@@ -301,8 +301,12 @@ static int mtk_pconf_set_pull_select(struct mtk_pinctrl *pctl,
 	 * resistor bit, so we need this special handle.
 	 */
 	if (pctl->devdata->spec_pull_set) {
+		/* For special pins, bias-disable is set by R1R0,
+		 * the parameter should be "MTK_PUPD_SET_R1R0_00".
+		 */
+		r1r0 = enable ? arg : MTK_PUPD_SET_R1R0_00;
 		ret = pctl->devdata->spec_pull_set(mtk_get_regmap(pctl, pin),
-			pin, pctl->devdata->port_align, isup, arg);
+			pin, pctl->devdata->port_align, isup, r1r0);
 		if (!ret)
 			return 0;
 	}
-- 
1.9.1
