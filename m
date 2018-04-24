Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934466AbeDXNem (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:34:42 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:44826 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933922AbeDXNeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:34:36 -0400
X-Google-Smtp-Source: AIpwx48O+a/vjHOvPLW8fjdxhgXKpyiuE7Pfe6qwIkRTQ0uKYslZAVh1eDKhIVl4Au6N3YKPoek6gQ==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [RFC 00/13] arm64: allwinner: Add A64 DE2 pipeline support
Date: Tue, 24 Apr 2018 19:04:12 +0530
Message-Id: <20180424133425.24291-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 has display engine pipeline like other Allwinner SOC's A83T/H3/H5.

A64 DE2 behaviour similar to Allwinner A83T where mixer0, connected to tcon0 with
RGB, LVDS MIPI-DSI and mixer1, connected to tcon1 with HDMI.
This series merely concentrated on HDMI pipeline and rest will add eventually.

patch 1: dt-bindings for a64 DE2 CCU

patch 2: a64 DE2 CCU node addition

patch 3: dt-bindings for a64 DE2 pipeline

patch 4 - 5: dt-bindings for a64 mixer0 and tcon-lcd

patch 6: a64 DE2 pipeline node addition

patch 7 - 8: dt-bindings for a64 HDMI and HDMI PHY

patch 9: a64 HDMI nodes addition

patch 10 - 11: dt-bindings for a64 mixer1 and tcon-tv

patch 12: a64 HDMI pipeline

patch 13: enable HDMI out on bananpi-m64

Tested HDMI on bananapi-m64 (along with DE2 SRAM C changes from [1]
thread), able to detect the HDMI but, no penguins on screen.

Request for any suggestions.

Test log on Bananpi-m64:
[    0.247631] sun4i-drm display-engine: bound 1100000.mixer (ops sun8i_mixer_ops)
[    0.256717] sun4i-drm display-engine: bound 1200000.mixer (ops sun8i_mixer_ops)
[    0.256783] sun4i-tcon 1c0c000.lcd-controller: Missing LVDS properties, Please upgrade your DT
[    0.256792] sun4i-tcon 1c0c000.lcd-controller: LVDS output disabled
[    0.257081] sun4i-drm display-engine: No panel or bridge found... RGB output disabled
[    0.257099] sun4i-drm display-engine: bound 1c0c000.lcd-controller (ops sun4i_tcon_ops)
[    0.257273] sun4i-drm display-engine: No panel or bridge found... RGB output disabled
[    0.257288] sun4i-drm display-engine: bound 1c0d000.lcd-controller (ops sun4i_tcon_ops)
[    0.258176] sun8i-dw-hdmi 1ee0000.hdmi: Detected HDMI TX controller v1.32a with HDCP (sun8i_dw_hdmi_p)
[    0.258596] sun8i-dw-hdmi 1ee0000.hdmi: registered DesignWare HDMI I2C bus driver
[    0.259188] sun4i-drm display-engine: bound 1ee0000.hdmi (ops sun8i_dw_hdmi_ops)
[    0.259199] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    0.259205] [drm] No driver support for vblank timestamp query.
[    0.259308] [drm] Cannot find any crtc or sizes
[    0.259824] [drm] Initialized sun4i-drm 1.0.0 20150629 for display-engine on minor 0

[1] https://lkml.org/lkml/2018/3/16/1096

Jagan Teki (13):
  dt-bindings: clock: Add compatible for A64 DE2 CCU
  arm64: dts: allwinner: a64: Add DE2 CCU
  bindings: display: Add compatible for A64 DE2 pipeline
  bindings: display: Add compatible for A64 Mixer0
  bindings: display: Add compatible for A64 tcon-lcd
  arm64: dts: allwinner: a64: Add DE2 pipeline
  bindings: display: Add compatible for A64 HDMI
  bindings: display: Add compatible for A64 HDMI PHY
  arm64: dts: allwinner: a64: Add HDMI support
  bindings: display: Add compatible for A64 Mixer1
  bindings: display: Add compatible for A64 tcon-tv
  arm64: dts: allwinner: a64: Add HDMI pipeline
  arm64: dts: allwinner: a64: bananapi-m64: Enable HDMI output

 .../devicetree/bindings/clock/sun8i-de2.txt        |   1 +
 .../bindings/display/sunxi/sun4i-drm.txt           |   7 +
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |  26 +++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 181 +++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |   1 +
 include/dt-bindings/clock/sun50i-a64-ccu.h         |   2 +
 6 files changed, 218 insertions(+)

-- 
2.14.3
