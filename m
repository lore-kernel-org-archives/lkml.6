Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37880C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1390208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gLLlg8Kw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1390208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935295AbeFRO7t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:59:49 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:42203 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934986AbeFRO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:59:48 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D49C01E04A8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 16:59:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529333987; bh=fbVBoDs/j4FtmR8QqLiw8LAlJGvUmPH0z8jQJo8z7rk=;
        h=From:To:Cc:Subject:Date:From;
        b=gLLlg8KwH0nbydHBOJ07/pEk1SbM0xoO5sgKO3xM0ER479qOzBMNVoSHIF0XrivyY
         Ob7RE884l0mGW2NXvqJ4p39sasxUTgU5uULvFzGgT/aveKY93vGphh3UTNR3iF5YOp
         uEGoktdiK+SVC6ao3cbJxvxyQUeYoltECbX0+PhbDzx5KGzZdxVf0VwQLYWLbAUnJB
         HMVf8/PisxBtHjP/0pcs2O7sdGaBDeqy2YQeX64GkE4urdF1CunTxaDuNzq03QPTJq
         QJQBh3QvClpNpo8PLBFZ57xgZr6Kv519DlUNucp5PEs6h5GdYHKEBYVg9dNH8ZNEYC
         iP7prPtfoxnyA==
Received: from pt02.synopsys.com (pt02.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id CD779507C;
        Mon, 18 Jun 2018 07:59:45 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id 2BE273D720;
        Mon, 18 Jun 2018 15:59:45 +0100 (WEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     Vineet.Gupta1@synopsys.com, Eugeniy.Paltsev@synopsys.com,
        Alexey.Brodkin@synopsys.com, robh@kernel.org, sboyd@codeaurora.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH] ARC: Add PCIe support for ARC HSDK platform
Date:   Mon, 18 Jun 2018 15:59:34 +0100
Message-Id: <3e9a2f384fd831fb2639ad99ec43ce0f019ac17c.1529333762.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCI support to the ARC HSDK platform allowing to use the generic PCI
setup functions.

Add GPIO interrupt configuration function on ARC HSDK platform and
configures it to PCI support.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 arch/arc/plat-hsdk/Kconfig    |  1 +
 arch/arc/plat-hsdk/platform.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arc/plat-hsdk/Kconfig b/arch/arc/plat-hsdk/Kconfig
index 19ab3cf..556bc5e 100644
--- a/arch/arc/plat-hsdk/Kconfig
+++ b/arch/arc/plat-hsdk/Kconfig
@@ -9,3 +9,4 @@ menuconfig ARC_SOC_HSDK
 	bool "ARC HS Development Kit SOC"
 	select CLK_HSDK
 	select RESET_HSDK
+	select MIGHT_HAVE_PCI
diff --git a/arch/arc/plat-hsdk/platform.c b/arch/arc/plat-hsdk/platform.c
index 2958aed..31adda7 100644
--- a/arch/arc/plat-hsdk/platform.c
+++ b/arch/arc/plat-hsdk/platform.c
@@ -42,6 +42,45 @@ static void __init hsdk_init_per_cpu(unsigned int cpu)
 #define SDIO_UHS_REG_EXT	(SDIO_BASE + 0x108)
 #define SDIO_UHS_REG_EXT_DIV_2	(2 << 30)
 
+#define HSDK_GPIO_INTC          (ARC_PERIPHERAL_BASE + 0x3000)
+#define GPIO_INTEN              (HSDK_GPIO_INTC + 0x30)
+#define GPIO_INTMASK            (HSDK_GPIO_INTC + 0x34)
+#define GPIO_INTTYPE_LEVEL      (HSDK_GPIO_INTC + 0x38)
+#define GPIO_INT_POLARITY       (HSDK_GPIO_INTC + 0x3c)
+
+#define GPIO_BLUETOOTH_INT	0x00000001
+#define GPIO_HAPS_INT		0x00000004
+#define GPIO_AUDIO_INT		0x00000008
+/* PMOD_A header */
+#define GPIO_PIN_08_INT		0x00000100
+#define GPIO_PIN_09_INT		0x00000200
+#define GPIO_PIN_10_INT		0x00000400
+#define GPIO_PIN_11_INT		0x00000800
+/* PMOD_B header */
+#define GPIO_PIN_12_INT		0x00001000
+#define GPIO_PIN_13_INT		0x00002000
+#define GPIO_PIN_14_INT		0x00004000
+#define GPIO_PIN_15_INT		0x00008000
+/* PMOD_C header */
+#define GPIO_PIN_16_INT		0x00010000
+#define GPIO_PIN_17_INT		0x00020000
+#define GPIO_PIN_18_INT		0x00040000
+#define GPIO_PIN_19_INT		0x00080000
+#define GPIO_PIN_20_INT		0x00100000
+#define GPIO_PIN_21_INT		0x00200000
+#define GPIO_PIN_22_INT		0x00400000
+#define GPIO_PIN_23_INT		0x00800000
+static void __init hsdk_enable_gpio_intc_wire(void)
+{
+	u32 val = GPIO_HAPS_INT;
+
+	iowrite32(0xffffffff, (void __iomem *) GPIO_INTMASK);
+	iowrite32(~val, (void __iomem *) GPIO_INTMASK);
+	iowrite32(0x00000000, (void __iomem *) GPIO_INTTYPE_LEVEL);
+	iowrite32(0xffffffff, (void __iomem *) GPIO_INT_POLARITY);
+	iowrite32(val, (void __iomem *) GPIO_INTEN);
+}
+
 static void __init hsdk_init_early(void)
 {
 	/*
@@ -62,6 +101,8 @@ static void __init hsdk_init_early(void)
 	 * minimum possible div-by-2.
 	 */
 	iowrite32(SDIO_UHS_REG_EXT_DIV_2, (void __iomem *) SDIO_UHS_REG_EXT);
+
+	sdk_enable_gpio_intc_wire();
 }
 
 static const char *hsdk_compat[] __initconst = {
-- 
2.7.4


