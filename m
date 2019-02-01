Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685DEC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3777C218F0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gHFlgPYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfBAMMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:12:22 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:39330 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfBAMMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:12:21 -0500
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 48DF210C1358;
        Fri,  1 Feb 2019 04:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549023141; bh=fqROi6V+w4Wme87XQ0cMwRFlaq5JypspIoXi33wf73E=;
        h=From:To:Cc:Subject:Date:From;
        b=gHFlgPYzrvz+Cg2QiJLoeEohwDpAbjoii9wv95sH9atWiVKHtNT9DXvn0T8keAhTU
         cbShEGe/Hum5Z+nPQpLnfYz6QfrewWXwivtiytfcobLVelT4wLZhMsJo8Ny0kKhX1L
         pX+33MhSBoW9ETVPRQ0lX2YP9vY7sSEtK527hxId5TmEAR1XbDEI9aYFEDIoDEAcey
         9PJ2q0Mfw5T+Y/M5aJmhkuIMjMHqFGmPofIb261XNEmSWzizWXbXC9SOJdpyAJZSk1
         sB2ITSAtksUJdjko6/a3FD3gxdjgg0mDbymWSfITVE9UQWc3MH7Djr20e53RFoUCOx
         dBMCz5GkVtI4A==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.46])
        by mailhost.synopsys.com (Postfix) with ESMTP id D966BA0070;
        Fri,  1 Feb 2019 12:12:13 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH v2] ARC: [plat-hsdk]: Add support of Vivante GPU
Date:   Fri,  1 Feb 2019 15:12:11 +0300
Message-Id: <20190201121211.23701-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HSDK board has built-in Vivante GPU IP which works perfectly fine
with Etnaviv driver, so let's use it.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v1->v2:
 * Add clock inputs to etnaviv device tree node (reported by Lucas Stach)

 arch/arc/boot/dts/hsdk.dts      | 29 +++++++++++++++++++++++++++++
 arch/arc/configs/hsdk_defconfig |  2 +-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index 43f17b51ee89..df86d0818db8 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -167,6 +167,24 @@
 			#clock-cells = <0>;
 		};
 
+		gpu_core_clk: gpu-core-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <400000000>;
+			#clock-cells = <0>;
+		};
+
+		gpu_dma_clk: gpu-dma-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <400000000>;
+			#clock-cells = <0>;
+		};
+
+		gpu_cfg_clk: gpu-cfg-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <200000000>;
+			#clock-cells = <0>;
+		};
+
 		gmac: ethernet@8000 {
 			#interrupt-cells = <1>;
 			compatible = "snps,dwmac";
@@ -237,6 +255,17 @@
 				reg = <0>;
 			};
 		};
+
+		gpu_3d: gpu@90000 {
+			compatible = "vivante,gc";
+			reg = <0x90000 0x4000>;
+			clocks = <&gpu_dma_clk>,
+				 <&gpu_cfg_clk>,
+				 <&gpu_core_clk>,
+				 <&gpu_core_clk>;
+			clock-names = "bus", "reg", "core", "shader";
+			interrupts = <28>;
+		};
 	};
 
 	memory@80000000 {
diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index 87b23b7fb781..915e1cca31f8 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -52,6 +52,7 @@ CONFIG_GPIO_DWAPB=y
 CONFIG_DRM=y
 # CONFIG_DRM_FBDEV_EMULATION is not set
 CONFIG_DRM_UDL=y
+CONFIG_DRM_ETNAVIV=y
 CONFIG_FB=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_USB_EHCI_HCD=y
@@ -63,7 +64,6 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_DW=y
-# CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT3_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
-- 
2.14.5

