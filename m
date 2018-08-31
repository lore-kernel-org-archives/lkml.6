Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91C3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9253520661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9253520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeHaPds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:33:48 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:32420 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726990AbeHaPds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:33:48 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie3.idc.renesas.com with ESMTP; 31 Aug 2018 20:26:41 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id A752D84E9B;
        Fri, 31 Aug 2018 20:26:41 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,311,1531753200"; 
   d="scan'208";a="291187229"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii2.idc.renesas.com with ESMTP; 31 Aug 2018 20:26:38 +0900
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH] clk: renesas: r9a06g032: Fix UART34567 clock rate
Date:   Fri, 31 Aug 2018 12:26:36 +0100
Message-Id: <1535714796-2211-1-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock for UARTs 0 through 2 is UART012, the clock for UARTs 3 through
7 is UART34567.
For UART012, we stop the clock driver from changing the clock rate. This
is because the Synopsys UART driver simply sets the reference clock to 16x
the baud rate, but doesn't check if the actual rate is within the required
tolerance. The RZ/N1 clock divider can't provide this (we have to rely on
the UART's internal divider to set the correct clock rate), so you end up
with a clock rate that is way off what you wanted.

In addition, since the clock is shared between multiple UARTs, you don't
want the driver trying to change the clock rate as it may affect the other
UARTs (which may not have been configured yet, so you don't know what baud
rate they will use). Normally, the clock rate is set early on before Linux
to some very high rate that supports all of the clock rates you want.

This change stops the UART34567 clock rate from changing for the same
reasons.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/clk/renesas/r9a06g032-clocks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index a0b6ecd..6d2b568 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -539,7 +539,8 @@ r9a06g032_div_round_rate(struct clk_hw *hw,
 	 * several uarts attached to this divider, and changing this impacts
 	 * everyone.
 	 */
-	if (clk->index == R9A06G032_DIV_UART) {
+	if (clk->index == R9A06G032_DIV_UART ||
+	    clk->index == R9A06G032_DIV_P2_PG) {
 		pr_devel("%s div uart hack!\n", __func__);
 		return clk_get_rate(hw->clk);
 	}
-- 
2.7.4

