Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A859C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FB7223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Priu/Ofk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FB7223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbeKOI1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:27:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728895AbeKOI1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:23 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E43622511;
        Wed, 14 Nov 2018 22:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234140;
        bh=gYWCMeLntYRCFq2khA6yuYLx0cObBt/t6DcHo51WtG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Priu/OfkCrFI70ra8+K8x8NF1Hqt/1K2W6/ZyDYZd83o/c7r/3AziJ7n+0YCUV7DQ
         QWdKA8iGa4SnN4BgONreEGqlkk4zxrSZ8hcZHpcTnCqVSRaAvDuOVP/mLKqt0ZNoTs
         y0/guMI/SrSDIgXVJKJvEF33112pgSHGwJ0nE0HI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 51/73] i2c: qcom-geni: Fix runtime PM mismatch with child devices
Date:   Wed, 14 Nov 2018 17:21:45 -0500
Message-Id: <20181114222207.98701-51-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit 848bd3f3de9d44950c00eda6c115e8e9785440da ]

We need to enable runtime PM on this i2c controller before populating
child devices with i2c_add_adapter(). Otherwise, if a child device uses
runtime PM and stays runtime PM enabled we'll get the following warning
at boot.

 Enabling runtime PM for inactive device (a98000.i2c) with active children

[...]

 Call trace:
  pm_runtime_enable+0xd8/0xf8
  geni_i2c_probe+0x440/0x460
  platform_drv_probe+0x74/0xc8
[...]

Let's move the runtime PM enabling and setup to before we add the
adapter, so that this device can respond to runtime PM requests from
children.

Fixes: 37692de5d523 ("i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C controller")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 9f2eb02481d3..d7329177b0ea 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -590,18 +590,19 @@ static int geni_i2c_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "i2c fifo/se-dma mode. fifo depth:%d\n", tx_depth);
 
-	ret = i2c_add_adapter(&gi2c->adap);
-	if (ret) {
-		dev_err(&pdev->dev, "Error adding i2c adapter %d\n", ret);
-		return ret;
-	}
-
 	gi2c->suspended = 1;
 	pm_runtime_set_suspended(gi2c->se.dev);
 	pm_runtime_set_autosuspend_delay(gi2c->se.dev, I2C_AUTO_SUSPEND_DELAY);
 	pm_runtime_use_autosuspend(gi2c->se.dev);
 	pm_runtime_enable(gi2c->se.dev);
 
+	ret = i2c_add_adapter(&gi2c->adap);
+	if (ret) {
+		dev_err(&pdev->dev, "Error adding i2c adapter %d\n", ret);
+		pm_runtime_disable(gi2c->se.dev);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -609,8 +610,8 @@ static int geni_i2c_remove(struct platform_device *pdev)
 {
 	struct geni_i2c_dev *gi2c = platform_get_drvdata(pdev);
 
-	pm_runtime_disable(gi2c->se.dev);
 	i2c_del_adapter(&gi2c->adap);
+	pm_runtime_disable(gi2c->se.dev);
 	return 0;
 }
 
-- 
2.17.1

