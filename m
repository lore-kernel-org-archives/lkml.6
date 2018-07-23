Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8996ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDDB20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EDDB20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388238AbeGWV3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:29:50 -0400
Received: from sauhun.de ([88.99.104.3]:51256 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388149AbeGWV3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:29:49 -0400
Received: from localhost (p54B3377D.dip0.t-ipconnect.de [84.179.55.125])
        by pokefinder.org (Postfix) with ESMTPSA id 7A2A1631A4E;
        Mon, 23 Jul 2018 22:26:55 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] i2c: pmcmsp: use core to detect 'no zero length' quirk
Date:   Mon, 23 Jul 2018 22:26:09 +0200
Message-Id: <20180723202617.15230-6-wsa+renesas@sang-engineering.com>
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

 drivers/i2c/busses/i2c-pmcmsp.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index dae8ac618a52..0829cb696d9d 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -444,16 +444,6 @@ static enum pmcmsptwi_xfer_result pmcmsptwi_xfer_cmd(
 {
 	enum pmcmsptwi_xfer_result retval;
 
-	if ((cmd->type == MSP_TWI_CMD_WRITE && cmd->write_len == 0) ||
-	    (cmd->type == MSP_TWI_CMD_READ && cmd->read_len == 0) ||
-	    (cmd->type == MSP_TWI_CMD_WRITE_READ &&
-	    (cmd->read_len == 0 || cmd->write_len == 0))) {
-		dev_err(&pmcmsptwi_adapter.dev,
-			"%s: Cannot transfer less than 1 byte\n",
-			__func__);
-		return -EINVAL;
-	}
-
 	mutex_lock(&data->lock);
 	dev_dbg(&pmcmsptwi_adapter.dev,
 		"Setting address to 0x%04x\n", cmd->addr);
@@ -532,11 +522,6 @@ static int pmcmsptwi_master_xfer(struct i2c_adapter *adap,
 		cmd.write_data = msg->buf;
 	}
 
-	if (msg->len == 0) {
-		dev_err(&adap->dev, "Zero-byte messages unsupported\n");
-		return -EINVAL;
-	}
-
 	cmd.addr = msg->addr;
 
 	if (msg->flags & I2C_M_TEN) {
@@ -578,7 +563,7 @@ static u32 pmcmsptwi_i2c_func(struct i2c_adapter *adapter)
 }
 
 static const struct i2c_adapter_quirks pmcmsptwi_i2c_quirks = {
-	.flags = I2C_AQ_COMB_WRITE_THEN_READ,
+	.flags = I2C_AQ_COMB_WRITE_THEN_READ | I2C_AQ_NO_ZERO_LEN,
 	.max_write_len = MSP_MAX_BYTES_PER_RW,
 	.max_read_len = MSP_MAX_BYTES_PER_RW,
 	.max_comb_1st_msg_len = MSP_MAX_BYTES_PER_RW,
-- 
2.11.0

