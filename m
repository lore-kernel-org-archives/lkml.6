Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753073AbeDSJdf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 05:33:35 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:35656 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752783AbeDSJce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 05:32:34 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jonathan Liu <net147@gmail.com>
Subject: [PATCH 0/6] drm/sun4i: Support color dithering for LCD panels
Date: Thu, 19 Apr 2018 17:32:19 +0800
Message-Id: <20180419093225.614-1-wens@csie.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dithering is a method of approximating a color from a mixture of other
colors when the required color isn't available. It reduces color
banding artifacts that can be observed when displaying gradients
(e.g. grayscale gradients). This may occur when the image that needs
to be displayed is 24-bit but the LCD panel is a lower bit depth and
does not perform dithering on its own.

The TCON (LCD controller) found in Allwinner SoCs has hardware support
for dithering on channel 0, the channel used to feed LCD panels. This
series adds support for it.

Patch 1 reworks the mode set function for the CPU interface to pass
the encoder object, so it can be passed to other helper functions.

Patch 2 renames the dithering related register macros to reflect the
fact that dithering is only supported on channel 0.

Patch 3 adds support for dithering on all LCD panel output types.

Patch 4 adds support for Banana Pi's 7" DPI LCD panel.

Patch 5 adds a pinmux setting for RGB888 for the Allwinner A20 SoC.
This change has been sent by others before.

Patch 6 provides an example for enabling the Banana Pi 7" DPI LCD panel
on the Banana Pi M1+. This should not be merged. I will likely rework
this into an overlay in the future.

Note that I was only able to test dithering with DPI, as I do not have
other panel types. However the underlying concept and core code is the
same, as are the drm objects accessed. Nevertheless I'm hoping Jonathan
can test LVDS and Maxime can test MIPI DSI.

Also it seems pwm-backlight hardware is unusable at the moment. I'm not
sure whether the pwm-backlight or sun4i-pwm driver is to blame. I had to
manually poke the pwm registers so the LCD backlight wouldn't be
completely black.


Regards
ChenYu

Chen-Yu Tsai (5):
  drm/sun4i: tcon: Pass drm_encoder * into sun4i_tcon0_mode_set_cpu
  drm/sun4i: tcon: Rename Dithering related register macros
  drm/panel: simple: Add support for Banana Pi 7" S070WV20-CT16 panel
  ARM: dts: sun7i: add pinmux setting for RGB888 output for LCD0
  [DO NOT MERGE] ARM: dts: sun7i: bananapi-m1-plus: Enable Bananapi 7"
    800x480 RGB LCD panel

Jonathan Liu (1):
  drm/sun4i: tcon: Add dithering support for RGB565/RGB666 LCD panels

 .../display/panel/bananapi,s070wv20-ct16.txt  |  7 ++
 .../boot/dts/sun7i-a20-bananapi-m1-plus.dts   | 61 +++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi              | 11 +++
 drivers/gpu/drm/panel/panel-simple.c          | 25 ++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.c            | 76 ++++++++++++++++---
 drivers/gpu/drm/sun4i/sun4i_tcon.h            | 27 ++++---
 6 files changed, 186 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt

-- 
2.17.0
