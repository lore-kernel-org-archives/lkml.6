Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F72DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEF220989
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfAGJzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:55:11 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:47634 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726549AbfAGJzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:55:09 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-119-lHYb6N7aO8u2suev8LZbGg-1; Mon, 07 Jan 2019 09:55:05 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 7 Jan 2019 09:55:32 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 7 Jan 2019 09:55:32 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     Andrew Lutomirski <luto@kernel.org>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH] x86: only use ERMS for user copies for larger sizes
Thread-Topic: [PATCH] x86: only use ERMS for user copies for larger sizes
Thread-Index: AQHUgaBY0KBBfG3q00apJLDxEV5GB6VcD8pwgAAXuEiAAPNRcIAAB5wwgABvjYCABE4VAIA+XC8AgAOb8vA=
Date:   Mon, 7 Jan 2019 09:55:32 +0000
Message-ID: <dbb32dfaebee4bcb8ec3372bc7a27032@AcuMS.aculab.com>
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com>
 <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <26eff539-7de7-784c-0c88-f1d30753299d@redhat.com>
 <7ea44458b90b4d41a08ba9012818d273@AcuMS.aculab.com>
 <CAHk-=wjLNuNpHRfuVTb6awstC9OOmSb3S8aP51ufep-Th4dXKw@mail.gmail.com>
 <CALCETrW=hMZLUM_nPEEgUW9x9Bmhm2LZ6ZRDiRRguxVT=-_BWA@mail.gmail.com>
 <CAHk-=wiEUVpSU-GxpKDvN9wnH2yDxkJgE7Vqh46A+fmnvhubyw@mail.gmail.com>
 <cd11d9423c8b46ecbf97753f8317c294@AcuMS.aculab.com>
 <64fd67993af04579b5262c270a7a4694@AcuMS.aculab.com>
 <CAHk-=wj9DA-mH8jahuEPUWxO4EgbCcPRgdOJAQD58DBtCCrHcQ@mail.gmail.com>
 <a3ebeca68de1493f876467f57575be74@AcuMS.aculab.com>
 <CAHk-=wiFoyd-L2f0sdyKDiBQ67b4VHjw9jO34ChYJxwqm1YhCA@mail.gmail.com>
In-Reply-To: <CAHk-=wiFoyd-L2f0sdyKDiBQ67b4VHjw9jO34ChYJxwqm1YhCA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: lHYb6N7aO8u2suev8LZbGg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDUgSmFudWFyeSAyMDE5IDAyOjM5DQouLi4N
Cj4gQW55d2F5LCBpdCB3b3VsZCBiZSBsb3ZlbHkgdG8gaGVhciB3aGV0aGVyIG1lbWNweV90b2lv
KCkgbm93IHdvcmtzDQo+IHJlYXNvbmFibHkuIEkganVzdCBwaWNrZWQgb3VyIHZlcnkgb2xkIGxl
Z2FjeSBmdW5jdGlvbiBmb3IgdGhpcywgc28gaXQNCj4gd2lsbCBkbyB0aGluZ3MgaW4gMzItYml0
IGNodW5rcyAoZXZlbiBvbiB4ODYtNjQpLCBhbmQgSSdtIGNlcnRhaW5seQ0KPiBvcGVuIHRvIHNv
bWVib2R5IGRvaW5nIHNvbWV0aGluZyBzbWFydGVyLCBidXQgY29uc2lkZXJpbmcgdGhhdCBub2Jv
ZHkNCj4gZWxzZSBzZWVtZWQgdG8gc2hvdyBhbnkgaW50ZXJlc3QgaW4gdGhpcyBhdCBhbGwsIEkg
anVzdCB3ZW50DQo+ICJ3aGF0ZXZlciwgZ29vZCBlbm91Z2giLg0KPiANCj4gSSB0cmllZCB0byBt
YWtlIGl0IGVhc3kgdG8gaW1wcm92ZSBvbiB0aGluZ3MgaWYgcGVvcGxlIHdhbnQgdG8uDQoNCkkn
bGwgZG8gc29tZSB0ZXN0cyBvbmNlIHRoZSBtZXJnZSBoYXMgaGFkIHRpbWUgdG8gc2V0dGxlLg0K
DQpJIG5lZWRlZCB0byBvcGVuLWNvZGUgb25lIHBhcnQgYmVjYXVzZSBpdCB3YW50cyB0byBkbyBj
b3B5X3RvX3VzZXIoKQ0KZnJvbSBhIFBDSWUgYWRkcmVzcyBidWZmZXIgKHdoaWNoIGhhcyB0byB3
b3JrKS4NCg0KVXNpbmcgNjRiaXQgY2h1bmtzIGZvciByZWFkcyBpcyBwcm9iYWJseSB3b3J0aCB3
aGlsZSBvbiB4ODYtNjQuDQpJIG1pZ2h0IGNvb2sgdXAgYSBwYXRjaC4NCkFjdHVhbGx5LCBpZiB0
aGUgQVZYIHJlZ2lzdGVycyBhcmUgYXZhaWxhYmxlIHdpdGhvdXQgYW4gZnB1IHNhdmUNCnVzaW5n
IGxhcmdlciBjaHVua3Mgd291bGQgYmUgd29ydGh3aGlsZSAtIGVzcGVjaWFsbHkgZm9yIGlvIHJl
YWRzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K

