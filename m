Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D357C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7FD20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7FD20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pschenker.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395049AbeKXBIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:08:51 -0500
Received: from mxout013.mail.hostpoint.ch ([217.26.49.173]:41948 "EHLO
        mxout013.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727681AbeKXBIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:08:51 -0500
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout013.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1gQCNY-00048B-S7; Fri, 23 Nov 2018 15:24:20 +0100
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1gQCNY-000MJh-N4; Fri, 23 Nov 2018 15:24:20 +0100
X-Authenticated-Sender-Id: dev@pschenker.ch
From:   Philippe Schenker <dev@pschenker.ch>
To:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 3/4] iio: adc: add STMPE ADC devicetree bindings
Date:   Fri, 23 Nov 2018 15:24:10 +0100
Message-Id: <20181123142411.8921-3-dev@pschenker.ch>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123142411.8921-1-dev@pschenker.ch>
References: <20181123142411.8921-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

This adds the devicetree bindings for the STMPE ADC.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v3:
 - Reformatted documentation for touchscreen to use tabs and have a better
   overview of the settings.
 - Added note which adc-settings will take precedence.
 - changed typo in sample-time setting from 144 clocks to 124 clocks, as stated
   in the datasheet.

Changes in v2:
 - Moved the bindings for ADC to the overlying mfd.
 - Reformatted for better readability

 .../devicetree/bindings/iio/adc/stmpe-adc.txt | 21 +++++++
 .../bindings/input/touchscreen/stmpe.txt      | 60 ++++++++++++-------
 .../devicetree/bindings/mfd/stmpe.txt         | 28 ++++++---
 3 files changed, 80 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt b/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
new file mode 100644
index 000000000000..480e66422625
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
@@ -0,0 +1,21 @@
+STMPE ADC driver
+----------------
+
+Required properties:
+ - compatible: "st,stmpe-adc"
+
+Optional properties:
+Note that the ADC is shared with the STMPE touchscreen. ADC related settings
+have to be done in the mfd.
+- st,norequest-mask: bitmask specifying which ADC channels should _not_ be
+  requestable due to different usage (e.g. touch)
+
+Node name must be stmpe_adc and should be child node of stmpe node to
+which it belongs.
+
+Example:
+
+	stmpe_adc {
+		compatible = "st,stmpe-adc";
+		st,norequest-mask = <0x0F>; /* dont use ADC CH3-0 */
+	};
diff --git a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
index 127baa31a77a..414586513a02 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
@@ -5,36 +5,52 @@ Required properties:
  - compatible: "st,stmpe-ts"
 
 Optional properties:
-- st,sample-time: ADC converstion time in number of clock.  (0 -> 36 clocks, 1 ->
-  44 clocks, 2 -> 56 clocks, 3 -> 64 clocks, 4 -> 80 clocks, 5 -> 96 clocks, 6
-  -> 144 clocks), recommended is 4.
-- st,mod-12b: ADC Bit mode (0 -> 10bit ADC, 1 -> 12bit ADC)
-- st,ref-sel: ADC reference source (0 -> internal reference, 1 -> external
-  reference)
-- st,adc-freq: ADC Clock speed (0 -> 1.625 MHz, 1 -> 3.25 MHz, 2 || 3 -> 6.5 MHz)
-- st,ave-ctrl: Sample average control (0 -> 1 sample, 1 -> 2 samples, 2 -> 4
-  samples, 3 -> 8 samples)
-- st,touch-det-delay: Touch detect interrupt delay (0 -> 10 us, 1 -> 50 us, 2 ->
-  100 us, 3 -> 500 us, 4-> 1 ms, 5 -> 5 ms, 6 -> 10 ms, 7 -> 50 ms) recommended
-  is 3
-- st,settling: Panel driver settling time (0 -> 10 us, 1 -> 100 us, 2 -> 500 us, 3
-  -> 1 ms, 4 -> 5 ms, 5 -> 10 ms, 6 for 50 ms, 7 -> 100 ms) recommended is 2
-- st,fraction-z: Length of the fractional part in z (fraction-z ([0..7]) = Count of
-  the fractional part) recommended is 7
-- st,i-drive: current limit value of the touchscreen drivers (0 -> 20 mA typical 35
-  mA max, 1 -> 50 mA typical 80 mA max)
+- st,ave-ctrl		: Sample average control
+				0 -> 1 sample
+				1 -> 2 samples
+				2 -> 4 samples
+				3 -> 8 samples
+- st,touch-det-delay	: Touch detect interrupt delay (recommended is 3)
+				0 -> 10 us		5 -> 5 ms
+				1 -> 50 us		6 -> 10 ms
+				2 -> 100 us		7 -> 50 ms
+				3 -> 500 us
+				4-> 1 ms
+- st,settling		: Panel driver settling time (recommended is 2)
+				0 -> 10 us		5 -> 10 ms
+				1 -> 100 us		6 for 50 ms
+				2 -> 500 us		7 -> 100 ms
+				3 -> 1 ms
+				4 -> 5 ms
+- st,fraction-z		: Length of the fractional part in z (recommended is 7)
+			  (fraction-z ([0..7]) = Count of the fractional part)
+- st,i-drive		: current limit value of the touchscreen drivers
+				0 -> 20 mA (typical 35mA max)
+				1 -> 50 mA (typical 80 mA max)
+
+Optional properties common with MFD (deprecated):
+ - st,sample-time	: ADC conversion time in number of clock.
+				0 -> 36 clocks		4 -> 80 clocks (recommended)
+				1 -> 44 clocks		5 -> 96 clocks
+				2 -> 56 clocks		6 -> 124 clocks
+				3 -> 64 clocks
+ - st,mod-12b		: ADC Bit mode
+				0 -> 10bit ADC		1 -> 12bit ADC
+ - st,ref-sel		: ADC reference source
+				0 -> internal		1 -> external
+ - st,adc-freq		: ADC Clock speed
+				0 -> 1.625 MHz		2 || 3 -> 6.5 MHz
+				1 -> 3.25 MHz
 
 Node name must be stmpe_touchscreen and should be child node of stmpe node to
 which it belongs.
 
