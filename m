Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F58ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACF22146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACF22146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbeIRTVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:21:38 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:44102 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729647AbeIRTVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:21:38 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07484756|-1;CH=green;FP=9517861349875253737|1|1|1|0|-1|-1|-1;HT=e02c03298;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.CsTjzPJ_1537278499;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CsTjzPJ_1537278499)
          by smtp.aliyun-inc.com(10.147.42.241);
          Tue, 18 Sep 2018 21:48:20 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        robh@kernel.org, sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, green.hu@gmail.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 2/2] csky: remove irq_mapping from smp.c.
Date:   Tue, 18 Sep 2018 21:48:14 +0800
Message-Id: <ec95f397f52b8b5d9191b85d0d907a1a43d2e2c1.1537276837.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1537276837.git.ren_guo@c-sky.com>
References: <cover.1537276837.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537276837.git.ren_guo@c-sky.com>
References: <cover.1537276837.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - remove irq_mapping from smp.c to irq-driver
 - Add set_ipi_irq_mapping api to irq-driver
 - update asm/smp.h

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/smp.h |  4 ++++
 arch/csky/kernel/smp.c      | 18 +++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/csky/include/asm/smp.h b/arch/csky/include/asm/smp.h
index 9a53abf..fed3a5a 100644
--- a/arch/csky/include/asm/smp.h
+++ b/arch/csky/include/asm/smp.h
@@ -7,6 +7,8 @@
 
 #ifdef CONFIG_SMP
 
+#define IPI_IRQ	15
+
 void __init setup_smp(void);
 
 void __init setup_smp_ipi(void);
@@ -19,6 +21,8 @@ void arch_send_call_function_single_ipi(int cpu);
 
 void __init set_send_ipi(void (*func)(const unsigned long *, unsigned long));
 
+void __init set_ipi_irq_mapping(int (*func)(void));
+
 #define raw_smp_processor_id()	(current_thread_info()->cpu)
 
 #endif /* CONFIG_SMP */
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 522c73f..f8343f6 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -20,8 +20,6 @@
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
 
-#define IPI_IRQ	15
-
 static struct {
 	unsigned long bits ____cacheline_aligned;
 } ipi_data[NR_CPUS] __cacheline_aligned;
@@ -121,13 +119,23 @@ void __init enable_smp_ipi(void)
 	enable_percpu_irq(IPI_IRQ, 0);
 }
 
+static int (*arch_ipi_irq_mapping)(void) = NULL;
+
+void __init set_ipi_irq_mapping(int (*func)(void))
+{
+	if (arch_ipi_irq_mapping)
+		return;
+
+	arch_ipi_irq_mapping = func;
+}
+
 void __init setup_smp_ipi(void)
 {
-	int rc;
+	int rc, irq;
 
-	irq_create_mapping(NULL, IPI_IRQ);
+	irq = arch_ipi_irq_mapping();
 
-	rc = request_percpu_irq(IPI_IRQ, handle_ipi, "IPI Interrupt", &ipi_dummy_dev);
+	rc = request_percpu_irq(irq, handle_ipi, "IPI Interrupt", &ipi_dummy_dev);
 	if (rc)
 		panic("%s IRQ request failed\n", __func__);
 
-- 
2.7.4

