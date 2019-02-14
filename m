Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84461C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545E92075C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404687AbfBNONy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:13:54 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:23258 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393613AbfBNONy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:13:54 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-58-cS1Xal03PAGXnZoPo9IHMA-1; Thu, 14 Feb 2019 14:13:51 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 14 Feb 2019 14:14:34 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 14 Feb 2019 14:14:34 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH] ARC: Explicitly set ARCH_SLAB_MINALIGN = 8
Thread-Topic: [PATCH] ARC: Explicitly set ARCH_SLAB_MINALIGN = 8
Thread-Index: AQHUwvc8KjF6Xlwy10OvbYFx5kwo16XcaZhggAK74naAADJoAA==
Date:   Thu, 14 Feb 2019 14:14:34 +0000
Message-ID: <3b9d2eadfc81422caa0292c7ef1684f1@AcuMS.aculab.com>
References: <20190208105519.26750-1-abrodkin@synopsys.com>
 <81017fe4-b31f-4942-e822-a7b70008b74d@synopsys.com>
 <f83412d1e7fd4d67b4632c1f81fae963@AcuMS.aculab.com>
 <bfc65835-21f9-6d5e-791d-ee49113d939c@synopsys.com>
 <20190213125651.GP32494@hirez.programming.kicks-ass.net>
 <e6138aeb-9ce4-fbfa-4d6a-b76f189a3e47@synopsys.com>
 <20190214103140.GG32494@hirez.programming.kicks-ass.net>
 <4881796E12491D4BB15146FE0209CE64681DB122@DE02WEMBXB.internal.synopsys.com>
 <20190214110813.GK32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190214110813.GK32494@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: cS1Xal03PAGXnZoPo9IHMA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 14 February 2019 11:08
> On Thu, Feb 14, 2019 at 10:44:49AM +0000, Alexey Brodkin wrote:
> > > On Wed, Feb 13, 2019 at 03:23:36PM -0800, Vineet Gupta wrote:
> > > > On 2/13/19 4:56 AM, Peter Zijlstra wrote:
> > > > >
> > > > > Personally I think u64 and company should already force natural
> > > > > alignment; but alas.
> > > >
> > > > But there is an ISA/ABI angle here too. e.g. On 32-bit ARC, LDD (load double) is
> > > > allowed to take a 32-bit aligned address to load a register pair. Thus all u64
> > > > need not be 64-bit aligned (unless attribute aligned 8 etc) hence the relaxation
> > > > in ABI (alignment of long long is 4). You could certainly argue that we end up
> > > > undoing some of it anyways by defining things like ARCH_KMALLOC_MINALIGN to 8, but
> > > > still...
> > >
> > > So what happens if the data is then split across two cachelines; will a
> > > STD vs LDD still be single-copy-atomic? I don't _think_ we rely on that
> > > for > sizeof(unsigned long), with the obvious exception of atomic64_t,
> > > but yuck...
> >
> > STD & LDD are simple store/load instructions so there's no problem for
> > their 64-bit data to be from 2 subsequent cache lines as well as 2 pages
> > (if we're that unlucky). Or you mean something else?
> 
> u64 x;
> 
> WRITE_ONCE(x, 0x1111111100000000);
> WRITE_ONCE(x, 0x0000000011111111);
> 
> vs
> 
> t = READ_ONCE(x);
> 
> is t allowed to be 0x1111111111111111 ?
> 
> If the data is split between two cachelines, the hardware must do
> something very funny to avoid that.

Never mind cachelines, think about separate pages.
You'd have to 'lock' both TLB before doing either access.
Not to mention the fact that the two physical locations could be
on entirely different memory cards (or whatever).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

