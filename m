Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFE7C0044B
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E9020840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iJhSSYlj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E9020840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeKIL2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 06:28:41 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29616 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbeKIL2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 06:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1541728213; x=1573264213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=wTS7UviMuB1vJqlMidMCF02zuSQf2VK9pjNXvYjC+z4=;
  b=iJhSSYljHzJKRMvtyPxISDPQdc1gqKN3mkfKYQInsYAHCTULM/zYyuk/
   sUQv6+KT8PES+hzIeNFEON2ENwNy22a9i2YhRB1fSGNU/NZmfFwJRfdFE
   0qD18S2jR+DIwRB3JYUSq/pp5751HDw9bVXjMS95AWzucz4CvhQpyPr+O
   vgvOOEXZtdQJ3WlZ2qVc7U1TSq0miU336efAgDtSGKeeVDR7icONUk693
   e2Yfs5zJyHVF6omUh3Yc0To0JTWDq5zmEyqlR3afJPESGRZ7F6B7cNlrO
   yRSkK1hsypAZcxFhNWxjUmfhHrC/OQ+u7VRBNH+apb8Hk7htMuHNDlTUg
   w==;
X-IronPort-AV: E=Sophos;i="5.54,481,1534780800"; 
   d="scan'208";a="98624917"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2018 09:50:11 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 08 Nov 2018 17:33:44 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Nov 2018 17:50:11 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org, anup@brainfault.org,
        Damien.LeMoal@wdc.com, atish.patra@wdc.com,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        robh+dt@kernel.org, sudeep.holla@arm.com, palmer@sifive.com,
        devicetree@vger.kernel.org, juri.lelli@arm.com, mick@ics.forth.gr,
        jeremy.linton@arm.com
Subject: [RFC 3/3] RISC-V: Parse cpu topology during boot.
Date:   Thu,  8 Nov 2018 17:50:09 -0800
Message-Id: <1541728209-3224-4-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541728209-3224-1-git-send-email-atish.patra@wdc.com>
References: <1541728209-3224-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there are no topology defined for RISC-V.
Parse the cpu-map node from device tree and setup the
cpu topology.

CPU topology after applying the patch.
$cat /sys/devices/system/cpu/cpu2/topology/core_siblings_list
0-3
$cat /sys/devices/system/cpu/cpu3/topology/core_siblings_list
0-3
$cat /sys/devices/system/cpu/cpu3/topology/physical_package_id
0
$cat /sys/devices/system/cpu/cpu3/topology/core_id
3

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/Kconfig          | 1 +
 arch/riscv/kernel/smpboot.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 55da93f4..e2d8ddb5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -42,6 +42,7 @@ config RISCV
 	select THREAD_INFO_IN_TASK
 	select RISCV_TIMER
 	select GENERIC_IRQ_MULTI_HANDLER
+	select GENERIC_ARCH_TOPOLOGY
 	select ARCH_HAS_PTE_SPECIAL
 
 config MMU
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 18cda0e8..6fa95442 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -31,6 +31,7 @@
 #include <linux/of.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/mm.h>
+#include <linux/arch_topology.h>
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -42,6 +43,7 @@ void *__cpu_up_task_pointer[NR_CPUS];
 
 void __init smp_prepare_boot_cpu(void)
 {
+	init_cpu_topology();
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
@@ -108,13 +110,15 @@ void __init smp_cpus_done(unsigned int max_cpus)
 asmlinkage void __init smp_callin(void)
 {
 	struct mm_struct *mm = &init_mm;
+	unsigned int cpu = smp_processor_id();
 
 	/* All kernel threads share the same mm context.  */
 	mmgrab(mm);
 	current->active_mm = mm;
 
 	trap_init();
-	notify_cpu_starting(smp_processor_id());
+	notify_cpu_starting(cpu);
+	update_siblings_masks(cpu);
 	set_cpu_online(smp_processor_id(), 1);
 	/*
 	 * Remote TLB flushes are ignored while the CPU is offline, so emit
-- 
2.7.4

