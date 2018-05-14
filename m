Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbeENV5L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:57:11 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41336 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752090AbeENV5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:57:07 -0400
X-Google-Smtp-Source: AB8JxZpl1SdoGDQKMJF/CWepe8SS6PBlFaSLxax7TjarmPtCCdAeVzJCaS7BJT5iI/HelWf1sI4f+Q==
From: Thomas Hebb <tommyhebb@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Hebb <tommyhebb@gmail.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Synaptics
        Berlin SoC support),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH] ARM: dts: chromecast: override bad bootloader memory info
Date: Mon, 14 May 2018 17:56:45 -0400
Message-Id: <20180514215645.17592-2-tommyhebb@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Chromecast, the bootloader provides us with an ATAG_MEM of
start=0x01000000 and size=0x3eff8000. This is clearly incorrect, as the
range given encompasses nearly a GiB but the Chromecast only has 512MiB
of RAM! Additionally, this causes the kernel to be decompressed at
0x00008000, below the claimed beginning of RAM, and so the boot fails.

Since the existing ATAG parsing code runs before the kernel is even
decompressed and irrevocably patches the device tree, don't even try
to bypass it. Instead, use the "linux,usable-memory" property instead
of the "reg" property to define the real range. The ATAG code only
overwrites reg, but linux,usable-memory is checked first in the OF
driver, so the fact that reg gets changed makes no difference.

Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
---
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
index 20f31cdeaf38..54221f55bfa2 100644
--- a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
+++ b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
@@ -52,7 +52,17 @@
 
 	memory@0 {
 		device_type = "memory";
-		reg = <0x00000000 0x20000000>; /* 512 MB */
+
+		/*
+		 * We're using "linux,usable-memory" instead of "reg" here
+		 * because the (signed and encrypted) bootloader that shipped
+		 * with this device provides an incorrect memory range in
+		 * ATAG_MEM. Linux helpfully overrides the "reg" property with
+		 * data from the ATAG, so we can't specify the proper range
+		 * normally. Fortunately, this alternate property is checked
+		 * first by the OF driver, so we can (ab)use it instead.
+		 */
+		linux,usable-memory = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
 	leds {
-- 
2.17.0
