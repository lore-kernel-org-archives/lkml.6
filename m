Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CFAC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2278F2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eLuO/mrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2278F2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbeJ2Sbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:31:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37315 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729786AbeJ2Sbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:31:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id bh10-v6so3537019plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vbqz/FFQSiZYMz4Ct6V+6er7vQMDEB5XowGv/dcExWY=;
        b=eLuO/mrFrZhhfoTh7+ecSofPtV9INZyKge0eYhB0pd+HlMYW0bFQAN/PIf/pJIqKN9
         73CuoW05pQJZ4MfnyiA8r0ZAk0pyRiYpGFUV0jbJuYTi7L90N23UIpQknS7+0GrD6XK/
         XtDCMn04D+SenZUROSTtA8xPnONcQWNh82CWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vbqz/FFQSiZYMz4Ct6V+6er7vQMDEB5XowGv/dcExWY=;
        b=PWHMQaRG1XgNTuFA0Z1zSKp3WNjB5x1CqGRmbb9JFprW1Y8cnaMzuex5VwkPX/8SXD
         4EYf9lUshizFAkRwFlj4Vz9Ih9BYr3SbSm493xJkELqk7J3sHZ8PqnTCAmKhPhbxi571
         fAQR+VwjNdEtBFMwXeltCiBWZUTFgLXUGPpP2mOMR4du/e4fmegsPWp7/bI4AWx9DL8+
         /QbJ5+BK82DYiScvfUoaYGy2SzftLCNoE6E1jKgibHVayn9OOve23reeCbBeEOy4JH6x
         BVRHmY8EJCP6bRIvokr8B15QqJfp7PLUz6nKzv29/tb4dRBADhwI6875Yf1Dygtc7h5P
         uphQ==
X-Gm-Message-State: AGRZ1gL/l+62278e/2an9opBYzIINJNJix18V042Fz/5I9EK8IpoVP5R
        X4c2CWBiISDfAX7mary0uif/
X-Google-Smtp-Source: AJdET5dltGBViApNzdW4O3zaw77ibbuqkNGO053tu32LBaUFE/QrVgZH4jUkL03KBIHWlQUtprcYVA==
X-Received: by 2002:a17:902:bb96:: with SMTP id m22-v6mr13451926pls.117.1540806228450;
        Mon, 29 Oct 2018 02:43:48 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6091:9d4b:9d82:66b9:3ee6:ffac])
        by smtp.gmail.com with ESMTPSA id b62-v6sm21162056pfa.159.2018.10.29.02.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 02:43:47 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     robh@kernel.org, heiko@sntech.de, ezequiel@collabora.com,
        xuwei5@hisilicon.com, michal.simek@xilinx.com, pavel@ucw.cz,
        andy.gross@linaro.org
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        koen.kooi@linaro.org, nicolas.dechesne@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 5/7] arm64: dts: hisilicon: poplar: Standardize LED labels and triggers
Date:   Mon, 29 Oct 2018 15:12:43 +0530
Message-Id: <20181029094245.7886-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For all 96Boards, the following standard is used for onboard LEDs.

green:user1  default-trigger: heartbeat
green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
green:user3  default-trigger: mmc1 (SD-card)
green:user4  default-trigger: none, panic-indicator
yellow:wlan  default-trigger: phy0tx
blue:bt      default-trigger: hci0-power

So lets adopt the same for Poplar, which is one of the 96Boards
Enterprise edition platform.

Due to absence of WLAN and BT support, corresponding LED nodes are not
considered.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
index d30f6eb8a5ee..32716c96b457 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
@@ -35,30 +35,31 @@
 		compatible = "gpio-leds";
 
 		user-led0 {
-			label = "USER-LED0";
+			label = "green:user1";
 			gpios = <&gpio6 3 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
 
 		user-led1 {
-			label = "USER-LED1";
+			label = "green:user2";
 			gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
 
 		user-led2 {
-			label = "USER-LED2";
+			label = "green:user3";
 			gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "none";
+			linux,default-trigger = "mmc1";
 			default-state = "off";
 		};
 
 		user-led3 {
-			label = "USER-LED3";
+			label = "green:user4";
 			gpios = <&gpio10 6 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "cpu0";
+			linux,default-trigger = "none";
+			panic-indicator;
 			default-state = "off";
 		};
 	};
-- 
2.17.1

