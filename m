Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeCNVsD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 17:48:03 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:53518 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbeCNVsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 17:48:02 -0400
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 14 Mar 2018 22:48:00 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mfd: pcf50633: Fix some memory leaks in the error handling path of 'pcf50633_probe()'
Date: Wed, 14 Mar 2018 22:47:55 +0100
Message-Id: <20180314214755.25853-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a 'platform_device_alloc()' call fails, we still need to release the
resources that have already been allocated before returning.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mfd/pcf50633-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/pcf50633-core.c b/drivers/mfd/pcf50633-core.c
index f952dff6765f..0d2a88d53eed 100644
--- a/drivers/mfd/pcf50633-core.c
+++ b/drivers/mfd/pcf50633-core.c
@@ -242,8 +242,10 @@ static int pcf50633_probe(struct i2c_client *client,
 
 	for (i = 0; i < PCF50633_NUM_REGULATORS; i++) {
 		pdev = platform_device_alloc("pcf50633-regulator", i);
-		if (!pdev)
-			return -ENOMEM;
+		if (!pdev) {
+			ret = -ENOMEM;
+			goto err2;
+		}
 
 		pdev->dev.parent = pcf->dev;
 		ret = platform_device_add_data(pdev, &pdata->reg_init_data[i],
@@ -269,6 +271,7 @@ static int pcf50633_probe(struct i2c_client *client,
 
 err:
 	platform_device_put(pdev);
+err2:
 	for (j = 0; j < i; j++)
 		platform_device_put(pcf->regulator_pdev[j]);
 
-- 
2.14.1
