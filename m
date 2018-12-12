Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4988C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885492084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885492084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbeLLXvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:51:55 -0500
Received: from anholt.net ([50.246.234.109]:59072 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbeLLXvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:51:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 5274110A1DB2;
        Wed, 12 Dec 2018 15:51:53 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id L90MOFdNcoqB; Wed, 12 Dec 2018 15:51:51 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 4811110A1D6F;
        Wed, 12 Dec 2018 15:51:51 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 3F86C2FE36F0; Wed, 12 Dec 2018 15:51:50 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v4 4/5] ARM: bcm283x: Extend the WDT DT node out to cover the whole PM block. (v4)
Date:   Wed, 12 Dec 2018 15:51:49 -0800
Message-Id: <20181212235150.6491-5-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181212235150.6491-1-eric@anholt.net>
References: <20181212235150.6491-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was covering part of the PM block's range, up to the WDT regs.  To
support the rest of the PM block's functionality, we need the full
register range plus the AXI Async Bridge regs for PM sequencing.

This doesn't convert any of the consumers over to the new binding yet,
since we will need to be careful in coordinating our usage of firmware
services that might power domains on and off versus the bcm2835-pm
driver's access of those same domains.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v4: Add the system-power-controller node.

 arch/arm/boot/dts/bcm283x.dtsi | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 31b29646b14c..20ed8b1da11b 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -121,8 +121,17 @@
 		};
 
 		watchdog@7e100000 {
-			compatible = "brcm,bcm2835-pm-wdt";
-			reg = <0x7e100000 0x28>;
+			compatible = "brcm,bcm2835-pm", "brcm,bcm2835-pm-wdt";
+			#power-domain-cells = <1>;
+			#reset-cells = <1>;
+			reg = <0x7e100000 0x114>,
+			      <0x7e00a000 0x24>;
+			clocks = <&clocks BCM2835_CLOCK_V3D>,
+				 <&clocks BCM2835_CLOCK_PERI_IMAGE>,
+				 <&clocks BCM2835_CLOCK_H264>,
+				 <&clocks BCM2835_CLOCK_ISP>;
+			clock-names = "v3d", "peri_image", "h264", "isp";
+			system-power-controller;
 		};
 
 		clocks: cprman@7e101000 {
-- 
2.20.0.rc1

