Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AD3C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8CB205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8CB205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388567AbeGXMKU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:10:20 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:40846 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388323AbeGXMKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:10:19 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-114-FMGZPDB4NqqEMq9DHmIxhA-1; Tue, 24 Jul 2018 12:04:20 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 24 Jul 2018 12:05:59 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 24 Jul 2018 12:05:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Krzysztof Kozlowski' <krzk@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Eric Biggers <ebiggers3@gmail.com>
Subject: RE: [PATCH] net: ethernet: fs-enet: Use generic CRC32 implementation
Thread-Topic: [PATCH] net: ethernet: fs-enet: Use generic CRC32 implementation
Thread-Index: AQHUIqFaRp0U1GGAv0+osEvb8ATmgqSeNinQ
Date:   Tue, 24 Jul 2018 11:05:59 +0000
Message-ID: <5ef968e1cb2a473cad97f6bfead369ca@AcuMS.aculab.com>
References: <20180723162020.6221-1-krzk@kernel.org>
In-Reply-To: <20180723162020.6221-1-krzk@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: FMGZPDB4NqqEMq9DHmIxhA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski
> Sent: 23 July 2018 17:20
> Use generic kernel CRC32 implementation because it:
> 1. Should be faster (uses lookup tables),

Are you sure?
The lookup tables are unlikely to be in the data cache and
the 6 cache misses kill performance.
(Not that it particularly matters when setting up multicast hash tables).

> 2. Removes duplicated CRC generation code,
> 3. Uses well-proven algorithm instead of coding it one more time.
...
> 
> Not tested on hardware.

Have you verified that the old and new functions give the
same result for a few mac addresses?
It is very easy to use the wrong bits in crc calculations
or generate the output in the wrong bit order.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

