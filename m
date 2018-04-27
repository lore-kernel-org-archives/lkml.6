Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758229AbeD0Mh4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 08:37:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:38624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757437AbeD0Mhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 08:37:55 -0400
Date: Fri, 27 Apr 2018 14:37:53 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/11] vsprintf: WARN() on invalid pointer access
Message-ID: <20180427123753.22mctekbwocbpfwj@pathway.suse.cz>
References: <20180425111251.13246-1-pmladek@suse.com>
 <20180425111251.13246-11-pmladek@suse.com>
 <20180426012805.GA3282@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426012805.GA3282@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-04-26 10:28:05, Sergey Senozhatsky wrote:
> On (04/25/18 13:12), Petr Mladek wrote:
> [..]
> >   /*
> >    * This is not a fool-proof test. 99% of the time that this will fault is
> >    * due to a bad pointer, not one that crosses into bad memory. Just test
> > @@ -623,8 +626,12 @@ static const char *check_pointer_access(const void *ptr)
> >  	if (!ptr)
> >  		return "(null)";
> >  
> > -	if (probe_kernel_address(ptr, byte))
> > +	/* Prevent silent crashes when called in printk_safe context. */
> > +	if (probe_kernel_address(ptr, byte)) {
> > +		WARN(!panic_on_warn && !test_printf_pointer_access,
> > +		     "vsprintf: invalid pointer address\n");
> >  		return "(efault)";
> > +	}
> 
> Can we have a rate-limited print out here? Or may be even a WARN_ONCE()?
> Yes, printk()-s from check_pointer_access() are OK, printk_safe() helps us,
> but at the same time every single invalid pointer access printk()-message
> will log_store() WARN() extra entries. Theoretically, this can harm. What
> do you think?

I believe that these WARNs will be rare. After all they happen in situations
where the kernel crashed so far.

I suggest to keep it as is for now. We could always ratelimit it later if
needed.

Best Regards,
Petr
