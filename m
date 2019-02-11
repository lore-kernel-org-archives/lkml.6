Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4678C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E2121B26
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898996;
	bh=17C+e4Rx04dNxPd+DGh6qj55NiNqW35Zn0mCXJE/FCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GK1543Y+24DLqyVGaob0yHUdzDTOVSC8jtuCl/vL8AIaf1OLz8ekEcQkQEKIXGAkk
	 gAWHHm2g6NTaEhTMU9W19Pcdfct7Ne7Zf0wdo6imWJ22isG8/HG+yOT26Dljp/wUh4
	 QPX0ITI1841QcHOw8RepWlaJ/E7XIiB3IM4mVgEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389278AbfBKO5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:57:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388616AbfBKO5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:57:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66E3D222A8;
        Mon, 11 Feb 2019 14:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897023;
        bh=17C+e4Rx04dNxPd+DGh6qj55NiNqW35Zn0mCXJE/FCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u/z0xI2Rb9O1xwkJ4Ntjpp7z7Q0pUUOtFRpHWbStQNMqUOux5VEQxTwRyCcsh4XPy
         p75OC+8sgCVHhzBHIy4dGcaRt0Tha015GKLfxehfe+Cf/ArYZ4GkucEgzxgc2w1j8B
         EDoXG9k8sOT3w29j1WLcJdutHpKNOAbYRiBOrJxw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 066/205] clk: sunxi-ng: a33: Set CLK_SET_RATE_PARENT for all audio module clocks
Date:   Mon, 11 Feb 2019 15:17:44 +0100
Message-Id: <20190211141833.083046917@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 13eb5b23c5e7..c40d572a7602 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -366,10 +366,10 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(spi1_clk, "spi1", mod0_default_parents, 0x0a4,
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
@@ -446,7 +446,7 @@ static SUNXI_CCU_M_WITH_GATE(ve_clk, "ve", "pll-ve",
 static SUNXI_CCU_GATE(ac_dig_clk,	"ac-dig",	"pll-audio",
 		      0x140, BIT(31), CLK_SET_RATE_PARENT);
 static SUNXI_CCU_GATE(ac_dig_4x_clk,	"ac-dig-4x",	"pll-audio-4x",
-		      0x140, BIT(30), 0);
+		      0x140, BIT(30), CLK_SET_RATE_PARENT);
 static SUNXI_CCU_GATE(avs_clk,		"avs",		"osc24M",
 		      0x144, BIT(31), 0);
 
-- 
2.19.1



