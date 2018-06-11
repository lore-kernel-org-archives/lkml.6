Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +bQOFUlqHlvpNQAAmS7hNA
	; Mon, 11 Jun 2018 12:25:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5A74F607E4; Mon, 11 Jun 2018 12:25:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E456460541;
	Mon, 11 Jun 2018 12:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E456460541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932980AbeFKMZp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 08:25:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8657 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932894AbeFKMZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:25:43 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5978953710F52;
        Mon, 11 Jun 2018 20:25:28 +0800 (CST)
Received: from localhost (10.177.19.219) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.382.0; Mon, 11 Jun 2018
 20:25:24 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <julien.thierry@arm.com>, <marc.zyngier@arm.com>
CC: <yangyingliang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3] irqchip/gic-v3-its: fix ITS queue timeout
Date: Mon, 11 Jun 2018 20:25:09 +0800
Message-ID: <1528719909-16572-1-git-send-email-yangyingliang@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a NUMA system, if an ITS is local to an offline
node, the ITS driver may pick an offline CPU to bind
the LPI. In this case, we need to pick an online CPU.
But on some systems, binding LPI to non-local node
CPU will cause deadlock. In this case, we don't
bind the LPI to any online CPU and return an error code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5416f2b..137c433 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2309,7 +2309,13 @@ static int its_irq_domain_activate(struct irq_domain *domain,
 		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
 
 	/* Bind the LPI to the first possible CPU */
-	cpu = cpumask_first(cpu_mask);
+	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
+	if (cpu >= nr_cpu_ids) {
+		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144)
+			return -EINVAL;
+
+		cpu = cpumask_first(cpu_online_mask);
+	}
 	its_dev->event_map.col_map[event] = cpu;
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
-- 
1.8.3
