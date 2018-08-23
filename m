Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79F7C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B16208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B16208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733183AbeHWMaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:30:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55712 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHWMay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:30:54 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DB8FABBF;
        Thu, 23 Aug 2018 09:02:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 226/324] ARC: [plat-hsdk]: Configure APB GPIO controller on ARC HSDK platform
Date:   Thu, 23 Aug 2018 09:54:52 +0200
Message-Id: <20180823075007.455243494@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

[ Upstream commit ec58ba16e174d7ca24c8955a21cd0a53e0c32fdf ]

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

Acked-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arc/plat-hsdk/platform.c |   62 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

--- a/arch/arc/plat-hsdk/platform.c
+++ b/arch/arc/plat-hsdk/platform.c
@@ -42,6 +42,66 @@ static void __init hsdk_init_per_cpu(uns
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


