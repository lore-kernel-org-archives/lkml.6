Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56629C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2360E206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733242AbeLQOy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:54:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:54890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732252AbeLQOy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:54:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0C9AAE17;
        Mon, 17 Dec 2018 14:54:53 +0000 (UTC)
Date:   Mon, 17 Dec 2018 15:54:52 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
Message-ID: <20181217145452.3kev4rmo2l5lt2qy@pathway.suse.cz>
References: <f224bd68-7394-ff70-cad6-d3fbbb3b5f7d@i-love.sakura.ne.jp>
 <20181203150603.cdqii263e4kmmibo@pathway.suse.cz>
 <b38c6957-c3c1-54fc-781e-06d7eed6a9b1@i-love.sakura.ne.jp>
 <20181204152724.ypk44mi4a56nrud4@pathway.suse.cz>
 <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
 <20181210130930.bas4fozjhe3dc5nu@pathway.suse.cz>
 <c5b5d660-d217-35f0-c4f1-7252367934d1@i-love.sakura.ne.jp>
 <e3f69846-ef08-c8f5-368f-4dada13c9970@i-love.sakura.ne.jp>
 <20181213121847.mwlr2vyv6qzclhk6@pathway.suse.cz>
 <20181213124255.GB3053@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213124255.GB3053@tigerII.localdomain>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-12-13 21:42:55, Sergey Senozhatsky wrote:
> On (12/13/18 13:18), Petr Mladek wrote:
> > > Sometimes we want to print a series of printk() messages to consoles
> > > without being disturbed by concurrent printk() from interrupts and/or
> > > other threads. But we can't enforce printk() callers to use their local
> > > buffers because we need to ask them to make too much changes. Also, even
> > > buffering up to one line inside printk() might cause failing to emit
> > > an important clue under critical situation.
> > > 
> > > Therefore, instead of trying to help buffering, let's try to help
> > > reconstructing messages by saving caller information as of calling
> > > log_store() and adding it as "[T$thread_id]" or "[C$processor_id]"
> > > upon printing to consoles.
> > > 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> > From my point of view, the patch is ready to go into
> > linux-next. Well, I would prefer to keep it there one more
> > release cycle.

I have pushed the patch into printk.git, for-4.22 branch.


Now, I always felt that the "from" name was a bit strange but
nothing better came to my mind until today.

I would like to rename "from" to "caller", see the patch below.
If you agree, I could push it on top or I could even squash it
into the original patch.

What do you think about it, please?


From 230cbd8efaf46e6e132a53768cc746b88589c738 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Mon, 17 Dec 2018 14:12:32 +0100
Subject: [PATCH] printk: Rename CONFIG_PRINTK_FROM to CONFIG_PRINTK_CALLER

The name printk_from is a bit unusual and I have troubles
to imagine what it exactly means. For example, @from is used
also for the iterator parameter in devkmsg_write().

I believe that printk_caller is easier to understand.

This patch does not change the existing behavior except
for the names related to PRINTK_FROM feature.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 47 ++++++++++++++++++++++++++---------------------
 lib/Kconfig.debug      |  2 +-
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f8fd63254ca3..b6c5128a1a82 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -357,8 +357,8 @@ struct printk_log {
 	u8 facility;		/* syslog facility */
 	u8 flags:5;		/* internal record flags */
 	u8 level:3;		/* syslog level */
-#ifdef CONFIG_PRINTK_FROM
-	u32 from_id;            /* thread id or processor id */
+#ifdef CONFIG_PRINTK_CALLER
+	u32 caller_id;            /* thread id or processor id */
 #endif
 }
 #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
@@ -426,7 +426,7 @@ static u64 exclusive_console_stop_seq;
 static u64 clear_seq;
 static u32 clear_idx;
 
-#ifdef CONFIG_PRINTK_FROM
+#ifdef CONFIG_PRINTK_CALLER
 #define PREFIX_MAX		48
 #else
 #define PREFIX_MAX		32
