Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C093FC65BAF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF6D2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ITpgH2po"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF6D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeLCIhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:37:19 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40371 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeLCIhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:37:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so5986865pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 00:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fxTRCJYVV9EzZbbnM6Gqj197szT1L21KspOo1diH5zQ=;
        b=ITpgH2poYAm3Z02EHXc5xJE+YW38THBmfrz79ivgy1M0uO8+ep4Z1nA1RgaY2ofgd5
         p9CGB1m99kyh+dbLz1Dpsi3q3aBtWyrilNfRtYQW6eighnL/FeEPFnhc0P9V1TnZot7u
         82BBXyl2y39T5c8lRC6o3dikhp+6KfdJIQsSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fxTRCJYVV9EzZbbnM6Gqj197szT1L21KspOo1diH5zQ=;
        b=od8+lpgQkxlckj4z+vMBT2N/P9ifLqvyOlfub8YGgT45FMlfdqK/8mss6CJ01MMhVs
         JoY3gsGFokXUsk3PAWSj/zeyscjrxxkwCIZprjp8LfAs3sZlvikRO2blEPRWCZG+VHRR
         8QEP1VCcnLe2bsLhCU6tuWSldnfhwaQ3BEkzRLJfqCCCv4A/owmiVhUt6jMqlIjgjCA1
         xQ159BOJ6zZ7Cnc+48jzEY0Ld877yphZ71sp21ffWvnMi7L9kVxj9hstfTKAXSjJ8X1r
         ujMzKt7u5fJU+cbEuOWmW8NmSTTfvBt4PrqpFI5Xly1DMGHfwEq3hDsfVRlnWgf4AmEd
         rIVQ==
X-Gm-Message-State: AA+aEWYYOPgDExV2HstOnujFKbY+u32WpnPfH76HnrZIppB0HuP7qV4T
        DZ0nEkHuO/Mtgpruef8T/AWVrg==
X-Google-Smtp-Source: AFSGD/V6rPmzFhB7gnIt8J0TcqM57G5DPADEloD1S2VTOXgJ0Wj3cPnfo67JUx6ClcYdGQScA9p+aw==
X-Received: by 2002:a62:1f9d:: with SMTP id l29mr14983396pfj.14.1543826236889;
        Mon, 03 Dec 2018 00:37:16 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 78sm17304426pft.184.2018.12.03.00.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Dec 2018 00:37:16 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        "Jayachandran C --cc=devicetree @ vger . kernel . org" 
        <jnair@caviumnetworks.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 3/3] arm64: dts: Add USB DT nodes for Stingray SoC
Date:   Mon,  3 Dec 2018 14:06:48 +0530
Message-Id: <1543826208-22742-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543826208-22742-1-git-send-email-srinath.mannam@broadcom.com>
References: <1543826208-22742-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT nodes for
  - Two xHCI host controllers
  - Two BDC Broadcom USB device controller
  - Five USB PHY controllers

[xHCI0]      [BDC0]            [xHCI1]            [BDC1]
   |           |                  |                 |
  ---------------               -----------------------
   |           |                 |         |         |
[SS-PHY0]   [HS-PHY0]        [SS-PHY1] [HS-PHY2] [HS-PHY1]

[SS-PHY0/HS-PHY0] and [SS-PHY1/HS-PHY1] are combo PHYs of
version1 category has both SS and HS PHYs..
[HS-PHY2] is HS PHY of version2 category.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../boot/dts/broadcom/stingray/stingray-usb.dtsi   | 95 ++++++++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  1 +
 2 files changed, 96 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
new file mode 100644
index 0000000..164a1de
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: (GPL-2.0 or BSD-3-Clause)
+/*
+ *Copyright(c) 2018 Broadcom
+ */
+	usb {
+		compatible = "simple-bus";
+		dma-ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x68500000 0x00400000>;
+
+		usbphy0: usb-phy@0 {
+			compatible = "brcm,sr-usb-phy";
+			reg = <0x00000000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			usb0_phy0: phy@0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+			usb0_phy1: phy@1 {
+				reg = <1>;
+				#phy-cells = <0>;
+			};
+
+		};
+
+		xhci0: usb@1000 {
+			compatible = "generic-xhci";
+			reg = <0x00001000 0x1000>;
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb0_phy1>, <&usb0_phy0>;
+			phy-names = "phy0", "phy1";
+			dma-coherent;
+			status = "disabled";
+		};
+
+		bdc0: usb@2000 {
+			compatible = "brcm,bdc-v0.16";
+			reg = <0x00002000 0x1000>;
+			interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb0_phy1>, <&usb0_phy0>;
+			phy-names = "phy0", "phy1";
+			dma-coherent;
+			status = "disabled";
+		};
+
+		usbphy1: usb-phy@10000 {
+			compatible = "brcm,sr-usb-phy";
+			reg = <0x00010000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			usb1_phy0: phy@0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+			usb1_phy1: phy@1 {
+				reg = <1>;
+				#phy-cells = <0>;
+			};
+		};
+
+		usbphy2: usb-phy@20000 {
+			compatible = "brcm,sr-usb-phy-v2";
+			reg = <0x00020000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		xhci1: usb@11000 {
+			compatible = "generic-xhci";
+			reg = <0x00011000 0x1000>;
+			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb1_phy1>, <&usbphy2>, <&usb1_phy0>;
+			phy-names = "phy0", "phy1", "phy2";
+			dma-coherent;
+			status = "disabled";
+		};
+
+		bdc1: usb@21000 {
+			compatible = "brcm,bdc-v0.16";
+			reg = <0x00021000 0x1000>;
+			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usbphy2>;
+			phy-names = "phy0";
+			dma-coherent;
+			status = "disabled";
+		};
+	};
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index e283480..6927236 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -287,6 +287,7 @@
 	#include "stingray-fs4.dtsi"
 	#include "stingray-sata.dtsi"
 	#include "stingray-pcie.dtsi"
+	#include "stingray-usb.dtsi"
 
 	hsls {
 		compatible = "simple-bus";
-- 
2.7.4

