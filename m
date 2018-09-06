Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87925C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9F52075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EtxI01tX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9F52075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbeIFMkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:40:45 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53556 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbeIFMju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536221195; x=1567757195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Rgz6bxuvikFnobsyCOafergcB2Su5l9V6r+6XKdmfgA=;
  b=EtxI01tXJUNxVxD4bZ+eD9lvsR86Fo1moon954EwFrRqox25o5j5hHWj
   PFD4e4yxUvZ5n6dp54ov1pIq7JJNedrv20GKaO3ulyheqsOykGeBNYBWj
   VjOITxmGkSUWvxRryEEg8nAjdURd72p94NnTx9GWBsa1NCxyxleG823fU
   8LcoljbqLRw83tHrVEx0kj1W17ErtvhkTXaU/r178W8ndIfI0jzMK4La2
   6P+AHbB91JHvKesREVkH7O5e6omyGUVvxBNy8Hy482NacOpXy44OIj1qA
   Q36ap4bIMmo8uemQQVTKrpo0MfPOllbpHBkqcaXPwmIoIryC7inFjKsqR
   A==;
X-IronPort-AV: E=Sophos;i="5.53,337,1531756800"; 
   d="scan'208";a="186673948"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2018 16:06:34 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 06 Sep 2018 00:52:13 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Sep 2018 01:05:37 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org, anup@brainfault.org
Cc:     mark.rutland@arm.com, atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com,
        marc.zyngier@arm.com, jeremy.linton@arm.com,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        catalin.marinas@arm.com, dmitriy@oss-tech.org,
        ard.biesheuvel@linaro.org
Subject: [PATCH v3 05/12] RISC-V: Provide a cleaner raw_smp_processor_id()
Date:   Thu,  6 Sep 2018 01:05:28 -0700
Message-Id: <1536221135-182613-6-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
References: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

I'm not sure how I managed to miss this the first time, but this is much
better.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
[Atish: code comment formatting and other fixes]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/smp.h | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 36016845..85d7619e 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -14,13 +14,9 @@
 #ifndef _ASM_RISCV_SMP_H
 #define _ASM_RISCV_SMP_H
 
-/* This both needs asm-offsets.h and is used when generating it. */
-#ifndef GENERATING_ASM_OFFSETS
-#include <asm/asm-offsets.h>
-#endif
-
 #include <linux/cpumask.h>
 #include <linux/irqreturn.h>
+#include <linux/thread_info.h>
 
 #ifdef CONFIG_SMP
 
@@ -34,12 +30,10 @@ void arch_send_call_function_ipi_mask(struct cpumask *mask);
 void arch_send_call_function_single_ipi(int cpu);
 
 /*
- * This is particularly ugly: it appears we can't actually get the definition
- * of task_struct here, but we need access to the CPU this task is running on.
- * Instead of using C we're using asm-offsets.h to get the current processor
- * ID.
+ * Obtains the hart ID of the currently executing task.  This relies on
+ * THREAD_INFO_IN_TASK, but we define that unconditionally.
  */
-#define raw_smp_processor_id() (*((int*)((char*)get_current() + TASK_TI_CPU)))
+#define raw_smp_processor_id() (current_thread_info()->cpu)
 
 #endif /* CONFIG_SMP */
 
-- 
2.7.4

