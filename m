Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0C5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9E020856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9E020856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbeGXOiq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:38:46 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:21818 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388321AbeGXOip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:38:45 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-146-LRpw1op3NzGtioWc_5wF_g-1; Tue, 24 Jul 2018 14:32:13 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 24 Jul 2018 14:33:52 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 24 Jul 2018 14:33:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Coly Li' <colyli@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Lyle <mlyle@lyle.org>,
        "Kent Overstreet" <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        Eric Biggers <ebiggers3@gmail.com>
Subject: RE: [PATCH v3 1/3] lib: add crc64 calculation routines
Thread-Topic: [PATCH v3 1/3] lib: add crc64 calculation routines
Thread-Index: AQHUHd56Kh2dY2MEf0SFas4KUCk7F6SeZsQg
Date:   Tue, 24 Jul 2018 13:33:52 +0000
Message-ID: <86570dc992b64bd5a9df0898e10ce643@AcuMS.aculab.com>
References: <20180717145525.50852-1-colyli@suse.de>
 <20180717145525.50852-2-colyli@suse.de>
In-Reply-To: <20180717145525.50852-2-colyli@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: LRpw1op3NzGtioWc_5wF_g-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coly Li
> Sent: 17 July 2018 15:55
> 
> This patch adds the re-write crc64 calculation routines for Linux kernel.
> The CRC64 polynomical arithmetic follows ECMA-182 specification, inspired
> by CRC paper of Dr. Ross N. Williams
> (see http://www.ross.net/crc/download/crc_v3.txt) and other public domain
> implementations.
> 
> All the changes work in this way,
> - When Linux kernel is built, host program lib/gen_crc64table.c will be
>   compiled to lib/gen_crc64table and executed.

That seems excessive for a fixed table.
No real point doing more than putting a commented out copy of the code
with the initialisation data.

> - The output of gen_crc64table execution is an array called as lookup
>   table (a.k.a POLY 0x42f0e1eba9ea369) which contain 256 64bits-long
>   numbers, this talbe is dumped into header file lib/crc64table.h.
> - Then the header file is included by lib/crc64.c for normal 64bit crc
>   calculation.

How long are the buffers being processed?
For short buffers a lot of bytes will suffer cache line misses.
For longer buffers you'll be displacing 2k of data from the L1 data cache.
That could easily have a knock on effect on the surrounding code.

You might find that a nibble based loop and lookup table is faster.
Or, relying on the linearity of CRCs, separate lookup tables
for the high and low nibbles of each byte.

So replacing:
		crc = crc64table[t] ^ (crc << 8);
with:
		crc = crc64table_hi[t >> 4] ^ crc64table_lo[t & 15] ^ (crc << 8);

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

