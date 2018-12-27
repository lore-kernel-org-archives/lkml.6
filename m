Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B494C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03281214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Yo59uPbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbeL0LSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 06:18:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33544 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbeL0LSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 06:18:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so9049624pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 03:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QPq/o0R9ggNlb2oMRGbkSeTpgM0rzBY83T9WPQ+nWrg=;
        b=Yo59uPbkTm9SD+5pdmZ9lP2fnSUyBZoPxA9s9sXRsD+bXFsq2OpX1UGgalJre/PPrH
         cJ3I1nj1g+yzMjjmpckYPP3FYKhZIDIW+DTgHTqnctPT28xIQuPPyQgbgIpqvXwAnqZT
         gl6Tkio30HoAVY7uyXrJllGTTdhGrpunF35YJgVwz4uoeKorUJT7JdI68AkTB4ZxLzRF
         VgdfOvdiQet9jrG/p4XJ+Y8wwyCUUqhuLav6pSm6xJqV7oUYEwbXP/ZARzdZMpMi4K/2
         z71YvBGbaDho9bbVBFtOXPcFpQi+bW5zYYQ2fhN2Xel/0CaQFXPNyA/Qw8nHVfSilrgg
         Sq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QPq/o0R9ggNlb2oMRGbkSeTpgM0rzBY83T9WPQ+nWrg=;
        b=Gmmo+WQpcvZHD0qmpFw31LeNZyMsCqr7WG6rYRARLGU/SKBfiq0uPNmlM0TQ9J6vJ1
         fNZ1bTbjX6AOcK8CBcl5rs14phNM/Owjtj3CTIzPlFQENihM2ZeBEr+M8Vm/FDjpiRKD
         zb4UI8OEoCBbEqqR6QNAZUcBN23851nc0dOnHrQLbLDyDDXEc1F/tgyc7WqFSTvhns6i
         ONTyIoavVTS8n1yjTEbtYbF2HoyrH+9WZKF/d0W0C/Jt2IaBEoFP3BoCpucsjoMV9P6c
         Q7ez1K+99judNLyTcy30MPo51/b4Z4VWbbDQ9ulMze26j0kyjIgB0s8kGG+xjS8lJp1Z
         wpvg==
X-Gm-Message-State: AJcUukdg+R7j5uxWCCUT9ZahmqdHJzu5BbuSbWtvEsJCMybwFC9LOWBH
        t0+iv2gyiRjCLbfAW8ZZwHmMgw==
X-Google-Smtp-Source: ALg8bN4bGjriTsgY8zh/M4PwKlWb+svWCY81ikwiyxUr4j0/Yi39ATET734Y2OTyaLIc0utXCX+qTQ==
X-Received: by 2002:a63:cc12:: with SMTP id x18mr22086304pgf.33.1545909532096;
        Thu, 27 Dec 2018 03:18:52 -0800 (PST)
Received: from localhost.localdomain ([106.51.18.57])
        by smtp.gmail.com with ESMTPSA id u137sm66830105pfc.140.2018.12.27.03.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 03:18:51 -0800 (PST)
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
Subject: [PATCH v4 3/5] irqchip: sifive-plic: Add warning in plic_init() if handler already present
Date:   Thu, 27 Dec 2018 16:48:19 +0530
Message-Id: <20181227111821.80908-4-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181227111821.80908-1-anup@brainfault.org>
References: <20181227111821.80908-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have two enteries (one for M-mode and another for S-mode) in the
interrupts-extended DT property of PLIC DT node for each HART. It is
expected that firmware/bootloader will set M-mode HWIRQ line of each
HART to 0xffffffff (i.e. -1) in interrupts-extended DT property
because Linux runs in S-mode only.

If firmware/bootloader is buggy then it will not correctly update
interrupts-extended DT property which might result in a plic_handler
configured twice. This patch adds a warning in plic_init() if a
plic_handler is already marked present. This warning provides us
a hint about incorrectly updated interrupts-extended DT property.

Signed-off-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/irqchip/irq-sifive-plic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 01bbbbffbcae..b9a0bcefe426 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -229,6 +229,11 @@ static int __init plic_init(struct device_node *node,
 
 		cpu = riscv_hartid_to_cpuid(hartid);
 		handler = per_cpu_ptr(&plic_handlers, cpu);
+		if (handler->present) {
+			pr_warn("handler already present for context %d.\n", i);
+			continue;
+		}
+
 		handler->present = true;
 		handler->hart_base =
 			plic_regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
-- 
2.17.1

