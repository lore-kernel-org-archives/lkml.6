Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D677DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921E52083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Q4ebC/dF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfA2Mlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:41:52 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:52014 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfA2Mlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:41:52 -0500
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id C300B10C1517;
        Tue, 29 Jan 2019 04:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548765712; bh=+uHavXaddJ5HFZry+KA7QdTYYrtwFxkGmDlzdkwAewM=;
        h=From:To:Cc:Subject:Date:From;
        b=Q4ebC/dFMS5nesLR4q/mbpbzCM0GA4kygsX3ljZxak0knVniumSsKU89RhpsgBgBx
         88vXJIxsR6PNUwMmnUDYMbKAs80ZUPrl5q7n+btoMkA02Ny9hAgd/5RWUlt3O2Rgk3
         wT87DWGZO9E6vlMI39sA1RFGrbu3jFcqRpvsE0FN6ztBNmvwWsg4PkmoNxjt1TOtln
         U/aeUJzisdvo0bsuCIRjuMdoQyBcNtuDucm5uN1J+QhJbNSrl2kB/AQ/3BFv9bYOu6
         aoH8kTd7ge2n7+YjOF112ZJQEjJCZWEfM2QBXDwMIxch78EeaY4xDIluprpd8ob64w
         LdPZ4p6vfOwDw==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.46])
        by mailhost.synopsys.com (Postfix) with ESMTP id 852B0A008B;
        Tue, 29 Jan 2019 12:41:49 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH] ARC: [plat-hsdk]: Add support of Vivante GPU
Date:   Tue, 29 Jan 2019 15:41:46 +0300
Message-Id: <20190129124146.5398-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HSDK board has built-in Vivante GPU IP which works perfectly fine
with Etnaviv driver, so let's use it.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
NOTE:
 * this patch has prerequisite:
   https://patchwork.kernel.org/patch/10766265/

 arch/arc/boot/dts/hsdk.dts      | 6 ++++++
 arch/arc/configs/hsdk_defconfig | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index 43f17b51ee89..ef892994f024 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -237,6 +237,12 @@
 				reg = <0>;
 			};
 		};
+
+		gpu_3d: gpu@90000 {
+			compatible = "vivante,gc";
+			reg = <0x90000 0x4000>;
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

