Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E28FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B862086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B862086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbeIJQVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:21:02 -0400
Received: from shell.v3.sk ([90.176.6.54]:35754 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728494AbeIJQVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:21:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 818AEB82D4;
        Mon, 10 Sep 2018 13:27:23 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 347wEIqnVdop; Mon, 10 Sep 2018 13:27:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 48C40B82DB;
        Mon, 10 Sep 2018 13:27:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ezdhPOdAxAm0; Mon, 10 Sep 2018 13:27:03 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 61130B82D0;
        Mon, 10 Sep 2018 13:27:01 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 8/8] Input: olpc_apsp: allocate the GPIOs used
Date:   Mon, 10 Sep 2018 13:26:54 +0200
Message-Id: <20180910112654.42061-9-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180910112654.42061-1-lkundrak@v3.sk>
References: <20180910112654.42061-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take the GPIO lines are used by the SP. The driver doesn't touch the
lines -- this is done to disallow anything else from fiddling with
them because that would confuse the SP firmware.

Also, the lines are now nicely visible in /sys/kernel/debug/gpio.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/input/serio/olpc_apsp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_apsp.c
index fe9e19014e70..287759c5f36d 100644
--- a/drivers/input/serio/olpc_apsp.c
+++ b/drivers/input/serio/olpc_apsp.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/gpio/consumer.h>
 
 /*
  * The OLPC XO-1.75 and XO-4 laptops do not have a hardware PS/2 controller.
@@ -76,6 +77,8 @@ struct olpc_apsp {
 	struct serio *padio;
 	void __iomem *base;
 	struct clk *clk;
+	struct gpio_desc *clk_gpio;
+	struct gpio_desc *data_gpio;
 	int open_count;
 	int irq;
 };
@@ -211,6 +214,16 @@ static int olpc_apsp_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
+	priv->clk_gpio = devm_gpiod_get_optional(&pdev->dev, "clk",
+							GPIOD_ASIS);
+	if (IS_ERR(priv->clk_gpio))
+		return PTR_ERR(priv->clk_gpio);
+
+	priv->data_gpio = devm_gpiod_get_optional(&pdev->dev, "data",
+							GPIOD_ASIS);
+	if (IS_ERR(priv->data_gpio))
+		return PTR_ERR(priv->data_gpio);
+
 	/* KEYBOARD */
 	kb_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!kb_serio)
-- 
2.17.1

