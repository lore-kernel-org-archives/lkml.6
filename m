Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C28C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C16120666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ile/K+YG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C16120666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeJCCAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:00:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61576 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeJCCAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1538507711; x=1570043711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yYSzJohgUUulgjrfTE5grm9/z8Wz6+2RwJyG6hRhupI=;
  b=Ile/K+YGGDIvzGY4ue/8VJ3S3sDsUFfnGDsAaZJhkNIf7gajk2zLClRW
   FbsQ4Njc9MF4XRx+wWs1aX3EQwNh3xBQmxqpiX/0l9cG0gxrUWoigyiGo
   JMiOuTBeEfDQqGNGgYl7wZJ/0j8Ok6sjB+JaEUjCyOUzENp5mjzTTL7bn
   tTF+8XiZ5cxBsBcsrPIbQWLT7Cq5b7H6Fdx3EA8H9J4rn4FLJewf/M2D+
   H/e7TB9Gq7O1OEQZyxdWSDLqZr/q4Ysm5M4o/iSng7jx4EVkL4AAssdhJ
   tgRAthxyuTUuVRFg9uNmI4/lkh+wqmm+KeRkK9DJouVZhA8VHDEqE0ODI
   Q==;
X-IronPort-AV: E=Sophos;i="5.54,332,1534780800"; 
   d="scan'208";a="91076755"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2018 03:15:10 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 02 Oct 2018 12:00:51 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Oct 2018 12:15:11 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org, palmer@sifive.com
Cc:     anup@brainfault.org, hch@infradead.org,
        linux-kernel@vger.kernel.org, atish.patra@wdc.com
Subject: [PATCH v6 11/14] RISC-V: Add logical CPU indexing for RISC-V
Date:   Tue,  2 Oct 2018 12:15:04 -0700
Message-Id: <1538507707-22299-12-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538507707-22299-1-git-send-email-atish.patra@wdc.com>
References: <1538507707-22299-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, both Linux CPU id and hart id are same.
This is not recommended as it will lead to discontinuous CPU
indexing in Linux. Moreover, kdump kernel will run from CPU0
which would be absent if we follow existing scheme.

Implement a logical mapping between Linux CPU id and hart
id to decouple these two. Always mark the boot processor as
CPU0 and all other CPUs get the logical CPU id based on their
booting order.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/smp.h | 24 +++++++++++++++++++++++-
 arch/riscv/kernel/setup.c    |  4 ++++
 arch/riscv/kernel/smp.c      | 19 +++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 85d7619e..47fd61df 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -18,6 +18,13 @@
 #include <linux/irqreturn.h>
 #include <linux/thread_info.h>
 
+#define INVALID_HARTID ULONG_MAX
+/*
+ * Mapping between linux logical cpu index and hartid.
+ */
+extern unsigned long __cpuid_to_hartid_map[NR_CPUS];
+#define cpuid_to_hartid_map(cpu)    __cpuid_to_hartid_map[cpu]
+
 #ifdef CONFIG_SMP
 
 /* SMP initialization hook for setup_arch */
@@ -29,12 +36,27 @@ void arch_send_call_function_ipi_mask(struct cpumask *mask);
 /* Hook for the generic smp_call_function_single() routine. */
 void arch_send_call_function_single_ipi(int cpu);
 
+int riscv_hartid_to_cpuid(int hartid);
+void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
+
 /*
  * Obtains the hart ID of the currently executing task.  This relies on
  * THREAD_INFO_IN_TASK, but we define that unconditionally.
  */
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
-#endif /* CONFIG_SMP */
+#else
+
+static inline int riscv_hartid_to_cpuid(int hartid)
+{
+	return 0;
+}
 
+static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
+					      struct cpumask *out)
+{
+	cpumask_set_cpu(cpuid_to_hartid_map(0), out);
+}
+
+#endif /* CONFIG_SMP */
 #endif /* _ASM_RISCV_SMP_H */
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index db20dc63..d40b7c0f 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -82,6 +82,10 @@ EXPORT_SYMBOL(empty_zero_page);
 /* The lucky hart to first increment this variable will boot the other cores */
 atomic_t hart_lottery;
 
+unsigned long __cpuid_to_hartid_map[NR_CPUS] = {
+	[0 ... NR_CPUS-1] = INVALID_HARTID
+};
+
 #ifdef CONFIG_BLK_DEV_INITRD
 static void __init setup_initrd(void)
 {
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 906fe21e..0bd48935 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -38,7 +38,26 @@ enum ipi_message_type {
 	IPI_MAX
 };
 
+int riscv_hartid_to_cpuid(int hartid)
+{
+	int i = -1;
+
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpuid_to_hartid_map(i) == hartid)
+			return i;
+
+	pr_err("Couldn't find cpu id for hartid [%d]\n", hartid);
+	BUG();
+	return i;
+}
 
+void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)
+{
+	int cpu;
+
+	for_each_cpu(cpu, in)
+		cpumask_set_cpu(cpuid_to_hartid_map(cpu), out);
+}
 /* Unsupported */
 int setup_profiling_timer(unsigned int multiplier)
 {
-- 
2.7.4

