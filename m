Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62436C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295C520870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wLOFFCJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295C520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbeKTC53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:57:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:56162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730241AbeKTC53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:57:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42B632089F;
        Mon, 19 Nov 2018 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645200;
        bh=NwVX0xIHh3KVX21/54p1HNYYZEbNy3ieQ3KxOeXPc3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wLOFFCJhAjhq0QRUhtIZn8lT2Bijja75Z9zp6jmtIA7LiyeZu0zLKwBgiHqUZAD7y
         O2WmTdNoJR6EmVYw2TAMU/R/EG1yxz7EU4OwQuaB2NtJ/G+MZfuItb5pQBL3NzptvJ
         QUz3m+mPPSzfa+aqaWE0BIkai/brHkwipkBwBVCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 075/205] MIPS: Loongson-3: Fix BRIDGE irq delivery problem
Date:   Mon, 19 Nov 2018 17:26:22 +0100
Message-Id: <20181119162630.225691769@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 360fe725f8849aaddc53475fef5d4a0c439b05ae ]

After commit e509bd7da149dc349160 ("genirq: Allow migration of chained
interrupts by installing default action") Loongson-3 fails at here:

setup_irq(LOONGSON_HT1_IRQ, &cascade_irqaction);

This is because both chained_action and cascade_irqaction don't have
IRQF_SHARED flag. This will cause Loongson-3 resume fails because HPET
timer interrupt can't be delivered during S3. So we set the irqchip of
the chained irq to loongson_irq_chip which doesn't disable the chained
irq in CP0.Status.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20434/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: Huacai Chen <chenhuacai@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/mach-loongson64/irq.h |  2 +-
 arch/mips/loongson64/loongson-3/irq.c       | 13 +++----------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson64/irq.h b/arch/mips/include/asm/mach-loongson64/irq.h
index 3644b68c0ccc..be9f727a9328 100644
--- a/arch/mips/include/asm/mach-loongson64/irq.h
+++ b/arch/mips/include/asm/mach-loongson64/irq.h
@@ -10,7 +10,7 @@
 #define MIPS_CPU_IRQ_BASE 56
 
 #define LOONGSON_UART_IRQ   (MIPS_CPU_IRQ_BASE + 2) /* UART */
-#define LOONGSON_HT1_IRQ    (MIPS_CPU_IRQ_BASE + 3) /* HT1 */
+#define LOONGSON_BRIDGE_IRQ (MIPS_CPU_IRQ_BASE + 3) /* CASCADE */
 #define LOONGSON_TIMER_IRQ  (MIPS_CPU_IRQ_BASE + 7) /* CPU Timer */
 
 #define LOONGSON_HT1_CFG_BASE		loongson_sysconf.ht_control_base
diff --git a/arch/mips/loongson64/loongson-3/irq.c b/arch/mips/loongson64/loongson-3/irq.c
index 2e115ab66a00..5605061f5f98 100644
--- a/arch/mips/loongson64/loongson-3/irq.c
+++ b/arch/mips/loongson64/loongson-3/irq.c
@@ -96,12 +96,6 @@ void mach_irq_dispatch(unsigned int pending)
 	}
 }
 
-static struct irqaction cascade_irqaction = {
-	.handler = no_action,
-	.flags = IRQF_NO_SUSPEND,
-	.name = "cascade",
-};
-
 static inline void mask_loongson_irq(struct irq_data *d) { }
 static inline void unmask_loongson_irq(struct irq_data *d) { }
 
@@ -147,11 +141,10 @@ void __init mach_init_irq(void)
 
 	irq_set_chip_and_handler(LOONGSON_UART_IRQ,
 			&loongson_irq_chip, handle_percpu_irq);
+	irq_set_chip_and_handler(LOONGSON_BRIDGE_IRQ,
+			&loongson_irq_chip, handle_percpu_irq);
 
-	/* setup HT1 irq */
-	setup_irq(LOONGSON_HT1_IRQ, &cascade_irqaction);
-
-	set_c0_status(STATUSF_IP2 | STATUSF_IP6);
+	set_c0_status(STATUSF_IP2 | STATUSF_IP3 | STATUSF_IP6);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
2.17.1



