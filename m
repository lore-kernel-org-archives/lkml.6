Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934138AbeBLLay (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 06:30:54 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54341 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S934007AbeBLL3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 06:29:46 -0500
X-UUID: f34a957f7d994ad18f9798f5a40e07eb-20180212
From: Ryder Lee <ryder.lee@mediatek.com>
To: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
CC: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, Garlic Tseng <garlic.tseng@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v3 4/5] dt-bindings: clock: mediatek: update audsys documentation to adapt MFD device
Date: Mon, 12 Feb 2018 19:28:50 +0800
Message-ID: <61928ad523a7aeffb8f16d4caad56836b65ae407.1518424204.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1518424204.git.ryder.lee@mediatek.com>
References: <cover.1518424204.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek audio hardware block that exposes functionalities that are
handled by separate subsystems in the kernel.  These functions are all
mapped somewhere at 0x112xxxxx, and there are some control bits are mixed
up with other functions within the same registers.

Therefore, it's better to switch the AUDSYS to MFD device for the sake of
avoiding adding individual nodes with the overlapping regions for those
devices.

This patch adds a top level node "simple-mfd" to represent whole subsystem,
which consists of two portions - audio componets and clock part.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../bindings/arm/mediatek/mediatek,audsys.txt      | 37 ++++++++++++++++++----
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
index 9b8f578..677af40 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
@@ -1,22 +1,45 @@
-MediaTek AUDSYS controller
+MediaTek Audio Subsystem
 ============================
+The audio subsystem is one of the multi-function blocks of MediaTek SoCs.
+It contains a system controller, which provides a number registers giving
+access to two features: AUDSYS clocks and Audio Front End (AFE) components.
 
+For the top level node:
+- compatible: must be: "syscon", "simple-mfd";
+- reg: register area of the Audio Subsystem
+
+Required sub-nodes:
+
+AUDSYS clocks:
+-------
 The MediaTek AUDSYS controller provides various clocks to the system.
 
 Required Properties:
 
 - compatible: Should be one of:
-	- "mediatek,mt7622-audsys", "syscon"
+	- "mediatek,mt2701-audsys";
+	- "mediatek,mt7622-audsys";
 - #clock-cells: Must be 1
 
 The AUDSYS controller uses the common clk binding from
 Documentation/devicetree/bindings/clock/clock-bindings.txt
 The available clocks are defined in dt-bindings/clock/mt*-clk.h.
 
+AFE components:
+-------
+For common binding part and usage, refer to
+../sonud/mt2701-afe-pcm.txt.
+
 Example:
 
-audsys: audsys@11220000 {
-	compatible = "mediatek,mt7622-audsys", "syscon";
-	reg = <0 0x11220000 0 0x1000>;
-	#clock-cells = <1>;
-};
+	audio-subsystem@11220000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0 0x11220000 0 0x2000>;
+
+		audsys: clock {
+			compatible = "mediatek,mt2701-audsys";
+			#clock-cells = <1>;
+		};
+
+		...
+	};
-- 
1.9.1
