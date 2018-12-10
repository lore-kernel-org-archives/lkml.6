Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923E6C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D4820672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aqPbNxfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D4820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbeLJQSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:18:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50274 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbeLJQSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:18:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so11627851wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FjGhPpG8sG9uBklMCJSskhFh/huEKC/N4BLQs4vEQZ4=;
        b=aqPbNxfJVW0/xjfottM/ES1pxezCOVjUQ2wAkUXTBOKqfUJUIK5AJ0C3SKuV3Ajp/Q
         CxaRLB/C6QeFwmz5BsgCj47v0HyyD6E7HU+nuNMaTkdIxhlkI9V4znXKSXCQc+MIcpBf
         AzffqZ9bvrC9Z5NgxF1OZ1gu431eOchzQvR94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FjGhPpG8sG9uBklMCJSskhFh/huEKC/N4BLQs4vEQZ4=;
        b=IFzM9zxg/Hy4M/tE3Uj37tOiTNt8u792FQaFDx3Rf4kq6drGEOVsfbW2XYjeLK9FAX
         jW150MQItBCsrdtjhptrY9WhAMrJjnAar3oAya2x4rroYpeZYtaHVJcsIW33LFuS0kEp
         9HBH+niNbIbqkGJhts+hyH+M75xWGGAdqoMGjCveiXKOfTI+LmeDhY48TppwI0u2N2Qj
         AXhHLRSWUNKEaEYQNFOuKkdTXlGIETjaVdzY5DWtQ6okd+n0hycYOGi41g0bHFdRIvFc
         9KLjioMrCLnTKjTG2r1o7Cz+ns8xRINJFID8hsdlpa//ramquP1E31ZEbNH6FYR6ARxm
         vnEg==
X-Gm-Message-State: AA+aEWaUL74LYNkQU5cvONJUYZiEGkIkvqsYng/8iMvpFlTsb44nUrxa
        EbbuxbHiWTmEMvT8bLT+B1WyTA==
X-Google-Smtp-Source: AFSGD/XofnVFXaIamGKZrCl8m9R2W57jrmtIYgZOTKF+Z01pEg48PsY16QkLyN3oPdocX2J4piqR4g==
X-Received: by 2002:a1c:de57:: with SMTP id v84mr10923948wmg.55.1544458693211;
        Mon, 10 Dec 2018 08:18:13 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:18:12 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 17/17] arm64: dts: allwinner: a64: Add DSI pipeline
Date:   Mon, 10 Dec 2018 21:47:29 +0530
Message-Id: <20181210161729.29720-18-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
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
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index dd5740bc3fc9..dd5c7ad55149 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -344,6 +344,12 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <1>;
+
+					tcon0_out_dsi: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&dsi_in_tcon0>;
+						allwinner,tcon-channel = <1>;
+					};
 				};
 			};
 		};
@@ -910,6 +916,45 @@
 			status = "disabled";
 		};
 
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
 		csi: csi@1cb0000 {
 			compatible = "allwinner,sun50i-a64-csi";
 			reg = <0x01cb0000 0x1000>;
-- 
2.18.0.321.gffc6fa0e3

