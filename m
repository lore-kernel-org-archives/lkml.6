Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44617C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2242064E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIj4DW1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2242064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJIVXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:23:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38059 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbeJIVXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:23:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id f8-v6so869012pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 07:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dqiYckb7Q3F8kaPDDVtcaj9+/KOyQnhiQ9kyaN/rDMk=;
        b=cIj4DW1SfQaNlFJdhnGgnF4jb/XGXIwnEgEEcFf1Tp7iWKUMxnWNdiMDh1qM6uybzM
         PqwWmbQyWCCz5HsqZd4uxFqDxNhvoJUgTesCNu6bgQ1c/r9Wpn9zeRAns+7MwEGjrVOe
         WBIb3z5JExOkgna6KkUfKqnmnLX8Y2mol9hvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dqiYckb7Q3F8kaPDDVtcaj9+/KOyQnhiQ9kyaN/rDMk=;
        b=eBZg7Tctq7GqZA7IQKfrzFs/9ib2ipge1/zPvIYSPjt9gr+OwPopJ3SAIlNL8xLNHi
         5srjlq6PONSFddIZyKJiJwHJf15za/DMomFvULz+spPqRB8i/R5r7ie5GjhaNtOft8v5
         uiWtj4DH4iLRSnUbi1j9h2K8ufcr45OISCuu+0yl6p9cqo0x5lFxrnlzplU0M7MCfspd
         T4NslGYJZCY2f+cC3SCaemPkTHq2+dUSYPELs9MjEU6YVy4wxVgYqITzSYMc7cXtuUAi
         rwxoLU3ov3TSYaqdIlwrc3wXRlNS1sdGVLXaXUndkgvIIi5UKHCdT6Ybn2A7AFvy6SNU
         bnOA==
X-Gm-Message-State: ABuFfogemOMprMASdJ4EasCcmZVWLLMsyQNojKD/tq+fn4nWfCZ/m8eh
        yHFjhZL2mDSZ5AcP/BxdNgfm
X-Google-Smtp-Source: ACcGV62jKg4lFYLo2Ygo+ApTeJ0uXrtpznjGYeRaxyuqrh8dKL4zEGk9n9FwsmdnzY2xvsQGzhcrHA==
X-Received: by 2002:a63:cc51:: with SMTP id q17-v6mr25509145pgi.291.1539093960346;
        Tue, 09 Oct 2018 07:06:00 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id e64-v6sm28947722pfe.55.2018.10.09.07.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 07:05:59 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     robh+dt@kernel.org, heiko@sntech.de, ezequiel@collabora.com,
        xuwei5@hisilicon.com, michal.simek@xilinx.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, koen.kooi@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/6] arm64: dts: hisilicon: hikey: Standardize LED labels and triggers
Date:   Tue,  9 Oct 2018 19:35:19 +0530
Message-Id: <20181009140522.6492-4-manivannan.sadhasivam@linaro.org>
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

So lets adopt the same for HiKey, which is one of the 96Boards
CE platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index f4964bee6a1a..3dd9543da0b6 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -340,42 +340,43 @@
 
 	leds {
 		compatible = "gpio-leds";
+
 		user_led4 {
-			label = "user_led4";
+			label = "hi6220-hikey:green:user1";
 			gpios = <&gpio4 0 0>; /* <&gpio_user_led_1>; */
 			linux,default-trigger = "heartbeat";
 		};
 
 		user_led3 {
-			label = "user_led3";
+			label = "hi6220-hikey:green:user2";
 			gpios = <&gpio4 1 0>; /* <&gpio_user_led_2>; */
 			linux,default-trigger = "mmc0";
 		};
 
 		user_led2 {
-			label = "user_led2";
+			label = "hi6220-hikey:green:user3";
 			gpios = <&gpio4 2 0>; /* <&gpio_user_led_3>; */
 			linux,default-trigger = "mmc1";
 		};
 
 		user_led1 {
-			label = "user_led1";
+			label = "hi6220-hikey:green:user4";
 			gpios = <&gpio4 3 0>; /* <&gpio_user_led_4>; */
 			panic-indicator;
-			linux,default-trigger = "cpu0";
+			linux,default-trigger = "none";
 		};
 
 		wlan_active_led {
-			label = "wifi_active";
+			label = "hi6220-hikey:yellow:wlan";
 			gpios = <&gpio3 5 0>; /* <&gpio_wlan_active_led>; */
 			linux,default-trigger = "phy0tx";
 			default-state = "off";
 		};
 
 		bt_active_led {
-			label = "bt_active";
+			label = "hi6220-hikey:blue:bt";
 			gpios = <&gpio4 7 0>; /* <&gpio_bt_active_led>; */
-			linux,default-trigger = "hci0rx";
+			linux,default-trigger = "hci0-power";
 			default-state = "off";
 		};
 	};
-- 
2.17.1

