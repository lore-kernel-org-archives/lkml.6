Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752951AbeCPBfN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 21:35:13 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33785 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbeCPBfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 21:35:11 -0400
X-Google-Smtp-Source: AG47ELvuad34VmvnZjU1Se6jFY3RZHGPJWBmdY02G9NhyzPagdwrVi6H+iUtwVoG5UiobCYnB53Gm3McvchUpBq43FE=
MIME-Version: 1.0
In-Reply-To: <20180316011852.GA5139@jagdpanzerIV>
References: <CA+55aFxr5eg_fWjyhcYFU4CSOoVP_GeB79cYa=8mUk7J1cUG7A@mail.gmail.com>
 <20180308141824.bfk2pr6wmjh4ytdi@pathway.suse.cz> <CA+55aFyDbr4JpiPoHXq=3wJu+WVCLZPpAVsmY=5HVStawmEiRw@mail.gmail.com>
 <CA+55aFwaNTC2HV9ERDFWCrmhvgZ58SKMM+ik9Ypr3i-ZUyU6Fw@mail.gmail.com>
 <20180309150153.3sxbbpd6jdn2d5yy@pathway.suse.cz> <CA+55aFwT-Vd+sVdAVemUjUvkNYFiLyVMHZxv9hF6KzRM7i4Yrg@mail.gmail.com>
 <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz> <20180315075842.GD3628@jagdpanzerIV>
 <20180315080309.GF3628@jagdpanzerIV> <20180315130117.7c2fb761@vmware.local.home>
 <20180316011852.GA5139@jagdpanzerIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Mar 2018 18:35:10 -0700
X-Google-Sender-Auth: b3pTiEnrgFPYNabF4yJCJbDEOO4
Message-ID: <CA+55aFzLQvPCB-A2ZN9h86pBDbNC1RXwzB=URRKFcJpXFzanig@mail.gmail.com>
Subject: Re: [PATCH v3] vsprintf: Prevent crash when dereferencing invalid pointers
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 6:18 PM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> Hm, may be sizeof(ptr) still won't suffice. It would be great if we
> could always look at spec.field_width, which can be up to 2 * sizeof(void *),
> and then just probe_kernel_read(spec.field_width). E.g., %b/%bl prints out a
> bitmap, accessing max_t(int, spec.field_width, 0) bits, which is good. But,
> for instance, %U (uuid printout) doesn't look at spec.field_width, and reads
> in 16 bytes from the given memory address. Then we have ipv4/ipv6, mac, etc.
> So I think that checking just 1 byte or sizeof(ptr) is not really enough if
> we want to fix vsprintf. What do you think?

Honestly, I think it would be better to move the whole logic to the
functions that actually do the printout.

Then you can do it right, and you don't need to have the strchr() either.

There really isn't any commonality between the different versions.
field_width is meaningless, since it's about the size of the _printed_
field, not the size in memory.

Would it be a few more lines? Yes. But it would also clarify the code
and get all the cases right. Look at hex_string() for example, and
imagine fetching a byte at a time and just getting the corner cases
automatically right.

And if you don't care, just do a

       const char *err = check_pointer_access(ptr);
       if (err)
                return string(buf, end, err, spec);

at the top of each function that dereferences things. Some of them
already have the equivalent of that (the afore-mentioned hex_string:

        if (ZERO_OR_NULL_PTR(addr))
                /* NULL pointer */
                return string(buf, end, NULL, spec);

and it certainly is neither a lot of extra code, nor subtle or complex
to just do that (except using "err = check_pointer_access(ptr);").

               Linus
