Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0729FC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13532174B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13532174B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389515AbeHGQq5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:46:57 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:52846 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388135AbeHGQq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:46:57 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-2-4PAP4CJSMfqkTcK2s-crIw-1; Tue, 07 Aug 2018 15:32:19 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 7 Aug 2018 15:33:58 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 7 Aug 2018 15:33:58 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mikulas Patocka' <mpatocka@redhat.com>
CC:     'Ard Biesheuvel' <ard.biesheuvel@linaro.org>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Thomas Petazzoni" <thomas.petazzoni@free-electrons.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Andrew Pinski <pinskia@gmail.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: RE: framebuffer corruption due to overlapping stp instructions on
 arm64
Thread-Topic: framebuffer corruption due to overlapping stp instructions on
 arm64
Thread-Index: AQHUKwzKyzS7gP0u+Em6lFS72D3AkaSt4YCg///76QCAACCeQIADLl6AgAFULpCAAciCAIAAEszQ
Date:   Tue, 7 Aug 2018 14:33:58 +0000
Message-ID: <5f5ab5ba0bc84b31be52bd7708c6a356@AcuMS.aculab.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <f696ebe8605840e3bb04bb78b60a6cfa@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808030759480.12341@file01.intranet.prod.int.rdu2.redhat.com>
 <a1564e8d091648bcad9b5ec58ab6cc95@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808051018360.23136@file01.intranet.prod.int.rdu2.redhat.com>
 <51a6c4e102ad4193b3f42498f0ff11a4@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808070939320.6020@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1808070939320.6020@file01.intranet.prod.int.rdu2.redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: 4PAP4CJSMfqkTcK2s-crIw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka
> Sent: 07 August 2018 15:07
...
> Unaccelerated scrolling is still painfully slow
> even on modern computers because of slow framebuffer read.

I solved that many years ago on a strongarm system by mapping
the screen memory at two separate virtual addresses.
One uncached used for writes, the second cached using the
'minicache' for reads.
(and immediately fell foul of a memcpy() function that compared
the two virtual addresses and decided to copy backwards)

I suspect some modern cpus don't like you doing that and the
graphics 'drivers' won't use different mappings.

Even in glibc you want a more general copy_to/from_io_memory()
rather than just 'copy_from_framebuffer()'.
Best to define both - even if they end up identical.
Other drivers allow PCIe space be mmap()ed into user space.

While your tests show vmovntdqa being slightly slower than an
avx read for uncached mappings it is still much better than
all the other options.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

