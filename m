Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031337AbeBNUJi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 15:09:38 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:36631 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031527AbeBNUJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 15:09:34 -0500
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, narmstrong@baylibre.com,
        Jose.Abreu@synopsys.com
Cc: jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v5 00/12] drm/sun4i: Add A83T HDMI support
Date: Wed, 14 Feb 2018 21:08:54 +0100
Message-Id: <20180214200906.31509-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implements support for A83T DW HDMI and PHY. Contrary to
v1 series, this one is based on latest linux-next, since all needed patches
were merged.

While exactly this combination of HDMI controller and PHY is not common in
Allwinner SoCs, this patch series nevertheless makes groundwork for other
SoCs, which have same DW HDMI IP block, but different PHYs, like H3 and H5.

Please take a look.

Best regards,
Jernej

Changes from v4:
- Added Acked-by tag
- DT patch doesn't add second example anymore
- Removed unneeded properties from dtsi

Changes from v3:
- Collected tags
- drop patch for changing NKMP formula
- add patch to use 64 bit intermediate variable for calculating NKMP
  clock rate and thus preventing overflow in some cases
- rework DT bindings patch according Rob's suggestions
- move TMDS clock from PHY to controller driver, since documentation
  suggest such relationship

Changes from v2:
- Collected ACKs and Review-by tags
- patch for deinit callback was replaced with the one which gives control
  of drvdata to driver
- fixed meson driver (renamed reset function)
- prototypes for newly exported functions in dw_hdmi.h were reordered

Changes from v1:
- Collected ACKs
- Separated bindings for controller and PHY
- Split driver into two parts - controller and PHY
- HDMI PHY driver now uses regmap for writes
- added defines for PHY registers and bits
- updated DT entries to accommodate new bindings
- removed already merged clock patch
- reworked first clock patch according to comments
- added new clock patch which changes NKMP formula
- split TCON patch in two, one for quirk and one for new compatible
- reworked patch which exports DW HDMI PHY functions:
  - remove "gen2" from some function names
  - removed parameter from dw_hdmi_phy_reset()
  - added address parameter to dw_hdmi_phy_i2c_set_addr()
- updated most of commit messages

Jernej Skrabec (12):
  clk: sunxi-ng: Mask nkmp factors when setting register
  clk: sunxi-ng: Use u64 for calculation of nkmp rate
  drm/bridge/synopsys: dw-hdmi: Enable workaround for v1.32a
  drm/bridge/synopsys: dw-hdmi: Export some PHY related functions
  drm/bridge/synopsys: dw-hdmi: don't clobber drvdata
  dt-bindings: display: sun4i-drm: Add A83T HDMI pipeline
  drm/sun4i: Add has_channel_0 TCON quirk
  drm/sun4i: Add support for A83T second TCON
  drm/sun4i: Add support for A83T second DE2 mixer
  drm/sun4i: Implement A83T HDMI driver
  ARM: dts: sun8i: a83t: Add HDMI display pipeline
  ARM: dts: sun8i: a83t: Enable HDMI on BananaPi M3

 .../bindings/display/sunxi/sun4i-drm.txt           |  61 ++++-
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       |  25 ++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 108 ++++++++-
 drivers/clk/sunxi-ng/ccu_nkmp.c                    |  42 +++-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  83 ++++---
 drivers/gpu/drm/imx/dw_hdmi-imx.c                  |  13 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |  22 +-
 drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c             |  12 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |  13 +-
 drivers/gpu/drm/sun4i/Kconfig                      |   9 +
 drivers/gpu/drm/sun4i/Makefile                     |   4 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  46 +++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |   1 +
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              | 196 +++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h              |  44 ++++
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c             | 270 +++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |  11 +
 include/drm/bridge/dw_hdmi.h                       |  24 +-
 18 files changed, 896 insertions(+), 88 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c

-- 
2.16.1
