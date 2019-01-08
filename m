Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F218C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152FF2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfAHJKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:10:04 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:33666 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727367AbfAHJKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:10:03 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-186-rRWwsNhmMgKmu7DXzJqGdA-1; Tue, 08 Jan 2019 09:09:55 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 8 Jan 2019 09:10:23 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 8 Jan 2019 09:10:23 +0000
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
Thread-Index: AQHUgaBY0KBBfG3q00apJLDxEV5GB6VcD8pwgAAXuEiAAPNRcIAAB5wwgABvjYCABE4VAIA+XC8AgAOb8vCAAIWbgIAAAOtA
Date:   Tue, 8 Jan 2019 09:10:22 +0000
Message-ID: <9e479981e09b4bebaaf6bc7f81c7bb59@AcuMS.aculab.com>
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
 <dbb32dfaebee4bcb8ec3372bc7a27032@AcuMS.aculab.com>
 <CAHk-=wg02_--Xbf9HQw0g5-0k_uY+ksbxfBHK45BKDnPjz9OXw@mail.gmail.com>
In-Reply-To: <CAHk-=wg02_--Xbf9HQw0g5-0k_uY+ksbxfBHK45BKDnPjz9OXw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: rRWwsNhmMgKmu7DXzJqGdA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDcgSmFudWFyeSAyMDE5IDE3OjQ0DQo+IE9u
IE1vbiwgSmFuIDcsIDIwMTkgYXQgMTo1NSBBTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBh
Y3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IEkgbmVlZGVkIHRvIG9wZW4tY29kZSBvbmUgcGFy
dCBiZWNhdXNlIGl0IHdhbnRzIHRvIGRvIGNvcHlfdG9fdXNlcigpDQo+ID4gZnJvbSBhIFBDSWUg
YWRkcmVzcyBidWZmZXIgKHdoaWNoIGhhcyB0byB3b3JrKS4NCj4gDQo+IEl0IHdpbGwgbmV2ZXIg
d29yayBmb3IgbWVtY3B5X2Zyb21pbygpLiBBbnkgZHJpdmVyIHRoYXQgdGhpbmtzIGl0IHdpbGwN
Cj4gY29weSBmcm9tIGlvIHNwYWNlIHRvIHVzZXIgc3BhY2UgYWJzb2x1dGVseSAqaGFzKiB0byBk
byBpdCBieSBoYW5kLiBObw0KPiBxdWVzdGlvbnMsIGFuZCBubyBleGNlcHRpb25zLiBTb21lIGxv
b3AgbGlrZQ0KPiANCj4gICAgZm9yICguLikNCj4gICAgICAgcHV0X3VzZXIocmVhZGwoaW9tZW0r
KyksIHVhZGRyKyspOw0KPiANCj4gYmVjYXVzZSBuZWl0aGVyIGNvcHlfdG9fdXNlcigpIG5vciBt
ZW1jcHlfZnJvbWlvKCkgd2lsbCAqZXZlciogaGFuZGxlDQo+IHRoYXQgY29ycmVjdGx5Lg0KPiAN
Cj4gVGhleSBtaWdodCByYW5kb21seSBoYXBwZW4gdG8gd29yayBvbiB4ODYsIGJ1dCBhYnNvbHV0
ZWx5IG5vd2hlcmUgZWxzZS4NCg0KQWN0dWFsbHkgdGhleSB0ZW5kIHRvIGhhbmRsZSBpdCBvbiBh
IGxvdCBvZiBzeXN0ZW1zLg0KKEJ1dCBJIGRvbid0IGRvIGl0LikNClByb2JhYmx5IG1vc3Qgb2Yg
dGhvc2Ugd2hlcmUgdm1faW9tYXBfbWVtb3J5KCkgKHRvIG1hcCBJTyBtZW1vcnkNCnNwYWNlIGRp
cmVjdGx5IGludG8gdXNlciBwYWdlcykgd29ya3MuDQoNCkl0IG1pZ2h0IGJlICdpbnRlcmVzdGlu
ZycgdG8gYnVpbGQgYW4gYW1kNjQga2VybmVsIHdoZXJlIGFsbCB0aGUgSU8NCm1lbW9yeSBhZGRy
ZXNzZXMgKGVnIHJldHVybmVkIGJ5IHBjaV9pb21hcCgpKSBhcmUgb2Zmc2V0IGJ5IGENCmxhcmdl
IGNvbnN0YW50IHNvIGRpcmVjdCBhY2Nlc3NlcyBhbGwgZmF1bHQgYW5kIGFsbCB0aGUgcmVhZGwo
KQ0KbWFjcm9zIChldGMpIGFkZCBpdCBiYWNrIGluLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

