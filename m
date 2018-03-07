Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbeCGKkM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:40:12 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42952 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbeCGKkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:40:07 -0500
X-Google-Smtp-Source: AG47ELsk2xDF0TboiLZX6wKSIXx16z0OEJe9pKLIc5oMAkZAQ40ifRzAWrSx5dMiC1aqgmRkmOJxHQ==
Date: Wed, 7 Mar 2018 19:40:02 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Dave Young <dyoung@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        adi-buildroot-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak symbol
Message-ID: <20180307104002.GA505@jagdpanzerIV>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
 <CAK8P3a1aCQWwrJuCmx-nrMG58NQFCkCPRuAT5g43Lty13nE2dg@mail.gmail.com>
 <20180307022127.GB802@jagdpanzerIV>
 <CAK8P3a172j6r2HEwQ3cOOqXgXkFbxYifQ96VRFZ3+=wGawYNLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a172j6r2HEwQ3cOOqXgXkFbxYifQ96VRFZ3+=wGawYNLQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/07/18 09:46), Arnd Bergmann wrote:
> >
> > When is this going to happen? 4.17?
> 
> Originally I planned to wait a few more releases, but the last maintainer
> has commented that he will now send a patch for immediate removal,
> so 4.17 is almost certain at this point.

Would be great to get it removed as soon as possible then. Otherwise we
will get broken blackfin build errors from Stephen (or would need to hold
off Dave's patch).

> > [..]
> I did the review of all the nds32 patches, and would have commented
> on this if I had noticed it earlier. I see no reason not to change it,
> and would suggest that you continue under the assumption that
> nds32 is going to be fixed, leaving it up to Greentime to add a fix
> to his tree before he sends the pull request.

Good.

> > Honestly, I kind of find __weak less confusing than EXPORT_SYMBOL(dump_stack)
> > in 3 different places. __weak hints that the symbol likely will be overridden
> > somewhere, while EXPORT_SYMBOL() does not (at least not to me). Dunno.
> 
> It's not either/or, they are both wrong ;-)
> 
> The EXPORT_SYMBOL() is not the thing that makes it work. The duplicate
> declaration today only works because lib/dump_stack.o is listed as lib-y
> in the Makefile instead of obj-y. On blackfin and nds32, this causes the entire
> file to just not be included in the final vmlinux, because there are no
> references to it.

Yeah.
But, admittedly, I learned that "obj-y vs lib-y" stuff quite recently.

> With your patch, I would actually expect the lib/dump_stack.o file
> to still not be picked up, so now you have a missing EXPORT_SYMBOL()
> on the two unusual architectures until the point when you add another
> (referenced) symbol to it.

Interesting point. Didn't check it. But I checked that we have at least
one reference to lib/dump_stack from every arch so __weak could work its
magic. The function is show_regs_print_info(). AFAICT, every arch calls
it (we have it in lib/dump_stack now, so we will link with lib/dump_stack).
Anyway, I'll be happy to drop my patch. Thanks for taking a look.

	-ss
