Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755281AbeEaOEJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:04:09 -0400
Received: from atl4mhob21.registeredsite.com ([209.17.115.115]:45230 "EHLO
        atl4mhob21.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755225AbeEaOEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:04:07 -0400
X-TCPREMOTEIP: 37.74.225.130
X-Authenticated-UID: mike@milosoftware.com
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] clk-si544: Properly round requested frequency to nearest match
Date: Thu, 31 May 2018 16:03:55 +0200
Message-Id: <1527775435-5017-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The si544 driver had a rounding problem that using the result of clk_round_rate
may set the clock to yet another rate, for example:
clk_round_rate(195000000) = 194999999
clk_round_rate(194999999) = 194999998

Clients would expect that after clk_set_rate(clk, freq2=clk_round_rate(clk, freq)) the
chip will be running at exactly freq2.

The problem was in the calculation of the feedback divider, it was always rounded
down instead of to the nearest possible VCO value.

After this change, the following holds true for any supported frequency:
actual_freq = clk_round_rate(clk, freq);
clk_set_rate(clk, actual_freq);
clk_round_rate(clk, actual_freq) == actual_freq && clk_get_rate(clk) == actual_freq

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/clk/clk-si544.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-si544.c b/drivers/clk/clk-si544.c
index d437722..e972ffb 100644
--- a/drivers/clk/clk-si544.c
+++ b/drivers/clk/clk-si544.c
@@ -207,6 +207,7 @@ static int si544_calc_muldiv(struct clk_si544_muldiv *settings,
 
 	/* And the fractional bits using the remainder */
 	vco = (u64)tmp << 32;
+	vco += FXO / 2; /* Round to nearest multiple */
 	do_div(vco, FXO);
 	settings->fb_div_frac = vco;
 
-- 
1.9.1
