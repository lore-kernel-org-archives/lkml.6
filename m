Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C65C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D03C21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548342358;
	bh=pnbSH7l2QSlRRn0pxfx4RPnN6AbvF3PlF/HeMHaTsfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sqfzLAIn7v8ZxbAtNfPOK8nQozWqKVmhddMN63d60CaT4III+zijLNg5tOVFpuhev
	 0TmJRV8qz6F31+LDh3mcrjxZ3Fk2hjFDn1FH4Wqjdrf0mR3IVmHS81h50DqRGxaNoQ
	 5DcKeJW7fB4mKVnM/h878VdpA6L9xpBG8Iw+d7Zo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfAXPF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:05:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbfAXPFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:05:55 -0500
Received: from localhost.localdomain (unknown [60.186.138.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEAAF21872;
        Thu, 24 Jan 2019 15:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548342354;
        bh=pnbSH7l2QSlRRn0pxfx4RPnN6AbvF3PlF/HeMHaTsfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMZejdXMmZ5MYIMb+CK+uZbfjYRDtP0j3gs8J0B5UEk+GDHKTSl9+j/4RIvLhy7fd
         NH/IJI3Wfmi4pyGY9Xp4LmUE5ZSscABGHhE1psTT5bVyQQlee1NwmiMVTGRcNVNysI
         8GJfbB47a4KihbnKO9OOJXHTDY5N4l6YbyIWxyLM=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 2/2] csky: coding convention: use task_stack_page
Date:   Thu, 24 Jan 2019 23:05:28 +0800
Message-Id: <1548342328-25268-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548342328-25268-1-git-send-email-guoren@kernel.org>
References: <1548342328-25268-1-git-send-email-guoren@kernel.org>
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

