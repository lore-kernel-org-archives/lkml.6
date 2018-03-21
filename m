Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbeCUAal (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 20:30:41 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:45254 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeCUAaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 20:30:39 -0400
X-Google-Smtp-Source: AG47ELvACKOgvzlNoHdb+f7KejRP0nHLrRz08To6aLBq+qYytKOgw5/dTsoFoBXyYjSv4C4YcHtTLQHwi40Ny6gBe3w=
MIME-Version: 1.0
In-Reply-To: <1521591040.508.2.camel@med.uni-goettingen.de>
References: <1521584015.31174.3.camel@med.uni-goettingen.de>
 <CA+55aFyRgq7hbmxK9471xY-eja4X=gKHSjF4Q+a0FJjxVB1TYQ@mail.gmail.com> <1521591040.508.2.camel@med.uni-goettingen.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Mar 2018 17:30:38 -0700
X-Google-Sender-Auth: cLLzlYIhB1jKascG09zi2uGfjPY
Message-ID: <CA+55aFyfW7kA_72vNifyxBV7gc_fkKjVC3j1WBJzx1R3GpApOQ@mail.gmail.com>
Subject: Re: detecting integer constant expressions in macros
To: "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 5:10 PM, Uecker, Martin
<Martin.Uecker@med.uni-goettingen.de> wrote:
>
>>
>> So I see two issues:
>>
>>  - "sizeof(*(void *)1)" is not necessalily well-defined. For gcc it
>> is
>> 1. But it could cause warnings.
>
> It is a documented extension which enables pointer arithmetic
> on void pointers, so I am sure neither gcc nor
> clang has any problem with it.

Well, so sparse does the whole "void pointer arithmetic" thing too,
but sparse actually complains about use of sizeof(void).

We could remove that warning, though. But:

> But one could also use __builtin_types_compatible_p instead.

That might be the right approach, even if I like how it only used
standard C (although _disgusting_ standard C) without it apart from
the small issue of sizeof(void)

So something like

  #define __is_constant(a) \
        __builtin_types_compatible_p(int *, typeof(1 ? ((void*)((a) *
0l)) : (int*)1 ) )

if I counted the parentheses right..

              Linus
