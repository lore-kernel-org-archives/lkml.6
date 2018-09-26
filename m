Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837DAC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1FE21480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AoMmcS17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1FE21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeIZJKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:10:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37984 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbeIZJKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:10:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id r77-v6so7885074pgr.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 20:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FM8t3RKYN0d8fne2p5QSPiCux/ygI5pU4yXE2CVZ35c=;
        b=AoMmcS17knMqVy4/yoHWQjtYTLz0BAlWK9g1N7om2VXmK119J+SmvPNrecEUMloGts
         1aD33GyqIfedb6WJz3pCvKY8ozM8PPHmkuSi6pLTfvugG37HIbcM8X+2hvOczitJT8/O
         CgTkJqg1a3uJpEtvmgKyTXzAGabEvWAVez6GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FM8t3RKYN0d8fne2p5QSPiCux/ygI5pU4yXE2CVZ35c=;
        b=aYETls0Bs2sKUGemaY2t+2iiG33o/1lkJjV/bLopl9zZWVf5qgphmn2TviJqphsDAz
         B4yCP7zYnrBTsV85c6CzWCJX5w1p/JHxdnenPS2J8uQuvABMpouxksxVGysWmZcY6qUg
         lGXsdy+ipiyMlMU4z5EczqTINrEZmZyB89zJv0BeKPDe59CNeCoBPp4Lj3qSMDBoMuNW
         GeDQL+GrnAxXjLSRhadFui5hFTb0nr9Uru6q+mfe2JbhE5Q7LijQd6wyqAFL1rDKVnyy
         jAYurdi+ZVzEBE+w9lFqH37AXlrAi9tPMbbrajYI4EF8riQSpSue2GOLpybfWS7WTayK
         y/OQ==
X-Gm-Message-State: ABuFfoiINWRwLR55sJ3T7V86Tew49KmsvJ9OwGzp4uSm+rDA6vs+kheS
        d7QpWwOB79CN8wZTJhw5ET2pIg==
X-Google-Smtp-Source: ACcGV626B01welFt9UKiusUPlkm8swMmRAsY+57cTRcvtfviuAtNQipjVrcgyoYsNr/mFPLSiDFWcw==
X-Received: by 2002:a62:71c4:: with SMTP id m187-v6mr3982624pfc.232.1537930805186;
        Tue, 25 Sep 2018 20:00:05 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s13-v6sm5471703pfj.105.2018.09.25.20.00.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 20:00:04 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: [PATCH v2 3/4] dt-bindings: power: Add Spreadtrum SC27XX fuel gauge unit documentation
Date:   Wed, 26 Sep 2018 10:59:13 +0800
Message-Id: <b4b36b7b54cc227e6e7f14c314b4617863a205f5.1537930252.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
In-Reply-To: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding documentation for Spreadtrum SC27XX series PMICs
fuel gauge unit device, which is used to calculate the battery capacity.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
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
index 0000000..b161468
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
+		ocv-capacity-table-temperatures = <20>;
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

