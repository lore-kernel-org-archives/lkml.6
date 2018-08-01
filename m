Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCE4C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78ACD20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3jO5iAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78ACD20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbeHAFXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 01:23:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45908 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731877AbeHAFXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 01:23:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id f1-v6so10086795pgq.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 20:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C4k4BFBDKpYNBDQHAjAavWfPFuGdz6CBzaB97h2SixQ=;
        b=B3jO5iAJyXtuXz/6Dh7j4sZXgl6BYvMVnCF9len0iLW1ZLFiABrdS9rYasN7rl8rD1
         z5JmMphaXkb6kh4Ww7sLx6Ss8BqkSx/MhDZa0umbEKPz7UuWFdTrcogRVOfrEq4dwY2c
         7MsHantHxHq/VseB7kz4jlOuQAY0rKn/LiwpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C4k4BFBDKpYNBDQHAjAavWfPFuGdz6CBzaB97h2SixQ=;
        b=dQls12Rm3x23Vti+ulecN1MvxrqcjcXDDIsbB6wut8OocdmSsrJ6dIOnh52sy/3J/+
         jlX9wDDMEYo0DZlPUZeiyO1BuQZBsI9vvCGn5XwgUiD2rbv0u98xO++LPVCmORgeMvVn
         iPfEr1iXN+R7Q+hSt8HqBApXqTUHg6SQVixXYBBHnWFwgKeBrvMN34CRn09/5/Z8wRa4
         Pp7YG4/mj0z/FGgQnL/RbT6cKQR3QwRjBDx9UubZmApVz6mwn3SRBg2Fodwe3INm4Y3Z
         8kUdXJ5HtoSgvNPC7qyz/wAsb3yoMbmkZdxAG4cZbeTNYo47TKR0z20LInB9ljG8MO9F
         kuCA==
X-Gm-Message-State: AOUpUlEgY1awwZ2MxcSeENW77TESbOg+2+EfURzd0vyYLIa6FPq1yP4T
        czEKEeDW7CPUqw2SSOQIVSXM
X-Google-Smtp-Source: AAOMgpfFum25jloCR2Mj9XauVQt3WJON5TUFIwY8TmTTPQBrR7yQso8qjVK7EWupz3vWpyt21kQKkw==
X-Received: by 2002:a65:53cb:: with SMTP id z11-v6mr22703811pgr.218.1533094806359;
        Tue, 31 Jul 2018 20:40:06 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:730e:f0ae:ac4e:9cdd:28a2:4bf9])
        by smtp.gmail.com with ESMTPSA id d19-v6sm34879545pgi.50.2018.07.31.20.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 20:40:05 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        afaerber@suse.de, robh+dt@kernel.org, lee.jones@linaro.org,
        arnd@arndb.de
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 02/10] arm64: dts: actions: Convert Owl SoCs clock-controller nodes to syscon
Date:   Wed,  1 Aug 2018 09:09:07 +0530
Message-Id: <20180801033915.15880-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
References: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since clock and reset management units are sharing the same memory map,
Owl SoCs clock-controller nodes needs to be converted to syscon so that
the corresponding reset drivers can also reuse the same memory region.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 12 ++++++++----
 arch/arm64/boot/dts/actions/s900.dtsi | 12 ++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 59d29e4ca404..a57f54587164 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -160,11 +160,15 @@
 			status = "disabled";
 		};
 
-		cmu: clock-controller@e0168000 {
-			compatible = "actions,s700-cmu";
+		sysctrl: system-controller@e0168000 {
+			compatible = "syscon", "simple-mfd";
 			reg = <0x0 0xe0168000 0x0 0x1000>;
-			clocks = <&hosc>, <&losc>;
-			#clock-cells = <1>;
+
+			cmu: clock-controller {
+				compatible = "actions,s700-cmu";
+				clocks = <&hosc>, <&losc>;
+				#clock-cells = <1>;
+			};
 		};
 
 		sps: power-controller@e01b0100 {
diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index aa3a49b0d646..d239033f9599 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -167,11 +167,15 @@
 			status = "disabled";
 		};
 
-		cmu: clock-controller@e0160000 {
-			compatible = "actions,s900-cmu";
+		sysctrl: system-controller@e0160000 {
+			compatible = "syscon", "simple-mfd";
 			reg = <0x0 0xe0160000 0x0 0x1000>;
-			clocks = <&hosc>, <&losc>;
-			#clock-cells = <1>;
+
+			cmu: clock-controller {
+				compatible = "actions,s900-cmu";
+				clocks = <&hosc>, <&losc>;
+				#clock-cells = <1>;
+			};
 		};
 
 		pinctrl: pinctrl@e01b0000 {
-- 
2.17.1

