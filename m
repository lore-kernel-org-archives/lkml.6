Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbeCTXIf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 19:08:35 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:46795 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeCTXIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 19:08:31 -0400
X-Google-Smtp-Source: AG47ELvqnJ8xuLjM7axzIoLCndJl2xS6lQmwsif2KmAdWfux33qQSdCFypnGIWONbKTYKBF7gNIgmSPm/VR/qqXafCs=
MIME-Version: 1.0
In-Reply-To: <1521584015.31174.3.camel@med.uni-goettingen.de>
References: <1521584015.31174.3.camel@med.uni-goettingen.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Mar 2018 16:08:30 -0700
X-Google-Sender-Auth: sB4_xBlt8i44gtj48qnNbkvuQhc
Message-ID: <CA+55aFyRgq7hbmxK9471xY-eja4X=gKHSjF4Q+a0FJjxVB1TYQ@mail.gmail.com>
Subject: Re: detecting integer constant expressions in macros
To: "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 3:13 PM, Uecker, Martin
<Martin.Uecker@med.uni-goettingen.de> wrote:
>
> here is an idea:

That's not "an idea".

That is either genius, or a seriously diseased mind.

I can't quite tell which.

> a test for integer constant expressions which returns an
> integer constant expression itself which should be suitable
> for passing to __builtin_choose_expr might be:
>
> #define ICE_P(x) (sizeof(int) == sizeof(*(1 ? ((void*)((x) * 0l)) : (int*)1)))

Ok, so I can see that (void *)((x)*0l)) turns into NULL when x is an
ICE. Fine. So with a constant, we have

   sizeof( 1 ? NULL : (int *) 1)

and the rule is that if one of the sides of a ternary operation with
pointers is NULL, the end result is the other type (int *).

So yes, the above returns 'sizeof(int)'.

And if it is *not* an ICE that first pointer is still of type '(void
*)', but it is not NULL.

And yes, the type conversion rules for a ternary op with two non-NULL
pointers is different,  and it now returns "void *".

So now the end result is (sizeof(*(void *)(x)), which on gcc is
generally *different* from 'int'.

So I see two issues:

 - "sizeof(*(void *)1)" is not necessalily well-defined. For gcc it is
1. But it could cause warnings.

 - this will break the minds of everybody who ever sees that expression.

Those two issues might be fine, though.

> This also does not evaluate x itself on gcc although this is
> not guaranteed by the standard. (And I haven't tried any older
> gcc.)

Oh, I think it's guaranteed by the standard that 'sizeof()' doesn't
evaluate the argument value, only the type.

I'm in awe of your truly marvelously disgusting hack. That is truly a
work of art.

I'm sure it doesn't work or causes warnings for various reasons, but
it's still a thing of beaty.

              Linus
