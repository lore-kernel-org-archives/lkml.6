Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeDHJow (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 05:44:52 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21467 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeDHJov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 05:44:51 -0400
Date: Sun, 8 Apr 2018 05:44:23 -0400
From: Marcin <marcin@ziemianowicz.com>
To: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: at91: Fix for PLL set_rate changes not being
 actually written to PLL peripheral bits
Message-ID: <20180408094423.GA51702@hak8or>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a USB device is connected to the USB host port on the SAM9N12 then
you get "-62" error which seems to indicate USB replies from the device
are timing out. Looking around, I saw the USB bus was running at half
speed. Going further, it seems that in ..._set_rate() the PLL wasn't
actually being adjusted. Writing the multiplier and divider values to
the peripheral fixes the bus running at half speed.

Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>
---
 drivers/clk/at91/clk-pll.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index 534961766ae5..db7155fe9346 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -288,6 +288,14 @@ static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	pll->div = div;
 	pll->mul = mul;
 
+	// Set the PLL as per above div and mil values.
+	regmap_update_bits(pll->regmap, AT91_CKGR_PLLBR,
+		AT91_PMC_DIV | AT91_PMC_MUL,
+		(div << 0) | (mul << 16));
+
+	pr_debug("clk-pll: setting new rate, (%lu hz / %u) * %u = %lu hz\n",
+		parent_rate, div, mul, rate);
+
 	return 0;
 }
 
-- 
2.16.3
