Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932466AbeD0R4e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:56:34 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21406 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932412AbeD0R4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 13:56:32 -0400
Date: Fri, 27 Apr 2018 13:56:09 -0400
From: Marcin Ziemianowicz <marcin@ziemianowicz.com>
To: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] clk: at91: PLL recalc_rate() now using cached MUL+DIV
 values
Message-ID: <20180427175609.GA83298@hak8or>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Boyd <sboyd@kernel.org>,
linux-clk@vger.kernel.org,
linux-arm-kernel@lists.infradead.org,
linux-kernel@vger.kernel.org
Bcc: 
Subject: [PATCH v3] clk: at91: PLL recalc_rate() now using cached MUL and DIV
 values
Reply-To: 

When a USB device is connected to the USB host port on the SAM9N12 then
you get "-62" error which seems to indicate USB replies from the device
are timing out. Based on a logic sniffer, I saw the USB bus was running
at half speed.

The PLL code uses cached MUL and DIV values which get set in set_rate()
and applied in prepare(), but the recalc_rate() function instead
queries the hardware instead of using these cached values. Therefore,
if recalc_rate() is called between a set_rate() and prepare(), the
wrong frequency is calculated and later the USB clock divider for the
SAM9N12 SOC will be configured for an incorrect clock.

In my case, the PLL hardware was set to 96 Mhz before the OHCI
driver loads, and therefore the usb clock divider was being set
to /2 even though the OHCI driver set the PLL to 48 Mhz.

As an alternative explanation, I noticed this was fixed in the past:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/283502.html
but was later changed back via a large patch (maybe by mistake?):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1bdf02326b71eae7e9b4b335b881856aaf9d1af6

Thank you for bearing with me about this Boris.

Changes since V2:
  Removed all logging/debug messages I added
  > Comment by Boris Brezillon about my fix being wrong addressed
Changes since V1:
  Added patch set cover letter
  Shortened lines which were over >80 characters long
  > Comment by Greg Kroah-Hartman about "from" field in email addressed
  > Comment by Alan Stern about redundant debug lines addressed

Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>
---
 drivers/clk/at91/clk-pll.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index 7d3223fc..cc6e0364 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -132,19 +132,8 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
 					 unsigned long parent_rate)
 {
 	struct clk_pll *pll = to_clk_pll(hw);
-	unsigned int pllr;
-	u16 mul;
-	u8 div;
-
-	regmap_read(pll->regmap, PLL_REG(pll->id), &pllr);
-
-	div = PLL_DIV(pllr);
-	mul = PLL_MUL(pllr, pll->layout);
-
-	if (!div || !mul)
-		return 0;
 
-	return (parent_rate / div) * (mul + 1);
+	return return (parent_rate / pll->div) * (pll->mul + 1);
 }
 
 static long clk_pll_get_best_div_mul(struct clk_pll *pll, unsigned long rate,
-- 
2.17.0
