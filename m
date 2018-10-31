Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EDBC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565092080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FBH3nMdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565092080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbeKADgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:36:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44181 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730422AbeKADgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:36:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id j13-v6so4528161pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+xatb7GAYf1iPx9vohAUt8Lkjw2k2aXyj3u/SwygA8=;
        b=FBH3nMdqmuhgmU1teKrPqo+RPZdy7woz3XpS+xDhLiYfZqFsZpnN3Ko/FlUgfN6uRy
         mFjjj0xfiAvlITH8y/kWVADzGMIA0pevfjLh6ZPHlG+VD0dUwPnmYV31qC5biuJGNDem
         87h02ur1s2ENI+feTXe5we7NkQ8QYxvoqC2CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+xatb7GAYf1iPx9vohAUt8Lkjw2k2aXyj3u/SwygA8=;
        b=TKi/jOUhOLlAIrgrJWApHBV75Bac8raD/Z7aex3uXKPpY6wRcPtcMAEVJtObOZvYMm
         2bNh9z+oOqgc0GPGzIaw9YkoAJ98xy+Y5+fSwzDVDR5jRIYgoQ/uKgTax0wwHDGAb255
         mgFiIfnBDMLicbR92moi1hDfOIk+9qMBvYcJf/8cg05QM/X4mIGBZs4yWHVnbHqC4DYh
         GzACK5UUWf4E3VL+ghrHJcIuHaSTATFiX3KD+v66ISpWPhoZ/UQ7RVyuAtToeo8mEdQJ
         s8LEp0sfBGGdN+k2OQHYv9Doa91b7pQYkYT4mGRQuW7JQDiT5yrLXwkI/AKgAzJAA5Lj
         4a7A==
X-Gm-Message-State: AGRZ1gIJXFML6vd0mCic7Q7HNaoNTQ0ZEdlvWUUPYBBzMvMnEvaAnyrJ
        kZg2G5Xb4yexDaRz7XpFm+aqUw==
X-Google-Smtp-Source: AJdET5efM5Q9/RJtG3RBShKS55fQY3ny3lPoH5UqMxqt7cpndnVTUIFA3saEXkkcCrEQooxFGqLicg==
X-Received: by 2002:a62:1803:: with SMTP id 3-v6mr4538052pfy.21.1541011022962;
        Wed, 31 Oct 2018 11:37:02 -0700 (PDT)
Received: from localhost.localdomain ([2409:4070:221e:94ae:dc27:379e:a542:5441])
        by smtp.gmail.com with ESMTPSA id 72-v6sm37165627pfl.126.2018.10.31.11.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 11:37:02 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@openedev.com>
Subject: [PATCH 3/7] arm64: allwinner: h6: Add OrangePi Lite2 initial support
Date:   Thu,  1 Nov 2018 00:06:30 +0530
Message-Id: <20181031183634.29640-3-jagan@amarulasolutions.com>
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

OrangePi Lite2 is Allwinner H6 based open-source SBC,
which support:
- Allwinner H6 Quad-core 64-bit ARM Cortex-A53
- GPU Mali-T720
- 1GB LPDDR3 RAM
- AXP805 PMIC
- AP6356S Wifi/BT
- USB 2.0, USB 3.0 Host, OTG
- HDMI port
- 5V/2A DC power supply

Signed-off-by: Jagan Teki <jagan@openedev.com>
---
 arch/arm64/boot/dts/allwinner/Makefile                |  1 +
 .../boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts   | 11 +++++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 8d4f97f279e0..38f4a015637c 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -18,5 +18,6 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-lite2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
new file mode 100644
index 000000000000..e098a2475f2d
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (C) 2018 Jagan Teki <jagan@openedev.com>
+ */
+
+#include "sun50i-h6-orangepi.dtsi"
+
+/ {
+	model = "OrangePi Lite2";
+	compatible = "xunlong,orangepi-lite2", "allwinner,sun50i-h6";
+};
-- 
2.18.0.321.gffc6fa0e3

