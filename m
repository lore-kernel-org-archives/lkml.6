Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754419AbeCGNR0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:17:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:1796 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbeCGNRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:17:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,435,1515484800";
   d="scan'208";a="36197404"
Message-ID: <1520428639.10722.461.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] vsprintf: distinguish between (null), (err) and
 (invalid) pointer derefs
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adam Borowski <kilobyte@angband.pl>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Date: Wed, 07 Mar 2018 15:17:19 +0200
In-Reply-To: <20180306181122.11449-1-kilobyte@angband.pl>
References: <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz>
         <20180306181122.11449-1-kilobyte@angband.pl>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-06 at 19:11 +0100, Adam Borowski wrote:

Thanks for the patch, my comments below.

> Attempting to print an object pointed to by a bad (usually ERR_PTR)
> pointer
> is a not so surprising error.  Our code handles them inconsistently:
>  * two places print (null) if ptr<PAGE_SIZE
>  * one place prints (null) if abs(ptr)<PAGE_SIZE
>  * one place prints (null) only if !ptr
> 
> Obviously, saying (null) for a small but non-0 value is misleading.
> Thus, let's print:
>  * (null) for exactly 0
>  * (err) if last page && abs(ptr)<=MAX_ERRNO
>  * (invalid) otherwise
> 

First of all, this patch is much more arguable than the other one in
your small series.

"(invalid)" is invalid. Hint: there is a nice comment in the code why.

I'm in principle not putting explanation here to insist people to
eventually _read and understand_ the code before doing anything.

Some comments below.
 
> +#define BAD_PTR_STRING(x) (!(x) ? "(null)" : IS_ERR(x) ? "(err)" :
> "(invalid)")

It looks ugly.

>  /**
>   * simple_strtoull - convert a string to an unsigned long long
>   * @cp: The start of the string
> @@ -588,7 +590,7 @@ char *string(char *buf, char *end, const char *s,
> struct printf_spec spec)
>  	size_t lim = spec.precision;
>  
>  	if ((unsigned long)s < PAGE_SIZE)
> -		s = "(null)";
> +		s = BAD_PTR_STRING(s);

It doesn't make any sense before your patch 2.
 
>  	if ((unsigned long)dn < PAGE_SIZE)
> -		return string(buf, end, "(null)", spec);
> +		return string(buf, end, BAD_PTR_STRING(dn), spec);

It simple doesn't make sense.

The idea is to do it below, in the pointer.
These certain lines are going to be removed by my patch.

> -		return string(buf, end, "(null)", spec);
> +		return string(buf, end, BAD_PTR_STRING(ptr), spec);

Doesn't make sense before your patch 2.

>  			if ((unsigned long)save_str > (unsigned
> long)-PAGE_SIZE
>  					|| (unsigned long)save_str <
> PAGE_SIZE)
> -				save_str = "(null)";
> +				save_str = BAD_PTR_STRING(save_str);

This is perhaps one valid change in such situation.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
