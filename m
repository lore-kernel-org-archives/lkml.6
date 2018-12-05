Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757A5C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4526F206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4526F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeLEKL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:11:58 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:51460 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbeLEKL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:11:56 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 677E45FD43; Wed,  5 Dec 2018 18:11:53 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 3/3] ARM: dts: sun8i: a33: Drop audio codec oversampling rate to 128 fs
Date:   Wed,  5 Dec 2018 18:11:52 +0800
Message-Id: <20181205101152.22983-4-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181205101152.22983-1-wens@csie.org>
References: <20181205101152.22983-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current oversampling rate of 512 means that for 48 kHz 16 bit
stereo, the MCLK is running at the same rate as the module clock,
so there is no head room to support higher sampling rates. The codec
however supports up to 192 kHz for playback.

This patch drops the oversampling rate from 512 to 128, so that 192 kHz
audio can be played back directly without downsampling. Ideally we
should be using different oversampling rates for different sampling
rates, but that's not possible without a platform-specific machine
driver.

Fixes: 870f1bd1f5e9 ("ARM: dts: sun8i: Add audio codec, dai and card for A33")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index c2c10cd4a210..11f58893678d 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -207,7 +207,7 @@
 		simple-audio-card,format = "i2s";
 		simple-audio-card,frame-master = <&link_codec>;
 		simple-audio-card,bitclock-master = <&link_codec>;
-		simple-audio-card,mclk-fs = <512>;
+		simple-audio-card,mclk-fs = <128>;
 		simple-audio-card,aux-devs = <&codec_analog>;
 		simple-audio-card,routing =
 			"Left DAC", "AIF1 Slot 0 Left",
-- 
2.20.0.rc1

