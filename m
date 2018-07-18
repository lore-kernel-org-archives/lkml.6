Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26510ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8AF20661
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoNrOqAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8AF20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbeGSAhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 20:37:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44324 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeGSAhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 20:37:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so5598466ljq.11;
        Wed, 18 Jul 2018 16:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BycCmm8Gq6/0A/A3AdvDrsfmkVSIr0emCY8Ur1J9Y78=;
        b=KoNrOqAkK56tdHLli02jtgsoFdXZ5koETC7WXacVnuPtdQ/+oNk7yG6+gqb3obnn3o
         VxCPvnE418o6Jg2pd02CT2y+5I6ONQkU9cINvIp7jxKK2K3N6gDR26MtcPcN+HExqfRE
         0Eb1WFUuf7gH4HQw+LssoL7gocsPVoxPnIBxIHU4JorCehpkq3GnIUQNRRSCbaYH4SE1
         hzKuCApgwWohEeCMyYLmwEmd6G1f5ByyPTpzkV/ra0ao57DzZDXbsdMXyJHNI7p3aJSB
         A5/IGOePuobIVLqcazQNcKWNkbMnthbVA5tHagCa0xKqKA4kCuuamZNxkgm7f9MHGkRZ
         ECxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BycCmm8Gq6/0A/A3AdvDrsfmkVSIr0emCY8Ur1J9Y78=;
        b=g85Ly3nZ2xtxDlHI+3CJuT5Sj3CqNy3pS8tfRj6coiSoeAG28X3DdxVdD9k30C/n42
         x20WsqR18+aqUyM4kqXNhazRPuMl9vE5nQtrx1u8aBl/OHDapwPTbwwKOGr6nVF/fiiQ
         0c2JcFlrBoctAwY2wr0mk/EExhOoSh+2hqcKqCt+gtF0OtJ+pEvWQ/7hN/+xYrIZCOtz
         y8CYXIaiI4diOhDS1xa3q1hyAMo+TxeQa0FUtOI3PE4GbnigQsJSnWnYb2tV/Tu9aaIt
         wG7aTIYc23e20uPSAkQR6MmM/wWGSH5Ahxa2JtGScFMv57XeudAXP7x/zOyydhc6/i4C
         JhWg==
X-Gm-Message-State: AOUpUlEeQkfVeNRXOMfl3DGK83WlFl+pi42Goea5gyqSVQSAbJc6pWF5
        IEhVk8G9/rSTCzA/qFJlT5I=
X-Google-Smtp-Source: AAOMgpePfj+3pVjxiIMv2HBi82aJ2vjCr6FGwAwVkOS73Y6sOqSaQCnL75rRTSiJ01KeKFwfOd+pOQ==
X-Received: by 2002:a2e:59d1:: with SMTP id g78-v6mr6093135ljf.79.1531958212445;
        Wed, 18 Jul 2018 16:56:52 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id h7-v6sm826584ljk.27.2018.07.18.16.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 16:56:51 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 2/8] mtd: rawnand: ams-delta: Write protect device during probe
Date:   Thu, 19 Jul 2018 01:57:04 +0200
Message-Id: <20180718235710.18242-3-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180718235710.18242-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize NWP GPIO pin low to protect the device from hazard during
probe.  Release write protection as soon as the device is under
control.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 48233d638d2a..6ac38e9cfa1a 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -219,8 +219,8 @@ static int ams_delta_init(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	/* Set chip enabled, but  */
-	priv->gpiod_nwp = devm_gpiod_get(&pdev->dev, "nwp", GPIOD_OUT_HIGH);
+	/* Set chip enabled but write protected */
+	priv->gpiod_nwp = devm_gpiod_get(&pdev->dev, "nwp", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->gpiod_nwp)) {
 		err = PTR_ERR(priv->gpiod_nwp);
 		dev_err(&pdev->dev, "NWP GPIO request failed (%d)\n", err);
@@ -267,6 +267,9 @@ static int ams_delta_init(struct platform_device *pdev)
 	if (err)
 		goto out_mtd;
 
+	/* As soon as the device is found, release write protection */
+	gpiod_set_value(priv->gpiod_nwp, 1);
+
 	/* Register the partitions */
 	mtd_device_register(mtd, partition_info, ARRAY_SIZE(partition_info));
 
@@ -288,6 +291,9 @@ static int ams_delta_cleanup(struct platform_device *pdev)
 	struct mtd_info *mtd = nand_to_mtd(&priv->nand_chip);
 	void __iomem *io_base = priv->io_base;
 
+	/* Apply write protection */
+	gpiod_set_value(priv->gpiod_nwp, 0);
+
 	/* Release resources, unregister device */
 	nand_release(mtd);
 
-- 
2.16.4

