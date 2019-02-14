Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785F4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49561222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4zOorQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438740AbfBNNJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:09:34 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46690 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436747AbfBNNJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:09:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so3043350pgp.13;
        Thu, 14 Feb 2019 05:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+hK5V+00HuBIgvwFBMqvf1caVsLQS7fH30vXRswk3QU=;
        b=N4zOorQCPStoqHAzK8dkZTKIuQP4g/v0c1TBWu0ordNOpN4aVAkxtt0rp8IsunV+oL
         JZabue/BQgQ7oyk1EZFxhswYI6N4VS0t8uMNZvLg0klSFmA5pLDU/mDgolH0dEyGqxSm
         zokMSqu2kCGY+d9fL3j6oEt7yEAEVFngv8Bt9ujBDho+vikddNE8PbjcZmNNm0xK+MCi
         dWHOIfn8STLExiLjj+3+wW6TT+z4mheqy+c2CSzX3jrz1mNHO5s1nIVyWxsh5+siuqpa
         pEI56Q2+P7RJ7kS00p3dEpWoSe0rH1mNj+67idrGD5TyQh7qFhQI1MpTdTT5GbonMBbK
         W8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+hK5V+00HuBIgvwFBMqvf1caVsLQS7fH30vXRswk3QU=;
        b=SlfDaX5BXePFpTfqHaMnLb6eAVxQXqzP07RXOTQbSKN6RzOCb7P2yXCV1OJZ5Aa+Zn
         O/Ra4t8jim4KG901G00UWKLhC14QLZ/1s66oH4rN1QsiEDY40cSkq7TQt8HWRk5/6czQ
         1efSez6xfUZMf1ZP78Vf45SYmggphrIeHwi7yhgjlDN/3TfXE44D9tkdKXRUsjdgUqxc
         AarWirT2/qKfDu5Ir982dgdALB6Y1E7EEkK7odnI1urIv992h0UO/2SEX4xuisxq+Ue0
         OnmAPhhFpz9BmETosTrf0tFe7W9/DonM4HaMUYRzM4vCPn/0voGYjYXHnwH/fjcPYZUR
         UGQA==
X-Gm-Message-State: AHQUAua1gt5k7/yI1Qk0FuhcOaJsqHk8cToTXa5qFaf2DkTz72ZIZboO
        qAEqqkDX/EulSabRp5LTTUs=
X-Google-Smtp-Source: AHgI3IZE6om4PCXUD8l/xFXDXYr2gbJMaFNdC2/Pesiz51GgDeT7X6D+cXbbQrjUMdXMQpgE/YpFtA==
X-Received: by 2002:a65:47ca:: with SMTP id f10mr3810384pgs.166.1550149771864;
        Thu, 14 Feb 2019 05:09:31 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 15sm3625336pfr.55.2019.02.14.05.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 05:09:31 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 3/4] arm64: dts: allwinner: h6: Add clock to CPU cores
Date:   Thu, 14 Feb 2019 08:09:09 -0500
Message-Id: <20190214130910.9201-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190214130910.9201-1-tiny.windzz@gmail.com>
References: <20190214130910.9201-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM CPU cores are fed by the CPU clock from the CCU. Add a
reference to the clock for each CPU core, along with the clock
transition latency.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index d93a7add67e7..57a1390ecdc2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -26,6 +26,8 @@
 			device_type = "cpu";
 			reg = <0>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>; 
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu1: cpu@1 {
@@ -33,6 +35,8 @@
 			device_type = "cpu";
 			reg = <1>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>; 
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu2: cpu@2 {
@@ -40,6 +44,8 @@
 			device_type = "cpu";
 			reg = <2>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>; 
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu3: cpu@3 {
@@ -47,6 +53,8 @@
 			device_type = "cpu";
 			reg = <3>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>; 
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 	};
 
-- 
2.17.0

