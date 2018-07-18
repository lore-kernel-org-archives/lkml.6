Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E96ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A230A20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UQogW0FG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A230A20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbeGRLeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:34:06 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45522 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbeGRLeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:34:05 -0400
Received: by mail-pl0-f68.google.com with SMTP id 94-v6so1870703ple.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FOBLZ5urAy7VMR+hHZBZ94mTkwzsEEdpb+K9j45RtB0=;
        b=UQogW0FGUN9VLDvgbuPtBIWdxT/3r28TBvAWS6Iv0K3ZGACyEdKlBZQUpWbDaLIkym
         DqnDr5GTq8h4GKrRdm/YqHBkuOHCPpHPVs0p6jDLmOwehh12lyrgPMMAK8ZdbfeIrwMm
         V9+SmDTJfku+Hz2zoHE7WYbda6xewo0qdeRcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FOBLZ5urAy7VMR+hHZBZ94mTkwzsEEdpb+K9j45RtB0=;
        b=fvdKkA9Z0FM/u3pGhocZlVEeiOLnHAinHO7REARxS4GSwDdVxaTEl/W96oEpu8c/UZ
         8R4DFwVKyN2a2RcYWLFa8zpB8Dp2QCqvgYjoGo6BVYhcj66UZLEXDq45RiZjdA3T7td8
         mhA+dv/7BY5hmPmxBZq7IT9B+RCUU0FQwYw6mQFvwEUlbby0nFcjVT/jxOwy/RKcrKDV
         SU4Fu++J8fOUMtr97LIFWiaI7SYmVNSP6sf4ZR58/aT8lJvY/nWseF+i8URpGNTpVL83
         CHzfV/6AbLC4oEFcFlDwKUQpiGXKFFlMNkc8tb9IQeASoxR+oGLn/7tHLoHuxMtT53tU
         MxTA==
X-Gm-Message-State: AOUpUlFdDzSgVz6ROvmnqiJKSZ0u3tK/lSDUFZukFY3EMSkpqOTuttM1
        rGJZKLOp5a4WsV/RlWWQH/ReiA==
X-Google-Smtp-Source: AAOMgpemKyhMG7KQQuTstxAHmtYpZ98sj5UqGNOdVEo7KAhZt23LAJVIbBmoJEIw625WESZTvfbFtQ==
X-Received: by 2002:a17:902:aa07:: with SMTP id be7-v6mr5383514plb.109.1531911405200;
        Wed, 18 Jul 2018 03:56:45 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id x25-v6sm4644452pgv.63.2018.07.18.03.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:56:44 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
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
Subject: [PATCH v3 13/18] arm64: dts: allwinner: a64: bananapi-m64: Enable HDMI output
Date:   Wed, 18 Jul 2018 16:24:53 +0530
Message-Id: <20180718105458.22304-14-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable all necessary HDMI pipeline nodes with HDMI out
connector on Bananpi-m64 board.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- Enable all pipeline components
Changes for v2:
- none

 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 094cfed13df9..7adba2c8f6e5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -60,6 +60,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -86,6 +97,10 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -103,6 +118,17 @@
 	status = "okay";
 };
 
+&hdmi {
+	hvcc-supply = <&reg_dldo1>;
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins>;
@@ -120,6 +146,10 @@
 	};
 };
 
+&mixer1 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -300,6 +330,10 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&tcon1 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.17.1

