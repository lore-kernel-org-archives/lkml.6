Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D45BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0547B214D9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aVmN+pEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0547B214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeLCKIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:08:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55968 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeLCKIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:08:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so5064891wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SaTHXuzdJjMTWekY2/DsirLmYaUh6d39j/40yOw9ADA=;
        b=aVmN+pEPQpdTu26ytBH6ev469JzbamvV7CCnubiDPyOpmzonabtdr3gd//ELjNxIgM
         cGOYPfwYML5EoVHTlkG1sAAYiQOBPai3zb+4elxLYiyRImtP/NYnSgIMLs0a01woZb/z
         o8vORLdcIToa0TyHYyYc+IFw9CPmu207BMDx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SaTHXuzdJjMTWekY2/DsirLmYaUh6d39j/40yOw9ADA=;
        b=WcpyqunHjGZ9pyvjTj/WAx5fJ67vNRnaOJodZ+Atr2sFKpGmCSJZW6tCMXZqeUADQa
         Cxaay7I6LGrzWeUxzqa6MhRp+xAzNKIKwPO6Y7tz6topAdpoRxQBJ7L2Ik7r66am1++n
         aY0e36QWylqccIZ6whfpn8MQlalqhR7getnwUf19Gb7ohV4lwDw7YVOWDZN5IJ1RDwJj
         QhJtLeTXY8bs3Ifyh4vpcg0r7dZd1EJGvG2FI4X7TiM6PKNVua/ZrZmj0fSjjzU0qM/h
         3Tq/hByuRCYU58f2OtUm2D1UtCF2wSeRoOVT1/hqYBwkfJWZlwwRBG41mB5g1hiqSQXd
         UuXg==
X-Gm-Message-State: AA+aEWbNypk3afJQn6DeZQaHUvswEtbrUlbYqz7dnimVgPHWEgHXBWEM
        SR3YjBw3ctxTBt3/H2ffWe6O4g==
X-Google-Smtp-Source: AFSGD/XXID2lcNa2SrO9/ABXfaFcfhJBWMw99ZZqav47P2OVn/8dG2m9kDDGnVhHa33Fr1z3Y/KK/A==
X-Received: by 2002:a1c:b687:: with SMTP id g129mr7464602wmf.59.1543831680419;
        Mon, 03 Dec 2018 02:08:00 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com. [2.228.78.71])
        by smtp.gmail.com with ESMTPSA id n15sm18589236wrt.21.2018.12.03.02.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:07:59 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 4/5] arm64: dts: allwinner: a64: Add A64 CSI controller
Date:   Mon,  3 Dec 2018 15:37:46 +0530
Message-Id: <20181203100747.16442-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203100747.16442-1-jagan@amarulasolutions.com>
References: <20181203100747.16442-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 CSI controller has similar features as like in
H3, So add support for A64 via H3 fallback.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 384c417cb7a2..d32ff694ac5c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -532,6 +532,12 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			csi_pins: csi-pins {
+				pins = "PE0", "PE2", "PE3", "PE4", "PE5", "PE6",
+				       "PE7", "PE8", "PE9", "PE10", "PE11";
+				function = "csi0";
+			};
+
 			i2c0_pins: i2c0_pins {
 				pins = "PH0", "PH1";
 				function = "i2c0";
@@ -899,6 +905,21 @@
 			status = "disabled";
 		};
 
+		csi: csi@1cb0000 {
+			compatible = "allwinner,sun50i-a64-csi",
+				     "allwinner,sun8i-h3-csi";
+			reg = <0x01cb0000 0x1000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CSI>,
+				 <&ccu CLK_CSI_SCLK>,
+				 <&ccu CLK_DRAM_CSI>;
+			clock-names = "bus", "mod", "ram";
+			resets = <&ccu RST_BUS_CSI>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&csi_pins>;
+			status = "disabled";
+		};
+
 		hdmi: hdmi@1ee0000 {
 			compatible = "allwinner,sun50i-a64-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
-- 
2.18.0.321.gffc6fa0e3

