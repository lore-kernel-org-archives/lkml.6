Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DDEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1A820818
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eMrkOmeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1A820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732930AbeKMV7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:59:05 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44029 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732786AbeKMV7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:59:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id n10-v6so5581013pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 04:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s3gRYHT8FKG6ENi+N4NoaSa/TEH6QZAoYAGxS/97DJA=;
        b=eMrkOmeQdFndhYuXbN0GYk8cHj9GvETZgA6MzK5zvOcMDWKba5BQnxZy/+fsfw5jX9
         NWFgDUQ6SlxzJcZISafOszvc4oihx//h6bjMCXb9SwpT9xbVrITj5O9QzE7hHkFzYulw
         geP5jnjTA3rEbAnXb8dSZMso0G5DcewdEAMCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s3gRYHT8FKG6ENi+N4NoaSa/TEH6QZAoYAGxS/97DJA=;
        b=jo6Z8MXONP18rAEUR5nP+FlANfDT/5jPU3RLDrRE01rquHvlPHQEV1FN6Id/NDxj5G
         S6+YHbnYzdCrambXoYkLqrk6OGFp9PWtvlFOAf/HDatT6iB9OhfsDpuxPKcS9pytDGRD
         oOjQbooOmj/kpeKLlqOOdLnWEUMPJN/RZCXXo5EGzLlN6+xfVQFmk8h7eRLodyDoRQ3E
         klvb5Imgr+m6F9H5TzqE/b55N5b/RhG53Eeps+e7+UZAt1sXOQQ8/iE9UzttMMeDDXtW
         kRX+v8eiSfTztBOLAqBAK9MYUQebJ3U32Zt0OvwVXkOHuP93Ms8dHWsc1iMgUv+T4Tmc
         h2TQ==
X-Gm-Message-State: AGRZ1gJfT0eZ0AyJyrEeF8R+1WHX4ao4pBJSmYNPXbyjDGj4QY+YzdGl
        wjr94V9h7aABGk3LFHAHBqzTfQ==
X-Google-Smtp-Source: AJdET5fMbsmhYlN0kvhApAR/rJ3y8eK0/dOn0rsv5wPQKn8bdoK3YeaLPNZVlEa5Q0TWDSxoAAltqA==
X-Received: by 2002:a62:2095:: with SMTP id m21-v6mr1876669pfj.32.1542110475445;
        Tue, 13 Nov 2018 04:01:15 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3670:3f11:bc71:2ef7:4a39:e260])
        by smtp.gmail.com with ESMTPSA id 74sm21826267pgh.82.2018.11.13.04.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 04:01:14 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 2/2] arm64: dts: allwinner: a64: Add device node for Mali-400 GPU
Date:   Tue, 13 Nov 2018 17:30:54 +0530
Message-Id: <20181113120054.17639-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181113120054.17639-1-jagan@amarulasolutions.com>
References: <20181113120054.17639-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Allwinner A64 has Mali-400MP2.

All interrupt lines are mentioned in the manual so used the same.
Used 408MHz as assigned clock rate used by BSP, so used the same as
well.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Drop assigned clock properties
- Separate dt-bindings as separate patch.

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index d6f269883759..d507be9879d8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -813,6 +813,28 @@
 			};
 		};
 
+		mali: gpu@1c40000 {
+			compatible = "allwinner,sun50i-a64-mali", "arm,mali-400";
+			reg = <0x01c40000 0x10000>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
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
 		gic: interrupt-controller@1c81000 {
 			compatible = "arm,gic-400";
 			reg = <0x01c81000 0x1000>,
-- 
2.18.0.321.gffc6fa0e3

