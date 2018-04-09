Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753610AbeDISRO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 14:17:14 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38122 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752576AbeDISRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 14:17:13 -0400
X-Google-Smtp-Source: AIpwx4/TNbmu+D6FAf60h/Ji/I8a/tmoTgqB8eSG03Cg4ruENyx12iJqnFbeXXA3M5LT1r98ah9BFoekzY/JJEcrung=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLSbX-qYx2xWYrsPb-tUFcEhYG86MkhtJ3zMirBHtmurg@mail.gmail.com>
References: <alpine.LFD.2.21.1804061125390.1819@schleppi> <CAGXu5jKTtU3fvqP-ygV51WcOAmTkm=y5fysKNv+k0crhJACtVg@mail.gmail.com>
 <alpine.LFD.2.21.1804091809310.1698@schleppi> <CA+55aFw1MoQ=7=U6QCGXAAiCniMKy8_igxgc8sMLykSRcDk-0g@mail.gmail.com>
 <CA+55aFy1jJPX2fu7ce2Z7hxn49RaSghtnziwsyUU1Em5WEH2yw@mail.gmail.com> <CAGXu5jLSbX-qYx2xWYrsPb-tUFcEhYG86MkhtJ3zMirBHtmurg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Apr 2018 11:17:11 -0700
X-Google-Sender-Auth: 8wMahn2QzubulVYDY24lbbY_3Ms
Message-ID: <CA+55aFwHOTfcGcptyNhFyS_sO6RXrRhPedzXqKHRfrY05Xf1VQ@mail.gmail.com>
Subject: Re: [bisected] 3c8ba0d61d04ced9f8d9ff93977995a9e4e96e91 oopses on s390
To: Kees Cook <keescook@chromium.org>
Cc: Sebastian Ott <sebott@linux.ibm.com>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 9, 2018 at 11:00 AM, Kees Cook <keescook@chromium.org> wrote:
>
> Can we update the comment near the top to explain why we need
> __UNIQUE_ID() since we've now rediscovered why it was originally
> there?

Too late, since it's already committed in my tree and going through
the build test paces.

But I really hope somebody revisits __UNIQUE_ID, and maybe they can
then add a comment to the users too.

It looks like gcc needs at least version 4.3 to have a working
__COUNTER__ implementation. What a coincidence - we don't really
support anything older now anyway.

And similarly for clang - the only versions that didn't have it are
not able to build the kernel anyway.

So we should remove any version conditionals, and we should remove the
known-broken generic fallback that uses __LINE__ instead of
__COUNTER__.

And once you do that, the "prefix" is actually pointlessm and we could
drop it to make __UNIQUE_ID() easier to use.

The *REAL* problem, however, is that __UNIQUE_ID is such a pain to use
in general. You basically have two choices:

 - use it as a single-declaration throwaway variable name that is
never actually used

 - use it only in a wrapper macro that then passes it off as an
argument to another macro that uses it several times

That "throwaway" use sounds pointless, but it's actually the *common*
use we have for this thing outside of this min/max case. It's used to
shut up the compiler about other unused variables, where people do
things like

   static __unused__ __UNIQUE_ID(xyz) = .. mark other variable as used here ..;

and I think the reason it's common is that it's the only *easy* use of
that unique-name-generator macro. Having to pass it off to a second
macro to use as a variable name makes it cumbersome to use for most
normal macro cases.

It would be nice to have the equivalent of __COUNTER__ that just
expanded not to a continually increasing number, but expanded to a
number that expands for each macro expansion.

Then you could do things like

    int UNIQUE(a) = (a);

to generate a variable name that was unique within a particular macro
expansion, and then actually _use_ UNIQUE(a) in the same macro
expansion to refer to it without having to pass it off as a name to
another macro that does the declaration and use.

You can't use __UNIQUE_ID() for that, because every new __UNIQUE_ID(a)
will give _another_ unique ID.

(And you *could* use the __LINE__ based one for that, but then you'd
get the whole "nasty shadowing" problem if we have nested macros
again).

Ugh. We have no wonderful model for unique names. Which is why we
obviously just use the "add underscores until it's unique" and the get
it wrong with nesting.

                Linus
