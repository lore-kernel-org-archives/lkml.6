Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D77C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14CF21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Cocny1Go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfBSKwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:52:30 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:54610 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfBSKw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:52:29 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 736DF10C167A;
        Tue, 19 Feb 2019 02:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550573549; bh=NAcZG6L+HcqA3SvuIi3PddQkswsVWEwjkwyqaFiA+GA=;
        h=From:To:Cc:Subject:Date:From;
        b=Cocny1GoVshGgTOxMwEFaFaTPaOMAPnmnz9fSA0tKfo/TTrpZqOk899QZnsiDqxsg
         hHcGh+AxlPGUtRarpuc5l0uRqV7v5vX3kT5NYRLTtkNrb8RFzifHec0As/bjQ1Z7Ya
         T4ZWa6l+5QKeLhmR1fqmbQcoveZGw59cvFkFO4mf4BfyqcktRe+VTDC/2u9AZ5pFd2
         zIT4IRCknLV0DIq07lR8nz9SQDayRGLwxg3pgRYEOJBumeZIeJ8kyU/lxN1iiX14FF
         w4LBw4HdKbJ5P+AQ3WNZbsqKtr/2ciSyeyea2yd8DBtkNVq3oFgeIf3R4+Br1Nbyqx
         itPySYwWyKemQ==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.8.62])
        by mailhost.synopsys.com (Postfix) with ESMTP id EB9F3A0090;
        Tue, 19 Feb 2019 10:52:27 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH] ARC: [plat-hsdk]: Enable AXI DW DMAC support
Date:   Tue, 19 Feb 2019 13:52:26 +0300
Message-Id: <20190219105226.20062-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
NOTE:
  Even if this patch have no logical dependency with gpu-enabling-patch
  (http://patchwork.ozlabs.org/patch/1034722/)
  gpu-enabling-patch should be applied first to avoid rebasing.

 arch/arc/boot/dts/hsdk.dts      | 27 +++++++++++++++++++++++++++
 arch/arc/configs/hsdk_defconfig |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index a26b3f532f32..46a6e1080b38 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -185,6 +185,18 @@
 			#clock-cells = <0>;
 		};
 
+		dmac_core_clk: dmac-core-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <400000000>;
+			#clock-cells = <0>;
+		};
+
+		dmac_cfg_clk: dmac-gpu-cfg-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <200000000>;
+			#clock-cells = <0>;
+		};
+
 		gmac: ethernet@8000 {
 			#interrupt-cells = <1>;
 			compatible = "snps,dwmac";
@@ -268,6 +280,21 @@
 			clock-names = "bus", "reg", "core", "shader";
 			interrupts = <28>;
 		};
+
+		dmac: dmac@80000 {
+			compatible = "snps,axi-dma-1.01a";
+			reg = <0x80000 0x400>;
+			interrupts = <27>;
+			clocks = <&dmac_core_clk>, <&dmac_cfg_clk>;
+			clock-names = "core-clk", "cfgr-clk";
+
+			dma-channels = <4>;
+			snps,dma-masters = <2>;
+			snps,data-width = <3>;
+			snps,block-size = <4096 4096 4096 4096>;
+			snps,priority = <0 1 2 3>;
+			snps,axi-max-burst-len = <16>;
+		};
 	};
 
 	memory@80000000 {
diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index 915e1cca31f8..5f1c772cb2fd 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -64,6 +64,8 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_DW=y
+CONFIG_DMADEVICES=y
+CONFIG_DW_AXI_DMAC=y
 CONFIG_EXT3_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
-- 
2.14.5

