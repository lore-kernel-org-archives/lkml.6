Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeBFQfk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:35:40 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16174 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752637AbeBFQeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:34:46 -0500
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 06 Feb 2018 08:34:45 -0800
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: [PATCH v3 07/11] dt-bindings: tegra: Update DFLL binding for PWM regulator
Date: Tue, 6 Feb 2018 18:34:08 +0200
Message-ID: <1517934852-23255-8-git-send-email-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
References: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.21.24.170]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To UKMAIL101.nvidia.com
 (10.26.138.13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new properties to configure the DFLL PWM regulator support. Also
add an example and make the I2C clock only required when I2C support is
used.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 .../bindings/clock/nvidia,tegra124-dfll.txt        | 76 +++++++++++++++++++++-
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
index dff236f..a4903f7 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
@@ -23,7 +23,8 @@ Required properties:
 - clock-names: Must include the following entries:
   - soc: Clock source for the DFLL control logic.
   - ref: The closed loop reference clock
-  - i2c: Clock source for the integrated I2C master.
+  - i2c: Clock source for the integrated I2C master (only required when
+	 using I2C mode).
 - resets: Must contain an entry for each entry in reset-names.
   See ../reset/reset.txt for details.
 - reset-names: Must include the following entries:
@@ -45,10 +46,28 @@ Required properties for the control loop parameters:
 Optional properties for the control loop parameters:
 - nvidia,cg-scale: Boolean value, see the field DFLL_PARAMS_CG_SCALE in the TRM.
 
+Optional properties for mode selection:
+- nvidia,pwm-to-pmic: Use PWM to control regulator rather then I2C.
+
 Required properties for I2C mode:
 - nvidia,i2c-fs-rate: I2C transfer rate, if using full speed mode.
 
-Example:
+Required properties for PWM mode:
+- nvidia,pwm-period: period of PWM square wave in us.
+- nvidia,init-uv: Regulator voltage in uV when PWM control is disabled.
+- nvidia,align-offset-uv: Regulator voltage in uV when PWM control is enabled
+			  and PWM output is low.
+- nvidia,align-step-uv: Voltage increase in uV corresponding to a 1/33th
+			increase in duty cycle. Eg the voltage for 2/33th duty
+			cycle would be:
+			nvidia,align-offset-uv + nvidia,align-step-uv * 2.
+- pinctrl-0: I/O pad configuration when PWM control is enabled.
+- pinctrl-1: I/O pad configuration when PWM control is disabled.
+- pinctrl-names: must include the following entries:
+  - dvfs_pwm_enable: I/O pad configuration when PWM control is enabled.
+  - dvfs_pwm_disable: I/O pad configuration when PWM control is disabled.
+
+Example for I2C:
 
 clock@70110000 {
         compatible = "nvidia,tegra124-dfll";
@@ -76,3 +95,56 @@ clock@70110000 {
 
         nvidia,i2c-fs-rate = <400000>;
 };
+
+Example for PWM:
+
+clock@70110000 {
+        compatible = "nvidia,tegra124-dfll";
+        reg = <0 0x70110000 0 0x100>, /* DFLL control */
+              <0 0x70110000 0 0x100>, /* I2C output control */
+              <0 0x70110100 0 0x100>, /* Integrated I2C controller */
+              <0 0x70110200 0 0x100>; /* Look-up table RAM */
+        interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&tegra_car TEGRA210_CLK_DFLL_SOC>,
+                 <&tegra_car TEGRA210_CLK_DFLL_REF>;
+        clock-names = "soc", "ref";
+        resets = <&tegra_car TEGRA124_RST_DFLL_DVCO>;
+        reset-names = "dvco";
+        #clock-cells = <0>;
+        clock-output-names = "dfllCPU_out";
+	nvidia,pwm-to-pmic;
+	nvidia,init-uv = <1000000>;
+	nvidia,align-step-uv = <19200>; /* 19.2mV */
+	nvidia,align-offset-uv = <708000>; /* 708mV */
+	nvidia,sample-rate = <25000>;
+	nvidia,droop-ctrl = <0x00000f00>;
+	nvidia,force-mode = <1>;
+	nvidia,cf = <6>;
+	nvidia,ci = <0>;
+	nvidia,cg = <2>;
+	nvidia,idle-override;
+	nvidia,one-shot-calibrate;
+	nvidia,pwm-period = <2500>; /* 2.5us */
+	pinctrl-names = "dvfs_pwm_enable", "dvfs_pwm_disable";
+	pinctrl-0 = <&dvfs_pwm_active_state>;
+	pinctrl-1 = <&dvfs_pwm_inactive_state>;
+};
+
+/* pinmux nodes added for completeness. Binding doc can be found in:
+ * Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt
+ */
+
+pinmux: pinmux@700008d4 {
+	dvfs_pwm_active_state: dvfs_pwm_active {
+		dvfs_pwm_pbb1 {
+			nvidia,pins = "dvfs_pwm_pbb1";
+			nvidia,tristate = <TEGRA_PIN_DISABLE>;
+		};
+	};
+	dvfs_pwm_inactive_state: dvfs_pwm_inactive {
+		dvfs_pwm_pbb1 {
+			nvidia,pins = "dvfs_pwm_pbb1";
+			nvidia,tristate = <TEGRA_PIN_ENABLE>;
+		};
+	};
+};
-- 
1.9.1
