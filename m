Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76728C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C4023F04
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GixpAFpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C4023F04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753871AbeGFKc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:32:58 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:60562 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753535AbeGFKc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:32:56 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E869824E2376;
        Fri,  6 Jul 2018 03:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1530873176; bh=tZA8AM0LhOJ+w/ACIpq1SEWzD5JXisGGDHtHvAPYyFQ=;
        h=From:To:Cc:Subject:Date:From;
        b=GixpAFpQ2Rdc7YaL/oohezE1EJaTABZaB5mmlTg7V7QBimDTpfnBgTNdUTh+jfE+t
         0kKzqfmi7Lpdv6sqXLbXtRntH2FOL0TzwwXAz7k9dsSFmri7Wr7cqtVbUw+l8XQkJP
         EDbc4uFzPUKqVLWGPnDNCgrc702mIyLIPcAOFJxjlTMZ0pj3C8/sxx1Oo7tOG/IdqQ
         8gbo8/hpUQNvG6EeuyEh4KlWd6LEc6Y8ZjYpUijGfJhOzHkdepB+VFKQ7E07GY/7L0
         4Bu23+WlvhaqeuDyfjZYiXh5uziExkDlmsbaOTJnLzeb9SYm/ZpIE+QCt2/VLuza3y
         W8svA5/I4MIXg==
Received: from pt02.synopsys.com (pt02.internal.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6B57C5706;
        Fri,  6 Jul 2018 03:32:55 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id BC2C13EB12;
        Fri,  6 Jul 2018 11:32:54 +0100 (WEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     Vineet.Gupta1@synopsys.com, eugeniy.paltsev@synopsys.com,
        robh@kernel.org, sboyd@codeaurora.org, Alexey.Brodkin@synopsys.com,
        joao.pinto@synopsys.com
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v2] ARC: Configure APB GPIO controller on ARC HSDK platform
Date:   Fri,  6 Jul 2018 11:32:37 +0100
Message-Id: <5f3c59cdf0f4eb8bf22ca27031187fd866ffbecc.1530872741.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of HSDK we have intermediate INTC in for of DW APB GPIO controller
which is used as a de-bounce logic for interrupt wires that come from
outside the board.

We cannot use existing "irq-dw-apb-ictl" driver here because all input
lines are routed to corresponding output lines but not muxed into one
line (this is configured in RTL and we cannot change this in software).

But even if we add such a feature to "irq-dw-apb-ictl" driver that won't
benefit us as higher-level INTC (in case of HSDK it is IDU) anyways has
per-input control so adding fully-controller intermediate INTC will only
bring some overhead on interrupt processing but no other benefits.

Thus we just do one-time configuration of DW APB GPIO controller and
forget about it.

Based on implementation available on arch/arc/plat-axs10x/axs10x.c file.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 arch/arc/plat-hsdk/platform.c | 62 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arc/plat-hsdk/platform.c b/arch/arc/plat-hsdk/platform.c
index 2958aed..2588b84 100644
--- a/arch/arc/plat-hsdk/platform.c
+++ b/arch/arc/plat-hsdk/platform.c
@@ -42,6 +42,66 @@ static void __init hsdk_init_per_cpu(unsigned int cpu)
 #define SDIO_UHS_REG_EXT	(SDIO_BASE + 0x108)
 #define SDIO_UHS_REG_EXT_DIV_2	(2 << 30)
 
+#define HSDK_GPIO_INTC          (ARC_PERIPHERAL_BASE + 0x3000)
+
+static void __init hsdk_enable_gpio_intc_wire(void)
+{
+	/*
+	 * Peripherals on CPU Card are wired to cpu intc via intermediate
+	 * DW APB GPIO blocks (mainly for debouncing)
+	 *
+	 *         ---------------------
+	 *        |  snps,archs-intc  |
+	 *        ---------------------
+	 *                  |
+	 *        ----------------------
+	 *        | snps,archs-idu-intc |
+	 *        ----------------------
+	 *         |   |     |   |    |
+	 *         | [eth] [USB]    [... other peripherals]
+	 *         |
+	 * -------------------
+	 * | snps,dw-apb-intc |
+	 * -------------------
+	 *  |      |   |   |
+	 * [Bt] [HAPS]   [... other peripherals]
+	 *
+	 * Current implementation of "irq-dw-apb-ictl" driver doesn't work well
+	 * with stacked INTCs. In particular problem happens if its master INTC
+	 * not yet instantiated. See discussion here -
+	 * https://lkml.org/lkml/2015/3/4/755
+	 *
+	 * So setup the first gpio block as a passive pass thru and hide it from
+	 * DT hardware topology - connect intc directly to cpu intc
+	 * The GPIO "wire" needs to be init nevertheless (here)
+	 *
+	 * One side adv is that peripheral interrupt handling avoids one nested
+	 * intc ISR hop
+	 *
+	 * According to HSDK User's Manual [1], "Table 2 Interrupt Mapping"
+	 * we have the following GPIO input lines used as sources of interrupt:
+	 * - GPIO[0] - Bluetooth interrupt of RS9113 module
+	 * - GPIO[2] - HAPS interrupt (on HapsTrak 3 connector)
+	 * - GPIO[3] - Audio codec (MAX9880A) interrupt
+	 * - GPIO[8-23] - Available on Arduino and PMOD_x headers
+	 * For now there's no use of Arduino and PMOD_x headers in Linux
+	 * use-case so we only enable lines 0, 2 and 3.
+	 *
+	 * [1] https://github.com/foss-for-synopsys-dwc-arc-processors/ARC-Development-Systems-Forum/wiki/docs/ARC_HSDK_User_Guide.pdf
+	 */
+#define GPIO_INTEN              (HSDK_GPIO_INTC + 0x30)
+#define GPIO_INTMASK            (HSDK_GPIO_INTC + 0x34)
+#define GPIO_INTTYPE_LEVEL      (HSDK_GPIO_INTC + 0x38)
+#define GPIO_INT_POLARITY       (HSDK_GPIO_INTC + 0x3c)
+#define GPIO_INT_CONNECTED_MASK	0x0d
+
+	iowrite32(0xffffffff, (void __iomem *) GPIO_INTMASK);
+	iowrite32(~GPIO_INT_CONNECTED_MASK, (void __iomem *) GPIO_INTMASK);
+	iowrite32(0x00000000, (void __iomem *) GPIO_INTTYPE_LEVEL);
+	iowrite32(0xffffffff, (void __iomem *) GPIO_INT_POLARITY);
+	iowrite32(GPIO_INT_CONNECTED_MASK, (void __iomem *) GPIO_INTEN);
+}
+
 static void __init hsdk_init_early(void)
 {
 	/*
@@ -62,6 +122,8 @@ static void __init hsdk_init_early(void)
 	 * minimum possible div-by-2.
 	 */
 	iowrite32(SDIO_UHS_REG_EXT_DIV_2, (void __iomem *) SDIO_UHS_REG_EXT);
+
+	hsdk_enable_gpio_intc_wire();
 }
 
 static const char *hsdk_compat[] __initconst = {
-- 
2.7.4


