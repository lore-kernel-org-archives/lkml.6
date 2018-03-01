Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031606AbeCAO40 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:56:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:32125 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031346AbeCAO4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:56:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,408,1515484800";
   d="scan'208";a="21323901"
Message-ID: <1519916180.10722.317.camel@linux.intel.com>
Subject: Re: [PATCH v2 8/9] lib/vsprintf: Remove useless NULL checks
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: "Tobin C . Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Date: Thu, 01 Mar 2018 16:56:20 +0200
In-Reply-To: <20180228100437.o4juwxbzomkqjvjx@pathway.suse.cz>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
         <20180216210711.79901-8-andriy.shevchenko@linux.intel.com>
         <20180227155047.o74ohmoyj56up6pa@pathway.suse.cz>
         <1519752950.10722.231.camel@linux.intel.com>
         <20180228100437.o4juwxbzomkqjvjx@pathway.suse.cz>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Pantelis, author of %pOF extension
(I leave a lot of the message from Petr to give you a bit of context)

On Wed, 2018-02-28 at 11:04 +0100, Petr Mladek wrote:
> On Tue 2018-02-27 19:35:50, Andy Shevchenko wrote:
> > On Tue, 2018-02-27 at 16:50 +0100, Petr Mladek wrote:
> > > On Fri 2018-02-16 23:07:10, Andy Shevchenko wrote:
> > > > The pointer can't be NULL since it's first what has been done in
> > > > the
> > > > pointer().
> > > > 
> > > > Remove useless checks.
> > > > 
> > > > Note we leave check for !CONFIG_HAVE_CLK to make compiler
> > > > to optimize code away when possible.
 
> > > > -	if (ZERO_OR_NULL_PTR(addr))
> > > 
> > > This macro matches also values <= 16.
> > 
> > Yes, I know.
> > 
> > This had been discussed with Rasmus and we agreed that printing a
> > result
> > of kmalloc(0) is rather weird.
> 
> I see
> https://lkml.kernel.org/r/1500546142.29303.133.camel@linux.intel.com
> There you suggested to move this check into pointer(). But I do not
> see any agreement on this.

> > > >  	switch (fmt[1]) {
> > > > @@ -1580,9 +1572,6 @@ char *device_node_string(char *buf, char
> > > > *end,
> > > > struct device_node *dn,
> > > >  	if (!IS_ENABLED(CONFIG_OF))
> > > >  		return string(buf, end, "(!OF)", spec);
> > > >  
> > > > -	if ((unsigned long)dn < PAGE_SIZE)
> > > > -		return string(buf, end, "(null)", spec);
> > > 
> > > In this case, "null" was printed for ptr < PAGE_SIZE. The same
> > > check
> > > is also in string() function.
> > 
> > Do we have a uses cases when invalid (non-NULL) pointer is supplied
> > to
> > print function?
> > 
> > Those call sites have to be fixed.

Pantelis, is this check necessary? What are the use cases of node
pointer being < PAGE_SIZE?

And main question, can it be just (re-)moved to simple NULL check?

See below the originate of the PAGE_SIZE check what Petr found.

> I am not aware of any. But this patch will make fixing such locations
> more complicated. The kernel would crash and might not show any
> message.
> Is this really what we want?
> 
> Note that it will most likely crash in vprintk_emit() on the line
> 
>    text_len = vscnprintf(text, sizeof(textbuf), fmt, args);
> 
> It will be with logbug_lock() taken. The nested printk() messages
> will be stored in per-CPU buffer thanks to printk_safe code.
> They might eventually be printed by printk_safe_flush_on_panic()
> but it is not guaranteed.
> 
> 
> > > Note that it is not only about the printed value. The pointer is
> > > later
> > > derefecend. We will start crashing on dn > 0 && dn < PAGE_SIZE.
> > 
> > Yes.
> > So, fix the call sites!
> 
> It would be easier if printk() was able to show the message
> when hitting this place.
> 
> I did some archaeology. The first check for PAGE_SIZE was added
> by the pre-git commit:
> 
> commit 8bcb3ba1dec5749a7f1eed570cb69a20c2e4bd41
> Author: Andrew Morton <akpm@osdl.org>
> Date:   Tue Oct 21 18:22:28 2003 -0700
> 
>     [PATCH] make printk more robust with "null" pointers
>     
>     Expand printk's traditional handling of null pointers so that
> anything in the
>     first page is considered a null pointer.
>     
>     This gives us better behaviour when someone (acpi..) accidentally
> prints a
>     string which is embedded in a struct, the pointer to which is
> null.
> 
> 
> IMHO, it would make sense to hanve this check also pointers that are
> being deferred.
> 
> 
> > > To be honest, I do not feel experienced enough to decide
> > > about the preferred behavior. On one hand, it is bad when
> > > printk() would crash the kernel. On the other hand, hiding wide
> > > range of values under "(null)" string might confuse people.
> > > Would it make sense to survive and write different strings for
> > > difference intervals? For example?
> > > 
> > >     "(null)"     for ptr == 0
> > >     "(null-16)"  for ptr > 0 && ptr <= 16
> > >     "(null-pg)"  for prt > 16 && ptr <= PAGE_SIZE
> > > 
> > > In each case, this patch changes the behavior and it should
> > > be documented in the commit message.
> > 
> > Personally I strongly disagree with blowing code up in such places
> > for
> > little or none benefit.
> 
> I do not have strong opinion here. I could imagine that this might
> save a day to some people. But I have never encountered such a bug
> myself.
> 
> To make it clear. Your clean up work makes sense. I just want to point
> out that this patch is not as innocent as the commit message suggest.
> Also I think that it goes in the wrong direction regarding the
> ability to show useful information in a buggy situation.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
