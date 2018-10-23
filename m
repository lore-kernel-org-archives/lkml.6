Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6B6C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29B120671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XEAj9F9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29B120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeJWUcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:32:39 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:44832 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbeJWUcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:32:39 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8525C10C0FF4;
        Tue, 23 Oct 2018 05:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1540296566; bh=d8aAbd6zN++3eczZmy7acLULZ4RQvQIQYDt3QoAcxNM=;
        h=From:To:Cc:Subject:Date:From;
        b=XEAj9F9Gx0U2FhqcG2vlcPxIVUsuKpOOLQus7UgGEszoz56dNNgYBfkbQ6+VC6s9p
         8pz407PRkHY0BLJcmxECcRJo/yegGLPJLOpchaKI3HKSCA86dUDGbnwE8ntrVHjSW3
         Shd39JN27x9eSxJcIOAGBA9/W1HNP3Sv95R9HkXTQjI4V1aLkR6JqlrIvpPPWiDGUv
         VH4y9aiUphpkK6KLli6b7ZYVZdsm2/dax1BHaVE/wQ0p8+lOwLHraJgVTlI9S9deo5
         UL3+KuDLaAy4x0JVaKDbGoyA6awNidlB4oiWFdBF/egldtYN+QSBkkTfPsimDME5rF
         ghxo98BdRtSuA==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.38])
        by mailhost.synopsys.com (Postfix) with ESMTP id B21543966;
        Tue, 23 Oct 2018 05:09:23 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: [plat-hsdk] Enable DW APB GPIO support
Date:   Tue, 23 Oct 2018 15:09:19 +0300
Message-Id: <20181023120919.11627-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable GPIO support on HSDK. HSDK SoC includes Synopsys
DesignWare DW_apb_gpio IP with 24 GPIOs mapped onto port A.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/boot/dts/hsdk.dts      | 15 +++++++++++++++
 arch/arc/configs/hsdk_defconfig |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index ef149f59929a..43f17b51ee89 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -222,6 +222,21 @@
 			bus-width = <4>;
 			dma-coherent;
 		};
+
+		gpio: gpio@3000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x3000 0x20>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gpio_port_a: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <24>;
+				reg = <0>;
+			};
+		};
 	};
 
 	memory@80000000 {
diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index 1dec2b4bc5e6..eca10b8baea5 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -45,6 +45,9 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_DWAPB=y
 # CONFIG_HWMON is not set
 CONFIG_DRM=y
 # CONFIG_DRM_FBDEV_EMULATION is not set
-- 
2.14.5

