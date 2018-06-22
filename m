Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B235BC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6383023FCE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6383023FCE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754612AbeFVJxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:53:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60860 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754580AbeFVJxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:53:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8379515BE;
        Fri, 22 Jun 2018 02:53:12 -0700 (PDT)
Received: from approximate.cambridge.arm.com (approximate.cambridge.arm.com [10.1.206.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 525B63F819;
        Fri, 22 Jun 2018 02:53:11 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 7/7] irqchip/gic-v3-its: Fix reprogramming of redistributors on CPU hotplug
Date:   Fri, 22 Jun 2018 10:52:54 +0100
Message-Id: <20180622095254.5906-8-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622095254.5906-1-marc.zyngier@arm.com>
References: <20180622095254.5906-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We recently made enabling LPIs a lot stricter, by checking that
they are disabled before we enable them. By doing so, we missed
the CPU hotplug case altogether, where we leave LPIs enabled
on hotplug off (we expect the CPU to eventually come back),
and won't write a different value anyway on hotplug on.

So let's skip that check if we detect that particular case.

Fixes: 6eb486b66a30 ("irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is observed before enabling")
Reported-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0269ffb93f6e..d7842d312d3e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3427,6 +3427,16 @@ static int redist_disable_lpis(void)
 	u64 timeout = USEC_PER_SEC;
 	u64 val;
 
+	/*
+	 * If coming via a CPU hotplug event, we don't need to disable
+	 * LPIs before trying to re-enable them. They are already
+	 * configured and all is well in the world. Detect this case
+	 * by checking the allocation of the pending table for the
+	 * current CPU.
+	 */
+	if (gic_data_rdist()->pend_page)
+		return 0;
+
 	if (!gic_rdists_supports_plpis()) {
 		pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
 		return -ENXIO;
-- 
2.17.1

