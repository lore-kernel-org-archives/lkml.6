Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B611C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5FB208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5FB208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbeK1Uc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:32:57 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:49082 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbeK1Ubd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:31:33 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 2DE085FBE2; Wed, 28 Nov 2018 17:30:28 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 00/15] rtc: sun6i: clock rework and pre-H6 SoC support
Date:   Wed, 28 Nov 2018 17:29:57 +0800
Message-Id: <20181128093013.24442-1-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This series was started as part of enabling Bluetooth on various
Allwinner SBCs. The bluetooth controller requires a precise 32.768 kHz
clock fed to it to correctly detect the frequency of its main oscillator.
This clock signal is provided by the RTC, either directly from a special
pin on the SoC, or some clock output function from the clock controllers.
I found that the clock-related properties of the RTC on later SoCs were
incorrect or missing.

This series reworks the compatible strings and clock parts of the device
tree bindings for sun6i-rtc. Currently we assume most Allwinner SoCs use
the same sun6i-rtc variant, when in fact they do not. The differences
that matter with regards to clocks are a) the A31 does not have an extra
external output for the RTC 32K clock, while most of the others do;
b) the clock frequency of the internal RC oscillator is different on
some SoCs; c) on the H6 the RTC also handles the 24 MHz DCXO, which
feeds the system HOSC. The last difference, and by extension the H6, are
not covered in this series.

Patch 1 cleans up the clock-related section of the RTC device tree
binding. This would make it easier to read and easier to add additional
clocks.

Patch 2 adds compatible strings for all identified variants introduced
prior to the H6.

Patch 3 deprecates the external clock output for the A31. The A31 does
not have this output, so it's introduction and usage was an error.

Patch 4 adds a clock output for the RTC's internal oscillator to the
device tree binding. This feeds the PRCM in some SoCs.

Patch 5 adds a default clock name for the LOSC to the RTC driver.

Patch 6 adds support for different hardware variants to the RTC driver.

Patch 7 adds support for all known pre-H6 variants.

Patch 8 exposes the RTC's internal oscillator through the device tree.

Patch 9 makes the R40's CCU use the LOSC from the RTC module, instead of
its own internal oscillator.

Patch 10 through 15 adds an RTC node or fixes up the RTC device node
address ranges, clock properties, names of existing clocks, and adds
accuracy properties for the external fixed oscillators.

The clock names require fixing because the sunxi clock driver implicitly
depends on the HOSC and LOSC being named "osc24M" and "osc32k". The
"fixes" to the clock hierarchy introduced in this series means the names
must also be shuffled around or the in kernel representation would be
incorrect. This has been the case since the sunxi-ng drivers were
introduced. There are plans to address this, but the code is still in its
early stages.

Please have a look.

Thanks
ChenYu

Chen-Yu Tsai (15):
  dt-bindings: rtc: sun6i-rtc: Rewrite clock outputs as a list
  dt-bindings: rtc: sun6i-rtc: Add compatible strings for pre-H6
    variants
  dt-bindings: rtc: sun6i-rtc: Deprecate external clock output for A31
  dt-bindings: rtc: sun6i-rtc: Export internal RC oscillator
  rtc: sun6i: Add default clock name for LOSC
  rtc: sun6i: Add support for different variants
  rtc: sun6i: Add support for all known pre-H6 variants
  rtc: sun6i: Expose internal oscillator through device tree
  clk: sunxi-ng: r40: Force LOSC parent to RTC LOSC output
  ARM: dts: sun8i: a23/a33: Fix up RTC device node
  ARM: dts: sunxi: h3/h5: Add clock accuracy for external oscillators
  ARM: dts: sunxi: h3/h5: Fix up RTC device node and clock references
  ARM: dts: sun8i: r40: Add clock accuracy for external oscillators
  ARM: dts: sun8i: r40: Add RTC device node
  arm64: dts: allwinner: a64: Fix up RTC device node and clock
    references

 .../devicetree/bindings/rtc/sun6i-rtc.txt     |  31 ++++-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi          |   6 +-
 arch/arm/boot/dts/sun8i-h3.dtsi               |   4 +
 arch/arm/boot/dts/sun8i-r40.dtsi              |  18 ++-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  28 ++---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  22 ++--
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |   4 +
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c          |  11 ++
 drivers/rtc/rtc-sun6i.c                       | 117 ++++++++++++++++--
 9 files changed, 188 insertions(+), 53 deletions(-)

-- 
2.20.0.rc1

