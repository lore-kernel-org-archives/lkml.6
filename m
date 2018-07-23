Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DC4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCCE20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCCE20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbeGWV34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:29:56 -0400
Received: from sauhun.de ([88.99.104.3]:51290 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388280AbeGWV3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:29:55 -0400
Received: from localhost (p54B3377D.dip0.t-ipconnect.de [84.179.55.125])
        by pokefinder.org (Postfix) with ESMTPSA id B5D24631A53;
        Mon, 23 Jul 2018 22:27:01 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] i2c: xlr: use core to detect 'no zero length' quirk
Date:   Mon, 23 Jul 2018 22:26:15 +0200
Message-Id: <20180723202617.15230-12-wsa+renesas@sang-engineering.com>
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

 drivers/i2c/busses/i2c-xlr.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
index 484bfa15d58e..34cd4b308540 100644
--- a/drivers/i2c/busses/i2c-xlr.c
+++ b/drivers/i2c/busses/i2c-xlr.c
@@ -173,9 +173,6 @@ static int xlr_i2c_tx(struct xlr_i2c_private *priv,  u16 len,
 	u8 offset;
 	u32 xfer;
 
-	if (!len)
-		return -EOPNOTSUPP;
-
 	offset = buf[0];
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_ADDR, offset);
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_DEVADDR, addr);
@@ -241,9 +238,6 @@ static int xlr_i2c_rx(struct xlr_i2c_private *priv, u16 len, u8 *buf, u16 addr)
 	unsigned long timeout, stoptime, checktime;
 	int nbytes, timedout;
 
-	if (!len)
-		return -EOPNOTSUPP;
-
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG,
 			XLR_I2C_CFG_NOADDR | priv->cfg->cfg_extra);
 	xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len - 1);
@@ -340,6 +334,10 @@ static const struct i2c_algorithm xlr_i2c_algo = {
 	.functionality	= xlr_func,
 };
 
+static const struct i2c_adapter_quirks xlr_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
 static const struct xlr_i2c_config xlr_i2c_config_default = {
 	.status_busy	= XLR_I2C_BUS_BUSY,
 	.cfg_extra	= 0,
@@ -427,6 +425,7 @@ static int xlr_i2c_probe(struct platform_device *pdev)
 	priv->adap.owner	= THIS_MODULE;
 	priv->adap.algo_data	= priv;
 	priv->adap.algo		= &xlr_i2c_algo;
+	priv->adap.quirks	= &xlr_i2c_quirks;
 	priv->adap.nr		= pdev->id;
 	priv->adap.class	= I2C_CLASS_HWMON;
 	snprintf(priv->adap.name, sizeof(priv->adap.name), "xlr-i2c");
-- 
2.11.0

