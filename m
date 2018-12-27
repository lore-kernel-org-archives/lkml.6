Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C668BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954F4214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="n/d3YUhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbeL0LSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 06:18:42 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36260 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbeL0LSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 06:18:41 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so8705881pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 03:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EWRMoEC/A0hBjLIZuy6KvNFGbEVqYyO/63HQJNeKmb0=;
        b=n/d3YUhZCxj7eZFrEZNSG181qtPIVM9yoXtg+iIHfEprSrzlTFU+Y6dnLD0tX8K3+y
         j0v3hhLU2YBgUsK5Olw43hiIO77qcYRuqxCkzNB5OYOwgl2GRrrejFLZipAw0VMV+PMI
         dDAeuDEDSaAoESR1bIByMBMGlqbD3wJiTJXo0qXNyZVN0vxm6Pt788t1Y0y7jy0/HW+6
         SExQXa6/7UgKU84z33sTDpfFd4hAWM7+X7Gz1au4UntP4SQRr9XCG4N3DvVUR9/SQiDr
         2WvJ2c4OZm/6LV2TGXuzMMecfKJbYCjNxWnamCkm9grVjbAKZmk9LpASFIkkZVBDx2mF
         /E2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EWRMoEC/A0hBjLIZuy6KvNFGbEVqYyO/63HQJNeKmb0=;
        b=folzaSBRUI+5CoWONRwcf8SYQiDmRBcCEHAbOLuAbPmCIOD3gMnnM9Ht/YZrf7FwaL
         LzX9fBjb7OLNJEG9PgcvRUH+ywL8kvBwBU30u0NcX5oWn3qVUlVHgo73eWVGiNGQl3gs
         0BV4JGayTMfJqXUWZhPPpKd4Yb5CcH4FI+l9pkl//TMd2a/vvXyuPWPE5dcXeH6zD6A+
         5TLYCDuuxzJza5GOaWWJ8Ba9J45W8+wyaTH6D/hZ/hH2DUy3CV1gghozLBY5QSeFwGOY
         4P7rdFq2vDkE/7nibDpmivxYjLZ74+nS95PyG4xBRLRW86Ihs5soZ+hdldW97TAQ23A/
         7+VQ==
X-Gm-Message-State: AA+aEWakY693HznyU95bOlapnIjKMcFhHtBCXP5ShwXQedX6SRf4R77b
        df1xAWs3mzjT5C7+T3bnIIfQJg==
X-Google-Smtp-Source: AFSGD/UYGcQ9bKMI7TC+KNrvXccHJMd+rk2BtjFCExFwLt2vxNaMFzuyV6LID0v9fU34hzRsRBm3Ew==
X-Received: by 2002:a62:29c3:: with SMTP id p186mr24144025pfp.117.1545909520438;
        Thu, 27 Dec 2018 03:18:40 -0800 (PST)
Received: from localhost.localdomain ([106.51.18.57])
        by smtp.gmail.com with ESMTPSA id u137sm66830105pfc.140.2018.12.27.03.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 03:18:39 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v4 1/5] irqchip: sifive-plic: Pre-compute context hart base and enable base
Date:   Thu, 27 Dec 2018 16:48:17 +0530
Message-Id: <20181227111821.80908-2-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181227111821.80908-1-anup@brainfault.org>
References: <20181227111821.80908-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does following optimizations:
1. Pre-compute hart base for each context handler
2. Pre-compute enable base for each context handler
3. Have enable lock for each context handler instead
of global plic_toggle_lock

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 drivers/irqchip/irq-sifive-plic.c | 47 ++++++++++++++-----------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 357e9daf94ae..c23a293a2aae 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -59,37 +59,28 @@ static void __iomem *plic_regs;
 
 struct plic_handler {
 	bool			present;
-	int			ctxid;
+	void __iomem		*hart_base;
+	/*
+	 * Protect mask operations on the registers given that we can't
+	 * assume atomic memory operations work on them.
+	 */
+	raw_spinlock_t		enable_lock;
+	void __iomem		*enable_base;
 };
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
-static inline void __iomem *plic_hart_offset(int ctxid)
-{
-	return plic_regs + CONTEXT_BASE + ctxid * CONTEXT_PER_HART;
-}
-
-static inline u32 __iomem *plic_enable_base(int ctxid)
-{
-	return plic_regs + ENABLE_BASE + ctxid * ENABLE_PER_HART;
-}
-
-/*
- * Protect mask operations on the registers given that we can't assume that
- * atomic memory operations work on them.
- */
-static DEFINE_RAW_SPINLOCK(plic_toggle_lock);
-
-static inline void plic_toggle(int ctxid, int hwirq, int enable)
+static inline void plic_toggle(struct plic_handler *handler,
+				int hwirq, int enable)
 {
-	u32 __iomem *reg = plic_enable_base(ctxid) + (hwirq / 32);
+	u32 __iomem *reg = handler->enable_base + (hwirq / 32) * sizeof(u32);
 	u32 hwirq_mask = 1 << (hwirq % 32);
 
-	raw_spin_lock(&plic_toggle_lock);
+	raw_spin_lock(&handler->enable_lock);
 	if (enable)
 		writel(readl(reg) | hwirq_mask, reg);
 	else
 		writel(readl(reg) & ~hwirq_mask, reg);
-	raw_spin_unlock(&plic_toggle_lock);
+	raw_spin_unlock(&handler->enable_lock);
 }
 
 static inline void plic_irq_toggle(struct irq_data *d, int enable)
@@ -101,7 +92,7 @@ static inline void plic_irq_toggle(struct irq_data *d, int enable)
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
 
 		if (handler->present)
-			plic_toggle(handler->ctxid, d->hwirq, enable);
+			plic_toggle(handler, d->hwirq, enable);
 	}
 }
 
@@ -150,7 +141,7 @@ static struct irq_domain *plic_irqdomain;
 static void plic_handle_irq(struct pt_regs *regs)
 {
 	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
-	void __iomem *claim = plic_hart_offset(handler->ctxid) + CONTEXT_CLAIM;
+	void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
 	irq_hw_number_t hwirq;
 
 	WARN_ON_ONCE(!handler->present);
@@ -239,12 +230,16 @@ static int __init plic_init(struct device_node *node,
 		cpu = riscv_hartid_to_cpuid(hartid);
 		handler = per_cpu_ptr(&plic_handlers, cpu);
 		handler->present = true;
-		handler->ctxid = i;
+		handler->hart_base =
+			plic_regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
+		raw_spin_lock_init(&handler->enable_lock);
+		handler->enable_base =
+			plic_regs + ENABLE_BASE + i * ENABLE_PER_HART;
 
 		/* priority must be > threshold to trigger an interrupt */
-		writel(0, plic_hart_offset(i) + CONTEXT_THRESHOLD);
+		writel(0, handler->hart_base + CONTEXT_THRESHOLD);
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
-			plic_toggle(i, hwirq, 0);
+			plic_toggle(handler, hwirq, 0);
 		nr_mapped++;
 	}
 
-- 
2.17.1

