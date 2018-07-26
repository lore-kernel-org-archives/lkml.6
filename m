Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB6DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE7020673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z77Pxt0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE7020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbeGZREb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:04:31 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43003 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbeGZREa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:04:30 -0400
Received: by mail-pl0-f66.google.com with SMTP id z7-v6so1001364plo.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 08:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2pWiTqMDsoMOxuo1kybX0qJyORiAw5vulAq9JPZVfNM=;
        b=Z77Pxt0H3glitbvPEMsOOOn8IpWEja4kbrhcyZqQ5ISstEhAX421O8kVAJ5BtrTOmM
         6ml/WG9cyIu6ilgMUzLJhPPdpKBd5U/v05UCHcgPsLfc4mo1xOt2MPYJ4btHB9lNorYs
         sYGSQxxRFpLgGUeXYiyCnPAqqJGySKZP2LG2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2pWiTqMDsoMOxuo1kybX0qJyORiAw5vulAq9JPZVfNM=;
        b=NPKNKC9tUtKOHVOgnSU7a+wjNr2B0iyeK6JafqeyBCNOxLqugB17fiYIhK1MMdkQZd
         PxxFeAekakR8dXilWpld5SPEWXtLzDAZEsLGhQjxd+Nk4r8cAT/khtKEErTsFKXc6o0e
         5AmezyG6MvACjY17ZnJeue3nXyLl7SWTG+Vs+Mbft7tm0eUUs/UlN8Qc1uoCLKJ4Fi35
         j1hKsNj5MHbKmX6kMdiTUTtunDuyaggRlV/vDtjvo0BH8TNVAr0LV/U/equ1hFBXqxHb
         YaUVikZC1KGi3dJHUa8a2TMbfUJz9cwp3GfC5iBmp0GeNE3oM3hbsmgkTrL46ebwkyOn
         OL5w==
X-Gm-Message-State: AOUpUlFqo3YGEjOC8kMYtHDONOqb7YVayisUsgiBw2YLscMEcmx/D0zH
        510tdW+6AY07sjS1Xhy94ciNQghBPA==
X-Google-Smtp-Source: AAOMgpdDby6R8P0jth7o91sdFyj9RJTsMzNDH3vMQ7+Vo8dVdihJUzKWK7hTY0wQZtGFlwHLvwjtAQ==
X-Received: by 2002:a17:902:8604:: with SMTP id f4-v6mr2484651plo.225.1532620025508;
        Thu, 26 Jul 2018 08:47:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:628e:aef6:6d51:3501:dada:e06d])
        by smtp.gmail.com with ESMTPSA id z11-v6sm3755322pff.162.2018.07.26.08.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 08:47:05 -0700 (PDT)
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
Subject: [PATCH v7 3/6] arm64: dts: actions: Add Actions Semiconductor S900 I2C controller nodes
Date:   Thu, 26 Jul 2018 21:16:00 +0530
Message-Id: <20180726154603.5089-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726154603.5089-1-manivannan.sadhasivam@linaro.org>
References: <20180726154603.5089-1-manivannan.sadhasivam@linaro.org>
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

