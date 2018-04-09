Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeDIMFa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:05:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:36289 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752185AbeDIMF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:05:28 -0400
Date: Mon, 9 Apr 2018 14:05:26 +0200
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
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 2/9] vsprintf: Consistent %pK handling for
 kptr_restrict == 0
Message-ID: <20180409120526.66ubl3by4cvaaprq@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-3-pmladek@suse.com>
 <1522933485.21176.353.camel@linux.intel.com>
 <20180405144602.qnpwoxinepgnjhds@pathway.suse.cz>
 <1523110098.21176.409.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523110098.21176.409.camel@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2018-04-07 17:08:18, Andy Shevchenko wrote:
> On Thu, 2018-04-05 at 16:46 +0200, Petr Mladek wrote:
> > On Thu 2018-04-05 16:04:45, Andy Shevchenko wrote:
> > > On Wed, 2018-04-04 at 10:58 +0200, Petr Mladek wrote:
> > > > restricted_pointer() pretends that it prints the address when
> > > > kptr_restrict
> > > > is set to zero. But it is never called in this situation. Instead,
> > > > pointer() falls back to ptr_to_id() and hashes the pointer.
> > > > 
> > > > This patch removes the potential confusion. klp_restrict is
> > > > checked
> > > > only
> > > > in restricted_pointer().
> > > > 
> > > 
> > > 
> > > >  /* Maps a pointer to a 32 bit unique identifier. */
> > > > -static char *ptr_to_id(char *buf, char *end, void *ptr, struct
> > > > printf_spec spec)
> > > > +static char *ptr_to_id(char *buf, char *end,
> > > > +		       const void *ptr, struct printf_spec spec)
> > > 
> > > I don't think this change belongs to the patch.
> > 
> > The const should have been there from the beginning. I have found it
> > because this patch added a call to ptr_to_id() which had the const
> > and compiler warned about cast problems.
> 
> So, why not to do a separate patch with clear intention?

If you insist I could do it as separate patch.


> > IMHO, it is rather cosmetic change.
> 
> >From my experience I'm afraid of cosmetic changes in the patches which
> might focus out attention on real fix.

I would understand this if it was part of a large patch that changed
complex chain of functions. But this patch touched 5 lines. The const
is added into static function that is almost leaf and was called
only from a single location.

Best Regards,
Petr
