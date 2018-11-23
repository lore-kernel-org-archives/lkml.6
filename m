Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F71C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127FA20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127FA20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503155AbeKWU4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:56:08 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:30287 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387808AbeKWU4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:56:07 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-25-MDF-VcXoPOm9BxBa3KMGBw-1; Fri, 23 Nov 2018 10:12:26 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri,
 23 Nov 2018 10:12:33 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 23 Nov 2018 10:12:33 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        'Andrew Lutomirski' <luto@kernel.org>
CC:     "'dvlasenk@redhat.com'" <dvlasenk@redhat.com>,
        'Jens Axboe' <axboe@kernel.dk>,
        'Ingo Molnar' <mingo@kernel.org>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Ingo Molnar' <mingo@redhat.com>,
        "'bp@alien8.de'" <bp@alien8.de>, 'Peter Anvin' <hpa@zytor.com>,
        'the arch/x86 maintainers' <x86@kernel.org>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Peter Zijlstra'" <a.p.zijlstra@chello.nl>,
        "'brgerst@gmail.com'" <brgerst@gmail.com>,
        'Linux List Kernel Mailing' <linux-kernel@vger.kernel.org>,
        "'pabeni@redhat.com'" <pabeni@redhat.com>
Subject: RE: [PATCH] x86: only use ERMS for user copies for larger sizes
Thread-Topic: [PATCH] x86: only use ERMS for user copies for larger sizes
Thread-Index: AQHUgaBY0KBBfG3q00apJLDxEV5GB6VcD8pwgAAXuEiAAPNRcIAAB5ww
Date:   Fri, 23 Nov 2018 10:12:33 +0000
Message-ID: <64fd67993af04579b5262c270a7a4694@AcuMS.aculab.com>
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com>
 <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <26eff539-7de7-784c-0c88-f1d30753299d@redhat.com>
 <7ea44458b90b4d41a08ba9012818d273@AcuMS.aculab.com>
 <CAHk-=wjLNuNpHRfuVTb6awstC9OOmSb3S8aP51ufep-Th4dXKw@mail.gmail.com>
 <CALCETrW=hMZLUM_nPEEgUW9x9Bmhm2LZ6ZRDiRRguxVT=-_BWA@mail.gmail.com>
 <CAHk-=wiEUVpSU-GxpKDvN9wnH2yDxkJgE7Vqh46A+fmnvhubyw@mail.gmail.com>
 <cd11d9423c8b46ecbf97753f8317c294@AcuMS.aculab.com>
