Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41526C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266B421509
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266B421509
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeHOXF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:05:29 -0400
Received: from mail.ispras.ru ([83.149.199.45]:47970 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbeHOXF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:05:29 -0400
Received: from localhost.localdomain (ppp85-140-179-125.pppoe.mtu-net.ru [85.140.179.125])
        by mail.ispras.ru (Postfix) with ESMTPSA id 34872540089;
        Wed, 15 Aug 2018 23:11:49 +0300 (MSK)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] media: ov772x: Disable clk on error path
Date:   Wed, 15 Aug 2018 23:10:39 +0300
Message-Id: <1534363839-28509-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ov772x_power_on() is unable to get GPIO rstb,
the clock is left undisabled.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/media/i2c/ov772x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/ov772x.c b/drivers/media/i2c/ov772x.c
index e2550708abc8..7b62bf1fc5b1 100644
--- a/drivers/media/i2c/ov772x.c
+++ b/drivers/media/i2c/ov772x.c
@@ -828,6 +828,7 @@ static int ov772x_power_on(struct ov772x_priv *priv)
 					     GPIOD_OUT_LOW);
 	if (IS_ERR(priv->rstb_gpio)) {
 		dev_info(&client->dev, "Unable to get GPIO \"rstb\"");
+		clk_disable_unprepare(priv->clk);
 		return PTR_ERR(priv->rstb_gpio);
 	}
 
-- 
2.7.4

