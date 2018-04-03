Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeDCOuV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:50:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:34357 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751279AbeDCOuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:50:20 -0400
Date: Tue, 3 Apr 2018 16:50:18 +0200
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
Message-ID: <20180403145017.n6iksx7hchf4ppib@pathway.suse.cz>
References: <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
 <1521119343.10722.665.camel@linux.intel.com>
 <20180315152607.xgzjmj5as6lg42dy@pathway.suse.cz>
 <1521224375.23017.41.camel@linux.intel.com>
 <20180329145312.4uqygrjqy3fqyl26@pathway.suse.cz>
 <1522678523.21176.178.camel@linux.intel.com>
 <20180403114600.uc7sqeoqt7fmdd66@pathway.suse.cz>
 <1522756458.21176.314.camel@linux.intel.com>
 <20180403131346.vwjpz475fzah5a6p@pathway.suse.cz>
 <1522762858.21176.327.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522762858.21176.327.camel@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-04-03 16:40:58, Andy Shevchenko wrote:
> On Tue, 2018-04-03 at 15:13 +0200, Petr Mladek wrote:
> > On Tue 2018-04-03 14:54:18, Andy Shevchenko wrote:
> > > On Tue, 2018-04-03 at 13:46 +0200, Petr Mladek wrote:
> > > > On Mon 2018-04-02 17:15:23, Andy Shevchenko wrote:
> > > We have a lot of API functions which returns:
> > > -ERR_PTR
> > > NULL
> > > struct foo *
> > > 
> > > There is no guarantee that one of that API won't be used as a
> > > supplier
> > > for printf().
> > 
> > OK, I think that I have finally understood it. You would like to
> > detect ERR_PTR values and handle them specially? I mean to show
> > the value?
> > 
> > But then we would need to distinguish three types of errors,
> > something like:
> > 
> >  + (null)       for pure NULL address
> >  + (e:XXXX)     for address in IS_ERR_VALUE() range
> 
> // Just IS_ERR(). IS_ERR_VALUE() is not meant to be used widely

IS_ERR() is just a wrapper above IS_ERR_VALUE(). The range is important
here and it is the same for both.


> >  + (efault)     for any other invalid address
> > 
> > Then people might want to see values also from the first 4096 bytes.
> > This is getting too complicated.
> 
> No, it's not. (null) case is already in kernel, you came with (efault),
> but IS_ERR() case or any other case like it is just printing of standard
> pointer value. See in the code where special_hex_number() is called.
> 
> >  I am not sure if it is worth it.
> 
> Your patch will hide values for error codes. Not good for debugging.

It does it in situation where we mostly silently crashed so
far. Therefore I do not see this as a big regression.

If we hanle IS_ERR() a special way, it will mean more code and more types
of error messages. People might be confused by the difference between
(e:000e) and (efault).

Yes, it might help to distinguish this situation in some cases.
But typically the information about invalid address access should be
enough. People will either see the problem from the code or they would
need to add more debug messages anyway.



> > > You can't dereference ERR_PTR value, but anything else except the
> > > > 
> > > > > >  Also google gives
> > > > > > rather confusing results when searching, for example for
> > > > > > "(0x000E)".
> > > > > 
> > > > > It's not primarily for google, though yeah, people would google
> > > > > for
> > > > > error messages...
> > > > > 
> > > > > Another question is what the format: decimal versus hex for
> > > > > errors.
> > > > > Maybe just "(-DDDDD)"?
> > > > 
> > > > This still looks confusing and google does not help.
> > > 
> > > ...then we have a last option just to print a value as a pointer
> > > address.
> > 
> > We could not print the real address from security reasons. The hashed
> > pointer value is not much helpful. IMHO, a common error string is
> > easier to spot or search for.
> 
> Did you read what I'm writing? How on the earth the pointer in the range
> of -1...-4095 would be a security issue?!

Please, read your mails again. You never wrote that you were talking
about handling error codes specially. I mean this thread starting at
https://lkml.kernel.org/r/20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz

Most of the time I though that you were talking about displaying the
single error code -EFAULT for any invalid address or showing any
invalid address directly. I am not a psychic.

OK, you mentioned this in the early mail at
https://lkml.kernel.org/r/1520446689.10722.493.camel@linux.intel.com
But it was in a bit different context. Also it was right before the mail
from Linus who wrote:

"Guys, stop this idiocy. printk() needs to be *simple* and *reliable*,
not fancy."

He then wrote many times that NULL might be considered special.
But that we should really keep it simple.

Best Regards,
Petr
