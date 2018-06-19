Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65410C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C1420836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C1420836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757305AbeFSL5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:57:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48402 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757217AbeFSL4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:56:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0F1015AD;
        Tue, 19 Jun 2018 04:56:09 -0700 (PDT)
Received: from approximate.cambridge.arm.com (approximate.cambridge.arm.com [10.1.206.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 939DB3F557;
        Tue, 19 Jun 2018 04:56:08 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 2/6] irqchip/ls-scfg-msi: Fix MSI affinity handling
Date:   Tue, 19 Jun 2018 12:55:42 +0100
Message-Id: <20180619115546.12196-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619115546.12196-1-marc.zyngier@arm.com>
References: <20180619115546.12196-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ls-scfs-msi driver is not dealing with the effective affinity
as it should. Let's fix that, and make it clear that the effective
affinity is restricted to a single CPU.

Reported-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-ls-scfg-msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 1ec3bfe56693..2811cc53e425 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -121,7 +121,8 @@ static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
 		return -EINVAL;
 	}
 
-	cpumask_copy(irq_data->common->affinity, mask);
+	cpumask_copy(irq_data->common->affinity, cpumask_of(cpu));
+	irq_data_update_effective_affinity(irq_data, cpumask_of(cpu));
 
 	return IRQ_SET_MASK_OK;
 }
-- 
2.17.1

