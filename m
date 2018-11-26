Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E843C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA42820672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kpju2SIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA42820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbeKZWAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:00:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:47060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbeKZWAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:00:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAC5020645;
        Mon, 26 Nov 2018 11:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230390;
        bh=VcWrju7b4gxuc3QUd31rkgd8beeU/0qkOEIgduKtwQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kpju2SIvtIIhbOS2mLkhHq6OgiFdfnITiMeMSP51b1qYU0Phd9sFGRMAEaZEwv0So
         S7//dgdd85SlTjK/47SKMQ0ccx8TY9IbDtP3Vr9A79RMc4GveyzkL8OLvVSBQhJspI
         FyWd92yAtAf2wDNafX0ENuW03jxW45vq101X+qoc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 073/118] i2c: qcom-geni: Fix runtime PM mismatch with child devices
Date:   Mon, 26 Nov 2018 11:51:07 +0100
Message-Id: <20181126105104.336966682@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



