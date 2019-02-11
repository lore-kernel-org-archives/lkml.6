Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0EBC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E028C20844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895214;
	bh=57IGTE/o9VT6eHD3lmKZ+r73F4KKa94SOIwc2/ngDBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gpc+4K9wFrkGzwZHILte33FF2mqK7M2OaX8D4N1aNboN1tvuz3CydJR/2GzJtCgQh
	 6tfB+/nB0OgmBxYoE9ihzkJl08unen2iLmdcQd8Y9pGoxawhDb1MKhYH6LM77TuKW9
	 u8qZpIMebuuca0q1qkWPgx9mEjFTDP48QgtyvUhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfBKO0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:26:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:60720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729608AbfBKO0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:26:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DEB920821;
        Mon, 11 Feb 2019 14:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895208;
        bh=57IGTE/o9VT6eHD3lmKZ+r73F4KKa94SOIwc2/ngDBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HwjTRHM6kt5KxrZwxvPzj55RxoJ2evby4K1wC8vo1uGxb5+hq6MdZDs1zUyMbOM7h
         KU1pqJkRsI4q645Gsh6VMoR5J5ilL4UO14R4jEewTYxTcr862+dtyGuv7sBBzd43rn
         WZ/RYdCQmvGCobBMv9PvYKONdl/Yu4k/IPtGNvVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 129/352] pinctrl: sx150x: handle failure case of devm_kstrdup
Date:   Mon, 11 Feb 2019 15:15:56 +0100
Message-Id: <20190211141854.616086871@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a9d9f6b83f1bb05da849b3540e6d1f70ef1c2343 ]

devm_kstrdup() may return NULL if internal allocation failed.
Thus using  label, name  is unsafe without checking. Therefor
in the unlikely case of allocation failure, sx150x_probe() simply
returns -ENOMEM.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 9e80f9064e73 ("pinctrl: Add SX150X GPIO Extender Pinctrl Driver")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-sx150x.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sx150x.c b/drivers/pinctrl/pinctrl-sx150x.c
index cbf58a10113d..4d87d75b9c6e 100644
--- a/drivers/pinctrl/pinctrl-sx150x.c
+++ b/drivers/pinctrl/pinctrl-sx150x.c
@@ -1166,7 +1166,6 @@ static int sx150x_probe(struct i2c_client *client,
 	}
 
 	/* Register GPIO controller */
-	pctl->gpio.label = devm_kstrdup(dev, client->name, GFP_KERNEL);
 	pctl->gpio.base = -1;
 	pctl->gpio.ngpio = pctl->data->npins;
 	pctl->gpio.get_direction = sx150x_gpio_get_direction;
@@ -1180,6 +1179,10 @@ static int sx150x_probe(struct i2c_client *client,
 	pctl->gpio.of_node = dev->of_node;
 #endif
 	pctl->gpio.can_sleep = true;
+	pctl->gpio.label = devm_kstrdup(dev, client->name, GFP_KERNEL);
+	if (!pctl->gpio.label)
+		return -ENOMEM;
+
 	/*
 	 * Setting multiple pins is not safe when all pins are not
 	 * handled by the same regmap register. The oscio pin (present
@@ -1200,13 +1203,15 @@ static int sx150x_probe(struct i2c_client *client,
 
 	/* Add Interrupt support if an irq is specified */
 	if (client->irq > 0) {
-		pctl->irq_chip.name = devm_kstrdup(dev, client->name,
-						   GFP_KERNEL);
 		pctl->irq_chip.irq_mask = sx150x_irq_mask;
 		pctl->irq_chip.irq_unmask = sx150x_irq_unmask;
 		pctl->irq_chip.irq_set_type = sx150x_irq_set_type;
 		pctl->irq_chip.irq_bus_lock = sx150x_irq_bus_lock;
 		pctl->irq_chip.irq_bus_sync_unlock = sx150x_irq_bus_sync_unlock;
+		pctl->irq_chip.name = devm_kstrdup(dev, client->name,
+						   GFP_KERNEL);
+		if (!pctl->irq_chip.name)
+			return -ENOMEM;
 
 		pctl->irq.masked = ~0;
 		pctl->irq.sense = 0;
-- 
2.19.1



