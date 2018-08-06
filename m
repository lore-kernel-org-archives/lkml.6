Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B52C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5D0219F4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5D0219F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbeHFMZW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:25:22 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([146.101.78.211]:45217 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726699AbeHFMZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:25:21 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-143-X99eNT_KMRCVOQycZ9ycPQ-1; Mon, 06 Aug 2018 11:16:54 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 6 Aug 2018 11:18:33 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 6 Aug 2018 11:18:33 +0100
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
        "Russell King" <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: RE: framebuffer corruption due to overlapping stp instructions on
 arm64
Thread-Topic: framebuffer corruption due to overlapping stp instructions on
 arm64
Thread-Index: AQHUKwzKyzS7gP0u+Em6lFS72D3AkaSt4YCg///76QCAACCeQIADLl6AgAFULpA=
Date:   Mon, 6 Aug 2018 10:18:33 +0000
Message-ID: <51a6c4e102ad4193b3f42498f0ff11a4@AcuMS.aculab.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <f696ebe8605840e3bb04bb78b60a6cfa@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808030759480.12341@file01.intranet.prod.int.rdu2.redhat.com>
 <a1564e8d091648bcad9b5ec58ab6cc95@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808051018360.23136@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1808051018360.23136@file01.intranet.prod.int.rdu2.redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: X99eNT_KMRCVOQycZ9ycPQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka
> Sent: 05 August 2018 15:36
> To: David Laight
...
> There's an instruction movntdqa (and vmovntdqa) that can actually do
> prefetch on write-combining memory type. It's the only instruction that
> can do it.
> 
> It this instruction is used on non-write-combining memory type, it behaves
> like movdqa.
> 
...
> I benchmarked it on a processor with ERMS - for writes to the framebuffer,
> there's no difference between memcpy, 8-byte writes, rep stosb, rep stosq,
> mmx, sse, avx - all this method achieve 16-17 GB/s

The combination of write-combining, posted writes and a fast PCIe slave
are probably why there is little difference.

> For reading from the framebuffer:
>  323 MB/s - memcpy (using avx2)
>   91 MB/s - explicit 8-byte reads
>  249 MB/s - rep movsq
>  307 MB/s - rep movsb

You must be getting the ERMS hardware optimised 'rep movsb'.

>   90 MB/s - mmx
>  176 MB/s - sse
> 4750 MB/s - sse movntdqa
>  330 MB/s - avx

avx512 is probably faster still.

> 5369 MB/s - avx vmovntdqa
> 
> So - it may make sense to introduce a function memcpy_from_framebuffer()
> that uses movntdqa or vmovntdqa on CPUs that support it.

For kernel space it ought to be just memcpy_fromio().

Can you easily repeat the tests using a non-write-combining map of the
same PCIe slave?

I can probably run the same measurements against our rather leisurely
FPGA based PCIe slave.
IIRC PCIe reads happen every 128 clocks of the cards 62.5MHz clock,
increasing the size of the registers makes a significant different.
I've not tried mapping write-combining and using (v)movntdaq.
I'm not sure what effect write-combining would have if the whole BAR
were mapped that way - so I'll either have to map the physical addresses
twice or add in another BAR.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

