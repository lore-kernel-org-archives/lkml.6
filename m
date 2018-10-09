Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197B3C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C552086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R+UTf16z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C552086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeJIVXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:23:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39086 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbeJIVXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:23:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id c25-v6so903402pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 07:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mjns9AO833DdTLlO/vGxzhXmWWgQNDuIJY3ha9Rxc70=;
        b=R+UTf16zmaJc7ZMBbNHwtbXPuEUJ/r0zyjbirplJ0qwSRSkepl+UXCqxKWAF/JbBl1
         gX3Ha2zMfEriX1CsQIOnFTX7g8lvRiDEbl+wcI4fl60156xF3nwMV6mg52DGJ77bvOQx
         /EWNvn4wzKm8echOtZNCPGKaxcacC5F74bYOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mjns9AO833DdTLlO/vGxzhXmWWgQNDuIJY3ha9Rxc70=;
        b=MwPEdD2+JTKbRXRGLc9wIZTTIVA2T5AmfsNwfPvo6JPhhKLcorRt6UTt/Yt3uOFb1C
         2I5chT3G3qydLD/gEbsiV2G1zEQc+YL4OthuQVhPEpN5CIlBvUQnMlHT1fzKVmZkcsfM
         g7R2XwX6qnNqOLCR1VuCxm6snkwuBx7CBaj1SW3thF5jJCS7JM1xuXfs9wJ9aZ/wElsV
         csXpotHYLM5VzbfjLnScFKz0+4e1HQ+PfjrsUT502XRt/m/9v2H57vtHVoNF+51SQtDJ
         Vzl0nZojtDf6GlCtOOTkq2nRjVsrMs77QN8zI5prND8fJe6jIM/wZC5RWQZCy/7wDONW
         b5NA==
X-Gm-Message-State: ABuFfohQ6/mrCu7bO5Na9+oSbM2sTFhL/t8CZmvZRrrm7GYGY+eoAap4
        rPvzJKPZmGS3WWcAUIbizKR8
X-Google-Smtp-Source: ACcGV633CsOIak7VEAeH4jTt7NE2mZQPI6Ve4IekmecaD0HiGsuS+YsQJgrMuEm2gIIyQRpESwaXCg==
X-Received: by 2002:a63:bf46:: with SMTP id i6-v6mr17390656pgo.378.1539093968247;
        Tue, 09 Oct 2018 07:06:08 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id e64-v6sm28947722pfe.55.2018.10.09.07.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 07:06:07 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     robh+dt@kernel.org, heiko@sntech.de, ezequiel@collabora.com,
        xuwei5@hisilicon.com, michal.simek@xilinx.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, koen.kooi@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/6] arm64: dts: hisilicon: poplar: Standardize LED labels and triggers
Date:   Tue,  9 Oct 2018 19:35:21 +0530
Message-Id: <20181009140522.6492-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
References: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For all 96Boards, the following standard is used for onboard LEDs.

device-name:green:user1  default-trigger: heartbeat
device-name:green:user2  default-trigger: mmc0/disk-activity
                                          (onboard-storage)
device-name:green:user3  default-trigger: mmc1 (SD-card)
device-name:green:user4  default-trigger: none, panic-indicator
device-name:yellow:wlan  default-trigger: phy0tx
device-name:blue:bt      default-trigger: hci0-power

So lets adopt the same for Poplar, which is one of the 96Boards
Enterprise edition platform.

Due to absence of WLAN and BT support, corresponding LED nodes are not
considered.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
index d30f6eb8a5ee..f6f3e928a54e 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
@@ -35,30 +35,31 @@
 		compatible = "gpio-leds";
 
 		user-led0 {
-			label = "USER-LED0";
+			label = "hi3798cv200-poplar:green:user1";
 			gpios = <&gpio6 3 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
 
 		user-led1 {
-			label = "USER-LED1";
+			label = "hi3798cv200-poplar:green:user2";
 			gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
 
 		user-led2 {
-			label = "USER-LED2";
+			label = "hi3798cv200-poplar:green:user3";
 			gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "none";
+			linux,default-trigger = "mmc1";
 			default-state = "off";
 		};
 
 		user-led3 {
-			label = "USER-LED3";
+			label = "hi3798cv200-poplar:green:user4";
 			gpios = <&gpio10 6 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "cpu0";
+			linux,default-trigger = "none";
+			panic-indicator;
 			default-state = "off";
 		};
 	};
-- 
2.17.1

