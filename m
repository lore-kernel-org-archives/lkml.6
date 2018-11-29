Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183C1C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0C82146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkGi3G86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0C82146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbeK2RGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:06:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:42916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbeK2RGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:06:35 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79DEB213A2;
        Thu, 29 Nov 2018 06:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471343;
        bh=n+IKdAjsvTX6UM10Kkyq6Mv839iq28opDtLTXCPBWsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LkGi3G8694HyBTI92XU/ymMC74W5R58MUReeIOg4A6Rk2bvvXwXZiXH9VlHUrPYw9
         cDzPhfXNyEAXjy4pvQjPrIynBTyjgaFSOMiPIxrBbvwjxR8SqQbvfozWs5wFk7RZnv
         01RhyXP//N6UsIOZxebKT16UdBVLMqtUndrjyGQw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 18/35] gpio: mockup: fix indicated direction
Date:   Thu, 29 Nov 2018 01:00:52 -0500
Message-Id: <20181129060110.159878-18-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060110.159878-1-sashal@kernel.org>
References: <20181129060110.159878-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <brgl@bgdev.pl>

[ Upstream commit bff466bac59994cfcceabe4d0be5fdc1c20cd5b8 ]

Commit 3edfb7bd76bd ("gpiolib: Show correct direction from the
beginning") fixed an existing issue but broke libgpiod tests by
changing the default direction of dummy lines to output.

We don't break user-space so make gpio-mockup behave as before.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mockup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 9532d86a82f7..d99c8d8da9a0 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -35,8 +35,8 @@
 #define GPIO_MOCKUP_MAX_RANGES	(GPIO_MOCKUP_MAX_GC * 2)
 
 enum {
-	GPIO_MOCKUP_DIR_OUT = 0,
-	GPIO_MOCKUP_DIR_IN = 1,
+	GPIO_MOCKUP_DIR_IN = 0,
+	GPIO_MOCKUP_DIR_OUT = 1,
 };
 
 /*
@@ -112,7 +112,7 @@ static int gpio_mockup_get_direction(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
-	return chip->lines[offset].dir;
+	return !chip->lines[offset].dir;
 }
 
 static int gpio_mockup_name_lines(struct device *dev,
-- 
2.17.1

