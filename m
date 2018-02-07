Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753726AbeBGJOZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:14:25 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58071 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753436AbeBGJOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:14:21 -0500
X-UUID: ad6071150561442c8e22832ece5fc4e7-20180207
From: <sean.wang@mediatek.com>
To: <thierry.reding@gmail.com>, <matthias.bgg@gmail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, Zhi Mao <zhi.mao@mediatek.com>,
        John Crispin <john@phrozen.org>
Subject: [PATCH v2] pwm: mediatek: fix up PWM4 and PWM5 malfunction on MT7623
Date: Wed, 7 Feb 2018 17:14:17 +0800
Message-ID: <f94b2d4146ebe0f8eaae02b0dd951f39af0972d4.1517994540.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Since the offset for both registers, PWMDWIDTH and PWMTHRES, used to
control PWM4 or PWM5 are distinct from the other PWMs, whose wrong
programming on PWM hardware causes waveform cannot be output as expected.
Thus, the patch adds the extra condition for fixing up the weird case to
let PWM4 or PWM5 able to work on MT7623.

v1 -> v2: use pwm45_fixup naming instead of pwm45_quirk

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Zhi Mao <zhi.mao@mediatek.com>
Cc: John Crispin <john@phrozen.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/pwm/pwm-mediatek.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index f5d97e0..796baea 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -29,7 +29,9 @@
 #define PWMGDUR			0x0c
 #define PWMWAVENUM		0x28
 #define PWMDWIDTH		0x2c
+#define PWM45DWIDTH_FIXUP	0x30
 #define PWMTHRES		0x30
+#define PWM45THRES_FIXUP	0x34
 
 #define PWM_CLK_DIV_MAX		7
 
@@ -54,6 +56,7 @@ static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
 
 struct mtk_pwm_platform_data {
 	unsigned int num_pwms;
+	bool pwm45_fixup;
 };
 
 /**
@@ -66,6 +69,7 @@ struct mtk_pwm_chip {
 	struct pwm_chip chip;
 	void __iomem *regs;
 	struct clk *clks[MTK_CLK_MAX];
+	const struct mtk_pwm_platform_data *soc;
 };
 
 static const unsigned int mtk_pwm_reg_offset[] = {
@@ -131,7 +135,8 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
 	struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
-	u32 resolution, clkdiv = 0;
+	u32 resolution, clkdiv = 0, reg_width = PWMDWIDTH,
+	    reg_thres = PWMTHRES;
 	int ret;
 
 	ret = mtk_pwm_clk_enable(chip, pwm);
@@ -151,9 +156,18 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 	}
 
+	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
+		/*
+		 * PWM[4,5] has distinct offset for PWMDWIDTH and PWMTHRES
+		 * from the other PWMs on MT7623.
+		 */
+		reg_width = PWM45DWIDTH_FIXUP;
+		reg_thres = PWM45THRES_FIXUP;
+	}
+
 	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
-	mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
-	mtk_pwm_writel(pc, pwm->hwpwm, PWMTHRES, duty_ns / resolution);
+	mtk_pwm_writel(pc, pwm->hwpwm, reg_width, period_ns / resolution);
+	mtk_pwm_writel(pc, pwm->hwpwm, reg_thres, duty_ns / resolution);
 
 	mtk_pwm_clk_disable(chip, pwm);
 
@@ -211,6 +225,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	data = of_device_get_match_data(&pdev->dev);
 	if (data == NULL)
 		return -EINVAL;
+	pc->soc = data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pc->regs = devm_ioremap_resource(&pdev->dev, res);
@@ -251,14 +266,17 @@ static int mtk_pwm_remove(struct platform_device *pdev)
 
 static const struct mtk_pwm_platform_data mt2712_pwm_data = {
 	.num_pwms = 8,
+	.pwm45_fixup = false,
 };
 
 static const struct mtk_pwm_platform_data mt7622_pwm_data = {
 	.num_pwms = 6,
+	.pwm45_fixup = false,
 };
 
 static const struct mtk_pwm_platform_data mt7623_pwm_data = {
 	.num_pwms = 5,
+	.pwm45_fixup = true,
 };
 
 static const struct of_device_id mtk_pwm_of_match[] = {
-- 
2.7.4
