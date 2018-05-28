Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932580AbeE1LMA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424132AbeE1LLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:11:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 174/272] drm/meson: Fix some error handling paths in meson_drv_bind_master()
Date: Mon, 28 May 2018 12:03:27 +0200
Message-Id: <20180528100255.372503381@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 2c18107b9d58972588cd45d89b8f58d0f033c110 ]

If one of these functions fail, we whould free 'drm', as alreadry done in
the other error handling paths, below and above.

Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://patchwork.freedesktop.org/patch/msgid/df47e03d36c2cf7bc37ec3105fc47c16555bd946.1520885192.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/meson/meson_drv.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -189,35 +189,43 @@ static int meson_drv_bind_master(struct
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "vpu");
 	regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(regs))
-		return PTR_ERR(regs);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
+		goto free_drm;
+	}
 
 	priv->io_base = regs;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hhi");
 	/* Simply ioremap since it may be a shared register zone */
 	regs = devm_ioremap(dev, res->start, resource_size(res));
-	if (!regs)
-		return -EADDRNOTAVAIL;
+	if (!regs) {
+		ret = -EADDRNOTAVAIL;
+		goto free_drm;
+	}
 
 	priv->hhi = devm_regmap_init_mmio(dev, regs,
 					  &meson_regmap_config);
 	if (IS_ERR(priv->hhi)) {
 		dev_err(&pdev->dev, "Couldn't create the HHI regmap\n");
-		return PTR_ERR(priv->hhi);
+		ret = PTR_ERR(priv->hhi);
+		goto free_drm;
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmc");
 	/* Simply ioremap since it may be a shared register zone */
 	regs = devm_ioremap(dev, res->start, resource_size(res));
-	if (!regs)
-		return -EADDRNOTAVAIL;
+	if (!regs) {
+		ret = -EADDRNOTAVAIL;
+		goto free_drm;
+	}
 
 	priv->dmc = devm_regmap_init_mmio(dev, regs,
 					  &meson_regmap_config);
 	if (IS_ERR(priv->dmc)) {
 		dev_err(&pdev->dev, "Couldn't create the DMC regmap\n");
-		return PTR_ERR(priv->dmc);
+		ret = PTR_ERR(priv->dmc);
+		goto free_drm;
 	}
 
 	priv->vsync_irq = platform_get_irq(pdev, 0);
