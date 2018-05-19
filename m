Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbeESScb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 14:32:31 -0400
Received: from mailout6.siol.net ([213.250.19.133]:34612 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752451AbeESSc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 14:32:27 -0400
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 00/15] Add support for R40 HDMI pipeline
Date: Sat, 19 May 2018 20:31:12 +0200
Message-Id: <20180519183127.2718-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for R40 HDMI pipeline. It is a bit special
than other already supported pipelines because it has additional unit
called TCON TOP responsible for relationship configuration between
mixers, TCONs and HDMI. Additionally, it has additional gates for DSI
and TV TCONs, TV encoder clock settings and pin muxing between LCD
and TV encoders.

However, it seems that TCON TOP will become a norm, since newer
Allwinner SoCs like H6 also have this unit.

I tested different possible configurations:
- mixer0 <> TCON-TV0 <> HDMI
- mixer0 <> TCON-TV1 <> HDMI
- mixer1 <> TCON-TV0 <> HDMI
- mixer1 <> TCON-TV1 <> HDMI

Please review.

Best regards,
Jernej

Jernej Skrabec (15):
  clk: sunxi-ng: r40: Add minimal rate for video PLLs
  clk: sunxi-ng: r40: Allow setting parent rate to display related
    clocks
  clk: sunxi-ng: r40: Export video PLLs
  dt-bindings: display: sunxi-drm: Add TCON TOP description
  drm/sun4i: Add TCON TOP driver
  drm/sun4i: tcon: Add support for tcon-top
  dt-bindings: display: sun4i-drm: Add R40 HDMI pipeline
  drm/sun4i: DE2 mixer: Add index quirk
  drm/sun4i: Add support for R40 mixers
  drm/sun4i: Add support for R40 TV TCONs
  drm/sun4i: DW HDMI PHY: Add support for second PLL
  drm/sun4i: Add support for second clock parent to DW HDMI PHY clk
    driver
  drm/sun4i: Add support for A64 HDMI PHY
  ARM: dts: sun8i: r40: Add HDMI pipeline
  ARM: dts: sun8i: r40: Enable HDMI output on BananaPi M2 Ultra

 .../bindings/display/sunxi/sun4i-drm.txt      |  36 ++-
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  50 ++++
 arch/arm/boot/dts/sun8i-r40.dtsi              | 166 ++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c          |  58 ++--
 drivers/clk/sunxi-ng/ccu-sun8i-r40.h          |   8 +-
 drivers/gpu/drm/sun4i/Makefile                |   3 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |  67 +++++
 drivers/gpu/drm/sun4i/sun4i_tcon.h            |   8 +
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h         |   8 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c        |  61 ++++-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c    |  90 ++++--
 drivers/gpu/drm/sun4i/sun8i_mixer.c           |  30 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.h           |   2 +
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c        | 256 ++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_tcon_top.h        |  20 ++
 include/dt-bindings/clock/sun8i-r40-ccu.h     |   4 +
 include/dt-bindings/clock/sun8i-tcon-top.h    |  11 +
 17 files changed, 813 insertions(+), 65 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_tcon_top.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_tcon_top.h
 create mode 100644 include/dt-bindings/clock/sun8i-tcon-top.h

-- 
2.17.0
