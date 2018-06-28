Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C99C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB03C276FF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3ouznjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB03C276FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030370AbeF1SMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:12:15 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37948 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030372AbeF1SMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:12:10 -0400
Received: by mail-pg0-f65.google.com with SMTP id c9-v6so2815442pgf.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lyThY3JcGjNBnO+ReNP/irIxhSH65Nk/lsrkpXUda8k=;
        b=g3ouznjklWPZBbvmAyfrg5Y9KNRcCU7d+E1Az0Xu8Uks0RiSjLfwRPMGjH5ztikR64
         OekdtDexa5DYVRyJX09evNTIHcJ7utN3w8FwAIqnMnM6ptYWnKs2vFNhjvRSqHNe8tOE
         ulNKcF5bz2zFtoIvoTjOp1p/rpwnUHD1TP/AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lyThY3JcGjNBnO+ReNP/irIxhSH65Nk/lsrkpXUda8k=;
        b=AXkn9UlMMZ5XmjKGfTfWyLzJtJ7wqHgDLmkMfpEuEVojssHbH83KYw6es+jC8v1vwM
         C9qtdai5BzZFEawZ1QAqLXzW4tBWRHRGtKpWSLmllvA0FUQU7lOq0TpoYosiK2kjKMxj
         brXiQrRgH4qXf2mHS0cb9iFq8kyOSgWq1xRTD3xJyOewpXB1aTnTOVebnmSdzE9up3S3
         Jb22F3k7rfKhT5gZ0eLLnM2A5usQQEqFEnMMkr28Fr7G3CbLo953LdfqinCNwoPw5iQr
         8OC0D58tsPIojDN5Ja994PYHd3sm4zVRGuZNglY2oFlYBd2v2ZnYW5k0hjJ4HfFu/vry
         ZIhA==
X-Gm-Message-State: APt69E1EeWrNmOqn88PMm3O3xLsIKTVU7EHxXOW1rddOf3Iq+XWq6X1N
        r44FR9isnVgVWJ2C8QS2A7Vs
X-Google-Smtp-Source: AAOMgpef52MdCQV91m6Szb+YDVk20us3pyeb6Tb8otCS1t2MYVkXCCQEkhSi/1FSUtTcp93U9/QJ4w==
X-Received: by 2002:a62:c882:: with SMTP id i2-v6mr10884247pfk.13.1530209529729;
        Thu, 28 Jun 2018 11:12:09 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7141:9f8e:c1c3:7dd1:e694:9dc2])
        by smtp.gmail.com with ESMTPSA id o13-v6sm13293132pgn.93.2018.06.28.11.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 11:12:09 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de
Cc:     linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/6] arm64: dts: actions: Add Actions Semi S900 I2C controller nodes
Date:   Thu, 28 Jun 2018 23:40:38 +0530
Message-Id: <20180628181042.2239-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C controller nodes for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 60 +++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index 7ae8b931f000..6f7b89edbe4d 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -174,6 +174,66 @@
 			#clock-cells = <1>;
 		};
 
+		i2c0: i2c@e0170000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe0170000 0 0x1000>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_default>;
+		};
+
+		i2c1: i2c@e0172000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe0172000 0 0x1000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_default>;
+		};
+
+		i2c2: i2c@e0174000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe0174000 0 0x1000>;
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_default>;
+		};
+
+		i2c3: i2c@e0176000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe0176000 0 0x1000>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@e0178000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe0178000 0 0x1000>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@e017a000 {
+			compatible = "actions,s900-i2c";
+			reg = <0 0xe017a000 0 0x1000>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		pinctrl: pinctrl@e01b0000 {
 			compatible = "actions,s900-pinctrl";
 			reg = <0x0 0xe01b0000 0x0 0x1000>;
-- 
2.17.1

