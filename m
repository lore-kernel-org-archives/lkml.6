Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeDZB2M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 21:28:12 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:40635 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeDZB2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 21:28:10 -0400
X-Google-Smtp-Source: AIpwx4/XCenO94U9RO1eUirhFYmOWVEx3a9rVKRkJq6VpEWjZ6QKQ0wRn3cOZgeyjbzD+1emJ4MNWg==
Date: Thu, 26 Apr 2018 10:28:05 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/11] vsprintf: WARN() on invalid pointer access
Message-ID: <20180426012805.GA3282@jagdpanzerIV>
References: <20180425111251.13246-1-pmladek@suse.com>
 <20180425111251.13246-11-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425111251.13246-11-pmladek@suse.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/25/18 13:12), Petr Mladek wrote:
[..]
>   /*
>    * This is not a fool-proof test. 99% of the time that this will fault is
>    * due to a bad pointer, not one that crosses into bad memory. Just test
> @@ -623,8 +626,12 @@ static const char *check_pointer_access(const void *ptr)
>  	if (!ptr)
>  		return "(null)";
>  
> -	if (probe_kernel_address(ptr, byte))
> +	/* Prevent silent crashes when called in printk_safe context. */
> +	if (probe_kernel_address(ptr, byte)) {
> +		WARN(!panic_on_warn && !test_printf_pointer_access,
> +		     "vsprintf: invalid pointer address\n");
>  		return "(efault)";
> +	}

Can we have a rate-limited print out here? Or may be even a WARN_ONCE()?
Yes, printk()-s from check_pointer_access() are OK, printk_safe() helps us,
but at the same time every single invalid pointer access printk()-message
will log_store() WARN() extra entries. Theoretically, this can harm. What
do you think?

	-ss
