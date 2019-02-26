Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76F1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901352173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfBZQ1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:27:03 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45421 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfBZQ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:27:03 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gyfZK-0004hO-HJ; Tue, 26 Feb 2019 17:26:58 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk/console: Do not suppress information about dropped messages
References: <20190226124945.7078-1-pmladek@suse.com>
Date:   Tue, 26 Feb 2019 17:26:57 +0100
In-Reply-To: <20190226124945.7078-1-pmladek@suse.com> (Petr Mladek's message
        of "Tue, 26 Feb 2019 13:49:45 +0100")
Message-ID: <87k1hmzfam.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-26, Petr Mladek <pmladek@suse.com> wrote:
> The warning about dropped messages gets lost when the current
> message is above console_loglevel and suppressed.

Here you are reporting a bug. (More on this below.)

> The suppressed messages allow even slow consoles to caught up
> with a flood of messages. The consoles must not get slowed
> down by many warnings. Instead, the warning is delayed until
> the next printable message.

Here you are introducing a new behavior. (Also discussed below.)
Although the two are similar, they are really 2 different things.

> The handling of newly registered consoles is handled with a compromise:
>
>   + It does not make sense to reply the log when it is already behind.
>     This prevents a bogus number at the beginning of the replayed log.
>
>   + The counter is restarted when switching to all consoles. This
>     prevents a bogus number on already registered consoles.
>
>   + The last number in the replayed log might be lower than reality.
>     But it does not look worth existing.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/printk/printk.c | 54 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 35 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index b4d26388bc62..c3f287422ef4 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -420,6 +420,7 @@ static u32 log_next_idx;
>  /* the next printk record to write to the console */
>  static u64 console_seq;
>  static u32 console_idx;
> +static u64 console_dropped_cnt;
>  static u64 exclusive_console_stop_seq;
>  
>  /* the next printk record to read after the last 'clear' command */
> @@ -2060,6 +2061,7 @@ static u64 syslog_seq;
>  static u32 syslog_idx;
>  static u64 console_seq;
>  static u32 console_idx;
> +static u64 console_dropped_cnt;
>  static u64 exclusive_console_stop_seq;
>  static u64 log_first_seq;
>  static u32 log_first_idx;
> @@ -2398,20 +2400,24 @@ void console_unlock(void)
>  	for (;;) {
>  		struct printk_log *msg;
>  		size_t ext_len = 0;
> -		size_t len;
> +		size_t len = 0;
>  
>  		printk_safe_enter_irqsave(flags);
>  		raw_spin_lock(&logbuf_lock);
> +
> +		/* Reset dropped msg count when switching to all consoles. */
> +		if (unlikely(exclusive_console &&
> +			     exclusive_console_stop_seq < log_first_seq)) {
> +			console_dropped_cnt = 0;
> +			console_seq = exclusive_console_stop_seq;
> +		}
> +

Wouldn't the fix to the bug be to move the "skip" target here?

skip:

>  		if (console_seq < log_first_seq) {
> -			len = sprintf(text,
> -				      "** %llu printk messages dropped **\n",
> -				      log_first_seq - console_seq);
> +			console_dropped_cnt += log_first_seq - console_seq;
>  
>  			/* messages are gone, move to first one */
>  			console_seq = log_first_seq;
>  			console_idx = log_first_idx;
> -		} else {
> -			len = 0;
>  		}
>  skip:
>  		if (console_seq == log_next_seq)
> @@ -2435,6 +2441,13 @@ void console_unlock(void)
>  			exclusive_console = NULL;
>  		}
>  
> +		if (unlikely(console_dropped_cnt)) {
> +			len = sprintf(text,
> +				      "** %llu printk messages dropped **\n",
> +				      console_dropped_cnt);
> +			console_dropped_cnt = 0;
> +		}
> +

My only objection to this is that the "messages dropped" only comes if a
non-supressed message comes. So information about dropped information
may never get printed unless some task prints something non-supressed.

Imagine a situation where I am expecting a message to come, but don't
see it because it was dropped. But if no more non-supressed messages
come, I see neither the expected message nor the dropped message.

John Ogness
