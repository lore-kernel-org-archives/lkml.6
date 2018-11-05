Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A39C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE46F204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="W81cXauW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE46F204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeKERHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:07:33 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33083 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeKERHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:07:32 -0500
Received: by mail-pf1-f194.google.com with SMTP id v68-v6so421724pfk.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 23:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bDli50Ufc215J41my+ABoEfiwBdmTRhNnLSYGE4kbB8=;
        b=W81cXauWw/ZYaDjuwOPtxBJERba4jvWmcTZkwjAMWjEqFb5ssHVgD6gTBtPQyFL4mT
         68701bTqVHs1mNlbQso+3njpeN2B9bi4fI4v6g05vxA8zWAhcImihbbFbcgUeqEkLlEi
         HMDt8iJpBSqGHVVfzKGVRrBwcCy6UEy0xhyjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bDli50Ufc215J41my+ABoEfiwBdmTRhNnLSYGE4kbB8=;
        b=HSFWjK/eBbVO/2bJUwv5EmQ2fSE+lKHl0XBIpxrTyn3x2B+FqFRYbpXmvfmvWrnbqp
         A6FxBMzqJnZF5TS7Ve01J1d+PUmYH4i+ISyzETkdqjNITGmjqs4B9E78QWfNU6xSjBYP
         y78oi4+9KJf+mmwohh86mx9IPs55CGzSCmV987S2EH2f3Um5vbq+GPk5PVtRsyCOTJwt
         Uva4VSCQcSxttBWcg6qBA+bT1GDvUmj98yv4ntUpTKv9WbvbDx71WEy1g2Rqjk7vy1EF
         hWaYH6KyWEMFRc6AKVbAHRDXlPjtQb63CLCyP6wDA9ebOlLBidFkb/w57x/YoKVnf4Hq
         ZD6w==
X-Gm-Message-State: AGRZ1gLAx8gy6Z6EM1me0sOuASkhSHneSt/dT68m/xlCpyft15qP44GD
        iqwtl6UrXCsZKE3wjIPMfB7YtQ==
X-Google-Smtp-Source: AJdET5fPeoC/0/hhCFddAq393wHNkiKJA/ZsgfYini041ZbeZ33sbxfPNUNBySEjLld1EWemg0Slrg==
X-Received: by 2002:a63:c141:: with SMTP id p1mr15718809pgi.424.1541404149412;
        Sun, 04 Nov 2018 23:49:09 -0800 (PST)
Received: from localhost.localdomain ([2405:204:638e:987d:4588:e264:3e7b:ee8])
        by smtp.gmail.com with ESMTPSA id n189-v6sm14790630pfn.163.2018.11.04.23.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 23:49:08 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@openedev.com>
Subject: [PATCH v2 3/3] arm64: allwinner: h6: Add OrangePi Lite2 initial support
Date:   Mon,  5 Nov 2018 13:18:42 +0530
Message-Id: <20181105074842.21988-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181105074842.21988-1-jagan@amarulasolutions.com>
References: <20181105074842.21988-1-jagan@amarulasolutions.com>
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
Changes for v2:
- none

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

