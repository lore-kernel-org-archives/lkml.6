Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF45ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2E12083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2E12083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeJVEP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:15:29 -0400
Received: from sauhun.de ([88.99.104.3]:45604 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbeJVEP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:15:29 -0400
Received: from localhost (unknown [90.200.225.72])
        by pokefinder.org (Postfix) with ESMTPSA id EEA192E35C3;
        Sun, 21 Oct 2018 22:00:00 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/1] bus: brcmstb_gisb: simplify getting .driver_data
Date:   Sun, 21 Oct 2018 21:59:58 +0200
Message-Id: <20181021195958.1412-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021195958.1412-1-wsa+renesas@sang-engineering.com>
References: <20181021195958.1412-1-wsa+renesas@sang-engineering.com>
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

 drivers/bus/brcmstb_gisb.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 68ac3e93b600..f58ff67e97ac 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -150,8 +150,7 @@ static ssize_t gisb_arb_get_timeout(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct brcmstb_gisb_arb_device *gdev = platform_get_drvdata(pdev);
+	struct brcmstb_gisb_arb_device *gdev = dev_get_drvdata(dev);
 	u32 timeout;
 
 	mutex_lock(&gdev->lock);
@@ -165,8 +164,7 @@ static ssize_t gisb_arb_set_timeout(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct brcmstb_gisb_arb_device *gdev = platform_get_drvdata(pdev);
+	struct brcmstb_gisb_arb_device *gdev = dev_get_drvdata(dev);
 	int val, ret;
 
 	ret = kstrtoint(buf, 10, &val);
@@ -418,8 +416,7 @@ static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int brcmstb_gisb_arb_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct brcmstb_gisb_arb_device *gdev = platform_get_drvdata(pdev);
+	struct brcmstb_gisb_arb_device *gdev = dev_get_drvdata(dev);
 
 	gdev->saved_timeout = gisb_read(gdev, ARB_TIMER);
 
@@ -431,8 +428,7 @@ static int brcmstb_gisb_arb_suspend(struct device *dev)
  */
 static int brcmstb_gisb_arb_resume_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct brcmstb_gisb_arb_device *gdev = platform_get_drvdata(pdev);
+	struct brcmstb_gisb_arb_device *gdev = dev_get_drvdata(dev);
 
 	gisb_write(gdev, gdev->saved_timeout, ARB_TIMER);
 
-- 
2.19.0

