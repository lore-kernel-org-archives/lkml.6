Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeD3LlO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 07:41:14 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:41748 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbeD3LlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 07:41:11 -0400
X-Google-Smtp-Source: AB8JxZpS8OhHVrEy5tciNn4/cCFAmZDsalT2XX4bn94aivQA7dhrcbgLJ4flkjzUE5QW9zBlQOd3wQ==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 00/21] arm64: allwinner: Add A64 DE2 HDMI support
Date: Mon, 30 Apr 2018 17:10:37 +0530
Message-Id: <20180430114058.5061-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 has display engine pipeline like other Allwinner SOC's A83T/H3/H5.

A64 DE2 behaviour similar to Allwinner A83T where mixer0, connected to tcon0
with RGB, LVDS MIPI-DSI and mixer1, connected to tcon1 with HDMI as per
Display System Block DiagramAllwinner_A64_User_Manual_V1.1.pdf

This is the first series on Allwinner A64 DE2 HDMI support which followed
with previous RFC series [1] (thanks to Maxime, Jernej for comments on RFC series)
and rest will add in future patches.

patch 1: dt-bindings for a64 de2 ccu

patch 2: add node support for a64 de2 ccu

patch 3: enable DE2_CCU for Allwinner 64-bit SoCs

patch 4: dt-bindings for a64 de2 pipeline

patch 5: add support for a64 de2

patch 6: defconfig: enable CONFIG_DRM_SUN4I

patch 7 -8: dt-bindings for a64 HDMI and HDMI PHY

patch 9: add support for a64 HDMI

patch 10: enable DesignWare HDMI for Allwinner 64-bit SoCs

patch 11 - 12: dt-bindings for a64 mixer1 and tcon1

patch 13: enable de2 mixer for Allwinner 64-bit SoCs

patch 14: add support for a64 HDMI pipeline

patch 15: add support for HVCC regulator

patch 16: enable HDMI out for bananapi-m64

patch 17: enable HDMI out for nanopi-a64

patch 18: enable HDMI out for orangepi-win

patch 19: enable HDMI out for a64-olinuxino

patch 20: enable HDMI out for pine64

patch 21: enable HDMI out for sopine

Since this series added HDMI through mixer1 through tcon1,
I have used CLK_PLL_VIDEO1 as pll-0 we need to update the driver
to support both CLK_PLL_VIDEO0 and 1 once we have add hdmi through mixer0.

Note:
with pine64 and sopine, I'm unable to see any display on screen but
loadded fine, request to verify anyone.

Log:
---
# modprobe -a sun4i-drm sun8i-mixer sun4i_tv sun4i-drm-hdmi sun8i-drm-hdmi          
[   13.390465] sun4i-drm display-engine: bound 1200000.mixer (ops sun8i_mixer_ops [sun8i_mixer])
[   13.399247] sun4i-drm display-engine: No panel or bridge found... RGB output disabled
[   13.407113] sun4i-drm display-engine: bound 1c0d000.lcd-controller (ops sun4i_tcon_ops [sun4i_tcon])
[   13.417386] sun8i-dw-hdmi 1ee0000.hdmi: Detected HDMI TX controller v1.32a with HDCP (sun8i_dw_hdmi_ph
y)                                                                                  
[   13.427436] sun8i-dw-hdmi 1ee0000.hdmi: registered DesignWare HDMI I2C bus driver
[   13.435987] sun4i-drm display-engine: bound 1ee0000.hdmi (ops sun8i_dw_hdmi_ops [sun8i_drm_hdmi])
[   13.444868] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).          
[   13.451498] [drm] No driver support for vblank timestamp query.                  
[   13.922226] Console: switching to colour frame buffer device 320x90              
[   14.008789] sun4i-drm display-engine: fb0:  frame buffer device                  
[   14.028297] [drm] Initialized sun4i-drm 1.0.0 20150629 for display-engine on minor 0

[1] https://lkml.org/lkml/2018/4/24/547

Icenowy Zheng (1):
  drm: sun4i: add support for HVCC regulator for DWC HDMI glue

Jagan Teki (20):
  dt-bindings: clock: Add compatible for A64 DE2 CCU
  arm64: dts: allwinner: a64: Add DE2 CCU
  clk: sunxi-ng: Enable DE2_CCU for Allwinner 64-bit SoCs
  bindings: display: Add compatible for A64 DE2 pipeline
  drm/sun4i: Add support for A64 display engine
  arm64: defconfig: Enable CONFIG_DRM_SUN4I
  bindings: display: Add compatible for A64 HDMI
  bindings: display: Add compatible for A64 HDMI PHY
  arm64: dts: allwinner: a64: Add HDMI support
  drm/sun4i: Enable DesignWare HDMI for Allwinner 64-bit SoCs
  bindings: display: Add compatible for A64 Mixer1
  bindings: display: Add compatible for A64 tcon-tv
  drm/sun4i: Enable DE2 Mixer for Allwinner 64-bit SoCs
  arm64: dts: allwinner: a64: Add HDMI pipeline
  arm64: dts: allwinner: a64: bananapi-m64: Enable HDMI output
  arm64: dts: allwinner: a64: nanopi-a64: Enable HDMI output
  arm64: dts: allwinner: a64: orangepi-win: Enable HDMI output
  arm64: dts: allwinner: a64: a64-olinuxino: Enable HDMI output
  arm64: dts: allwinner: a64: pine64: Enable HDMI output
  arm64: dts: allwinner: a64: sopine: Enable HDMI output

 .../devicetree/bindings/clock/sun8i-de2.txt        |   1 +
 .../bindings/display/sunxi/sun4i-drm.txt           |   5 +
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |  26 +++++
 .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   |  26 +++++
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    |  26 +++++
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts |  26 +++++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  26 +++++
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  |  26 +++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 126 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/clk/sunxi-ng/Kconfig                       |   2 +
 drivers/gpu/drm/sun4i/Kconfig                      |   3 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |   1 +
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              |  14 +++
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h              |   2 +
 include/dt-bindings/clock/sun50i-a64-ccu.h         |   2 +
 16 files changed, 312 insertions(+), 1 deletion(-)

-- 
2.14.3
