Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3C9C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A332082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNznO+uB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A332082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbeKAQkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:40:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39664 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbeKAQkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:40:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id r10-v6so19105292wrv.6;
        Thu, 01 Nov 2018 00:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3aM1D9WDLOgDPGWTrFp0a9a42JLuitpq+OWkUO7HUb0=;
        b=JNznO+uBWK6JJREHBQMV9Mi16BViAKS9IMCUts5BiZwapeP2bItP0RU8MPlUDaZLeL
         fRg3wUobE9luPLEP6EU1ZqkP2TcKq3PmqObk+9u7AFtqHT+nHILO+1m3xg9+vWtOBKlH
         3eNdYbNnjlUPUblBetw14v1EN3tyqN77040ZbvpMDCyOR7/cr88J0Vj6dQRNi2Ge5Lgu
         /uv6xXwy0R86/G4QDzJlM6B7sY1CSgtB7sjaW1pLA/8dotfLN1Sel0+sjRNZzvlzB0sJ
         9qFqEODAmEGWjD8Mmg/QxKxR4UAampUt8hGWVqcupo49iMUHVGBnuLzWblukgGUFHQau
         Pjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3aM1D9WDLOgDPGWTrFp0a9a42JLuitpq+OWkUO7HUb0=;
        b=Leh9GxP8X7/a+XdCvPp0M5XLDu1c7Uc+Iio6nqPReHClDxg8t00EpI+AMtstNxuA/X
         dp24B8sVHejzBMNB6Ee5mS/iQm9mPSKk50CkeoN486W0IVNAgAjatrMRqs53g/vLq9S3
         v3U+yit56mT+AhTXVlL42i3Jy7UIq1ubLtZnHUXIAkqGva2dJWPHdCRGTiuArsZkGK8g
         D77Lwe1rxep5lvVd1ZZz4faeRFfNwX0ZDzxnSZlnaSYoVrAyQ1wYpLxjInpzA+DxUiJI
         CaenR7tFcz2a8a7AaG8SR5hfZ9Qdv31X21VCd0ChprJ+6xKi/VdImhPkbZzMVmZRY4l1
         H38Q==
X-Gm-Message-State: AGRZ1gIYRZuOsgH0qJTXvdVzCN9W4ph1r1MVJZW5eAVe6URfIilOVZkC
        qabZ8ziTJtRdEx7/D39XEcg=
X-Google-Smtp-Source: AJdET5dqPzQ+tBJ05dq+zrSDObbJvpAGxCvof8SrMcrmBfv4a9iFuP+eUAb65r2Tj2t20LeGZOh0Vg==
X-Received: by 2002:a5d:5745:: with SMTP id q5-v6mr5444348wrw.161.1541057925919;
        Thu, 01 Nov 2018 00:38:45 -0700 (PDT)
Received: from xeon.fritz.box (p508DB575.dip0.t-ipconnect.de. [80.141.181.117])
        by smtp.gmail.com with ESMTPSA id x18-v6sm3287624wrs.50.2018.11.01.00.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 00:38:44 -0700 (PDT)
From:   Lothar Felten <lothar.felten@gmail.com>
To:     linux-sunxi@googlegroups.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     maxime.ripard@bootlin.com, jernej.skrabec@siol.net,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        Lothar Felten <lothar.felten@gmail.com>
Subject: [PATCH] ARM: dtsi: sun8i-r40: add mali node
Date:   Thu,  1 Nov 2018 08:38:33 +0100
Message-Id: <20181101073833.2936-1-lothar.felten@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a node for the mali 400 GPU of the R40/V40 SoC

Signed-off-by: Lothar Felten <lothar.felten@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 6f4c9ca5a3ee..ddf765e931f3 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -542,6 +542,31 @@
 
 		};
 
+		mali: gpu@1c40000 {
+			compatible = "allwinner,sun7i-a20-mali", "arm,mali-400";
+			reg = <0x01c40000 0x10000>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gp",
+					  "gpmmu",
+					  "pp0",
+					  "ppmmu0",
+					  "pp1",
+					  "ppmmu1",
+					  "pmu";
+			clocks = <&ccu CLK_BUS_GPU>, <&ccu CLK_GPU>;
+			clock-names = "bus", "core";
+			resets = <&ccu RST_BUS_GPU>;
+
+			assigned-clocks = <&ccu CLK_GPU>;
+			assigned-clock-rates = <384000000>;
+		};
+
 		gmac: ethernet@1c50000 {
 			compatible = "allwinner,sun8i-r40-gmac";
 			syscon = <&ccu>;
@@ -813,7 +838,8 @@
 		};
 
 		hdmi_phy: hdmi-phy@1ef0000 {
-			compatible = "allwinner,sun8i-r40-hdmi-phy";
+			compatible = "allwinner,sun8i-r40-hdmi-phy",
+				     "allwinner,sun50i-a64-hdmi-phy";
 			reg = <0x01ef0000 0x10000>;
 			clocks = <&ccu CLK_BUS_HDMI1>, <&ccu CLK_HDMI_SLOW>,
 				 <&ccu 7>, <&ccu 16>;
-- 
2.11.0

