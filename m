Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeDEOq1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:46:27 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39223 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeDEOq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:46:26 -0400
X-Google-Smtp-Source: AIpwx4+vjQdtTObV6Z385XnqDBkZBf/C10WYocDDBXTJbSKjtPSsFR1wF8khFRMXvzrHyZyrxGGQBg==
Subject: Re: [PATCH v4 8/9] vsprintf: Prevent crash when dereferencing invalid
 pointers
To: Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-9-pmladek@suse.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f5fd81ea-99ab-29ac-a176-87ca8c4a754d@rasmusvillemoes.dk>
Date: Thu, 5 Apr 2018 16:46:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180404085843.16050-9-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-04 10:58, Petr Mladek wrote:

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3551b7957d9e..1a080a75a825 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -599,12 +599,46 @@ char *__string(char *buf, char *end, const char *s, struct printf_spec spec)
>  	return widen_string(buf, len, end, spec);
>  }
>  
> + /*
> +  * This is not a fool-proof test. 99% of the time that this will fault is
> +  * due to a bad pointer, not one that crosses into bad memory. Just test
> +  * the address to make sure it doesn't fault due to a poorly added printk
> +  * during debugging.
> +  */
> +static const char *check_pointer_access(const void *ptr)
> +{
> +	char byte;
> +
> +	if (!ptr)
> +		return "(null)";
> +
> +	if (probe_kernel_address(ptr, byte))
> +		return "(efault)";
> +
> +	return NULL;
> +}

So while I think the WARNings are mostly pointless for the bad format
specifiers, I'm wondering why an averted crash is not worth a WARN_ONCE?
This means there's an actual bug somewhere, probably even exploitable,
but we're just silently producing some innocent string...

Also, I'd still prefer to insist on ptr being a kernel pointer. Sure,
for %ph userspace gets to print their own memory, but for a lot of the
others, we're chasing pointers another level, so if an attacker can feed
a user pointer to one of those, there's a trivial arbitrary read gadget.
We have lots of printks in untested error paths, and I find it quite
likely that one of those uses a garbage pointer.

I know you're mostly phrasing this in terms of preventing a crash, but
it seems silly not to close that when it only costs a pointer comparison.

You're also missing the %pD (struct file*) case, which is one of those
double-pointer chasing cases.

Rasmus
