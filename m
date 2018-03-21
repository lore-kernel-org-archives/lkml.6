Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbeCUASD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 20:18:03 -0400
Received: from mail1.med.uni-goettingen.de ([134.76.103.230]:29598 "EHLO
        mail1.med.uni-goettingen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751018AbeCUASC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 20:18:02 -0400
From: "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: detecting integer constant expressions in macros
Thread-Topic: detecting integer constant expressions in macros
Thread-Index: AQHTwJiwGR/EgJUmakKV29wYTwhXcaPZrsMAgAARXwA=
Date: Wed, 21 Mar 2018 00:10:40 +0000
Message-ID: <1521591040.508.2.camel@med.uni-goettingen.de>
References: <1521584015.31174.3.camel@med.uni-goettingen.de>
         <CA+55aFyRgq7hbmxK9471xY-eja4X=gKHSjF4Q+a0FJjxVB1TYQ@mail.gmail.com>
In-Reply-To: <CA+55aFyRgq7hbmxK9471xY-eja4X=gKHSjF4Q+a0FJjxVB1TYQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.76.125.21]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7CB0D15B9A9A244ACE02B4025E1B5CD@ads.local.med.uni-goettingen.de>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2L0IBeU019046



Am Dienstag, den 20.03.2018, 16:08 -0700 schrieb Linus Torvalds:
> On Tue, Mar 20, 2018 at 3:13 PM, Uecker, Martin
> <Martin.Uecker@med.uni-goettingen.de> wrote:
> > 
> > here is an idea:
> 
> That's not "an idea".
> 
> That is either genius, or a seriously diseased mind.
> 
> I can't quite tell which.
> 
> > a test for integer constant expressions which returns an
> > integer constant expression itself which should be suitable
> > for passing to __builtin_choose_expr might be:
> > 
> > #define ICE_P(x) (sizeof(int) == sizeof(*(1 ? ((void*)((x) * 0l)) :
> > (int*)1)))

...
> So now the end result is (sizeof(*(void *)(x)), which on gcc is
> generally *different* from 'int'.
> 
> So I see two issues:
> 
>  - "sizeof(*(void *)1)" is not necessalily well-defined. For gcc it
> is
> 1. But it could cause warnings.

It is a documented extension which enables pointer arithmetic
on void pointers, so I am sure neither gcc nor
clang has any problem with it. But one could also use
__builtin_types_compatible_p instead.

>  - this will break the minds of everybody who ever sees that
> expression.
>
> Those two issues might be fine, though.
> 
> > This also does not evaluate x itself on gcc although this is
> > not guaranteed by the standard. (And I haven't tried any older
> > gcc.)
> 
> Oh, I think it's guaranteed by the standard that 'sizeof()' doesn't
> evaluate the argument value, only the type.

It has to evaluate the expression for the length of an array,
but it is not specified whether this is done if it does not have
any effect on the result. I would assume that any sane compiler
does not.

> I'm in awe of your truly marvelously disgusting hack. That is truly a
> work of art.
> 
> I'm sure it doesn't work or causes warnings for various reasons, but
> it's still a thing of beaty.

I thought you might like it ;-)

Martin
 
