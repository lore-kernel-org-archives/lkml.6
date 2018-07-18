Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6D1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1408820850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="m3q3jpIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1408820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbeGRLeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:34:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36072 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbeGRLeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:34:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id m19-v6so1842605pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R7mOrEE8dnJwOAlOXTRlyNWV30JGa7nESTHQrR41ghU=;
        b=m3q3jpIK+a8Z7B4/7icjrmKyXQZcoOoso141KqqKiOs/jszPxDghZa8Z4DzpyBeSy9
         QeNUs1itt10ziQqc3tCOqsfl3FkwSMA89SPyYf47wpzYOlXToCsNCr2vKtKMdounD1sp
         9hk40DBw4vpjL9PrIE8WhqA/j/I+wxglyb1W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R7mOrEE8dnJwOAlOXTRlyNWV30JGa7nESTHQrR41ghU=;
        b=odZfy26DYU7KQwGi9cPFIlpuNLHm9Vf4tSDkeYflZUKcFPR1mfXiFsUeSLZ9FicsBT
         5UnkT9kJUHsiobvUV8vlsP9IWUZr/lepMfeu4V85Xzpo6ktPsj8Bmx2q9RW3f71Ywq6t
         jpO90Kj6LCKWG/3dM61jJ99HAvnRHMycwd3TA7JkfO+QAP1GhF/fylIZumtE0ANFUfbN
         M199q/eHbwDqOIVotlq8mxKK3DtsePRTuCU4jSzl+VtZmDpEXMCE/gwSnQjfKMDT//wp
         TrHDljd1cR8j15HzUZOLtFJRj4ebq0EmrGjMv33GM2lOxoJCog9PgR/Jl2BR4u5IBmda
         RysA==
X-Gm-Message-State: AOUpUlG9StUvcJwGFocXe6nZkpLYQZS4M/4MzOlOi1Fg+zb5a4yKKmkT
        6wY17J74P9iWhF8mw911f45M/g==
X-Google-Smtp-Source: AAOMgpcn+x4H0IxiMrZUnjgw2KfPQB1WCEl35G1lMTsVtPcWoglSVYK0GJg3Cad7RQnvuq+B0+YjNQ==
X-Received: by 2002:a63:e60c:: with SMTP id g12-v6mr5395326pgh.308.1531911411158;
        Wed, 18 Jul 2018 03:56:51 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id x25-v6sm4644452pgv.63.2018.07.18.03.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:56:50 -0700 (PDT)
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
Subject: [PATCH v3 14/18] arm64: dts: allwinner: a64: nanopi-a64: Enable HDMI output
Date:   Wed, 18 Jul 2018 16:24:54 +0530
Message-Id: <20180718105458.22304-15-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable all necessary HDMI pipeline nodes with HDMI out
connector on nanopi-a64 board.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- Enable all pipeline components
Changes for v2:
- none

 .../dts/allwinner/sun50i-a64-nanopi-a64.dts   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index 98dbff19f5cc..5395069bf541 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -57,6 +57,21 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
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
+};
+
+&de {
+	status = "okay";
 };
 
 &ehci0 {
@@ -67,6 +82,17 @@
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
 /* i2c1 connected with gpio headers like pine64, bananapi */
 &i2c1 {
 	pinctrl-names = "default";
@@ -78,6 +104,10 @@
 	bias-pull-up;
 };
 
+&mixer1 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -199,6 +229,10 @@
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

