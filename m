Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932370AbeCITFU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 14:05:20 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:53575 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932069AbeCITFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 14:05:18 -0500
X-Google-Smtp-Source: AG47ELua/jRm9xG809kkoqIICmTkPeZ87ZqmiLsHFAJRzUdE//LTKPzCeUX9joTJ+PBcOEONSvLXunAjcsgVKf6muck=
MIME-Version: 1.0
In-Reply-To: <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
References: <20180302125118.bjd3tbuu72vgfczo@pathway.suse.cz>
 <20180302125359.szbin2kznxvoq7sc@pathway.suse.cz> <CAKwiHFgTbFof34oc59OU3M1=-PTzstv0uxSmoiRc8TJPJPMHVw@mail.gmail.com>
 <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz> <1520330185.10722.401.camel@linux.intel.com>
 <20180307155244.b45c3fb5vcxb4q2l@pathway.suse.cz> <CA+55aFxr5eg_fWjyhcYFU4CSOoVP_GeB79cYa=8mUk7J1cUG7A@mail.gmail.com>
 <20180308141824.bfk2pr6wmjh4ytdi@pathway.suse.cz> <CA+55aFyDbr4JpiPoHXq=3wJu+WVCLZPpAVsmY=5HVStawmEiRw@mail.gmail.com>
 <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com> <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Mar 2018 11:05:17 -0800
X-Google-Sender-Auth: hspr7qBn9GJHEtRDBiw-Hhmqats
Message-ID: <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
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

On Fri, Mar 9, 2018 at 7:01 AM, Petr Mladek <pmladek@suse.com> wrote:
> Also it makes the handling unified. We print:
>
>    + (null) when pure NULL pointer is dereferenced
>    + (efault) when an invalid address is dereferenced
>    + pointer address otherwise

This is still fundamentally completely wrong.

It never prints "pointer address", and if it were to do that, it would be wrong.

It should never ever trigger for an address operation, only for the
"we will get _data_ from the ponter".

The strchr thing is also completely broken, and in a very subtle way.
"strchr(string, 0)" is special, and the Open Group states

  "The terminating null byte is considered to be part of the string"

so a NUL character will *always* return success, which is actually
completely wrong for this case, because now it does that whole crazy
<efault> thing for %p that it shouldn't do.

Not that I actually verified that our strchr() follows the actual
rules anyway - I personally consider "strchr(string, 0)" to not really
be "special", but be a bug. Either way, the comment is wrong, but the
code is also wrong.

                 Linus
