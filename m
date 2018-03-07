Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933366AbeCGNWa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:22:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:43105 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754545AbeCGNWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:22:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,435,1515484800";
   d="scan'208";a="39930073"
Message-ID: <1520428941.10722.466.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] vsprintf: don't dereference pointers to the first
 or last page
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adam Borowski <kilobyte@angband.pl>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Date: Wed, 07 Mar 2018 15:22:21 +0200
In-Reply-To: <20180306181122.11449-2-kilobyte@angband.pl>
References: <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz>
         <20180306181122.11449-1-kilobyte@angband.pl>
         <20180306181122.11449-2-kilobyte@angband.pl>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-06 at 19:11 +0100, Adam Borowski wrote:
> As old code to avoid so is inconsistent, let's unify it within a
> single
> macro.
> 
>  
> +#define IS_BAD_PTR(x) ((unsigned long)(x) >= (unsigned long)-
> PAGE_SIZE \
> +				|| (unsigned long)(x) < PAGE_SIZE)

Oh, no.

First of all, why it's a macro?

Next, what prevents us to do it in place using IS_ERR() instead? (Btw, I
have a patch for that, not published yet)

>  #define BAD_PTR_STRING(x) (!(x) ? "(null)" : IS_ERR(x) ? "(err)" :
> "(invalid)")
>  
>  /**
> @@ -589,7 +591,7 @@ char *string(char *buf, char *end, const char *s,
> struct printf_spec spec)
>  	int len = 0;
>  	size_t lim = spec.precision;
>  
> -	if ((unsigned long)s < PAGE_SIZE)
> +	if (IS_BAD_PTR(s))
>  		s = BAD_PTR_STRING(s);

I don't think it's a good idea to change current behaviour.

> @@ -1583,7 +1585,7 @@ char *device_node_string(char *buf, char *end,
> struct device_node *dn,
>  	if (!IS_ENABLED(CONFIG_OF))
>  		return string(buf, end, "(!OF)", spec);
>  
> -	if ((unsigned long)dn < PAGE_SIZE)
> +	if (IS_BAD_PTR(dn))
>  		return string(buf, end, BAD_PTR_STRING(dn), spec);

This makes no sense. Explained in comment against patch 1.

>  
>  	/* simple case without anything any more format specifiers */
> @@ -1851,7 +1853,7 @@ char *pointer(const char *fmt, char *buf, char
> *end, void *ptr,
>  {
>  	const int default_width = 2 * sizeof(void *);
>  
> -	if (!ptr && *fmt != 'K' && *fmt != 'x') {
> +	if (IS_BAD_PTR(ptr) && *fmt != 'K' && *fmt != 'x') {
>  		/*
>  		 * Print (null)/etc with the same width as a pointer
> so it
>  		 * makes tabular output look nice.
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
