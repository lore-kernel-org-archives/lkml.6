Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8756EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E2520881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E2520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbeLCDFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:05:54 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:43349 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeLCDFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:05:53 -0500
Received: from localhost.localdomain (10.28.8.22) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Mon, 3 Dec 2018
 11:05:57 +0800
From:   Xingyu Chen <xingyu.chen@amlogic.com>
To:     <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>
CC:     <narmstrong@baylibre.com>, <jbrunet@baylibre.com>,
        <khilman@baylibre.com>, <carlo@caione.org>,
        <martin.blumenstingl@googlemail.com>, <robh@kernel.org>,
        <xingyu.chen@amlogic.com>, <jianxin.pan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] pinctrl: meson: fix G12A ao pull registers base address
Date:   Mon, 3 Dec 2018 11:05:33 +0800
Message-ID: <20181203030533.10989-1-xingyu.chen@amlogic.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.22]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Meson G12A SoC, Introduce new ao registers AO_RTI_PULL_UP_EN_REG
and AO_GPIO_O.

These bits of controlling output level are remapped to the new register
AO_GPIO_O, and the AO_GPIO_O_EN_N support only controlling output enable.

These bits of controlling pull enable are remapped to the new register
AO_RTI_PULL_UP_EN_REG, and the AO_RTI_PULL_UP_REG support only controlling
pull type(up/down).

The new layout of ao gpio/pull registers is as follows:
- AO_GPIO_O_EN_N        [offset: 0x9 << 2]
- AO_GPIO_I             [offset: 0xa << 2]
- AO_RTI_PULL_UP_REG    [offset: 0xb << 2]
- AO_RTI_PULL_UP_EN_REG [offset: 0xc << 2]
- AO_GPIO_O             [offset: 0xd << 2]

From above, we can see ao GPIO registers region has been separated by the
ao pull registers. In order to ensure the continuity of the region on
software, the ao GPIO and ao pull registers use the same base address, but
can be identified by the offset.

Fixes: 29ae0952e85f ("pinctrl: meson-g12a: add pinctrl driver support")
Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 53d449076dee..7ff40cd7a0cb 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -31,6 +31,9 @@
  * In some cases the register ranges for pull enable and pull
  * direction are the same and thus there are only 3 register ranges.
  *
+ * Since Meson G12A SoC, the ao register ranges for gpio, pull enable
+ * and pull direction are the same, so there are only 2 register ranges.
+ *
  * For the pull and GPIO configuration every bank uses a contiguous
  * set of bits in the register sets described above; the same register
  * can be shared by more banks with different offsets.
@@ -487,23 +490,22 @@ static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc,
 		return PTR_ERR(pc->reg_mux);
 	}
 
-	pc->reg_pull = meson_map_resource(pc, gpio_np, "pull");
-	if (IS_ERR(pc->reg_pull)) {
-		dev_err(pc->dev, "pull registers not found\n");
-		return PTR_ERR(pc->reg_pull);
+	pc->reg_gpio = meson_map_resource(pc, gpio_np, "gpio");
+	if (IS_ERR(pc->reg_gpio)) {
+		dev_err(pc->dev, "gpio registers not found\n");
+		return PTR_ERR(pc->reg_gpio);
 	}
 
+	pc->reg_pull = meson_map_resource(pc, gpio_np, "pull");
+	/* Use gpio region if pull one is not present */
+	if (IS_ERR(pc->reg_pull))
+		pc->reg_pull = pc->reg_gpio;
+
 	pc->reg_pullen = meson_map_resource(pc, gpio_np, "pull-enable");
 	/* Use pull region if pull-enable one is not present */
 	if (IS_ERR(pc->reg_pullen))
 		pc->reg_pullen = pc->reg_pull;
 
-	pc->reg_gpio = meson_map_resource(pc, gpio_np, "gpio");
-	if (IS_ERR(pc->reg_gpio)) {
-		dev_err(pc->dev, "gpio registers not found\n");
-		return PTR_ERR(pc->reg_gpio);
-	}
-
 	return 0;
 }
 
-- 
2.19.2

