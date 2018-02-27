Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754045AbeB0Puv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:50:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:40623 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753264AbeB0Puu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:50:50 -0500
Date: Tue, 27 Feb 2018 16:50:47 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Tobin C . Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v2 8/9] lib/vsprintf: Remove useless NULL checks
Message-ID: <20180227155047.o74ohmoyj56up6pa@pathway.suse.cz>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
 <20180216210711.79901-8-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216210711.79901-8-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-02-16 23:07:10, Andy Shevchenko wrote:
> The pointer can't be NULL since it's first what has been done in the
> pointer().
> 
> Remove useless checks.
> 
> Note we leave check for !CONFIG_HAVE_CLK to make compiler
> to optimize code away when possible.
> 
> Cc: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/vsprintf.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 97be2d07297a..a49da00b79e7 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -819,10 +819,6 @@ char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
>  		/* nothing to print */
>  		return buf;
>  
> -	if (ZERO_OR_NULL_PTR(addr))

This macro matches also values <= 16. All these values are handled as NULL
by kfree(). Therefore it would make sense to write "(null)" for them.

But pointer() prints "(null)" only for ptr == 0.

See below.

> -		/* NULL pointer */
> -		return string(buf, end, NULL, spec);
> -
>  	switch (fmt[1]) {
>  	case 'C':
>  		separator = ':';
> @@ -1258,10 +1254,6 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
>  	if (spec.field_width == 0)
>  		return buf;				/* nothing to print */
>  
> -	if (ZERO_OR_NULL_PTR(addr))
> -		return string(buf, end, NULL, spec);	/* NULL pointer */
> -
> -
>  	do {
>  		switch (fmt[count++]) {
>  		case 'a':
> @@ -1455,7 +1447,7 @@ static noinline_for_stack
>  char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
>  	    const char *fmt)
>  {
> -	if (!IS_ENABLED(CONFIG_HAVE_CLK) || !clk)
> +	if (!IS_ENABLED(CONFIG_HAVE_CLK))
>  		return string(buf, end, NULL, spec);
>  
>  	switch (fmt[1]) {
> @@ -1580,9 +1572,6 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
>  	if (!IS_ENABLED(CONFIG_OF))
>  		return string(buf, end, "(!OF)", spec);
>  
> -	if ((unsigned long)dn < PAGE_SIZE)
> -		return string(buf, end, "(null)", spec);

In this case, "null" was printed for ptr < PAGE_SIZE. The same check
is also in string() function.

Note that it is not only about the printed value. The pointer is later
derefecend. We will start crashing on dn > 0 && dn < PAGE_SIZE.


To be honest, I do not feel experienced enough to decide
about the preferred behavior. On one hand, it is bad when
printk() would crash the kernel. On the other hand, hiding wide
range of values under "(null)" string might confuse people.

Would it make sense to survive and write different strings for
difference intervals? For example?

    "(null)"     for ptr == 0
    "(null-16)"  for ptr > 0 && ptr <= 16
    "(null-pg)"  for prt > 16 && ptr <= PAGE_SIZE

In each case, this patch changes the behavior and it should
be documented in the commit message.

Best Regards,
Petr
