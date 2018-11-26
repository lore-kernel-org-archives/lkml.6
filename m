Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8320C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7806520989
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7806520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbeKZVTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:19:43 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:44405 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbeKZVTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:19:43 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-60-4g2VTU3BMqGDiNdLEPZqJw-1; Mon, 26 Nov 2018 10:26:01 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 26 Nov 2018 10:26:08 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 26 Nov 2018 10:26:08 +0000
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
Thread-Index: AQHUgaBY0KBBfG3q00apJLDxEV5GB6VcD8pwgAAXuEiAAPNRcIAAB5wwgABvjYCABE4VAA==
Date:   Mon, 26 Nov 2018 10:26:08 +0000
Message-ID: <a3ebeca68de1493f876467f57575be74@AcuMS.aculab.com>
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
In-Reply-To: <CAHk-=wj9DA-mH8jahuEPUWxO4EgbCcPRgdOJAQD58DBtCCrHcQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 4g2VTU3BMqGDiNdLEPZqJw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjMgTm92ZW1iZXIgMjAxOCAxNjozNg0KLi4u
DQo+IEVuZCByZXN1bHQ6IHdlICp1c2VkKiB0byBkbyB0aGlzIHJpZ2h0LiBGb3IgdGhlIGxhc3Qg
ZWlnaHQgeWVhcnMgb3VyDQo+ICJtZW1jcHlfe3RvLGZyb219aW8oKSIgaGFzIGJlZW4gZW50aXJl
bHkgYnJva2VuLCBhbmQgYXBwYXJlbnRseSBldmVuDQo+IHRoZSBwZW9wbGUgd2hvIG5vdGljZWQg
b2RkaXRpZXMgbGlrZSBEYXZpZCwgbmV2ZXIgcmVwb3J0ZWQgaXQgYXMNCj4gYnJlYWthZ2UgYnV0
IGluc3RlYWQganVzdCB3b3JrZWQgYXJvdW5kIGl0IGluIGRyaXZlcnMuDQoNCkkndmUgbWVudGlv
bmVkIGl0IHNldmVyYWwgdGltZXMuLi4NCg0KUHJvYmFibHkgbm8gb25lIGVsc2Ugbm90aWNlZCBs
b3RzIG9mIHNpbmdsZSBieXRlIHRyYW5zZmVycyB3aGlsZQ0KdGVzdGluZyBhIFRMUCBtb25pdG9y
IGhlIHdhcyB3cml0aW5nIGZvciBhbiBGUEdBIDotKQ0KVGhleSBhcmUgZmFyIHRvbyBleHBlbnNp
dmUgdG8gYnV5LCBhbmQgd291bGQgbmV2ZXIgYmUgY29ubmVjdGVkDQp0byB0aGUgcmlnaHQgc3lz
dGVtIGF0IHRoZSByaWdodCB0aW1lIC0gc28gd2UgKEkpIHdyb3RlIG9uZS4NCg0KVW5mb3J0dW5h
dGVseSB3ZSBkb24ndCByZWFsbHkgZ2V0IHRvIHNlZSB3aGF0IGhhcHBlbnMgd2hlbiB0aGUNCmxp
bmsgY29tZXMgdXAgKG9yIHJhdGhlciBkb2Vzbid0IGNvbWUgdXApLiBXZSBvbmx5IGdldCB0aGUN
CkxUU1NNIHN0YXRlIHRyYW5zaXRpb25zLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

