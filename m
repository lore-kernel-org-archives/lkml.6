Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E15C46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0CB2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELZ5WO0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0CB2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbeJ2RtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:49:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42183 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeJ2Rs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:48:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id f26-v6so3665247pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qiPc7+pFvXoljKcM3oPGvfYWKPi0YXvGMfaOhIYBWYY=;
        b=ELZ5WO0S/23V0UdRmgKRvDxZVuNu6bYA5IenqCxz5yktJa7MW60rvS+wcD1cZ+MkIS
         Xkl3eWIzSiIb1K93HoSZorED2aIJUgUBg2IcoCM3glPbjDopmMz5WrutlClBCFMoK85u
         OjbR/cap8ylCkd+J/bUjSRLirqaumdi+9CBic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qiPc7+pFvXoljKcM3oPGvfYWKPi0YXvGMfaOhIYBWYY=;
        b=DZLbOtQf3qQD2sCDUlJATaSV4W+MJ+LFnVPrkLHLCgfMGg2gmlDcwztyar00dcFz7a
         gMfyZ16nBiz9R2x2jVuYhuDgKODfUlWFAKUT13qm8SwhGMjzHNK/d6U8Czb/XpU8Aduw
         xeHSTUkIoTMiveozaat2X67H/JgzKMjXe6zzIdXu/JXaH1/pGdTChYLXOesjoABtyiGk
         mcDRPWB9prPmzyUa3KyivN0pSoVBHxqtMVQ8StM+H2ARq6O3x/txDYGJxKqn3tNbVE/8
         aFdBWzMXlyK+Q8WgzFuPtK3g71nkmLXDdTSTfScwuqx8xmaKWGeRs1QcYzwCdDxDDSsU
         1ccQ==
X-Gm-Message-State: AGRZ1gInEkQRFooT9tV4fiEUky0y8G8LmyY42b5aZRTmh+0c7Lm3Zyvz
        7bl+44937Zx9X8K4ab459eqT
X-Google-Smtp-Source: AJdET5dogNaqGTrd/NLfBSY786haoLdaKxO8hPfqgv+0s7bjecUpnYFQbeuhhA74lAM2RYt0fhnZgQ==
X-Received: by 2002:a63:e40e:: with SMTP id a14-v6mr13070918pgi.28.1540803675488;
        Mon, 29 Oct 2018 02:01:15 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6091:9d4b:9d82:66b9:3ee6:ffac])
        by smtp.gmail.com with ESMTPSA id m11-v6sm28265245pfi.102.2018.10.29.02.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 02:01:15 -0700 (PDT)
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
Subject: [PATCH v2 4/7] arm64: dts: hisilicon: hikey960: Standardize LED labels and triggers
Date:   Mon, 29 Oct 2018 14:30:03 +0530
Message-Id: <20181029090006.4353-5-manivannan.sadhasivam@linaro.org>
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

So lets adopt the same for HiKey960 which is one of the 96Boards
CE platform.

Since there is no trigger available for onboard-storage UFS now, user2
trigger is set to none.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/hisilicon/hi3660-hikey960.dts     | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index c98bcbc8dfba..46435466f1ab 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -85,36 +85,36 @@
 		compatible = "gpio-leds";
 
 		user_led1 {
-			label = "user_led1";
+			label = "green:user1";
 			/* gpio_150_user_led1 */
 			gpios = <&gpio18 6 0>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		user_led2 {
-			label = "user_led2";
+			label = "green:user2";
 			/* gpio_151_user_led2 */
 			gpios = <&gpio18 7 0>;
-			linux,default-trigger = "mmc0";
+			linux,default-trigger = "none";
 		};
 
 		user_led3 {
-			label = "user_led3";
+			label = "green:user3";
 			/* gpio_189_user_led3 */
 			gpios = <&gpio23 5 0>;
-			default-state = "off";
+			linux,default-trigger = "mmc0";
 		};
 
 		user_led4 {
-			label = "user_led4";
+			label = "green:user4";
 			/* gpio_190_user_led4 */
 			gpios = <&gpio23 6 0>;
 			panic-indicator;
-			linux,default-trigger = "cpu0";
+			linux,default-trigger = "none";
 		};
 
 		wlan_active_led {
-			label = "wifi_active";
+			label = "yellow:wlan";
 			/* gpio_205_wifi_active */
 			gpios = <&gpio25 5 0>;
 			linux,default-trigger = "phy0tx";
@@ -122,7 +122,7 @@
 		};
 
 		bt_active_led {
-			label = "bt_active";
+			label = "blue:bt";
 			gpios = <&gpio25 7 0>;
 			/* gpio_207_user_led1 */
 			linux,default-trigger = "hci0-power";
-- 
2.17.1

