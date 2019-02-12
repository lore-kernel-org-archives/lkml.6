Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200CFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B5F214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="eGeQXCrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfBLMxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:53:16 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34714 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbfBLMxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:53:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id j18so1273384pfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 04:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gsJS4yIBKT28AV4SM0RQ9vanzyz+KIa+304VYw5cpNg=;
        b=eGeQXCrAfG8ecew51ixd+Ac7u9cHblpOfC3x2VIestEm3l6OJrv91fKp/chn7pHbmw
         qTGPdy7Sm2e8YJLLunTQ32oxestJRfmAdc18+vosvs0/GFLPp4q2Z8ch1aCN3r2mxUlD
         pLpVdysDGowHQ6fU2NRlixxGsEJfsQs80CW/IDLZIlLpN2g/ZxUMMdBPB5vi8APmxOF1
         6MEW5kEnp/Vr8eTsv0FbKDaz/pUhjqs7NpfxolIO7fPBrZFgtIZgpTIF+YMC2BAPZmDM
         9SfpgtsbdoOwxcKkvfSUIAgBi6e3WO7KpRog68VmEtymfcTNaf9D92zAG657pA+dxdVf
         4zHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gsJS4yIBKT28AV4SM0RQ9vanzyz+KIa+304VYw5cpNg=;
        b=J3ZHs2kirRLkwizMZd9ZQaVnf481JlQXGUFESWGDMpxu8zl9QUDtS4jwEKmQFyHCD4
         rFNxwZPyC1Ku9WM8GNzuL49YRtJFuppkF6rWsBYHt4qba7dq3gnRYAfvZkiuOwudrepr
         0cC0XwFTu9g2sRVF/vUThz/E7rk7shIhmKjcB/NfDIJtB3DiJMXEN7DoXzF6YqC8og1c
         MlZh/zt/XA3vDa9WB1WuO8n76t+if+4J3MLLnz6LFaNpRggj3fMODDPiCHacZCsy4Md/
         VXRkTNh4EuGxJwSUxRqT/F40XAYMF1sGZu6lUwiQ8KkZJ6M4Jx6NwUdWZ4umhJ5MaUFC
         NI1w==
X-Gm-Message-State: AHQUAuZpEnxos60fEMCBz9ApjDyiDw2pzPkrmJ+L0PXFGbN27AeYNsnL
        mqViuLae0LcJeETVzgfepvgK+g==
X-Google-Smtp-Source: AHgI3IbZlbgAG111vB2Qds3H2DoDuEUXcMbwnPw8/9IQsf02qUY+paif0M6Mj0tE45zdvj+zjrz03g==
X-Received: by 2002:a63:1544:: with SMTP id 4mr3590228pgv.290.1549975994963;
        Tue, 12 Feb 2019 04:53:14 -0800 (PST)
Received: from localhost.localdomain ([49.207.48.205])
        by smtp.gmail.com with ESMTPSA id z67sm27894828pfd.188.2019.02.12.04.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 04:53:14 -0800 (PST)
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
Subject: [PATCH v6 3/4] irqchip: sifive-plic: Differentiate between PLIC handler and context
Date:   Tue, 12 Feb 2019 18:22:45 +0530
Message-Id: <20190212125246.69239-4-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212125246.69239-1-anup@brainfault.org>
References: <20190212125246.69239-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We explicitly differentiate between PLIC handler and context because
PLIC context is for given mode of HART whereas PLIC handler is per-CPU
software construct meant for handling interrupts from a particular
PLIC context.

To achieve this differentiation, we rename "nr_handlers" to "nr_contexts"
and "nr_mapped" to "nr_handlers" in plic_init().

Signed-off-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/irqchip/irq-sifive-plic.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index da09f46fad64..542a9e4c47fc 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -177,7 +177,7 @@ static int plic_find_hart_id(struct device_node *node)
 static int __init plic_init(struct device_node *node,
 		struct device_node *parent)
 {
-	int error = 0, nr_handlers, nr_mapped = 0, i;
+	int error = 0, nr_contexts, nr_handlers = 0, i;
 	u32 nr_irqs;
 
 	if (plic_regs) {
@@ -194,10 +194,10 @@ static int __init plic_init(struct device_node *node,
 	if (WARN_ON(!nr_irqs))
 		goto out_iounmap;
 
-	nr_handlers = of_irq_count(node);
-	if (WARN_ON(!nr_handlers))
+	nr_contexts = of_irq_count(node);
+	if (WARN_ON(!nr_contexts))
 		goto out_iounmap;
-	if (WARN_ON(nr_handlers < num_possible_cpus()))
+	if (WARN_ON(nr_contexts < num_possible_cpus()))
 		goto out_iounmap;
 
 	error = -ENOMEM;
@@ -206,7 +206,7 @@ static int __init plic_init(struct device_node *node,
 	if (WARN_ON(!plic_irqdomain))
 		goto out_iounmap;
 
-	for (i = 0; i < nr_handlers; i++) {
+	for (i = 0; i < nr_contexts; i++) {
 		struct of_phandle_args parent;
 		struct plic_handler *handler;
 		irq_hw_number_t hwirq;
@@ -245,11 +245,11 @@ static int __init plic_init(struct device_node *node,
 		writel(0, handler->hart_base + CONTEXT_THRESHOLD);
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
 			plic_toggle(handler, hwirq, 0);
-		nr_mapped++;
+		nr_handlers++;
 	}
 
-	pr_info("mapped %d interrupts to %d (out of %d) handlers.\n",
-		nr_irqs, nr_mapped, nr_handlers);
+	pr_info("mapped %d interrupts with %d handlers for %d contexts.\n",
+		nr_irqs, nr_handlers, nr_contexts);
 	set_handle_irq(plic_handle_irq);
 	return 0;
 
-- 
2.17.1

