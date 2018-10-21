Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15737ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB58E20652
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB58E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbeJVEPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:15:35 -0400
Received: from sauhun.de ([88.99.104.3]:45622 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727399AbeJVEPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:15:34 -0400
Received: from localhost (unknown [90.200.225.72])
        by pokefinder.org (Postfix) with ESMTPSA id B6D572E35C5;
        Sun, 21 Oct 2018 22:00:06 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hoan Tran <hotran@apm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Subject: [PATCH 1/6] gpio: gpio-dwapb: simplify getting .driver_data
Date:   Sun, 21 Oct 2018 21:59:56 +0200
Message-Id: <20181021200002.1472-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021200002.1472-1-wsa+renesas@sang-engineering.com>
References: <20181021200002.1472-1-wsa+renesas@sang-engineering.com>
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

 drivers/gpio/gpio-dwapb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 044888fd96a1..84ae04402f70 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -748,8 +748,7 @@ static int dwapb_gpio_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int dwapb_gpio_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct dwapb_gpio *gpio = platform_get_drvdata(pdev);
+	struct dwapb_gpio *gpio = dev_get_drvdata(dev);
 	struct gpio_chip *gc	= &gpio->ports[0].gc;
 	unsigned long flags;
 	int i;
@@ -793,8 +792,7 @@ static int dwapb_gpio_suspend(struct device *dev)
 
 static int dwapb_gpio_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct dwapb_gpio *gpio = platform_get_drvdata(pdev);
+	struct dwapb_gpio *gpio = dev_get_drvdata(dev);
 	struct gpio_chip *gc	= &gpio->ports[0].gc;
 	unsigned long flags;
 	int i;
-- 
2.19.0

