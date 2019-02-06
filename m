Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72B2C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBCE218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfBFKtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:49:00 -0500
Received: from foss.arm.com ([217.140.101.70]:51264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfBFKs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:48:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2ADC41596;
        Wed,  6 Feb 2019 02:48:58 -0800 (PST)
Received: from big-swifty.cambridge.arm.com (big-swifty.cambridge.arm.com [10.1.30.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D692C3F719;
        Wed,  6 Feb 2019 02:48:55 -0800 (PST)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Heyi Guo <guoheyi@huawei.com>, Heyi Guo <heyi.guo@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Zheng Xiang <zhengxiang9@huawei.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] irqchip/gic-v4: Fix occasional VLPI drop
Date:   Wed,  6 Feb 2019 10:48:44 +0000
Message-Id: <20190206104848.12580-2-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206104848.12580-1-marc.zyngier@arm.com>
References: <20190206104848.12580-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heyi Guo <guoheyi@huawei.com>

1. In current implementation, every VLPI will temporarily be mapped to
the first CPU in system (normally CPU0) and then moved to the real
scheduled CPU later.

2. So there is a time window and a VLPI may be sent to CPU0 instead of
the real scheduled vCPU, in a multi-CPU virtual machine.

3. However, CPU0 may have not been scheduled as a virtual CPU after
system boots up, so the value of its GICR_VPROPBASER is unknown at
that moment.

4. If the INTID of VLPI is larger than 2^(GICR_VPROPBASER.IDbits+1),
while IDbits is also in unknown state, GIC will behave as if the VLPI
is out of range and simply drop it, which results in interrupt missing
in Guest.

As no code will clear GICR_VPROPBASER at runtime, we can safely
initialize the IDbits field at boot time for each CPU to get rid of
this issue.

We also clear Valid bit of GICR_VPENDBASER in case any ancient
programming gets left in and causes memory corrupting. A new function
its_clear_vpend_valid() is added to reuse the code in
its_vpe_deschedule().

Fixes: e643d8034036 ("irqchip/gic-v3-its: Add VPE scheduling")
Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Signed-off-by: Heyi Guo <heyi.guo@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 66 ++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7f2a45445b00..36181197d5e0 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2059,6 +2059,29 @@ static int __init allocate_lpi_tables(void)
 	return 0;
 }
 
+static u64 its_clear_vpend_valid(void __iomem *vlpi_base)
+{
+	u32 count = 1000000;	/* 1s! */
+	bool clean;
+	u64 val;
+
+	val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
+	val &= ~GICR_VPENDBASER_Valid;
+	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+
+	do {
+		val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
+		clean = !(val & GICR_VPENDBASER_Dirty);
+		if (!clean) {
+			count--;
+			cpu_relax();
+			udelay(1);
+		}
+	} while (!clean && count);
+
+	return val;
+}
+
 static void its_cpu_init_lpis(void)
 {
 	void __iomem *rbase = gic_data_rdist_rd_base();
@@ -2144,6 +2167,30 @@ static void its_cpu_init_lpis(void)
 	val |= GICR_CTLR_ENABLE_LPIS;
 	writel_relaxed(val, rbase + GICR_CTLR);
 
+	if (gic_rdists->has_vlpis) {
+		void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
+
+		/*
+		 * It's possible for CPU to receive VLPIs before it is
+		 * sheduled as a vPE, especially for the first CPU, and the
+		 * VLPI with INTID larger than 2^(IDbits+1) will be considered
+		 * as out of range and dropped by GIC.
+		 * So we initialize IDbits to known value to avoid VLPI drop.
+		 */
+		val = (LPI_NRBITS - 1) & GICR_VPROPBASER_IDBITS_MASK;
+		pr_debug("GICv4: CPU%d: Init IDbits to 0x%llx for GICR_VPROPBASER\n",
+			smp_processor_id(), val);
+		gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
+
+		/*
+		 * Also clear Valid bit of GICR_VPENDBASER, in case some
+		 * ancient programming gets left in and has possibility of
+		 * corrupting memory.
+		 */
+		val = its_clear_vpend_valid(vlpi_base);
+		WARN_ON(val & GICR_VPENDBASER_Dirty);
+	}
+
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
 out:
@@ -2755,26 +2802,11 @@ static void its_vpe_schedule(struct its_vpe *vpe)
 static void its_vpe_deschedule(struct its_vpe *vpe)
 {
 	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
-	u32 count = 1000000;	/* 1s! */
-	bool clean;
 	u64 val;
 
-	/* We're being scheduled out */
-	val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
-	val &= ~GICR_VPENDBASER_Valid;
-	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
-
-	do {
-		val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
-		clean = !(val & GICR_VPENDBASER_Dirty);
-		if (!clean) {
-			count--;
-			cpu_relax();
-			udelay(1);
-		}
-	} while (!clean && count);
+	val = its_clear_vpend_valid(vlpi_base);
 
-	if (unlikely(!clean && !count)) {
+	if (unlikely(val & GICR_VPENDBASER_Dirty)) {
 		pr_err_ratelimited("ITS virtual pending table not cleaning\n");
 		vpe->idai = false;
 		vpe->pending_last = true;
-- 
2.20.1

