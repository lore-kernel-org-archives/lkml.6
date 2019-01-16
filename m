Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB905C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F640205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xtzWHJB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbfAPQwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:52:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39933 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729915AbfAPQwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:52:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so7741649wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dUNj70748HNnwQMeBYqdWeK5DbMKqYQpIgSDSRP1d7Y=;
        b=xtzWHJB5UEMKRrAmCfxZB/aeiqtD9KVgCKGMg2KnAYSp7ooLd3kQROL/ZMpcKcSiZx
         JoIf5TUz4ls8RjN4RTKRB6fCzg8XIgF2Ibg9FUcADrm5g9MVhn+txknwXWhPA8NARNFD
         wi1/4NjHP2VS4QrYXKgBzDIlJ/DYDhwRC9bFxPk8YhCck6z+QvinmJ2+v+TBnJXPROdy
         SChfcT9vGDA448hadUOEMc+khus9pFpdDC+XJOpR8oSoNO3yjLEGOySlqpEOs31SXUUo
         VJZAguJKxDTpJLgKMgc+sphN1DjOknhs5bw4pRcRQI0JhAKEgcKiuU++fodpQCPfMm0K
         ZRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dUNj70748HNnwQMeBYqdWeK5DbMKqYQpIgSDSRP1d7Y=;
        b=n5hWSc8TpBTxf1X7goh9dslVzvZpW67OuqWearapaZUdyx0ew7Ngcup3uYP7eAV6gl
         05rsJTRpzfOItT/nJB4OUT23G7wTledH8umgdrDCAnQDGRKhVaT7trKlKO/viTXhJ1in
         GcsKRcDwdDwUpTZq20rq58fo389EV95c1IH08DvYT9bzXGHuT++jRM/nHeeBojU+rRTT
         T/oNjYKSXn9ouNiPmbcbrCBxAFnphDWTEv5Qx3FADvMzf3/8RbtJ02huphy/pRtu8RXr
         JhM8+TIYg5SWmi3FdBHPD6qj4bMRhLXz192quYdI4Fug+Ec1U4zhObE0oAXnhrkKBHDo
         XpWQ==
X-Gm-Message-State: AJcUuke2LMvJM9plR5vw/K25R7cwHu4zjgT8/QUzDAID0MI8wrOPXKDY
        QlxemEEW7AMXGUaeZU8YU8LBBQ==
X-Google-Smtp-Source: ALg8bN7IbKDsp3ZjcRkHs764YhGfJVPFUnU/1pmi+L+5c+9IULukCrCrYcplvURcQAIqMDS+Kd8SxQ==
X-Received: by 2002:adf:e284:: with SMTP id v4mr8067611wri.26.1547657568223;
        Wed, 16 Jan 2019 08:52:48 -0800 (PST)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a132sm46318997wmh.5.2019.01.16.08.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 08:52:47 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: fix g12a buses
Date:   Wed, 16 Jan 2019 17:52:36 +0100
Message-Id: <20190116165236.8330-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

periph and hiu bus addresses/size are wrong.
cbus, aobus and apb just don't exist in the memory map so remove them.

Fixes: 9c8c52f7cb4f ("arm64: dts: meson-g12a: add initial g12a s905d2 SoC DT support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 70 +++++++--------------
 1 file changed, 24 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 3b82a975c663..2aea5ba62fee 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -78,46 +78,40 @@
 		#size-cells = <2>;
 		ranges;
 
-		periphs: periphs@ff634000 {
+		periphs: bus@ff634400 {
 			compatible = "simple-bus";
-			reg = <0x0 0xff634000 0x0 0x2000>;
+			reg = <0x0 0xff634400 0x0 0x400>;
 			#address-cells = <2>;
 			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xff634000 0x0 0x2000>;
+			ranges = <0x0 0x0 0x0 0xff634400 0x0 0x400>;
 		};
 
-		hiubus: bus@ff63c000 {
+		hiu: bus@ff63c000 {
 			compatible = "simple-bus";
-			reg = <0x0 0xff63c000 0x0 0x1c00>;
+			reg = <0x0 0xff63c000 0x0 0x1400>;
 			#address-cells = <2>;
 			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
+			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1400>;
 		};
 
-		aobus: bus@ff800000 {
-			compatible = "simple-bus";
-			reg = <0x0 0xff800000 0x0 0x100000>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
-
-			uart_AO: serial@3000 {
-				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
-				reg = <0x0 0x3000 0x0 0x18>;
-				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>, <&xtal>, <&xtal>;
-				clock-names = "xtal", "pclk", "baud";
-				status = "disabled";
-			};
-
-			uart_AO_B: serial@4000 {
-				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
-				reg = <0x0 0x4000 0x0 0x18>;
-				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>, <&xtal>, <&xtal>;
-				clock-names = "xtal", "pclk", "baud";
-				status = "disabled";
-			};
+		uart_AO: serial@ff803000 {
+			compatible = "amlogic,meson-gx-uart",
+				     "amlogic,meson-ao-uart";
+			reg = <0x0 0xff803000 0x0 0x18>;
+			interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&xtal>, <&xtal>, <&xtal>;
+			clock-names = "xtal", "pclk", "baud";
+			status = "disabled";
+		};
+
+		uart_AO_B: serial@ff804000 {
+			compatible = "amlogic,meson-gx-uart",
+				     "amlogic,meson-ao-uart";
+			reg = <0x0 0xff804000 0x0 0x18>;
+			interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&xtal>, <&xtal>, <&xtal>;
+			clock-names = "xtal", "pclk", "baud";
+			status = "disabled";
 		};
 
 		gic: interrupt-controller@ffc01000 {
@@ -132,22 +126,6 @@
 			#interrupt-cells = <3>;
 			#address-cells = <0>;
 		};
-
-		cbus: bus@ffd00000 {
-			compatible = "simple-bus";
-			reg = <0x0 0xffd00000 0x0 0x25000>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x25000>;
-		};
-
-		apb: apb@ffe00000 {
-			compatible = "simple-bus";
-			reg = <0x0 0xffe00000 0x0 0x200000>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x200000>;
-		};
 	};
 
 	timer {
-- 
2.20.1

