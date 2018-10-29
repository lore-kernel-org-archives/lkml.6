Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F8BC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E312084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T1oqIA+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E312084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbeJ2SbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:31:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44205 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729757AbeJ2SbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:31:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3-v6so3596843pgs.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eF7R+wV5XvQwulmXcDJVVSDaYAoMfcK0EngVpIC/pTQ=;
        b=T1oqIA+WZ4VaD4gwcVt/EeAQUL4LV9w5Bh7g8yYjkzfIfCAFcLVAnsA19+mO3LBBP0
         PpkpGcOSbeMuVukpajaZrAZ0Pyau3UPtBCe5qq54srP8RuB1aBuHiv4te2jgNa24fiLE
         5WRKUPHFDvMM5lqLKbVjQMkuvf0f40dJKoX0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eF7R+wV5XvQwulmXcDJVVSDaYAoMfcK0EngVpIC/pTQ=;
        b=jKXbW1jl3E8Q2SrtLpFXcD7KsZpdEAUH30fQL2PsKylKPV2Zfbc6Er+uaneEy4vH0D
         Qe0xtZORrPgQdNdpWN6wxHSpT99BamJGieXb5SgKG42CoMxkASb5Oc2m15imh0KjRNKG
         cGHIeHGWYukH0s9+FoWr8bErLW0J1oO0dNtiWjwouRtR4UZaG9C5Md801xe1tFr4enac
         sc06fSBBe8B/nOMvb86DBDpO5iVDEL3w3SNzamHWAHf9Sf6hK37aJylbcOVPb03sSnWA
         BWH+rhxsEqNfluEImo2KK+dfAuFoutq6UK2VEEWIxVzEJJtwTRkMOOhecGAPwRtPEDEI
         GhLA==
X-Gm-Message-State: AGRZ1gKr9wRmtMynL9iIAaZpiP4nYNZ6VWdC3aP0auI1QB5WZDsm9nFG
        rWkPO2d1Y7mXQd465kk/6Da4
X-Google-Smtp-Source: AJdET5dV2bclnlsREn8R0dTaX1qfHV+FwC1BvmKMU/oD6xKGnnAEFNm/zu0Dnw3DX0BceVZOoDepDg==
X-Received: by 2002:a63:2e47:: with SMTP id u68-v6mr13188980pgu.294.1540806208288;
        Mon, 29 Oct 2018 02:43:28 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6091:9d4b:9d82:66b9:3ee6:ffac])
        by smtp.gmail.com with ESMTPSA id b62-v6sm21162056pfa.159.2018.10.29.02.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 02:43:27 -0700 (PDT)
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
Subject: [PATCH v3 3/7] arm64: dts: hisilicon: hikey: Standardize LED labels and triggers
Date:   Mon, 29 Oct 2018 15:12:41 +0530
Message-Id: <20181029094245.7886-4-manivannan.sadhasivam@linaro.org>
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

So lets adopt the same for HiKey, which is one of the 96Boards
CE platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../arm64/boot/dts/hisilicon/hi6220-hikey.dts | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index f4964bee6a1a..610235028cc7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -340,42 +340,43 @@
 
 	leds {
 		compatible = "gpio-leds";
-		user_led4 {
-			label = "user_led4";
+
+		user_led1 {
+			label = "green:user1";
 			gpios = <&gpio4 0 0>; /* <&gpio_user_led_1>; */
 			linux,default-trigger = "heartbeat";
 		};
 
-		user_led3 {
-			label = "user_led3";
+		user_led2 {
+			label = "green:user2";
 			gpios = <&gpio4 1 0>; /* <&gpio_user_led_2>; */
 			linux,default-trigger = "mmc0";
 		};
 
-		user_led2 {
-			label = "user_led2";
+		user_led3 {
+			label = "green:user3";
 			gpios = <&gpio4 2 0>; /* <&gpio_user_led_3>; */
 			linux,default-trigger = "mmc1";
 		};
 
-		user_led1 {
-			label = "user_led1";
+		user_led4 {
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

