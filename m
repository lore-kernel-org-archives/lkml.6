Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784DBC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF0B2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WXYEBIOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF0B2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbeJ2Rss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:48:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46236 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbeJ2Rss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:48:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id m9-v6so850017pgl.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j2cyl7pk/6O0Vid/aGybHYEdGtKHVLDUxG+HI9FVaoA=;
        b=WXYEBIOSHhZvGe/6kt/SgeSbslSJXkqbZ0fRzs5jy48Ai3Gc5kXSPFxH5AG+BZjr6C
         B8f0LxSrx+RoBc/wlrR8K3+o3ubakn5wC9RYOi0OH6DXdqpa4AqjNR/8PSzd70NoaSxV
         ckPCguDAiO4rZ6yBzcYnXf2ULxRM/JwZTjQYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j2cyl7pk/6O0Vid/aGybHYEdGtKHVLDUxG+HI9FVaoA=;
        b=N2LQghxa8ZHzR6yoya4HxHBJkLv5hti5IrKMMkv0q4TXgBFW6+qmXFkicxuablrb9Z
         1NuBavgvGRwLMjz8vCCI5kTEArWcHn+5pwePV7ES08V+CgWiufpu7DQ/yRu/WmplbGJC
         uts7CSffozfrHpDg1W1vjZwzBfInhxalOnqfwX8nV/pLyICX4BvuTOiAu0sxzhrO0Kdq
         rvhLcw5MkWdS3ElYipPU1WSJ26VmsL1oD3zV4iMXsa3tP4n/vagv/c/YlUQzJVleKCeA
         XXbAIJMpU2b14JNu7uDt2GIoGbZSoz/AGDH/cNTUG3MoF15n2CpGjj2zMq+90++SLrs3
         CUZw==
X-Gm-Message-State: AGRZ1gKiS0R0g02m406cJOvkV6OQhit3uw4IpI4qDI+2RzFmEXL4usnK
        37LbMa9BSSmQDaxMO/utuErO
X-Google-Smtp-Source: AJdET5cG27bKpgsyGYQbxkexpabn/WBOGJscC8thahsoxQZ/qTda67toB8MZqGc9CCMcVJDDRtux1w==
X-Received: by 2002:a62:764e:: with SMTP id r75-v6mr14316497pfc.230.1540803664889;
        Mon, 29 Oct 2018 02:01:04 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6091:9d4b:9d82:66b9:3ee6:ffac])
        by smtp.gmail.com with ESMTPSA id m11-v6sm28265245pfi.102.2018.10.29.02.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 02:01:04 -0700 (PDT)
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
Subject: [PATCH v2 3/7] arm64: dts: hisilicon: hikey: Standardize LED labels and triggers
Date:   Mon, 29 Oct 2018 14:30:02 +0530
Message-Id: <20181029090006.4353-4-manivannan.sadhasivam@linaro.org>
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

So lets adopt the same for HiKey, which is one of the 96Boards
CE platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index f4964bee6a1a..d2bb5912dee7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -340,42 +340,43 @@
 
 	leds {
 		compatible = "gpio-leds";
+
 		user_led4 {
-			label = "user_led4";
+			label = "green:user1";
 			gpios = <&gpio4 0 0>; /* <&gpio_user_led_1>; */
 			linux,default-trigger = "heartbeat";
 		};
 
 		user_led3 {
-			label = "user_led3";
+			label = "green:user2";
 			gpios = <&gpio4 1 0>; /* <&gpio_user_led_2>; */
 			linux,default-trigger = "mmc0";
 		};
 
 		user_led2 {
-			label = "user_led2";
+			label = "green:user3";
 			gpios = <&gpio4 2 0>; /* <&gpio_user_led_3>; */
 			linux,default-trigger = "mmc1";
 		};
 
 		user_led1 {
-			label = "user_led1";
+			label = "green:user4";
 			gpios = <&gpio4 3 0>; /* <&gpio_user_led_4>; */
 			panic-indicator;
-			linux,default-trigger = "cpu0";
+			linux,default-trigger = "none";
 		};
 
 		wlan_active_led {
-			label = "wifi_active";
+			label = "yellow:wlan";
 			gpios = <&gpio3 5 0>; /* <&gpio_wlan_active_led>; */
 			linux,default-trigger = "phy0tx";
 			default-state = "off";
 		};
 
 		bt_active_led {
-			label = "bt_active";
+			label = "blue:bt";
 			gpios = <&gpio4 7 0>; /* <&gpio_bt_active_led>; */
-			linux,default-trigger = "hci0rx";
+			linux,default-trigger = "hci0-power";
 			default-state = "off";
 		};
 	};
-- 
2.17.1

