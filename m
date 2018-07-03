Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1A5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B502075E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B502075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933649AbeGCJsS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:48:18 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:34830 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754805AbeGCJsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:48:12 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id w639l4ul020999;
        Tue, 3 Jul 2018 12:47:04 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 01E1C63045; Tue,  3 Jul 2018 12:47:04 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jdelvare@suse.com,
        linux@roeck-us.net, avifishman70@gmail.com, yuenn@google.com,
        brendanhiggins@google.com, venture@google.com, joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v7 1/2] dt-binding: hwmon: Add NPCM7xx PWM and Fan controller documentation
Date:   Tue,  3 Jul 2018 12:47:00 +0300
Message-Id: <20180703094701.255662-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180703094701.255662-1-tmaimon77@gmail.com>
References: <20180703094701.255662-1-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device tree binding documentation for Nuvoton BMC
NPCM7xx Pulse Width Modulation (PWM)  and Fan tach controller.
The PWM controller can support upto 8 PWM output ports.
The Fan tach controller can support upto 16 tachometer inputs.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../devicetree/bindings/hwmon/npcm750-pwm-fan.txt  | 87 ++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt

diff --git a/Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt
new file mode 100644
index 000000000000..c56d72d03717
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt
@@ -0,0 +1,87 @@
+Nuvoton NPCM7xx PWM and Fan Tacho controller device
+
+The NPCM7xx has two identical Pulse-width modulation (PWM) controller modules,
+Each PWM module has four PWM controller outputs, Totally 8 PWM controller outputs.
+
+The NPCM7xx has eight identical Fan tachometer controller modules,
+Each Fan module has two Fan controller inputs, Totally 16 Fan controller inputs.
+
+Required properties for pwm-fan node
+- #address-cells : should be 1.
+- #size-cells 	: should be 0.
+- compatible	: "nuvoton,npcm750-pwm-fan" for Poleg NPCM7XX.
+- reg 			: specifies physical base address and size of the registers.
+- reg-names 	: must contain:
+					* "pwm" for the PWM registers.
+ 					* "fan" for the Fan registers.
+- clocks		: phandle of reference clocks.
+- clock-names	: must contain
+					* "clk_apb3" for clock of PWM controller.
+ 					* "clk_apb4" for clock of Fan controller.
+- interrupts	: contain the Fan interrupts with flags for falling edge.
+- pinctrl-names	: a pinctrl state named "default" must be defined.
+- pinctrl-0 	: phandle referencing pin configuration of the PWM and Fan
+					controller ports.
+
+fan subnode format:
+===================
+Under fan subnode can be upto 8 child nodes, each child node representing a fan.
+Each fan subnode must have one PWM channel and atleast one Fan tach channel.
+
+For PWM channel can be configured cooling-levels to create cooling device.
+Cooling device could be bound to a thermal zone for the thermal control.
+
+Required properties for each child node:
+- reg : specify the PWM output channel.
+	integer value in the range 0 through 7, that represent
+	the PWM channel number that used.
+
+- fan-tach-ch : specify the Fan tach input channel.
+		integer value in the range 0 through 15, that represent
+		the fan tach channel number that used.
+
+		At least one Fan tach input channel is required
+
+Optional property for each child node:
+- cooling-levels: PWM duty cycle values in a range from 0 to 255
+                  which correspond to thermal cooling states.
+
+Examples:
+
+pwm_fan:pwm-fan-controller@103000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "nuvoton,npcm750-pwm-fan";
+	reg = <0x103000 0x2000>,
+		<0x180000 0x8000>;
+	reg-names = "pwm", "fan";
+	clocks = <&clk NPCM7XX_CLK_APB3>,
+		<&clk NPCM7XX_CLK_APB4>;
+	clock-names = "clk_apb3","clk_apb4";
+	interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins &pwm1_pins &pwm2_pins
+			&fanin0_pins &fanin1_pins &fanin2_pins
+			&fanin3_pins &fanin4_pins>;
+	fan@0 {
+		reg = <0x00>;
+		fan-ch = /bits/ 8 <0x00 0x01>;
+		cooling-levels = <127 255>;
+	};
+	fan@1 {
+		reg = <0x01>;
+		fan-ch = /bits/ 8 <0x02 0x03>;
+	};
+	fan@2 {
+		reg = <0x02>;
+		fan-ch = /bits/ 8 <0x04>;
+	};
+
+};
\ No newline at end of file
-- 
2.14.1

