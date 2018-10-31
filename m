Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D537ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10C62080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EMrQreV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10C62080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbeKADgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:36:39 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:35259 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730141AbeKADgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:36:39 -0400
Received: by mail-pg1-f175.google.com with SMTP id 32-v6so7793847pgu.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wHPgnCxqq5e0L9jJ6bVuEGeSV4D7Kq7aHeh6/Y3ccbE=;
        b=EMrQreV6Yi1OdKVIn3mcavYfygx+uGfowj7ltEWaFFo/xLaQJwyrIxoH2cJz8YmfWt
         E12j4obY1c8NgMf2Snm2qrW0onUE3yiHPDjjUzkWuRaAi0r5jhxG7uIpR70XzIdmZSLe
         NQcs4ugCwBWxdEX1XFairG+vNsiA+cahpX9Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wHPgnCxqq5e0L9jJ6bVuEGeSV4D7Kq7aHeh6/Y3ccbE=;
        b=kxSR2aOJp3mCvhsc8sgaU4zL6Ua8z6fBrG4wVmYry+6rSI+D7iq8ULf5yJKoK07Nj+
         tZC4W9Q48ztaF+phvxGqk0K9eSEII/P8L9j9S6XgFWdIXl+YvxlrqkZufrD0jEdyku8s
         GdIbz5jhkEZCXZtJ0iVUcuwYOWE+sjPUR5wrziDO6in0x1poAg/g9BjnxenAH9ySvDg6
         VqV4j2HwDurq1ka5SeEEUJkZ+6MHXehEYncaabfFuSC46PyQRSt3MRLsxzsF5wFW+F1M
         bxOIMwE7UVRfh4QmZch6jlryN10e1d0UE1XmdEcPq22vOSI3aMlYtYwGJDgb0ndFSbYq
         l+iA==
X-Gm-Message-State: AGRZ1gJtpe0uvuhTG8ZuJg8wHKM2tjRgPsOT5sJypFuHgU7A9UJOPFDa
        Qtfpq1arGL7OtBCgTyoi/zk4TA==
X-Google-Smtp-Source: AJdET5dIKqaeL7zBZUtwMgEeuzpgCaemCrL4QomOCbt2bDBlLxFL6ksUdMv3tbqYH4SljTb2D3VWAw==
X-Received: by 2002:a62:8145:: with SMTP id t66-v6mr4533951pfd.246.1541011045621;
        Wed, 31 Oct 2018 11:37:25 -0700 (PDT)
Received: from localhost.localdomain ([2409:4070:221e:94ae:dc27:379e:a542:5441])
        by smtp.gmail.com with ESMTPSA id 72-v6sm37165627pfl.126.2018.10.31.11.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 11:37:25 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@openedev.com>
Subject: [RFC PATCH 7/7] arm64: allwinner: h6: orangepi-liet2: Enable AP6356S WiFi support
Date:   Thu,  1 Nov 2018 00:06:34 +0530
Message-Id: <20181031183634.29640-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181031183634.29640-1-jagan@amarulasolutions.com>
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagan Teki <jagan@openedev.com>

Enable AP6356S WiFi/BT combo chip on Orangepi Lite2 board:
- WiFi SDIO interface is connected to MMC1
- WiFi WL-PMU-EN pin connected to gpio PM3: attach to mmc-pwrseq
- WiFi WL-WAKE-AP pin connected to gpio PM0
- 32kHz external oscillator gate clock from RTC

Signed-off-by: Jagan Teki <jagan@openedev.com>
---
Note:
- chip detected, but failed to connect
[  129.084504] brcmfmac: brcmf_sdio_hostmail: mailbox indicates firmware halted
[  135.906409] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout 

 .../allwinner/sun50i-h6-orangepi-lite2.dts    | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
index e098a2475f2d..b8012208c185 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
@@ -8,4 +8,31 @@
 / {
 	model = "OrangePi Lite2";
 	compatible = "xunlong,orangepi-lite2", "allwinner,sun50i-h6";
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rtc 1>;
+		clock-names = "ext_clock";
+		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* WL-REG-ON: PM3 */
+		post-power-on-delay-ms = <200>;
+	};
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&reg_cldo2>;
+	vqmmc-supply = <&reg_bldo3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&r_pio>;
+		interrupts = <1 0 IRQ_TYPE_LEVEL_LOW>;	/* WL-WAKE-AP: PM0 */
+		interrupt-names = "host-wake";
+	};
 };
-- 
2.18.0.321.gffc6fa0e3

