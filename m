Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E584BC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CB82082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CB82082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbeLJVEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:04:07 -0500
Received: from sauhun.de ([88.99.104.3]:36716 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729921AbeLJVDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:03:18 -0500
Received: from localhost (p54B335CF.dip0.t-ipconnect.de [84.179.53.207])
        by pokefinder.org (Postfix) with ESMTPSA id A7ECC4C3C71;
        Mon, 10 Dec 2018 22:03:16 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC/RFT 05/10] i2c: zx2967: use core helper to mark adapter suspended
Date:   Mon, 10 Dec 2018 22:03:03 +0100
Message-Id: <20181210210310.12677-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rejecting transfers should be handled by the core. Also, this will
ensure proper locking which was forgotten in this open coded version
and make sure resume mark is set after enabling clocks (not before).

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-zx2967.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-zx2967.c b/drivers/i2c/busses/i2c-zx2967.c
index b8f9e020d80e..9fa48bbe0719 100644
--- a/drivers/i2c/busses/i2c-zx2967.c
+++ b/drivers/i2c/busses/i2c-zx2967.c
@@ -66,7 +66,6 @@ struct zx2967_i2c {
 	int			msg_rd;
 	u8			*cur_trans;
 	u8			access_cnt;
-	bool			is_suspended;
 	int			error;
 };
 
@@ -313,9 +312,6 @@ static int zx2967_i2c_xfer(struct i2c_adapter *adap,
 	int ret;
 	int i;
 
-	if (i2c->is_suspended)
-		return -EBUSY;
-
 	zx2967_set_addr(i2c, msgs->addr);
 
 	for (i = 0; i < num; i++) {
@@ -470,7 +466,7 @@ static int __maybe_unused zx2967_i2c_suspend(struct device *dev)
 {
 	struct zx2967_i2c *i2c = dev_get_drvdata(dev);
 
-	i2c->is_suspended = true;
+	i2c_mark_adapter_suspended(&i2c->adap, true);
 	clk_disable_unprepare(i2c->clk);
 
 	return 0;
@@ -480,8 +476,8 @@ static int __maybe_unused zx2967_i2c_resume(struct device *dev)
 {
 	struct zx2967_i2c *i2c = dev_get_drvdata(dev);
 
-	i2c->is_suspended = false;
 	clk_prepare_enable(i2c->clk);
+	i2c_mark_adapter_suspended(&i2c->adap, false);
 
 	return 0;
 }
-- 
2.11.0

