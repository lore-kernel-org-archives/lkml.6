Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36750C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBF82087D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGpW6USU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBF82087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeJOPzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:55:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41144 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeJOPzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:55:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23-v6so8785334pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 01:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MD9VCbYMsPzCy5AruI5XWxwxrKvHTLzOyYm9oZJSb+U=;
        b=GGpW6USUoWrm+IxxdX+3dxILIV55heU2m86aR/lvjDymMg4dgdGDQ+En9vhfgA6iYz
         l+z8m23H9jaCyb5JKn3QR1O4EcFNyQQfMNlTgs/YQIH3W/d4v+mYig3FXazMmv7zUjn8
         8S3r+fR69tH7bDWwqWUWVkAsLWBtVWexDI1F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MD9VCbYMsPzCy5AruI5XWxwxrKvHTLzOyYm9oZJSb+U=;
        b=Rip56zflYQ1sZzNQMxFW9ePCzoK8XiM+E+elzcVsd9T34iUxHklKE1TddWxvPDDzCV
         rrKLPaSdKwhXEHyb8HFwNOnFcK4EmLKQ/YOOIsZhPTaqyBl7b5xAh+p/u6sNPphxbvem
         n62Nq9BQToROQtQbzS1OVqykzZqSPmCU1agPZBAg1A5Zt3vgGWgJCd3jwx9NYml/Y/QG
         IzG8UHUmjJya/qeew+2eTD7ORH6973xoa3BOH18xgN5StBpGd5Uhv2uKfwijn4TLjp2F
         Kw8D13yjep+F1xvkuxO/FjDlB/QQFWpYp5wijGNRADZoiqCVTxtP0XF9RKTj6AwD7I7Q
         /kCw==
X-Gm-Message-State: ABuFfogeqmf9YkHiaNuR0KIfYuGk/SQqwB0jw8sOOrxgTSWXXF+pt40G
        g1NSrzwy01+HGZLA8ax9nN0j+A==
X-Google-Smtp-Source: ACcGV61XRsj7Cvlc31anKOp7bq8opAoUL/ofHdIhb7MUeuOU0rfU7RmZ8vfuDnS/sgrAVMLwMEgEHw==
X-Received: by 2002:a63:3c46:: with SMTP id i6-v6mr15021222pgn.286.1539591053940;
        Mon, 15 Oct 2018 01:10:53 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m27-v6sm16375855pff.187.2018.10.15.01.10.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Oct 2018 01:10:52 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: [PATCH v4 5/6] dt-bindings: power: Add Spreadtrum SC27XX fuel gauge unit documentation
Date:   Mon, 15 Oct 2018 16:09:24 +0800
Message-Id: <3aaeca63d2282d5dea1cbb2dc716cc736b0b0cfa.1539587217.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539587217.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539587217.git.baolin.wang@linaro.org>
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539587217.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539587217.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding documentation for Spreadtrum SC27XX series PMICs
fuel gauge unit device, which is used to calculate the battery capacity.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes from v3:
 Add reviewed tag from Rob.

Changes from v2:
 - Add reviewed tag from Linus.

Changes from v1:
 - Renamed GPIO property.
 - Use standand battery properties instead of 'sprd,inner-resist' and
 'sprd,ocv-cap-table'.
 - Remove battery node's description.
---
 .../devicetree/bindings/power/supply/sc27xx-fg.txt |   52 ++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt

diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
new file mode 100644
index 0000000..98a2400
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
@@ -0,0 +1,52 @@
+Spreadtrum SC27XX PMICs Fuel Gauge Unit Power Supply Bindings
+
+Required properties:
+- compatible: Should be one of the following:
+  "sprd,sc2720-fgu",
+  "sprd,sc2721-fgu",
+  "sprd,sc2723-fgu",
+  "sprd,sc2730-fgu",
+  "sprd,sc2731-fgu".
+- reg: The address offset of fuel gauge unit.
+- battery-detect-gpios: GPIO for battery detection.
+- io-channels: Specify the IIO ADC channel to get temperature.
+- io-channel-names: Should be "bat-temp".
+- monitored-battery: Phandle of battery characteristics devicetree node.
+  See Documentation/devicetree/bindings/power/supply/battery.txt
+
+Example:
+
+	bat: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <1900000>;
+		constant-charge-voltage-max-microvolt = <4350000>;
+		ocv-capacity-celsius = <20>;
+		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>,
+					<4022000 85>, <3983000 80>, <3949000 75>,
+					<3917000 70>, <3889000 65>, <3864000 60>,
+					<3835000 55>, <3805000 50>, <3787000 45>,
+					<3777000 40>, <3773000 35>, <3770000 30>,
+					<3765000 25>, <3752000 20>, <3724000 15>,
+					<3680000 10>, <3605000 5>, <3400000 0>;
+		......
+	};
+
+	sc2731_pmic: pmic@0 {
+		compatible = "sprd,sc2731";
+		reg = <0>;
+		spi-max-frequency = <26000000>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		fgu@a00 {
+			compatible = "sprd,sc2731-fgu";
+			reg = <0xa00>;
+			battery-detect-gpios = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
+			io-channels = <&pmic_adc 5>;
+			io-channel-names = "bat-temp";
+			monitored-battery = <&bat>;
+		};
+	};
-- 
1.7.9.5

