Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeFAIYM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:24:12 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46958 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbeFAIX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:23:28 -0400
X-Google-Smtp-Source: ADUXVKLmB5/vlPztPMh1SO30FDbe9UH8p/AYy/Fpz/rg3kNjqSIArxz38a4e+Zg0+mzn09G2HdVlXQ==
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 6/8] dt-bindings: gnss: add sirfstar binding
Date: Fri,  1 Jun 2018 10:22:57 +0200
Message-Id: <20180601082259.17563-7-johan@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180601082259.17563-1-johan@kernel.org>
References: <20180601082259.17563-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for SiRFstar-based GNSS receivers.

Note that while four compatible-strings are initially added representing
devices which differ in which I/O interfaces they support, they
otherwise essentially share the same feature set.

Pin and supply names vary slightly, as do some recommended timings.

Note that the wakeup gpio is not intended to be used as a wakeup source,
but rather to detect the current power state of the device (active or
hibernate).

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 .../devicetree/bindings/gnss/sirfstar.txt     | 45 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt   |  3 ++
 2 files changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gnss/sirfstar.txt

diff --git a/Documentation/devicetree/bindings/gnss/sirfstar.txt b/Documentation/devicetree/bindings/gnss/sirfstar.txt
new file mode 100644
index 000000000000..648d183cdb77
--- /dev/null
+++ b/Documentation/devicetree/bindings/gnss/sirfstar.txt
@@ -0,0 +1,45 @@
+SiRFstar-based GNSS Receiver DT binding
+
+SiRFstar chipsets are used in GNSS-receiver modules produced by several
+vendors and can use UART, SPI or I2C interfaces.
+
+Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
+properties.
+
+Required properties:
+
+- compatible	: Must be one of
+
+			"fastrax,uc430"
+			"linx,r4"
+			"wi2wi,w2sg0008i"
+			"wi2wi,w2sg0084i"
+
+- vcc-supply	: Main voltage regulator (pin name: 3V3_IN, VCC, VDD)
+
+Required properties (I2C):
+- reg		: I2C slave address
+
+Required properties (SPI):
+- reg		: SPI chip select address
+
+Optional properties:
+
+- sirf,onoff-gpios	: GPIO used to power on and off device (pin name: ON_OFF)
+- sirf,wakeup-gpios	: GPIO used to determine device power state
+			  (pin name: RFPWRUP, WAKEUP)
+- timepulse-gpios	: Time pulse GPIO (pin name: 1PPS, TM)
+
+Example:
+
+serial@1234 {
+	compatible = "ns16550a";
+
+	gnss {
+		compatible = "wi2wi,w2sg0084i";
+
+		vcc-supply = <&gnss_reg>;
+		sirf,onoff-gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+		sirf,wakeup-gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
+	};
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2128dfdf73f1..61db9d2391c4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -120,6 +120,7 @@ excito	Excito
 ezchip	EZchip Semiconductor
 fairphone	Fairphone B.V.
 faraday	Faraday Technology Corporation
+fastrax	Fastrax Oy
 fcs	Fairchild Semiconductor
 firefly	Firefly
 focaltech	FocalTech Systems Co.,Ltd
@@ -197,6 +198,7 @@ licheepi	Lichee Pi
 linaro	Linaro Limited
 linksys	Belkin International, Inc. (Linksys)
 linux	Linux-specific binding
+linx	Linx Technologies
 lltc	Linear Technology Corporation
 lsi	LSI Corp. (LSI Logic)
 lwn	Liebherr-Werk Nenzing GmbH
@@ -393,6 +395,7 @@ vot	Vision Optical Technology Co., Ltd.
 wd	Western Digital Corp.
 wetek	WeTek Electronics, limited.
 wexler	Wexler
+wi2wi	Wi2Wi, Inc.
 winbond Winbond Electronics corp.
 winstar	Winstar Display Corp.
 wlf	Wolfson Microelectronics
-- 
2.17.1
