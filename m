Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752795AbeCFJZU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:25:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:46521 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750836AbeCFJZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:25:17 -0500
Date: Tue, 6 Mar 2018 10:25:13 +0100
From: Petr Mladek <pmladek@suse.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH] vsprintf: Make "null" pointer dereference more robust
Message-ID: <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
 <20180216210711.79901-8-andriy.shevchenko@linux.intel.com>
 <20180227155047.o74ohmoyj56up6pa@pathway.suse.cz>
 <1519752950.10722.231.camel@linux.intel.com>
 <20180228100437.o4juwxbzomkqjvjx@pathway.suse.cz>
 <1519814544.10722.266.camel@linux.intel.com>
 <20180302125118.bjd3tbuu72vgfczo@pathway.suse.cz>
 <20180302125359.szbin2kznxvoq7sc@pathway.suse.cz>
 <CAKwiHFgTbFof34oc59OU3M1=-PTzstv0uxSmoiRc8TJPJPMHVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwiHFgTbFof34oc59OU3M1=-PTzstv0uxSmoiRc8TJPJPMHVw@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-03-05 16:16:37, Rasmus Villemoes wrote:
> On 2 March 2018 at 13:53, Petr Mladek <pmladek@suse.com> wrote:
> > %p has many modifiers where the pointer is dereferenced. An invalid
> > pointer might cause kernel to crash silently.
> >
> > Note that printk() formats the string under logbuf_lock. Any recursive
> > printks are redirected to the printk_safe implementation and the messages
> > are stored into per-CPU buffers. These buffers might be eventually flushed
> > in printk_safe_flush_on_panic() but it is not guaranteed.
> 
> Yeah, it's annoying that we can't reliably WARN for bogus vsprintf() uses.
> 
> > In general, we should do our best to get useful message from printk().
> > All pointers to the first memory page must be invalid. Let's prevent
> > the dereference and print "(null)" in this case. This is already done
> > in many other situations, including "%s" format handling and many
> > page fault handlers.
> >
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > ---
> >  lib/vsprintf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index d7a708f82559..5c2d1f44218a 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -1849,7 +1849,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
> >  {
> >         const int default_width = 2 * sizeof(void *);
> >
> > -       if (!ptr && *fmt != 'K' && *fmt != 'x') {
> > +       if ((unsigned long)ptr < PAGE_SIZE && *fmt != 'K' && *fmt != 'x') {
> 
> ISTM that accidentally passing an ERR_PTR would be just as likely as
> passing a NULL pointer (or some small offset from one), so if we do
> this, shouldn't the test also cover IS_ERR values?

It would make perfect sense to catch IS_ERR_PTR(). Derefenrecing
such pointer cause crash. But it might be pretty confusing to print
"(null)" in this case.

I would handle this in separate patch and print "(err)" or so.
Any volunteer to prepare the patch?

Best Regards,
Petr
