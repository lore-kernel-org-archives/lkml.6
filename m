Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D70C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47412240A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47412240A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933755AbeFVKub (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:50:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49522 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933589AbeFVKt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:49:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6872E20CFE; Fri, 22 Jun 2018 12:49:55 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id EF3E020DBE;
        Fri, 22 Jun 2018 12:49:38 +0200 (CEST)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v5 10/10] dt-bindings: gpio: Add bindings for Cadence I3C gpio expander
Date:   Fri, 22 Jun 2018 12:49:30 +0200
Message-Id: <20180622104930.32050-11-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180622104930.32050-1-boris.brezillon@bootlin.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Cadence I3C gpio expander bindings.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v5:
- Add Rob's R-b

Changes in v4:
- Use GPIO_ and IRQ_TYPE_ macros instead of raw numbers
- Fix the unit-address in the example
---
 .../devicetree/bindings/gpio/gpio-cdns-i3c.txt     | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt b/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
new file mode 100644
index 000000000000..d0155a9cea79
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
@@ -0,0 +1,39 @@
+* Cadence I3C GPIO expander
+
+The Cadence I3C GPIO expander provides 8 GPIOs controllable over I3C.
+This GPIOs can be configured in output or input mode and if they are in input
+mode they can generate IBIs (In Band Interrupts).
+
+Required properties for GPIO node:
+- reg : 3 cells encoding the I3C static address (none in our case) and the I3C
+	Provisional ID. See Documentation/devicetree/bindings/i3c/i3c.txt for
+	more details.
+	Should be <0x0 0x392 0x0>.
+- gpio-controller : Marks the device node as a gpio controller.
+- #gpio-cells : Should be two. The first cell is the pin number and
+  the second cell is used to specify the gpio polarity (GPIO_ACTIVE_HIGH or
+  GPIO_ACTIVE_LOW)
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells : Should be 2. The first cell is the GPIO number.
+  The second cell is used to specify trigger type and level flags.
+  The following trigger types are accepted (see
+  <dt-bindings/interrupt-controller/irq.h> for their definition):
+	IRQ_TYPE_EDGE_RISING
+	IRQ_TYPE_EDGE_FALLING
+	IRQ_TYPE_EDGE_BOTH
+	IRQ_TYPE_LEVEL_HIGH
+	IRQ_TYPE_LEVEL_LOW
+
+Example:
+
+	i3c-master@xxx {
+		...
+		i3c_gpio_expander: gpio@0,39200000000 {
+			reg = <0 0x392 0x0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+		...
+	};
-- 
2.14.1

