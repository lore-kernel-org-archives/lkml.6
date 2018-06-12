Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 77DE9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38ECE2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38ECE2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933983AbeFLUCF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:02:05 -0400
Received: from mailoutvs26.siol.net ([185.57.226.217]:38260 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933611AbeFLUCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:02:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id A34D852212F;
        Tue, 12 Jun 2018 22:01:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SpG0yji_IhvB; Tue, 12 Jun 2018 22:01:58 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id F0503521FAC;
        Tue, 12 Jun 2018 22:01:57 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 711A652212F;
        Tue, 12 Jun 2018 22:01:55 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 04/27] dt-bindings: display: sunxi-drm: Add TCON TOP description
Date:   Tue, 12 Jun 2018 22:00:13 +0200
Message-Id: <20180612200036.21483-5-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
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
 .../bindings/display/sunxi/sun4i-drm.txt      | 45 +++++++++++++++++++
 include/dt-bindings/clock/sun8i-tcon-top.h    | 11 +++++
 2 files changed, 56 insertions(+)
 create mode 100644 include/dt-bindings/clock/sun8i-tcon-top.h

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 3346c1e2a7a0..ef64c589a4b3 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -187,6 +187,51 @@ And on the A23, A31, A31s and A33, you need one more clock line:
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
+                             / LCD0/LVDS0
+                 / TCON-LCD0
+                 |           \ MIPI DSI
+ mixer0          |
+        \        / TCON-LCD1 - LCD1/LVDS1
+         TCON-TOP
+        /        \ TCON-TV0 - TVE0/RGB
+ mixer1          |          \
+                 |           TCON-TOP - HDMI
+                 |          /
+                 \ TCON-TV1 - TVE1/RGB
+
+Note that both TCON TOP references same physical unit.
+
+Required properties:
+  - compatible: value must be one of:
+    * allwinner,sun8i-r40-tcon-top
+  - reg: base address and size of the memory-mapped region.
+  - clocks: phandle to the clocks feeding the TCON TOP
+    * bus: TCON TOP interface clock
+  - clock-names: clock name mentioned above
+  - resets: phandle to the reset line driving the DRC
+    * rst: TCON TOP reset line
+  - reset-names: reset name mentioned above
+  - #clock-cells : must contain 1
+
+- ports: A ports node with endpoint definitions as defined in
+    Documentation/devicetree/bindings/media/video-interfaces.txt. The first port
+    should be the input for mixer0 mux. The second should be the output for that
+    mux. Third port should be input for mixer1 mux. Fourth port should be output
+    for mixer1 mux. Fifth port should be input for HDMI mux. Sixth port should
+    be output for it. All output endpoints should have reg property with the id
+    of the target TCON. All ports should have only one enpoint connected to
+    remote endpoint.
+
 DRC
 ---
 
diff --git a/include/dt-bindings/clock/sun8i-tcon-top.h b/include/dt-bindings/clock/sun8i-tcon-top.h
new file mode 100644
index 000000000000..c05e92770402
--- /dev/null
+++ b/include/dt-bindings/clock/sun8i-tcon-top.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/* Copyright (C) 2018 Jernej Skrabec <jernej.skrabec@siol.net> */
+
+#ifndef _DT_BINDINGS_CLOCK_SUN8I_TCON_TOP_H_
+#define _DT_BINDINGS_CLOCK_SUN8I_TCON_TOP_H_
+
+#define CLK_BUS_TCON_TOP_DSI	0
+#define CLK_BUS_TCON_TOP_TV0	1
+#define CLK_BUS_TCON_TOP_TV1	2
+
+#endif /* _DT_BINDINGS_CLOCK_SUN8I_TCON_TOP_H_ */
-- 
2.17.1

