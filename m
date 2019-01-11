Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724CDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A285206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218447;
	bh=yss41sBtXTzeXZKQ9fWDbZkdgsGDf+7kKA/KDW0btSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xIYWx7ZhbGT0flukqt8a/3jh+0xbm8RAhgb5U/kku9IiQGTnA0Ae23AtDgmZLVjgw
	 dTjAQIaVm3jZJJPRDX/fUwMl5J1Xd5N2gh5Z/q5UFNZy1/m7V91qc3qyFtWk41cH94
	 H/XiT1hE8LH6ytHQXlkgLuQLG2eEZXLyC2zxjWmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391239AbfAKOyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:54:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390682AbfAKOhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:37:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94760204EC;
        Fri, 11 Jan 2019 14:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217465;
        bh=yss41sBtXTzeXZKQ9fWDbZkdgsGDf+7kKA/KDW0btSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRTHpseUvvwEtmUOM/CjBJD1t7IjSe+u6Pk0iljgjV/iiyRwkyRV6WnE7dzZknvKQ
         6v+HrcHrzx+qjFAWi5jsw8ew03Sht8Q20FqMdkTZjK5yU8xdp3ORDjJvahXgw8HvAq
         72g3YO48hfgv1CAuHyQIgy3LLvZPXhSNHuWxHK18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 071/148] gpio: mvebu: only fail on missing clk if pwm is actually to be used
Date:   Fri, 11 Jan 2019 15:14:09 +0100
Message-Id: <20190111131117.078147091@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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
index 6e02148c208b..adc768f908f1 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -773,9 +773,6 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 				     "marvell,armada-370-gpio"))
 		return 0;
 
-	if (IS_ERR(mvchip->clk))
-		return PTR_ERR(mvchip->clk);
-
 	/*
 	 * There are only two sets of PWM configuration registers for
 	 * all the GPIO lines on those SoCs which this driver reserves
@@ -786,6 +783,9 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
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



