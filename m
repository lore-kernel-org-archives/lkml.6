Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29843C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B054C206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE576iQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B054C206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeIJHlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:41:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40418 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeIJHlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:41:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id x26-v6so16183774lfi.7;
        Sun, 09 Sep 2018 19:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6IK8C/3Lmm7EgMtmeJDH4caEbK/r7LRC38GKEdHwXew=;
        b=XE576iQTwF7+QVhIcDovX9++hRW6/Hu2jAJ2XxTe7JL+vOKwU6yeJsAo344OOC12Qu
         8G60F38/Ju5zJ1vrd1ugddHM4Dw8z3jjTYE/lgC0b6I/RD5nrJbIaTuELNP482Jdd5D+
         3shO1XUOkOrgrPJLIBy4tm/Yo20Rh5sz12/S2QW9oa1HEknlx5NzqJ029yTz46X6skiC
         ryXJMK43YIGQP2ADlhfIiNMDr2d6VP6rUXWhA2YBtYR74yKXpJUa6opCfkj9j22lmucd
         VqMtz19nMUuAultbODTgJHyrzmUxXR/UPgsC7rReoJbHKLs39MljfypaLjftpLZ9wbAL
         64yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6IK8C/3Lmm7EgMtmeJDH4caEbK/r7LRC38GKEdHwXew=;
        b=b9CAQRMzNh1ckJyEI0z8doaARptZDgz+Wfvg4yvjj2+I7OqtQpgP/vTb0GXkHDArg6
         J7lMGFm6YhOOi+NCGI5WdbB1DQnu4tzfPXxV2KE2FtX+V/LRN9eHQsBIVx639EeKaCpx
         SeXBMZIl2ubAvhTtXAAq5hplT6cfT5yO/4warsQiTCEXbvFUbz6lNhkcbLVkzxtRIydI
         hCoUEOOm1z6+Swjsghb5YPtWtplZupBvMTeSpVCpEMjyqF9xAlpEimLIWlyTNov84Sy7
         Fp1WCnxSz45ioLvvLAHYNve39FwlrS28cJFTNSgqEK085YlSOoxY37Kck6ABX+cWSWQ8
         fXvw==
X-Gm-Message-State: APzg51B48CmfQlGhXkuaFBrRrK1GKtmO34xoGUZPmURSrM9prTcqTUw1
        XrLKDjdLnjLECEaNEbk72jwZ8WFf5wM=
X-Google-Smtp-Source: ANB0VdZHiPguRmXBCW0FSXVwjnK+dGOBiid3h0OgT/4gZG7nb29B6u+o3HWcqwo5j3lkTkBVlNSXLg==
X-Received: by 2002:a19:14e6:: with SMTP id 99-v6mr10616482lfu.26.1536533708813;
        Sun, 09 Sep 2018 15:55:08 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id v10-v6sm2401574ljg.12.2018.09.09.15.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 15:55:08 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] mtd: rawnand: ams-delta: use GPIO lookup table
Date:   Mon, 10 Sep 2018 00:56:04 +0200
Message-Id: <20180909225605.16463-3-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180909225605.16463-1-jmkrzyszt@gmail.com>
References: <20180717231448.14958-1-jmkrzyszt@gmail.com>
 <20180909225605.16463-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now as Amstrad Delta board - the only user of this driver - provides
GPIO lookup tables, switch from GPIO numbers to GPIO descriptors and
use the table to locate required GPIO pins.

Declare static variables for storing GPIO descriptors and replace
gpio_ function calls with their gpiod_ equivalents.

Pin naming used by the driver should be followed while respective GPIO
lookup table is initialized by a board init code.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 126 +++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 59 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 37a3cc21c7bc..2a8872ebd14a 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -20,23 +20,28 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
-#include <linux/gpio.h>
 #include <linux/platform_data/gpio-omap.h>
 
 #include <asm/io.h>
 #include <asm/sizes.h>
 
-#include <mach/board-ams-delta.h>
-
 #include <mach/hardware.h>
 
 /*
  * MTD structure for E3 (Delta)
  */
 static struct mtd_info *ams_delta_mtd = NULL;
