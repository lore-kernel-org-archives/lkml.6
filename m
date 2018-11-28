Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16183C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5227208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5227208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeK1Ubh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:31:37 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:49300 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbeK1Ubg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:31:36 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 7B39A6035A; Wed, 28 Nov 2018 17:30:28 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 09/15] clk: sunxi-ng: r40: Force LOSC parent to RTC LOSC output
Date:   Wed, 28 Nov 2018 17:30:07 +0800
Message-Id: <20181128093013.24442-11-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181128093013.24442-1-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the R40, in addition to a mux between the RTC's own RC oscillator and
an external 32768 Hz crystal, which are muxed inside the RTC module, the
CCU also has its own RC oscillator, which runs at around 2 MHz, and can
be muxed with the LOSC output from the RTC. This muxed output is called
"SYS 32K" in the module clock diagram, but otherwise referred to as the
LOSC throughout the CCU documentation.

The RC oscillator is not very accurate, even though it has an undocumented
calibration function. We really want a precise clock at 32768 Hz,
instead of something at around 32 KHz. This patch forces the SYS 32K
clock to use the RTC output as its parent, and doesn't bother
registering the internal oscillator nor a clock mux.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
index 582ebd41d20d..a22d11aa38ba 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
@@ -1284,6 +1284,9 @@ static struct regmap_config sun8i_r40_ccu_regmap_config = {
 	.writeable_reg	= sun8i_r40_ccu_regmap_accessible_reg,
 };
 
+#define SUN8I_R40_SYS_32K_CLK_REG 0x310
+#define SUN8I_R40_SYS_32K_CLK_KEY (0x16AA << 16)
+
 static int sun8i_r40_ccu_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -1312,6 +1315,14 @@ static int sun8i_r40_ccu_probe(struct platform_device *pdev)
 	val &= ~GENMASK(25, 20);
 	writel(val, reg + SUN8I_R40_USB_CLK_REG);
 
+	/*
+	 * Force SYS 32k (otherwise known as LOSC throughout the CCU)
+	 * clock parent to LOSC output from RTC module instead of the
+	 * CCU's internal RC oscillator divided output.
+	 */
+	writel(SUN8I_R40_SYS_32K_CLK_KEY | BIT(8),
+	       reg + SUN8I_R40_SYS_32K_CLK_REG);
+
 	regmap = devm_regmap_init_mmio(&pdev->dev, reg,
 				       &sun8i_r40_ccu_regmap_config);
 	if (IS_ERR(regmap))
-- 
2.20.0.rc1

