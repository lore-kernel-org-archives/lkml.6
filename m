Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE91BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B476E214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864131;
	bh=Zp4Shgj6on+KbZN0SyQh1esyiCHNRpx9ClKA9GzO5qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yoGAUZkFodfRY9bYifkrB3pq/8IKs8ixpfDqjB7C7jVYOwxhsUyRiDzpQZxzvgLFl
	 vv0cRLH/1wzMROILifliHyyoiOhfq0mVoMsHhtGUuGg7Vgr4orZEOGqxLzKAAuhn9W
	 gmAzMktwmwtyfhhZn2w+sbvx1YEee9w4srAZdEvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbeLZWli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:41:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729492AbeLZWlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:41:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D304B20651;
        Wed, 26 Dec 2018 22:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864094;
        bh=Zp4Shgj6on+KbZN0SyQh1esyiCHNRpx9ClKA9GzO5qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0ADXtORY1pDteuPz3QOxQWE08GjX+U/iwikssWAxHtOJ56BzJJGFbN33sfYDotdT
         +Hrga9sOsN90Apguf/xVn+p9Bwcfs9ONuWObRPrcVEkT/FW4IBcVxedHR9PCj25h4k
         TwRNNLTwwUD7bIVxWzMyY/U6FyoAkC5aX1XUGdw8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 55/59] gpio: mvebu: only fail on missing clk if pwm is actually to be used
Date:   Wed, 26 Dec 2018 17:38:35 -0500
Message-Id: <20181226223839.150262-55-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit c8da642d41a6811c21177c9994aa7dc35be67d46 ]

The gpio IP on Armada 370 at offset 0x18180 has neither a clk nor pwm
registers. So there is no need for a clk as the pwm isn't used anyhow.
So only check for the clk in the presence of the pwm registers. This fixes
a failure to probe the gpio driver for the above mentioned gpio device.

Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mvebu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 45c65f805fd6..be85d4b39e99 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -777,9 +777,6 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 				     "marvell,armada-370-gpio"))
 		return 0;
 
-	if (IS_ERR(mvchip->clk))
-		return PTR_ERR(mvchip->clk);
-
 	/*
 	 * There are only two sets of PWM configuration registers for
 	 * all the GPIO lines on those SoCs which this driver reserves
@@ -790,6 +787,9 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	if (!res)
 		return 0;
 
+	if (IS_ERR(mvchip->clk))
+		return PTR_ERR(mvchip->clk);
+
 	/*
 	 * Use set A for lines of GPIO chip with id 0, B for GPIO chip
 	 * with id 1. Don't allow further GPIO chips to be used for PWM.
-- 
2.19.1

