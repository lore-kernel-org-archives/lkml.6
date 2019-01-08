Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF0BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9432206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P02rmWol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfAHJir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:38:47 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8878 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfAHJiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546940326; x=1578476326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yvtspfG7CoIHnopRwUo0DnfYLecRH2XoGu3rQKnIYZw=;
  b=P02rmWolculmF+eIPGLtZQhlEuXq7RuKWhK8bUKt4X3cWaU0VKxuFLR4
   Zcrtsjfy7ASKOt2MkfdJbpuwntVASnExzDjTU3TxhY0joKL7OfDy/195/
   AQHzBgSiqL9hh25WXz8wztSbDe8yfUSWzAsVR77hQvX32aotwQItBXfVO
   9t97aq4lcI1AJdz5VdXxT0x31XM3rqdjJB9Sb6ljXOo+S4JMPoRqLB7NB
   /lmNg7X8hLqCSAEC7oR/ogknE2STEpBJHEHPj1XwVaZfesZeHklJKu0tR
   EqeQRj47x6tFt2AN4ouhiirPkhxAYQZFs8LhXfTX4t+7/mg6fjbbRzgLa
   A==;
X-IronPort-AV: E=Sophos;i="5.56,453,1539619200"; 
   d="scan'208";a="99458400"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2019 17:38:45 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 08 Jan 2019 01:18:50 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Jan 2019 01:38:45 -0800
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
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?q?Patrick=20St=C3=A4hlin?= <me@packi.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH v2 1/8] RISC-V: Do not wait indefinitely in __cpu_up
Date:   Tue,  8 Jan 2019 01:38:31 -0800
Message-Id: <1546940318-9752-2-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In SMP path, __cpu_up waits for other CPU to come online
indefinitely. This is wrong as other CPU might be disabled
in machine mode and possible CPU is set to the cpus present
in DT.

Introduce a completion variable and waits only for a second.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kernel/smpboot.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index fc185eca..32e14572 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -39,6 +39,7 @@
 
 void *__cpu_up_stack_pointer[NR_CPUS];
 void *__cpu_up_task_pointer[NR_CPUS];
+static DECLARE_COMPLETION(cpu_running);
 
 void __init smp_prepare_boot_cpu(void)
 {
@@ -81,6 +82,7 @@ void __init setup_smp(void)
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
+	int ret = 0;
 	int hartid = cpuid_to_hartid_map(cpu);
 	tidle->thread_info.cpu = cpu;
 
@@ -96,10 +98,15 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 		  task_stack_page(tidle) + THREAD_SIZE);
 	WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
 
-	while (!cpu_online(cpu))
-		cpu_relax();
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
@@ -125,6 +132,7 @@ asmlinkage void __init smp_callin(void)
 	 * a local TLB flush right now just in case.
 	 */
 	local_flush_tlb_all();
+	complete(&cpu_running);
 	/*
 	 * Disable preemption before enabling interrupts, so we don't try to
 	 * schedule a CPU that hasn't actually started yet.
-- 
2.7.4

