Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE36BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7578820873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nY/fJC3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7578820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeK1KXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:23:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45015 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeK1KXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 05:23:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so9159147pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 15:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Xfx8ZewVdmrTUz9BIWUKVGbJfsFKHUDz2o+BqWwEEU=;
        b=nY/fJC3orJvzPlKkTcBYu2YA0qwRxxPRvYQQsbxm4wCi0euZwpIs8wNjfKSKPNRf58
         FVSIJbHvfTagHqSKuondv962L4Xqdt6kgz+EL0ekiStn7EK4McyaJgSeWOymqA7Vye+A
         PSy1UfkbI9N88WSed8lQNtc8qG2NlZl09XsO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Xfx8ZewVdmrTUz9BIWUKVGbJfsFKHUDz2o+BqWwEEU=;
        b=CIhRx3oCwO/W5pSw5GCv1Aw8tj3CBQgP9vPigfemr0Cv1958RFu2+6MrO40nzoe9MF
         N/BEGBBR7TqxxDmDSiDukkHwREKUQtlN8VToGjKWfq69hh5FX5YAcF3F4aP8r75WNBH1
         37T+rGUQaL8OxlZhK6G8P5/3qpj0x2VX/LeO16QKj9FXwmv2erEDBs9YWc82pBwuZr8o
         L5ozpQPr6fWkqpkawy3OKQ8l5YZU4TkakrwkoTAR9UiZqudgLxKnCb2UFefaqmjHNjQw
         JQ6BdTpuzMsLVWNfUTvSXygDxV7q/+IFqFmWYWBEFS21xyBRWy6EjTFZXr32X4SVYBi4
         j90A==
X-Gm-Message-State: AA+aEWZraZgYpuS2D2B1KgWwRQywz1DbX2XYpdkpr7dembGcU2IUIA3A
        PRMban2x70DjR8e4bA59NExs6+NZL6M=
X-Google-Smtp-Source: AFSGD/XK8+grlxxuwoykk/HC4/5a9SI4M8JjDohx7JwD6H4dowUbSNE8OxifxU8mTOEGo0xIPWeqiA==
X-Received: by 2002:a63:4246:: with SMTP id p67mr30776662pga.335.1543361016552;
        Tue, 27 Nov 2018 15:23:36 -0800 (PST)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:db8d:8e3f:2514:5db8])
        by smtp.gmail.com with ESMTPSA id 73-v6sm6484042pfl.142.2018.11.27.15.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 15:23:35 -0800 (PST)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        tony.xie@rock-chips.com, zyw@rock-chips.com, ayaka@soulik.info,
        nickey.yang@rock-chips.com, zhengsq@rock-chips.com,
        klaus.goger@theobroma-systems.com, dianders@chromium.org,
        briannorris@chromium.org, enric.balletbo@collabora.com,
        heiko@sntech.de, mark.rutland@arm.com, robh+dt@kernel.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH] arm64: dts: rockchip: Add 32k clk on rk3399-gru
Date:   Tue, 27 Nov 2018 15:23:31 -0800
Message-Id: <20181127232331.49628-1-dbasehore@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the 32k clock to the RK3399 Gru board file. Even though it's
not directly used, muxes will end up traversing the entire clk tree on
calls to determine_rate if it doesn't exist. This is because the 32k
clk is listed as a possible parent on some clks. Since the clk doesn't
know about the 32k clk (it was never registered), it triggers a global
search for it. This can happen about 40 times per second, which isn't
great for power.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index ca07f6032200..a07aa4c570c0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -14,6 +14,13 @@
 		stdout-path = "serial2:115200n8";
 	};
 
+	ap_rtc_clk: ap-rtc-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		clock-output-names = "xin32k";
+		#clock-cells = <0>;
+	};
+
 	/*
 	 * Power Tree
 	 *
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

