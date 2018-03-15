Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeCOL2V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:28:21 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:46097 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbeCOL2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:28:20 -0400
X-Originating-IP: 2.224.242.101
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] arm64: dts: renesas: Add LVDS decoder to R-Car V3M Eagle
Date: Thu, 15 Mar 2018 11:56:31 +0100
Message-Id: <1521111391-3515-4-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521111391-3515-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1521111391-3515-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R-Car V3M Eagle board includes a transparent THC63LVD1024 LVDS
decoder, connected to the on-chip LVDS encoder output on one side
and to HDMI encoder ADV7511w on the other one.

As the decoder does not need any configuration it has been so-far
omitted from DTS. Now that a driver is available, describe it in DT
as well.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 33 +++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
index c0fd144..69f43b8 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
@@ -42,6 +42,33 @@
 			};
 		};
 	};
+
+	thc63lvd1024: lvds-decoder {
+		compatible = "thine,thc63lvd1024";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				thc63lvd1024_in_0: endpoint {
+					remote-endpoint = <&lvds0_out>;
+				};
+			};
+
+			port@2{
+				reg = <2>;
+
+				thc63lvd1024_out_2: endpoint {
+					remote-endpoint = <&adv7511_in>;
+				};
+
+			};
+
+		};
+	};
 };
 
 &avb {
@@ -98,7 +125,7 @@
 			port@0 {
 				reg = <0>;
 				adv7511_in: endpoint {
-					remote-endpoint = <&lvds0_out>;
+					remote-endpoint = <&thc63lvd1024_out_2>;
 				};
 			};
 
@@ -152,8 +179,8 @@
 
 	ports {
 		port@1 {
-			endpoint {
-				remote-endpoint = <&adv7511_in>;
+			lvds0_out: endpoint {
+				remote-endpoint = <&thc63lvd1024_in_0>;
 			};
 		};
 	};
-- 
2.7.4
