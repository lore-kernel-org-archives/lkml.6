Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966636AbeBOIjS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 03:39:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755353AbeBOIi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 03:38:59 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55AE2177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=kbingham@kernel.org
From: Kieran Bingham <kbingham@kernel.org>
To: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>, geert@glider.be,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 8/8] [PoC] arm64: dts: renesas: r8a77995-draak: Add ADV7612
Date: Thu, 15 Feb 2018 08:38:23 +0000
Message-Id: <1518683903-10681-9-git-send-email-kbingham@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
References: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kieran Bingham <kieran.bingham@ideasonboard.com>

Provide a node for the ADV7612. There is no VIN support yet, so this
node will only instantiate the device on the I2C bus for I2C address
testing.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 43 ++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index df0c7773cb7d..d7dd471c9fde 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -27,6 +27,17 @@
 		stdout-path = "serial0:115200n8";
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
 	hdmi-out {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -168,6 +179,38 @@
 			};
 		};
 	};
+
+	hdmi-in@4c {
+		compatible = "adi,adv7612";
+		reg = <0x4c>, <0x5a>, <0x5b>, <0x5c>, <0x5d>, <0x5e>, <0x5f>,
+		      <0x6a>, <0x6b>, <0x6c>, <0x6d>, <0x6e>, <0x6f>;
+		reg-names = "main", "avlink", "cec", "infoframe", "esdp",
+			    "dpp", "afe", "rep", "edid", "hdmi", "test",
+			    "cp", "vdp";
+
+		/* ADV7612_INTn connected only to test point CP56. */
+
+		default-input = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				adv7612_in: endpoint {
+					remote-endpoint = <&hdmi_con_in>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+				adv7612_out: endpoint {
+					// remote-endpoint = <&vin0ep2>;
+				};
+			};
+		};
+	};
 };
 
 &i2c1 {
-- 
2.7.4
