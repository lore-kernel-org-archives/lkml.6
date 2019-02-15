Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81BEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925CB2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pRnaMg1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391037AbfBOICA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:02:00 -0500
Received: from m12-14.163.com ([220.181.12.14]:45804 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfBOIB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=1xcxi4Zr4aaPTy57CW
        jvbD7ZyvLCvnjLBec3BAsIsjM=; b=pRnaMg1hm66xPFgwm1Q3PVweWIrXSWD+/a
        TZZFPji0TJEnyKfzoNoR3ZODelxlNL8csKzgHiNU9QotHHj/wDWP7Wr+JwOOtmfR
        cwUBfbK64jOWTntmariCi8SVNPZ13bDeQ872wJBhV9NcZ07TyeoxhTbMSNZzcOUD
        uWAPD+ZMY=
Received: from localhost.localdomain (unknown [182.139.212.12])
        by smtp10 (Coremail) with SMTP id DsCowADn7+PicWZcXym0Fw--.3412S2;
        Fri, 15 Feb 2019 16:01:39 +0800 (CST)
From:   WangBo <wdjjwb@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wang.bo116@zte.com.cn
Subject: [PATCH] pinctrl: nomadik: fix possible object reference leak
Date:   Fri, 15 Feb 2019 16:01:36 +0800
Message-Id: <1550217696-3006-1-git-send-email-wdjjwb@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DsCowADn7+PicWZcXym0Fw--.3412S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cry7AF1ftryxGFWUCrW7Arb_yoW8Cr18pF
        W7JFWagryUtF47K34rGa1fZrWSk3WI9w42q3s2939Fgay3Jr93Gr48KFyavrZ5CF93G3y3
        JrWUtFy8ZF4DAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jyKZXUUUUU=
X-Originating-IP: [182.139.212.12]
X-CM-SenderInfo: xzgmy4re6rljoofrz/1tbiOwNcGVXlh4wh-QAAsa
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_device_by_node takes a reference to the struct device
when find the match device ,we should release it when fail.

Signed-off-by: WangBo <wang.bo116@zte.com.cn>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 4cc2c47f8778..ec02739bd21b 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1056,17 +1056,22 @@ static struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 	}
 	if (of_property_read_u32(np, "gpio-bank", &id)) {
 		dev_err(&pdev->dev, "populate: gpio-bank property not found\n");
+		platform_device_put(gpio_pdev);
 		return ERR_PTR(-EINVAL);
 	}
 
 	/* Already populated? */
 	nmk_chip = nmk_gpio_chips[id];
-	if (nmk_chip)
+	if (nmk_chip) {
+		platform_device_put(gpio_pdev);
 		return nmk_chip;
+	}
 
 	nmk_chip = devm_kzalloc(&pdev->dev, sizeof(*nmk_chip), GFP_KERNEL);
-	if (!nmk_chip)
+	if (!nmk_chip) {
+		platform_device_put(gpio_pdev);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	nmk_chip->bank = id;
 	chip = &nmk_chip->chip;
@@ -1077,13 +1082,17 @@ static struct nmk_gpio_chip *nmk_gpio_populate_chip(struct device_node *np,
 
 	res = platform_get_resource(gpio_pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
+	if (IS_ERR(base)) {
+		platform_device_put(gpio_pdev);
 		return ERR_CAST(base);
+	}
 	nmk_chip->addr = base;
 
 	clk = clk_get(&gpio_pdev->dev, NULL);
-	if (IS_ERR(clk))
+	if (IS_ERR(clk)) {
+		platform_device_put(gpio_pdev);
 		return (void *) clk;
+	}
 	clk_prepare(clk);
 	nmk_chip->clk = clk;
 
-- 
2.15.2


