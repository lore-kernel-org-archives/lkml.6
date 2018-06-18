Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F86C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A7820836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ray6oaaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A7820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935588AbeFRRmT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:42:19 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35598 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934957AbeFRRmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:42:15 -0400
Received: by mail-qt0-f195.google.com with SMTP id s9-v6so15897361qtg.2;
        Mon, 18 Jun 2018 10:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S5QS2nbgJ40ZMQRjJcpMCm/74LfgvYp+piZWqDU5kmA=;
        b=Ray6oaaN7IV+ghZu/XGzvFppwCfCYgigAfL5IkD0WYwMSQNZcQAMYqrB1R3+nXFbPw
         j+KYo4ZjFbdxCNc72hEYQSS8x30yPJr4p1G/dnNF2Fc+Am+91yqseuSsovmzUS3S2vmk
         c5zMj5ToA52pa2s29MxzUbyLYr3mdf+H5gjqMLp+qEJtdSbuxD2Eg4Ra2UksVdt6Nau2
         LHRPHqNF8tOaF3wu7V/nEqPTgAoYQux5AjNDedK1fYvFWoLwBtTirQqUUzg4RmEVTAJC
         Kuue9gitvgPs330c9wAUiXF+QWqctW6XXi04KW80P19lkCi2yQyfQti5RfVmZEftNUEl
         Ovtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S5QS2nbgJ40ZMQRjJcpMCm/74LfgvYp+piZWqDU5kmA=;
        b=rORcGqM8GI1jimQ2H/QgFJy+fs+749MrtY9nGa8hxIsiwDst9KKUAe4bze4QIA3MPt
         kuFZ7tIMk+jyudQVbGuY5wqQJ3U1Yq6uO05b+qm3WTSFZxQS9duMNPO7lfZ2x37YF29X
         R0d9QPLWCeRX4hF/fByw753GpdiVvAxs6uRh/2JLWw3PQyWTB6mjmocb9KLLg8rSpfx4
         C2FML6t3GdjBNzpNhhglBfCmaO1z5loBqYFkvQKK2909VfVVrk9PdWZNcGX0m+q9Zl8g
         nHWk5jK+M8ty9DhXKERC6VkLYOFc/B0Jj5cb1KRW9LLih3DKxhs2WBFBvJlZZbKhURy9
         piqQ==
X-Gm-Message-State: APt69E3e2lCFW6X0vjhSObnGSxM5XZA05ciVUBvCy38V6UPHdMcZHBOh
        F5VWfI1fTmOjKInUX1h+VNQ=
X-Google-Smtp-Source: ADUXVKI20wKVZbezCF2Clj5NRFaoQjq2/LuoPKOlpSa0EvfC/L6D51O4N+jknjD8thcO7G1WOPdu2g==
X-Received: by 2002:ac8:3f24:: with SMTP id c33-v6mr11606399qtk.235.1529343734582;
        Mon, 18 Jun 2018 10:42:14 -0700 (PDT)
Received: from localhost.localdomain (ool-44c0037e.dyn.optonline.net. [68.192.3.126])
        by smtp.googlemail.com with ESMTPSA id v56-v6sm12317047qtv.50.2018.06.18.10.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 10:42:13 -0700 (PDT)
From:   Vivek Unune <npcomplete13@gmail.com>
To:     florian.fainelli@broadcom.com, hauke@hauke-m.de, zajec5@gmail.com,
        jonmason@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vivek Unune <npcomplete13@gmail.com>
Subject: [PATCH v3] ARM: dts: BCM5301X: Add support for Linksys EA9500
Date:   Mon, 18 Jun 2018 13:41:59 -0400
Message-Id: <20180618174159.86150-1-npcomplete13@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180222223844.98527-1-npcomplete13@gmail.com>
References: <20180222223844.98527-1-npcomplete13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware Info
-------------

Processor	- Broadcom BCM4709C0KFEBG dual-core @ 1.4 GHz
Switch		- BCM53012 in BCM4709C0KFEBG & external BCM53125
DDR3 RAM	- 256 MB
Flash		- 128 MB (Toshiba TC58BVG0S3HTA00)
2.4GHz		- BCM4366 4×4 2.4/5G single chip 802.11ac SoC
Power Amp	- Skyworks SE2623L 2.4 GHz power amp (x4)
5GHz x 2	- BCM4366 4×4 2.4/5G single chip 802.11ac SoC
Power Amp	- PLX Technology PEX8603 3-lane, 3-port PCIe switch
Ports		- 8 Ports, 1 WAN Ports
Antennas	- 8 Antennas
Serial Port	- @J6 [GND,TX,RX] (VCC NC)    115200 8n1

Tested with OpenWrt built with DSA driver and Kernel v4.14

Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
---
Changes in v3:
 - Remove unnecessary change to BCH settings
 - Remove ports 5 & 7 from internal switch for now
Changes in v2:
 - Properly define mdio mux, internal mdio, external mdio, mii bus
 - Now we define usb3 phy as a mdio node connected to internal mdio,
   thanks to work done by Rafał Miłecki on the bcm usb3 phy mdio driver
 - Define external SW as a mdio-mii node connected to external mdio
