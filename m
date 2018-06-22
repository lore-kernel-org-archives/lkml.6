Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACB4C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F4F23FC9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F4F23FC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754575AbeFVJxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:53:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60836 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753219AbeFVJxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:53:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 292D7164F;
        Fri, 22 Jun 2018 02:53:08 -0700 (PDT)
Received: from approximate.cambridge.arm.com (approximate.cambridge.arm.com [10.1.206.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC18A3F819;
        Fri, 22 Jun 2018 02:53:06 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 4/7] irqchip/gic-v3-its: Don't bind LPI to unavailable NUMA node
Date:   Fri, 22 Jun 2018 10:52:51 +0100
Message-Id: <20180622095254.5906-5-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622095254.5906-1-marc.zyngier@arm.com>
References: <20180622095254.5906-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

On a NUMA system, if an ITS is local to an offline node, the ITS
driver may pick an offline CPU to bind the LPI.  In this case,
we need to pick an online CPU (and the first one will do).

But on some systems, binding an LPI to non-local node CPU may
cause deadlock (see Cavium erratum 23144).  In this case, we
just fail the activate and return an error code.

Cc: stable@vger.kernel.org
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5377d7e2afba..cae53937feeb 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2310,7 +2310,14 @@ static int its_irq_domain_activate(struct irq_domain *domain,
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
+
 	its_dev->event_map.col_map[event] = cpu;
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
-- 
2.17.1

