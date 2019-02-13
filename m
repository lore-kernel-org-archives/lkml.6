Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9F0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF4D222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391920AbfBMONd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:13:33 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:56373 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728416AbfBMONc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:13:32 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-110-WxTaH3GeMhar7JZtKQUZtw-1; Wed, 13 Feb 2019 14:12:56 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 13 Feb 2019 14:13:08 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 13 Feb 2019 14:13:08 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>
CC:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH] ARC: Explicitly set ARCH_SLAB_MINALIGN = 8
Thread-Topic: [PATCH] ARC: Explicitly set ARCH_SLAB_MINALIGN = 8
Thread-Index: AQHUwvc8KjF6Xlwy10OvbYFx5kwo16XcaZhggAFH5CCAABKpkA==
Date:   Wed, 13 Feb 2019 14:13:08 +0000
Message-ID: <536eb8d0112b44dc90b9b9a7f670e96d@AcuMS.aculab.com>
References: <20190208105519.26750-1-abrodkin@synopsys.com>
 <81017fe4-b31f-4942-e822-a7b70008b74d@synopsys.com>
 <f83412d1e7fd4d67b4632c1f81fae963@AcuMS.aculab.com>
 <bfc65835-21f9-6d5e-791d-ee49113d939c@synopsys.com>
 <20190213125651.GP32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190213125651.GP32494@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: WxTaH3GeMhar7JZtKQUZtw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra 
> Sent: 13 February 2019 12:57
...
...
> In the past I've proposed a GCC plugin / checker that would verify the
> alignment requirements against the various allocators.
> 
> For instance:
> 
> struct foo {
> 	spinlock_t a;
> 	int b;
> } __cacheline_aligned;
> 
> struct foo *my_foo = kmalloc(sizeof(struct foo), GFP_KERNEL);
> 
> would result in a warning; because obviously kmalloc (as per
> ARCH_SLAB_MINALIGN) doesn't respect the cacheline alignment of the type.
> 
> Of course; it appears our kmalloc() function definition doesn't even
> have a __malloc attribute, so there's plenty work to be done here.

We could pass the alignment to the allocator by defining something like:

#define do_malloc(x) ((x) = (typeof(*(x)))_do_malloc(sizeof *(x), __alignof__(*(x))))

Although you probably want to compile-time detect alignments that are smaller
than the normal minimal alignment.

If the allocator needs to add a header it would need to use the byte before
the allocated item to find the header.
OTOH adding a header is horrid for page-sized items.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

