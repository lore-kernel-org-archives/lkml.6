Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752596AbeEKLCf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 07:02:35 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:11214 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeEKLCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 07:02:34 -0400
To: sergey.senozhatsky.work@gmail.com
Cc: pmladek@suse.com, dvyukov@google.com, sergey.senozhatsky@gmail.com,
        syzkaller@googlegroups.com, rostedt@goodmis.org,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: [PATCH] printk: fix possible reuse of va_list variable
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <201805102350.JJH73950.tVJHQLFSOMOOFF@I-love.SAKURA.ne.jp>
        <20180511014515.GA895@jagdpanzerIV>
        <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
        <20180511062151.GA18160@jagdpanzerIV>
In-Reply-To: <20180511062151.GA18160@jagdpanzerIV>
Message-Id: <201805112002.GIF21216.OFVHFOMLJtQFSO@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Fri, 11 May 2018 20:02:31 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From 766cf72b5fdc00d1cf5a8ca2c6b23ebb75e2b4d4 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Fri, 11 May 2018 19:54:19 +0900
Subject: [PATCH] printk: fix possible reuse of va_list variable

I noticed that there is a possibility that printk_safe_log_store() causes
kernel oops because "args" parameter is passed to vsnprintf() again when
atomic_cmpxchg() detected that we raced. Fix this by using va_copy().

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 42a0bb3f71383b45 ("printk/nmi: generic solution for safe printk in NMI")
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/printk/printk_safe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 3e3c200..449d67e 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -82,6 +82,7 @@ static __printf(2, 0) int printk_safe_log_store(struct printk_safe_seq_buf *s,
 {
 	int add;
 	size_t len;
+	va_list ap;
 
 again:
 	len = atomic_read(&s->len);
@@ -100,7 +101,9 @@ static __printf(2, 0) int printk_safe_log_store(struct printk_safe_seq_buf *s,
 	if (!len)
 		smp_rmb();
 
-	add = vscnprintf(s->buffer + len, sizeof(s->buffer) - len, fmt, args);
+	va_copy(ap, args);
+	add = vscnprintf(s->buffer + len, sizeof(s->buffer) - len, fmt, ap);
+	va_end(ap);
 	if (!add)
 		return 0;
 
-- 
1.8.3.1
