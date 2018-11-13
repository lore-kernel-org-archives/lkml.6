Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A849DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C58223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C58223D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbeKMRVl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 12:21:41 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:59508 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbeKMRVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 12:21:41 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 5960D3D712ED0488290D;
        Tue, 13 Nov 2018 15:24:50 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAD7OeVm043841;
        Tue, 13 Nov 2018 15:24:40 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018111315245436-10380498 ;
          Tue, 13 Nov 2018 15:24:54 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        konrad.wilk@oracle.com, wang.yi59@zte.com.cn, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, riel@redhat.com,
        viro@ZenIV.linux.org.uk, zhong.weidong@zte.com.cn
Subject: [PATCH] fork: Fix two -Wmissing-prototypes warnings
Date:   Tue, 13 Nov 2018 15:26:28 +0800
Message-Id: <1542093988-42041-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-13 15:24:54,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-13 15:24:36
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse01.zte.com.cn wAD7OeVm043841
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get two warning when building kernel with W=1:
kernel/fork.c:167:13: warning: no previous prototype for ‘arch_release_thread_stack’ [-Wmissing-prototypes]
kernel/fork.c:779:13: warning: no previous prototype for ‘fork_init’ [-Wmissing-prototypes]

Add the missing declaration in head file to fix this.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 arch/x86/include/asm/thread_info.h | 1 +
 include/linux/sched/task.h         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 2ff2a30..8621036 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -237,6 +237,7 @@ static inline int arch_within_stack_frames(const void * const stack,
 extern void arch_task_cache_init(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 extern void arch_release_task_struct(struct task_struct *tsk);
+extern void arch_release_thread_stack(unsigned long *stack);
 extern void arch_setup_new_exec(void);
 #define arch_setup_new_exec arch_setup_new_exec
 #endif	/* !__ASSEMBLY__ */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 108ede9..44c6f15 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -39,6 +39,8 @@
 
 extern void proc_caches_init(void);
 
+extern void fork_init(void);
+
 extern void release_task(struct task_struct * p);
 
 #ifdef CONFIG_HAVE_COPY_THREAD_TLS
-- 
1.8.3.1

