Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11F0C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93452206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93452206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeLEKMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:12:02 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:51424 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbeLEKL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:11:56 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 50CDD5FB79; Wed,  5 Dec 2018 18:11:53 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 0/3] ARM: sun8i: a33: Audio codec improvements
Date:   Wed,  5 Dec 2018 18:11:49 +0800
Message-Id: <20181205101152.22983-1-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This series improves audio support on the A33. Like other Allwinner
SoCs, the A33 requires the use of a sigma-delta modulation fractional-N
PLL to generate the correct clock used for audio playback. Otherwise the
pitch would be slightly off.

Patch 1 enables sigma-delta modulation for the audio PLL on the A33.

Patch 2 is only slightly related. It sets the CLK_SET_RATE_PARENT flag
for all audio-related module clocks

Patch 3 lowers the audio codec's oversampling rate, so that it can
play back audio sampled at beyond 48 KHz.

This is the same as what has recently been done for the A64, which
shares the same audio codec hardware design.

However, on the A33 it seems the PLL doesn't always immediately lock on
to the new clock frequency when there is a rate change. Also since the
codec is only put in standby instead of turned off, runtime PM never
kicks in, and the audio related clocks never get turned off. I'm still
looking into this.

On an unrelated note, if you get pops when playing back audio on sunxi,
it might be related to cpufreq. Try setting the governor to performance
and see if that removes the pops.

Regards
ChenYu


Chen-Yu Tsai (3):
  clk: sunxi-ng: a33: Use sigma-delta modulation for audio PLL
  clk: sunxi-ng: a33: Set CLK_SET_RATE_PARENT for all audio module
    clocks
  ARM: dts: sun8i: a33: Drop audio codec oversampling rate to 128 fs

 arch/arm/boot/dts/sun8i-a33.dtsi     |  2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 43 +++++++++++++++++-----------
 2 files changed, 28 insertions(+), 17 deletions(-)

-- 
2.20.0.rc1

