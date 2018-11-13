Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBA3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C512243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C512243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbeKMWZz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:25:55 -0500
Received: from hermes.aosc.io ([199.195.250.187]:37216 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732743AbeKMWZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 17:25:55 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 67033A2847;
        Tue, 13 Nov 2018 12:27:56 +0000 (UTC)
Date:   Tue, 13 Nov 2018 20:27:50 +0800
In-Reply-To: <20181113055053.78352-31-sashal@kernel.org>
References: <20181113055053.78352-1-sashal@kernel.org> <20181113055053.78352-31-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH AUTOSEL 4.18 31/39] clk: sunxi-ng: sun50i: h6: Add 2x fixed post-divider to MMC module clocks
To:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
CC:     Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-clk@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <19C4C784-F94E-49D0-883C-12C49EF2676A@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年11月13日 GMT+08:00 下午1:50:45, Sasha Levin <sashal@kernel.org> 写到:
>From: Icenowy Zheng <icenowy@aosc.io>
>
>[ Upstream commit c2ff8383cc33c2d9c169e4daf1e37a434c3bb420 ]
>
>On the H6, the MMC module clocks are fixed in the new timing mode,
>i.e. they do not have a bit to select the mode. These clocks have
>a 2x divider somewhere between the clock and the MMC module.
>
>To be consistent with other SoCs supporting the new timing mode,
>we model the 2x divider as a fixed post-divider on the MMC module
>clocks.
>
>This patch adds the post-dividers to the MMC clocks, following the
>approach on A64.
>
>Fixes: 524353ea480b ("clk: sunxi-ng: add support for the Allwinner H6
>CCU")
>Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>Signed-off-by: Sasha Levin <sashal@kernel.org>

Please don't select this, it needs some fixes in MMC driver.

>---
> drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 43 +++++++++++++++-------------
> 1 file changed, 23 insertions(+), 20 deletions(-)
>
>diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
>b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
>index bdbfe78fe133..3d60f7978506 100644
>--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
>+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
>@@ -408,26 +408,29 @@ static SUNXI_CCU_GATE(bus_nand_clk, "bus-nand",
>"ahb3", 0x82c, BIT(0), 0);
> 
>static const char * const mmc_parents[] = { "osc24M", "pll-periph0-2x",
> 					    "pll-periph1-2x" };
>-static SUNXI_CCU_MP_WITH_MUX_GATE(mmc0_clk, "mmc0", mmc_parents,
>0x830,
>-					0, 4,	/* M */
>-					8, 2,	/* N */
>-					24, 3,	/* mux */
>-					BIT(31),/* gate */
>-					0);
>-
>-static SUNXI_CCU_MP_WITH_MUX_GATE(mmc1_clk, "mmc1", mmc_parents,
>0x834,
>-					0, 4,	/* M */
>-					8, 2,	/* N */
>-					24, 3,	/* mux */
>-					BIT(31),/* gate */
>-					0);
>-
>-static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_clk, "mmc2", mmc_parents,
>0x838,
>-					0, 4,	/* M */
>-					8, 2,	/* N */
>-					24, 3,	/* mux */
>-					BIT(31),/* gate */
>-					0);
>+static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc0_clk, "mmc0",
>mmc_parents, 0x830,
>+					  0, 4,		/* M */
>+					  8, 2,		/* N */
>+					  24, 3,	/* mux */
>+					  BIT(31),	/* gate */
>+					  2,		/* post-div */
>+					  0);
>+
>+static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1",
>mmc_parents, 0x834,
>+					  0, 4,		/* M */
>+					  8, 2,		/* N */
>+					  24, 3,	/* mux */
>+					  BIT(31),	/* gate */
>+					  2,		/* post-div */
>+					  0);
>+
>+static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc2_clk, "mmc2",
>mmc_parents, 0x838,
>+					  0, 4,		/* M */
>+					  8, 2,		/* N */
>+					  24, 3,	/* mux */
>+					  BIT(31),	/* gate */
>+					  2,		/* post-div */
>+					  0);
> 
>static SUNXI_CCU_GATE(bus_mmc0_clk, "bus-mmc0", "ahb3", 0x84c, BIT(0),
>0);
>static SUNXI_CCU_GATE(bus_mmc1_clk, "bus-mmc1", "ahb3", 0x84c, BIT(1),
>0);
