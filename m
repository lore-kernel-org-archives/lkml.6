Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7D4C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00EC2588B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00EC2588B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933302AbeFYME5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:04:57 -0400
Received: from mailoutvs47.siol.net ([185.57.226.238]:47763 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932444AbeFYMEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:04:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 3F8B75202EC;
        Mon, 25 Jun 2018 14:04:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1QoWdm7oavQy; Mon, 25 Jun 2018 14:04:51 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 8969E52029A;
        Mon, 25 Jun 2018 14:04:51 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id B1B70520604;
        Mon, 25 Jun 2018 14:04:48 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 04/24] dt-bindings: display: sunxi-drm: Add TCON TOP description
Date:   Mon, 25 Jun 2018 14:02:44 +0200
Message-Id: <20180625120304.7543-5-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180625120304.7543-1-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCON TOP main purpose is to configure whole display pipeline. It
determines relationships between mixers and TCONs, selects source TCON
for HDMI, muxes LCD and TV encoder GPIO output, selects TV encoder
clock source and contains additional TV TCON and DSI gates.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../bindings/display/sunxi/sun4i-drm.txt      | 56 +++++++++++++++++++
 include/dt-bindings/clock/sun8i-tcon-top.h    | 11 ++++
 2 files changed, 67 insertions(+)
 create mode 100644 include/dt-bindings/clock/sun8i-tcon-top.h

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 3346c1e2a7a0..fe31b1510717 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -187,6 +187,62 @@ And on the A23, A31, A31s and A33, you need one more clock line:
    - 'lvds-alt': An alternative clock source, separate from the TCON channel 0
                  clock, that can be used to drive the LVDS clock
 
+TCON TOP
+--------
+
+TCON TOPs main purpose is to configure whole display pipeline. It determines
+relationships between mixers and TCONs, selects source TCON for HDMI, muxes
+LCD and TV encoder GPIO output, selects TV encoder clock source and contains
+additional TV TCON and DSI gates.
+
+It allows display pipeline to be configured in very different ways:
+
+                                / LCD0/LVDS0
+                 / [0] TCON-LCD0
+                 |              \ MIPI DSI
+ mixer0          |
+        \        / [1] TCON-LCD1 - LCD1/LVDS1
+         TCON-TOP
+        /        \ [2] TCON-TV0 [0] - TVE0/RGB
+ mixer1          |                  \
+                 |                   TCON-TOP - HDMI
+                 |                  /
+                 \ [3] TCON-TV1 [1] - TVE1/RGB
+
+Note that both TCON TOP references same physical unit. Both mixers can be
+connected to any TCON.
+
+Required properties:
+  - compatible: value must be one of:
+    * allwinner,sun8i-r40-tcon-top
+  - reg: base address and size of the memory-mapped region.
+  - clocks: phandle to the clocks feeding the TCON TOP
+    * bus: TCON TOP interface clock
+    * tcon-tv0: TCON TV0 clock
+    * tve0: TVE0 clock
+    * tcon-tv1: TCON TV1 clock
+    * tve1: TVE0 clock
+    * dsi: MIPI DSI clock
+  - clock-names: clock name mentioned above
+  - resets: phandle to the reset line driving the TCON TOP
+  - #clock-cells : must contain 1
+  - clock-output-names: Names of clocks created for TCON TV0 channel clock,
+    TCON TV1 channel clock and DSI channel clock, in that order.
+
+- ports: A ports node with endpoint definitions as defined in
+    Documentation/devicetree/bindings/media/video-interfaces.txt. 6 ports should
+    be defined:
+    * port 0 is input for mixer0 mux
+    * port 1 is output for mixer0 mux
+    * port 2 is input for mixer1 mux
+    * port 3 is output for mixer1 mux
+    * port 4 is input for HDMI mux
+    * port 5 is output for HDMI mux
+    All output endpoints for mixer muxes and input endpoints for HDMI mux should
+    have reg property with the id of the target TCON, as shown in above graph
+    (0-3 for mixer muxes and 0-1 for HDMI mux). All ports should have only one
+    endpoint connected to remote endpoint.
+
 DRC
 ---
 
diff --git a/include/dt-bindings/clock/sun8i-tcon-top.h b/include/dt-bindings/clock/sun8i-tcon-top.h
new file mode 100644
index 000000000000..25164d767835
--- /dev/null
+++ b/include/dt-bindings/clock/sun8i-tcon-top.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/* Copyright (C) 2018 Jernej Skrabec <jernej.skrabec@siol.net> */
+
+#ifndef _DT_BINDINGS_CLOCK_SUN8I_TCON_TOP_H_
+#define _DT_BINDINGS_CLOCK_SUN8I_TCON_TOP_H_
+
+#define CLK_TCON_TOP_TV0	0
+#define CLK_TCON_TOP_TV1	1
+#define CLK_TCON_TOP_DSI	2
+
+#endif /* _DT_BINDINGS_CLOCK_SUN8I_TCON_TOP_H_ */
-- 
2.18.0

