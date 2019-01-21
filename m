Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F16C7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25E12089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfAULw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:52:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2206 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728018AbfAULw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:52:59 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0215081EAF5BB445C6C9;
        Mon, 21 Jan 2019 19:52:57 +0800 (CST)
Received: from linux-fhAnjn.huawei.com (10.175.104.222) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Mon, 21 Jan 2019 19:52:50 +0800
From:   Heyi Guo <guoheyi@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <wanghaibin.wang@huawei.com>
Subject: [RFC] irq-gic-v3-its: fix occasional VLPI drop
Date:   Mon, 21 Jan 2019 19:51:48 +0800
Message-ID: <1548071508-11846-1-git-send-email-guoheyi@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.222]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every VLPI will temporarily be mapped to the first CPU in system
(normally CPU0) and then moved to the real scheduled CPU later. There
is a time window so a VLPI may be sent to CPU0 instead of the real
scheduled vCPU, in a multi-CPU virtual machine. However, CPU0 may have
not been scheduled as a virtual CPU after system boots up, so the
value of GICR_VPROPBASER still be the reset value. According to GIC
spec, the reset value of IDbits in GICR_VPROPBASER is architecturally
UNKNOWN, and the GIC will behave as if all virtual LPIs are out of
range if it is less than 0b1101. On our platform the GICR will simply
drop the incoming VLPI, which results in interrupt missing in Guest.

As no code will clear GICR_VPROPBASER at runtime, we can safely
initialize the IDbits field at boot time for each CPU to get rid of
this issue.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Signed-off-by: Heyi Guo <heyi.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index db20e99..6116215 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2144,6 +2144,20 @@ static void its_cpu_init_lpis(void)
 	val |= GICR_CTLR_ENABLE_LPIS;
 	writel_relaxed(val, rbase + GICR_CTLR);
 
+	/*
+	 * Temporary workaround for vlpi drop on Hi1620.
+	 * IDbits must be set before any VLPI is sent to this CPU, or else the
+	 * VLPI will be considered as out of range and dropped.
+	 */
+	if (gic_rdists->has_vlpis) {
+		void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
+
+		val = (LPI_NRBITS - 1) & GICR_VPROPBASER_IDBITS_MASK;
+		pr_info("GICv4: CPU%d: Init IDbits to 0x%llx for GICR_VPROPBASER\n",
+			smp_processor_id(), val);
+		gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
+	}
+
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
 out:
-- 
1.8.3.1

