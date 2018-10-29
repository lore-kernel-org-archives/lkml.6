Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5239EC46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE772084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+RgILs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE772084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbeJ2SbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:31:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40672 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729646AbeJ2SbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:31:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id o14-v6so3611054pgv.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wUFCaMP2U/9XAPvBBvehrJOX1gaBUfBxuvntsZn9/3s=;
        b=C+RgILs3dUJi3yraFCTU5KozzhnQqfd6aNaaH6g/niqa6DtxemChy0W8NGhvefe0hc
         eXZhBhncQ68vRSxmRQKktJb0TZtI/J6x6Rq6MfoPajHK5VBQBSxK/spann2Yv2cBvsDI
         RRb8GoLdALuemVCAody9oaWDnCsVGkEliQCd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wUFCaMP2U/9XAPvBBvehrJOX1gaBUfBxuvntsZn9/3s=;
        b=jRgN8HyWIxmBomfp7UMZvgz1omkxvs0yg8H0FZ8MGu+PqxxqmQP0oJddvDaBcKlQpj
         dpP17lYurr9JNplbEASV6mIGH7ddOfWF3S4JM3Dr5nszQ5rgJ0mM2N44LF3BrnD0ws92
         hNTRBk2xxe76WPH7G95IL1sxPgqoOJT75IWsLXuqCKMNZLZPMlLfUiMCSpHMZ8yg2SY7
         A/yLVp7l+n2SIb6/K5uTIB9956Eu4ccgbTeicAu6TRYvbFYSZdpon+7ht295olgSLqad
         ljSH9SWL7/ddN3qPgQOc6s21xDc1XLc5h7hgdVREkzj9JVK9DliTNq9d/u47dy4J90nD
         gZfg==
X-Gm-Message-State: AGRZ1gL139uvp9InXFgOuCLk6ioAgNqNsdH6CbuLt63XRVjwoE3rpaa6
        U95Qdi92uQzBKZVotLOPoouc
X-Google-Smtp-Source: AJdET5fS54SjrO378Z1st9Q6dtXGznAhI4v8BaKMT7ORh4ePfM1UD/S6TF7rxeSXlreeNQeHE5nKhA==
X-Received: by 2002:a63:1c1b:: with SMTP id c27-v6mr13211072pgc.351.1540806189478;
        Mon, 29 Oct 2018 02:43:09 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6091:9d4b:9d82:66b9:3ee6:ffac])
        by smtp.gmail.com with ESMTPSA id b62-v6sm21162056pfa.159.2018.10.29.02.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 02:43:09 -0700 (PDT)
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
Subject: [PATCH v3 1/7] arm64: dts: rockchip: ficus: Add on-board LED support
Date:   Mon, 29 Oct 2018 15:12:39 +0530
Message-Id: <20181029094245.7886-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add on-board LED support for Ficus board based on the following
standard used by other 96Boards:

red:user1  default-trigger: heartbeat
red:user2  default-trigger: mmc0/disk-activity (onboard-storage)
red:user3  default-trigger: mmc1 (SD-card)
red:user4  default-trigger: none, panic-indicator
red:wlan   default-trigger: phy0tx
red:bt     default-trigger: hci0-power

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
index cce266da28cd..027d428917b8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
@@ -23,6 +23,52 @@
 		clock-output-names = "clkin_gmac";
 		#clock-cells = <0>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_led1>, <&user_led2>, <&user_led3>,
+			    <&user_led4>, <&wlan_led>, <&bt_led>;
+
+		user_led1 {
+			label = "red:user1";
+			gpios = <&gpio4 25 0>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		user_led2 {
+			label = "red:user2";
+			gpios = <&gpio4 26 0>;
+			linux,default-trigger = "mmc0";
+		};
+
+		user_led3 {
+			label = "red:user3";
+			gpios = <&gpio4 30 0>;
+			linux,default-trigger = "mmc1";
+		};
+
+		user_led4 {
+			label = "red:user4";
+			gpios = <&gpio1 0 0>;
+			panic-indicator;
+			linux,default-trigger = "none";
+		};
+
+		wlan_active_led {
+			label = "red:wlan";
+			gpios = <&gpio1 1 0>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		bt_active_led {
+			label = "red:bt";
+			gpios = <&gpio1 4 0>;
+			linux,default-trigger = "hci0-power";
+			default-state = "off";
+		};
+	};
 };
 
 &gmac {
@@ -66,6 +112,38 @@
 				<4 27 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	leds {
+		user_led1: user_led1 {
+			rockchip,pins =
+				<4 25 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		user_led2: user_led2 {
+			rockchip,pins =
+				<4 26 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		user_led3: user_led3 {
+			rockchip,pins =
+				<4 30 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		user_led4: user_led4 {
+			rockchip,pins =
+				<1 0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wlan_led: wlan_led {
+			rockchip,pins =
+				<1 1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_led: bt_led {
+			rockchip,pins =
+				<1 4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &usbdrd_dwc3_0 {
-- 
2.17.1

