Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeA3C5H (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 21:57:07 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42174 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752221AbeA3C5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 21:57:06 -0500
From: fangxiang <fangxiang3@huawei.com>
To: <tglx@linutronix.de>, <ljason@lakedaemon.net>, <marc.zyngier@arm.com>
CC: <linux-kernel@vger.kernel.org>, <gengyanping@hisilicon.com>
Subject: [PATCH] irqchip/gic-v3: Fix gic_chip specific flag
Date: Tue, 30 Jan 2018 10:56:45 +0800
Message-ID: <1517281005-18993-1-git-send-email-fangxiang3@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.167.7]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both IRQCHIP_SKIP_SET_WAKE and .irq_set_wake() is
not set in gic_chip V3. This causes
set_irq_wake_real() return -ENXIO and a
WARN(Unbalanced IRQ ... wake disable ...) in
irq_set_irq_wake().

Signed-off-by: fangxiang <fangxiang3@huawei.com>
---
 drivers/irqchip/irq-gic-v3.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b56c3e2..e8104b8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -800,7 +800,8 @@ static inline void gic_cpu_pm_init(void) { }
 	.irq_set_affinity	= gic_set_affinity,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
-	.flags			= IRQCHIP_SET_TYPE_MASKED,
+	.flags			= IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE,
 };
 
 static struct irq_chip gic_eoimode1_chip = {
-- 
1.7.9.5
