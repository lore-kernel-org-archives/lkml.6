Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbeCUJwD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 05:52:03 -0400
Received: from mail1.med.uni-goettingen.de ([134.76.103.230]:32138 "EHLO
        mail1.med.uni-goettingen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751464AbeCUJwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 05:52:00 -0400
From: "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: detecting integer constant expressions in macros
Thread-Topic: detecting integer constant expressions in macros
Thread-Index: AQHTwJiwGR/EgJUmakKV29wYTwhXcaPZrsMAgAARXwCAAAWUAIAAnNEA
Date: Wed, 21 Mar 2018 09:51:55 +0000
Message-ID: <1521625914.3034.1.camel@med.uni-goettingen.de>
References: <1521584015.31174.3.camel@med.uni-goettingen.de>
         <CA+55aFyRgq7hbmxK9471xY-eja4X=gKHSjF4Q+a0FJjxVB1TYQ@mail.gmail.com>
         <1521591040.508.2.camel@med.uni-goettingen.de>
         <CA+55aFyfW7kA_72vNifyxBV7gc_fkKjVC3j1WBJzx1R3GpApOQ@mail.gmail.com>
In-Reply-To: <CA+55aFyfW7kA_72vNifyxBV7gc_fkKjVC3j1WBJzx1R3GpApOQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.76.125.21]
Content-Type: text/plain; charset="utf-8"
Content-ID: <266536CD73102A4B9776A31B3D435A48@ads.local.med.uni-goettingen.de>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2L9q9a0029159



Am Dienstag, den 20.03.2018, 17:30 -0700 schrieb Linus Torvalds:
> On Tue, Mar 20, 2018 at 5:10 PM, Uecker, Martin
> <Martin.Uecker@med.uni-goettingen.de> wrote:

> 
> > But one could also use __builtin_types_compatible_p instead.
> 
> That might be the right approach, even if I like how it only used
> standard C (although _disgusting_ standard C) without it apart from
> the small issue of sizeof(void)
> 
> So something like
> 
>   #define __is_constant(a) \
>         __builtin_types_compatible_p(int *, typeof(1 ? ((void*)((a) *
> 0l)) : (int*)1 ) )
> 
> if I counted the parentheses right..

This seems to work fine on all recent compilers. Sadly, it
produces false positives on 4.4.7 and earlier when
tested on godbolt.org

Surprisingly, the MAX macro as defined below still seems
to do the right thing with respect to avoiding the VLA
even on the old compilers.

I am probably missing something... or there are two
compiler bugs cancelling out, or the __builting_choose_expr
changes things.

Martin

My test code:

#define ICE_P(x) (__builtin_types_compatible_p(int*, __typeof__(1 ?
((void*)((x) * 0l)) : (int*)1)))

#define SIMPLE_MAX(a, b) ((a) > (b) ? (a) : (b))
#define SAFE_MAX(a, b) ({ __typeof(a) _a = (a); __typeof(b) _b = (b);
SIMPLE_MAX(_a, _b); })
#define MAX(a, b) (__builtin_choose_expr(ICE_P(a) && ICE_P(b),
SIMPLE_MAX(a, b), SAFE_MAX(a, b)))



int foo(int x)
{
    int a[MAX(3, 4)];
    //int a[MAX(3, x)];
    //int a[SAFE_MAX(3, 4)];
    //return ICE_P(MAX(3, 4));
    return ICE_P(MAX(3, x));
}