+Note that common ADC settings of stmpe_touchscreen will take precedence.
+
 Example:
 
 	stmpe_touchscreen {
 		compatible = "st,stmpe-ts";
-		st,sample-time = <4>;
-		st,mod-12b = <1>;
-		st,ref-sel = <0>;
-		st,adc-freq = <1>;
 		st,ave-ctrl = <1>;
 		st,touch-det-delay = <2>;
 		st,settling = <2>;
diff --git a/Documentation/devicetree/bindings/mfd/stmpe.txt b/Documentation/devicetree/bindings/mfd/stmpe.txt
index c797c05cd3c2..d4408a417193 100644
--- a/Documentation/devicetree/bindings/mfd/stmpe.txt
+++ b/Documentation/devicetree/bindings/mfd/stmpe.txt
@@ -4,15 +4,29 @@ STMPE is an MFD device which may expose the following inbuilt devices: gpio,
 keypad, touchscreen, adc, pwm, rotator.
 
 Required properties:
- - compatible                   : "st,stmpe[610|801|811|1600|1601|2401|2403]"
- - reg                          : I2C/SPI address of the device
+ - compatible			: "st,stmpe[610|801|811|1600|1601|2401|2403]"
+ - reg				: I2C/SPI address of the device
 
 Optional properties:
- - interrupts                   : The interrupt outputs from the controller
- - interrupt-controller         : Marks the device node as an interrupt controller
- - wakeup-source                : Marks the input device as wakable
- - st,autosleep-timeout         : Valid entries (ms); 4, 16, 32, 64, 128, 256, 512 and 1024
- - irq-gpio                     : If present, which GPIO to use for event IRQ
+ - interrupts			: The interrupt outputs from the controller
+ - interrupt-controller		: Marks the device node as an interrupt controller
+ - wakeup-source		: Marks the input device as wakable
+ - st,autosleep-timeout		: Valid entries (ms); 4, 16, 32, 64, 128, 256, 512 and 1024
+ - irq-gpio			: If present, which GPIO to use for event IRQ
+
+Optional properties for devices with touch and ADC (STMPE811|STMPE610):
+ - st,sample-time		: ADC conversion time in number of clock.
+					0 -> 36 clocks		4 -> 80 clocks (recommended)
+					1 -> 44 clocks		5 -> 96 clocks
+					2 -> 56 clocks		6 -> 124 clocks
+					3 -> 64 clocks
+ - st,mod-12b			: ADC Bit mode
+					0 -> 10bit ADC		1 -> 12bit ADC
+ - st,ref-sel			: ADC reference source
+					0 -> internal		1 -> external
+ - st,adc-freq			: ADC Clock speed
+					0 -> 1.625 MHz		2 || 3 -> 6.5 MHz
+					1 -> 3.25 MHz
 
 Example:
 
-- 
2.19.1