In-Reply-To: <cd11d9423c8b46ecbf97753f8317c294@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: MDF-VcXoPOm9BxBa3KMGBw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDIzIE5vdmVtYmVyIDIwMTggMDk6MzUNCj4gRnJv
bTogTGludXMgVG9ydmFsZHMNCj4gPiBTZW50OiAyMiBOb3ZlbWJlciAyMDE4IDE4OjU4DQo+IC4u
Lg0KPiA+IE9oLCBhbmQgSSBqdXN0IG5vdGljZWQgdGhhdCBvbiB4ODYgd2UgZXhwcmVzc2x5IHVz
ZSBvdXIgb2xkICJzYWZlIGFuZA0KPiA+IHNhbmUiIGZ1bmN0aW9uczogc2VlIF9faW5saW5lX21l
bWNweSgpLCBhbmQgaXRzIHVzZSBpbg0KPiA+IF9fbWVtY3B5X3tmcm9tLHRvfWlvKCkuDQo+ID4N
Cj4gPiBTbyB0aGUgImZhbGxzIGJhY2sgdG8gbWVtY3B5IiB3YXMgYWx3YXlzIGEgcmVkIGhlcnJp
bmcuIFdlIGRvbid0DQo+ID4gYWN0dWFsbHkgZG8gdGhhdC4NCj4gPg0KPiA+IFdoaWNoIGV4cGxh
aW5zIHdoeSB0aGluZ3Mgd29yay4NCj4gDQo+IEl0IGRvZXNuJ3QgZXhwbGFpbiB3aHkgSSd2ZSBz
ZWVuIHNpbmdsZSBieXRlIFBDSWUgVExQIGdlbmVyYXRlZA0KPiBieSBtZW1jcHlfdG8vZnJvbWlv
KCkuDQo+IA0KPiBJJ3ZlIGhhZCB0byBjaGFuZ2UgY29kZSB0byB1c2UgcmVhZHEvd3JpdGVxIGxv
b3BzIGJlY2F1c2UgdGhlDQo+IGJ5dGUgYWNjZXNzZXMgYXJlIHNvIHNsb3cgLSBldmVuIHdoZW4g
UElPIHBlcmZvcm1hbmNlIHNob3VsZA0KPiBiZSAnZ29vZCBlbm91Z2gnLg0KPiANCj4gSXQgbWln
aHQgaGF2ZSBiZWVuIGNoYW5nZWQgc2luY2UgbGFzdCB0aW1lIEkgdGVzdGVkIGl0Lg0KPiBCdXQg
SSBkb24ndCByZW1lbWJlciBzZWVpbmcgYSBjb21taXQgZ28gYnkuDQoNCkkndmUganVzdCBwYXRj
aGVkIG15IGRyaXZlciBhbmQgcmVkb25lIHRoZSB0ZXN0IG9uIGEgNC4xMyAodWJ1bnR1KSBrZXJu
ZWwuDQpDYWxsaW5nIG1lbWNweV9mcm9taW8oa2VybmVsX2J1ZmZlciwgUENJZV9hZGRyZXNzLCBs
ZW5ndGgpDQpnZW5lcmF0ZXMgYSBsb3Qgb2Ygc2luZ2xlIGJ5dGUgVExQLg0KDQpXaGF0IHRoZSBj
b2RlIG5vcm1hbGx5IGRvZXMgaXMgNjRiaXQgYWxpZ25lZCBQQ0llIHJlYWRzIHdpdGgNCm11bHRp
cGxlIHdyaXRlcyBhbmQgc2hpZnRzIHRvIGF2b2lkIHdyaXRpbmcgYmV5b25kIHRoZSBlbmQgb2YN
CnRoZSBrZXJuZWwgYnVmZmVyIGZvciAnb2RkJyBsZW5ndGggdHJhbnNmZXJzLg0KDQpNb3N0IG9m
IG91ciBQSU8gY29waWVzIGFyZSBhY3R1YWxseSBkaXJlY3QgdG8vZnJvbSB1c2Vyc3BhY2UuDQpX
aGlsZSBjb3B5X3RvL2Zyb21fdXNlcigpIHdpbGwgd29yayBvbiBQQ0llIG1lbW9yeSwgaXQgaXMg
J3JlcCBtb3N2YicuDQpXZSBhbHNvIG1tYXAoKSB0aGUgUENJZSBzcGFjZSBpbnRvIHByb2Nlc3Mg
bWVtb3J5IC0gYW5kIGhhdmUgYmUNCmNhcmVmdWwgbm90IHRvIHVzZSBtZW1jcHkoKSBpbiB1c2Vz
cGFjZS4NCg0KT24gc3VpdGFibGUgc3lzdGVtcyB1c2Vyc3BhY2UgY2FuIHVzZSB0aGUgQVZYMjU2
IGluc3RydWN0aW9ucyB0bw0KZ2V0IHdpZGUgcmVhZHMuIE11Y2ggaGFyZGVyIGFuZCBtb3JlIGV4
cGVuc2l2ZSBpbiB0aGUga2VybmVsLg0KDQpJbiBwcmFjdGlzZSBtb3N0IG9mIHRoZSBidWxrIGRh
dGEgdHJhbnNmZXJzIGFyZSByZXF1ZXN0ZWQgYnkgdGhlIFBDSWUgc2xhdmUuDQpCdXQgdGhlcmUg
YXJlIHRpbWVzIHdoZW4gUElPIG9uZXMgYXJlIG5lZWRlZCwgYW5kIDY0IGJpdCB0cmFuc2ZlcnMg
YXJlDQo4IHRpbWVzIGZhc3RlciB0aGFuIDggYml0IG9uZXMuDQpUaGlzIGlzIGFsbCBtYWRlIG1v
cmUgc2lnbmlmaWNhbnQgYmVjYXVzZSBpdCB0YWtlcyBvdXIgZnBnYSBhYm91dCA1MDBucw0KdG8g
Y29tcGxldGUgYSBzaW5nbGUgd29yZCBQQ0llIHJlYWQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

