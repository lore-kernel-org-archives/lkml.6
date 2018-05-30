Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937227AbeE3HEE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:04:04 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35918 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964773AbeE3HD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:03:59 -0400
X-Google-Smtp-Source: ADUXVKJVAUD9rPSoQX0IkHAc1MdvDIWoYn1VpiFRUys2/p36xGbZQ/BxTfCVRAomJoF72U1ttAmNYA==
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] printk: drop in_nmi check from printk_safe_flush_on_panic()
Date: Wed, 30 May 2018 16:03:50 +0900
Message-Id: <20180530070350.10131-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the in_nmi() check from printk_safe_flush_on_panic()
and attempt to re-init (IOW unlock) locked logbuf spinlock
from panic CPU regardless of its context. Otherwise,
theoretically, we can deadlock on logbuf trying to flush
per-CPU buffers:
a) Panic CPU is running in non-NMI context
b) Panic CPU sends out shutdown IPI via reboot vector
c) Panic CPU fails to stop all remote CPUs
d) Panic CPU sends out shutdown IPI via NMI vector
   One of the CPUs that we bring down via NMI vector can hold
   logbuf spin lock (theoretically).

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/printk_safe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 3e3c2004bb23..baa80de5d8ec 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -278,7 +278,7 @@ void printk_safe_flush_on_panic(void)
 	 * Make sure that we could access the main ring buffer.
 	 * Do not risk a double release when more CPUs are up.
 	 */
-	if (in_nmi() && raw_spin_is_locked(&logbuf_lock)) {
+	if (raw_spin_is_locked(&logbuf_lock)) {
 		if (num_online_cpus() > 1)
 			return;
 
-- 
2.17.0
