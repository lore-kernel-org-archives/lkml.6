Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07744C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 11:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFA3206B7
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 11:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFA3206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbeLBLX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:23:56 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:59226 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbeLBLX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 06:23:56 -0500
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wB2BNoce080564;
        Sun, 2 Dec 2018 20:23:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Sun, 02 Dec 2018 20:23:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wB2BNinR080454
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 2 Dec 2018 20:23:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add caller information to printk() output.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Petr Mladek <pmladek@suse.com>, Dmitry Vyukov <dvyukov@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1543045075-3008-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181130154024.ls3mntfdr4zvluub@pathway.suse.cz>
 <f224bd68-7394-ff70-cad6-d3fbbb3b5f7d@i-love.sakura.ne.jp>
Message-ID: <1bd509ec-0a3a-55cc-d43b-02baa489019a@i-love.sakura.ne.jp>
Date:   Sun, 2 Dec 2018 20:23:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <f224bd68-7394-ff70-cad6-d3fbbb3b5f7d@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/01 23:44, Tetsuo Handa wrote:
> On 2018/12/01 0:40, Petr Mladek wrote:
>>> Some examples for console output:
>>>
>>>   [    0.293000] [T1] smpboot: CPU0: Intel(R) Core(TM) i5-4440S CPU @ 2.80GHz (family: 0x6, model: 0x3c, stepping: 0x3)
>>>   [    0.299733] [T1] Performance Events: Haswell events, core PMU driver.
>>>   [    2.813808] [T35] clocksource: Switched to clocksource tsc
>>>   [    2.893984] [C0] random: fast init done
>>                   ^
>>
>> Please, remove the space between the timestamp and the from field.
> 
> This space was emitted by print_time(). Do we want to modify print_time()
> not to emit this space if the from field is printed?
> 
> If we modify print_time(), I think that the leading spaces inserted by "%5lu"
> makes little sense, for "%5lu" is too small for systems with uptime >= 1.16 days
> and parsers after all cannot assume fixed length for the timestamp field. Then,
> we could change from "%5lu.%06lu" to "%lu.%06lu" so that parsers (like /bin/awk)
> can get prefix part using white spaces as a delimiter.
> 
> If we want to reduce space, do we want to do like
> 
>   [0.293000@T1] smpboot: CPU0: Intel(R) Core(TM) i5-4440S CPU @ 2.80GHz (family: 0x6, model: 0x3c, stepping: 0x3)
>   [0.299733@T1] Performance Events: Haswell events, core PMU driver.
>   [2.813808@T35] clocksource: Switched to clocksource tsc
>   [2.893984@C0] random: fast init done
> 
> (if printk_time = true) or
> 
>   [@T1] smpboot: CPU0: Intel(R) Core(TM) i5-4440S CPU @ 2.80GHz (family: 0x6, model: 0x3c, stepping: 0x3)
>   [@T1] Performance Events: Haswell events, core PMU driver.
>   [@T35] clocksource: Switched to clocksource tsc
>   [@C0] random: fast init done
> 
> (if printk_time = false) ?
> 
> Dmitry, what format/delimiter is convenient for parsing by syzbot?

Here is an updated patch (which uses appropriate PREFIX_MAX definition
after "[PATCH v2] printk: fix printk_time race." is applied).

From 48603394cc0c8c5ad9ee57bc665dfd2c421e923b Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sun, 2 Dec 2018 19:41:02 +0900
Subject: [PATCH v2] printk: Add caller information to printk() output.

Sometimes we want to print a series of printk() messages to consoles
without being disturbed by concurrent printk() from interrupts and/or
other threads. But we can't enforce printk() callers to use their local
buffers because we need to ask them to make too much changes. Also, even
buffering up to one line inside printk() might cause failing to emit
an important clue under critical situation.

Therefore, instead of trying to help buffering, let's try to help
reconstructing messages by saving caller information as of calling
log_store() and adding it as "@T$thread_id" or "@C$processor_id" upon
printing to consoles.

Some examples for console output:

  [    0.919699]@T1 x86: Booting SMP configuration:
  [    4.152681]@T271 Fusion MPT base driver 3.04.20
  [    5.070470]@C0 random: fast init done
  [    6.587900]@C3 random: crng init done

# Not yet signed-off in order to silence build-bot error reports.
---
 kernel/printk/printk.c | 62 ++++++++++++++++++++++++++++++--------------------
 lib/Kconfig.debug      | 17 ++++++++++++++
 2 files changed, 54 insertions(+), 25 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0b47e34..31151e8 100644
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
+		msg->from_id = current->pid;
+	else
+		msg->from_id = 0x80000000 + raw_smp_processor_id();
+#endif
 	memset(log_dict(msg) + dict_len, 0, pad_len);
 	msg->len = size;
 
@@ -1227,39 +1242,36 @@ static inline void boot_delay_msec(int level)
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
 
-	if (time)
-		len += print_time(msg->ts_nsec, buf ? buf + len : NULL);
+		len += sprintf(buf + len, "@%c%u",
+			       id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
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

