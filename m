Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F48C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F2820878
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F2820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394251AbeKVVCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:02:38 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:48268 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387625AbeKVVCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:02:37 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 363AE5FB45; Thu, 22 Nov 2018 18:23:46 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v9 0/8] Add support for audiocodec in Allwinner A64
Date:   Thu, 22 Nov 2018 18:23:17 +0800
Message-Id: <20181122102325.29495-1-wens@csie.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is v9 of the A64 audio codec series, originally started by Vasily.
These are the last changes to make the A64 audio codec work correctly,
and be accurately represented in the device tree and in software.

Notably, the new driver changes cover regulator supplies for the simple
audio amplifier, which is used in the Pinebook for the internal
speakers, and the audio codec's internal headphone amp. There's also an
extra patch that enables SDM fractional clock support for the audio PLL
on the A64, which gives us accurate audio playback.

Patch 1 & 2 add the cpvdd regulator supply to the sun50i-codec-analog
dt bindings & driver.

Patch 3 & 4 add a regulator supply to the simple-audio-amplifier dt
bindings & driver.

Patch 5 adds SDM fractional clock support for the audio PLL on the A64.

Patch 6 ~ 8 add the device tree bits and enables audio on several
boards.

I have one extra patch for the Bananapi M64 that's not included here,
as I'm waiting for an accessory to test the microphone bias. I'll send
that one out once it's tested.

As always, we'll take the clock and dts patches after Mark has merged
the ASoC ones.

And a big thanks to Vasily for having worked on this for so long.

Regards
ChenYu

v9: - Dropped simple amplifier headphone amp device tree changes
    - Dropped "make enable-gpio optional for simple amplifier" 
    - Lowered oversampling rate from 512 to 128
    - Add regulator supply for audio codec CPVDD (headphone amp charge pump)
    - Hook up CPVDD regulator in board device trees
    - Add patch to enable SDM fractional clock support for audio PLL on A64
v8: - drop merged patches
    - add regulator property for simple amplifier, make enable-gpio
      optional
    - add regulator to speaker amp, introduce headphone amp
v7: - drop 'Mic' and 'Headset Mic' from dtsi
    - move AIF1 Slot 0 ADC to ADC route to sun8i-codec
    - drop BIAS routes for Pine64 and SoPine
v6: - driver patches has been merged through ASoC tree
    - rebase onto 4.20-rc1
    - Drop 'Speaker' from routes on sopine and pine64, they don't have
      speaker.
v5: - collect all the tags
v4: - dts: don't use 'Mic' and 'Headset Mic' widgets from sun8i-codec,
      define our board-level widgets instead.
v3: - renamed sunxi-adda-pr-regmap to sun8i-adda-pr-regmap
    - use ilog2() to calculate reg value for LRCK div instead of using a
      table
v2: - Use simple-amplifier for speaker amp on Pinebook
    - Rename sun50i-a64-i2s to sun50i-a64-codec-i2s to preserve compatible
      string for other 3 I2S modules in A64 in case if there's any
      incompatibility with H3

Chen-Yu Tsai (3):
  ASoC: dt-bindings: sun50i-codec-analog: Add headphone amp regulator
    supply
  ASoC: sunxi: sun50i-codec-analog: Add support for cpvdd regulator
    supply
  clk: sunxi-ng: sun50i: a64: Use sigma-delta modulation for audio PLL

Vasily Khoruzhick (5):
  ASoC: dt-bindings: add regulator property to simple amplifier
  ASoC: simple-amplifier: add VCC regulator widget
  arm64: dts: allwinner: a64: add nodes necessary for analog sound
    support
  arm64: dts: allwinner: a64: enable sound on Pine64 and SoPine
  arm64: dts: allwinner: a64: enable sound on Pinebook

 .../bindings/sound/simple-amplifier.txt       |  5 ++
 .../bindings/sound/sun50i-codec-analog.txt    |  2 +
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 27 ++++++++++
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 49 +++++++++++++++++
 .../allwinner/sun50i-a64-sopine-baseboard.dts | 26 +++++++++
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi |  4 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 54 +++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c         | 37 ++++++++-----
 sound/soc/codecs/simple-amplifier.c           |  4 ++
 sound/soc/sunxi/sun50i-codec-analog.c         |  2 +
 10 files changed, 197 insertions(+), 13 deletions(-)

-- 
2.19.1

