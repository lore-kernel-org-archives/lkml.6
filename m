Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D42C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB07C2150C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB07C2150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJKAda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:33:30 -0400
Received: from shell.v3.sk ([90.176.6.54]:54203 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbeJKAd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:33:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 05FB6BCFB1;
        Wed, 10 Oct 2018 19:10:23 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YLhjDiubGH4A; Wed, 10 Oct 2018 19:10:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id DC636BCF8E;
        Wed, 10 Oct 2018 19:09:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id A03z38LnQTVf; Wed, 10 Oct 2018 19:09:57 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 374E0BCF83;
        Wed, 10 Oct 2018 19:09:55 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     James Cameron <quozl@laptop.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 10/11] spi: pxa2xx: Add ready signal
Date:   Wed, 10 Oct 2018 19:09:35 +0200
Message-Id: <20181010170936.316862-11-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181010170936.316862-1-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Strobe a GPIO line when the slave TX FIFO is filled. This is how the
Embedded Controller on an OLPC XO-1.75 machine, that happens to be a SPI
master, learns that it can initiate a transaction.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/spi/spi-pxa2xx.c | 12 ++++++++++++
 drivers/spi/spi-pxa2xx.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 3848842d68fd..a3b4b12c1077 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1079,6 +1079,9 @@ static int pxa2xx_spi_transfer_one(struct spi_contr=
oller *master,
 	if (spi_controller_is_slave(master)) {
 		while (drv_data->write(drv_data))
 			;
+		gpiod_set_value(drv_data->gpiod_ready, 1);
+		udelay(1);
+		gpiod_set_value(drv_data->gpiod_ready, 0);
 	}
=20
 	/*
@@ -1784,6 +1787,15 @@ static int pxa2xx_spi_probe(struct platform_device=
 *pdev)
 		}
 	}
=20
+	if (platform_info->is_slave) {
+		drv_data->gpiod_ready =3D devm_gpiod_get_optional(dev,
+						"ready", GPIOD_OUT_LOW);
+		if (IS_ERR(drv_data->gpiod_ready)) {
+			status =3D (int)PTR_ERR(drv_data->gpiod_ready);
+			goto out_error_clock_enabled;
+		}
+	}
+
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 513c53aaeab2..4e324da66ef7 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -64,6 +64,9 @@ struct driver_data {
=20
 	/* GPIOs for chip selects */
 	struct gpio_desc **cs_gpiods;
+
+	/* Optional slave FIFO ready signal */
+	struct gpio_desc *gpiod_ready;
 };
=20
 struct chip_data {
--=20
2.19.0

