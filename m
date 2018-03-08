Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeCHR0O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:26:14 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:44858 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeCHR0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:26:12 -0500
X-Google-Smtp-Source: AG47ELsj8Qn7LXuKVnD2IywrlaOaV3bSuEScKLfEF0N+5FjxiS0mWG4I6Sw3n/bWoFbNRcynrrBsuHnp0qYnEy2TLus=
MIME-Version: 1.0
In-Reply-To: <CA+55aFyDbr4JpiPoHXq=3wJu+WVCLZPpAVsmY=5HVStawmEiRw@mail.gmail.com>
References: <1519752950.10722.231.camel@linux.intel.com> <20180228100437.o4juwxbzomkqjvjx@pathway.suse.cz>
 <1519814544.10722.266.camel@linux.intel.com> <20180302125118.bjd3tbuu72vgfczo@pathway.suse.cz>
 <20180302125359.szbin2kznxvoq7sc@pathway.suse.cz> <CAKwiHFgTbFof34oc59OU3M1=-PTzstv0uxSmoiRc8TJPJPMHVw@mail.gmail.com>
 <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz> <1520330185.10722.401.camel@linux.intel.com>
 <20180307155244.b45c3fb5vcxb4q2l@pathway.suse.cz> <CA+55aFxr5eg_fWjyhcYFU4CSOoVP_GeB79cYa=8mUk7J1cUG7A@mail.gmail.com>
 <20180308141824.bfk2pr6wmjh4ytdi@pathway.suse.cz> <CA+55aFyDbr4JpiPoHXq=3wJu+WVCLZPpAVsmY=5HVStawmEiRw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Mar 2018 09:26:11 -0800
X-Google-Sender-Auth: wbzd96lAkSr_QRPLMzPXoiKzMCU
Message-ID: <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com>
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

On Thu, Mar 8, 2018 at 8:45 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Umm. Look again. It _does_ affect plain %p.
>
> You're correct that it doesn't affect %px and %pK, since those never
> printed out (null) in the first place.
>
> It not only affects %p, but it also affects %pS and friends (sSfFB),

Looking around at the x86 panic thing, %p doesn't matter that much,
but %p[sSfFB] really do.

We use %pS/%pB to print out the instruction pointer. And a fault might
be due to the instruction pointer being bad.

And then we very much need to see the value, which the current
%pS-and-friends falls back to.

So printing <efault> would actually be horrible, in addition to the
extra page fault being wrong. In fact, _only_ NULL itself needs to be
printed as (null), because we'd care if it's 0 or 8 or something.

The other ones? The ones that would actually fault (%pI and friends)
would not matter.

The hex dumping one _might_ actually be useful if it got a buffer with
'probe_kernel_read()' and stopped half-way on problems.   Maybe. The
others I can't imagine really care. efault or hex address.

             Linus
