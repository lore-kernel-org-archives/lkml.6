Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC34CC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68094258C6
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68094258C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965683AbeGASNR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:13:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34038 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965220AbeGAQ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:27:10 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 11FF192B;
        Sun,  1 Jul 2018 16:27:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcin Ziemianowicz <marcin@ziemianowicz.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.9 065/101] clk: at91: PLL recalc_rate() now using cached MUL and DIV values
Date:   Sun,  1 Jul 2018 18:21:51 +0200
Message-Id: <20180701160759.764063131@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcin Ziemianowicz <marcin@ziemianowicz.com>

commit a982e45dc150da3a08907b6dd676b735391704b4 upstream.

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

As an alternative explanation, I noticed this was fixed in the past by
87e2ed338f1b ("clk: at91: fix recalc_rate implementation of PLL
driver") but the bug was later re-introduced by 1bdf02326b71 ("clk:
at91: make use of syscon/regmap internally").

Fixes: 1bdf02326b71 ("clk: at91: make use of syscon/regmap internally)
Cc: <stable@vger.kernel.org>
Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>
Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/at91/clk-pll.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -132,19 +132,8 @@ static unsigned long clk_pll_recalc_rate
 					 unsigned long parent_rate)
 {
 	struct clk_pll *pll = to_clk_pll(hw);
-	unsigned int pllr;
-	u16 mul;
-	u8 div;
 
-	regmap_read(pll->regmap, PLL_REG(pll->id), &pllr);
-
-	div = PLL_DIV(pllr);
-	mul = PLL_MUL(pllr, pll->layout);
-
-	if (!div || !mul)
-		return 0;
-
-	return (parent_rate / div) * (mul + 1);
+	return (parent_rate / pll->div) * (pll->mul + 1);
 }
 
 static long clk_pll_get_best_div_mul(struct clk_pll *pll, unsigned long rate,


