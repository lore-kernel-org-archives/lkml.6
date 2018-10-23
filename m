Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868B4C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA0B20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="E1jZu/Nq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA0B20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeJXAQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:16:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41744 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbeJXAQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:16:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id a19-v6so883631pfo.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 08:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yls8VK5SloeD7PLycjCBmh8RmhNZ2f5OyyDTNa+PUjw=;
        b=E1jZu/NqK4UGLFtr/awcZP8ojZAlsCYBRElMj/TEE05ZRdtouaclx1alkrNZaaLgle
         DaFTR1o6bOAQz6SgcUrthyxCbJhGcHMsNKzWtJFkal7Nn/SSnR/rkoCXxpol+2/tHHdF
         lndDw74DMYYboS+XB/0w+LYxdTHR74KnyR6a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yls8VK5SloeD7PLycjCBmh8RmhNZ2f5OyyDTNa+PUjw=;
        b=jvFp6GBDC7GyMXajp1oVpJABisEKOlVd1o6+Kis6cFHqUomT3PlfCfLEWg+7u+vscm
         UMoF/o0YVnOlLc1fQ3JUD6cSw9Fey4dXHXk0VpyzLTZaGXbpt/81/TbPx5pthVCb2raw
         p8FIWTNBBjFmcU1IvghTo0FNv8GuwQALzeFL8+vsCmRbqmqfiSPj9/ftv/g1UQbzJHcs
         5+JPcSqhgmioQXWrSolb/26r51foSUyRRoP6iwep0ftBKjh01BRQb6H4ctqexsxc3Woo
         +9RAoBly80vkMH++0phPpp182IKmCFpFL1gbjtv0MEDptP0iUGpwdfRtZ8aCNsUYzaWx
         9QCA==
X-Gm-Message-State: ABuFfojwQzt0SI+k2uYcOpKuFql+advmOn4HmvRCtp4sd72inbkL+89H
        FMkGeLCs0Y8mDLGvtWhb0366Hg==
X-Google-Smtp-Source: ACcGV61ixopvneYuQdnX9WKiA8YAnm8JF3FBR96qugo3dDIMzbSqceXp9QQfrYWOTLZDt7POpTm+OQ==
X-Received: by 2002:a63:ce56:: with SMTP id r22-v6mr46752105pgi.217.1540309937928;
        Tue, 23 Oct 2018 08:52:17 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id o75-v6sm7442829pfg.0.2018.10.23.08.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 08:52:17 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 14/15] arm64: dts: allwinner: a64: Add DSI pipeline
Date:   Tue, 23 Oct 2018 21:20:34 +0530
Message-Id: <20181023155035.9101-15-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181023155035.9101-1-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A64 has a MIPI-DSI block which is similar to A31
without mod clock.

So, add dsi node with A64 compatible, dphy node with
A31 compatible and finally connect dsi to tcon0 to
make proper DSI pipeline.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- use A64 dphy compatible

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index f3a66f888205..f82e6b165d57 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -320,6 +320,11 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <1>;
+
+					tcon0_out_dsi: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&dsi_in_tcon0>;
+					};
 				};
 			};
 		};
@@ -818,6 +823,46 @@
 			#interrupt-cells = <3>;
 		};
 
+
+		dsi: dsi@1ca0000 {
+			compatible = "allwinner,sun50i-a64-mipi-dsi";
+			reg = <0x01ca0000 0x1000>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MIPI_DSI>;
+			clock-names = "bus";
+			resets = <&ccu RST_BUS_MIPI_DSI>;
+			phys = <&dphy>;
+			phy-names = "dphy";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					dsi_in_tcon0: endpoint {
+						remote-endpoint = <&tcon0_out_dsi>;
+					};
+				};
+			};
+		};
+
+		dphy: d-phy@1ca1000 {
+			compatible = "allwinner,sun50i-a64-mipi-dphy",
+				     "allwinner,sun6i-a31-mipi-dphy";
+			reg = <0x01ca1000 0x1000>;
+			clocks = <&ccu CLK_BUS_MIPI_DSI>,
+				 <&ccu CLK_DSI_DPHY>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_MIPI_DSI>;
+			status = "disabled";
+			#phy-cells = <0>;
+		};
+
 		pwm: pwm@1c21400 {
 			compatible = "allwinner,sun50i-a64-pwm",
 				     "allwinner,sun5i-a13-pwm";
-- 
2.18.0.321.gffc6fa0e3

