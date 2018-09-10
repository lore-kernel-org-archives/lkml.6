Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEBDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6972086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6972086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeIJQVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:21:07 -0400
Received: from shell.v3.sk ([90.176.6.54]:35747 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbeIJQVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:21:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C3B93B82C9;
        Mon, 10 Sep 2018 13:27:24 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wks5ejx-mVVX; Mon, 10 Sep 2018 13:27:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 36309B82D3;
        Mon, 10 Sep 2018 13:27:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S7hcMnawjEKV; Mon, 10 Sep 2018 13:27:02 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 289E5B82CF;
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
Subject: [PATCH 7/8] Input: olpc_apsp: enable the SP clock
Date:   Mon, 10 Sep 2018 13:26:53 +0200
Message-Id: <20180910112654.42061-8-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180910112654.42061-1-lkundrak@v3.sk>
References: <20180910112654.42061-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without the clock, the keyboard controller won't operate.
Tested on an OLPC XO 1.75.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/input/serio/olpc_apsp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_apsp.c
index 8b19a47dfa46..fe9e19014e70 100644
--- a/drivers/input/serio/olpc_apsp.c
+++ b/drivers/input/serio/olpc_apsp.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/clk.h>
 
 /*
  * The OLPC XO-1.75 and XO-4 laptops do not have a hardware PS/2 controller.
@@ -74,6 +75,7 @@ struct olpc_apsp {
 	struct serio *kbio;
 	struct serio *padio;
 	void __iomem *base;
+	struct clk *clk;
 	int open_count;
 	int irq;
 };
@@ -146,8 +148,13 @@ static int olpc_apsp_open(struct serio *port)
 	struct olpc_apsp *priv = port->port_data;
 	unsigned int tmp;
 	unsigned long l;
+	int error;
 
 	if (priv->open_count++ == 0) {
+		error = clk_prepare_enable(priv->clk);
+		if (error)
+			return error;
+
 		l = readl(priv->base + COMMAND_FIFO_STATUS);
 		if (!(l & CMD_STS_MASK)) {
 			dev_err(priv->dev, "SP cannot accept commands.\n");
@@ -171,6 +178,8 @@ static void olpc_apsp_close(struct serio *port)
 		/* Disable interrupt 0 */
 		tmp = readl(priv->base + PJ_INTERRUPT_MASK);
 		writel(tmp | INT_0, priv->base + PJ_INTERRUPT_MASK);
+
+		clk_disable_unprepare(priv->clk);
 	}
 }
 
@@ -198,6 +207,10 @@ static int olpc_apsp_probe(struct platform_device *pdev)
 	if (priv->irq < 0)
 		return priv->irq;
 
+	priv->clk = devm_clk_get(&pdev->dev, "sp");
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
 	/* KEYBOARD */
 	kb_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!kb_serio)
-- 
2.17.1

