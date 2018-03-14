Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeCNT6A (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:58:00 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:29519 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbeCNT55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:57:57 -0400
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 14 Mar 2018 20:57:56 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/3] remoteproc: imx_rproc: Fix an error handling path in 'imx_rproc_probe()'
Date: Wed, 14 Mar 2018 20:56:37 +0100
Message-Id: <f944d560ce1b1573be00697d66c4a49b14680af9.1521057013.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1521057013.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521057013.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1521057013.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521057013.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'of_device_get_match_data()' fails, we must undo the previous
'rproc_alloc()' call.

Fixes: a0ff4aa6f010 ("remoteproc: imx_rproc: add a NXP/Freescale imx_rproc driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/remoteproc/imx_rproc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 633268e9d550..05bcbce2013a 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -339,8 +339,10 @@ static int imx_rproc_probe(struct platform_device *pdev)
 	}
 
 	dcfg = of_device_get_match_data(dev);
-	if (!dcfg)
-		return -EINVAL;
+	if (!dcfg) {
+		ret = -EINVAL;
+		goto err_put_rproc;
+	}
 
 	priv = rproc->priv;
 	priv->rproc = rproc;
-- 
2.14.1
