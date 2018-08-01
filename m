Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891F2C46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD6420894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LApvsmde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD6420894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389074AbeHALdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:33:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37744 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388953AbeHALdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:33:01 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so6294752wmc.2;
        Wed, 01 Aug 2018 02:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cq9NH+oVSC4BLzYdcoahdEruWQbnx28uoXRsQSzwgUo=;
        b=LApvsmded2eoFiLN+w/c/eTiFPV3sEHkA/CRstAWA2m25NMELBlQlDvbOvCJNDp9Ch
         33siPQcsXD1UFXdAzGgSL4tU5kLfCrKEdYZBcrcY+dqbNyGqbDYRepTFs7jSqQDxguZ8
         AD0gg8etKcuJoE/KC/OGmpMOzmrF1lzJAHWwxwn1CKTjK9jH8Dne5cFjwH4I2c/SFsnp
         2SrkIi/UlsogGqhpF4hkT6gQUKODzsBpiCRAKs6H2b0vkwxuWA6pbsJ53EUOabDnlMol
         qNkhvs5KNBXFILCljNLR+iX3KR3Uz0gBBnsWn2r+8EymDaJOJkv7XxxOYQwPnqbEnlFV
         qXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cq9NH+oVSC4BLzYdcoahdEruWQbnx28uoXRsQSzwgUo=;
        b=Rogds/E4Q8DvqSKzfv1EH3BxbY7Ugq2emeuxCjJU1lhJ6K75h2ffQ//Sw+de7ksOd9
         XnDloF3EmjLCFHVPA8+uIlSOxgEJP92QZ9ZWFenmzDGCoHGCsUNSzCUrZsW+x/0xr2rA
         2hLWBt+SSQ1F/b7pyVEoms5+ixpVsczv/fHloZesNSJIBSXTtNsL337te5eE63bdJ4Qj
         OrU4KbLXTWNLJ2db0PAuWZNzHZODAR22oKGC84suUsgH1wiv2yy1jqWyZ1KDz9QP/ZhF
         Cf0woYHsjIut4nA43oMiiSfqXzoRcP2WFm+eiX5X4Ix0i04SNmF6ae9VO7UP2HLaSvX9
         u7WQ==
X-Gm-Message-State: AOUpUlH6IB7PGlINsyV85v+d5kqKKTPosClmo0lZaaMrAIeixAD5o8Z8
        o40ercGmGu5dkU510DY7S1c=
X-Google-Smtp-Source: AAOMgpdo2ESO22O+floht/gfkKouLdHVumDdFKQbYLTcmhHiS5x4+knxnIBjpL4CUSQBmCb84Nx7/Q==
X-Received: by 2002:a1c:2d54:: with SMTP id t81-v6mr2390507wmt.31.1533116884828;
        Wed, 01 Aug 2018 02:48:04 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id r12-v6sm13580217wmh.0.2018.08.01.02.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 02:48:04 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org,
        linux@armlinux.org.uk, sean@mess.org, p.zabel@pengutronix.de
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v7 2/4] ARM: dts: sun8i: a83t: Add support for the cir interface
Date:   Wed,  1 Aug 2018 11:47:59 +0200
Message-Id: <20180801094801.26627-3-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180801094801.26627-1-embed3d@gmail.com>
References: <20180801094801.26627-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cir interface is like on the H3 located at 0x01f02000 and is exactly
the same. This patch adds support for the ir interface on the A83T.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index afed6c0dea6f..798ab48c5479 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -992,6 +992,19 @@
 			reg = <0x1f01c00 0x400>;
 		};
 
+		r_cir: ir@1f02000 {
+			compatible = "allwinner,sun8i-a83t-ir",
+				"allwinner,sun5i-a13-ir";
+			clocks = <&r_ccu CLK_APB0_IR>, <&r_ccu CLK_IR>;
+			clock-names = "apb", "ir";
+			resets = <&r_ccu RST_APB0_IR>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x01f02000 0x400>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_cir_pin>;
+			status = "disabled";
+		};
+
 		r_pio: pinctrl@1f02c00 {
 			compatible = "allwinner,sun8i-a83t-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
-- 
2.11.0

