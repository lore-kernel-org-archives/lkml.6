Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E21C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423AE20989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7kVjeMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423AE20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbeKUVkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:40:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35307 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbeKUVkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:40:16 -0500
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so4461719ljb.2;
        Wed, 21 Nov 2018 03:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xJzcdWUi5g1mmy1o8VxmoXAad6mTqA99FbBKb9Bxfrc=;
        b=r7kVjeMexgP6f9JebK5xtWxEWBrGaxE9aO7UAIPB/mkfz4LHZ5rZH+1b8rKYohtZlb
         X35+qLvQE4gUhVFlIQp7AbPOC6H45bVsAFgE1CLkLO4Eo1yoOvAITMQd7IWe9YvKK3+n
         5Fnlxx4G335qYD00tikii/PZ72X3efGwJq7fRnjLk0MptiDINzN4yx4vzb5odvcd/bSI
         2tcxAUKsBBacBnZvbRbjgrSnoDnP5f7hLugH9IWMbIOzwDGqLU77ecaommjrYaMkWclZ
         yYOMUtRFWbTbRlUW6m6hcPYgucMnZ13Upc8t6MKCSQqF+PARmsl6zmWOK1n04eEWTk0x
         mVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xJzcdWUi5g1mmy1o8VxmoXAad6mTqA99FbBKb9Bxfrc=;
        b=VxKFYnJC95XE5xUsdaFv3zhiPs9Drz/IZiYanyGPHa5DBFsErlrteqpQXYPrtnccRn
         vDBHjBRHatFmed7NQ2kvy+65L9TVcftfkMJLxW/jcLFlRMNSxqAxQsCFSAls2gT2+Xzv
         7w5WycH98TDra94uvNUF7vc2nNm5C4E4Oi69W+IVfYtetbVPaIl9ZmwlN5eQLs0q+IJR
         24KaPVs09gSwWoRRn/ZgIuWBK0kFR/YytUsupF7hmYVayStitBO3yOg7asOQVOMLLYYq
         BFLqKhColL9YSDjK1Ie7sxefQtC7D4F2L74bXP1AMq0e9TZOyew9H6t87WuhH6D3YxKK
         P6vQ==
X-Gm-Message-State: AA+aEWYaPymhPTmPYr5ZnHs4N8la2zDUhiVIrROguw82mvGzyzkAgRU2
        uTE42QxV6rqn0NCUBJhc/4c=
X-Google-Smtp-Source: AFSGD/UxF4+6EgaFA+wlF99Claii+6Jao8pyHQxGqPr3OZRx9RKbJ/gQQiNoxL7Rl1quD08TtXxBpw==
X-Received: by 2002:a2e:81a:: with SMTP id 26-v6mr4019750lji.14.1542798376943;
        Wed, 21 Nov 2018 03:06:16 -0800 (PST)
Received: from z50.intranet (78-10-164-223.static.ip.netia.com.pl. [78.10.164.223])
        by smtp.gmail.com with ESMTPSA id x11sm7280047lfd.81.2018.11.21.03.06.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 03:06:16 -0800 (PST)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v4 2/4] mtd: rawnand: ams-delta: Request data port GPIO resource
Date:   Wed, 21 Nov 2018 12:08:04 +0100
Message-Id: <20181121110806.32076-3-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181121110806.32076-1-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20181121110806.32076-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data port used by the driver is actually an OMAP MPUIO device, already
under control of gpio-omap driver.  For that reason we used to not
request the memory region of the port as that would fail because the
region is already busy.  Despite that, we are still accessing the port
by just ioremapping it and performing read/write operations.  Moreover,
we are doing that without any proteciton from other users legally
manipulating the port pins over GPIO API.

The plan is to convert the driver to access the port over GPIO consumer
API.  Before that happens, already prevent from other users accessing
the port pins by requesting an array of its GPIO descriptors.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/nand/raw/ams-delta.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index f8eb4a419e77..bb50dda05654 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -190,6 +190,7 @@ static int ams_delta_init(struct platform_device *pdev)
 	struct mtd_info *mtd;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	void __iomem *io_base;
+	struct gpio_descs *data_gpiods;
 	int err = 0;
 
 	if (!res)
@@ -275,8 +276,14 @@ static int ams_delta_init(struct platform_device *pdev)
 		goto err_unmap;
 	}
 
-	/* Initialize data port direction to a known state */
-	ams_delta_dir_input(priv, true);
+	/* Request array of data pins, initialize them as input */
+	data_gpiods = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_IN);
+	if (IS_ERR(data_gpiods)) {
+		err = PTR_ERR(data_gpiods);
+		dev_err(&pdev->dev, "data GPIO request failed: %d\n", err);
+		goto err_unmap;
+	}
+	priv->data_in = true;
 
 	/* Initialize the NAND controller object embedded in ams_delta_nand. */
 	priv->base.ops = &ams_delta_ops;
-- 
2.18.1

