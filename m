Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93ABC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B615621734
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129413;
	bh=ctZOrGfFk/qVkklWnvxAYjawha5gd5D0/fgOzN1sobM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NMEFB0jlJDbouZ5M+iIH25VjmK1isMxvxUHd2ySXnkePGuWgqhY2vUvBFVwqqSpOz
	 Foen66zjr6ExIsWeX4k1u34j/dM6Kyj9IeC+ky1O6zGP1aXNE3P4XRA0xShyow4AWL
	 pacMIi135CKW6pZvCUjMo4QbAUEyuTWpHioHtsRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfBYVQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:16:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729771AbfBYVQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:16:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86ED821734;
        Mon, 25 Feb 2019 21:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129405;
        bh=ctZOrGfFk/qVkklWnvxAYjawha5gd5D0/fgOzN1sobM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9HXu7V8vJPb8DVfoOqa2rsFYqqw9SCWlXC2um6XnxCN6c02DhQu2MHJIGm/cWqtq
         BzOmYaxZ5kKeNKc1RBEG1PhnHKf3nC20BiIIgFOeBv49a6EowLjh4/ml1+SDFKOyqf
         p2S6UKQCB0C294RdZ9/JFbZV9GnL1WHDoG2YCQo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>,
        Keerthy <j-keerthy@ti.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 20/71] mfd: tps65218: Use devm_regmap_add_irq_chip and clean up error path in probe()
Date:   Mon, 25 Feb 2019 22:11:22 +0100
Message-Id: <20190225195036.032688162@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 13834a0d28172..612f5ecda78fa 100644
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



