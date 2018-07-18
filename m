Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E5DECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B4E20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZrqQuDUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B4E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbeGRLe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:34:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33769 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbeGRLe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:34:28 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so2038949pfi.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sph8ugjCFtlf6uzzMmhxVqqBorMdVRTL8Im7dX1W458=;
        b=ZrqQuDUfeGZCXL54t6AjzWbXfM8ZyNACS9sjvcvdtOv0lScnbsLZmdDmT3HrZL2+Ay
         FvIkYU9SSzXAlxp/I1XRPuV9zA0jxGrChI9MAWxjt5BCZur56y9gh7fcw7cW/hyQnEoo
         H7mTthv/2GcfWQNz5lAemT7AP+tV+FMU451NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sph8ugjCFtlf6uzzMmhxVqqBorMdVRTL8Im7dX1W458=;
        b=HFuqdI9Hf6Tv1aS/LddqVgvAe+V6reNsucJB12Wko4eq7JIaQ4X4+h/UinXu0GAba+
         NjrpYruSlRikBBZWc/S2mKa7IFEHBxse/zSBMlP7m8oofHVquokVNN17DZ8eR9z1rJ1v
         F/zS/SE1gqUXIlKyPkfxB1OvW64slJQH9sUoAuWEAwnRgo67CjZ1U/qh+68O3rkRAIWj
         kFwroM9FcyTTA18OPdO0Bo2gSIiYmBGYXYBS3LRVMSFmkIZ2e+gP/zMZbEZ3djXZzQaQ
         BfNj0agX/bdWVCfke0b32atultBz4IT0W/xV+34LpAABeT5LcoU9jI3iz8OPeBZ/wtcV
         ZEug==
X-Gm-Message-State: AOUpUlESboR771hIoaYzLZ8iTM/MM0DR4zfhiAeuAzfPL2aNuK/OEIv3
        /zkhhggBzP4KABveOBcgFDenkA==
X-Google-Smtp-Source: AAOMgpdK+zcRDYbN7lDop95IPZ3cRYRWJck8v0T1WZf7RLUL2hHIQaJ4o5YljBHu9+VcvPqZajilBg==
X-Received: by 2002:a65:66d7:: with SMTP id c23-v6mr5333152pgw.427.1531911427336;
        Wed, 18 Jul 2018 03:57:07 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id x25-v6sm4644452pgv.63.2018.07.18.03.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:57:06 -0700 (PDT)
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
Subject: [PATCH v3 17/18] arm64: dts: allwinner: a64: pine64: Enable HDMI output
Date:   Wed, 18 Jul 2018 16:24:57 +0530
Message-Id: <20180718105458.22304-18-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable all necessary HDMI pipeline nodes with HDMI out
connector on pine64 board.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- Enable all pipeline components
Changes for v2:
- none

 .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 1b9b92e541d2..4d1553f7d2a9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -62,6 +62,21 @@
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
@@ -82,6 +97,17 @@
 
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
@@ -99,6 +125,10 @@
 	};
 };
 
+&mixer1 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -238,6 +268,10 @@
 	status = "disabled";
 };
 
+&tcon1 {
+	status = "okay";
+};
+
 /* On Exp and Euler connectors */
 &uart0 {
 	pinctrl-names = "default";
-- 
2.17.1

