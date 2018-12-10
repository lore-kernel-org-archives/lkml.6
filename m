Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED115C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94F72082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94F72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbeLJVEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:04:04 -0500
Received: from sauhun.de ([88.99.104.3]:36710 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729910AbeLJVDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:03:18 -0500
Received: from localhost (p54B335CF.dip0.t-ipconnect.de [84.179.53.207])
        by pokefinder.org (Postfix) with ESMTPSA id E8F174C3C6E;
        Mon, 10 Dec 2018 22:03:15 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: [RFC/RFT 04/10] i2c: brcmstb: use core helper to mark adapter suspended
Date:   Mon, 10 Dec 2018 22:03:02 +0100
Message-Id: <20181210210310.12677-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rejecting transfers should be handled by the core.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-brcmstb.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 826d32049996..05c822e5a3f6 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -170,7 +170,6 @@ struct brcmstb_i2c_dev {
 	struct bsc_regs *bsc_regmap;
 	struct i2c_adapter adapter;
 	struct completion done;
-	bool is_suspended;
 	u32 clk_freq_hz;
 	int data_regsz;
 };
@@ -467,9 +466,6 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
 	int xfersz = brcmstb_i2c_get_xfersz(dev);
 	u32 cond, cond_per_msg;
 
-	if (dev->is_suspended)
-		return -EBUSY;
-
 	/* Loop through all messages */
 	for (i = 0; i < num; i++) {
 		pmsg = &msgs[i];
@@ -689,10 +685,7 @@ static int brcmstb_i2c_suspend(struct device *dev)
 {
 	struct brcmstb_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 
-	i2c_lock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
-	i2c_dev->is_suspended = true;
-	i2c_unlock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
-
+	i2c_mark_adapter_suspended(&i2c_dev->adapter, true);
 	return 0;
 }
 
@@ -700,10 +693,8 @@ static int brcmstb_i2c_resume(struct device *dev)
 {
 	struct brcmstb_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 
-	i2c_lock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
 	brcmstb_i2c_set_bsc_reg_defaults(i2c_dev);
-	i2c_dev->is_suspended = false;
-	i2c_unlock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
+	i2c_mark_adapter_suspended(&i2c_dev->adapter, false);
 
 	return 0;
 }
-- 
2.11.0

