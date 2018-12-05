Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639FFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD7920672
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD7920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeLEKmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:42:33 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:34689 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbeLEKmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:42:33 -0500
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wB5AgU8U044251;
        Wed, 5 Dec 2018 19:42:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Wed, 05 Dec 2018 19:42:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wB5AgNFb044039
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 5 Dec 2018 19:42:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add caller information to printk() output.
To:     Petr Mladek <pmladek@suse.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
References: <1543045075-3008-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181130154024.ls3mntfdr4zvluub@pathway.suse.cz>
 <f224bd68-7394-ff70-cad6-d3fbbb3b5f7d@i-love.sakura.ne.jp>
 <20181203150603.cdqii263e4kmmibo@pathway.suse.cz>
 <b38c6957-c3c1-54fc-781e-06d7eed6a9b1@i-love.sakura.ne.jp>
 <20181204152724.ypk44mi4a56nrud4@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
Date:   Wed, 5 Dec 2018 19:42:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181204152724.ypk44mi4a56nrud4@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/05 0:27, Petr Mladek wrote:
> On Tue 2018-12-04 06:10:40, Tetsuo Handa wrote:
>> On 2018/12/04 0:06, Petr Mladek wrote:
>>>> If we modify print_time(), I think that the leading spaces inserted by "%5lu"
>>>> makes little sense, for "%5lu" is too small for systems with uptime >= 1.16 days
>>>> and parsers after all cannot assume fixed length for the timestamp field. Then,
>>>> we could change from "%5lu.%06lu" to "%lu.%06lu" so that parsers (like /bin/awk)
>>>> can get prefix part using white spaces as a delimiter.
>>>
>>> My primary concern was a human readability. The different header columns
>>> are separated by brackets and the message itself is separated by the space.
>>
>> PID_MAX_LIMIT is 4194304, which can take up to 10 bytes if [T%u] is used.
> 
> 4194304 is the worst case. I would use the same approach as with the
> timestamp seconds. It uses 5 characters as the minimum. But it might
> eventully get bigger.
> 
> IMHO, [T%5u] looks like a reasonable default.
> 

While "%5lu.%06lu" for uptime does not decrease over time (and hence changing
to "%lu.%06lu" does not cause wavy output), "[%6s]" for T$thread_id will cause
wavy output after PID reached 100000. Isn't it hard to parse after all?

From 22a5c966651095d12ab1572f6d35dc86d5671ea5 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 5 Dec 2018 16:53:08 +0900
Subject: [PATCH v3] printk: Add caller information to printk() output.

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

  6,496,1222773,-,from=T1;x86: Booting SMP configuration:
  6,968,2779635,-,from=T1;pci 0000:00:01.0: PCI bridge to [bus 01]
   SUBSYSTEM=pci
   DEVICE=+pci:0000:00:01.0
  6,1353,5069193,-,from=T268;Fusion MPT base driver 3.04.20
  5,1526,9316504,-,from=C2;random: fast init done
  6,1575,13413336,-,from=T3355;Initialized host personality

# Not yet signed-off in order to silence build-bot error reports.
---
 kernel/printk/printk.c | 82 +++++++++++++++++++++++++++++++++-----------------
 lib/Kconfig.debug      | 17 +++++++++++
 2 files changed, 71 insertions(+), 28 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 4f18472..f9812f6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -356,6 +356,9 @@ struct printk_log {
 	u8 facility;		/* syslog facility */
 	u8 flags:5;		/* internal record flags */
 	u8 level:3;		/* syslog level */
+#ifdef CONFIG_PRINTK_FROM
+	u32 from_id;            /* thread id or processor id */
+#endif
 }
 #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 __packed __aligned(4)
@@ -422,8 +425,14 @@ __packed __aligned(4)
 static u64 clear_seq;
 static u32 clear_idx;
 
+#ifdef CONFIG_PRINTK_FROM
+#define PREFIX_FROM_MAX		16
+#define PREFIX_MAX		(32 + PREFIX_FROM_MAX)
+#define LOG_LINE_MAX		(1024 - 32)
+#else
 #define PREFIX_MAX		32
 #define LOG_LINE_MAX		(1024 - PREFIX_MAX)
+#endif
 
 #define LOG_LEVEL(v)		((v) & 0x07)
 #define LOG_FACILITY(v)		((v) >> 3 & 0xff)
