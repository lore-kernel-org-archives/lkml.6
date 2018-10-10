Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AB0C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522AB2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522AB2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeJJVsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:48:00 -0400
Received: from shell.v3.sk ([90.176.6.54]:53483 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbeJJVr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:47:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0B75CBCF76;
        Wed, 10 Oct 2018 16:25:31 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id A5SIzXyGH7_B; Wed, 10 Oct 2018 16:25:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1E418BCF62;
        Wed, 10 Oct 2018 16:25:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jpz9rjSHDBLj; Wed, 10 Oct 2018 16:25:11 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id CB88EBCF5E;
        Wed, 10 Oct 2018 16:25:10 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 6/8] Input: olpc_apsp: check FIFO status on open(), not probe()
Date:   Wed, 10 Oct 2018 16:25:02 +0200
Message-Id: <20181010142504.233467-7-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181010142504.233467-1-lkundrak@v3.sk>
References: <20181010142504.233467-1-lkundrak@v3.sk>
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
2.19.0

