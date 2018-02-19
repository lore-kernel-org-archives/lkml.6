Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeBSITJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 03:19:09 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:54568 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbeBSITG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 03:19:06 -0500
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clabbe.montjoie@gmail.com,
        thomas.petazzoni@bootlin.com, mylene.josserand@bootlin.com,
        quentin.schulz@bootlin.com
Subject: [PATCH v3 6/7] arm: dts: sun8i: a83t: Fix undefined offset with virtual timer
Date: Mon, 19 Feb 2018 09:18:36 +0100
Message-Id: <20180219081837.15482-7-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180219081837.15482-1-mylene.josserand@bootlin.com>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM architected timers use an offset between their physical and
virtual counters. That offset should be configured by the bootloader
in CNTVOFF.

However, the A83t bootloader fails to do so, and we end up with an
undefined offset (which in our case is random), meaning that each CPU
will have a different time, which isn't working very well.

Fix that by setting the arm,cpu-registers-not-fw-configured that will
make Linux use the physical timers instead of the virtual ones. One
possible side effect would be that the virtualization features would
be disabled. However, due to the way the GIC has been integrated in
the system, it is already unusable so we're effectively not losing any
feature.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index e97a6d17b8d0..b9bdb891cf2f 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -123,6 +123,7 @@
 			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+		arm,cpu-registers-not-fw-configured;
 	};
 
 	clocks {
-- 
2.11.0
