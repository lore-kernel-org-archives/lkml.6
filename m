Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3E0C282E9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84A82084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfAUHxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:53:35 -0500
Received: from shell.v3.sk ([90.176.6.54]:49621 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbfAUHxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:53:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8ACC9CAF89;
        Mon, 21 Jan 2019 07:23:29 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XIUdzRkxOTh8; Mon, 21 Jan 2019 07:23:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 837A4CAF38;
        Mon, 21 Jan 2019 07:23:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NBedsD64bK1m; Mon, 21 Jan 2019 07:23:17 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 349CDCAE3B;
        Mon, 21 Jan 2019 07:23:17 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 1/3] Revert "Input: olpc_apsp - enable the SP clock"
Date:   Mon, 21 Jan 2019 07:22:54 +0100
Message-Id: <20190121062255.551587-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121062255.551587-1-lkundrak@v3.sk>
References: <20190121062255.551587-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out this is not such a great idea. Once the SP clock is disabled,
it's not sufficient to just enable in order to bring the SP core back up.

It seems that the kernel has no business managing this clock. Just let
the firmware keep it enabled.

This reverts commit ed22cee91a88c47e564478b012fdbcb079653499.

Link: https://lore.kernel.org/lkml/154783267051.169631.319783654464662574=
7@swboyd.mtv.corp.google.com/
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../devicetree/bindings/serio/olpc,ap-sp.txt       |  4 ----
 drivers/input/serio/olpc_apsp.c                    | 14 --------------
 2 files changed, 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt b/Doc=
umentation/devicetree/bindings/serio/olpc,ap-sp.txt
index 36603419d6f8..0e72183f52bc 100644
--- a/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
+++ b/Documentation/devicetree/bindings/serio/olpc,ap-sp.txt
@@ -4,14 +4,10 @@ Required properties:
 - compatible : "olpc,ap-sp"
 - reg : base address and length of SoC's WTM registers
 - interrupts : SP-AP interrupt
-- clocks : phandle + clock-specifier for the clock that drives the WTM
-- clock-names:  should be "sp"
=20
 Example:
 	ap-sp@d4290000 {
 		compatible =3D "olpc,ap-sp";
 		reg =3D <0xd4290000 0x1000>;
 		interrupts =3D <40>;
-		clocks =3D <&soc_clocks MMP2_CLK_SP>;
-		clock-names =3D "sp";
 	}
diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_a=
psp.c
index bae08226e3d9..a7cfab3db9ee 100644
--- a/drivers/input/serio/olpc_apsp.c
+++ b/drivers/input/serio/olpc_apsp.c
@@ -23,7 +23,6 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
-#include <linux/clk.h>
=20
 /*
  * The OLPC XO-1.75 and XO-4 laptops do not have a hardware PS/2 control=
ler.
@@ -75,7 +74,6 @@ struct olpc_apsp {
 	struct serio *kbio;
 	struct serio *padio;
 	void __iomem *base;
-	struct clk *clk;
 	int open_count;
 	int irq;
 };
@@ -148,17 +146,11 @@ static int olpc_apsp_open(struct serio *port)
 	struct olpc_apsp *priv =3D port->port_data;
 	unsigned int tmp;
 	unsigned long l;
-	int error;
=20
 	if (priv->open_count++ =3D=3D 0) {
-		error =3D clk_prepare_enable(priv->clk);
-		if (error)
-			return error;
-
 		l =3D readl(priv->base + COMMAND_FIFO_STATUS);
 		if (!(l & CMD_STS_MASK)) {
 			dev_err(priv->dev, "SP cannot accept commands.\n");
-			clk_disable_unprepare(priv->clk);
 			return -EIO;
 		}
=20
@@ -179,8 +171,6 @@ static void olpc_apsp_close(struct serio *port)
 		/* Disable interrupt 0 */
 		tmp =3D readl(priv->base + PJ_INTERRUPT_MASK);
 		writel(tmp | INT_0, priv->base + PJ_INTERRUPT_MASK);
-
-		clk_disable_unprepare(priv->clk);
 	}
 }
=20
@@ -208,10 +198,6 @@ static int olpc_apsp_probe(struct platform_device *p=
dev)
 	if (priv->irq < 0)
 		return priv->irq;
=20
-	priv->clk =3D devm_clk_get(&pdev->dev, "sp");
-	if (IS_ERR(priv->clk))
-		return PTR_ERR(priv->clk);
-
 	/* KEYBOARD */
 	kb_serio =3D kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!kb_serio)
--=20
2.20.1

