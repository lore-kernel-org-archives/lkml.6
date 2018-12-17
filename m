Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6587DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271E521849
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389372AbeLQVFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:05:12 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57013 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbeLQVFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:05:11 -0500
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBHL58j2098349;
        Tue, 18 Dec 2018 06:05:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Tue, 18 Dec 2018 06:05:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBHL57IC098343
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 18 Dec 2018 06:05:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add caller information to printk() output.
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
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
 <20181217145452.3kev4rmo2l5lt2qy@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <93f19e57-5051-c67d-9af4-b17624062d44@i-love.sakura.ne.jp>
Date:   Tue, 18 Dec 2018 06:05:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181217145452.3kev4rmo2l5lt2qy@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/17 23:54, Petr Mladek wrote:
> On Thu 2018-12-13 21:42:55, Sergey Senozhatsky wrote:
>> On (12/13/18 13:18), Petr Mladek wrote:
>>>> Sometimes we want to print a series of printk() messages to consoles
>>>> without being disturbed by concurrent printk() from interrupts and/or
>>>> other threads. But we can't enforce printk() callers to use their local
>>>> buffers because we need to ask them to make too much changes. Also, even
>>>> buffering up to one line inside printk() might cause failing to emit
>>>> an important clue under critical situation.
>>>>
>>>> Therefore, instead of trying to help buffering, let's try to help
>>>> reconstructing messages by saving caller information as of calling
>>>> log_store() and adding it as "[T$thread_id]" or "[C$processor_id]"
>>>> upon printing to consoles.
>>>>
>>> Reviewed-by: Petr Mladek <pmladek@suse.com>
>>
>> Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>>
>>> From my point of view, the patch is ready to go into
>>> linux-next. Well, I would prefer to keep it there one more
>>> release cycle.
> 
> I have pushed the patch into printk.git, for-4.22 branch.

Thank you.

> 
> 
> Now, I always felt that the "from" name was a bit strange but
> nothing better came to my mind until today.
> 
> I would like to rename "from" to "caller", see the patch below.
> If you agree, I could push it on top or I could even squash it
> into the original patch.
> 
> What do you think about it, please?

No problem. Squashed version attached.

