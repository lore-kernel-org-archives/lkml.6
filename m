Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC58BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957102087A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957102087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391533AbeIVBvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:51:12 -0400
Received: from foss.arm.com ([217.140.101.70]:41340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391444AbeIVBup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:50:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9472C169E;
        Fri, 21 Sep 2018 13:00:21 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47FDA3F5BD;
        Fri, 21 Sep 2018 13:00:21 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 08/10] irqchip/gic-v3-its: Check that all RDs have the same property table
Date:   Fri, 21 Sep 2018 20:59:52 +0100
Message-Id: <20180921195954.21574-9-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If booting with LPIs enabled, all the redistributors must have the
exact same property table. No ifs, no buts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0b3e76cdde26..4d9604dd6fb1 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2029,6 +2029,15 @@ static void its_cpu_init_lpis(void)
 	val = readl_relaxed(rbase + GICR_CTLR);
 	if ((gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED) &&
 	    (val & GICR_CTLR_ENABLE_LPIS)) {
+		/*
+		 * Check that we get the same property table on all
+		 * RDs. If we don't, this is hopeless.
+		 */
+		paddr = gicr_read_propbaser(rbase + GICR_PROPBASER);
+		paddr &= GENMASK_ULL(51, 12);
+		if (WARN_ON(gic_rdists->prop_table_pa != paddr))
+			add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
+
 		paddr = gicr_read_pendbaser(rbase + GICR_PENDBASER);
 		paddr &= GENMASK_ULL(51, 16);
 
-- 
2.18.0

