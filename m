Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B3BC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1E22086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqilUWZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1E22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeJIVXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:23:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34738 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbeJIVXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:23:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id f18-v6so904741plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 07:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2v0A8Sy+mBXs6qKDANV08GTdJ7Hi+gaENxNk1633qzo=;
        b=dqilUWZ8k3+3dB7GdgNnSUnkxsyfzIAB2n7vFWTR7EifJcr7Bmj5t4tqKkwTEyL3RU
         FbHIzGnB16JAVEfwRklSjwmklgn8O3ncDy0wQLEBlA+EJqAD3vSlCqT7FnRlBdqz1cjm
         sI9CZqmmJyDIGcfGNywthy0hiKeP22SkQRuQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2v0A8Sy+mBXs6qKDANV08GTdJ7Hi+gaENxNk1633qzo=;
        b=QGA795A/Qr8THMxZkg/LBIFMiB2OSiI1upWGgb5QPXCgW4bEqBqhQRV5rjlIE6mz9U
         PNw1TkZYoWivUKFDhkjXdoXFC4ES1lpbU8v4dgqjEEyY0UpiZC5tfQ1Ib3SQohp0Efm+
         do/65h6Zoiayk3l6bJvEjp1XjhwpiMSEIoUCy7jhmTB16VcbBq+w23bFQ4uxt00395Z6
         RJJRrXCsvOz+Y5p9VyTUZUxKHM4S43aG194ypNdoFr9xE7LiNDncSQIhK4PyCFyIWJi/
         z5mOjpb34ibvB3qphENOmzTfwJmZn8YX+lw6/4P5SJCs53PKvD+ymFXWuASoAJcYq2+l
         mZ0Q==
X-Gm-Message-State: ABuFfoj+uWrbA/lEAWs4wPfDsVE9mvMx/DOQnHCKXpTbEPhh1Iw+dDWq
        CK/VD3SuZBIJ2EQa8KIwJzaS
X-Google-Smtp-Source: ACcGV63ZyRn69n6sXb9QCqwtRgHqSpbeQk+5cLve33dgfW6Q+i44vYFrJsV9+EdMVjBb9kYvVtq0JQ==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11-v6mr28500234plb.219.1539093956191;
        Tue, 09 Oct 2018 07:05:56 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id e64-v6sm28947722pfe.55.2018.10.09.07.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 07:05:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     robh+dt@kernel.org, heiko@sntech.de, ezequiel@collabora.com,
        xuwei5@hisilicon.com, michal.simek@xilinx.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, koen.kooi@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/6] arm64: dts: rockchip: rock960: Add on-board LED support
Date:   Tue,  9 Oct 2018 19:35:18 +0530
Message-Id: <20181009140522.6492-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
References: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add on-board LED support for Rock960 board based on the following
standard used by rest of the 96Boards:

device-name:green:user1  default-trigger: heartbeat
device-name:green:user2  default-trigger: mmc0/disk-activity
                                          (onboard-storage)
device-name:green:user3  default-trigger: mmc1 (SD-card)
device-name:green:user4  default-trigger: none, panic-indicator
device-name:yellow:wlan  default-trigger: phy0tx
device-name:blue:bt      default-trigger: hci0-power

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/rockchip/rk3399-rock960.dts      | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
index 3c3308daec98..7d0d1c69c3a8 100644
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
+			label = "rk3399-rock960:green:user1";
+			gpios = <&gpio4 RK_PC2 0>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		user_led2 {
+			label = "rk3399-rock960:green:user2";
+			gpios = <&gpio4 RK_PC6 0>;
+			linux,default-trigger = "mmc0";
+		};
+
+		user_led3 {
+			label = "rk3399-rock960:green:user3";
+			gpios = <&gpio4 RK_PD0 0>;
+			linux,default-trigger = "mmc1";
+	};
+
+		user_led4 {
+			label = "rk3399-rock960:green:user4";
+			gpios = <&gpio4 RK_PD4 0>;
+			panic-indicator;
+			linux,default-trigger = "none";
+		};
+
+		wlan_active_led {
+			label = "rk3399-rock960:yellow:wlan";
+			gpios = <&gpio4 RK_PD5 0>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		bt_active_led {
+			label = "rk3399-rock960:blue:bt";
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

