Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84066C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5590821019
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfACDx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:53:28 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:43485 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726136AbfACDx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 22:53:28 -0500
X-Greylist: delayed 1224 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jan 2019 22:53:27 EST
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id x033al6P020432;
        Thu, 3 Jan 2019 11:36:47 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x033aQWw020403;
        Thu, 3 Jan 2019 11:36:26 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 3 Jan 2019
 11:32:40 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <linux-arch@vger.kernel.org>
CC:     Vincent Chen <vincentc@andestech.com>
Subject: [PATCH] RISC-V: Add _TIF_NEED_RESCHED check for kernel thread when CONFIG_PREEMPT=y
Date:   Thu, 3 Jan 2019 11:32:33 +0800
Message-ID: <1546486353-23115-1-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x033aQWw020403
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cond_resched() can be used to yield the CPU resource if
CONFIG_PREEMPT is not defined. Otherwise, cond_resched() is a dummy
function. In order to avoid kernel thread occupying entire CPU,
when CONFIG_PREEMPT=y, the kernel thread needs to follow the
rescheduling mechanism like a user thread.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 arch/riscv/kernel/asm-offsets.c |    1 +
 arch/riscv/kernel/entry.S       |   18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 6a92a2f..dac9834 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -39,6 +39,7 @@ void asm_offsets(void)
 	OFFSET(TASK_STACK, task_struct, stack);
 	OFFSET(TASK_TI, task_struct, thread_info);
 	OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
+	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
 	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
 	OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 13d4826..728b72d 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -144,6 +144,10 @@ _save_context:
 	REG_L x2,  PT_SP(sp)
 	.endm
 
+#if !IS_ENABLED(CONFIG_PREEMPT)
+#define resume_kernel restore_all
+#endif
+
 ENTRY(handle_exception)
 	SAVE_ALL
 
@@ -228,7 +232,7 @@ ret_from_exception:
 	REG_L s0, PT_SSTATUS(sp)
 	csrc sstatus, SR_SIE
 	andi s0, s0, SR_SPP
-	bnez s0, restore_all
+	bnez s0, resume_kernel
 
 resume_userspace:
 	/* Interrupts must be disabled here so flags are checked atomically */
@@ -250,6 +254,18 @@ restore_all:
 	RESTORE_ALL
 	sret
 
+#if IS_ENABLED(CONFIG_PREEMPT)
+resume_kernel:
+	REG_L s0, TASK_TI_PREEMPT_COUNT(tp)
+	bnez s0, restore_all
+need_resched:
+	REG_L s0, TASK_TI_FLAGS(tp)
+	andi s0, s0, _TIF_NEED_RESCHED
+	beqz s0, restore_all
+	call preempt_schedule_irq
+	j need_resched
+#endif
+
 work_pending:
 	/* Enter slow path for supplementary processing */
 	la ra, ret_from_exception
-- 
1.7.1

