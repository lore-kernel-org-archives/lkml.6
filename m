Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E6DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F4420834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F4420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeLACuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:50:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:52020 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbeLACuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:50:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 594BBAF74;
        Fri, 30 Nov 2018 15:40:25 +0000 (UTC)
Date:   Fri, 30 Nov 2018 16:40:24 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
Message-ID: <20181130154024.ls3mntfdr4zvluub@pathway.suse.cz>
References: <1543045075-3008-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543045075-3008-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2018-11-24 16:37:55, Tetsuo Handa wrote:
> Sometimes we want to print a whole line without being disturbed by
> concurrent printk() from interrupts and/or other threads, for printk()
> which does not end with '\n' can be disturbed.
> 
> We tried to allow printk() callers to explicitly use their local buffer
> in order to make sure that a whole line is printed by one printk() call.
> But it turned out that it is not realistic to ask printk() callers to
> update their function arguments only for handling rare race conditions.
> Also, like Steven Rostedt mentioned at [1], buffering sometimes makes
> the situation worse. Therefore, we should not enforce buffering in a way
> that requires modification of printk() callers.
> 
> I need to give up (at least for now) manipulating text which will be
> passed to printk(). Instead, I propose allow saving caller information
> as of calling log_store() and adding it as "T$thread_id" or
> "C$processor_id" upon printing each line of printk() output.

It looks like the best solution that I can think of at the moment.
I suggest only few cosmetic changes.

> 
> Some examples for console output:
> 
>   [    0.293000] [T1] smpboot: CPU0: Intel(R) Core(TM) i5-4440S CPU @ 2.80GHz (family: 0x6, model: 0x3c, stepping: 0x3)
>   [    0.299733] [T1] Performance Events: Haswell events, core PMU driver.
>   [    2.813808] [T35] clocksource: Switched to clocksource tsc
>   [    2.893984] [C0] random: fast init done
                  ^

Please, remove the space between the timestamp and the from field.

>  kernel/printk/printk.c | 33 +++++++++++++++++++++++++++++++++
>  lib/Kconfig.debug      | 17 +++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 5c2079d..5ace5ba 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -609,6 +612,12 @@ static int log_store(int facility, int level,
>  
>  	/* fill message */
>  	msg = (struct printk_log *)(log_buf + log_next_idx);
> +#ifdef CONFIG_PRINTK_FROM
> +	if (in_task())
> +		msg->from_id = current->pid;
> +	else
> +		msg->from_id = 0x80000000 + raw_smp_processor_id();
> +#endif

Please, move this below. It better fits after msg->ts_nsec assignment.

>  	memcpy(log_text(msg), text, text_len);
>  	msg->text_len = text_len;
>  	if (trunc_msg_len) {
> @@ -690,9 +699,17 @@ static ssize_t msg_print_ext_header(char *buf, size_t size,
>  
>  	do_div(ts_usec, 1000);
>  
> +#ifdef CONFIG_PRINTK_FROM
> +	return scnprintf(buf, size, "%u,%llu,%llu,%c,from=%c%u;",
> +			 (msg->facility << 3) | msg->level, seq, ts_usec,
> +			 msg->flags & LOG_CONT ? 'c' : '-',
> +			 msg->from_id & 0x80000000 ? 'C' : 'T',
> +			 msg->from_id & ~0x80000000);
> +#else
>  	return scnprintf(buf, size, "%u,%llu,%llu,%c;",
>  		       (msg->facility << 3) | msg->level, seq, ts_usec,
>  		       msg->flags & LOG_CONT ? 'c' : '-');

Please, avoid cut&pasting.

> +#endif
>  }
>  
>  static ssize_t msg_print_ext_body(char *buf, size_t size,
> @@ -1037,6 +1054,9 @@ void log_buf_vmcoreinfo_setup(void)
>  	VMCOREINFO_OFFSET(printk_log, len);
>  	VMCOREINFO_OFFSET(printk_log, text_len);
>  	VMCOREINFO_OFFSET(printk_log, dict_len);
> +#ifdef CONFIG_PRINTK_FROM
> +	VMCOREINFO_OFFSET(printk_log, from_id);
> +#endif

The crash tool would need to be updated if anyone wanted to read
the log from the extended structure. Well, it might be done later
if people start using it more widely.

I think about adding one more filed "u8 version". It would help
to solve the external compatibility in the long term.


Anyway, I like this feature. It is compatible with /dev/kmsg
format. dmesg works well. It helps to sort any mixed output
from both full and continuous lines.

Best Regards,
Petr
