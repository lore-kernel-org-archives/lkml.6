Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB524C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924562087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfBZLyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:54:13 -0500
Received: from aliyun-cloud.icoremail.net ([47.90.88.95]:51181 "HELO
        aliyun-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S1726469AbfBZLyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:54:12 -0500
Received: from bogon.wangsu.com (unknown [59.61.78.237])
        by app2 (Coremail) with SMTP id 4zNnewCnJAT_JnVc+aQ9AA--.7800S2;
        Tue, 26 Feb 2019 19:46:13 +0800 (CST)
From:   Lin Feng <linf@wangsu.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com, fabf@skynet.be,
        arjan@infradead.org, linf@wangsu.com
Subject: [PATCH 1/2] kernel/latencytop.c: rename clear_all_latency_tracing to clear_tsk_latency_tracing
Date:   Tue, 26 Feb 2019 19:46:01 +0800
Message-Id: <20190226114602.16902-1-linf@wangsu.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 4zNnewCnJAT_JnVc+aQ9AA--.7800S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF15CF4kXF1UAFyDZr4DXFb_yoW5Jw4xpF
        1kZw17Ca1xAa1v9ry0g3yDCw15tw4kurW7GrZ5A34FqFnxKFnagFnFk3Wjyr4Yyry8Kana
        gF4DKw4DJF48GFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: holqwq5zdqw23xof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name clear_all_latency_tracing is misleading, in fact which only
clear per task's latency_record[], and we do have another function
named clear_global_latency_tracing which clear the global
latency_record[] buffer.

Signed-off-by: Lin Feng <linf@wangsu.com>
---
 fs/proc/base.c             | 2 +-
 include/linux/latencytop.h | 4 ++--
 kernel/fork.c              | 2 +-
 kernel/latencytop.c        | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index f5ed9512d193..da0f6112d314 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -511,7 +511,7 @@ static ssize_t lstats_write(struct file *file, const char __user *buf,
 
 	if (!task)
 		return -ESRCH;
-	clear_all_latency_tracing(task);
+	clear_tsk_latency_tracing(task);
 	put_task_struct(task);
 
 	return count;
diff --git a/include/linux/latencytop.h b/include/linux/latencytop.h
index 7c560e0dc8f4..9022f0c2e2e4 100644
--- a/include/linux/latencytop.h
+++ b/include/linux/latencytop.h
@@ -36,7 +36,7 @@ account_scheduler_latency(struct task_struct *task, int usecs, int inter)
 		__account_scheduler_latency(task, usecs, inter);
 }
 
-void clear_all_latency_tracing(struct task_struct *p);
+void clear_tsk_latency_tracing(struct task_struct *p);
 
 extern int sysctl_latencytop(struct ctl_table *table, int write,
 			void __user *buffer, size_t *lenp, loff_t *ppos);
@@ -48,7 +48,7 @@ account_scheduler_latency(struct task_struct *task, int usecs, int inter)
 {
 }
 
-static inline void clear_all_latency_tracing(struct task_struct *p)
+static inline void clear_tsk_latency_tracing(struct task_struct *p)
 {
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index b69248e6f0e0..4f32faf9dfa9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1963,7 +1963,7 @@ static __latent_entropy struct task_struct *copy_process(
 #ifdef TIF_SYSCALL_EMU
 	clear_tsk_thread_flag(p, TIF_SYSCALL_EMU);
 #endif
-	clear_all_latency_tracing(p);
+	clear_tsk_latency_tracing(p);
 
 	/* ok, now we should be set up.. */
 	p->pid = pid_nr(pid);
diff --git a/kernel/latencytop.c b/kernel/latencytop.c
index 96b4179cee6a..9e794b49791e 100644
--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -67,7 +67,7 @@ static struct latency_record latency_record[MAXLR];
 
 int latencytop_enabled;
 
-void clear_all_latency_tracing(struct task_struct *p)
+void clear_tsk_latency_tracing(struct task_struct *p)
 {
 	unsigned long flags;
 
-- 
2.20.1

