Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFA4C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EF92077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EF92077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeIEPby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:31:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:56712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726189AbeIEPbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:31:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B4963AE0E;
        Wed,  5 Sep 2018 11:02:08 +0000 (UTC)
Date:   Wed, 5 Sep 2018 13:02:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Maninder Singh <maninder1.s@samsung.com>
Subject: Re: [PATCH 4.19 regression fix] printk: For early boot messages
 check loglevel when flushing the buffer
Message-ID: <20180905110207.rxy3upplgkjbk5oi@pathway.suse.cz>
References: <20180904180154.845-1-hdegoede@redhat.com>
 <20180905023522.GA1444@jagdpanzerIV>
 <93901f2b-91ad-a910-7031-0040b827a3af@redhat.com>
 <20180905053609.GA19936@jagdpanzerIV>
 <20180905083326.GC19936@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905083326.GC19936@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-09-05 17:33:26, Sergey Senozhatsky wrote:
> On (09/05/18 14:36), Sergey Senozhatsky wrote:
> > 
> > Just a demonstration of the idea. It does not look very good, tho.
> > I'd rather have just one suppress_message_printing() in printk code.
> > 
> > // This is not a proposed patch, hence the 80-cols violation.
> > 
> > ---
> > 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index c036f128cdc3..231ac18423e1 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2416,7 +2416,7 @@ void console_unlock(void)
> >  			break;
> >  
> >  		msg = log_from_idx(console_idx);
> > -		if (msg->flags & LOG_NOCONS) {
> > +		if (msg->flags & LOG_NOCONS || (exclusive_console && suppress_message_printing(msg->level))) {
> >  			/*
> >  			 * Skip record if !ignore_loglevel, and
> >  			 * record has level above the console loglevel.
> 
> D'oh... Sorry about that, but, believe it or not, this is completely
> not what I had in my mind. What I had, was something like this:
> 
> ---
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index c036f128cdc3..dadb8c11b0d6 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2416,6 +2416,11 @@ void console_unlock(void)
>  			break;
>  
>  		msg = log_from_idx(console_idx);
> +
> +		if (exclusive_console &&
> +				!suppress_message_printing(msg->level))
> +			msg->flags &= ~LOG_NOCONS;

Hmm, this does not help with consoles without CON_PRINTBUFFER
flag. Note that the first registered console prints all messages
even without this flag.

Also there is "debug" earlyparam where we need the opposite. I mean
that we want to show messages that were suppressed by default.

I played with another solution, see the patch below. It defines
which messages have a valid NOCONS flag according to the msg_seq
number. IMHO, it is a bit more straightforward but it is still
a hack. I am not super happy about it.


Hmm, I seriously think about reverting the commit 375899cddcbb
("printk: make sure to print log on console.") and solving it
another way.

For example, the commit was primary about locations that
wanted to make some messages always visible or always
suppressed. We could create LOG_FORCE_NOCONS and
LOG_FORCE_CONS for these two special cases.



Possible solution:


From c0fb2d83ca3ca0bab5e1de5a6e29a1b96756a530 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Wed, 5 Sep 2018 12:57:18 +0200
Subject: [RFC PATCH] printk: Possible solution for loglevel manipulation by
 earlyparams

Early params that manipulate console_loglevel should invalidate
LOG_NOCONS flag for all the existing messages.
---
 include/linux/console.h |  2 ++
 init/main.c             |  6 +++---
 kernel/printk/printk.c  | 27 +++++++++++++++++++++++----
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index ec9bdb3d7bab..3d3f7ab8f82e 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -195,6 +195,8 @@ extern bool console_suspend_enabled;
 extern void suspend_console(void);
 extern void resume_console(void);
 
+extern void console_set_default_loglevel(int loglevel);
+
 int mda_console_init(void);
 void prom_con_init(void);
 
diff --git a/init/main.c b/init/main.c
index 18f8f0140fa0..936466209494 100644
--- a/init/main.c
+++ b/init/main.c
@@ -213,13 +213,13 @@ EXPORT_SYMBOL(loops_per_jiffy);
 
 static int __init debug_kernel(char *str)
 {
-	console_loglevel = CONSOLE_LOGLEVEL_DEBUG;
+	console_set_default_loglevel(CONSOLE_LOGLEVEL_DEBUG);
 	return 0;
 }
 
 static int __init quiet_kernel(char *str)
 {
-	console_loglevel = CONSOLE_LOGLEVEL_QUIET;
+	console_set_default_loglevel(CONSOLE_LOGLEVEL_QUIET);
 	return 0;
 }
 
@@ -236,7 +236,7 @@ static int __init loglevel(char *str)
 	 * are quite hard to debug
 	 */
 	if (get_option(&str, &newlevel)) {
-		console_loglevel = newlevel;
+		console_set_default_loglevel(newlevel);
 		return 0;
 	}
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 924e37fb1620..b5a0074302e9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -430,6 +430,9 @@ static u32 console_idx;
 static u64 clear_seq;
 static u32 clear_idx;
 
+/* Invalidate nocons flag setting before early param are proceed */
+static u64 console_valid_nocons_seq;
+
 #define PREFIX_MAX		32
 #define LOG_LINE_MAX		(1024 - PREFIX_MAX)
 
@@ -1148,11 +1151,19 @@ module_param(ignore_loglevel, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(ignore_loglevel,
 		 "ignore loglevel setting (prints all kernel messages to the console)");
 
-static bool suppress_message_printing(int level)
+static bool nocons_loglevel(int level)
 {
 	return (level >= console_loglevel && !ignore_loglevel);
 }
 
+static bool nocons_msg(struct printk_log *msg)
+{
+	if (console_seq >= console_valid_nocons_seq)
+		return msg->flags & LOG_NOCONS;
+
+	return nocons_loglevel(msg->level);
+}
+
 #ifdef CONFIG_BOOT_PRINTK_DELAY
 
 static int boot_delay; /* msecs delay after each printk during bootup */
@@ -1182,7 +1193,7 @@ static void boot_delay_msec(int level)
 	unsigned long timeout;
 
 	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
-		|| suppress_message_printing(level)) {
+		|| nocons_loglevel(level)) {
 		return;
 	}
 
@@ -1882,7 +1893,7 @@ int vprintk_store(int facility, int level,
 	if (dict)
 		lflags |= LOG_PREFIX|LOG_NEWLINE;
 
-	if (suppress_message_printing(level))
+	if (nocons_loglevel(level))
 		lflags |= LOG_NOCONS;
 
 	return log_output(facility, level, lflags,
@@ -2031,6 +2042,7 @@ static void console_lock_spinning_enable(void) { }
 static int console_lock_spinning_disable_and_check(void) { return 0; }
 static void call_console_drivers(const char *ext_text, size_t ext_len,
 				 const char *text, size_t len) {}
+static bool nocons_msg(struct printk_log *msg) { return false; }
 static size_t msg_print_text(const struct printk_log *msg,
 			     bool syslog, char *buf, size_t size) { return 0; }
 
@@ -2197,6 +2209,13 @@ void resume_console(void)
 	console_unlock();
 }
 
+void console_set_default_loglevel(int loglevel)
+{
+	console_loglevel = loglevel;
+	/* Invalidate nocons flag for earlier messages. */
+	console_valid_nocons_seq = log_next_seq;
+}
+
 /**
  * console_cpu_notify - print deferred console messages after CPU hotplug
  * @cpu: unused
@@ -2369,7 +2388,7 @@ void console_unlock(void)
 			break;
 
 		msg = log_from_idx(console_idx);
-		if (msg->flags & LOG_NOCONS) {
+		if (nocons_msg(msg)) {
 			/*
 			 * Skip record if !ignore_loglevel, and
 			 * record has level above the console loglevel.
-- 
2.13.7

