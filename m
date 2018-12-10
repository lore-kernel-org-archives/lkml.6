Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494C3C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150162084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150162084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbeLJVDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:03:23 -0500
Received: from sauhun.de ([88.99.104.3]:36726 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbeLJVDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:03:19 -0500
Received: from localhost (p54B335CF.dip0.t-ipconnect.de [84.179.53.207])
        by pokefinder.org (Postfix) with ESMTPSA id 64A034C3C75;
        Mon, 10 Dec 2018 22:03:17 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC/RFT 06/10] i2c: sprd: don't use pdev as variable name for struct device *
Date:   Mon, 10 Dec 2018 22:03:04 +0100
Message-Id: <20181210210310.12677-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer to a device is usually named 'dev'. These 'pdev' here look
much like copy&paste errors. Fix them to avoid confusion.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sprd.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index a94e724f51dc..e266d8a713d9 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -586,40 +586,40 @@ static int sprd_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused sprd_i2c_suspend_noirq(struct device *pdev)
+static int __maybe_unused sprd_i2c_suspend_noirq(struct device *dev)
 {
-	struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
+	struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
 
 	i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
 	i2c_dev->is_suspended = true;
 	i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
 
-	return pm_runtime_force_suspend(pdev);
+	return pm_runtime_force_suspend(dev);
 }
 
-static int __maybe_unused sprd_i2c_resume_noirq(struct device *pdev)
+static int __maybe_unused sprd_i2c_resume_noirq(struct device *dev)
 {
-	struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
+	struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
 
 	i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
 	i2c_dev->is_suspended = false;
 	i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
 
-	return pm_runtime_force_resume(pdev);
+	return pm_runtime_force_resume(dev);
 }
 
-static int __maybe_unused sprd_i2c_runtime_suspend(struct device *pdev)
+static int __maybe_unused sprd_i2c_runtime_suspend(struct device *dev)
 {
-	struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
+	struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
 
 	clk_disable_unprepare(i2c_dev->clk);
 
 	return 0;
 }
 
-static int __maybe_unused sprd_i2c_runtime_resume(struct device *pdev)
+static int __maybe_unused sprd_i2c_runtime_resume(struct device *dev)
 {
-	struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
+	struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
 	int ret;
 
 	ret = clk_prepare_enable(i2c_dev->clk);
-- 
2.11.0

