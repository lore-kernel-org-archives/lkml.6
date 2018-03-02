Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427860AbeCBMvY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:51:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:49678 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424020AbeCBMvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:51:20 -0500
Date: Fri, 2 Mar 2018 13:51:18 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Tobin C . Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v2 8/9] lib/vsprintf: Remove useless NULL checks
Message-ID: <20180302125118.bjd3tbuu72vgfczo@pathway.suse.cz>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
 <20180216210711.79901-8-andriy.shevchenko@linux.intel.com>
 <20180227155047.o74ohmoyj56up6pa@pathway.suse.cz>
 <1519752950.10722.231.camel@linux.intel.com>
 <20180228100437.o4juwxbzomkqjvjx@pathway.suse.cz>
 <1519814544.10722.266.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519814544.10722.266.camel@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-02-28 12:42:24, Andy Shevchenko wrote:
> On Wed, 2018-02-28 at 11:04 +0100, Petr Mladek wrote:
> > On Tue 2018-02-27 19:35:50, Andy Shevchenko wrote:
> > > On Tue, 2018-02-27 at 16:50 +0100, Petr Mladek wrote:
> > Note that it will most likely crash in vprintk_emit() on the line
> > 
> >    text_len = vscnprintf(text, sizeof(textbuf), fmt, args);
> > 
> > It will be with logbug_lock() taken. The nested printk() messages
> > will be stored in per-CPU buffer thanks to printk_safe code.
> 
> Yeah, that's bad.
> 
> > IMHO, it would make sense to hanve this check also pointers that are
> > being deferred.
> 
> Send a patch to discuss!

I thought about this more. IMHO, the check for PAGE_SIZE in pointer()
makes perfect sense. It helps to avoid crash and actually see
the message. I am going to send the patch in a minute.

BTW: I am not sure who is going to pass this patchset to Linus.
If nobody is against, I could eventually do so via printk.git.


> > > > To be honest, I do not feel experienced enough to decide
> > > > about the preferred behavior. On one hand, it is bad when
> > > > printk() would crash the kernel. On the other hand, hiding wide
> > > > range of values under "(null)" string might confuse people.
> > > > Would it make sense to survive and write different strings for
> > > > difference intervals? For example?
> > > > 
> > > >     "(null)"     for ptr == 0
> > > >     "(null-16)"  for ptr > 0 && ptr <= 16
> > > >     "(null-pg)"  for prt > 16 && ptr <= PAGE_SIZE
> > > > 
> > > > In each case, this patch changes the behavior and it should
> > > > be documented in the commit message.
> > > 
> > > Personally I strongly disagree with blowing code up in such places
> > > for little or none benefit.
> 
> Send a patch to discuss!

I am not going to do so unless there is an evidence that people are
confused or that the above idea is desired.

Best Regards,
Petr
