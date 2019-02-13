Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D5FC0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D84F222AC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MyK9oZJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394609AbfBMUSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:18:45 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:63574 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394557AbfBMUSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550089101; x=1581625101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=h2fKv5100GvHj+ysLhrtvyrBQOE+5MV8IiW0LUcjPlE=;
  b=MyK9oZJbxs56vx+1jThUaLdE5Y80D/wcJ3/WYtiEAkUHjGlrp1ulz4OY
   k+bhNAXBeeCwqeyhcYVPIkqnJjlh7PR+ceqzWJCY1RyhzpcVKOuGtDeNJ
   6jzFw1GyQfDWY9XZbPDWDM2bFZ1wWAInOw1LqTJiO30bE8tkjuXokg0EW
   K2XL37VrEi/At4UOWJMKg8I2e6WYi1fgoE8DPLK4f5hoeJsOPt1AtUmRk
   N+sxA+YnKNM+55+1yhYS9DFjkDq4JPCY6b08HSWBQJtJLO82XXQDh0Dt7
   EE6kWRnGGoy4aWPiC2jwxuwz2TM+WoLc3SLUnXTh+ihisA/lhCEBh95hD
   w==;
X-IronPort-AV: E=Sophos;i="5.58,366,1544457600"; 
   d="scan'208";a="206321188"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2019 04:18:20 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 13 Feb 2019 11:58:54 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2019 12:18:21 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jason Cooper <jason@lakedaemon.net>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [v5 PATCH 2/8] RISC-V: Move cpuid to hartid mapping to SMP.
Date:   Wed, 13 Feb 2019 12:18:06 -0800
Message-Id: <1550089092-28783-3-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550089092-28783-1-git-send-email-atish.patra@wdc.com>
References: <1550089092-28783-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, logical CPU id to physical hartid mapping is defined for both
smp and non-smp configurations. This is not required as we need this
only for smp configuration.  The mapping function can define directly
boot_cpu_hartid for non-smp use case.

The reverse mapping function i.e. hartid to cpuid can be called for any
valid but not booted harts. So it should return default cpu 0 only if it
is a boot hartid.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/smp.h | 18 +++++++++++++-----
 arch/riscv/kernel/setup.c    |  9 ---------
 arch/riscv/kernel/smp.c      |  9 +++++++++
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 41aa73b4..636a934f 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -19,16 +19,17 @@
 #include <linux/thread_info.h>
 
 #define INVALID_HARTID ULONG_MAX
+
+struct seq_file;
+extern unsigned long boot_cpu_hartid;
+
+#ifdef CONFIG_SMP
 /*
  * Mapping between linux logical cpu index and hartid.
  */
 extern unsigned long __cpuid_to_hartid_map[NR_CPUS];
 #define cpuid_to_hartid_map(cpu)    __cpuid_to_hartid_map[cpu]
 
-struct seq_file;
-
-#ifdef CONFIG_SMP
-
 /* print IPI stats */
 void show_ipi_stats(struct seq_file *p, int prec);
 
@@ -58,7 +59,14 @@ static inline void show_ipi_stats(struct seq_file *p, int prec)
 
 static inline int riscv_hartid_to_cpuid(int hartid)
 {
-	return 0;
+	if (hartid == boot_cpu_hartid)
+		return 0;
+
+	return -1;
+}
+static inline unsigned long cpuid_to_hartid_map(int cpu)
+{
+	return boot_cpu_hartid;
 }
 
 static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index fb09e013..61c81616 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -61,15 +61,6 @@ EXPORT_SYMBOL(empty_zero_page);
 atomic_t hart_lottery;
 unsigned long boot_cpu_hartid;
 
-unsigned long __cpuid_to_hartid_map[NR_CPUS] = {
-	[0 ... NR_CPUS-1] = INVALID_HARTID
-};
-
-void __init smp_setup_processor_id(void)
-{
-	cpuid_to_hartid_map(0) = boot_cpu_hartid;
-}
-
 #ifdef CONFIG_BLK_DEV_INITRD
 static void __init setup_initrd(void)
 {
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 246635ea..b69883c6 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -36,6 +36,15 @@ enum ipi_message_type {
 	IPI_MAX
 };
 
+unsigned long __cpuid_to_hartid_map[NR_CPUS] = {
+	[0 ... NR_CPUS-1] = INVALID_HARTID
+};
+
+void __init smp_setup_processor_id(void)
+{
+	cpuid_to_hartid_map(0) = boot_cpu_hartid;
+}
+
 /* A collection of single bit ipi messages.  */
 static struct {
 	unsigned long stats[IPI_MAX] ____cacheline_aligned;
-- 
2.7.4

