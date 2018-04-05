Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751437AbeDEOeQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:34:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:44882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751179AbeDEOeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:34:14 -0400
Date: Thu, 5 Apr 2018 16:34:12 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 2/9] vsprintf: Consistent %pK handling for
 kptr_restrict == 0
Message-ID: <20180405143412.xuict2cdttr7dzh4@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-3-pmladek@suse.com>
 <20180404231014.GA622@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404231014.GA622@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-04-05 08:10:14, Sergey Senozhatsky wrote:
> On (04/04/18 10:58), Petr Mladek wrote:
> >
> > restricted_pointer() pretends that it prints the address when kptr_restrict
> > is set to zero. But it is never called in this situation. Instead,
> > pointer() falls back to ptr_to_id() and hashes the pointer.
> > 
> > This patch removes the potential confusion. klp_restrict is checked only
> > in restricted_pointer().
> > 
> > It should actually fix a small race when the address might get printed
> > unhashed:
> 
> Early morning, didn't have my coffee yet [like really didn't].
> 
> But I don't see how you "fix" a race. "echo 0" might still be called
> later than switch().

I assume that switch() is safe enough and we always have to take one
path there. The old code allowed to print the original pointer without
the capability check (case 0). The new code does:

    case 0: print hashed pointer
    case 1: keep original pointer only with sufficient privileges
    case 2:
    default: set NULL

The old code expected that it would never use case 0. But it was
possible because of the race.


> [..]
> > @@ -1426,8 +1427,8 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
> >  
> >  	switch (kptr_restrict) {
> >  	case 0:
> > -		/* Always print %pK values */
> > -		break;
> > +		/* Handle as %p, hash and do _not_ leak addresses. */
> > +		return ptr_to_id(buf, end, ptr, spec);
> 
> >From "Always print pK values" to "Always print hashed values"... Do we need
> %pK then? You probably need to update printk-formats.rst as well.

It is already correctly documented in Documentation/sysctl/kernel.txt.
printk-formats.rst uses reference to it.

Best Regards,
Petr