+static struct gpio_desc *gpiod_rdy;
+static struct gpio_desc *gpiod_nce;
+static struct gpio_desc *gpiod_nre;
+static struct gpio_desc *gpiod_nwp;
+static struct gpio_desc *gpiod_nwe;
+static struct gpio_desc *gpiod_ale;
+static struct gpio_desc *gpiod_cle;
 
 /*
  * Define partitions for flash devices
@@ -70,9 +75,9 @@ static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 
 	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
 	writew(byte, this->IO_ADDR_W);
-	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NWE, 0);
+	gpiod_set_value(gpiod_nwe, 0);
 	ndelay(40);
-	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NWE, 1);
+	gpiod_set_value(gpiod_nwe, 1);
 }
 
 static u_char ams_delta_read_byte(struct mtd_info *mtd)
@@ -81,11 +86,11 @@ static u_char ams_delta_read_byte(struct mtd_info *mtd)
 	struct nand_chip *this = mtd_to_nand(mtd);
 	void __iomem *io_base = (void __iomem *)nand_get_controller_data(this);
 
-	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NRE, 0);
+	gpiod_set_value(gpiod_nre, 0);
 	ndelay(40);
 	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
 	res = readw(this->IO_ADDR_R);
-	gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NRE, 1);
+	gpiod_set_value(gpiod_nre, 1);
 
 	return res;
 }
@@ -120,12 +125,9 @@ static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
 {
 
 	if (ctrl & NAND_CTRL_CHANGE) {
-		gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_NCE,
-				(ctrl & NAND_NCE) == 0);
-		gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_CLE,
-				(ctrl & NAND_CLE) != 0);
-		gpio_set_value(AMS_DELTA_GPIO_PIN_NAND_ALE,
-				(ctrl & NAND_ALE) != 0);
+		gpiod_set_value(gpiod_nce, !(ctrl & NAND_NCE));
+		gpiod_set_value(gpiod_cle, !!(ctrl & NAND_CLE));
+		gpiod_set_value(gpiod_ale, !!(ctrl & NAND_ALE));
 	}
 
 	if (cmd != NAND_CMD_NONE)
@@ -134,41 +136,9 @@ static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
 
 static int ams_delta_nand_ready(struct mtd_info *mtd)
 {
-	return gpio_get_value(AMS_DELTA_GPIO_PIN_NAND_RB);
+	return gpiod_get_value(gpiod_rdy);
 }
 
-static const struct gpio _mandatory_gpio[] = {
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_NAND_NCE,
-		.flags	= GPIOF_OUT_INIT_HIGH,
-		.label	= "nand_nce",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_NAND_NRE,
-		.flags	= GPIOF_OUT_INIT_HIGH,
-		.label	= "nand_nre",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_NAND_NWP,
-		.flags	= GPIOF_OUT_INIT_HIGH,
-		.label	= "nand_nwp",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_NAND_NWE,
-		.flags	= GPIOF_OUT_INIT_HIGH,
-		.label	= "nand_nwe",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_NAND_ALE,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "nand_ale",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_NAND_CLE,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "nand_cle",
-	},
-};
 
 /*
  * Main initialization routine
@@ -216,12 +186,17 @@ static int ams_delta_init(struct platform_device *pdev)
 	this->write_buf = ams_delta_write_buf;
 	this->read_buf = ams_delta_read_buf;
 	this->cmd_ctrl = ams_delta_hwcontrol;
-	if (gpio_request(AMS_DELTA_GPIO_PIN_NAND_RB, "nand_rdy") == 0) {
-		this->dev_ready = ams_delta_nand_ready;
-	} else {
-		this->dev_ready = NULL;
-		pr_notice("Couldn't request gpio for Delta NAND ready.\n");
+
+	gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
+	if (IS_ERR(gpiod_rdy)) {
+		err = PTR_ERR(gpiod_rdy);
+		dev_warn(&pdev->dev, "RDY GPIO request failed (%d)\n", err);
+		goto out_mtd;
 	}
+
+	if (gpiod_rdy)
+		this->dev_ready = ams_delta_nand_ready;
+
 	/* 25 us command delay time */
 	this->chip_delay = 30;
 	this->ecc.mode = NAND_ECC_SOFT;
@@ -230,9 +205,47 @@ static int ams_delta_init(struct platform_device *pdev)
 	platform_set_drvdata(pdev, io_base);
 
 	/* Set chip enabled, but  */
-	err = gpio_request_array(_mandatory_gpio, ARRAY_SIZE(_mandatory_gpio));
-	if (err)
-		goto out_gpio;
+	gpiod_nwp = devm_gpiod_get(&pdev->dev, "nwp", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod_nwp)) {
+		err = PTR_ERR(gpiod_nwp);
+		dev_err(&pdev->dev, "NWP GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
+
+	gpiod_nce = devm_gpiod_get(&pdev->dev, "nce", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod_nce)) {
+		err = PTR_ERR(gpiod_nce);
+		dev_err(&pdev->dev, "NCE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
+
+	gpiod_nre = devm_gpiod_get(&pdev->dev, "nre", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod_nre)) {
+		err = PTR_ERR(gpiod_nre);
+		dev_err(&pdev->dev, "NRE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
+
+	gpiod_nwe = devm_gpiod_get(&pdev->dev, "nwe", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod_nwe)) {
+		err = PTR_ERR(gpiod_nwe);
+		dev_err(&pdev->dev, "NWE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
+
+	gpiod_ale = devm_gpiod_get(&pdev->dev, "ale", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_ale)) {
+		err = PTR_ERR(gpiod_ale);
+		dev_err(&pdev->dev, "ALE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
+
+	gpiod_cle = devm_gpiod_get(&pdev->dev, "cle", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_cle)) {
+		err = PTR_ERR(gpiod_cle);
+		dev_err(&pdev->dev, "CLE GPIO request failed (%d)\n", err);
+		goto out_mtd;
+	}
 
 	/* Scan to find existence of the device */
 	err = nand_scan(ams_delta_mtd, 1);
@@ -246,9 +259,6 @@ static int ams_delta_init(struct platform_device *pdev)
 	goto out;
 
  out_mtd:
-	gpio_free_array(_mandatory_gpio, ARRAY_SIZE(_mandatory_gpio));
-out_gpio:
-	gpio_free(AMS_DELTA_GPIO_PIN_NAND_RB);
 	iounmap(io_base);
 out_free:
 	kfree(this);
@@ -266,8 +276,6 @@ static int ams_delta_cleanup(struct platform_device *pdev)
 	/* Release resources, unregister device */
 	nand_release(ams_delta_mtd);
 
-	gpio_free_array(_mandatory_gpio, ARRAY_SIZE(_mandatory_gpio));
-	gpio_free(AMS_DELTA_GPIO_PIN_NAND_RB);
 	iounmap(io_base);
 
 	/* Free the MTD device structure */
-- 
2.16.4

