Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A363DECDFBB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFFE20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFFE20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbeGWV3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:29:51 -0400
Received: from sauhun.de ([88.99.104.3]:51266 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388201AbeGWV3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:29:50 -0400
Received: from localhost (p54B3377D.dip0.t-ipconnect.de [84.179.55.125])
        by pokefinder.org (Postfix) with ESMTPSA id D17CC631A4A;
        Mon, 23 Jul 2018 22:26:56 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] i2c: stu300: use core to detect 'no zero length' quirk
Date:   Mon, 23 Jul 2018 22:26:11 +0200
Message-Id: <20180723202617.15230-8-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And don't reimplement in the driver.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Only build tested.

 drivers/i2c/busses/i2c-stu300.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index fce52bdab2b7..5503fa171df0 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -673,12 +673,6 @@ static int stu300_xfer_msg(struct i2c_adapter *adap,
 			msg->addr, msg->len, msg->flags, stop);
 	}
 
-	/* Zero-length messages are not supported by this hardware */
-	if (msg->len == 0) {
-		ret = -EINVAL;
-		goto exit_disable;
-	}
-
 	/*
 	 * For some reason, sending the address sometimes fails when running
 	 * on  the 13 MHz clock. No interrupt arrives. This is a work around,
@@ -863,6 +857,10 @@ static const struct i2c_algorithm stu300_algo = {
 	.functionality	= stu300_func,
 };
 
+static const struct i2c_adapter_quirks stu300_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
 static int stu300_probe(struct platform_device *pdev)
 {
 	struct stu300_dev *dev;
@@ -920,6 +918,8 @@ static int stu300_probe(struct platform_device *pdev)
 	adap->algo = &stu300_algo;
 	adap->dev.parent = &pdev->dev;
 	adap->dev.of_node = pdev->dev.of_node;
+	adap->quirks = &stu300_quirks;
+
 	i2c_set_adapdata(adap, dev);
 
 	/* i2c device drivers may be active on return from add_adapter() */
-- 
2.11.0

