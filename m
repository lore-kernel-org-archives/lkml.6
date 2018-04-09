Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeDINub (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:50:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:46450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751653AbeDINua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:50:30 -0400
Date: Mon, 9 Apr 2018 15:50:28 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] vsprintf: Consolidate handling of unknown pointer
 specifiers
Message-ID: <20180409135028.ymyvsqxup7zm5vgc@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-5-pmladek@suse.com>
 <1523111200.21176.416.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523111200.21176.416.camel@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2018-04-07 17:26:40, Andy Shevchenko wrote:
> On Wed, 2018-04-04 at 10:58 +0200, Petr Mladek wrote:
> > There are few printk formats that make sense only with two or more
> > specifiers. Also some specifiers make sense only when a kernel feature
> > is enabled.
> > 
> > The handling of unknown specifiers is strange, inconsistent, and
> > even leaking the address. For example, netdev_bits() prints the
> > non-hashed pointer value or clock() prints "(null)".
> > 
> > The best solution seems to be in flags_string(). It does not print any
> > misleading value. Instead it calls WARN_ONCE() describing the unknown
> > specifier. Therefore it clearly shows the problem and helps to find
> > it.
> > 
> > Note that WARN_ONCE() used to cause recursive printk(). But it is safe
> > now because vscnprintf() is called in printk_safe context from
> > vprintk_emit().
> > 
> 
> > -	if (!IS_ENABLED(CONFIG_HAVE_CLK) || !clk)
> > +	if (!IS_ENABLED(CONFIG_HAVE_CLK)) {
> > +		WARN_ONCE(1, "Unsupported pointer format specifier:
> > %%pC\n");
> > +		return buf;
> > +	}
> > +
> > +	if (!clk)
> >  		return string(buf, end, NULL, spec);
> 
> This change collides with my patch series. Can you elaborate what your
> thoughts are about my patches? Are you going incorporate them to your
> series? Should I send them independently?

Good question. I think that the best solution will be that I go
over your patchset and just add all valid ones into printk.git
for-4.18. Then I will base v5 of this patchset on top of it.

I should have done this earlier. But I did not expect that long
way for the access-check stuff. We originally planned to
do the access check first, see
https://lkml.kernel.org/r/1520000254.10722.389.camel@linux.intel.com
But the access check patchset still need some love, so it makes
sense to switch the order.

Best Regards,
Petr
