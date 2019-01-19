Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF19C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3FB2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="UG1Cwrse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfASF5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 00:57:09 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37440 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfASF5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 00:57:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so7055670pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 21:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+5uWZcZTnUMYkzU8RtvAyOycmBx9913OmwDsy9awI1U=;
        b=UG1Cwrsee516w8BNGvbRF4/j28/qVMEu5Xmu/3v0qMapBN8duHPlhINsPr0igqeInS
         NPgRGkg9KZ8nsAKjStecrDf9Xnprj0yJ5SjQ3xMTpSoEh3SSGG1t1LfVCFx9ZmncNTnz
         s8vP98s8NfMgBOzXfP2Krco8Lt0ZsOU9nVN/1UmtkWVXyKKS+L/b2n962p1UpzFqVsKx
         YcJ/xQeczW17pxycRV2m8CU5Ek5w25C2pzOPAyC+0kXU5vcRQ+fZaZcqJGNfw/QpIHi9
         j+vo3FgCN6P0aQINqz5caDxXwlXByUC1HqQ0jpAjxORchQDFMvGhCwRc4LGZWzpKep77
         F+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+5uWZcZTnUMYkzU8RtvAyOycmBx9913OmwDsy9awI1U=;
        b=jKFvxRm1PQ29l69P5c7qtO1zehUfEUdb41ZLcqwW8uIdMjytyyzpMp3MZMFKamK3y4
         DEnZd7QxayPNj78K+B9reK8mj7HK87As3knNoUEhOLDAIr6bS7QKywF664tbsDtbrwcL
         dNzuJmXGpgqKWq+eVPPSSjnjaLbThnLIVPu1aqN5pItfbQ1p3cKj01vsnF6WoH4TPvL4
         x7YSc6vPoLy9bJXn1240VFb4cKAQMl2FlLGDL6ko4rL295nUs2zRj8jUO6l2yfe9OI6r
         pdxGmFDvrYjmEnLUk2KQXArk5wK23RlpKx1ZwDL9MRrXa8darx+00h0zrcU0u15UW88i
         +ULA==
X-Gm-Message-State: AJcUukeMa5YvhhumQhdRZ3KXDtksBnhDLGk3LbvlF7CMmHKRNCV3lQal
        EGGFyuYyPQAUM5ISbkYsKTgaDQ==
X-Google-Smtp-Source: ALg8bN5hh8Y87U3+JnY9xdXjts/r8Nz0wxNzUFqNsbVeYHTwEhJOo+suPGf+fbnO8qNDagL61b/HMw==
X-Received: by 2002:a62:9657:: with SMTP id c84mr22700141pfe.77.1547877427469;
        Fri, 18 Jan 2019 21:57:07 -0800 (PST)
Received: from localhost.localdomain ([49.207.51.221])
        by smtp.gmail.com with ESMTPSA id c7sm9295535pfh.18.2019.01.18.21.57.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 21:57:06 -0800 (PST)
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
Subject: [PATCH v5 2/5] irqchip: sifive-plic: Don't inline plic_toggle() and plic_irq_toggle()
Date:   Sat, 19 Jan 2019 11:26:22 +0530
Message-Id: <20190119055625.100054-3-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119055625.100054-1-anup@brainfault.org>
References: <20190119055625.100054-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The plic_toggle() uses raw_spin_lock() and plic_irq_toggle has a
for loop so both these functions are not suitable for being inline
hence this patch removes the inline keyword.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 drivers/irqchip/irq-sifive-plic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index c23a293a2aae..01bbbbffbcae 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -69,8 +69,8 @@ struct plic_handler {
 };
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
-static inline void plic_toggle(struct plic_handler *handler,
-				int hwirq, int enable)
+static void plic_toggle(struct plic_handler *handler,
+			int hwirq, int enable)
 {
 	u32 __iomem *reg = handler->enable_base + (hwirq / 32) * sizeof(u32);
 	u32 hwirq_mask = 1 << (hwirq % 32);
@@ -83,7 +83,7 @@ static inline void plic_toggle(struct plic_handler *handler,
 	raw_spin_unlock(&handler->enable_lock);
 }
 
-static inline void plic_irq_toggle(struct irq_data *d, int enable)
+static void plic_irq_toggle(struct irq_data *d, int enable)
 {
 	int cpu;
 
-- 
2.17.1

