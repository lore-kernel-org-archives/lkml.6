Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335A1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038A9214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038A9214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbeKLMVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:21:47 -0500
Received: from shell.v3.sk ([90.176.6.54]:59291 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbeKLMVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:21:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B486EC6A0B;
        Mon, 12 Nov 2018 03:30:45 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZpYhbe4TjvBD; Mon, 12 Nov 2018 03:30:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E2D97C6A0F;
        Mon, 12 Nov 2018 03:30:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Zr5tf_9SJ69F; Mon, 12 Nov 2018 03:30:36 +0100 (CET)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id EA132C6A10;
        Mon, 12 Nov 2018 03:30:35 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 5/6] Input: olpc_apsp: check FIFO status on open(), not probe()
Date:   Mon, 12 Nov 2018 03:30:28 +0100
Message-Id: <20181112023029.648408-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112023029.648408-1-lkundrak@v3.sk>
References: <20181112023029.648408-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's defer the FIFO status checking until open().

When we'll get a clk handle, this will allow us to defer clock enablement
until the device is actually used.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/input/serio/olpc_apsp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_a=
psp.c
index 8e9a4209fcad..8b19a47dfa46 100644
--- a/drivers/input/serio/olpc_apsp.c
+++ b/drivers/input/serio/olpc_apsp.c
@@ -145,8 +145,15 @@ static int olpc_apsp_open(struct serio *port)
 {
 	struct olpc_apsp *priv =3D port->port_data;
 	unsigned int tmp;
+	unsigned long l;
=20
 	if (priv->open_count++ =3D=3D 0) {
+		l =3D readl(priv->base + COMMAND_FIFO_STATUS);
+		if (!(l & CMD_STS_MASK)) {
+			dev_err(priv->dev, "SP cannot accept commands.\n");
+			return -EIO;
+		}
+
 		/* Enable interrupt 0 by clearing its bit */
 		tmp =3D readl(priv->base + PJ_INTERRUPT_MASK);
 		writel(tmp & ~INT_0, priv->base + PJ_INTERRUPT_MASK);
@@ -173,7 +180,6 @@ static int olpc_apsp_probe(struct platform_device *pd=
ev)
 	struct olpc_apsp *priv;
 	struct resource *res;
 	struct device_node *np;
-	unsigned long l;
 	int error;
=20
 	priv =3D devm_kzalloc(&pdev->dev, sizeof(struct olpc_apsp), GFP_KERNEL)=
;
@@ -192,12 +198,6 @@ static int olpc_apsp_probe(struct platform_device *p=
dev)
 	if (priv->irq < 0)
 		return priv->irq;
=20
-	l =3D readl(priv->base + COMMAND_FIFO_STATUS);
-	if (!(l & CMD_STS_MASK)) {
-		dev_err(&pdev->dev, "SP cannot accept commands.\n");
-		return -EIO;
-	}
-
 	/* KEYBOARD */
 	kb_serio =3D kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!kb_serio)
--=20
2.19.1

