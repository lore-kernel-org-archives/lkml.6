Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605C7ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E422087A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E422087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391546AbeIVBvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:51:24 -0400
Received: from foss.arm.com ([217.140.101.70]:41350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391279AbeIVBup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:50:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35A35168F;
        Fri, 21 Sep 2018 13:00:21 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCC813F73C;
        Fri, 21 Sep 2018 13:00:20 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 07/10] irqchip/gic-v3-its: Use pre-programmed redistributor tables with kdump kernels
Date:   Fri, 21 Sep 2018 20:59:51 +0100
Message-Id: <20180921195954.21574-8-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If using a kdump kernel, and that we cannot disable LPIs to install
our own tables, let's switch to using the already allocated tables.

This means that we'll change some of the initial kernel's memory,
but at least we'll be able to have LPIs in this secondary kernel.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e29ce9f2ac8a..0b3e76cdde26 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -19,6 +19,7 @@
 #include <linux/acpi_iort.h>
 #include <linux/bitmap.h>
 #include <linux/cpu.h>
+#include <linux/crash_dump.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
 #include <linux/interrupt.h>
@@ -1963,8 +1964,15 @@ static void its_free_pending_table(struct page *pt)
 	free_pages((unsigned long)page_address(pt), get_order(LPI_PENDBASE_SZ));
 }
 
+/*
+ * Booting with kdump and LPIs enabled is generally fine.
+ */
 static bool enabled_lpis_allowed(void)
 {
+	/* Allow a kdump kernel */
+	if (is_kdump_kernel())
+		return true;
+
 	return false;
 }
 
-- 
2.18.0

