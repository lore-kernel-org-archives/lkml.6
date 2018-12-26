Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442BEC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F11218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F7wd+7JA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeLZXJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 18:09:25 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20034 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeLZXJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 18:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1545865762; x=1577401762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=meu8IE2Cb35XRAORiR9qLyyfGNjZhzm1rUp8PRNo5pE=;
  b=F7wd+7JAp93SOLAthSRi23ujC4mGscwvU8IccENO9xkEp85PLe6i0J0y
   0YCNlB/S3YxUQZwsAm7r2ZkRZU9yVmVQc3EfyYgK+nLlJb+Z+kCV0G6AP
   7FUvS5bp09ciu5MpJQ6Vc7ktqfgY2Mu9sgw25A4JIGAZgufYf5K9HPTnu
   Q52qjlU3ovglu7DJfRx1gfo1gU+aw4TFyGYKkdPrzcRpoyr7ZObj40dHE
   ojj1iPlle8Pw4zZInBaXJqRSn0MfbqRnVouI77z53MftDazSqZt5mPHir
   VB+sfMMjLeR8z+whlzW+5NwWCMRQCxZ/QEaLZqZYgRna5JzL1I7LFh6//
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,401,1539619200"; 
   d="scan'208";a="98702979"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Dec 2018 07:09:07 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Dec 2018 14:49:51 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Dec 2018 15:09:07 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?q?Patrick=20St=C3=A4hlin?= <me@packi.ch>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [PATCH 2/3] RISC-V: Move cpuid to hartid mapping to SMP.
Date:   Wed, 26 Dec 2018 15:09:00 -0800
Message-Id: <1545865741-22795-3-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545865741-22795-1-git-send-email-atish.patra@wdc.com>
References: <1545865741-22795-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, logical CPU id to physical hartid mapping is
defined for both smp and non-smp configurations. This
is not required as we need this only for smp configuration.
The mapping function can define directly boot_cpu_hartid
for non-smp usecase.

The reverse mapping function i.e. hartid to cpuid can be called
for any valid but not booted harts. So it should return default
cpu 0 only if it is a boot hartid

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/smp.h | 13 +++++++++++--
 arch/riscv/kernel/setup.c    |  2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 41aa73b4..8f30300f 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -22,12 +22,13 @@
 /*
  * Mapping between linux logical cpu index and hartid.
  */
-extern unsigned long __cpuid_to_hartid_map[NR_CPUS];
-#define cpuid_to_hartid_map(cpu)    __cpuid_to_hartid_map[cpu]
 
+extern unsigned long boot_cpu_hartid;
 struct seq_file;
 
 #ifdef CONFIG_SMP
+extern unsigned long __cpuid_to_hartid_map[NR_CPUS];
+#define cpuid_to_hartid_map(cpu)    __cpuid_to_hartid_map[cpu]
 
 /* print IPI stats */
 void show_ipi_stats(struct seq_file *p, int prec);
@@ -58,7 +59,15 @@ static inline void show_ipi_stats(struct seq_file *p, int prec)
 
 static inline int riscv_hartid_to_cpuid(int hartid)
 {
+	if (hartid == boot_cpu_hartid)
 		return 0;
+	else
+		return -1;
+}
+static inline unsigned long cpuid_to_hartid_map(int cpu)
+{
+
+	return boot_cpu_hartid;
 }
 
 static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 2c290e6a..bd4d7b85 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -83,6 +83,7 @@ EXPORT_SYMBOL(empty_zero_page);
 atomic_t hart_lottery;
 unsigned long boot_cpu_hartid;
 
+#ifdef CONFIG_SMP
 unsigned long __cpuid_to_hartid_map[NR_CPUS] = {
 	[0 ... NR_CPUS-1] = INVALID_HARTID
 };
@@ -91,6 +92,7 @@ void __init smp_setup_processor_id(void)
 {
 	cpuid_to_hartid_map(0) = boot_cpu_hartid;
 }
+#endif
 
 #ifdef CONFIG_BLK_DEV_INITRD
 static void __init setup_initrd(void)
-- 
2.7.4

