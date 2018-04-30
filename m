Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbeD3IZh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:25:37 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40774 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752610AbeD3IZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:25:32 -0400
X-Google-Smtp-Source: AB8JxZprUTAss7PLTGAXn9tLUrr3erO0TZjJdhGSSi6zIZan22q1rYFKblfxN044h7tXeucU9M+FTg==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 11/12] mtd: nand: davinci: stop using pdev->id as chipselect
Date: Mon, 30 Apr 2018 10:24:52 +0200
Message-Id: <20180430082453.8091-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430082453.8091-1-brgl@bgdev.pl>
References: <20180430082453.8091-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

All platform now use the core_chipsel field in platform data. Stop
using pdev->id in the driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/mtd/nand/raw/davinci_nand.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 7255a0d94374..cd12e5abafde 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -545,7 +545,7 @@ static struct davinci_nand_pdata
 			return ERR_PTR(-ENOMEM);
 		if (!of_property_read_u32(pdev->dev.of_node,
 			"ti,davinci-chipselect", &prop))
-			pdev->id = prop;
+			pdata->core_chipsel = prop;
 		else
 			return ERR_PTR(-EINVAL);
 
@@ -627,7 +627,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	/* which external chipselect will we be managing? */
-	if (pdev->id < 0 || pdev->id > 3)
+	if (pdata->core_chipsel < 0 || pdata->core_chipsel > 3)
 		return -ENODEV;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
@@ -683,7 +683,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	info->ioaddr		= (uint32_t __force) vaddr;
 
 	info->current_cs	= info->ioaddr;
-	info->core_chipsel	= pdev->id;
+	info->core_chipsel	= pdata->core_chipsel;
 	info->mask_chipsel	= pdata->mask_chipsel;
 
 	/* use nandboot-capable ALE/CLE masks by default */
-- 
2.17.0
