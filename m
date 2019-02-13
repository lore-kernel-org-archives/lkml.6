Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38100C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032CB21934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026163;
	bh=WVdMNVfJ4i8y/xY3FTPgA1Vk3NMtw8XM87ZfVLszY94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZWVn75U1pKNFgVOQo0vyH11SA4n55NbA2N9t4u85n8N9OmQvHgneh+MaZhqcYWX1I
	 BXyc8ID1CU8krk1cyaucWy9peIquRiQFlrdHbjhnBI61cTesoZvmICi60F8T2IIl5H
	 m0pVXX/7EN+Y5AqV2impoVNWBmzChMBw83u8BA04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389145AbfBMCtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:49:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388884AbfBMCkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:40:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1FF4222CA;
        Wed, 13 Feb 2019 02:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025604;
        bh=WVdMNVfJ4i8y/xY3FTPgA1Vk3NMtw8XM87ZfVLszY94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AO977BWenjuZebchAXarzJp5DnUe6ssXQaUoI8MxV5dIz9zU0snKTwP8rMbHhRcXj
         hVmVAMWe540jxYCOdkCcmbFpZ4LS6zlv6CFYcin0c5YVOwpf3j4aLHYYC6cedIeoqU
         de0FgRDakdo+cMFPUXbBxO5bcvc9gKMBYDORv7Bg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Keerthy <j-keerthy@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 10/34] mfd: tps65218: Use devm_regmap_add_irq_chip and clean up error path in probe()
Date:   Tue, 12 Feb 2019 21:39:28 -0500
Message-Id: <20190213023952.21311-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023952.21311-1-sashal@kernel.org>
References: <20190213023952.21311-1-sashal@kernel.org>
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
index 13834a0d2817..612f5ecda78f 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -243,9 +243,9 @@ static int tps65218_probe(struct i2c_client *client,
 
 	mutex_init(&tps->tps_lock);
 
-	ret = regmap_add_irq_chip(tps->regmap, tps->irq,
-			IRQF_ONESHOT, 0, &tps65218_irq_chip,
-			&tps->irq_data);
+	ret = devm_regmap_add_irq_chip(&client->dev, tps->regmap, tps->irq,
+				       IRQF_ONESHOT, 0, &tps65218_irq_chip,
+				       &tps->irq_data);
 	if (ret < 0)
 		return ret;
 
@@ -261,26 +261,9 @@ static int tps65218_probe(struct i2c_client *client,
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
@@ -293,7 +276,6 @@ static struct i2c_driver tps65218_driver = {
 		.of_match_table = of_tps65218_match_table,
 	},
 	.probe		= tps65218_probe,
-	.remove		= tps65218_remove,
 	.id_table       = tps65218_id_table,
 };
 
-- 
2.19.1

