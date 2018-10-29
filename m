Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F154C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEC22084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TjAIwcBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEC22084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbeJ2SbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:31:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37470 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbeJ2SbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:31:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so3617776pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pCPQcI73UddaBWggkh570wXZTWiaCyv6lTgOSiLnbCM=;
        b=TjAIwcBs595dTO4lawKU3u/xjBCzwU4vXj8rbWfbQ0EXBtVEaWjDjHH4NUoYIeO2Qn
         xMAjv9np6GTwAZ7UBXV/AQi/EUrY56ku4NcQS+7JqKSbKLTWcKRBGd4bqPFL859LXBV/
         sbM0+UuKCihmKH+ky7DeUQ6H1VHcIY1wm/j94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pCPQcI73UddaBWggkh570wXZTWiaCyv6lTgOSiLnbCM=;
        b=ruJcnBviLD/iaB9SAjFLA7NU/VhzetO8xEE8qanSckjvDiT9Ibvbr6oFgbn3sSIbY0
         8DSP68CE8M06lex6+bvcsgd+3AF5neYE9thjIg13sMtvHBTIQde/7+T93QL7wjVupHkz
         MvpU4srM9Y2erN3OID4FUguG+wy1yiypSzn8ccqktRbILPp7PmuHt8AHJJVmi9M5RAR+
         qjgKiop8GD5BfQf32mtm5YoVfgBOaJYZsHZDfoiiL0Vart5aWYZhe48dwA7I8coacVJV
         XH7NoxDUdo8FbNEg0ou2C/rw6mQPiJIXCc4wb9QyXR7AfozJQ2Iuhun4tS6x7qdGrE+C
         PoSQ==
X-Gm-Message-State: AGRZ1gLTPKqoIEYhAzpP7bqjb2ezf33iAc+WOv8328VCCmGDHFRN1ooA
        gPBpbVR1oBf/IZuWjimSiLix
X-Google-Smtp-Source: AJdET5e3W23iETWSuprcDsJ0+1FqdzhhfEwF7SvTEk1pZxm/5TUz62C250d18Z+ZO66+IaR+SYns3Q==
X-Received: by 2002:a63:4343:: with SMTP id q64-v6mr13582181pga.276.1540806199372;
        Mon, 29 Oct 2018 02:43:19 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6091:9d4b:9d82:66b9:3ee6:ffac])
        by smtp.gmail.com with ESMTPSA id b62-v6sm21162056pfa.159.2018.10.29.02.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 02:43:18 -0700 (PDT)
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
Subject: [PATCH v3 2/7] arm64: dts: rockchip: rock960: Add on-board LED support
Date:   Mon, 29 Oct 2018 15:12:40 +0530
Message-Id: <20181029094245.7886-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add on-board LED support for Rock960 board based on the following
standard used by rest of the 96Boards:

green:user1  default-trigger: heartbeat
green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
green:user3  default-trigger: mmc1 (SD-card)
green:user4  default-trigger: none, panic-indicator
yellow:wlan  default-trigger: phy0tx
blue:bt      default-trigger: hci0-power

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/rockchip/rk3399-rock960.dts      | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
index 3c3308daec98..12285c51cceb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
@@ -13,6 +13,53 @@
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_led1>, <&user_led2>, <&user_led3>,
+			    <&user_led4>, <&wlan_led>, <&bt_led>;
+
+		user_led1 {
+			label = "green:user1";
+			gpios = <&gpio4 RK_PC2 0>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		user_led2 {
+			label = "green:user2";
+			gpios = <&gpio4 RK_PC6 0>;
+			linux,default-trigger = "mmc0";
+		};
+
+		user_led3 {
+			label = "green:user3";
+			gpios = <&gpio4 RK_PD0 0>;
+			linux,default-trigger = "mmc1";
+		};
+
+		user_led4 {
+			label = "green:user4";
+			gpios = <&gpio4 RK_PD4 0>;
+			panic-indicator;
+			linux,default-trigger = "none";
+		};
+
+		wlan_active_led {
+			label = "yellow:wlan";
+			gpios = <&gpio4 RK_PD5 0>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		bt_active_led {
+			label = "blue:bt";
+			gpios = <&gpio4 RK_PD6 0>;
+			linux,default-trigger = "hci0-power";
+			default-state = "off";
+		};
+	};
+
 };
 
 &pcie0 {
@@ -20,6 +67,38 @@
 };
 
 &pinctrl {
+	leds {
+		user_led1: user_led1 {
+			rockchip,pins =
+				<4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		user_led2: user_led2 {
+			rockchip,pins =
+				<4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		user_led3: user_led3 {
+			rockchip,pins =
+				<4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		user_led4: user_led4 {
+			rockchip,pins =
+				<4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wlan_led: wlan_led {
+			rockchip,pins =
+				<4 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_led: bt_led {
+			rockchip,pins =
+				<4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	pcie {
 		pcie_drv: pcie-drv {
 			rockchip,pins =
-- 
2.17.1