---
 arch/arm/boot/dts/bcm47094-linksys-panamera.dts | 225 ++++++++++++++++++++++++
 1 file changed, 225 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
index 1b26f0be2382..f4f40fd7fbe5 100644
--- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
+++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
@@ -31,6 +31,231 @@
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 		};
+
+		rfkill {
+				label = "WiFi";
+				linux,code = <KEY_RFKILL>;
+				gpios = <&chipcommon 16 GPIO_ACTIVE_LOW>;
+		};
+
+		reset {
+				label = "Reset";
+				linux,code = <KEY_RESTART>;
+				gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		wps {
+			label = "bcm53xx:white:wps";
+			gpios = <&chipcommon 22 GPIO_ACTIVE_LOW>;
+		};
+
+		usb2 {
+			label = "bcm53xx:green:usb2";
+			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
+			trigger-sources = <&ohci_port2>, <&ehci_port2>;
+			linux,default-trigger = "usbport";
+		};
+
+		usb3 {
+			label = "bcm53xx:green:usb3";
+			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
+			trigger-sources = <&ohci_port1>, <&ehci_port1>,
+					  <&xhci_port1>;
+			linux,default-trigger = "usbport";
+		};
+
+		power {
+			label = "bcm53xx:white:power";
+			gpios = <&chipcommon 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		wifi-disabled {
+			label = "bcm53xx:amber:wifi-disabled";
+			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
+		};
+
+		wifi-enabled {
+			label = "bcm53xx:white:wifi-enabled";
+			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar1 {
+			label = "bcm53xx:white:bluebar1";
+			gpios = <&chipcommon 11 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar2 {
+			label = "bcm53xx:white:bluebar2";
+			gpios = <&chipcommon 12 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar3 {
+			label = "bcm53xx:white:bluebar3";
+			gpios = <&chipcommon 15 GPIO_ACTIVE_LOW>;
+		};
+
+		bluebar4 {
+			label = "bcm53xx:white:bluebar4";
+			gpios = <&chipcommon 18 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar5 {
+			label = "bcm53xx:white:bluebar5";
+			gpios = <&chipcommon 19 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar6 {
+			label = "bcm53xx:white:bluebar6";
+			gpios = <&chipcommon 20 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar7 {
+			label = "bcm53xx:white:bluebar7";
+			gpios = <&chipcommon 21 GPIO_ACTIVE_HIGH>;
+		};
+
+		bluebar8 {
+			label = "bcm53xx:white:bluebar8";
+			gpios = <&chipcommon 8 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	mdio-bus-mux {
+		mdio_ext: mdio@200 {	/* BIT(9) = 1 => external mdio */
+			reg = <0x200>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	mdio-mii-mux {
+		compatible = "mdio-mux-mmioreg";
+		mdio-parent-bus = <&mdio_ext>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x1800c1c0 0x4>;
+		mux-mask = <0xc0>;		/* BIT(6) = mdc, BIT(7) = mdio */
+
+		mdio-mii@0 {
+			reg = <0x0>;		/* Enable mii function */
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			switch@0  {
+				compatible = "brcm,bcm53125";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reset-gpios = <&chipcommon 10 GPIO_ACTIVE_LOW>;
+				reset-names = "robo_reset";
+				reg = <0>;
+				dsa,member = <1 0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						label = "lan1";
+					};
+
+					port@1 {
+						reg = <1>;
+						label = "lan5";
+					};
+
+					port@2 {
+						reg = <2>;
+						label = "lan2";
+					};
+
+					port@3 {
+						reg = <3>;
+						label = "lan6";
+					};
+
+					port@4 {
+						reg = <4>;
+						label = "lan3";
+					};
+
+					sw1_p8: port@8 {
+						reg = <8>;
+						ethernet = <&sw0_p0>;
+						label = "cpu";
+
+						fixed-link {
+							speed = <1000>;
+							full-duplex;
+						};
+					};
+				};
+			};
+		};
+	};
+};
+
+&usb2 {
+	vcc-gpio = <&chipcommon 13 GPIO_ACTIVE_HIGH>;
+};
+
+&usb3 {
+	vcc-gpio = <&chipcommon 14 GPIO_ACTIVE_HIGH>;
+};
+
+&srab {
+	compatible = "brcm,bcm53012-srab", "brcm,bcm5301x-srab";
+	status = "okay";
+	dsa,member = <0 0>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@1 {
+			reg = <1>;
+			label = "lan7";
+		};
+
+		port@2 {
+			reg = <2>;
+			label = "lan4";
+		};
+
+		port@3 {
+			reg = <3>;
+			label = "lan8";
+		};
+
+		port@4 {
+			reg = <4>;
+			label = "wan";
+		};
+
+		port@8 {
+			reg = <8>;
+			ethernet = <&gmac2>;
+			label = "cpu";
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+
+		sw0_p0: port@0 {
+			reg = <0>;
+			label = "extsw";
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
 	};
 };
 
-- 
2.11.0

