Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B36ECDE45
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088D72083C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088D72083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeJVEQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:16:26 -0400
Received: from sauhun.de ([88.99.104.3]:45962 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728644AbeJVEQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:16:25 -0400
Received: from localhost (unknown [90.200.225.72])
        by pokefinder.org (Postfix) with ESMTPSA id 393E22E35DF;
        Sun, 21 Oct 2018 22:00:57 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH 3/5] thermal: spear_thermal: simplify getting .driver_data
Date:   Sun, 21 Oct 2018 22:00:50 +0200
Message-Id: <20181021200053.2194-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021200053.2194-1-wsa+renesas@sang-engineering.com>
References: <20181021200053.2194-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/thermal/spear_thermal.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 81b35aace9de..8b9d567134d0 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -56,8 +56,7 @@ static struct thermal_zone_device_ops ops = {
 
 static int __maybe_unused spear_thermal_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct thermal_zone_device *spear_thermal = platform_get_drvdata(pdev);
+	struct thermal_zone_device *spear_thermal = dev_get_drvdata(dev);
 	struct spear_thermal_dev *stdev = spear_thermal->devdata;
 	unsigned int actual_mask = 0;
 
@@ -73,15 +72,14 @@ static int __maybe_unused spear_thermal_suspend(struct device *dev)
 
 static int __maybe_unused spear_thermal_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct thermal_zone_device *spear_thermal = platform_get_drvdata(pdev);
+	struct thermal_zone_device *spear_thermal = dev_get_drvdata(dev);
 	struct spear_thermal_dev *stdev = spear_thermal->devdata;
 	unsigned int actual_mask = 0;
 	int ret = 0;
 
 	ret = clk_enable(stdev->clk);
 	if (ret) {
-		dev_err(&pdev->dev, "Can't enable clock\n");
+		dev_err(dev, "Can't enable clock\n");
 		return ret;
 	}
 
-- 
2.19.0

