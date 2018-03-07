Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754166AbeCGIqh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:46:37 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:50814 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbeCGIqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:46:30 -0500
X-Google-Smtp-Source: AG47ELteHPsbkS13a/ZTN2YZWxbzMBiZh7Fmijm5FTUruJYL1TUpEQ0u2yy81aHtyzDHwTxevkdo7K5KDwUM6CR4Yvo=
MIME-Version: 1.0
In-Reply-To: <20180307022127.GB802@jagdpanzerIV>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
 <CAK8P3a1aCQWwrJuCmx-nrMG58NQFCkCPRuAT5g43Lty13nE2dg@mail.gmail.com> <20180307022127.GB802@jagdpanzerIV>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 09:46:27 +0100
X-Google-Sender-Auth: E40iPK53N7olRssOv6vWGztDXmQ
Message-ID: <CAK8P3a172j6r2HEwQ3cOOqXgXkFbxYifQ96VRFZ3+=wGawYNLQ@mail.gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak symbol
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Dave Young <dyoung@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        adi-buildroot-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 3:21 AM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> Hello Arnd,
>
> On (03/06/18 14:27), Arnd Bergmann wrote:
> [..]
>> As we are now removing blackfin, based on the latest discussion, this
>> part should no longer be necessary.
>
> When is this going to happen? 4.17?

Originally I planned to wait a few more releases, but the last maintainer
has commented that he will now send a patch for immediate removal,
so 4.17 is almost certain at this point.

> [..]
>> nds32 currently only exists in linux-next, not in the mainline kernel.
>> If it's the only architecture that does something different from everyone
>> else, I think we should change nds32.
>>
>> I looked at the nds32 show_stack() implementation now and it
>> seems to me that it is completely unnecessary, as the implementation
>> from lib/dump_stack.c does basically the same thing (by calling
>> show_stack(NULL, NULL)).
>
> Interesting point. I'll leave it to nds32 maintainers.
> OTOH blackfin is still in linux-next, so I assume we need
> that __weak dump_stack() for the time being.

I did the review of all the nds32 patches, and would have commented
on this if I had noticed it earlier. I see no reason not to change it,
and would suggest that you continue under the assumption that
nds32 is going to be fixed, leaving it up to Greentime to add a fix
to his tree before he sends the pull request.

>> > +asmlinkage __weak __visible void dump_stack(void)
>> >  {
>> >         __dump_stack();
>> >  }
>>
>> Weak symbols are generally discouraged in the kernel. We have
>> them in a couple of places, but I find them rather confusing as they
>> make it harder to figure out what is actually going on.
>
> Honestly, I kind of find __weak less confusing than EXPORT_SYMBOL(dump_stack)
> in 3 different places. __weak hints that the symbol likely will be overridden
> somewhere, while EXPORT_SYMBOL() does not (at least not to me). Dunno.

It's not either/or, they are both wrong ;-)

The EXPORT_SYMBOL() is not the thing that makes it work. The duplicate
declaration today only works because lib/dump_stack.o is listed as lib-y
in the Makefile instead of obj-y. On blackfin and nds32, this causes the entire
file to just not be included in the final vmlinux, because there are no
references to it.

With your patch, I would actually expect the lib/dump_stack.o file
to still not be picked up, so now you have a missing EXPORT_SYMBOL()
on the two unusual architectures until the point when you add another
(referenced) symbol to it.

       Arnd
