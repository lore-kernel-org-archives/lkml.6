Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97472C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6505020863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6505020863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbeK3Bk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:40:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:49594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729204AbeK3Bk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:40:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2CF2DAF5A;
        Thu, 29 Nov 2018 14:35:23 +0000 (UTC)
Date:   Thu, 29 Nov 2018 15:35:22 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: deduplicate print_prefix() calls
Message-ID: <20181129143522.xo67shn6mxxkrouq@pathway.suse.cz>
References: <1543056613-4779-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1543069716-3246-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543069716-3246-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2018-11-24 23:28:36, Tetsuo Handa wrote:
> Since /sys/module/printk/parameters/time can change from N to Y between
> "msg_print_text() called print_prefix() with buf == NULL" and
> "msg_print_text() again calls print_prefix() with buf != NULL", it is not
> safe for print_time() to unconditionally return 0 if printk_time == false.
> 
> But print_prefix() is called by only msg_print_text(), and print_prefix()
> is called once more for calculating output length of prefix, and there is
> no need to recalculate it when one log entry contains multiple lines.
> 
> Since max output length for syslog marker and timestamp are known to be
> small enough, let's close this race by deduplicating print_prefix() calls.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  kernel/printk/printk.c | 64 +++++++++++++++-----------------------------------
>  1 file changed, 19 insertions(+), 45 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1b2a029..eac4c80 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1213,50 +1213,26 @@ static inline void boot_delay_msec(int level)
>  static bool printk_time = IS_ENABLED(CONFIG_PRINTK_TIME);
>  module_param_named(time, printk_time, bool, S_IRUGO | S_IWUSR);
>  
> -static size_t print_time(u64 ts, char *buf)
> -{
> -	unsigned long rem_nsec;
> -
> -	if (!printk_time)
> -		return 0;
> -
> -	rem_nsec = do_div(ts, 1000000000);
> -
> -	if (!buf)
> -		return snprintf(NULL, 0, "[%5lu.000000] ", (unsigned long)ts);
> -
> -	return sprintf(buf, "[%5lu.%06lu] ",
> -		       (unsigned long)ts, rem_nsec / 1000);
> -}
> -
> -static size_t print_prefix(const struct printk_log *msg, bool syslog, char *buf)
> -{
> -	size_t len = 0;
> -	unsigned int prefix = (msg->facility << 3) | msg->level;
> -
> -	if (syslog) {
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
> -	}
> -
> -	len += print_time(msg->ts_nsec, buf ? buf + len : NULL);
> -	return len;
> -}
> -
>  static size_t msg_print_text(const struct printk_log *msg, bool syslog, char *buf, size_t size)
>  {
>  	const char *text = log_text(msg);
>  	size_t text_size = msg->text_len;
>  	size_t len = 0;
> +	char prefix[32]; /* "<2047>[18446744073.709551] " */
> +	size_t prefix_len = 0;
> +
> +	if (syslog)
> +		prefix_len += snprintf(prefix, sizeof(prefix), "<%u>",
> +				       (msg->facility << 3) | msg->level);
> +	if (printk_time) {

This does not solve the real problem (buffer overflow) in
syslog_print_all() and kmsg_dump_get_buffer().

> +		u64 ts = msg->ts_nsec;
> +		unsigned long rem_nsec = do_div(ts, 1000000000);
> +
> +		prefix_len += snprintf(prefix + prefix_len,
> +				       sizeof(prefix) - prefix_len,
> +				       "[%5lu.%06lu] ", (unsigned long)ts,
> +				       rem_nsec / 1000);
> +	}

I am not against removing some optimizations when buf == NULL.
It is a crazy code and the win is questionable. But the helper
functions still might make sense. msg_print_text() is complicated
enough as is.

Finally, I have mixed feelings about the memcpy() of the prefix.
On one hand, it makes some conditions a bit more readable.
On the other hand, it looks strange to copy it when most
messages have only one line and one prefix. It does not
look like a win in the end.

Let's fix the buffer overflow first and do any code clean up
later in a separate patch.

Best Regards,
Petr
