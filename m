Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1447C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2122084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jS5l+EQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2122084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbeJ2Rta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:49:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46914 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729499AbeJ2Rta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:49:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id r64-v6so3656841pfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TvxtMQMr+s0zlpORARx/dbFxpLuRgUmSr0bYiw/Dal4=;
        b=jS5l+EQUy3AoLDQPMcTl0MNhVvcK6XiZ9hCvRysSZQ/QF8OmiOT4tzM7upYKpQuwfd
         LvbKRHgkPkmQswrQA4HmgtwBc1OadC6/UFL91j/04/2muix7bM0ntruw1sIbZtx3tIfY
         KYYOU6dGCOKPXTwspZw4tX3xmJgKb8EdYZgOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TvxtMQMr+s0zlpORARx/dbFxpLuRgUmSr0bYiw/Dal4=;
        b=V9ZncRiIm3S158qUNupe1IuwFqxfEYqv/Mt2ME8LZk9bqvb9N8ddeOTdSPLzwUZ9jh
         l+UBIrIjeiDHqNpVGtxzPzpzsEndZ2vdUMweOTApSgu9xqQZvLJkMMPPtHDEAtYVqOuR
         GsKJFTSySnbVRZu9hnUm47evf/QbauctjO+NzXr9y6hqNJCMRwFzRP73Eeokg+U2aO2W
         Oig0sPynim2IlnennMCR4jxDjz4KpiNVcdzzEYx9JMqIV+Ndja0TLYDOYOJ7FdtGeOof
         Qc2jy9mHKAxKoRXr2t8aIf7JiZ0xw7ijwiCD1Oga61i/6v5c5gVR/YomoYS0/CsKFjMV
         mhpw==
X-Gm-Message-State: AGRZ1gIk0fJuS37MfpLnlW0a6rM4T57g6MDqV0vw5+FAaPrZ+Yvg2n7e
        VyiVL/zCaoblWYMUoXunXeS8
X-Google-Smtp-Source: AJdET5fOLpu6T4PXpWFURgMefh9S3+b3GHBePEJQUo+y6/uhiwrsVYUbq60jmKngqzJAfQVAr+Pzkg==
X-Received: by 2002:a63:e302:: with SMTP id f2mr13154444pgh.320.1540803706419;
        Mon, 29 Oct 2018 02:01:46 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6091:9d4b:9d82:66b9:3ee6:ffac])
        by smtp.gmail.com with ESMTPSA id m11-v6sm28265245pfi.102.2018.10.29.02.01.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 02:01:45 -0700 (PDT)
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
Subject: [PATCH v2 7/7] arm64: dts: qcom: apq8016-sbc: Standardize LED labels
Date:   Mon, 29 Oct 2018 14:30:06 +0530
Message-Id: <20181029090006.4353-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029090006.4353-1-manivannan.sadhasivam@linaro.org>
References: <20181029090006.4353-1-manivannan.sadhasivam@linaro.org>
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

So lets adopt the same for APQ8016 SBC (Dragonboard410c), which is
one of the 96Boards CE platform.
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 46feedf7c989..35f95154316b 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -300,28 +300,28 @@
 			compatible = "gpio-leds";
 
 			led@1 {
-				label = "apq8016-sbc:green:user1";
+				label = "green:user1";
 				gpios = <&msmgpio 21 GPIO_ACTIVE_HIGH>;
 				linux,default-trigger = "heartbeat";
 				default-state = "off";
 			};
 
 			led@2 {
-				label = "apq8016-sbc:green:user2";
+				label = "green:user2";
 				gpios = <&msmgpio 120 GPIO_ACTIVE_HIGH>;
 				linux,default-trigger = "mmc0";
 				default-state = "off";
 			};
 
 			led@3 {
-				label = "apq8016-sbc:green:user3";
+				label = "green:user3";
 				gpios = <&pm8916_gpios 1 GPIO_ACTIVE_HIGH>;
 				linux,default-trigger = "mmc1";
 				default-state = "off";
 			};
 
 			led@4 {
-				label = "apq8016-sbc:green:user4";
+				label = "green:user4";
 				gpios = <&pm8916_gpios 2 GPIO_ACTIVE_HIGH>;
 				linux,default-trigger = "none";
 				panic-indicator;
@@ -329,14 +329,14 @@
 			};
 
 			led@5 {
-				label = "apq8016-sbc:yellow:wlan";
+				label = "yellow:wlan";
 				gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
 				linux,default-trigger = "phy0tx";
 				default-state = "off";
 			};
 
 			led@6 {
-				label = "apq8016-sbc:blue:bt";
+				label = "blue:bt";
 				gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
 				linux,default-trigger = "bluetooth-power";
 				default-state = "off";
-- 
2.17.1

