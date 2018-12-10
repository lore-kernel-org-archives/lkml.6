Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE88C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30BE2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30BE2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeLJNJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:09:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:50430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726209AbeLJNJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:09:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20363AFB6;
        Mon, 10 Dec 2018 13:09:32 +0000 (UTC)
Date:   Mon, 10 Dec 2018 14:09:30 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
Message-ID: <20181210130930.bas4fozjhe3dc5nu@pathway.suse.cz>
References: <1543045075-3008-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181130154024.ls3mntfdr4zvluub@pathway.suse.cz>
 <f224bd68-7394-ff70-cad6-d3fbbb3b5f7d@i-love.sakura.ne.jp>
 <20181203150603.cdqii263e4kmmibo@pathway.suse.cz>
 <b38c6957-c3c1-54fc-781e-06d7eed6a9b1@i-love.sakura.ne.jp>
 <20181204152724.ypk44mi4a56nrud4@pathway.suse.cz>
 <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-12-05 19:42:22, Tetsuo Handa wrote:
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Wed, 5 Dec 2018 16:53:08 +0900
> Subject: [PATCH v3] printk: Add caller information to printk() output.
> 
> Sometimes we want to print a series of printk() messages to consoles
> without being disturbed by concurrent printk() from interrupts and/or
> other threads. But we can't enforce printk() callers to use their local
> buffers because we need to ask them to make too much changes. Also, even
> buffering up to one line inside printk() might cause failing to emit
> an important clue under critical situation.
> 
> Therefore, instead of trying to help buffering, let's try to help
> reconstructing messages by saving caller information as of calling
> log_store() and adding it as "[T$thread_id]" or "[C$processor_id]"
> upon printing to consoles.
> 
> Some examples for console output:
> 
>   [    1.222773][    T1] x86: Booting SMP configuration:
>   [    2.779635][    T1] pci 0000:00:01.0: PCI bridge to [bus 01]
>   [    5.069193][  T268] Fusion MPT base driver 3.04.20
>   [    9.316504][    C2] random: fast init done
>   [   13.413336][ T3355] Initialized host personality

I like this formating. IMHO, the limit 100000 for the right formating
is good enough. Also I think that the process ID might give a clue.
IMHO, ID reusing is rather rare.

> Some examples for /dev/kmsg output:
> 
>   6,496,1222773,-,from=T1;x86: Booting SMP configuration:
>   6,968,2779635,-,from=T1;pci 0000:00:01.0: PCI bridge to [bus 01]
>    SUBSYSTEM=pci
>    DEVICE=+pci:0000:00:01.0
>   6,1353,5069193,-,from=T268;Fusion MPT base driver 3.04.20
>   5,1526,9316504,-,from=C2;random: fast init done
>   6,1575,13413336,-,from=T3355;Initialized host personality
> 
> # Not yet signed-off in order to silence build-bot error reports.
> ---
>  kernel/printk/printk.c | 82 +++++++++++++++++++++++++++++++++-----------------
>  lib/Kconfig.debug      | 17 +++++++++++
>  2 files changed, 71 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 4f18472..f9812f6 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -422,8 +425,14 @@ __packed __aligned(4)
>  static u64 clear_seq;
>  static u32 clear_idx;
>  
> +#ifdef CONFIG_PRINTK_FROM
> +#define PREFIX_FROM_MAX		16
> +#define PREFIX_MAX		(32 + PREFIX_FROM_MAX)
> +#define LOG_LINE_MAX		(1024 - 32)

This looks suspicious. We either need to limit LOG_LINE_MAX
by the real PREFIX_MAX (48). Or we must make sure that
the code is able to handle an eventual overflow.

For example, msg_print_text() would just ignore the line
when it overflows, see:

			if (print_prefix(msg, syslog, time, NULL) +
			    text_len + 1 >= size - len)
				break;

BTW: The limit 48 looks right. If I count correctly, the longest
prefix might be:

    <2048>[4294967296,xxxxxx][T4294967296]

38 = 6+19+13

IMHO, LOG_LINE_MAX defined as (1024 - 48) is perfectly fine. Most
lines are under 80 characters. I doubt that any goes close
to the existing limit.


> +#else
>  #define PREFIX_MAX		32
>  #define LOG_LINE_MAX		(1024 - PREFIX_MAX)
> +#endif
>  
>  #define LOG_LEVEL(v)		((v) & 0x07)
>  #define LOG_FACILITY(v)		((v) >> 3 & 0xff)

[...]

> @@ -1227,39 +1254,38 @@ static inline void boot_delay_msec(int level)
>  static bool printk_time = IS_ENABLED(CONFIG_PRINTK_TIME);
>  module_param_named(time, printk_time, bool, S_IRUGO | S_IWUSR);
>  
> -static size_t print_time(u64 ts, char *buf)
> -{
> -	unsigned long rem_nsec = do_div(ts, 1000000000);
> -
> -	if (!buf)
> -		return snprintf(NULL, 0, "[%5lu.000000] ", (unsigned long)ts);
> -
> -	return sprintf(buf, "[%5lu.%06lu] ",
> -		       (unsigned long)ts, rem_nsec / 1000);
> -}
> -
>  static size_t print_prefix(const struct printk_log *msg, bool syslog,
>  			   bool time, char *buf)
>  {
>  	size_t len = 0;
> -	unsigned int prefix = (msg->facility << 3) | msg->level;
> +	char tmp[PREFIX_MAX];
>  
> +	if (!buf)
> +		buf = tmp;

Please, add empty lines between the if-sections. It will better
split the logical parts.

I would personally create three helper functions (print_level(),
print_time(), and print_from(). But adding the empty lines
is fine as well.

>  	if (syslog) {
> -		if (buf) {
> -			len += sprintf(buf, "<%u>", prefix);
> -		} else {
> -			len += 3;
> -			if (prefix > 999)
> -				len += 3;
> -			else if (prefix > 99)
> -				len += 2;
> -			else if (prefix > 9)
> -				len++;
> -		}
> +		unsigned int prefix = (msg->facility << 3) | msg->level;
> +
> +		len += sprintf(buf, "<%u>", prefix);
> +	}
> +	if (time) {
> +		u64 ts = msg->ts_nsec;
> +		unsigned long rem_nsec = do_div(ts, 1000000000);
> +
> +		len += sprintf(buf + len, "[%5lu.%06lu]", (unsigned long)ts,
> +			       rem_nsec / 1000);
>  	}
> +#ifdef CONFIG_PRINTK_FROM
> +	{
> +		u32 id = msg->from_id;
> +		char from[12];
>  
> -	if (time)
> -		len += print_time(msg->ts_nsec, buf ? buf + len : NULL);
> +		snprintf(from, sizeof(from), "%c%u",
> +			 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
> +		len += sprintf(buf + len, "[%6s]", from);
> +	}
> +#endif
> +	if (IS_ENABLED(CONFIG_PRINTK_FROM) || time)
> +		buf[len++] = ' ';

Please, add also the trailing '\0'. I know that it is not strictly
necessary but...

I consider it a good practice. It prevents a potential misuse.
For example, people might want use the output in their own
debug messages.


Otherwise, the patch looks good to me. Please, send the next
revision as a proper patch.

Best Regards,
Petr
