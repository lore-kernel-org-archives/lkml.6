Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72911C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DDA2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gqu9i8cE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DDA2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeK2JiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:38:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37598 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbeK2JiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:38:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so2993105pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 14:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KU7YR+dMFcDShtWfE5CNdmGOqYjteSkR+jWwR0YcA2U=;
        b=Gqu9i8cEZK6Zr5+TLSZlrj77KGqvVzsD3pFBHQZzvVlMvLQrh31rHiLajblRQlsNhn
         FevRX/sn9mjiYaypvFTvsOXslCeAZAsi6Tyb1YKlXhq8NMNdnLjEvz7nwxxmJV+5ajlY
         aX4PzcMu0auu/05ZMRQ3Qbmf9Ok5lOejkgnt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KU7YR+dMFcDShtWfE5CNdmGOqYjteSkR+jWwR0YcA2U=;
        b=n5xJKnaFKCAGMQgsZQaRn/DWk7msP2pft4CGMCxXtl76NdjR6MSP1xmKl3+PH6JvGh
         UcgpyqQU8/nIXXMh5xF7bB4W43fHiMAWLlHLULeu35jWVprmqJmBzpb0eKen5NykpV3O
         xM9HD9DUJtZWq5LMx4j4N7Dim+P8Rx+/s/h9wxdQBkoOD7FYPcufvIVzHLfQatotjdZH
         g7Te6eOaqm9ieuJgE4tJJJC3zvLvWWsviASJAlZZyr9rFqsu0SGSjZTa5LuMRkgFeK2u
         hkQ/sshzHnJwGYh9l3vYk8xGKhZvfJjdj/DKx4URehhrjGDt6mTQChXn90t6ZuaTxnAX
         n9MQ==
X-Gm-Message-State: AGRZ1gK96aC7VKcmzoHzoeknaIdCGMJ8bWOIWnvckcSeSiBQT1WO39Ko
        katfdMhZwcGnaXE0OqIucBJ/Ow==
X-Google-Smtp-Source: AJdET5ft3ebWxDj7BS6t0nJLhzG7j5XOmR7XOH94siS13cqp/2jUZoTQ1jNHsfoHrOAoD/a8O7eXmg==
X-Received: by 2002:a62:d2c1:: with SMTP id c184mr39660614pfg.248.1543444493823;
        Wed, 28 Nov 2018 14:34:53 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id y26-v6sm12364813pfi.123.2018.11.28.14.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:34:53 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v1 3/3] arm64: dts: qcom: sdm845: Add SD nodes for sdm845-mtp
Date:   Wed, 28 Nov 2018 14:34:28 -0800
Message-Id: <20181128223428.177313-4-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181128223428.177313-1-evgreen@chromium.org>
References: <20181128223428.177313-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for the micro SD slot on the MTP.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 53 +++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index d667eee4e6d03..b85e9fed14845 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sdm845.dtsi"
 
@@ -348,6 +349,18 @@
 	clock-frequency = <400000>;
 };
 
+&sdhc_2 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdc2_clk &sdc2_cmd &sdc2_data &sd_cd_odl>;
+
+	vmmc-supply = <&vreg_l21a_2p95>;
+	vqmmc-supply = <&vddpx_2>;
+
+	cd-gpios = <&tlmm 126 GPIO_ACTIVE_LOW>;
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
@@ -444,3 +457,43 @@
 		bias-pull-up;
 	};
 };
+
+&tlmm {
+	/* It seems that mmc_test reports errors if drive strength is not 16. */
+	sdc2_clk: sdc2-clk {
+		pinconf {
+			pins = "sdc2_clk";
+			bias-disable;
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
+	sd_cd_odl: sd-cd-odl {
+		pinmux {
+			pins = "gpio126";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio126";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+	};
+};
-- 
2.18.1

