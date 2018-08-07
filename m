Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEA5C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2322A216FE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2322A216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbeHGMxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:53:50 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:51970 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727103AbeHGMxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:53:50 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id w77A8npW002105;
        Tue, 7 Aug 2018 13:08:49 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 20088)
        id 8A35A62EDE; Tue,  7 Aug 2018 13:38:48 +0300 (IDT)
From:   Tali Perry <tali.perry1@gmail.com>
To:     sboyd@kernel.org, brendanhiggins@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk,
        weiyongjunl@huawei.com, avifishman70@gmail.com,
        tmaimon77@gmail.com, raltherr@google.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        Tali Perry <tali.perry1@gmail.com>
Subject: [PATCH v2 1/2] dt-binding: i2c: npcm7xx: add binding for i2c controller
Date:   Tue,  7 Aug 2018 13:38:13 +0300
Message-Id: <20180807103814.29586-2-tali.perry1@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180807103814.29586-1-tali.perry1@gmail.com>
References: <20180807103814.29586-1-tali.perry1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nuvoton NPCM7XX I2C Controller
NPCM7xx includes 16 I2C contollers. THis driver operates the controller.
This module also includes a slave mode, which will be submitted later on.

Any feedback would be appreciated.  

v2 -> v1:
	- run check patch in strict mode.
	- use linux crc.
	- define regs in constant offset without base.
	- remove debug prints.
	- no declerations for local functions.
	
v1: initial version

Signed-off-by: Tali Perry <tali.perry1@gmail.com>

---
 .../devicetree/bindings/i2c/i2c-npcm7xx.txt        | 27 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 +++++++
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt b/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
new file mode 100644
index 000000000000..e2ee45d7a41e
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
@@ -0,0 +1,27 @@
+Nuvoton NPCM7XX I2C bus
+
+The NPCM750x includes sixteen I2C busses
+
+Required properties:
+- compatible      : must be "nuvoton,npcm750-i2c-bus"
+- reg             : Offset and length of the register set for the device.
+- interrupts      : Contain the I2C interrupt with flags for falling edge.
+- clocks          : phandle of I2C reference clock.
+
+Optional:
+- bus-frequency   : Contain the I2C bus frequency,
+			the default I2C bus frequency is 100000.
+- pinctrl-0       : must be <&smbX_pins>, X is module number
+			(on NPCM7XX it's 0 to 15)
+- pinctrl-names   : should be set to "default"
+Example:
+
+	i2c0: i2c-bus@80000 {
+		compatible = "nuvoton,npcm750-i2c-bus";
+		reg = <0x80000 0x1000>;
+		clocks = <&clk NPCM7XX_CLK_APB2>;
+		bus-frequency = <100000>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&smb0_pins>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 192d7f73fd01..13bac916d21d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1244,6 +1244,14 @@ F:	drivers/i2c/busses/i2c-aspeed.c
 F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-i2c-ic.txt
 F:	Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
 
+ARM/NUVOTON I2C DRIVER
+M:	Tali Perry <tali.perry1@gmail.com>
+L:	linux-i2c@vger.kernel.org
+L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/i2c/busses/i2c-npcm7xx.c
+F:	Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
+
 ARM/ASPEED MACHINE SUPPORT
 M:	Joel Stanley <joel@jms.id.au>
 R:	Andrew Jeffery <andrew@aj.id.au>
-- 
2.14.1

