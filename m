Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeB1Km3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:42:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:4978 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752109AbeB1Km2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:42:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,405,1515484800";
   d="scan'208";a="204355059"
Message-ID: <1519814544.10722.266.camel@linux.intel.com>
Subject: Re: [PATCH v2 8/9] lib/vsprintf: Remove useless NULL checks
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: "Tobin C . Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Date: Wed, 28 Feb 2018 12:42:24 +0200
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
> > > > 

> I see
> https://lkml.kernel.org/r/1500546142.29303.133.camel@linux.intel.com
> There you suggested to move this check into pointer(). But I do not
> see any agreement on this.

> I am not aware of any. But this patch will make fixing such locations
> more complicated. The kernel would crash and might not show any
> message.

> Is this really what we want?

I never see such, so, I don't know what we want here.

> Note that it will most likely crash in vprintk_emit() on the line
> 
>    text_len = vscnprintf(text, sizeof(textbuf), fmt, args);
> 
> It will be with logbug_lock() taken. The nested printk() messages
> will be stored in per-CPU buffer thanks to printk_safe code.

Yeah, that's bad.


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

Send a patch to discuss!

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

Send a patch to discuss!

I consider silence as not preventing me doing my way. It seems you are
the first one who looks into this closer than the other(s) [Rasmus].

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
