Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D685C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A5A20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="n/al2t3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A5A20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeLJLxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:53:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40620 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbeLJLxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:53:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so10862642wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 03:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YCOZorFflqds8ajAHDAaoT0p9NgnHCX+QglAEJ8Qg/w=;
        b=n/al2t3NVW0ZJ0ItwmFF84wfLAhRNRVoQuVQ/CcY33LEIPT0PtCMQe9E9BWR99xy1E
         uKAQnpIHoYdZGhvt5NXZLWj7DwItZ4PLiFrXb0kgFJTtxjOwzVULh6Itbcdict5HU8Tn
         qAV/IKoHmX6Vp/1kfIkIN9s0aQntk2RW2lClg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YCOZorFflqds8ajAHDAaoT0p9NgnHCX+QglAEJ8Qg/w=;
        b=ieSma+qgapUc6lEKThQ0faAaKyPUc1iXxczYZKg9NDtz9UequEE4rLI5ekogKOSO1Q
         43lctZl8GtdXy031jdPOgrs1BcH+rzio+u8KUtujjXDDzI2+h65XK0WQGrTJauYvbqte
         eZl8GxXivG2qwN94WMWFW+A0xnkpEbWyAJ74n97FkMr3Xpendfqf0jKYtzkJBDkcfQV0
         rQ6OtIv3NUvmQ2o+V08LRKGPNtKVmXqXHxaqJZ4lXAyPg7b3Nwp0zaQbejJHJAPik4N7
         K4VMYWKdSfASp6aTyMzha6xENtsX9dwLXjMk5ErbtGbeFXLIfAVA3VS2xrxaWBxv2Zut
         skbw==
X-Gm-Message-State: AA+aEWaCkC5ScAYnOjugYh1I+dGeJsya2Fx4fKyLFeuA6RePSu5UvMuw
        iEi4fgCbaxpEUUOJr5WecaOSJw==
X-Google-Smtp-Source: AFSGD/U8grm9cGMe6Y4Sc0MwaFhIdWzVIUZ5SIaZ+q9e4S/oH6tjr2Bm9FBjN1XGD6og/2ml5q9hzQ==
X-Received: by 2002:a7b:c142:: with SMTP id z2mr11014121wmi.102.1544442815538;
        Mon, 10 Dec 2018 03:53:35 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b16sm7869243wrm.41.2018.12.10.03.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 03:53:34 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 4/6] arm64: dts: allwinner: a64: Add A64 CSI controller
Date:   Mon, 10 Dec 2018 17:22:44 +0530
Message-Id: <20181210115246.8188-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210115246.8188-1-jagan@amarulasolutions.com>
References: <20181210115246.8188-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 CSI controller has similar features as like in
H3, but work by lowering clock than default mod clock.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 384c417cb7a2..89a0deb3fe6a 100644
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
@@ -899,6 +905,20 @@
 			status = "disabled";
 		};
 
+		csi: csi@1cb0000 {
+			compatible = "allwinner,sun50i-a64-csi";
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

