Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C58C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F342146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F342146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeK3XhB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:37:01 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:38840 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726549AbeK3XhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:37:01 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-144-4qFN5sBKP82d6eOpE1nuuw-1; Fri, 30 Nov 2018 12:27:50 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri,
 30 Nov 2018 12:27:58 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 30 Nov 2018 12:27:58 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dave Rodgman' <dave.rodgman@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        nd <nd@arm.com>
Subject: RE: [PATCH 2/8] lib/lzo: clean-up by introducing COPY16
Thread-Topic: [PATCH 2/8] lib/lzo: clean-up by introducing COPY16
Thread-Index: AQHUiKKcsNRVxoInU0ado7SP4WwMWKVoPj+w
Date:   Fri, 30 Nov 2018 12:27:58 +0000
Message-ID: <ccb719dd52354cfab8def75689d675af@AcuMS.aculab.com>
References: <20181130114715.27523-1-dave.rodgman@arm.com>
 <20181130114715.27523-3-dave.rodgman@arm.com>
In-Reply-To: <20181130114715.27523-3-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 4qFN5sBKP82d6eOpE1nuuw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Rodgman
> Sent: 30 November 2018 11:48
> From: Matt Sealey <matt.sealey@arm.com>
> 
> Most compilers should be able to merge adjacent loads/stores of sizes
> which are less than but effect a multiple of a machine word size (in
> effect a memcpy() of a constant amount). However the semantics of the
> macro are that it just does the copy, the pointer increment is in the
> code, hence we see
> 
>     *a = *b
>     a += 8
>     b += 8
>     *a = *b
>     a += 8
>     b += 8
> 
> This introduces a dependency between the two groups of statements which
> seems to defeat said compiler optimizers and generate some very strange
> sequences of addition and subtraction of address offsets (i.e. it is
> overcomplicated).
> 
> Since COPY8 is only ever used to copy amounts of 16 bytes (in pairs),
> just define COPY16 as COPY8,COPY8. We leave the definition to preserve
> the need to do unaligned accesses to machine-sized words per the
> original code intent, we just don't use it in the code proper.
> 
> COPY16 then gives us code like:
> 
>     *a = *b
>     *(a+8) = *(b+8)
>     a += 16
>     b += 16

You probably actually want:
	t1 = *b;
	t2 = *(b+8);
	*a = t1;
	*(a+8) = t2;
	a += 16;
	b += 16;

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

