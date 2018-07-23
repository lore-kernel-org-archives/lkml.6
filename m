Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D39ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A51420685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A51420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388341AbeGWVaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:30:01 -0400
Received: from sauhun.de ([88.99.104.3]:51256 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388149AbeGWV34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:29:56 -0400
Received: from localhost (p54B3377D.dip0.t-ipconnect.de [84.179.55.125])
        by pokefinder.org (Postfix) with ESMTPSA id 6B120631A54;
        Mon, 23 Jul 2018 22:27:02 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] i2c: sh_mobile: use core to detect 'no zero length read' quirk
Date:   Mon, 23 Jul 2018 22:26:16 +0200
Message-Id: <20180723202617.15230-13-wsa+renesas@sang-engineering.com>
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

 drivers/i2c/busses/i2c-sh_mobile.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 5fda4188a9e5..9c7f6f8ceb22 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -613,11 +613,6 @@ static void sh_mobile_i2c_xfer_dma(struct sh_mobile_i2c_data *pd)
 static int start_ch(struct sh_mobile_i2c_data *pd, struct i2c_msg *usr_msg,
 		    bool do_init)
 {
-	if (usr_msg->len == 0 && (usr_msg->flags & I2C_M_RD)) {
-		dev_err(pd->dev, "Unsupported zero length i2c read\n");
-		return -EOPNOTSUPP;
-	}
-
 	if (do_init) {
 		/* Initialize channel registers */
 		iic_wr(pd, ICCR, ICCR_SCP);
@@ -758,6 +753,10 @@ static const struct i2c_algorithm sh_mobile_i2c_algorithm = {
 	.master_xfer	= sh_mobile_i2c_xfer,
 };
 
+static const struct i2c_adapter_quirks sh_mobile_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN_READ,
+};
+
 /*
  * r8a7740 chip has lasting errata on I2C I/O pad reset.
  * this is work-around for it.
@@ -925,6 +924,7 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 
 	adap->owner = THIS_MODULE;
 	adap->algo = &sh_mobile_i2c_algorithm;
+	adap->quirks = &sh_mobile_i2c_quirks;
 	adap->dev.parent = &dev->dev;
 	adap->retries = 5;
 	adap->nr = dev->id;
-- 
2.11.0

