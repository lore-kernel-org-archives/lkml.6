Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34240C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE742207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550027138;
	bh=6go/5oR2NCf81JfMdR+mvnKz0r8TB1gXrYV3tsOWs0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OlTg2hLHG5S5IiSg3k+d2MA3+4WR68ZDe2+rtxdko1s7LmXt0meHASOSm4pVjqBVZ
	 pt6Xhq6n3EeqZcFUVK+Wd4/8qkAkfyivw02PKguy+71nvsALQF6iDbU4AOG5ONQeXy
	 QuDjkGJ9hEZFpq1jWezgdS+afA4/zfF6FymnmR2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390487AbfBMDFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:05:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387515AbfBMCd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:33:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C357F222BA;
        Wed, 13 Feb 2019 02:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025236;
        bh=6go/5oR2NCf81JfMdR+mvnKz0r8TB1gXrYV3tsOWs0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0FzQebUGcRFGDTPvk9WGu13G+EGfPd1A1ZlJlYgWBEB0K/koXFW9S7eH42cd8XU/p
         QMmitDAgliCfNv1AxD6OzdTTixsbZuDgfVhGv/jUWRkSpUIfYu9uJ4H6Xl2Oq3YkPo
         T74c65mMbihs0smwWT2ekUjioa9V8jHxaVs7xFn0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Keerthy <j-keerthy@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 019/105] mfd: tps65218: Use devm_regmap_add_irq_chip and clean up error path in probe()
Date:   Tue, 12 Feb 2019 21:32:10 -0500
Message-Id: <20190213023336.19019-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

[ Upstream commit 75d4c5e03c2ae9902ab521024b10291f6fc9515b ]

Use devm_regmap_add_irq_chip and clean up error path in probe
and also the remove function.

Reported-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/tps65218.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 910f569ff77c..8bcdecf494d0 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -235,9 +235,9 @@ static int tps65218_probe(struct i2c_client *client,
 
 	mutex_init(&tps->tps_lock);
 
-	ret = regmap_add_irq_chip(tps->regmap, tps->irq,
-			IRQF_ONESHOT, 0, &tps65218_irq_chip,
-			&tps->irq_data);
+	ret = devm_regmap_add_irq_chip(&client->dev, tps->regmap, tps->irq,
+				       IRQF_ONESHOT, 0, &tps65218_irq_chip,
+				       &tps->irq_data);
 	if (ret < 0)
 		return ret;
 
@@ -253,26 +253,9 @@ static int tps65218_probe(struct i2c_client *client,
 			      ARRAY_SIZE(tps65218_cells), NULL, 0,
 			      regmap_irq_get_domain(tps->irq_data));
 
-	if (ret < 0)
-		goto err_irq;
-
-	return 0;
-
-err_irq:
-	regmap_del_irq_chip(tps->irq, tps->irq_data);
-
 	return ret;
 }
 
-static int tps65218_remove(struct i2c_client *client)
-{
-	struct tps65218 *tps = i2c_get_clientdata(client);
-
-	regmap_del_irq_chip(tps->irq, tps->irq_data);
-
-	return 0;
-}
-
 static const struct i2c_device_id tps65218_id_table[] = {
 	{ "tps65218", TPS65218 },
 	{ },
@@ -285,7 +268,6 @@ static struct i2c_driver tps65218_driver = {
 		.of_match_table = of_tps65218_match_table,
 	},
 	.probe		= tps65218_probe,
-	.remove		= tps65218_remove,
 	.id_table       = tps65218_id_table,
 };
 
-- 
2.19.1

