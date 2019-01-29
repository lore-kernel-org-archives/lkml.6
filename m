Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C140CC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925FE2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548764716;
	bh=pnbSH7l2QSlRRn0pxfx4RPnN6AbvF3PlF/HeMHaTsfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QmdG6a4b9L1MjV9C/7zBDK75uxViKGsYSnpEbCzCA/2LxaAmmnJn/z9TPbdObdzDP
	 eiw06Mxopg6TXh07zN5EZdEOK4eXmhx5bI16PGcHEMFm0j24Ke2dcBtnJ92SgW3Bq1
	 2L6GTCXGr1vpCIy/V0E23UBbZ7tIdee27WikAi80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfA2MZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:25:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:36044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbfA2MZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:25:13 -0500
Received: from localhost.localdomain (unknown [60.186.218.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C75792087E;
        Tue, 29 Jan 2019 12:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548764712;
        bh=pnbSH7l2QSlRRn0pxfx4RPnN6AbvF3PlF/HeMHaTsfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bb481fjgrRntRWSXjmep0Ppeid5GsmI71omQYuQ2xWEaTbFsIHJlF624itMXIhsV7
         bpgiryPIyMUNPu1puhow/eBL7m1Jc46VQMIM3i8fFrN7hWFSlF4xxEtltjWhxW4+5n
         lJJBSA34y++GLo89r9i+ntxWjJExfe9uvrxvYQGM=
From:   guoren@kernel.org
To:     arnd@arndb.de, robh+dt@kernel.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 08/10] csky: coding convention: Use task_stack_page
Date:   Tue, 29 Jan 2019 20:24:27 +0800
Message-Id: <1548764669-16656-8-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548764669-16656-1-git-send-email-guoren@kernel.org>
References: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Use task_stack_page instead of p->stack to get stack. Follow the coding
convention style. Also for init_stack, the same with other archs.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/processor.h | 4 ++--
 arch/csky/kernel/smp.c            | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
index 8f45481..21e0bd5 100644
--- a/arch/csky/include/asm/processor.h
+++ b/arch/csky/include/asm/processor.h
@@ -49,7 +49,7 @@ struct thread_struct {
 };
 
 #define INIT_THREAD  { \
-	.ksp = (unsigned long) init_thread_union.stack + THREAD_SIZE, \
+	.ksp = sizeof(init_stack) + (unsigned long) &init_stack, \
 	.sr = DEFAULT_PSR_VALUE, \
 }
 
@@ -95,7 +95,7 @@ unsigned long get_wchan(struct task_struct *p);
 #define KSTK_ESP(tsk)		(task_pt_regs(tsk)->usp)
 
 #define task_pt_regs(p) \
-	((struct pt_regs *)(THREAD_SIZE + p->stack) - 1)
+	((struct pt_regs *)(THREAD_SIZE + task_stack_page(p)) - 1)
 
 #define cpu_relax() barrier()
 
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index ddc4dd7..b07a534 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -160,7 +160,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
 	unsigned long mask = 1 << cpu;
 
-	secondary_stack = (unsigned int)tidle->stack + THREAD_SIZE - 8;
+	secondary_stack =
+		(unsigned int) task_stack_page(tidle) + THREAD_SIZE - 8;
 	secondary_hint = mfcr("cr31");
 	secondary_ccr  = mfcr("cr18");
 
-- 
2.7.4

