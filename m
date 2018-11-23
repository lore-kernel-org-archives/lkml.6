Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBD6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E794020820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E794020820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405361AbeKWUSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:18:16 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:23632 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387987AbeKWUSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:18:16 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-166-TWy6a9ZrMV6iTM9A9wSALQ-1; Fri, 23 Nov 2018 09:34:42 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri,
 23 Nov 2018 09:34:49 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 23 Nov 2018 09:34:49 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>
CC:     "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH] x86: only use ERMS for user copies for larger sizes
Thread-Topic: [PATCH] x86: only use ERMS for user copies for larger sizes
Thread-Index: AQHUgaBY0KBBfG3q00apJLDxEV5GB6VcD8pwgAAXuEiAAPNRcA==
Date:   Fri, 23 Nov 2018 09:34:49 +0000
Message-ID: <cd11d9423c8b46ecbf97753f8317c294@AcuMS.aculab.com>
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com>
 <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <26eff539-7de7-784c-0c88-f1d30753299d@redhat.com>
 <7ea44458b90b4d41a08ba9012818d273@AcuMS.aculab.com>
 <CAHk-=wjLNuNpHRfuVTb6awstC9OOmSb3S8aP51ufep-Th4dXKw@mail.gmail.com>
 <CALCETrW=hMZLUM_nPEEgUW9x9Bmhm2LZ6ZRDiRRguxVT=-_BWA@mail.gmail.com>
 <CAHk-=wiEUVpSU-GxpKDvN9wnH2yDxkJgE7Vqh46A+fmnvhubyw@mail.gmail.com>
In-Reply-To: <CAHk-=wiEUVpSU-GxpKDvN9wnH2yDxkJgE7Vqh46A+fmnvhubyw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: TWy6a9ZrMV6iTM9A9wSALQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjIgTm92ZW1iZXIgMjAxOCAxODo1OA0KLi4u
DQo+IE9oLCBhbmQgSSBqdXN0IG5vdGljZWQgdGhhdCBvbiB4ODYgd2UgZXhwcmVzc2x5IHVzZSBv
dXIgb2xkICJzYWZlIGFuZA0KPiBzYW5lIiBmdW5jdGlvbnM6IHNlZSBfX2lubGluZV9tZW1jcHko
KSwgYW5kIGl0cyB1c2UgaW4NCj4gX19tZW1jcHlfe2Zyb20sdG99aW8oKS4NCj4gDQo+IFNvIHRo
ZSAiZmFsbHMgYmFjayB0byBtZW1jcHkiIHdhcyBhbHdheXMgYSByZWQgaGVycmluZy4gV2UgZG9u
J3QNCj4gYWN0dWFsbHkgZG8gdGhhdC4NCj4gDQo+IFdoaWNoIGV4cGxhaW5zIHdoeSB0aGluZ3Mg
d29yay4NCg0KSXQgZG9lc24ndCBleHBsYWluIHdoeSBJJ3ZlIHNlZW4gc2luZ2xlIGJ5dGUgUENJ
ZSBUTFAgZ2VuZXJhdGVkDQpieSBtZW1jcHlfdG8vZnJvbWlvKCkuDQoNCkkndmUgaGFkIHRvIGNo
YW5nZSBjb2RlIHRvIHVzZSByZWFkcS93cml0ZXEgbG9vcHMgYmVjYXVzZSB0aGUNCmJ5dGUgYWNj
ZXNzZXMgYXJlIHNvIHNsb3cgLSBldmVuIHdoZW4gUElPIHBlcmZvcm1hbmNlIHNob3VsZA0KYmUg
J2dvb2QgZW5vdWdoJy4NCg0KSXQgbWlnaHQgaGF2ZSBiZWVuIGNoYW5nZWQgc2luY2UgbGFzdCB0
aW1lIEkgdGVzdGVkIGl0Lg0KQnV0IEkgZG9uJ3QgcmVtZW1iZXIgc2VlaW5nIGEgY29tbWl0IGdv
IGJ5Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K

