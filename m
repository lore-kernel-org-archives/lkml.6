Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB1EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D8422360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D8422360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbeKNDBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:01:54 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727042AbeKNDBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:01:53 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 124D29A8FF2D9;
        Wed, 14 Nov 2018 01:02:53 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Wed, 14 Nov 2018 01:02:49 +0800
From:   John Garry <john.garry@huawei.com>
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <maxime.ripard@bootlin.com>, <wens@csie.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <icenowy@aosc.io>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] arm64: sunxi: Enable REGMAP_MMIO to fix linker error
Date:   Wed, 14 Nov 2018 01:04:25 +0800
Message-ID: <1542128665-78302-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following linker failure can be seen for a certain heavily reduced
defconfig:
drivers/soc/sunxi/sunxi_sram.o: In function `sunxi_sram_probe':
drivers/soc/sunxi/sunxi_sram.c:353: undefined reference to `__devm_regmap_init_mmio_clk'
drivers/soc/sunxi/sunxi_sram.c:353:(.text+0x3c4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__devm_regmap_init_mmio_clk'

It would seem that the sunxi sram driver implicitly depended on config
REGMAP_MMIO.

To solve, select config REGMAP_MMIO for ARCH_SUNXI. This seems a better
option than selecting from the respective driver config as this just
defaults to ARCH_SUNXI.

Fixes: 5828729bebbb ("soc: sunxi: export a regmap for EMAC clock reg on A64")
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 51bc479..c8a6ad3 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -12,6 +12,7 @@ config ARCH_SUNXI
 	select ARCH_HAS_RESET_CONTROLLER
 	select GENERIC_IRQ_CHIP
 	select PINCTRL
+	select REGMAP_MMIO
 	select RESET_CONTROLLER
 	help
 	  This enables support for Allwinner sunxi based SoCs like the A64.
-- 
1.9.1

