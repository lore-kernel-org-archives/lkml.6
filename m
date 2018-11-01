Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D75FC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336102081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8EiBnG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336102081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeKAR70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 13:59:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32824 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeKAR7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 13:59:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id u1-v6so19323864wrn.0;
        Thu, 01 Nov 2018 01:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=emoO1uNFgH2/vZ9/8K/yC1aOxYxdWJfqUqwN0u0t4E0=;
        b=Z8EiBnG8EhLVnA64YwvG1g2uaVLLd7JSwPLr4SpYUHursW31lMqWJxx325YlaUZQpZ
         XK1x5TUMmnXOvBjuePu0zA/Q2U/KwFM3R+2rcHSF1JXp5bxNeVFRYzSK1EJqbN1+4l8r
         g+a6SlB3VBDYQwt15PGBTAqiGXF40WjQK8Vfk7skRy1rq+oWMwu7ucxDTYPpZP8I5BdL
         nzwKHOzx66opqEPTjboO3woqksIJCRH90/miPenm9nCUCU4n3exZt0EsZuJJmROwYENx
         2Ai1esaIADPW46ecbmlpVo4eXgcnrYhZEXyNXm0TmjdAtG7LQ2R6YrHnkyKg3m/lsGIY
         h3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=emoO1uNFgH2/vZ9/8K/yC1aOxYxdWJfqUqwN0u0t4E0=;
        b=EOOXdzx99PD/Eswf7SDmibuT4eW50JfdMPW1G/JSqYYu/Gt57+GUuljIyV/4Y+aRvU
         599UpB3JjVvjkzRaMPt68/IEZzHIbnwrP7VXtaB7BFK0D2KIuvnHy/U797W1OOXoBQ5L
         QODXmcZ/cvekMfra2bvXQZUycnZ87pOvYQehD2+Kb9/cbomjmo1JGyxXgShwLKi/qc1S
         nzqJPi2KRsHra94vrtlw7ZIuHc5M8zem3e11tBjRj6Txp9Xm+7n1WVcYambvG/zJ1qA9
         m6CqAwubBxre9L3BRf0ZtSuQKc0ho+3MqbitB2wRtWznXutz0J8z5pGCJBdkM+R0bc2B
         TvJg==
X-Gm-Message-State: AGRZ1gKzlRcMyl0PGWuTTmT3E5eJ/21ksLld1swFHajCANFDymuHySdq
        nOExP1edHeza9K+Ur1X18xA=
X-Google-Smtp-Source: AJdET5eNVL9UQwakiKs2hQUnciBSHWagm2XTMIY+myrGgE2Gjv/zU9Nm+EXxHE0nPV+1cZlWBLD1vQ==
X-Received: by 2002:a5d:634f:: with SMTP id b15-v6mr6071212wrw.14.1541062639561;
        Thu, 01 Nov 2018 01:57:19 -0700 (PDT)
Received: from xeon.fritz.box (p508DB575.dip0.t-ipconnect.de. [80.141.181.117])
        by smtp.gmail.com with ESMTPSA id u15-v6sm6357132wrt.53.2018.11.01.01.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 01:57:18 -0700 (PDT)
From:   Lothar Felten <lothar.felten@gmail.com>
To:     linux-sunxi@googlegroups.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     maxime.ripard@bootlin.com, jernej.skrabec@siol.net,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        Lothar Felten <lothar.felten@gmail.com>
Subject: [PATCH v3] ARM: dtsi: sun8i-r40: add mali node
Date:   Thu,  1 Nov 2018 09:57:10 +0100
Message-Id: <20181101085710.15774-1-lothar.felten@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a node for the mali 400 GPU of the R40/V40 SoC

Signed-off-by: Lothar Felten <lothar.felten@gmail.com>
---
Changes v2->v3:
- remove mali clock rates
- drop hdmi-phy sun50i-a64 compatibility  
- patch version, change log added

Changes v1->v2:
- commit message uppercase ARM prefix
- wrong patch submitted by mistake
---

 arch/arm/boot/dts/sun8i-r40.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 6f4c9ca5a3ee..136c248cc7d1 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -542,6 +542,28 @@
 
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
+		};
+
 		gmac: ethernet@1c50000 {
 			compatible = "allwinner,sun8i-r40-gmac";
 			syscon = <&ccu>;
-- 
2.11.0

