Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB3FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCB7206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZiU44Uih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732929AbeLTQKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:10:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46900 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732743AbeLTQKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:10:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so2311132wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 08:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QjVe3lROVBqlIiyvJQbtG1oGTNmeE8FN/piqLb6ma88=;
        b=ZiU44UihTjPFm4vBM9gq5QoK/bNtmqe1eH9RBf387klB2o9PYnyszhzjHo8Lf349nQ
         Gg+/u7ZitKXafBcIIdQs/nwhHzKfltHjZv334tV+IP1WW9nkiUSyZN99ElSBbQCuamLC
         yel3TDv/i7gIcYOji6B/WmUv/0lMc9gWSpV8fsLP0eGIPzC8D69akg+Q6qlrNR8uZUmE
         Af754XMmAZGx39PHnuHMMRICbz5JqZm0lqHJKzzkQL6uFX35yX2Yc0fAP8Uv3yo1MRdg
         7pfY/JLaA4/AJ8ZbP2Rn36chBwDl/QZBCAmhvbcVgtcqd+EioXQueQlUOAHYSkOwIAHy
         jLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QjVe3lROVBqlIiyvJQbtG1oGTNmeE8FN/piqLb6ma88=;
        b=ADO7cbYpd7V85d7DIZ/y8iGja4dxDjEeTqydWzUcHMsEso5xNPXO4ONfxlGMPO0OMA
         769bocVMd+natgh+s4uWtuYeumdA3y+NJi2geiO8qGQ3X7DM3MnUGiI87zuFVsaQt36L
         1FBOtjpJ221qCMnwNnN2ksvE+cvtttT0anehfryyRMQCreI8sKMyYCGIsed974VT+dsg
         YZuzfupd+5ZSeA6+AsQuLHBboOmQv3pJhFAk4kMq+XTu4gKs9NQ1J+PT/JrFIIMQ6gsY
         Cbdrnl2TQs4z2W7o1j2t9Wpxknov5CVsFsa/FjZCU2yyfmamX1Z0gqqPGj4BzOA80fjl
         EoiA==
X-Gm-Message-State: AA+aEWZil9yp/8DNbZUR5vDcbi4EKyujQRum2ikT8yd5KWOXGG8J930q
        Ws+SxklZtXfSMjWx+zTMueDqZQ==
X-Google-Smtp-Source: AFSGD/XOn0vYX+lsI+bMf558aC+MgeaR8reEXGv8Kwdl4L8ZzmaZXj1VEHKcNoRF+PBY5mt+cgbkGQ==
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr22378940wrh.317.1545322246254;
        Thu, 20 Dec 2018 08:10:46 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id x10sm10941186wrn.29.2018.12.20.08.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 08:10:45 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: meson: libretech-cc: switch eMMC to 1.8v
Date:   Thu, 20 Dec 2018 17:10:37 +0100
Message-Id: <20181220161037.23756-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181220161037.23756-1-jbrunet@baylibre.com>
References: <20181220161037.23756-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While some 3.3v eMMC 4.0 are available from libretech, the default
option for the aml-s905x-cc seems to 1.8v 5.0 modules.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts    | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index daad007fac1f..d0d202cf7161 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -118,8 +118,8 @@
 	vddio_boot: regulator-vddio_boot {
 		compatible = "regulator-fixed";
 		regulator-name = "VDDIO_BOOT";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
 	};
 };
 
@@ -254,8 +254,9 @@
 
 	bus-width = <8>;
 	cap-mmc-highspeed;
-	mmc-ddr-3_3v;
-	max-frequency = <50000000>;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	max-frequency = <200000000>;
 	disable-wp;
 
 	mmc-pwrseq = <&emmc_pwrseq>;
-- 
2.19.2

