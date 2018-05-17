Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeEQLVm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 07:21:42 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41534 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752168AbeEQLVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 07:21:40 -0400
X-Google-Smtp-Source: AB8JxZr/bpHm74RGPE5Qwc+7X6IfRnyjNZE0cprMaXHR0fwYAF9dDUl3diZ6CI261C0TVXg/6l0cXQ==
Date: Thu, 17 May 2018 20:21:35 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: sergey.senozhatsky.work@gmail.com, dvyukov@google.com,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        syzkaller@googlegroups.com, rostedt@goodmis.org,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180517112135.GB20796@jagdpanzerIV>
References: <20180511014515.GA895@jagdpanzerIV>
 <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
 <20180511062151.GA18160@jagdpanzerIV>
 <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
 <20180511095004.GA6575@jagdpanzerIV>
 <201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/11/18 20:58), Tetsuo Handa wrote:
[..]
> -	if (nr_ext_console_drivers || cont.len + len > sizeof(cont.buf)) {
> +	if (nr_ext_console_drivers) {
> +		cont_flush();
> +		return false;
> +	}
> +
> +	/* Inject before memcpy() in order to avoid overflow. */
> +	if (!cont.len)
> +		text = printk_inject_caller_info(text, &len);
> +
> +	/* If the line gets too long, split it up in separate records. */
> +	if (cont.len + len > sizeof(cont.buf)) {
>  		cont_flush();
>  		return false;
>  	}
> @@ -1820,6 +1860,9 @@ static size_t log_output(int facility, int level, enum log_flags lflags, const c
>  			return text_len;
>  	}
>  
> +	/* Inject caller info. */
> +	text = printk_inject_caller_info(text, &text_len);
> +
>  	/* Store it in the record log */
>  	return log_store(facility, level, lflags, 0, dict, dictlen, text, text_len);
>  }

[..]

I think this is slightly intrusive. I understand that you want to avoid
struct printk_log modification, let's try to see if we have any other
options.

Dunno...
For instance, can we store context tracking info as a extended record
data? We have that dict/dict_len thing. So may we can store tracking
info there? Extended records will appear on the serial console /* if
console supports extended data */ or can be read in via devkmsg_read().
Any other options?

>  #include "internal.h"
>  
> @@ -83,6 +84,17 @@ static __printf(2, 0) int printk_safe_log_store(struct printk_safe_seq_buf *s,
[..]
>  	len = atomic_read(&s->len);
> @@ -102,7 +114,15 @@ static __printf(2, 0) int printk_safe_log_store(struct printk_safe_seq_buf *s,
>  		smp_rmb();
>  
>  	va_copy(ap, args);
> -	add = vscnprintf(s->buffer + len, sizeof(s->buffer) - len, fmt, ap);
> +	if (printk_caller_info) {
> +		struct va_format vaf = { .fmt = fmt, .va = &ap };
> +
> +		add = scnprintf(s->buffer + len, sizeof(s->buffer) - len,
> +				"(%c%u) %pV", c, v, &vaf);
> +	} else {
> +		add = vscnprintf(s->buffer + len, sizeof(s->buffer) - len,
> +				 fmt, ap);
> +	}

A bit of a silly question - do we want to modify printk_safe at this
point? With this implementation printk_safe entries will have two context
info-s attached: one from original printk_safe_log_store and another one
from printk_safe_flush->log_store. I suspect that adding context info in
printk_safe_log_store is, probably, not really needed. We flush printk_safe
from irq work on the CPU that issued unsafe printk, so part of the context
info will be valid if you append context info only in printk log_store - at
least the correct smp_processor_id.

	-ss
