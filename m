Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbeCUKfF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 06:35:05 -0400
Received: from smtp-out4.electric.net ([192.162.216.184]:51143 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeCUKfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 06:35:04 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Uecker, Martin'" <Martin.Uecker@med.uni-goettingen.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: detecting integer constant expressions in macros
Thread-Topic: detecting integer constant expressions in macros
Thread-Index: AQHTwJiwGR/EgJUmakKV29wYTwhXcaPZrsMAgAARXwCAAAWUAIAAnNEAgAAIcgCAABNMwA==
Date: Wed, 21 Mar 2018 10:35:58 +0000
Message-ID: <a930db420e404d15a6c4435ac182911a@AcuMS.aculab.com>
References: <1521584015.31174.3.camel@med.uni-goettingen.de>
         <CA+55aFyRgq7hbmxK9471xY-eja4X=gKHSjF4Q+a0FJjxVB1TYQ@mail.gmail.com>
         <1521591040.508.2.camel@med.uni-goettingen.de>
         <CA+55aFyfW7kA_72vNifyxBV7gc_fkKjVC3j1WBJzx1R3GpApOQ@mail.gmail.com>
         <1521625914.3034.1.camel@med.uni-goettingen.de>
 <1521627728.3354.1.camel@med.uni-goettingen.de>
In-Reply-To: <1521627728.3354.1.camel@med.uni-goettingen.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2LAZD2K029413

From: Uecker, Martin
> Sent: 21 March 2018 10:22
> Am Mittwoch, den 21.03.2018, 10:51 +0100 schrieb Martin Uecker:
> >
> > Am Dienstag, den 20.03.2018, 17:30 -0700 schrieb Linus Torvalds:
> > > On Tue, Mar 20, 2018 at 5:10 PM, Uecker, Martin
> > > <Martin.Uecker@med.uni-goettingen.de> wrote:
> > >
> > > > But one could also use __builtin_types_compatible_p instead.
> > >
> > > That might be the right approach, even if I like how it only used
> > > standard C (although _disgusting_ standard C) without it apart from
> > > the small issue of sizeof(void)
> > >
> > > So something like
> > >
> > >   #define __is_constant(a) \
> > >         __builtin_types_compatible_p(int *, typeof(1 ? ((void*)((a) * 0l)) : (int*)1 ) )
> > >
> > > if I counted the parentheses right..
> >
> > This seems to work fine on all recent compilers. Sadly, it
> > produces false positives on 4.4.7 and earlier when
> > tested on godbolt.org
> >
> > Surprisingly, the MAX macro as defined below still seems
> > to do the right thing with respect to avoiding the VLA
> > even on the old compilers.
> >
> > I am probably missing something... or there are two
> > compiler bugs cancelling out, or the __builting_choose_expr
> > changes things.
> 
> Nevermind, of course it avoids the VLA if it produces a false
> positive and uses the simple version. So it is unsafe to use
> on very old compilers.

False positives with old compilers don't matter when max() is being used
for an on-stack array.
The compilations with a new compiler will detect real VLA, the old compiler
will generate valid code with a constant sized VLA.

OTOH these horrid:
	long buf[max(sizeof (struct foo), sizeof (struct bar)) + 7 / 8];
would be better replaced with:
	union buf { struct foo foo; struct bar bar; };

	David
