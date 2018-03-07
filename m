Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754341AbeCGK5o (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:57:44 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42866 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754293AbeCGK5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:57:37 -0500
X-Google-Smtp-Source: AG47ELtDSAorM0ydf+wgXEbHBzzFkLD14uM4f4nkesMghWo8eFkl+voUMSTuCowng8kpHsV9Ul8WS37UNMpElpDaLUc=
MIME-Version: 1.0
In-Reply-To: <20180307104002.GA505@jagdpanzerIV>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
 <CAK8P3a1aCQWwrJuCmx-nrMG58NQFCkCPRuAT5g43Lty13nE2dg@mail.gmail.com>
 <20180307022127.GB802@jagdpanzerIV> <CAK8P3a172j6r2HEwQ3cOOqXgXkFbxYifQ96VRFZ3+=wGawYNLQ@mail.gmail.com>
 <20180307104002.GA505@jagdpanzerIV>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 11:57:35 +0100
X-Google-Sender-Auth: E15orKau_EbouSL7Rnahljlas_0
Message-ID: <CAK8P3a3eK4iS9rEWvoRfH75zjj7KHpsPnofoGdWH28Dqbz-UyQ@mail.gmail.com>
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

On Wed, Mar 7, 2018 at 11:40 AM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> On (03/07/18 09:46), Arnd Bergmann wrote:
>> >
>> > When is this going to happen? 4.17?
>>
>> Originally I planned to wait a few more releases, but the last maintainer
>> has commented that he will now send a patch for immediate removal,
>> so 4.17 is almost certain at this point.
>
> Would be great to get it removed as soon as possible then. Otherwise we
> will get broken blackfin build errors from Stephen (or would need to hold
> off Dave's patch).

You could also add a patch to your tree that removes the blackfin
dump_stack() function, or we could ask Stephen and the other
people operating build bots to stop building blackfin right now
(they will have to do that anyway once the arch gets removed).

>> With your patch, I would actually expect the lib/dump_stack.o file
>> to still not be picked up, so now you have a missing EXPORT_SYMBOL()
>> on the two unusual architectures until the point when you add another
>> (referenced) symbol to it.
>
> Interesting point. Didn't check it. But I checked that we have at least
> one reference to lib/dump_stack from every arch so __weak could work its
> magic. The function is show_regs_print_info(). AFAICT, every arch calls
> it (we have it in lib/dump_stack now, so we will link with lib/dump_stack).
> Anyway, I'll be happy to drop my patch. Thanks for taking a look.

Ah, right, that is after your second patch. So after the first one, it might
be broken, but the follow-up patch fixes it.

Since lib/dump_stack.c is mandatory then, I would suggest making it
obj-y and moving it out of lib/ into kernel/printk/.

      Arnd
