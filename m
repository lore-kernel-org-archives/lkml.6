Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED65C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A7E259BD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HOG5EKb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A7E259BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933282AbeFYM5C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:57:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51640 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752590AbeFYM5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:57:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id w137-v6so3840180wmw.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 05:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=UCc3wHAmQeJ56mmCgytTZ4HN/sKKf/fo7z+QUtpnU1s=;
        b=HOG5EKb5jyl9xVRsyR8mT20kTLOBaB6fHBHc8+93qoClPy7+4rLyN0+rDYTJ8TQASI
         idvh3jqQONlLZFgXR3ZagaFIKi2OPdLSM/PXd7U/jJTsE0WUKZ5KJ5khtLf4XFNLoDJJ
         Vcoi71aIWLu+dYDp1F98oP4P66eIrZyS/lWvQif5YM5toU8ei6kp8twa/mboT0HmJYbA
         6VqEEbtG8wCWn641avHbeTlYIea7Sb5+Gwhy7OcK6lUnxWjV85T63LZBamSezDtoxqNd
         8PDMRbV7sGV6B42K37064t27uOmTJiyjeI+6ZAmQggHDVFwB5bYI7cd4OKPcANdcFOFq
         7FnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UCc3wHAmQeJ56mmCgytTZ4HN/sKKf/fo7z+QUtpnU1s=;
        b=kuK9L4d73+hnseKcpe2+kMoKDg6sQgyQ5MxVCk+g0cDxSxudrHtuq/TxmhX28bSZEf
         36wCatvavWbFuWQUtYK48KwmTByDrSAKFzBcb61gVWe2uNjHeYvXXqpU5quxXMLS/0kK
         0NJJXW2W9Mcxn8qZf8069y8cF9X1RaqsS2nynU4qZTEv4Ha4M2junGPY2FETzvHxP3Hm
         IO7H8kemS66QMsop4iGQnG6kckmUqMmytZHo66+g8iQy67C2AvwjP5K4s2BbyklTuP2o
         99ZWqhxaADKSDB0UaPCRGpBEOdzFIGG4TUT15A5yRWbFhzuleP1SwU/kR6Ng4UPBZrJ8
         lU7Q==
X-Gm-Message-State: APt69E35dzrlJeIBIolHe+d+h9iEMxWNFNwHo1eB9QzHAaSE1FpSadNq
        My/yONtxMcLuFkQt8Cscx2RJ6Q==
X-Google-Smtp-Source: ADUXVKLP4TeEYP7VJvtnLK2pyDHvUFpl98S+jDzgD/8eI8eVIjWr2e2U22ZCIignDzhX3c5ZOD6H1g==
X-Received: by 2002:a1c:6e19:: with SMTP id j25-v6mr923129wmc.30.1529931419664;
        Mon, 25 Jun 2018 05:56:59 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h77-v6sm14146551wmd.9.2018.06.25.05.56.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 05:56:59 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: dts: meson-axg: fix ethernet stability issue
Date:   Mon, 25 Jun 2018 14:56:53 +0200
Message-Id: <20180625125653.3404-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the odroid-c2 and wetek, the s400 uses the RTL8211F and seems to
suffer from the kind of stability issue.

Doing an iperf3 download test, we can see a significant number of LPI
interrupts on the tx path. After a short while (5 to 15 seconds), the
network connection dies. If using rootfs over NFS, the connection may
also break during the boot sequence.

We still don't have a real explanation for this problem so let's disable
EEE once again.

Fixes: f6f6ac914b82 ("ARM64: dts: meson-axg: enable ethernet for A113D S400 board")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 4b3331fbfe39..dff9b15eb3c0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -66,9 +66,22 @@
 
 &ethmac {
 	status = "okay";
-	phy-mode = "rgmii";
 	pinctrl-0 = <&eth_rgmii_y_pins>;
 	pinctrl-names = "default";
+	phy-handle = <&eth_phy0>;
+	phy-mode = "rgmii";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth_phy0: ethernet-phy@0 {
+			/* Realtek RTL8211F (0x001cc916) */
+			reg = <0>;
+			eee-broken-1000t;
+		};
+	};
 };
 
 &uart_A {
-- 
2.14.4

