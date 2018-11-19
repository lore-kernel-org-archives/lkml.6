Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9B2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A727320870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsIKubNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A727320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbeKTC51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:57:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730241AbeKTC50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:57:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C92512086A;
        Mon, 19 Nov 2018 16:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645198;
        bh=LvAgt+iDQxS4nHAqYeZ+A9KBSvSiEwv5WR8r2efUBU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gsIKubNQHiHpnibA74XBm8z+978ekAXWYQQIgg/yUIsNQylSOpeyDQBq401aROzgs
         u/Z/QbDNwoHTECdlwKVHDwTApVxXEWVqSXj188QgLDK+TkFBGpcKXnf/CqYw1U5a7d
         4VspeEGyUakpBziSYEf+HVkthxsva4GJHPR74OgQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 074/205] MIPS: Loongson-3: Fix CPU UART irq delivery problem
Date:   Mon, 19 Nov 2018 17:26:21 +0100
Message-Id: <20181119162630.126177349@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d06f8a2f1befb5a3d0aa660ab1c05e9b744456ea ]

Masking/unmasking the CPU UART irq in CP0_Status (and redirecting it to
other CPUs) may cause interrupts be lost, especially in multi-package
machines (Package-0's UART irq cannot be delivered to others). So make
mask_loongson_irq() and unmask_loongson_irq() be no-ops.

The original problem (UART IRQ may deliver to any core) is also because
of masking/unmasking the CPU UART irq in CP0_Status. So it is safe to
remove all of the stuff.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20433/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: Huacai Chen <chenhuacai@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/loongson64/loongson-3/irq.c | 43 ++-------------------------
 1 file changed, 3 insertions(+), 40 deletions(-)

diff --git a/arch/mips/loongson64/loongson-3/irq.c b/arch/mips/loongson64/loongson-3/irq.c
index cbeb20f9fc95..2e115ab66a00 100644
--- a/arch/mips/loongson64/loongson-3/irq.c
+++ b/arch/mips/loongson64/loongson-3/irq.c
@@ -102,45 +102,8 @@ static struct irqaction cascade_irqaction = {
 	.name = "cascade",
 };
 
-static inline void mask_loongson_irq(struct irq_data *d)
-{
-	clear_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
-	irq_disable_hazard();
-
-	/* Workaround: UART IRQ may deliver to any core */
-	if (d->irq == LOONGSON_UART_IRQ) {
-		int cpu = smp_processor_id();
-		int node_id = cpu_logical_map(cpu) / loongson_sysconf.cores_per_node;
-		int core_id = cpu_logical_map(cpu) % loongson_sysconf.cores_per_node;
-		u64 intenclr_addr = smp_group[node_id] |
-			(u64)(&LOONGSON_INT_ROUTER_INTENCLR);
-		u64 introuter_lpc_addr = smp_group[node_id] |
-			(u64)(&LOONGSON_INT_ROUTER_LPC);
-
-		*(volatile u32 *)intenclr_addr = 1 << 10;
-		*(volatile u8 *)introuter_lpc_addr = 0x10 + (1<<core_id);
-	}
-}
-
-static inline void unmask_loongson_irq(struct irq_data *d)
-{
-	/* Workaround: UART IRQ may deliver to any core */
-	if (d->irq == LOONGSON_UART_IRQ) {
-		int cpu = smp_processor_id();
-		int node_id = cpu_logical_map(cpu) / loongson_sysconf.cores_per_node;
-		int core_id = cpu_logical_map(cpu) % loongson_sysconf.cores_per_node;
-		u64 intenset_addr = smp_group[node_id] |
-			(u64)(&LOONGSON_INT_ROUTER_INTENSET);
-		u64 introuter_lpc_addr = smp_group[node_id] |
-			(u64)(&LOONGSON_INT_ROUTER_LPC);
-
-		*(volatile u32 *)intenset_addr = 1 << 10;
-		*(volatile u8 *)introuter_lpc_addr = 0x10 + (1<<core_id);
-	}
-
-	set_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
-	irq_enable_hazard();
-}
+static inline void mask_loongson_irq(struct irq_data *d) { }
+static inline void unmask_loongson_irq(struct irq_data *d) { }
 
  /* For MIPS IRQs which shared by all cores */
 static struct irq_chip loongson_irq_chip = {
@@ -183,7 +146,7 @@ void __init mach_init_irq(void)
 	chip->irq_set_affinity = plat_set_irq_affinity;
 
 	irq_set_chip_and_handler(LOONGSON_UART_IRQ,
-			&loongson_irq_chip, handle_level_irq);
+			&loongson_irq_chip, handle_percpu_irq);
 
 	/* setup HT1 irq */
 	setup_irq(LOONGSON_HT1_IRQ, &cascade_irqaction);
-- 
2.17.1



