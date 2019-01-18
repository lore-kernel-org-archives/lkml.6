Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3CAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C722D2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfARDZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 22:25:22 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:60227 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726901AbfARDZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 22:25:04 -0500
X-UUID: 323e7fb21c334698aafc428e2f9ef677-20190118
X-UUID: 323e7fb21c334698aafc428e2f9ef677-20190118
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1600500021; Fri, 18 Jan 2019 11:24:55 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 18 Jan 2019 11:24:47 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 18 Jan 2019 11:24:47 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v1 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
Date:   Fri, 18 Jan 2019 11:24:41 +0800
Message-ID: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a property "mediatek,num-pwms" to avoid having an endless
list of compatibles with no differences for the same driver.

Thus, the driver should have backwards compatibility to older DTs.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
Changes since v1: add some checks for backwards compatibility.
---
 drivers/pwm/pwm-mediatek.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index eb6674c..81b7e5e 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -55,7 +55,7 @@ enum {
 };
 
 struct mtk_pwm_platform_data {
-	unsigned int num_pwms;
+	unsigned int num_pwms;	/* it should not be used in the future SoCs */
 	bool pwm45_fixup;
 	bool has_clks;
 };
@@ -226,27 +226,36 @@ static void mtk_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static int mtk_pwm_probe(struct platform_device *pdev)
 {
-	const struct mtk_pwm_platform_data *data;
+	struct device_node *np = pdev->dev.of_node;
 	struct mtk_pwm_chip *pc;
 	struct resource *res;
-	unsigned int i;
+	unsigned int i, num_pwms;
 	int ret;
 
 	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
 	if (!pc)
 		return -ENOMEM;
 
-	data = of_device_get_match_data(&pdev->dev);
-	if (data == NULL)
-		return -EINVAL;
-	pc->soc = data;
+	pc->soc = of_device_get_match_data(&pdev->dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pc->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(pc->regs))
 		return PTR_ERR(pc->regs);
 
-	for (i = 0; i < data->num_pwms + 2 && pc->soc->has_clks; i++) {
+	/* Check if we have set 'num-pwms' in DTs. */
+	ret = of_property_read_u32(np, "mediatek,num-pwms", &num_pwms);
+	if (ret < 0) {
+		/* If no, fallback to use SoC data for backwards compatibility. */
+		if (pc->soc->num_pwms) {
+			num_pwms = pc->soc->num_pwms;
+		} else {
+			dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < num_pwms + 2 && pc->soc->has_clks; i++) {
 		pc->clks[i] = devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
 		if (IS_ERR(pc->clks[i])) {
 			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
@@ -260,7 +269,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &mtk_pwm_ops;
 	pc->chip.base = -1;
-	pc->chip.npwm = data->num_pwms;
+	pc->chip.npwm = num_pwms;
 
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
-- 
1.9.1

