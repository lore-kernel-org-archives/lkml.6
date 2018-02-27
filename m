Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeB0Rg4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:36:56 -0500
Received: from mga11.intel.com ([192.55.52.93]:28578 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751117AbeB0Rgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:36:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,401,1515484800";
   d="scan'208";a="178506180"
Message-ID: <1519752950.10722.231.camel@linux.intel.com>
Subject: Re: [PATCH v2 8/9] lib/vsprintf: Remove useless NULL checks
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: "Tobin C . Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Date: Tue, 27 Feb 2018 19:35:50 +0200
In-Reply-To: <20180227155047.o74ohmoyj56up6pa@pathway.suse.cz>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
         <20180216210711.79901-8-andriy.shevchenko@linux.intel.com>
         <20180227155047.o74ohmoyj56up6pa@pathway.suse.cz>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-27 at 16:50 +0100, Petr Mladek wrote:
> On Fri 2018-02-16 23:07:10, Andy Shevchenko wrote:
> > The pointer can't be NULL since it's first what has been done in the
> > pointer().
> > 
> > Remove useless checks.
> > 
> > Note we leave check for !CONFIG_HAVE_CLK to make compiler
> > to optimize code away when possible.
> > 
> > Cc: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  lib/vsprintf.c | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> > 
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 97be2d07297a..a49da00b79e7 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -819,10 +819,6 @@ char *hex_string(char *buf, char *end, u8
> > *addr, struct printf_spec spec,
> >  		/* nothing to print */
> >  		return buf;
> >  
> > -	if (ZERO_OR_NULL_PTR(addr))
> 
> This macro matches also values <= 16.

Yes, I know.

This had been discussed with Rasmus and we agreed that printing a result
of kmalloc(0) is rather weird.

Moreover, in couple of cases I added these checks.
 
> >  	switch (fmt[1]) {
> > @@ -1580,9 +1572,6 @@ char *device_node_string(char *buf, char *end,
> > struct device_node *dn,
> >  	if (!IS_ENABLED(CONFIG_OF))
> >  		return string(buf, end, "(!OF)", spec);
> >  
> > -	if ((unsigned long)dn < PAGE_SIZE)
> > -		return string(buf, end, "(null)", spec);
> 
> In this case, "null" was printed for ptr < PAGE_SIZE. The same check
> is also in string() function.

Do we have a uses cases when invalid (non-NULL) pointer is supplied to
print function?

Those call sites have to be fixed.

> Note that it is not only about the printed value. The pointer is later
> derefecend. We will start crashing on dn > 0 && dn < PAGE_SIZE.

Yes.
So, fix the call sites!

> To be honest, I do not feel experienced enough to decide
> about the preferred behavior. On one hand, it is bad when
> printk() would crash the kernel. On the other hand, hiding wide
> range of values under "(null)" string might confuse people.

> Would it make sense to survive and write different strings for
> difference intervals? For example?
> 
>     "(null)"     for ptr == 0
>     "(null-16)"  for ptr > 0 && ptr <= 16
>     "(null-pg)"  for prt > 16 && ptr <= PAGE_SIZE
> 
> In each case, this patch changes the behavior and it should
> be documented in the commit message.

Personally I strongly disagree with blowing code up in such places for
little or none benefit.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
