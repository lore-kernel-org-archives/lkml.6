Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B13C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4C6208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4C6208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbeK1EGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:06:17 -0500
Received: from www.osadl.org ([62.245.132.105]:41955 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbeK1EGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:06:16 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wARH3GeS004498;
        Tue, 27 Nov 2018 18:03:16 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH V2] gpio: mt7621: pass mediatek_gpio_bank_probe() failure up the stack
Date:   Tue, 27 Nov 2018 18:00:18 +0100
Message-Id: <1543338018-708-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error cases of mediatek_gpio_bank_probe() would go unnoticed (except
for the dev_err() messages). The probe function should return an error
if one of the banks failed to initialize properly indicated by
not returning non-0.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
---

V2: A logic error spoted by Sean Wang <sean.wang@kernel.org> the
    success case is 0 and thus returning early should be on on 
    ret!=0 and not on !ret - thanks for catching this stupid mistake !

Patch was compile tested with: omega2p_defconfig, SOC_MT7621=y,
GPIOLIB=y, GPIO_MT7621=y

Patch is against 4.20-rc3 (localversion-next is next-20181121)

 drivers/gpio/gpio-mt7621.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index 1ec95bc..68fca8b 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -297,6 +297,7 @@ mediatek_gpio_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct mtk *mtk;
 	int i;
+	int ret;
 
 	mtk = devm_kzalloc(dev, sizeof(*mtk), GFP_KERNEL);
 	if (!mtk)
@@ -311,8 +312,11 @@ mediatek_gpio_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mtk);
 	mediatek_gpio_irq_chip.name = dev_name(dev);
 
-	for (i = 0; i < MTK_BANK_CNT; i++)
-		mediatek_gpio_bank_probe(dev, np, i);
+	for (i = 0; i < MTK_BANK_CNT; i++) {
+		ret = mediatek_gpio_bank_probe(dev, np, i);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.1.4

