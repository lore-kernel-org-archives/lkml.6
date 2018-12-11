Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44591C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2672146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543723;
	bh=EoooJqLEvVA2F92WAGrJgkjEBYAc5IpaBnmo5+LIE5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hl1Jd58P4BrVeONbrYP5K24KQG462Lni5S6k5/NKUQOhAkuwaBlxSyOmWeQ5c2ssa
	 CoGz9jNnP30SQ21+yxfMfhRPEBsAAnaRqBOb+XY7qr0ydZeUQtrIoaPFbiQsSravKx
	 A8OvKFNZm6yDLtKZzExnZlY9WYMexIqcuiNsNrfI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2672146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbeLKPzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:55:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:43870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730357AbeLKPzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:55:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2E4D2146D;
        Tue, 11 Dec 2018 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543714;
        bh=EoooJqLEvVA2F92WAGrJgkjEBYAc5IpaBnmo5+LIE5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mjgiUj5IVHBO3BFM26dgtgnNCENTTFVaFWPirz2v28OhES/7byQhln6Cq1BbspQ5/
         ymgcMAgerwl7vP3bxY3V1bx6E+4GQM+7djL43jxxiFADZdQtzYMwzvjFCWKHCuD8BP
         wTJFY56q2cmoc22hH4ffkHLtEio8enqZ3gX4bddQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 034/118] gpio: mockup: fix indicated direction
Date:   Tue, 11 Dec 2018 16:40:53 +0100
Message-Id: <20181211151645.614766892@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index d66b7a768ecd..945bd13e5e79 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -32,8 +32,8 @@
 #define gpio_mockup_err(...)	pr_err(GPIO_MOCKUP_NAME ": " __VA_ARGS__)
 
 enum {
-	GPIO_MOCKUP_DIR_OUT = 0,
-	GPIO_MOCKUP_DIR_IN = 1,
+	GPIO_MOCKUP_DIR_IN = 0,
+	GPIO_MOCKUP_DIR_OUT = 1,
 };
 
 /*
@@ -135,7 +135,7 @@ static int gpio_mockup_get_direction(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
-	return chip->lines[offset].dir;
+	return !chip->lines[offset].dir;
 }
 
 static int gpio_mockup_to_irq(struct gpio_chip *gc, unsigned int offset)
-- 
2.19.1



