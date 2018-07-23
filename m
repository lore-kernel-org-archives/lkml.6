Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB39ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521D220874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521D220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388296AbeGWV3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:29:54 -0400
Received: from sauhun.de ([88.99.104.3]:51260 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388271AbeGWV3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:29:52 -0400
Received: from localhost (p54B3377D.dip0.t-ipconnect.de [84.179.55.125])
        by pokefinder.org (Postfix) with ESMTPSA id 019D7631A4E;
        Mon, 23 Jul 2018 22:26:58 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] i2c: zx2967: use core to detect 'no zero length' quirk
Date:   Mon, 23 Jul 2018 22:26:13 +0200
Message-Id: <20180723202617.15230-10-wsa+renesas@sang-engineering.com>
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

 drivers/i2c/busses/i2c-zx2967.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-zx2967.c b/drivers/i2c/busses/i2c-zx2967.c
index 48281c1b30c6..b8f9e020d80e 100644
--- a/drivers/i2c/busses/i2c-zx2967.c
+++ b/drivers/i2c/busses/i2c-zx2967.c
@@ -281,9 +281,6 @@ static int zx2967_i2c_xfer_msg(struct zx2967_i2c *i2c,
 	int ret;
 	int i;
 
-	if (msg->len == 0)
-		return -EINVAL;
-
 	zx2967_i2c_flush_fifos(i2c);
 
 	i2c->cur_trans = msg->buf;
@@ -498,6 +495,10 @@ static const struct i2c_algorithm zx2967_i2c_algo = {
 	.functionality = zx2967_i2c_func,
 };
 
+static const struct i2c_adapter_quirks zx2967_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
 static const struct of_device_id zx2967_i2c_of_match[] = {
 	{ .compatible = "zte,zx296718-i2c", },
 	{ },
@@ -568,6 +569,7 @@ static int zx2967_i2c_probe(struct platform_device *pdev)
 	strlcpy(i2c->adap.name, "zx2967 i2c adapter",
 		sizeof(i2c->adap.name));
 	i2c->adap.algo = &zx2967_i2c_algo;
+	i2c->adap.quirks = &zx2967_i2c_quirks;
 	i2c->adap.nr = pdev->id;
 	i2c->adap.dev.parent = &pdev->dev;
 	i2c->adap.dev.of_node = pdev->dev.of_node;
-- 
2.11.0

