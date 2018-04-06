Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeDFJhG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 05:37:06 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39512 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeDFJhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 05:37:04 -0400
X-Google-Smtp-Source: AIpwx49slLVVwtMpjxTzVDaoqQhMv7zlGfpavu3eyhiMsKfb/q0hy5NELyOhYfq9ck95yXVeCdGANA==
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
Message-ID: <42c76ac4-09de-bc5e-a7f0-466a1955e429@rasmusvillemoes.dk>
Date: Fri, 6 Apr 2018 11:37:01 +0200
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
> +
> +
> +static bool valid_pointer_access(char **buf, char *end, const void *ptr,
> +				 struct printf_spec spec)
> +{
> +	const char *err_msg;
> +
> +	err_msg = check_pointer_access(ptr);
> +	if (err_msg) {
> +		*buf = __string(*buf, end, err_msg, spec);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  static noinline_for_stack
>  char *string(char *buf, char *end, const char *s,
>  		   struct printf_spec spec)
>  {
> -	if ((unsigned long)s < PAGE_SIZE)
> -		s = "(null)";
> +	if (!valid_pointer_access(&buf, end, s, spec))
> +		return buf;
>  
>  	return __string(buf, end, s, spec);
>  }

Obviously, if you do add a WARN to the check_pointer_access (and please
do), that somehow needs to be suppressed for the "%s", NULL and "%s",
ZEROPTR cases, which are grandfathered in and I think is relied upon in
some places. It should be as simple as keeping  the < PAGE_SIZE check
and do "else if (!valid...())".

Rasmus
