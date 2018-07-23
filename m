Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42A3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AB220685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AB220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbeGWV3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:29:48 -0400
Received: from sauhun.de ([88.99.104.3]:51238 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388064AbeGWV3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:29:47 -0400
Received: from localhost (p54B3377D.dip0.t-ipconnect.de [84.179.55.125])
        by pokefinder.org (Postfix) with ESMTPSA id 7620A631A4B;
        Mon, 23 Jul 2018 22:26:53 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] i2c: designware-master: use core to detect 'no zero length' quirk
Date:   Mon, 23 Jul 2018 22:26:06 +0200
Message-Id: <20180723202617.15230-3-wsa+renesas@sang-engineering.com>
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

 drivers/i2c/busses/i2c-designware-master.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index fc7c255c80af..a1717bff06a8 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -274,13 +274,6 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			break;
 		}
 
-		if (msgs[dev->msg_write_idx].len == 0) {
-			dev_err(dev->dev,
-				"%s: invalid message length\n", __func__);
-			dev->msg_err = -EINVAL;
-			break;
-		}
-
 		if (!(dev->status & STATUS_WRITE_IN_PROGRESS)) {
 			/* new i2c_msg */
 			buf = msgs[dev->msg_write_idx].buf;
@@ -523,6 +516,10 @@ static const struct i2c_algorithm i2c_dw_algo = {
 	.functionality = i2c_dw_func,
 };
 
+static const struct i2c_adapter_quirks i2c_dw_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
 static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 {
 	u32 stat;
@@ -718,6 +715,7 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 		 "Synopsys DesignWare I2C adapter");
 	adap->retries = 3;
 	adap->algo = &i2c_dw_algo;
+	adap->quirks = &i2c_dw_quirks;
 	adap->dev.parent = dev->dev;
 	i2c_set_adapdata(adap, dev);
 
-- 
2.11.0

