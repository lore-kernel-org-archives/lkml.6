Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCE0C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14DC20779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CmP5/V8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14DC20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeJVQCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:02:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34929 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbeJVQCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:02:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id l17-v6so19486399pff.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 00:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+Y1K5QL8FD/m4PSkMA+x2dLfylUdGuE/onAnmlwpJnk=;
        b=CmP5/V8nV0BmV0qLAy7IUWvAfBz0CnB7OzWcIm1CAs+IxuBnpYk3LM1C07hem02BAM
         Hafk97ZJew6AgGljwpg4SsBYiNVWIHKwTbNjTrULZEacFdAWpZUmpsuLJ2CTTJXcVdqK
         UwOj++E/noEmmUkXt5f1YtoNcs0j1RP5p/jeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+Y1K5QL8FD/m4PSkMA+x2dLfylUdGuE/onAnmlwpJnk=;
        b=e3obFVVynpGURZsqMc2nUw6QP/ao5fz1cq6R7YgLhZlrt5Ko2U40Nzl+5l48aG1Q5N
         MMZuSJ3xs03e3J1gLP7cHo/1zJ4z+0mil/ej6uPBaEegslgdQAW4QVc7TD1L4komistC
         PSPoElHC0bJBdzyE95rSDFX/kPKx9B+D8YDcU6/r1fRpQhOXCPrS+JXCnKy4HAUfNBeO
         buZbEJTkjLe7tGiXJqKs4mE//6RnapjJ1xc7JA0Lgq5kDkI4bVdMeCYsKAdsRsTq3WmO
         iH2wFSzlTIRYeiZXM6uUMmFF1yPRhwTcNFLOx/hmYNIefjYhHJgL/VF3zTXiBt9NcHsZ
         P5RQ==
X-Gm-Message-State: ABuFfoi+lRpotvgt7cHqia3YEdQBkHoCZg6dACCtckGtzHfKN/byWQ8S
        euV05or/KSuFHlbTSHUZsqwCYw==
X-Google-Smtp-Source: ACcGV63p/xvvH2zZNrMpgeIRCraWaYYHW3vg3mQ2MHve2ZADO/RHqVo2LcBpBVyYbAJcHWFsdXe2Cg==
X-Received: by 2002:a65:47cb:: with SMTP id f11-v6mr42826682pgs.166.1540194282691;
        Mon, 22 Oct 2018 00:44:42 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d186-v6sm43704253pfg.173.2018.10.22.00.44.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 00:44:41 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: [PATCH v6 5/6] dt-bindings: power: Add Spreadtrum SC27XX fuel gauge unit documentation
Date:   Mon, 22 Oct 2018 15:44:01 +0800
Message-Id: <14b947c6195133ed93cf0302b1575c033c4ccf04.1540189330.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
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
Changes from v5:
 - None.

Changes from v4:
 - None.

Changes from v3:
 - Add reviewed tag from Rob.

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