@@ -625,6 +634,12 @@ static int log_store(int facility, int level,
 		msg->ts_nsec = ts_nsec;
 	else
 		msg->ts_nsec = local_clock();
+#ifdef CONFIG_PRINTK_FROM
+	if (in_task())
+		msg->from_id = task_pid_nr(current);
+	else
+		msg->from_id = 0x80000000 + raw_smp_processor_id();
+#endif
 	memset(log_dict(msg) + dict_len, 0, pad_len);
 	msg->len = size;
 
@@ -688,12 +703,21 @@ static ssize_t msg_print_ext_header(char *buf, size_t size,
 				    struct printk_log *msg, u64 seq)
 {
 	u64 ts_usec = msg->ts_nsec;
+	char from[18];
+#ifdef CONFIG_PRINTK_FROM
+	u32 id = msg->from_id;
+
+	snprintf(from, sizeof(from), ",from=%c%u",
+		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
+#else
+	from[0] = '\0';
+#endif
 
 	do_div(ts_usec, 1000);
 
-	return scnprintf(buf, size, "%u,%llu,%llu,%c;",
-		       (msg->facility << 3) | msg->level, seq, ts_usec,
-		       msg->flags & LOG_CONT ? 'c' : '-');
+	return scnprintf(buf, size, "%u,%llu,%llu,%c%s;",
+			 (msg->facility << 3) | msg->level, seq, ts_usec,
+			 msg->flags & LOG_CONT ? 'c' : '-', from);
 }
 
 static ssize_t msg_print_ext_body(char *buf, size_t size,
@@ -1038,6 +1062,9 @@ void log_buf_vmcoreinfo_setup(void)
 	VMCOREINFO_OFFSET(printk_log, len);
 	VMCOREINFO_OFFSET(printk_log, text_len);
 	VMCOREINFO_OFFSET(printk_log, dict_len);
+#ifdef CONFIG_PRINTK_FROM
+	VMCOREINFO_OFFSET(printk_log, from_id);
+#endif
 }
 #endif
 
@@ -1227,39 +1254,38 @@ static inline void boot_delay_msec(int level)
 static bool printk_time = IS_ENABLED(CONFIG_PRINTK_TIME);
 module_param_named(time, printk_time, bool, S_IRUGO | S_IWUSR);
 
-static size_t print_time(u64 ts, char *buf)
-{
-	unsigned long rem_nsec = do_div(ts, 1000000000);
-
-	if (!buf)
-		return snprintf(NULL, 0, "[%5lu.000000] ", (unsigned long)ts);
-
-	return sprintf(buf, "[%5lu.%06lu] ",
-		       (unsigned long)ts, rem_nsec / 1000);
-}
-
 static size_t print_prefix(const struct printk_log *msg, bool syslog,
 			   bool time, char *buf)
 {
 	size_t len = 0;
-	unsigned int prefix = (msg->facility << 3) | msg->level;
+	char tmp[PREFIX_MAX];
 
+	if (!buf)
+		buf = tmp;
 	if (syslog) {
-		if (buf) {
-			len += sprintf(buf, "<%u>", prefix);
-		} else {
-			len += 3;
-			if (prefix > 999)
-				len += 3;
-			else if (prefix > 99)
-				len += 2;
-			else if (prefix > 9)
-				len++;
-		}
+		unsigned int prefix = (msg->facility << 3) | msg->level;
+
+		len += sprintf(buf, "<%u>", prefix);
+	}
+	if (time) {
+		u64 ts = msg->ts_nsec;
+		unsigned long rem_nsec = do_div(ts, 1000000000);
+
+		len += sprintf(buf + len, "[%5lu.%06lu]", (unsigned long)ts,
+			       rem_nsec / 1000);
 	}
+#ifdef CONFIG_PRINTK_FROM
+	{
+		u32 id = msg->from_id;
+		char from[12];
 
-	if (time)
-		len += print_time(msg->ts_nsec, buf ? buf + len : NULL);
+		snprintf(from, sizeof(from), "%c%u",
+			 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
+		len += sprintf(buf + len, "[%6s]", from);
+	}
+#endif
+	if (IS_ENABLED(CONFIG_PRINTK_FROM) || time)
+		buf[len++] = ' ';
 	return len;
 }
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d312188..a403e11 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -17,6 +17,23 @@ config PRINTK_TIME
 	  The behavior is also controlled by the kernel command line
 	  parameter printk.time=1. See Documentation/admin-guide/kernel-parameters.rst
 
+config PRINTK_FROM
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
+	  Since this is currently an experimental functionality which might be
+	  changed/reverted in the future, there is no option to enable/disable
+	  at the kernel command line parameter or sysfs interface.
+
 config CONSOLE_LOGLEVEL_DEFAULT
 	int "Default console loglevel (1-15)"
 	range 1 15
-- 
1.8.3.1

