Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeCHQpW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:45:22 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:46363 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752052AbeCHQpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:45:21 -0500
X-Google-Smtp-Source: AG47ELtFmEjR1xdHgWowlev0TbE2aJTYxYP5crSSsPyUDlIsHLfhOjvgreZ2J/K+v+mantNDnPVcjGPqMxmLc0ZnH84=
MIME-Version: 1.0
In-Reply-To: <20180308141824.bfk2pr6wmjh4ytdi@pathway.suse.cz>
References: <1519752950.10722.231.camel@linux.intel.com> <20180228100437.o4juwxbzomkqjvjx@pathway.suse.cz>
 <1519814544.10722.266.camel@linux.intel.com> <20180302125118.bjd3tbuu72vgfczo@pathway.suse.cz>
 <20180302125359.szbin2kznxvoq7sc@pathway.suse.cz> <CAKwiHFgTbFof34oc59OU3M1=-PTzstv0uxSmoiRc8TJPJPMHVw@mail.gmail.com>
 <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz> <1520330185.10722.401.camel@linux.intel.com>
 <20180307155244.b45c3fb5vcxb4q2l@pathway.suse.cz> <CA+55aFxr5eg_fWjyhcYFU4CSOoVP_GeB79cYa=8mUk7J1cUG7A@mail.gmail.com>
 <20180308141824.bfk2pr6wmjh4ytdi@pathway.suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Mar 2018 08:45:19 -0800
X-Google-Sender-Auth: 1sbSPSNTvpESP1XhKc80Zt0lZko
Message-ID: <CA+55aFyDbr4JpiPoHXq=3wJu+WVCLZPpAVsmY=5HVStawmEiRw@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: Make "null" pointer dereference more robust
To: Petr Mladek <pmladek@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 6:18 AM, Petr Mladek <pmladek@suse.com> wrote:
> On Wed 2018-03-07 10:34:17, Linus Torvalds wrote:
>>
>> Guess what happens now to any crash report if it uses %p and there is
>> anything wrong with the VM?
>
> This patch does _not_ affect plain %p, %px, and %pK!

Umm. Look again. It _does_ affect plain %p.

You're correct that it doesn't affect %px and %pK, since those never
printed out (null) in the first place.

> It affects %s and %p* modifiers that need to read data from the
> given address.

_If_ that was what the patch did, it would be fine.

But it isn't.

It not only affects %p, but it also affects %pS and friends (sSfFB),
that do not access the location (well, on some architectures those
might, to dereference a function descriptor, but then they will check
the address range).

So that patch really is completely broken for the reasons I outlined.

Now, if it was fixed to what you apparently *intended* to do, then
that would be ok.

            Linus
