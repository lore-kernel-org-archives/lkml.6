Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014EAC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C722F2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CzN+8crp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfBLLKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:10:33 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42874 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbfBLLKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549969888; x=1581505888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=YZUqK4Qfap9iJXTgeai1JroJ8SUKDUcCMd3sVPqcbE8=;
  b=CzN+8crpWaCyw1gul8xf/8KvMMr2fVk9L5KIBJV8k2BCpxzGXVet9s/6
   X88gGZ5N1ZdN9bAurJo2/N8Hg/NYaMbUB3OSBnbi6hWCmLpyavhmB7PXI
   eNzQupODU7YR1fI8L0aJa326sY0912am6i2yMgX2k2oBE90ma/BLZ+SMp
   +oYK5Rfu4ENhasMcOYvr5dGX/NEGvJ/BPcEEfaPCvH9ZeGlcIZRIGsIm2
   PXIa32oG65FRhxTzSaFIdXjvhgr/X9U0Ql6WOteIYL0DcO6WeAaOdwLQb
   3t4IoQMxUALWHjXx2BrijV24PG3P4vmaRHkmpVFFUmoi5PztSSz8RWhDg
   g==;
X-IronPort-AV: E=Sophos;i="5.58,361,1544457600"; 
   d="scan'208";a="199201825"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2019 19:11:09 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 12 Feb 2019 02:50:56 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Feb 2019 03:10:20 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [v4 PATCH 1/8] RISC-V: Do not wait indefinitely in __cpu_up
Date:   Tue, 12 Feb 2019 03:10:05 -0800
Message-Id: <1549969812-22502-2-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549969812-22502-1-git-send-email-atish.patra@wdc.com>
References: <1549969812-22502-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In SMP path, __cpu_up waits for other CPU to come online indefinitely.
This is wrong as other CPU might be disabled in machine mode and
possible CPU is set to the cpus present in DT.

Introduce a completion variable and waits only for a second.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/kernel/smpboot.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 6e281325..d369b669 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -39,6 +39,7 @@
 
 void *__cpu_up_stack_pointer[NR_CPUS];
 void *__cpu_up_task_pointer[NR_CPUS];
+static DECLARE_COMPLETION(cpu_running);
 
 void __init smp_prepare_boot_cpu(void)
 {
@@ -77,6 +78,7 @@ void __init setup_smp(void)
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
+	int ret = 0;
 	int hartid = cpuid_to_hartid_map(cpu);
 	tidle->thread_info.cpu = cpu;
 
@@ -92,10 +94,16 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 		  task_stack_page(tidle) + THREAD_SIZE);
 	WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
 
-	while (!cpu_online(cpu))
-		cpu_relax();
+	lockdep_assert_held(&cpu_running);
+	wait_for_completion_timeout(&cpu_running,
+					    msecs_to_jiffies(1000));
 
-	return 0;
+	if (!cpu_online(cpu)) {
+		pr_crit("CPU%u: failed to come online\n", cpu);
+		ret = -EIO;
+	}
+
+	return ret;
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
@@ -121,6 +129,7 @@ asmlinkage void __init smp_callin(void)
 	 * a local TLB flush right now just in case.
 	 */
 	local_flush_tlb_all();
+	complete(&cpu_running);
 	/*
 	 * Disable preemption before enabling interrupts, so we don't try to
 	 * schedule a CPU that hasn't actually started yet.
-- 
2.7.4