> -	char from[18];
> -#ifdef CONFIG_PRINTK_FROM
> -	u32 id = msg->from_id;
> +	char caller[18];
> +#ifdef CONFIG_PRINTK_CALLER
> +	u32 id = msg->caller_id;
>  
> -	snprintf(from, sizeof(from), ",from=%c%u",
> +	snprintf(caller, sizeof(caller), ",caller=%c%u",
>  		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);

Updated to [20] in case memory corruption like

  CPU: 0 PID: -2035180937 Comm:  L ����� Not tainted 4.20.0-rc6+ #344

happened.



From 91f85d2bd494df2f73c605d8b4747e8cc0a61ae2 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Tue, 18 Dec 2018 05:53:04 +0900
Subject: [PATCH] printk: Add caller information to printk() output.

Sometimes we want to print a series of printk() messages to consoles
without being disturbed by concurrent printk() from interrupts and/or
other threads. But we can't enforce printk() callers to use their local
buffers because we need to ask them to make too much changes. Also, even
buffering up to one line inside printk() might cause failing to emit
an important clue under critical situation.

Therefore, instead of trying to help buffering, let's try to help
reconstructing messages by saving caller information as of calling
log_store() and adding it as "[T$thread_id]" or "[C$processor_id]"
upon printing to consoles.

Some examples for console output:

  [    1.222773][    T1] x86: Booting SMP configuration:
  [    2.779635][    T1] pci 0000:00:01.0: PCI bridge to [bus 01]
  [    5.069193][  T268] Fusion MPT base driver 3.04.20
  [    9.316504][    C2] random: fast init done
  [   13.413336][ T3355] Initialized host personality

Some examples for /dev/kmsg output:

  6,496,1222773,-,caller=T1;x86: Booting SMP configuration:
  6,968,2779635,-,caller=T1;pci 0000:00:01.0: PCI bridge to [bus 01]
   SUBSYSTEM=pci
   DEVICE=+pci:0000:00:01.0
  6,1353,5069193,-,caller=T268;Fusion MPT base driver 3.04.20
  5,1526,9316504,-,caller=C2;random: fast init done
  6,1575,13413336,-,caller=T3355;Initialized host personality

Note that this patch changes max length of messages which can be printed
by printk() or written to /dev/kmsg interface from 992 bytes to 976 bytes,
based on an assumption that userspace won't try to write messages hitting
that border line to /dev/kmsg interface.

Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++----
 lib/Kconfig.debug      | 17 ++++++++++++++++
 2 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1306fe0..7eb79702 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -356,6 +356,9 @@ struct printk_log {
 	u8 facility;		/* syslog facility */
 	u8 flags:5;		/* internal record flags */
 	u8 level:3;		/* syslog level */
+#ifdef CONFIG_PRINTK_CALLER
+	u32 caller_id;            /* thread id or processor id */
+#endif
 }
 #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 __packed __aligned(4)
@@ -422,7 +425,11 @@ __packed __aligned(4)
 static u64 clear_seq;
 static u32 clear_idx;
 
+#ifdef CONFIG_PRINTK_CALLER
+#define PREFIX_MAX		48
+#else
 #define PREFIX_MAX		32
+#endif
 #define LOG_LINE_MAX		(1024 - PREFIX_MAX)
 
 #define LOG_LEVEL(v)		((v) & 0x07)
@@ -625,6 +632,12 @@ static int log_store(int facility, int level,
 		msg->ts_nsec = ts_nsec;
 	else
 		msg->ts_nsec = local_clock();
+#ifdef CONFIG_PRINTK_CALLER
+	if (in_task())
+		msg->caller_id = task_pid_nr(current);
+	else
+		msg->caller_id = 0x80000000 + raw_smp_processor_id();
+#endif
 	memset(log_dict(msg) + dict_len, 0, pad_len);
 	msg->len = size;
 
@@ -688,12 +701,21 @@ static ssize_t msg_print_ext_header(char *buf, size_t size,
 				    struct printk_log *msg, u64 seq)
 {
 	u64 ts_usec = msg->ts_nsec;
+	char caller[20];
+#ifdef CONFIG_PRINTK_CALLER
+	u32 id = msg->caller_id;
+
+	snprintf(caller, sizeof(caller), ",caller=%c%u",
+		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
+#else
+	caller[0] = '\0';
+#endif
 
 	do_div(ts_usec, 1000);
 
-	return scnprintf(buf, size, "%u,%llu,%llu,%c;",
-		       (msg->facility << 3) | msg->level, seq, ts_usec,
-		       msg->flags & LOG_CONT ? 'c' : '-');
+	return scnprintf(buf, size, "%u,%llu,%llu,%c%s;",
+			 (msg->facility << 3) | msg->level, seq, ts_usec,
+			 msg->flags & LOG_CONT ? 'c' : '-', caller);
 }
 
 static ssize_t msg_print_ext_body(char *buf, size_t size,
@@ -1038,6 +1060,9 @@ void log_buf_vmcoreinfo_setup(void)
 	VMCOREINFO_OFFSET(printk_log, len);
 	VMCOREINFO_OFFSET(printk_log, text_len);
 	VMCOREINFO_OFFSET(printk_log, dict_len);
+#ifdef CONFIG_PRINTK_CALLER
+	VMCOREINFO_OFFSET(printk_log, caller_id);
+#endif
 }
 #endif
 
@@ -1236,10 +1261,23 @@ static size_t print_time(u64 ts, char *buf)
 {
 	unsigned long rem_nsec = do_div(ts, 1000000000);
 
-	return sprintf(buf, "[%5lu.%06lu] ",
+	return sprintf(buf, "[%5lu.%06lu]",
 		       (unsigned long)ts, rem_nsec / 1000);
 }
 
+#ifdef CONFIG_PRINTK_CALLER
+static size_t print_caller(u32 id, char *buf)
+{
+	char from[12];
+
+	snprintf(from, sizeof(from), "%c%u",
+		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
+	return sprintf(buf, "[%6s]", from);
+}
+#else
+#define print_caller(id, buf) 0
+#endif
+
 static size_t print_prefix(const struct printk_log *msg, bool syslog,
 			   bool time, char *buf)
 {
@@ -1247,8 +1285,17 @@ static size_t print_prefix(const struct printk_log *msg, bool syslog,
 
 	if (syslog)
 		len = print_syslog((msg->facility << 3) | msg->level, buf);
+
 	if (time)
 		len += print_time(msg->ts_nsec, buf + len);
+
+	len += print_caller(msg->caller_id, buf + len);
+
+	if (IS_ENABLED(CONFIG_PRINTK_CALLER) || time) {
+		buf[len++] = ' ';
+		buf[len] = '\0';
+	}
+
 	return len;
 }
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9638656..608c355 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -17,6 +17,23 @@ config PRINTK_TIME
 	  The behavior is also controlled by the kernel command line
 	  parameter printk.time=1. See Documentation/admin-guide/kernel-parameters.rst
 
+config PRINTK_CALLER
+	bool "Show caller information on printks"
+	depends on PRINTK
+	help
+	  Selecting this option causes "thread id" (if in task context) or
+	  "processor id" (if not in task context) of the printk() messages
+	  to be added.
+
+	  This option is intended for environments where multiple threads
+	  concurrently call printk() for many times, for it is difficult to
+	  interpret without knowing where these lines (or sometimes individual
+	  line which was divided into multiple lines due to race) came from.
+
+	  Since toggling after boot makes the code racy, currently there is
+	  no option to enable/disable at the kernel command line parameter or
+	  sysfs interface.
+
 config CONSOLE_LOGLEVEL_DEFAULT
 	int "Default console loglevel (1-15)"
 	range 1 15
-- 
1.8.3.1
