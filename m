Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF34ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04243205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04243205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeJVEPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:15:38 -0400
Received: from sauhun.de ([88.99.104.3]:45650 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbeJVEPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:15:38 -0400
Received: from localhost (unknown [90.200.225.72])
        by pokefinder.org (Postfix) with ESMTPSA id 81EEB2E35C5;
        Sun, 21 Oct 2018 22:00:09 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 4/6] gpio: gpio-omap: simplify getting .driver_data
Date:   Sun, 21 Oct 2018 21:59:59 +0200
Message-Id: <20181021200002.1472-5-wsa+renesas@sang-engineering.com>
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

 drivers/gpio/gpio-omap.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 9887c3db6e16..6ed621a00561 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -984,8 +984,7 @@ omap4_gpio_disable_level_quirk(struct gpio_bank *bank)
 
 static int omap_mpuio_suspend_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_bank	*bank = platform_get_drvdata(pdev);
+	struct gpio_bank	*bank = dev_get_drvdata(dev);
 	void __iomem		*mask_reg = bank->base +
 					OMAP_MPUIO_GPIO_MASKIT / bank->stride;
 	unsigned long		flags;
@@ -999,8 +998,7 @@ static int omap_mpuio_suspend_noirq(struct device *dev)
 
 static int omap_mpuio_resume_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_bank	*bank = platform_get_drvdata(pdev);
+	struct gpio_bank	*bank = dev_get_drvdata(dev);
 	void __iomem		*mask_reg = bank->base +
 					OMAP_MPUIO_GPIO_MASKIT / bank->stride;
 	unsigned long		flags;
@@ -1688,8 +1686,7 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 
 static int __maybe_unused omap_gpio_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	struct gpio_bank *bank = dev_get_drvdata(dev);
 	unsigned long flags;
 	int error = 0;
 
@@ -1709,8 +1706,7 @@ static int __maybe_unused omap_gpio_runtime_suspend(struct device *dev)
 
 static int __maybe_unused omap_gpio_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	struct gpio_bank *bank = dev_get_drvdata(dev);
 	unsigned long flags;
 	int error = 0;
 
-- 
2.19.0