@@ -633,11 +633,11 @@ static int log_store(int facility, int level,
 		msg->ts_nsec = ts_nsec;
 	else
 		msg->ts_nsec = local_clock();
-#ifdef CONFIG_PRINTK_FROM
+#ifdef CONFIG_PRINTK_CALLER
 	if (in_task())
-		msg->from_id = task_pid_nr(current);
+		msg->caller_id = task_pid_nr(current);
 	else
-		msg->from_id = 0x80000000 + raw_smp_processor_id();
+		msg->caller_id = 0x80000000 + raw_smp_processor_id();
 #endif
 	memset(log_dict(msg) + dict_len, 0, pad_len);
 	msg->len = size;
@@ -702,21 +702,21 @@ static ssize_t msg_print_ext_header(char *buf, size_t size,
 				    struct printk_log *msg, u64 seq)
 {
 	u64 ts_usec = msg->ts_nsec;
-	char from[18];
-#ifdef CONFIG_PRINTK_FROM
-	u32 id = msg->from_id;
+	char caller[18];
+#ifdef CONFIG_PRINTK_CALLER
+	u32 id = msg->caller_id;
 
-	snprintf(from, sizeof(from), ",from=%c%u",
+	snprintf(caller, sizeof(caller), ",caller=%c%u",
 		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
 #else
-	from[0] = '\0';
+	caller[0] = '\0';
 #endif
 
 	do_div(ts_usec, 1000);
 
 	return scnprintf(buf, size, "%u,%llu,%llu,%c%s;",
 			 (msg->facility << 3) | msg->level, seq, ts_usec,
-			 msg->flags & LOG_CONT ? 'c' : '-', from);
+			 msg->flags & LOG_CONT ? 'c' : '-', caller);
 }
 
 static ssize_t msg_print_ext_body(char *buf, size_t size,
@@ -1061,8 +1061,8 @@ void log_buf_vmcoreinfo_setup(void)
 	VMCOREINFO_OFFSET(printk_log, len);
 	VMCOREINFO_OFFSET(printk_log, text_len);
 	VMCOREINFO_OFFSET(printk_log, dict_len);
-#ifdef CONFIG_PRINTK_FROM
-	VMCOREINFO_OFFSET(printk_log, from_id);
+#ifdef CONFIG_PRINTK_CALLER
+	VMCOREINFO_OFFSET(printk_log, caller_id);
 #endif
 }
 #endif
@@ -1266,8 +1266,8 @@ static size_t print_time(u64 ts, char *buf)
 		       (unsigned long)ts, rem_nsec / 1000);
 }
 
-#ifdef CONFIG_PRINTK_FROM
-static size_t print_from(u32 id, char *buf)
+#ifdef CONFIG_PRINTK_CALLER
+static size_t print_caller(u32 id, char *buf)
 {
 	char from[12];
 
@@ -1275,6 +1275,8 @@ static size_t print_from(u32 id, char *buf)
 		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
 	return sprintf(buf, "[%6s]", from);
 }
+#else
+#define print_caller(id, buf) 0
 #endif
 
 static size_t print_prefix(const struct printk_log *msg, bool syslog,
@@ -1284,14 +1286,17 @@ static size_t print_prefix(const struct printk_log *msg, bool syslog,
 
 	if (syslog)
 		len = print_syslog((msg->facility << 3) | msg->level, buf);
+
 	if (time)
 		len += print_time(msg->ts_nsec, buf + len);
-#ifdef CONFIG_PRINTK_FROM
-	len += print_from(msg->from_id, buf + len);
-#endif
-	if (IS_ENABLED(CONFIG_PRINTK_FROM) || time)
+
+	len += print_caller(msg->caller_id, buf + len);
+
+	if (IS_ENABLED(CONFIG_PRINTK_CALLER) || time) {
 		buf[len++] = ' ';
-	buf[len] = '\0'; /* For safety in case of accessed as a string. */
+		buf[len] = '\0';
+	}
+
 	return len;
 }
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3e8e69e0b3bb..6b1ecd6b67a6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -17,7 +17,7 @@ config PRINTK_TIME
 	  The behavior is also controlled by the kernel command line
 	  parameter printk.time=1. See Documentation/admin-guide/kernel-parameters.rst
 
-config PRINTK_FROM
+config PRINTK_CALLER
 	bool "Show caller information on printks"
 	depends on PRINTK
 	help
-- 
2.13.7

