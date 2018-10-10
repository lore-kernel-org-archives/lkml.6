Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4098C4161B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AECD2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AECD2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeJJVsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:48:00 -0400
Received: from shell.v3.sk ([90.176.6.54]:53494 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbeJJVr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:47:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E0105BCF62;
        Wed, 10 Oct 2018 16:25:31 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BPkrXXem0ap3; Wed, 10 Oct 2018 16:25:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 65983BCF5E;
        Wed, 10 Oct 2018 16:25:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M16OtDS2XjH9; Wed, 10 Oct 2018 16:25:12 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 8F761BCF6B;
        Wed, 10 Oct 2018 16:25:11 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 8/8] Input: olpc_apsp: allocate the GPIOs used
Date:   Wed, 10 Oct 2018 16:25:04 +0200
Message-Id: <20181010142504.233467-9-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181010142504.233467-1-lkundrak@v3.sk>
References: <20181010142504.233467-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_a=
psp.c
index fe9e19014e70..287759c5f36d 100644
--- a/drivers/input/serio/olpc_apsp.c
+++ b/drivers/input/serio/olpc_apsp.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/gpio/consumer.h>
=20
 /*
  * The OLPC XO-1.75 and XO-4 laptops do not have a hardware PS/2 control=
ler.
@@ -76,6 +77,8 @@ struct olpc_apsp {
 	struct serio *padio;
 	void __iomem *base;
 	struct clk *clk;
+	struct gpio_desc *clk_gpio;
+	struct gpio_desc *data_gpio;
 	int open_count;
 	int irq;
 };
@@ -211,6 +214,16 @@ static int olpc_apsp_probe(struct platform_device *p=
dev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
=20
+	priv->clk_gpio =3D devm_gpiod_get_optional(&pdev->dev, "clk",
+							GPIOD_ASIS);
+	if (IS_ERR(priv->clk_gpio))
+		return PTR_ERR(priv->clk_gpio);
+
+	priv->data_gpio =3D devm_gpiod_get_optional(&pdev->dev, "data",
+							GPIOD_ASIS);
+	if (IS_ERR(priv->data_gpio))
+		return PTR_ERR(priv->data_gpio);
+
 	/* KEYBOARD */
 	kb_serio =3D kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!kb_serio)
--=20
2.19.0

