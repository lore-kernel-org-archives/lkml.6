Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6833ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F6E20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NV9FiySm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F6E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbeGRLeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:34:23 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33571 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730403AbeGRLeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:34:22 -0400
Received: by mail-pl0-f65.google.com with SMTP id 6-v6so1885297plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tRmfUKCrVu88srqcCJLStnMZibYZeCReRoqRb0aEdSI=;
        b=NV9FiySmnXDllHJ2iNZ2Y2P1qaUzsn42Wwt4j3r0x7V7xLmHrZcFax0BaWWxEmNvIu
         M4oqT6sNZnc4eE1f7ZwW1D9iY2ZefiJpQMQ89MxqJIMLH6hM39CmgZRr+x1N+AvhfvPE
         ZfGvcJzma8nNxgqf9CIwf9J3BVlCHdVFCahnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tRmfUKCrVu88srqcCJLStnMZibYZeCReRoqRb0aEdSI=;
        b=Mhp4odoixO5V7fcoDes0byiEy6zfyvTV0zFwHvSWA9DaldYGwytapcAKyEu+ThFVHx
         SqCJ+dsZQw/esZ25m4LYpmM6p9gNmFLqjvjClQAMxmoZWK3i5HMzj1Ol1aalX1rr+b+2
         /nnM1EwKllj7rypR3jNOmoblHMKqG+aGoEpNJiKWvUM0yGagEhe/k+/5FSdIJGF5e4M5
         UjzU8ZCB6Q0D9x9EqGPBYQBnTNa1AeVK8FuQ1os+Om7IePzV0xW8bsPP88BmTIIiP0eb
         fkf0icXJvkXTtOQiDYnUcIzHHk39dxWTW1atpYDCQ7vAadty739a7vnVPGXcFX004nSU
         O4bQ==
X-Gm-Message-State: AOUpUlEnPFly0xrWkkTvXBfs3f6xa6M2uBvVVz2XTsB3jThlWXkhTl8n
        n/YjsUEGhnsUrz/kMeTuchE+LQ==
X-Google-Smtp-Source: AAOMgpeRkbLI+vd4dfy1Gx7svc3+s0exgAjT71kqgJYw3rR2WnExSs/o/evrmJsd/WKFOo+LLBY1Ig==
X-Received: by 2002:a17:902:422:: with SMTP id 31-v6mr5373780ple.320.1531911421947;
        Wed, 18 Jul 2018 03:57:01 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id x25-v6sm4644452pgv.63.2018.07.18.03.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:57:01 -0700 (PDT)
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
Subject: [PATCH v3 16/18] arm64: dts: allwinner: a64: a64-olinuxino: Enable HDMI output
Date:   Wed, 18 Jul 2018 16:24:56 +0530
Message-Id: <20180718105458.22304-17-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable all necessary HDMI pipeline nodes with HDMI out
connector on a64-olinuxino board.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- Enable all pipeline components
Changes for v2:
- none

 .../dts/allwinner/sun50i-a64-olinuxino.dts    | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 3f531393eaee..0292149ee40a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -58,12 +58,42 @@
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
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
 	};
 };
 
+&de {
+	status = "okay";
+};
+
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
+&mixer1 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -218,6 +248,10 @@
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

