Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4300CC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9B82082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9B82082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeK3Xji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:39:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:46216 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726557AbeK3Xji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:39:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6AA1AF57;
        Fri, 30 Nov 2018 12:30:27 +0000 (UTC)
Date:   Fri, 30 Nov 2018 13:30:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: don't unconditionally shortcut print_time()
Message-ID: <20181130123027.cyqfi2k34nh2gjmx@pathway.suse.cz>
References: <1543056613-4779-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181129141921.djeumz723fr7pasn@pathway.suse.cz>
 <201811300226.wAU2Q2JG060388@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201811300226.wAU2Q2JG060388@www262.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-11-30 11:26:02, Tetsuo Handa wrote:
> Petr Mladek wrote:
> > See syslog_print_all() and kmsg_dump_get_buffer(). They
> > start with calling msg_print_text() many times to calculate
> > how many messages fit into the given buffer. Then they
> > blindly copy the messages into the buffer.
> > 
> > Now, the buffer might overflow if the size is calculated
> > with printk_time disabled and the messages are copied with
> > printk_time enabled.
> > 
> 
> Indeed, SYSLOG_ACTION_READ_ALL case can write more bytes than userspace
> has supplied, resulting in possible memory corruption in userpsace. And
> obtaining a snapshot of printk_time under logbuf_lock won't help, for we
> need to drop logbuf_lock before calling copy_to_user().
> 
> > IMHO, passing it as parameter to msg_print_text(), print_prefix(),
> > and print_time() looks acceptable.
> 
> Below is a patch for passing a snapshot of printk_time to msg_print_text(),
> but we are still failing to close a race explained at bottom.

The patch looks fine to me.
 
> The remaining race is that klogctl(SYSLOG_ACTION_SIZE_UNREAD) after klogctl(SYSLOG_ACTION_READ)
> can return negative value upon success, for SYSLOG_ACTION_SIZE_UNREAD depends that printk_time
> did not change (from true to false) after SYSLOG_ACTION_READ updated syslog_partial. To close
> this race, we need to make sure that printk_time is evaluated only once for each record.
> That is, evaluate printk_time upon e.g. log_store() rather than upon msg_print_text().

Great catch!

>  kernel/printk/printk.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1b2a029..c692fbc 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -421,6 +421,8 @@ __packed __aligned(4)
>  static u64 clear_seq;
>  static u32 clear_idx;
>  
> +static bool printk_time = IS_ENABLED(CONFIG_PRINTK_TIME);
> +
>  #define PREFIX_MAX		32
>  #define LOG_LINE_MAX		(1024 - PREFIX_MAX)
>  
> @@ -620,7 +622,9 @@ static int log_store(int facility, int level,
>  	msg->facility = facility;
>  	msg->level = level & 7;
>  	msg->flags = flags & 0x1f;
> -	if (ts_nsec > 0)
> +	if (!printk_time)
> +		msg->ts_nsec = (u64) -1ULL;
> +	else if (ts_nsec > 0)
>  		msg->ts_nsec = ts_nsec;
>  	else
>  		msg->ts_nsec = local_clock();
> @@ -1210,14 +1214,13 @@ static inline void boot_delay_msec(int level)
>  }
>  #endif
>  
> -static bool printk_time = IS_ENABLED(CONFIG_PRINTK_TIME);
>  module_param_named(time, printk_time, bool, S_IRUGO | S_IWUSR);
>  
>  static size_t print_time(u64 ts, char *buf)
>  {
>  	unsigned long rem_nsec;
>  
> -	if (!printk_time)
> +	if (ts == (u64) -1ULL)

Sigh, we need to always store the timestamp. /dev/kmsg prints it
timestamps even when printk.time parameter is disabled.

Instead, we could use one bit in log_flags instead.

But I feel a bit uneasy that we change the semantic and could break
something. For example, SYSLOG_ACTION_READ_ALL callers might want
to have a consistent output (dmesg -Sr). Also we would need to sync
early boot messages with printk.time kernel parameter.


I am not fully happy with the solution passing time parameter.
It is less secure. But it would not break compatibility.
This particular race might be solved the following way:


diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1b2a029360b7..5b489988e9b7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1294,6 +1294,7 @@ static size_t msg_print_text(const struct printk_log *msg, bool syslog, char *bu
 
 static int syslog_print(char __user *buf, int size)
 {
+	static bool time;
 	char *text;
 	struct printk_log *msg;
 	int len = 0;
@@ -1318,9 +1319,13 @@ static int syslog_print(char __user *buf, int size)
 			break;
 		}
 
+		/* Keep partial line consistent */
+		if (!syslog_partial)
+			time = printk_time;
+
 		skip = syslog_partial;
 		msg = log_from_idx(syslog_idx);
-		n = msg_print_text(msg, true, text, LOG_LINE_MAX + PREFIX_MAX);
+		n = msg_print_text(msg, true, time, text, LOG_LINE_MAX + PREFIX_MAX);
 		if (n - syslog_partial <= size) {
 			/* message fits into buffer, move forward */
 			syslog_idx = log_next(syslog_idx);


Best Regards,
Petr
