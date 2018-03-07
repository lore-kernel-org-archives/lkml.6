Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754655AbeCGSk3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:40:29 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:35904 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754333AbeCGSk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:40:27 -0500
X-Google-Smtp-Source: AG47ELs941n9koQTN8vyiRc3raoigUzlGPalB6Q1PLCkCRRslM+ESK3SBWBMx7kvU3jS5q9U5b5ldwFH/LUeyswTyeQ=
MIME-Version: 1.0
In-Reply-To: <20180307155244.b45c3fb5vcxb4q2l@pathway.suse.cz>
References: <20180216210711.79901-8-andriy.shevchenko@linux.intel.com>
 <20180227155047.o74ohmoyj56up6pa@pathway.suse.cz> <1519752950.10722.231.camel@linux.intel.com>
 <20180228100437.o4juwxbzomkqjvjx@pathway.suse.cz> <1519814544.10722.266.camel@linux.intel.com>
 <20180302125118.bjd3tbuu72vgfczo@pathway.suse.cz> <20180302125359.szbin2kznxvoq7sc@pathway.suse.cz>
 <CAKwiHFgTbFof34oc59OU3M1=-PTzstv0uxSmoiRc8TJPJPMHVw@mail.gmail.com>
 <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz> <1520330185.10722.401.camel@linux.intel.com>
 <20180307155244.b45c3fb5vcxb4q2l@pathway.suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Mar 2018 10:34:17 -0800
X-Google-Sender-Auth: zBluRUj-uwHuQ3PaSeymCzD0ZyQ
Message-ID: <CA+55aFxr5eg_fWjyhcYFU4CSOoVP_GeB79cYa=8mUk7J1cUG7A@mail.gmail.com>
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

On Wed, Mar 7, 2018 at 7:52 AM, Petr Mladek <pmladek@suse.com> wrote:
> If we are changing things, let's do it properly. The range
> (-PAGE_SIZE,+PAGE_SIZE) is just a small subset of invalid pointers.
> Let's try to catch more of them by reading one byte using
> probe_kernel_read(). It would return -FAULT if we are not able
> to read the address but it would not crash.
>
> Then we clearly need a new message when dereferencing invalid
> poitners that are not pure NULL. I propose (efault).

NO! Absolutely f*cking NOT!

"probe_kernel_read()" is really complicated. It takes a *fault* for chrissake!

Guess what happens now to any crash report if it uses %p and there is
anything wrong with the VM?

Yes, yes, it disables page faults, but that only means that we won't
go all the way into the generic VM. We'll still take the fauly, still
do vmalloc fault filling, still do a *lot* of potentially really
complicated things.

Guys, stop this idiocy. printk() needs to be *simple* and *reliable*, not fancy.

Plus, you just made %p be an excellent leak of some very sensitive
information, like "where is the kernel mapped" etc.

So not only did you make it fundamentally more complex and fragile,
you actually made it more of a potential security issue too.

> Below is my RFC patch.

NAK NAK NAK.

Seriously. Stop this crap. Get over yourself guys.

This whole NULL discussion has been one huge pile of unbelievable *SHIT*.

The first few bytes in the address space are special, because NULL
pointers are often offset by structure offsets.  They are special
because NULL is special.

THEY ARE NOT SPECIAL BECAUSE IT CAUSES FAULTS.

The top "small negative numbers" are special, because the kernel
extensively uses the ERR_PTR model, and that is how we encode it.

THEY ARE NOT SPECIAL BECAUSE THEY CAUSE FAULTS.

Thinking that "this address causes faults is special" is moronic.

Actually testing - in something as crore and critical as printk -
whether a fault happens is beyond the pale.

                   Linus
