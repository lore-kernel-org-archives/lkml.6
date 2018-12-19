Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876FCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DFE217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbeLSQtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:49:47 -0500
Received: from sauhun.de ([88.99.104.3]:55886 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729963AbeLSQsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:48:38 -0500
Received: from localhost (p54B333DA.dip0.t-ipconnect.de [84.179.51.218])
        by pokefinder.org (Postfix) with ESMTPSA id A29CF2E35D1;
        Wed, 19 Dec 2018 17:48:36 +0100 (CET)
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
Subject: [PATCH 04/10] i2c: brcmstb: use core helper to mark adapter suspended
Date:   Wed, 19 Dec 2018 17:48:20 +0100
Message-Id: <20181219164827.20985-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rejecting transfers should be handled by the core.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/i2c/busses/i2c-brcmstb.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 826d32049996..f4d862234980 100644
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
+	i2c_mark_adapter_suspended(&i2c_dev->adapter);
 	return 0;
 }
 
@@ -700,10 +693,8 @@ static int brcmstb_i2c_resume(struct device *dev)
 {
 	struct brcmstb_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 
-	i2c_lock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
 	brcmstb_i2c_set_bsc_reg_defaults(i2c_dev);
-	i2c_dev->is_suspended = false;
-	i2c_unlock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
+	i2c_mark_adapter_resumed(&i2c_dev->adapter);
 
 	return 0;
 }
-- 
2.11.0

