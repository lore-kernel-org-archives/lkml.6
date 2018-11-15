Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE028C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E52223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E52223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbeKOUje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:39:34 -0500
Received: from shell.v3.sk ([90.176.6.54]:50221 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728757AbeKOUje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:39:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B87364A9B1;
        Thu, 15 Nov 2018 11:32:16 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mSKQ4qYRkC6v; Thu, 15 Nov 2018 11:32:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8DBCE4A9B8;
        Thu, 15 Nov 2018 11:32:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OtJ_Q3lG1ANs; Thu, 15 Nov 2018 11:32:13 +0100 (CET)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 8E7974A9B1;
        Thu, 15 Nov 2018 11:32:12 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2] spi: pxa2xx: Fix '"CONFIG_OF" is not defined' warning
Date:   Thu, 15 Nov 2018 11:32:09 +0100
Message-Id: <20181115103209.20619-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A careless oversight. Sorry.

Fixes: 0a897143b7c9 ("spi: pxa2xx: Add slave mode support")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
Changes since v1:
- Applied Robert Jarzmik's wise suggestion to remove useless
  conditionals and thus reduce this into a single line.

 drivers/spi/spi-pxa2xx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 29e6025f104c..4f55c9647289 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1555,19 +1555,13 @@ pxa2xx_spi_init_pdata(struct platform_device *pde=
v)
 	}
 #endif
=20
-#if CONFIG_OF
-	if (of_id) {
-		pdata->is_slave =3D of_property_read_bool(pdev->dev.of_node,
-								"spi-slave");
-	}
-#endif
-
 	ssp->clk =3D devm_clk_get(&pdev->dev, NULL);
 	ssp->irq =3D platform_get_irq(pdev, 0);
 	ssp->type =3D type;
 	ssp->pdev =3D pdev;
 	ssp->port_id =3D pxa2xx_spi_get_port_id(adev);
=20
+	pdata->is_slave =3D of_property_read_bool(pdev->dev.of_node, "spi-slave=
");
 	pdata->num_chipselect =3D 1;
 	pdata->enable_dma =3D true;
=20
--=20
2.19.1

