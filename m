Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EB9C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82018217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897570;
	bh=Uz5iiR1+vyFcgsljwiIC/VoJ0PSu8CCwjNp5iiOBVDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0h9intI1w3DFUumtBHOU/NnIN4hJPu9g46zpzUZ2ZipAdQVO7PWs0gw/kbTf2vbWT
	 /5uQXl+1I/IIawQVNXSjbXNeIe6Q7FUblUSQxrkitnXfyd8C1oxE/FD/pgplc+E3mt
	 YxCmR23PjQydt0bLG7MRoyqNZP6LFhaL7V0uuP0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391163AbfBKPGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:06:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:55616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391148AbfBKPGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:06:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59CE5222A7;
        Mon, 11 Feb 2019 15:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897565;
        bh=Uz5iiR1+vyFcgsljwiIC/VoJ0PSu8CCwjNp5iiOBVDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cg2xD7sTDWvSHb/A4IeypkubkNNBU6uj++VGy5o5EQF9Ik7oc+2xW34m5IDKwDmx8
         Ex05vMzUPUxqVflry5IqAjXVjHS9ge1MYwjZH8zg3gU0kWzXDOq+QSKFxvbtnFRALu
         GB+eXnGQI6g5Okn+2Ro/N893bmYI87IrYdXhXbMI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 040/137] clk: sunxi-ng: a33: Set CLK_SET_RATE_PARENT for all audio module clocks
Date:   Mon, 11 Feb 2019 15:18:41 +0100
Message-Id: <20190211141815.663752713@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6e6da2039c82271dd873b9ad2b902a692a7dd554 ]

All the audio interfaces on Allwinner SoCs need to change their module
clocks during operation, to switch between support for 44.1 kHz and 48
kHz family sample rates. The clock rate for the module clocks is
governed by their upstream audio PLL. The module clocks themselves only
have a gate, and sometimes a divider or mux. Thus any rate changes need
to be propagated upstream.

Set the CLK_SET_RATE_PARENT flag for all audio module clocks to achieve
this.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
index e1dc4e5b34e1..82add4670c53 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -362,10 +362,10 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(spi1_clk, "spi1", mod0_default_parents, 0x0a4,
 static const char * const i2s_parents[] = { "pll-audio-8x", "pll-audio-4x",
 					    "pll-audio-2x", "pll-audio" };
 static SUNXI_CCU_MUX_WITH_GATE(i2s0_clk, "i2s0", i2s_parents,
-			       0x0b0, 16, 2, BIT(31), 0);
+			       0x0b0, 16, 2, BIT(31), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_MUX_WITH_GATE(i2s1_clk, "i2s1", i2s_parents,
-			       0x0b4, 16, 2, BIT(31), 0);
+			       0x0b4, 16, 2, BIT(31), CLK_SET_RATE_PARENT);
 
 /* TODO: the parent for most of the USB clocks is not known */
 static SUNXI_CCU_GATE(usb_phy0_clk,	"usb-phy0",	"osc24M",
@@ -442,7 +442,7 @@ static SUNXI_CCU_M_WITH_GATE(ve_clk, "ve", "pll-ve",
 static SUNXI_CCU_GATE(ac_dig_clk,	"ac-dig",	"pll-audio",
 		      0x140, BIT(31), 0);
 static SUNXI_CCU_GATE(ac_dig_4x_clk,	"ac-dig-4x",	"pll-audio-4x",
-		      0x140, BIT(30), 0);
+		      0x140, BIT(30), CLK_SET_RATE_PARENT);
 static SUNXI_CCU_GATE(avs_clk,		"avs",		"osc24M",
 		      0x144, BIT(31), 0);
 
-- 
2.19.1



