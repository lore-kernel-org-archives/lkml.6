Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BC9C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECC3208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ci3teYyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECC3208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbeLFSqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:46:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34578 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeLFSqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:46:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so611104pfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CDAZThfGpZuCvBtSjM99jB2sfnJYtaXxMYYfeP3n/mU=;
        b=Ci3teYyTngYMlJntSFhuhSTIrgEGfsKKgXUI4RKtan9vH4CZLOW45u2y38apsxnfAU
         81Wkgfx9imebzudQlrwW4PZsVsdQF9xlbF1jesE8NWr6LWBuv39muSEdSyn2WY8q815s
         W9IivUQAQf4pazXie/RsSxpnwX+nkX8TcHZ8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CDAZThfGpZuCvBtSjM99jB2sfnJYtaXxMYYfeP3n/mU=;
        b=iblL0t7kC+BtuCAtQ+pwcBYNdXIsVPvK5U2z5O20vQ9oNghMgSdC6Z9dWsbmqEe1My
         Z+AVpeOCyxxuPaHBksQYT4QJ1drdhQUlhlH6mbOFg7ovnfZY0XftqXhDyFCoLLgFRGop
         Xwc5tnbmk1WLo19j2daHuickvJUW+tv3dhEO/fk5nVVwmujkHWP3X9MSxYwH+7PUfpIT
         DYauv0XFA0XONSpha+TlJPNTl9ih5s5CX4oEP/l+QETcPFuDtxMcU0lkw+hzlKbZBZx7
         BupoP4EECpTVPxz2/2yir54lXYMWNDOcAnrS8oG+4UDBz9NyxzpO83YPDNtet2ahDkz9
         J6nA==
X-Gm-Message-State: AA+aEWaJR2vLXUqaYIfznhcZXJtUzdTHWn3kh6BXldT9VwgiUrvduW71
        k3hk8IhI8tJqiV5YPnMyLsT7hw==
X-Google-Smtp-Source: AFSGD/Wiy/sPvVvGRIxBzaE1N9aYs6obd8R4g+LizYsET7doiqfA6shi/glWYP9sqCeHYR1KRGprkQ==
X-Received: by 2002:a63:2ac9:: with SMTP id q192mr24947768pgq.58.1544121965512;
        Thu, 06 Dec 2018 10:46:05 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v89sm1458476pfk.12.2018.12.06.10.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 10:46:04 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 3/3] arm64: dts: qcom: sdm845: Add SD nodes for sdm845-mtp
Date:   Thu,  6 Dec 2018 10:45:22 -0800
Message-Id: <20181206184522.118062-4-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181206184522.118062-1-evgreen@chromium.org>
References: <20181206184522.118062-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for one of the micro SD slots on the MTP.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v2:
 - Fixed alphabetization of node placement in sdm845-mtp.dtsi (Doug)
 - Fixed card detect name to match schematics (Doug).
 - Moved comment about drive strength next to the drive-strength entry
 (Doug)
 - Removed drive-strength from card detect input pin (Doug).
 - Consolidated tlmm nodes in MTP.

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 58 ++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index b3def03581775..cde76da42cbb7 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sdm845.dtsi"
 
@@ -358,8 +359,16 @@
 	status = "okay";
 };
 
-&tlmm {
-	gpio-reserved-ranges = <0 4>, <81 4>;
+&sdhc_2 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdc2_clk &sdc2_cmd &sdc2_data &sd_card_det_n>;
+
+	vmmc-supply = <&vreg_l21a_2p95>;
+	vqmmc-supply = <&vddpx_2>;
+
+	cd-gpios = <&tlmm 126 GPIO_ACTIVE_LOW>;
 };
 
 &uart9 {
@@ -450,3 +459,48 @@
 		bias-pull-up;
 	};
 };
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <81 4>;
+
+	sdc2_clk: sdc2-clk {
+		pinconf {
+			pins = "sdc2_clk";
+			bias-disable;
+
+			/*
+			 * It seems that mmc_test reports errors if drive
+			 * strength is not 16 on clk, cmd, and data pins.
+			 */
+			drive-strength = <16>;
+		};
+	};
+
+	sdc2_cmd: sdc2-cmd {
+		pinconf {
+			pins = "sdc2_cmd";
+			bias-pull-up;
+			drive-strength = <16>;
+		};
+	};
+
+	sdc2_data: sdc2-data {
+		pinconf {
+			pins = "sdc2_data";
+			bias-pull-up;
+			drive-strength = <16>;
+		};
+	};
+
+	sd_card_det_n: sd-card-det-n {
+		pinmux {
+			pins = "gpio126";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio126";
+			bias-pull-up;
+		};
+	};
+};
-- 
2.18.1

