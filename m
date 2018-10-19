Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609F7ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CBD21479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4RJBdZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CBD21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeJSS7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:59:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42993 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbeJSS7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:59:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so15609350pgq.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 03:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Yg2NqsPWyEaCTubWb3spqrxS0nBIYblv+mmU9f9ac4E=;
        b=U4RJBdZWaiebK1+vfkLJ7ia5s0uBdGM/QAgsa2iThK6v72RmukPsnB+tGAE9qcB3FX
         FBTRwl8nAI+LEg20o0enhqQxmN/IPEZ7CZHdyflZRK/xFVB0Ko2QR+eP3uO82dbM0+I6
         DATGs9wF7PCIhCOvvTpxYynyJjwc2CNzsZW24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Yg2NqsPWyEaCTubWb3spqrxS0nBIYblv+mmU9f9ac4E=;
        b=Z2nFUk50AVpuN44ZwJhtOZ1xahBPR133ftTqDBCRrXaMho5eXHUnUvlY6tgD39WWh8
         LjHIhLJS518/mfYlkvgn5iVtjriVfa+8Z4gZcvuTDrx2v6aYa1Yd+jWaBvqI1Y2AdgYt
         UcfqKCEReLTy4tluA1N6RYyOdLt3XdAJtmFiSDybNXB8NbgsZr6r1zxSypJj6dTF585k
         n4FhLgB7ShnfLqm+M1cyD3jjmUS1HvWCggIlNKN1QiH0hwM5ejYhSEvHp7VL7isvhWyP
         ssSDywSOeoc7QXzvWrn8Rl9RsxQ586nBtdScMs2nj9A43sdW7HscE9Bu8YMvcaxN9ll/
         0Crw==
X-Gm-Message-State: ABuFfog1ArSk95vyWbeQbpAl1+Cy8ww1CxE2WEDj5rSs+UIkMCofqksO
        67noxL1CG0roi6afUelWyMZ0TQ==
X-Google-Smtp-Source: ACcGV61jfxh4or6Q7y8LTLyRlr93vHXNvRRbvAnLMu25knEMJX3iAntAOjKTT41l72C9JQNJyaBfxA==
X-Received: by 2002:a63:5949:: with SMTP id j9-v6mr32169578pgm.210.1539946428500;
        Fri, 19 Oct 2018 03:53:48 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m67-v6sm54918pfm.13.2018.10.19.03.53.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 03:53:47 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: [PATCH v5 5/6] dt-bindings: power: Add Spreadtrum SC27XX fuel gauge unit documentation
Date:   Fri, 19 Oct 2018 18:53:14 +0800
Message-Id: <14b947c6195133ed93cf0302b1575c033c4ccf04.1539915051.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
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

