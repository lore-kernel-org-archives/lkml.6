Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123DAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92B020873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92B020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeKZUzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:55:06 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:47828 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726184AbeKZUzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:55:06 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-32--yhAZ17bPjqAKX3jCF37wA-1; Mon, 26 Nov 2018 10:01:25 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 26 Nov 2018 10:01:33 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 26 Nov 2018 10:01:33 +0000
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
Thread-Index: AQHUgaBY0KBBfG3q00apJLDxEV5GB6VcD8pwgAAXuEiAAPNRcIAAB5wwgABvjYCABEMEIA==
Date:   Mon, 26 Nov 2018 10:01:32 +0000
Message-ID: <c4a6e3cc861e4cf2bf463286a62ae5fa@AcuMS.aculab.com>
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
X-MC-Unique: -yhAZ17bPjqAKX3jCF37wA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMgDQo+IFNlbnQ6IDIzIE5vdmVtYmVyIDIwMTggMTY6MzYNCj4g
DQo+IE9uIEZyaSwgTm92IDIzLCAyMDE4IGF0IDI6MTIgQU0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5M
YWlnaHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJJ3ZlIGp1c3QgcGF0Y2hlZCBteSBk
cml2ZXIgYW5kIHJlZG9uZSB0aGUgdGVzdCBvbiBhIDQuMTMgKHVidW50dSkga2VybmVsLg0KPiA+
IENhbGxpbmcgbWVtY3B5X2Zyb21pbyhrZXJuZWxfYnVmZmVyLCBQQ0llX2FkZHJlc3MsIGxlbmd0
aCkNCj4gPiBnZW5lcmF0ZXMgYSBsb3Qgb2Ygc2luZ2xlIGJ5dGUgVExQLg0KPiANCj4gSSBqdXN0
IHRlc3RlZCBpdCB0b28gLSBpdCB0dXJucyBvdXQgdGhhdCB0aGUgX19pbmxpbmVfbWVtY3B5KCkg
Y29kZQ0KPiBuZXZlciB0cmlnZ2VycywgYW5kICJtZW1jcHlfdG9pbygpIiBqdXN0IGdlbmVyYXRl
cyBhIG1lbWNweS4NCj4gDQo+IFNvIHRoYXQgY29kZSBzZWVtcyBlbnRpcmVseSBkZWFkLg0KPiAN
Cj4gQW5kLCBpbiBmYWN0LCB0aGUgY29kZWJhc2UgSSBsb29rZWQgYXQgd2FzIHRoZSBoaXN0b3Jp
Y2FsIG9uZSwgYmVjYXVzZQ0KPiBJIGhhZCBiZWVuIGdvaW5nIGJhY2sgYW5kIGxvb2tpbmcgYXQg
dGhlIGhpc3RvcnkuIFRoZSBtb2Rlcm4gdHJlZQ0KPiAqZG9lcyogaGF2ZSB0aGUgIl9faW5saW5l
X21lbWNweSgpIiBmdW5jdGlvbiBJIHBvaW50ZWQgYXQsIGJ1dCBpdCdzDQo+IG5vdCBhY3R1YWxs
eSBob29rZWQgdXAgdG8gYW55dGhpbmchDQo+IA0KPiBUaGlzIGFjdHVhbGx5IGhhcyBiZWVuIGJy
b2tlbiBmb3IgX2FnZXNfLiBUaGUgYnJlYWthZ2UgZ29lcyBiYWNrIHRvDQo+IDIwMTAsIGFuZCBj
b21taXQgNjE3NWRkZjA2YjYxICgieDg2OiBDbGVhbiB1cCBtZW0qaW8gZnVuY3Rpb25zIiksIGFu
ZA0KPiBpdCBzZWVtcyBub2JvZHkgcmVhbGx5IGV2ZXIgbm90aWNlZCAtIG9yIHRob3VnaHQgdGhh
dCBpdCB3YXMgb2suDQoNCkl0IHByb2JhYmx5IHdhcyBvayBpbiAyMDEwIC0gdGhhdCBwcmVkYXRl
cyBFUk1TIGNvcHkuDQoNCj4gVGhhdCBjb21taXQgY2xhaW1zIHRoYXQgaW9tZW0gaGFzIG5vIHNw
ZWNpYWwgc2lnbmlmaWNhbmNlIG9uIHg4NiwgYnV0DQo+IHRoYXQgcmVhbGx5IHJlYWxseSBpc24n
dCB0cnVlLCBleGFjdGx5IGJlY2F1c2UgdGhlIGFjY2VzcyBzaXplIGRvZXMNCj4gbWF0dGVyLg0K
DQpJIHN1c3BlY3QgdGhhdCBtZW1jcHlfdG8vZnJvbWlvKCkgc2hvdWxkIG9ubHkgYmUgdXNlZCBm
b3IgSU8gc3BhY2UNCnRoYXQgaGFzICdtZW1vcnktbGlrZScgc2VtYW50aWNzLg0KU28gaXQgc2hv
dWxkbid0IHJlYWxseSBtYXR0ZXIgd2hhdCBzaXplIGFjY2Vzc2VzIGFyZSBkb25lLg0KT1RPSCB0
aGUgJ2lvJyBzaWRlIGlzIGxpa2VseSB0byBiZSBzbG93IHNvIHlvdSB3YW50IHRvIGxpbWl0IHRo
ZQ0KbnVtYmVyIG9mIGlvIGN5Y2xlcyAocmVhZHMgaW4gcGFydGljdWxhcikuDQpXaXRoIG1lbW9y
eS1saWtlIHNlbWFudGljcyBpdCBpcyBvayB0byByZWFkIGZ1bGwgd29yZHMgYXQgYm90aCBlbmRz
DQpvZiB0aGUgYnVmZmVyIHRvIGF2b2lkIGV4dHJhIHRyYW5zZmVycy4NCkluZGVlZCwgb24gUENJ
ZSwgdGhlIG1pc2FsaWduZWQgdHJhbnNmZXIgZm9yIHRoZSBsYXN0IDggYnl0ZXMgaXMNCnByb2Jh
Ymx5IG9wdGltYWwuDQoNCj4gQW5kIGFzIG1lbnRpb25lZCwgdGhlIGdlbmVyaWMgbWVtb3J5IGNv
cHkgcm91dGluZXMgYXJlIG5vdCBhdCBhbGwNCj4gYXBwcm9wcmlhdGUsIGFuZCB0aGF0IGhhcyBu
b3RoaW5nIHRvIGRvIHdpdGggRVJNUy4gT3VyICJkbyBpdCBieSBoYW5kIg0KPiBtZW1vcnkgY29w
eSByb3V0aW5lIGRvZXMgdGhpbmdzIGxpa2UgdGhpczoNCj4gDQo+IC5MbGVzc18xNmJ5dGVzOg0K
PiAgICAgICAgIGNtcGwgJDgsICAgICAgICAlZWR4DQo+ICAgICAgICAgamIgICAuTGxlc3NfOGJ5
dGVzDQo+ICAgICAgICAgLyoNCj4gICAgICAgICAgKiBNb3ZlIGRhdGEgZnJvbSA4IGJ5dGVzIHRv
IDE1IGJ5dGVzLg0KPiAgICAgICAgICAqLw0KPiAgICAgICAgIG1vdnEgMCo4KCVyc2kpLCAlcjgN
Cj4gICAgICAgICBtb3ZxIC0xKjgoJXJzaSwgJXJkeCksICAlcjkNCj4gICAgICAgICBtb3ZxICVy
OCwgICAgICAgMCo4KCVyZGkpDQo+ICAgICAgICAgbW92cSAlcjksICAgICAgIC0xKjgoJXJkaSwg
JXJkeCkNCj4gICAgICAgICByZXRxDQo+IA0KPiBhbmQgbm90ZSBob3cgZm9yIGEgOC1ieXRlIGNv
cHksIGl0IHdpbGwgZG8gKnR3byogcmVhZHMgb2YgdGhlIHNhbWUgOA0KPiBieXRlcywgYW5kICp0
d28qIHdyaXRlcyBvZiB0aGUgc2FtZSA4IGJ5dGUgZGVzdGluYXRpb24uIFRoYXQncw0KPiBwZXJm
ZWN0bHkgb2sgZm9yIHJlZ3VsYXIgbWVtb3J5LCBhbmQgaXQgbWVhbnMgdGhhdCB0aGUgY29kZSBj
YW4gaGFuZGxlDQo+IGFuIGFyYml0cmFyeSA4LTE1IGJ5dGUgY29weSB3aXRob3V0IGFueSBjb25k
aXRpb25hbHMgb3IgbG9vcCBjb3VudHMsDQo+IGJ1dCBpdCBpcyAqbm90KiBvayBmb3IgaW9tZW0u
DQoNCkknZCBzYXkgaXQgaXMgb2sgZm9yIG1lbWNweV90by9mcm9taW8oKSBzaW5jZSB0aGF0IHNo
b3VsZCBvbmx5IHJlYWxseQ0KYmUgdXNlZCBmb3IgdGFyZ2V0cyB3aXRoIG1lbW9yeS1saWtlIHNl
bWFudGljcyAtIGFuZCBjb3VsZCBiZSBkb2N1bWVudGVkDQphcyBzdWNoLg0KQnV0IGRvaW5nIHRo
ZSBzYW1lIHRyYW5zZmVycyB0d2ljZSBpcyBkZWZpbml0ZWx5IHN1Yi1vcHRpbWFsLg0KDQo+IE9m
IGNvdXJzZSwgaW4gcHJhY3RpY2UgaXQgYWxsIGp1c3QgaGFwcGVucyB0byB3b3JrIGluIGFsbW9z
dCBhbGwNCj4gc2l0dWF0aW9ucyAoYmVjYXVzZSBhIGxvdCBvZiBpb21lbSBkZXZpY2VzIHNpbXBs
eSB3b24ndCBjYXJlKSwgYW5kDQo+IG1hbnVhbCBhY2Nlc3MgdG8gaW9tZW0gaXMgYmFzaWNhbGx5
IGV4dHJlbWVseSByYXJlIHRoZXNlIGRheXMgYW55d2F5LA0KPiBidXQgaXQncyBkZWZpbml0ZWx5
IGVudGlyZWx5IGFuZCB1dHRlcmx5IGJyb2tlbi4NCj4gDQo+IEVuZCByZXN1bHQ6IHdlICp1c2Vk
KiB0byBkbyB0aGlzIHJpZ2h0LiBGb3IgdGhlIGxhc3QgZWlnaHQgeWVhcnMgb3VyDQo+ICJtZW1j
cHlfe3RvLGZyb219aW8oKSIgaGFzIGJlZW4gZW50aXJlbHkgYnJva2VuLCBhbmQgYXBwYXJlbnRs
eSBldmVuDQo+IHRoZSBwZW9wbGUgd2hvIG5vdGljZWQgb2RkaXRpZXMgbGlrZSBEYXZpZCwgbmV2
ZXIgcmVwb3J0ZWQgaXQgYXMNCj4gYnJlYWthZ2UgYnV0IGluc3RlYWQganVzdCB3b3JrZWQgYXJv
dW5kIGl0IGluIGRyaXZlcnMuDQo+IA0KPiBIbyBodW1tLg0KPiANCj4gTGV0IG1lIHdyaXRlIGEg
Z2VuZXJpYyByb3V0aW5lIGluIGxpYi9pb21hcF9jb3B5LmMgKHdoaWNoIGFscmVhZHkgZG9lcw0K
PiB0aGUgInVzZXIgc3BlY2lmaWVzIGNodW5rIHNpemUiIGNhc2VzKSwgYW5kIGhvb2sgaXQgdXAg
Zm9yIHg4Ni4NCj4gDQo+IERhdmlkLCBhcmUgeW91IHVzaW5nIGEgYnVzIGFuYWx5emVyIG9yIHNv
bWV0aGluZyB0byBkbyB5b3VyIHRlc3Rpbmc/DQo+IEknbGwgaGF2ZSBhIHRyaWFsIHBhdGNoIGZv
ciB5b3UgYXNhcC4NCg0KV2UndmUgYSBUTFAgbW9uaXRvciBidWlsdCBpbnRvIG91ciBmcGdhIGlt
YWdlIHNvIGNhbiBsb29rIGF0IHRoZSBsYXN0DQpmZXcgVExQcyAoSUlSQyBhIDMya0IgYnVmZmVy
KS4NCg0KVGVzdGluZyBwYXRjaGVzIGlzIGEgYml0IGhhcmRlci4NClRoZSB0ZXN0IHN5c3RlbSBp
c24ndCBvbmUgSSBidWlsZCBrZXJuZWxzIG9uLg0KDQpJcyB0aGVyZSBhICdzZW5zaWJsZScgYW1k
NjQga2VybmVsIGNvbmZpZyB0aGF0IGNvbnRhaW5zIG1vc3Qgb2YgdGhlIGRyaXZlcnMNCmEgbW9k
ZXJuIHN5c3RlbSBtaWdodCBuZWVkPw0KSXQgaXMgYSBQSVRBIHRyeWluZyB0byBidWlsZCBrZXJu
ZWxzIHRoYXQgd2lsbCBsb2FkIG9uIGFsbCBteSB0ZXN0IHN5c3RlbXMNCihzaW5jZSBJIHRlbmQg
dG8gbW92ZSB0aGUgZGlza3MgYmV0d2VlbiBzeXN0ZW1zKS4NClJlYnVpbGRpbmcgdGhlIHVidW50
dSBjb25maWcganVzdCB0YWtlcyB0b28gbG9uZyBhbmQgZ2VuZXJhdGVzIGEgcmFtZGlzaw0KdGhh
dCBkb2Vzbid0IGZpdCBpbiAvYm9vdC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

