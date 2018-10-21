Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0380FECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A612083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A612083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeJVEUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:20:50 -0400
Received: from sauhun.de ([88.99.104.3]:45658 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728088AbeJVEPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:15:38 -0400
Received: from localhost (unknown [90.200.225.72])
        by pokefinder.org (Postfix) with ESMTPSA id 6F62B2E35C7;
        Sun, 21 Oct 2018 22:00:10 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 5/6] gpio: gpio-tegra: simplify getting .driver_data
Date:   Sun, 21 Oct 2018 22:00:00 +0200
Message-Id: <20181021200002.1472-6-wsa+renesas@sang-engineering.com>
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

 drivers/gpio/gpio-tegra.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 47dbd19751d0..02f6db925fd5 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -404,8 +404,7 @@ static void tegra_gpio_irq_handler(struct irq_desc *desc)
 #ifdef CONFIG_PM_SLEEP
 static int tegra_gpio_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct tegra_gpio_info *tgi = platform_get_drvdata(pdev);
+	struct tegra_gpio_info *tgi = dev_get_drvdata(dev);
 	unsigned long flags;
 	unsigned int b, p;
 
@@ -444,8 +443,7 @@ static int tegra_gpio_resume(struct device *dev)
 
 static int tegra_gpio_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct tegra_gpio_info *tgi = platform_get_drvdata(pdev);
+	struct tegra_gpio_info *tgi = dev_get_drvdata(dev);
 	unsigned long flags;
 	unsigned int b, p;
 
-- 
2.19.0

