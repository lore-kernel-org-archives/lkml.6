Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF335ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6425920685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6425920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388362AbeGWVas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:30:48 -0400
Received: from sauhun.de ([88.99.104.3]:51248 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388070AbeGWV3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:29:48 -0400
Received: from localhost (p54B3377D.dip0.t-ipconnect.de [84.179.55.125])
        by pokefinder.org (Postfix) with ESMTPSA id 25AE1631A4C;
        Mon, 23 Jul 2018 22:26:54 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] i2c: mxs: use core to detect 'no zero length' quirk
Date:   Mon, 23 Jul 2018 22:26:07 +0200
Message-Id: <20180723202617.15230-4-wsa+renesas@sang-engineering.com>
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

 drivers/i2c/busses/i2c-mxs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 642c58946d8d..7d79317a1046 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -567,9 +567,6 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	dev_dbg(i2c->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
 		msg->addr, msg->len, msg->flags, stop);
 
-	if (msg->len == 0)
-		return -EINVAL;
-
 	/*
 	 * The MX28 I2C IP block can only do PIO READ for transfer of to up
 	 * 4 bytes of length. The write transfer is not limited as it can use
@@ -683,6 +680,10 @@ static const struct i2c_algorithm mxs_i2c_algo = {
 	.functionality = mxs_i2c_func,
 };
 
+static const struct i2c_adapter_quirks mxs_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
 static void mxs_i2c_derive_timing(struct mxs_i2c_dev *i2c, uint32_t speed)
 {
 	/* The I2C block clock runs at 24MHz */
@@ -854,6 +855,7 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	strlcpy(adap->name, "MXS I2C adapter", sizeof(adap->name));
 	adap->owner = THIS_MODULE;
 	adap->algo = &mxs_i2c_algo;
+	adap->quirks = &mxs_i2c_quirks;
 	adap->dev.parent = dev;
 	adap->nr = pdev->id;
 	adap->dev.of_node = pdev->dev.of_node;
-- 
2.11.0

