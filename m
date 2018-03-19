Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971239AbeCSUO3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:14:29 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:46337 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969087AbeCSUOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:14:20 -0400
X-Google-Smtp-Source: AG47ELtZfKO7nIHLXbVfMMzI5WRP9d+gZgMPSIO6IaW+T7mv8OHONVdDDfhD3I7Zf0nRUe3/PKvb1g==
From: Matt Porter <mporter@konsulko.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] arm: dts: hummingboard: convert onboard audio to simple-audio-card
Date: Mon, 19 Mar 2018 16:14:13 -0400
Message-Id: <20180319201414.29481-1-mporter@konsulko.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HB onboard audio currently makes use of the imx-audio-sgtl5000
binding. This binding does not support auxiliary audio devices such
as external amplifiers. The simple-audio-card binding does support
this property which allows systems incorporating the HB to add an
auxiliary device that's attached to the HB audio jack with an
overlay. Convert the HB onboard audio to use simple-audio-card for
this additional flexibility.

Signed-off-by: Matt Porter <mporter@konsulko.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
v2:
    - also convert HB1 to simple-audio-card
    - retain original card name as "On-board Codec" [case change]

 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi  | 52 ++++++++++++++++++++++------
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 48 ++++++++++++++++++++-----
 2 files changed, 82 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index 92583238ca4a..2f6e51fbd4bc 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -38,6 +38,7 @@
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
+#include <dt-bindings/sound/fsl-imx-audmux.h>
 
 / {
 	chosen {
@@ -105,17 +106,27 @@
 		vin-supply = <&v_5v0>;
 	};
 
-	sound-sgtl5000 {
-		audio-codec = <&sgtl5000>;
-		audio-routing =
-			"MIC_IN", "Mic Jack",
-			"Mic Jack", "Mic Bias",
+	audio: sound-sgtl5000 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "On-board Codec";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&sound_codec>;
+		simple-audio-card,frame-master = <&sound_codec>;
+		simple-audio-card,widgets =
+			"Microphone", "Headphone Jack",
+			"Headphone", "Headphone Jack";
+		simple-audio-card,routing =
+			"MIC_IN", "Headphone Jack",
+			"Headphone Jack", "Mic Bias",
 			"Headphone Jack", "HP_OUT";
-		compatible = "fsl,imx-audio-sgtl5000";
-		model = "On-board Codec";
-		mux-ext-port = <5>;
-		mux-int-port = <1>;
-		ssi-controller = <&ssi1>;
+
+		sound_cpu: simple-audio-card,cpu {
+			sound-dai = <&ssi1>;
+		};
+
+		sound_codec: simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+		};
 	};
 
 	sound-spdif {
@@ -129,6 +140,26 @@
 
 &audmux {
 	status = "okay";
+
+	ssi1 {
+		fsl,audmux-port = <0>;
+		fsl,port-config = <
+			(IMX_AUDMUX_V2_PTCR_SYN |
+			 IMX_AUDMUX_V2_PTCR_TFSEL(4) |
+			 IMX_AUDMUX_V2_PTCR_TCSEL(4) |
+			 IMX_AUDMUX_V2_PTCR_TFSDIR |
+			 IMX_AUDMUX_V2_PTCR_TCLKDIR)
+			 IMX_AUDMUX_V2_PDCR_RXDSEL(4)
+		>;
+	};
+
+	pins5 {
+		fsl,audmux-port = <4>;
+		fsl,port-config = <
+			IMX_AUDMUX_V2_PTCR_SYN
+			IMX_AUDMUX_V2_PDCR_RXDSEL(0)
+		>;
+	};
 };
 
 &can1 {
@@ -161,6 +192,7 @@
 		compatible = "fsl,sgtl5000";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_hummingboard_sgtl5000>;
+		#sound-dai-cells = <0>;
 		reg = <0x0a>;
 		VDDA-supply = <&v_3v2>;
 		VDDIO-supply = <&v_3v2>;
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index dffbc92e0023..47d780fafd87 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -38,6 +38,7 @@
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
+#include <dt-bindings/sound/fsl-imx-audmux.h>
 
 / {
 	chosen {
@@ -145,22 +146,52 @@
 		vin-supply = <&v_5v0>;
 	};
 
-	sound-sgtl5000 {
-		audio-codec = <&sgtl5000>;
-		audio-routing =
+	audio: sound-sgtl5000 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "On-board Codec";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&sound_codec>;
+		simple-audio-card,frame-master = <&sound_codec>;
+		simple-audio-card,widgets =
+			"Microphone", "Mic Jack",
+			"Headphone", "Headphone Jack";
+		simple-audio-card,routing =
 			"MIC_IN", "Mic Jack",
 			"Mic Jack", "Mic Bias",
 			"Headphone Jack", "HP_OUT";
-		compatible = "fsl,imx-audio-sgtl5000";
-		model = "On-board Codec";
-		mux-ext-port = <5>;
-		mux-int-port = <1>;
-		ssi-controller = <&ssi1>;
+
+		sound_cpu: simple-audio-card,cpu {
+			sound-dai = <&ssi1>;
+		};
+
+		sound_codec: simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+		};
 	};
 };
 
 &audmux {
 	status = "okay";
+
+	ssi1 {
+		fsl,audmux-port = <0>;
+		fsl,port-config = <
+			(IMX_AUDMUX_V2_PTCR_SYN |
+			 IMX_AUDMUX_V2_PTCR_TFSEL(4) |
+			 IMX_AUDMUX_V2_PTCR_TCSEL(4) |
+			 IMX_AUDMUX_V2_PTCR_TFSDIR |
+			 IMX_AUDMUX_V2_PTCR_TCLKDIR)
+			 IMX_AUDMUX_V2_PDCR_RXDSEL(4)
+		>;
+	};
+
+	pins5 {
+		fsl,audmux-port = <4>;
+		fsl,port-config = <
+			IMX_AUDMUX_V2_PTCR_SYN
+			IMX_AUDMUX_V2_PDCR_RXDSEL(0)
+		>;
+	};
 };
 
 &ecspi2 {
@@ -193,6 +224,7 @@
 		compatible = "fsl,sgtl5000";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_hummingboard2_sgtl5000>;
+		#sound-dai-cells = <0>;
 		reg = <0x0a>;
 		VDDA-supply = <&v_3v2>;
 		VDDD-supply = <&vcc_1p8>;
-- 
2.11.0
