Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932297AbeDCNNu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:13:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:46373 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932151AbeDCNNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:13:49 -0400
Date: Tue, 3 Apr 2018 15:13:46 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v3] vsprintf: Prevent crash when dereferencing invalid
 pointers
Message-ID: <20180403131346.vwjpz475fzah5a6p@pathway.suse.cz>
References: <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
 <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
 <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
 <1521119343.10722.665.camel@linux.intel.com>
 <20180315152607.xgzjmj5as6lg42dy@pathway.suse.cz>
 <1521224375.23017.41.camel@linux.intel.com>
 <20180329145312.4uqygrjqy3fqyl26@pathway.suse.cz>
 <1522678523.21176.178.camel@linux.intel.com>
 <20180403114600.uc7sqeoqt7fmdd66@pathway.suse.cz>
 <1522756458.21176.314.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522756458.21176.314.camel@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-04-03 14:54:18, Andy Shevchenko wrote:
> On Tue, 2018-04-03 at 13:46 +0200, Petr Mladek wrote:
> > On Mon 2018-04-02 17:15:23, Andy Shevchenko wrote:
> > > On Thu, 2018-03-29 at 16:53 +0200, Petr Mladek wrote:
> > > > On Fri 2018-03-16 20:19:35, Andy Shevchenko wrote:
> > > > > On Thu, 2018-03-15 at 16:26 +0100, Petr Mladek wrote:
> > > > > > On Thu 2018-03-15 15:09:03, Andy Shevchenko wrote:
> > > > > > > I still think that printing a hex value of the error code is
> > > > > > > much
> > > > > > > better
> > > > > > > than some odd "(efault)".
> > > > > > 
> > > > > > Do you mean (err:0e)? Google gives rather confusing answers
> > > > > > for
> > > > > > this.
> > > > > 
> > > > > More like "(0xHHHH)" (we have already more than 512 error code
> > > > > numbers.
> > > > 
> > > > Hmm, I have never seen the error code in this form.
> > > 
> > > We have limited space to print it and error numbers currently can be
> > > up
> > > to 0xfff (4095). So, I have no better idea how to squeeze them while
> > > thinking that "(efault)" is much harder to parse in case of error
> > > pointer.
> > 
> > But this will not be used instead of address value. It is used in
> > situations
> > where we print the information that is stored at the address, for
> > example,
> > string, IP address, dentry name.
> 
> We have a lot of API functions which returns:
> -ERR_PTR
> NULL
> struct foo *
> 
> There is no guarantee that one of that API won't be used as a supplier
> for printf().

OK, I think that I have finally understood it. You would like to
detect ERR_PTR values and handle them specially? I mean to show
the value?

But then we would need to distinguish three types of errors,
something like:

 + (null)       for pure NULL address
 + (e:XXXX)     for address in IS_ERR_VALUE() range
 + (efault)     for any other invalid address

Then people might want to see values also from the first 4096 bytes.
This is getting too complicated. I am not sure if it is worth it.


> You can't dereference ERR_PTR value, but anything else except the actual
> error value is worse than value itself...

Yes and no, see below.

> > 
> > > >  Also google gives
> > > > rather confusing results when searching, for example for
> > > > "(0x000E)".
> > > 
> > > It's not primarily for google, though yeah, people would google for
> > > error messages...
> > > 
> > > Another question is what the format: decimal versus hex for errors.
> > > Maybe just "(-DDDDD)"?
> > 
> > This still looks confusing and google does not help.
> 
> ...then we have a last option just to print a value as a pointer
> address.

We could not print the real address from security reasons. The hashed
pointer value is not much helpful. IMHO, a common error string is
easier to spot or search for.

Best Regards,
Petr
