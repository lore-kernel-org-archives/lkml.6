Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbeDDJ5t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:57:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42893 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751225AbeDDJ5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 05:57:33 -0400
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 0/8] drm/sun4i: Allwinner MIPI-DSI support
Date: Wed,  4 Apr 2018 11:57:08 +0200
Message-Id: <cover.a3617c4362eac8783f412525e52cf5552d19095d.1522835818.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is an preliminary version of the MIPI-DSI support for the Allwinner
SoCs.

This controller can be found on a number of recent SoCs, such as the
A31, A33 or the A64.

Given the sparse documentation, there's a number of obscure areas, but
the current implementation has been tested with a 4-lanes DSI panel on
an A33.

The support is a bit rough around the edges at the time, and some artifacts
are still shown on the screen for some reasons. Wider testing with
different display will hopefully nail those down.

This needs the regmap_mmio_attach_clk, on its way to Linus in 4.17.

Let me know what you think,
Maxime

Changes from v3:
  - Rebased on top of current drm-misc-next
  - Switched to SPDX license header
  - Made the ECC array const
  - Split the big DSI patch into two, one to add the DSI driver and one to
    add the TCON bits.
  - Removed the dithering code
  - Changed the DT labels to remove the indices
  - Used sleeps instead of delays in the panel driver
  - Used the backlight_enable / _disable functions
  - Added Chen-Yu's Reviewed-by

Changes from v2:
  - Added a ports node under the DSI node
  - Changed the huarui panel driver to an ili9881c driver
  - Changed the panel vendor to bananapi
  - Made the init table static in the panel driver
  - Dropped the huarui vendor patch for the DT doc.

Changes from v1:
  - Rebased on 4.16-rc1
  - Constified a few function arguments and structures
  - Reworked the DT binding example a bit
  - Reworked the panel driver to check for DSI return codes, and use DCS
    helpers when possible

Maxime Ripard (8):
  drm/sun4i: tcon: Add TRI finish interrupt for vblank
  dt-bindings: display: Add Allwinner MIPI-DSI bindings
  drm/sun4i: Add Allwinner A31 MIPI-DSI controller support
  drm/sun4i: Tie the DSI controller in the TCON
  dt-bindings: panel: Add the Ilitek ILI9881c panel documentation
  drm/panel: Add Ilitek ILI9881c panel driver
  ARM: dts: sun8i: a33: Add the DSI-related nodes
  [DO NOT MERGE] arm: dts: sun8i: bpi-m2m: Add DSI display

 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt |   20 +-
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt       |   93 ++++++-
 arch/arm/boot/dts/sun8i-a33.dtsi                                    |   44 +++-
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts                        |   39 +++-
 drivers/gpu/drm/panel/Kconfig                                       |    9 +-
 drivers/gpu/drm/panel/Makefile                                      |    1 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c                       |  489 ++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/Kconfig                                       |   10 +-
 drivers/gpu/drm/sun4i/Makefile                                      |    4 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                                  |   86 +++++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h                                  |   46 +++-
 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c                             |  292 +++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c                              | 1107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h                              |   63 ++++-
 14 files changed, 2300 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
 create mode 100644 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
 create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
 create mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c
 create mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
 create mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h

base-commit: 7d9cf386c8da2490d0ee55cedb87be94a9e6093a
-- 
git-series 0.9.1
