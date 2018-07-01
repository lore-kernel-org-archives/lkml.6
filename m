Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F31C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E0223C5A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSaf4F6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E0223C5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934164AbeGARYP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:24:15 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35911 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933919AbeGARYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 13:24:09 -0400
Received: by mail-pg0-f68.google.com with SMTP id m19-v6so2541949pgv.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 10:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2pWiTqMDsoMOxuo1kybX0qJyORiAw5vulAq9JPZVfNM=;
        b=SSaf4F6Z2VztB2U2o2Td+iRoxjnrv2qrX2AvClFBTK8cZQnx+Ph5nFxqIAInyxUGIw
         qgpeRreDSU+rQxiHOI6m9xOKDCwaZQEIVGhrBe0bKuEtVEUO26sA1V4SjcfaYf0awWE3
         TlSvi3rar/9kAnfLu9MEOuROJm4ENStgyqNAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2pWiTqMDsoMOxuo1kybX0qJyORiAw5vulAq9JPZVfNM=;
        b=HkKp0ayr73ezd6+xh0shYGscATYZdtZsj3SaaRF2bDBH8hiQ+86klxPZ6LjT+aseQH
         0+UGxJW+Bpr5KczL+boWa8fO6cF2pF/Eqlhpm0P87zMyRyTdBi3HKjANO+2/0TabFkbk
         SVUhP2fyjMhGvwZWQ6ns95dxvbLACsojCg8/rVge05iRCuinY3lA4/36DfOr6kMARzxi
         BIkgksqMR40m8c0SqcmmMZsQ02zKq/UPA1CvUZPH0V9dV0ly2sa9PN8AvEGR3ufxbNTf
         GJuH7eQind5++N6ZTPGhjBGKrISphcH7JYWZJ0YaMc+7yr6yY97sP84ZEfMDVrzxwymc
         KRlA==
X-Gm-Message-State: APt69E2IdU2JunNTeCYadRDlK7z0anvcvEnNuPeyR8KwcZHcACR2uEkm
        rbVU/AzQxY5f4zoZfEpQ93Nn
X-Google-Smtp-Source: AAOMgpftvZiwcYGPly8WK95qgBuW0iLsTtQwaX8zvr635tL4jz6dW6bpeJ7EV6PGam1Dx9bzeHzOXQ==
X-Received: by 2002:a63:b02:: with SMTP id 2-v6mr862985pgl.301.1530465848846;
        Sun, 01 Jul 2018 10:24:08 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:900:ea77:2c06:3367:1893:796])
        by smtp.gmail.com with ESMTPSA id f10-v6sm17989836pgr.30.2018.07.01.10.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 10:24:08 -0700 (PDT)
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
Subject: [PATCH v4 3/6] arm64: dts: actions: Add Actions Semiconductor S900 I2C controller nodes
Date:   Sun,  1 Jul 2018 22:53:02 +0530
Message-Id: <20180701172305.15663-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180701172305.15663-1-manivannan.sadhasivam@linaro.org>
References: <20180701172305.15663-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C controller nodes for Actions Semiconductor S900 SoC.

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

