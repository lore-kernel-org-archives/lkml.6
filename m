Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeEROsV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:48:21 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:56927 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeEROsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:48:17 -0400
X-Originating-IP: 2.224.242.101
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: niklas.soderlund@ragnatech.se, laurent.pinchart@ideasonboard.com,
        horms@verge.net.au, geert@glider.be, magnus.damm@gmail.com,
        robh+dt@kernel.org
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: renesas: draak: Describe HDMI input
Date: Fri, 18 May 2018 16:47:58 +0200
Message-Id: <1526654878-11143-4-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526654878-11143-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1526654878-11143-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe HDMI input connector and ADV7612 HDMI decoder installed on
R-Car Gen3 Draak board.

The video signal routing to the HDMI decoder to the video input interface
VIN4 is multiplexed with CVBS input path, and enabled/disabled through
on-board switches SW-49, SW-50, SW-51 and SW-52.

As the default board switches configuration connects CVBS input to VIN4,
leave the HDMI decoder unconnected in DTS.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

---
v2 -> v3:
- Add comment on HDMI output port about the shared CVBS/HDMI video path
- Add Niklas' R-b tag
---
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index 95745fc..1e475a4 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -59,6 +59,17 @@
 		};
 	};

+	hdmi-in {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&adv7612_in>;
+			};
+		};
+	};
+
 	memory@48000000 {
 		device_type = "memory";
 		/* first 128MB is reserved for secure area. */
@@ -176,6 +187,43 @@
 			};
 		};
 	};
+
+	hdmi-decoder@4c {
+		compatible = "adi,adv7612";
+		reg = <0x4c>;
+		default-input = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				adv7612_in: endpoint {
+					remote-endpoint = <&hdmi_con_in>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+
+				/*
+				 * The VIN4 video input path is shared between
+				 * CVBS and HDMI inputs through SW[49-54]
+				 * switches.
+				 *
+				 * CVBS is the default selection, leave HDMI
+				 * not connected here.
+				 */
+				adv7612_out: endpoint {
+					pclk-sample = <0>;
+					hsync-active = <0>;
+					vsync-active = <0>;
+				};
+			};
+		};
+	};
 };

 &i2c1 {
--
2.7.4
