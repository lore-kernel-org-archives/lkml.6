Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeCNT6Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:58:25 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:20448 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751430AbeCNT56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:57:58 -0400
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 14 Mar 2018 20:57:57 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/3] remoteproc: imx_rproc: Re-use existing error handling path in 'imx_rproc_probe()'
Date: Wed, 14 Mar 2018 20:56:38 +0100
Message-Id: <2b1b1c3ebd6798ac456affb0bb6580016f17afe8.1521057013.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1521057013.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521057013.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1521057013.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521057013.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid some code ducplication and be more future-proof.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/remoteproc/imx_rproc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 05bcbce2013a..6d02ef62a626 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -361,8 +361,8 @@ static int imx_rproc_probe(struct platform_device *pdev)
 	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(dev, "Failed to get clock\n");
-		rproc_free(rproc);
-		return PTR_ERR(priv->clk);
+		ret = PTR_ERR(priv->clk);
+		goto err_put_rproc;
 	}
 
 	/*
@@ -372,8 +372,7 @@ static int imx_rproc_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(priv->clk);
 	if (ret) {
 		dev_err(&rproc->dev, "Failed to enable clock\n");
-		rproc_free(rproc);
-		return ret;
+		goto err_put_rproc;
 	}
 
 	ret = rproc_add(rproc);
-- 
2.14.1
