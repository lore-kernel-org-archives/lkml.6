Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01F1C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830F82082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DZJR5a9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830F82082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeKCTVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 15:21:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45818 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeKCTVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 15:21:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4so1615297pgc.12
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 03:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jch0JasRD8DxgblgWqxxljQK0vs01jkKprFR0+gAUF8=;
        b=DZJR5a9FIPi68VOXZL7y0V97oypY8y2086ZCdd4jOOdeO9R9xYqi9ZIBYIb8H28ggC
         bx8S5ZbcXWmzkJ1G1MUAYkJ3DsE68kEA8nv2Zx6bAMBwZe3B8qtTNJLN780O57BjPutC
         0CnmNGMfvAtWSHWCWmvhI5T1v9p+t0JRTRbPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jch0JasRD8DxgblgWqxxljQK0vs01jkKprFR0+gAUF8=;
        b=sL8/8vAw58d7dj3YnbUN1a5lKRDGMEcPAb7D6RlGJ88ZuPMd4/k38aTFIxYvs8dU/w
         P0wHhCwXbQragkg4NeNPveo7z8kjpVrDfn1Wfv39ht/rdBpT9yNmahOLOB1YYtccv2gF
         CEMGRVyuLPOz7sBkSea4EuidFD4SoDY2Q/yPlBi8smUwZAsbn736jlX1a/6CnooXyY+r
         6IXBuhmz8QjFl3RDW6VWMTkpgVtq76bI68jpbVZntveyzSbJpLpnI/hLpGQAcQiHYM4L
         0SJrcq5iNmlha6v24KsxAMbdxlxXWVabXg+ZGGeVDVzqW3AZgXEnTh6Mz28n1UiUtMZy
         dKPw==
X-Gm-Message-State: AGRZ1gKaYdhu1gKgiohzJ67JUr2LfPO+PW8ZeSjP8U3mBm3FAlTYQVbe
        EkYqLVHpuOIo0f8jBdBFNIqZVA==
X-Google-Smtp-Source: AJdET5dIQoU1e/a+tJAvqPhyWVhTwVngHeof+XojGx9uR/FHe7MIAde5WcfSPjwETLLImvnsH07/dg==
X-Received: by 2002:a62:c184:: with SMTP id i126-v6mr15015200pfg.53.1541239834915;
        Sat, 03 Nov 2018 03:10:34 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:6094:3f7a:ed0a:fb74:1220:defe])
        by smtp.gmail.com with ESMTPSA id z79-v6sm28466823pfl.33.2018.11.03.03.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 03:10:34 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 10/10] [DO NOT MERGE] arm64: allwinner: a64: pine64-lts: Enable Feiyang FY07024DI26A30-D DSI panel
Date:   Sat,  3 Nov 2018 15:39:00 +0530
Message-Id: <20181103100900.30313-11-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181103100900.30313-1-jagan@amarulasolutions.com>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feiyang FY07024DI26A30-D MIPI_DSI panel is desiged to attach with
DSI connector on pine64 boards, enable the same for pine64 LTS.

DSI panel connected via board DSI port with,
- DC1SW as AVDD supply
- DLDO2 as DVDD supply
- DLDO1 as VCC-DSI supply
- PD24 gpio for reset pin
- PH10 gpio for backlight enable pin

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../dts/allwinner/sun50i-a64-pine64-lts.dts   | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
index 72d6961dc312..a5097cf7a8dc 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
@@ -5,9 +5,46 @@
  */
 
 #include "sun50i-a64-sopine-baseboard.dts"
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Pine64 LTS";
 	compatible = "pine64,pine64-lts", "allwinner,sun50i-r18",
 		     "allwinner,sun50i-a64";
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <1 2 4 8 16 32 64 128 512>;
+		default-brightness-level = <8>;
+		enable-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* LCD-BL-EN: PH10 */
+	};
+};
+
+&de {
+	status = "okay";
+};
+
+&dphy {
+	status = "okay";
+};
+
+&dsi {
+	vcc-dsi-supply = <&reg_dldo1>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "feiyang,fy07024di26a30d";
+		reg = <0>;
+		avdd-supply = <&reg_dc1sw>;
+		dvdd-supply = <&reg_dldo2>;
+		reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+		backlight = <&backlight>;
+	};
+};
+
+&r_pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&r_pwm_pin>;
+	status = "okay";
 };
-- 
2.18.0.321.gffc6fa0e3

