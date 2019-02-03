Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46102C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21839218F0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfBCNuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:50:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52878 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727927AbfBCNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:44 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9W-0003tg-FW; Sun, 03 Feb 2019 13:49:42 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9U-0006oo-6I; Sun, 03 Feb 2019 14:49:40 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        "Krzysztof Kozlowski" <krzk@kernel.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.55010683@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 023/305] ARM: dts: exynos: Disable pull control for
 MAX8997 interrupts on Origen
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit f5e758b8358f6c27e8a351ddf0b441a64cdabb94 upstream.

PMIC_IRQB and PMIC_KEYINB lines on Exynos4210-based Origen board have
external pull-up resistors, so disable any pull control for those lines
in respective pin controller node. This fixes support for MAX8997
interrupts and enables operation of wakeup from MAX8997 RTC alarm.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 17419726aaa1 ("ARM: dts: add max8997 device node for exynos4210-origen board")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
[bwh: Backported to 3.16:
 - Use literal 0 instead of EXYNOS_PIN_PULL_NONE
 - Adjust context, indentation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/boot/dts/exynos4210-origen.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -115,6 +115,8 @@
 			reg = <0x66>;
 			interrupt-parent = <&gpx0>;
 			interrupts = <4 0>, <3 0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&max8997_irq>;
 
 			max8997,pmic-buck1-dvs-voltage = <1350000>;
 			max8997,pmic-buck2-dvs-voltage = <1100000>;
@@ -334,3 +336,10 @@
 		};
 	};
 };
+
+&pinctrl_1 {
+	max8997_irq: max8997-irq {
+		samsung,pins = "gpx0-3", "gpx0-4";
+		samsung,pin-pud = <0>;
+	};
+};

