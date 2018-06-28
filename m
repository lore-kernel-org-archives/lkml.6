Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E398C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BA727186
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OVATpgcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BA727186
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965066AbeF1JvP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:51:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53491 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935167AbeF1JvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:51:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id b188-v6so2768641wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zl6Zkhd6RSRgOPhjTAu+UC5GorIb1NbgtctHViJe4Kw=;
        b=OVATpgcPD1IqmnUQBBWXJkbDE7/mpdfvc3W4MIIlEqISKairy4srck4Q9BnGzZZ3Dx
         AmVIgEYW+tCc6zR6pS88XLjUAGq/yynsu03VmNU99jXPHVyBHu1STBbwb8/9wE0gHV1q
         gjKCwDYxso+QEjhH8YVdgx9F58BWG8pnXpTfLKHro3crNEudTenw4ueCATNixnvnJqyT
         ejRDP5Nx/64qVgRgtUIvVFa1bTeHCKysyhSF7BrtwAh1NlBcbkEYpHfuScdwXTHxdL2e
         AVMVwBBPr18EoCis/hv/iLAoDRWMU/gW+5apTlCrOQhrfMFuZkKp+GYO3OM2tsEz3hhl
         ADCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zl6Zkhd6RSRgOPhjTAu+UC5GorIb1NbgtctHViJe4Kw=;
        b=lhnFdECdLZ1IK7Iup2xlYbrrnk/KtC2QcZ6gVElQxwz0te8itqPHWp7th7nbh2L4EA
         ihlj96c9eHhCfltalk36TYd1hGh2hXaL+Z2bThMH66PSXKEixUWBeI6KoMJZ5e02pMTw
         cCAfUuMtdrrjqCF2xOBA8F+8+uNxUyAmKGZae840J5wRBygo7hGDvGnuAalO03ns/O7f
         ViIcK4ocMErHtg30WNs+aMSXGRaPqzAfe9nciT0AUNstcLWQCb+XsqwyCX1vs6wHSJgk
         JDbVJcWmadU5L9tcBTwcHHhtJHpAcq5WaTFhu6p4up19S1Qqf6D+U05JeTy0GJLfQ/Ok
         HY7A==
X-Gm-Message-State: APt69E09aPZ8PQYZ9Bll/3xatfDQrPmMk68I/fH7EPliMJHSvaLcOEzF
        Cb0scgTyD7XIJtgOu0SeNTKHfg==
X-Google-Smtp-Source: AAOMgpdV+oeTHUrK1+jcUcNq9hwyN2NZJbCdT+twPGwfbaswcyQ8q5U/NdHP2yLt0+MUPuShixcZTg==
X-Received: by 2002:a1c:3307:: with SMTP id z7-v6mr8210529wmz.114.1530179462450;
        Thu, 28 Jun 2018 02:51:02 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w67-v6sm6413476wmw.0.2018.06.28.02.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 02:51:01 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM64: dts: meson-axg: add s400 main 12v supply
Date:   Thu, 28 Jun 2018 11:50:53 +0200
Message-Id: <20180628095054.13433-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628095054.13433-1-jbrunet@baylibre.com>
References: <20180628095054.13433-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a fixed regulator for the main 12v which is the main power supply
of the board.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index d926f8956db8..0b655570b7c2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -16,6 +16,13 @@
 		serial1 = &uart_A;
 	};
 
+	main_12v: regulator-main_12v {
+		compatible = "regulator-fixed";
+		regulator-name = "12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
 	vddio_boot: regulator-vddio_boot {
 		compatible = "regulator-fixed";
 		regulator-name = "VDDIO_BOOT";
-- 
2.14.4

