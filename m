Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A22C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039C92075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oiG+7YuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbfBLPPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:15:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39358 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729201AbfBLPOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:14:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so3075061wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 07:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=osllFgvA5o/xm9OT8Xpb7DYHPsPsZmWNpK7mAFRAhF0=;
        b=oiG+7YuJqM9Wn3QW7aHUgCS/ujcmlC66yyY0L75OKfZfhEsgXZGQp2Z4Ct+qlHmU7o
         zyParsGEfi6jFKGwT1Sm58Q8qak+h9AeePeIlLvc4+/zUEXTxtjThg0H0nNvX8yxataG
         giVR/PCot2NZA0WR/p3cxQAsNVSdB5GKKOKJQeuYEDGJZPVIbqVp53nOXP2m02tiAKIQ
         PquwisJwleHTWm7npHZn++dVEVj7o/zpwlDUOAUgMPK6xA1NVUXYIYso6V/NVOB4/3i1
         dQw1UNEy0hA+owcyQXG/iWD53+HQMxaax3Y+zE+aBy3nBPyGemi/XeHehKveYrx1c6N6
         wlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=osllFgvA5o/xm9OT8Xpb7DYHPsPsZmWNpK7mAFRAhF0=;
        b=sRs+eNULtIh4ahjZIo583aBhVRSR5Tf8PbxmPxGaC6iOFau2uT9p5C/s7aBmPIiFQx
         W90P03LYaiV8TWHm6z9F1GbkUDKoZ6nTyAp/QjwGJv75zdr+RPLmp9wbKaDt03dlfOfd
         YhqKcNHuczmdqysMZTHcbCXeNL7H2oh2Xa5RZo7LPPCpNhzW1tKeDKyc7r/oSQrFeKPR
         vfHk7rDb/YwsyWHA/bcR6/idh2ncQcN6vHHrZKg6zH7oavt0OdNMgfMi02GdmWUWgTw6
         4XV6vl9kUQrSllOVi7EPgNRpLCZGdPXBafX5Qpw3lGMSgZToWeipzMHvCvLXPlyGB8bv
         Yocw==
X-Gm-Message-State: AHQUAuZF1lfG9JO560vuLAqDTldg6YqaOcWwVruFAJ5gtmA1Y/65SY5M
        EDREwc2Te/5u1J01LaHjD7eKnA==
X-Google-Smtp-Source: AHgI3IbQPmshcp7UbeGIucCzLiesV8ASLETHlCcJ+rDprRG/Eot3nXohyyE/10CpSA0gb4XgHD4aoA==
X-Received: by 2002:a5d:52c3:: with SMTP id r3mr3246168wrv.163.1549984459784;
        Tue, 12 Feb 2019 07:14:19 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c1sm1589515wmb.14.2019.02.12.07.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 07:14:17 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] dt-bindings: phy: Add Amlogic G12A USB3+PCIE Combo PHY Bindings
Date:   Tue, 12 Feb 2019 16:14:07 +0100
Message-Id: <20190212151413.24632-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212151413.24632-1-narmstrong@baylibre.com>
References: <20190212151413.24632-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Amlogic G12A Family USB3 + PCIE Combo PHY Bindings.

This PHY can provide exclusively USB3 or PCIE support on shared I/Os.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/phy/meson-g12a-usb3-pcie-phy.txt | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt b/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
new file mode 100644
index 000000000000..714d751091f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
@@ -0,0 +1,25 @@
+* Amlogic G12A USB3 + PCIE Combo PHY binding
+
+Required properties:
+- compatible:	Should be "amlogic,meson-g12a-usb3-pcie-phy"
+- #phys-cells:	must be 1. The cell number is used to select the phy mode
+  as defined in <dt-bindings/phy/phy.h> between PHY_TYPE_USB3 and PHY_TYPE_PCIE
+- reg:		The base address and length of the registers
+- clocks:	a phandle to the 100MHz reference clock of this PHY
+- clock-names:	must be "ref_clk"
+- resets:	phandle to the reset lines for:
+		- the PHY control
+		- the USB3+PCIE PHY
+		- the PHY registers
+
+Example:
+	usb3_pcie_phy: phy@46000 {
+		compatible = "amlogic,g12a-usb3-pcie-phy";
+		reg = <0x0 0x46000 0x0 0x2000>;
+		clocks = <&clkc CLKID_PCIE_PLL>;
+		clock-names = "ref_clk";
+		resets = <&reset RESET_PCIE_CTRL_A>,
+			 <&reset RESET_PCIE_PHY>,
+			 <&reset RESET_PCIE_APB>;
+		#phy-cells = <1>;
+	};
-- 
2.20.1

