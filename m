Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0D0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82D020675
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfAJI0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:26:40 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:55712 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfAJI0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:26:37 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 160925FC23; Thu, 10 Jan 2019 16:26:34 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pinctrl: sunxi: Increase size of regulator array
Date:   Thu, 10 Jan 2019 16:26:32 +0800
Message-Id: <20190110082633.6321-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the A80, the pin banks go up to PN, which translates to the 14th
entry in the regulator array. The array is only 12 entries long, which
causes the sunxi_pmx_{request,free} functions to access beyond the
array on the A80 and the A31 (which has pin bank PM). While the
accessed data is still valid allocated data within the same driver
data structure, it is likely not a pointer.

Increase the size of the regulator array from 12 to 14. This is a simple
fix. While we could have the code take into account the fact that R_PIO
pin banks start from PL, or maybe even dynamically allocate the array
based on the last pin of the pin controller, the size reduction probably
isn't worth the additional code complexity.

Fixes: 9a2a566adb00 ("pinctrl: sunxi: Deal with per-bank regulators")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
This fixes a crash due to an invalid pointer on the A80.
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index e340d2a24b44..e8161aa17dab 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -136,7 +136,7 @@ struct sunxi_pinctrl {
 	struct gpio_chip		*chip;
 	const struct sunxi_pinctrl_desc	*desc;
 	struct device			*dev;
-	struct sunxi_pinctrl_regulator	regulators[12];
+	struct sunxi_pinctrl_regulator	regulators[14];
 	struct irq_domain		*domain;
 	struct sunxi_pinctrl_function	*functions;
 	unsigned			nfunctions;
-- 
2.20.1

