Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162116AbeCAVe6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:34:58 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:32988 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1161792AbeCAVe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:34:56 -0500
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org
Cc: jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 00/16] Implement H3/H5 HDMI driver
Date: Thu,  1 Mar 2018 22:34:26 +0100
Message-Id: <20180301213442.16677-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements H3/H5 HDMI driver. It was tested on OrangePi 2 (H3),
OrangePi Plus2e (H3) and OrangePi PC2 (H5) with many resolutions and it
works well.

Code is based on linux-next, next-20180228 tag.

Best regards,
Jernej

Changes in v3:
- Removed TCON patch to skip LVDS procesing
- Added TCON patch to release exclusive clock lock
- Minimal clock rate is now returned immediately in round_rate for NM PLLs

Changes in v2:
- Fixed build warning on arm64
- Fixed condition in determine_rate function in HDMI PHY clock driver
- Added defines for polarity settings in HDMI PHY
- Added patch to skip LVDS code path altogether if TCON doesn't support it.
- round_rate for NM PLLs now rounds to minimal rate if requested rate is
  lower.
- set_rate for NM PLLs doesn't fail if requested rate is lower than minimal
  (round_rate is called before which already guarantees that rate is not
   lower than minimal).

Jernej Skrabec (16):
  clk: sunxi-ng: Add check for minimal rate to NM PLLs
  clk: sunxi-ng: h3: h5: Add minimal rate for video PLL
  clk: sunxi-ng: h3: h5: Allow some clocks to set parent rate
  clk: sunxi-ng: h3: h5: export CLK_PLL_VIDEO
  dt-bindings: display: sun4i-drm: Add compatibles for H3 HDMI pipeline
  drm/sun4i: Release exclusive clock lock when disabling TCON
  drm/sun4i: Add support for H3 display engine
  drm/sun4i: Add support for H3 mixer 0
  drm/sun4i: Fix polarity configuration for DW HDMI PHY
  drm/sun4i: Add support for variants to DW HDMI PHY
  drm/sun4i: Move and expand DW HDMI PHY register macros
  drm/sun4i: Add support for H3 HDMI PHY variant
  drm/sun4i: Allow building on arm64
  ARM: dts: sunxi: h3/h5: Add HDMI pipeline
  ARM: dts: sun8i: h3: Enable HDMI output on H3 boards
  ARM64: dts: sun50i: h5: Enable HDMI output on H5 boards

 .../bindings/display/sunxi/sun4i-drm.txt           |   6 +
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |  25 ++
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts          |  25 ++
 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts |  25 ++
 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts           |  25 ++
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |  25 ++
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       |  25 ++
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        |  24 ++
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |  25 ++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 | 108 ++++++
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  |  25 ++
 .../dts/allwinner/sun50i-h5-orangepi-prime.dts     |  25 ++
 .../allwinner/sun50i-h5-orangepi-zero-plus2.dts    |  25 ++
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |  32 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.h                |   4 +-
 drivers/clk/sunxi-ng/ccu_nm.c                      |   7 +
 drivers/clk/sunxi-ng/ccu_nm.h                      |  27 ++
 drivers/gpu/drm/sun4i/Kconfig                      |   2 +-
 drivers/gpu/drm/sun4i/Makefile                     |   1 +
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |   1 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |   6 +-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h              | 157 ++++++++-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c             | 369 ++++++++++++++++++---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c         | 132 ++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |  12 +
 include/dt-bindings/clock/sun8i-h3-ccu.h           |   2 +
 26 files changed, 1070 insertions(+), 70 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c

-- 
2.16.2
