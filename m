Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0224C46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A562084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ebZDNOIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A562084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbeJ2RtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:49:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44986 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbeJ2RtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:49:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id j13-v6so165125pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vbqz/FFQSiZYMz4Ct6V+6er7vQMDEB5XowGv/dcExWY=;
        b=ebZDNOIlEKX7hx6BlBHcemhr+HLPaoSt2U0XQFC+CPJBEhjHMe7qiFAeOXuC7T4XVs
         bmPNma2YUkdycffAOC7nyECgJ5M2TlpIt/vauRBNOp9QcgN019BNj9UYrHPeYiGqsGqb
         ogA5vbqtg6LuiRXUgHDGDwOvc5/kmp7U04osE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vbqz/FFQSiZYMz4Ct6V+6er7vQMDEB5XowGv/dcExWY=;
        b=k4MIuBuuOmFDi6sd2A26zj3XhAfNyhs5uGkz04D34LkfoyWnVlpi/JtfrCP1C6/cG8
         wYyS8ef6L7Z6/IAvZHl9nT62GsJhrA8HaByIW5Su+9pztv59cJlJnvVy0C3gE28PKECA
         jGYP4XL6j7skuk7f6Ek3djR8kwTZjndZ6lCNDAtPDGTJ++abUbk4tvSHbWNnm411u/hV
         hs8xMosTwVl+65V03oPJMv2ZGM3p5map42Nbc1KidJ15MKBGZvDG02UAqioqw5HkbkSP
         60L9pz/9gQm3dtiPn1t4IOeRpNgyQPoxDj1eQRsMMishaWwA2ErFItVqRltTx2QUaLOa
         BnzA==
X-Gm-Message-State: AGRZ1gJDiwXhXAbyi7akf/okNY/RwfeMLbcG8BEkifCL2Fbh1YuSuFa3
        c/j2+zDql6IiWTLKFlYs5zxw
X-Google-Smtp-Source: AJdET5e3QeUReF9X4kWXeWZOBl9EJIP0WP+hIpU5igB4fbS1kv0fMu5WdNZLxaWv2jaqr0KAFGxOGg==
X-Received: by 2002:aa7:8603:: with SMTP id p3-v6mr3225827pfn.247.1540803686248;
        Mon, 29 Oct 2018 02:01:26 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6091:9d4b:9d82:66b9:3ee6:ffac])
        by smtp.gmail.com with ESMTPSA id m11-v6sm28265245pfi.102.2018.10.29.02.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 02:01:25 -0700 (PDT)
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
Subject: [PATCH v2 5/7] arm64: dts: hisilicon: poplar: Standardize LED labels and triggers
Date:   Mon, 29 Oct 2018 14:30:04 +0530
Message-Id: <20181029090006.4353-6-manivannan.sadhasivam@linaro.org>
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

