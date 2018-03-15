Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbeCOLns (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:43:48 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:59330 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751791AbeCOLlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:41:40 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] drm/sun4i: Add compatible strings for A80 TCONs
Date: Thu, 15 Mar 2018 19:41:29 +0800
Message-Id: <20180315114136.24747-2-wens@csie.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315114136.24747-1-wens@csie.org>
References: <20180315114136.24747-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A80 has 2 or 3 TCONs. The documentation and vendor kernel are very
vague about the third TCON, to the point that it might not exist.

In the documentation, the first TCON is missing channel 1, and the
second is missing channel 0. However the vendor kernel seems to be
able to use them regardless. Here we model them like the old TCONs.

An oddity is that TCON0 requires the reset control for the eDP block
to be deasserted, for any register access to stick.

This patch adds compatible strings for TCON0 and TCON1, with TCON0
requiring an extra "edp" reset control.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 8bdef4920edc..c05cbcdde4d7 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -146,13 +146,16 @@ Required properties:
    * allwinner,sun8i-a83t-tcon-lcd
    * allwinner,sun8i-a83t-tcon-tv
    * allwinner,sun8i-v3s-tcon
+   * allwinner,sun9i-a80-tcon-lcd
+   * allwinner,sun9i-a80-tcon-tv
  - reg: base address and size of memory-mapped region
  - interrupts: interrupt associated to this IP
  - clocks: phandles to the clocks feeding the TCON.
    - 'ahb': the interface clocks
-   - 'tcon-ch0': The clock driving the TCON channel 0, except for A83T TV TCON
+   - 'tcon-ch0': The clock driving the TCON channel 0, if supported
  - resets: phandles to the reset controllers driving the encoder
-   - "lcd": the reset line for the TCON channel 0
+   - "lcd": the reset line for the TCON
+   - "edp": the reset line for the eDP block (A80 only)
 
  - clock-names: the clock names mentioned above
  - reset-names: the reset names mentioned above
@@ -171,7 +174,9 @@ Required properties:
   channel the endpoint is associated to. If that property is not
   present, the endpoint number will be used as the channel number.
 
-On SoCs other than the A33 and V3s, there is one more clock required:
+For TCONs with channel 0, there is one more clock required:
+   - 'tcon-ch0': The clock driving the TCON channel 0
+For TCONs with channel 1, there is one more clock required:
    - 'tcon-ch1': The clock driving the TCON channel 1
 
 When TCON support LVDS (all TCONs except TV TCON on A83T and those found
-- 
2.16.2
