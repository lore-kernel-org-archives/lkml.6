Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2493ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8BC20858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BE4ihFO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8BC20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387847AbeGWEkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:40:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45408 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387747AbeGWEkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:40:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id f1-v6so11207447pgq.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 20:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2pWiTqMDsoMOxuo1kybX0qJyORiAw5vulAq9JPZVfNM=;
        b=BE4ihFO4aBBcTlIPFt4eZZl2hJFAlkqtafcVsO+utEaBlOmoVcDvQg+wMN3lL73fgo
         xbHcqvc29wVBMsg2WCG7KOP9+Prs/OBs1rHbvRui/F+S5bYgrvsf5PG7wvqTmhnQ1kdC
         eOjGKcd5nQ7P10MivU49a7LCeQfUKcks4aGWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2pWiTqMDsoMOxuo1kybX0qJyORiAw5vulAq9JPZVfNM=;
        b=fxr2nTLN9T2tZuz/XDYaIKFwkSNO7cxFEG4VSYc9OMXUirYzUq+e1i3UjZEmpwE9Dk
         CyTDDB5j5RsaaMklXiv/uGAm6r4d0OKD+SvMdIyLqU4cBMw7BmiNUuaJyHCsjIuxnfyb
         LoQGPYKDVCEffr/yF7BNKUkUM6qFoTryWqcjMb8URoWLbOJUNAbGTAFg35MyOObSU3wp
         RQBwyhhUamPshxJeZ9YJfwSHMIVpxzcOfEsX77o11A9qADscF0hxilnOAoZbaytEhZVR
         TYT7866VUtPrSKFqyYZJm+1B1DyrHsjRENutkug9E6zy75w2fxBAcvE50RtBUt+7XPRF
         BSaQ==
X-Gm-Message-State: AOUpUlEJhmWjXPExJORG79thGFyozo988KKMWF7SC5TdU80EPSbdmWvc
        PlZ2d2PQVmqaKE4rMGpuiO9/
X-Google-Smtp-Source: AAOMgped7PbTH4ILi+De70KCoTlqAKjTUhSzP/VB4vDY6RHLpb/MSGEtI7F8Sgqfe+m4DRWTDw94NQ==
X-Received: by 2002:a62:930c:: with SMTP id b12-v6mr11468840pfe.193.1532317294392;
        Sun, 22 Jul 2018 20:41:34 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:802:a98c:b568:c01f:49a2:2aa5])
        by smtp.gmail.com with ESMTPSA id s184-v6sm11340248pfb.56.2018.07.22.20.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 20:41:33 -0700 (PDT)
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
Subject: [PATCH v6 3/6] arm64: dts: actions: Add Actions Semiconductor S900 I2C controller nodes
Date:   Mon, 23 Jul 2018 09:10:22 +0530
Message-Id: <20180723034025.5763-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
References: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
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

