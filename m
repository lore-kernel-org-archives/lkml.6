Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BACFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BCC214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BCC214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbeKVDSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:18:12 -0500
Received: from www.osadl.org ([62.245.132.105]:41898 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbeKVDSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:18:12 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wALGccSH001213;
        Wed, 21 Nov 2018 17:38:38 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] gpio: mt7621: handle failure of devm_kasprintf()
Date:   Wed, 21 Nov 2018 17:35:42 +0100
Message-Id: <1542818142-27800-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasprintf() may return NULL on failure of internal allocation thus the
assigned  label  is not safe if not explicitly checked. On error
mediatek_gpio_bank_probe() returns negative values so -ENOMEM in the
(unlikely) failure case should be fine here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
---

Problem located with experimental coccinelle script

Patch was compile tested with: omega2p_defconfig, SOC_MT7621=y,
GPIOLIB=y, GPIO_MT7621=y

Patch is against 4.20-rc3 (localversion-next is next-20181121)

 drivers/gpio/gpio-mt7621.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index d72af6f..42f0c67 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -244,6 +244,10 @@ mediatek_gpio_bank_probe(struct device *dev,
 	rg->chip.of_xlate = mediatek_gpio_xlate;
 	rg->chip.label = devm_kasprintf(dev, GFP_KERNEL, "%s-bank%d",
 					dev_name(dev), bank);
+	if (!rg->chip.label) {
+		dev_err(dev, "Could not allocate label\n");
+		return -ENOMEM;
+	}
 
 	ret = devm_gpiochip_add_data(dev, &rg->chip, mtk);
 	if (ret < 0) {
-- 
2.1.4

