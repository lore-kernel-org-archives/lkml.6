Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23A0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B747620866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404042AbfAPKap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:30:45 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:59581 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403917AbfAPKao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:30:44 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-136-4U74QEZyNQu_MdkClKZp5A-1; Wed, 16 Jan 2019 10:30:41 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 16 Jan 2019 10:31:08 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 16 Jan 2019 10:31:08 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
CC:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Rik van Riel" <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: RE: [PATCH v6] x86: load FPU registers on return to userland
Thread-Topic: [PATCH v6] x86: load FPU registers on return to userland
Thread-Index: AQHUqBFG/2WmFKVnEEqv3ikTpa8106WwTizwgACPwxKAANvx0A==
Date:   Wed, 16 Jan 2019 10:31:08 +0000
Message-ID: <ac60c5d4acc2493298d0d864320993ba@AcuMS.aculab.com>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <2e396dbcbb1c4cc191b4208626baed07@AcuMS.aculab.com>
 <dc9e3308-4e2a-2ce8-495e-6fdb868c60b2@intel.com>
 <CALCETrX0RNgiVop+9uSkLyfxoy-cDyWk2G09svGD_UPsVyLAhA@mail.gmail.com>
 <39ab2f2b-81bb-636e-933d-f3a5225aa020@intel.com>
 <CALCETrXq8GFAzunui7d-seaK-on6_xiZOv0A4wc=sAur0wuDzg@mail.gmail.com>
In-Reply-To: <CALCETrXq8GFAzunui7d-seaK-on6_xiZOv0A4wc=sAur0wuDzg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 4U74QEZyNQu_MdkClKZp5A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBMdXRvbWlyc2tpIFttYWlsdG86bHV0b0BrZXJuZWwub3JnXQ0KPiBPbiBUdWUs
IEphbiAxNSwgMjAxOSBhdCAxMjo1NCBQTSBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIDEvMTUvMTkgMTI6MjYgUE0sIEFuZHkgTHV0b21pcnNr
aSB3cm90ZToNCj4gPiA+IEkgZG9uJ3QgdGhpbmsgd2UnZCBldmVyIHdhbnQga2VybmVsX2ZwdV9l
bmQoKSB0byByZXN0b3JlIGFueXRoaW5nLA0KPiA+ID4gcmlnaHQ/ICBJJ20gYSBiaXQgY29uZnVz
ZWQgYXMgdG8gd2hlbiB0aGlzIG9wdGltaXphdGlvbiB3b3VsZCBhY3R1YWxseQ0KPiA+ID4gYmUg
dXNlZnVsLg0KPiA+DQo+ID4gVXNpbmcgQVZYLTUxMiBhcyBhbiBleGFtcGxlLi4uDQo+ID4NCj4g
PiBMZXQncyBzYXkgdGhlcmUgd2FzIEFWWC01MTIgc3RhdGUsIGFuZCBhIGtlcm5lbF9mcHVfYmVn
aW4oKSB1c2VyIG9ubHkNCj4gPiB1c2VkIEFWWDIuICBXZSBjb3VsZCB0b3RhbGx5IGF2b2lkIGRv
aW5nICphbnkqIEFWWC01MTIgc3RhdGUgc2F2ZS9yZXN0b3JlLg0KPiA+DQo+ID4gVGhlIGluaXQg
b3B0aW1pemF0aW9uIGRvZXNuJ3QgaGVscCB1cyBpZiB0aGVyZSBfaXNfIEFWWC01MTIgc3RhdGUs
IGFuZA0KPiA+IHRoZSBtb2RpZmllZCBvcHRpbWl6YXRpb24gb25seSBoZWxwcyBpZiB3ZSByZWNl
bnRseSBkaWQgYSBYUlNUT1IgYXQNCj4gPiBjb250ZXh0IHN3aXRjaCBhbmQgaGF2ZSBub3Qgd3Jp
dHRlbiB0byBBVlgtNTEyIHN0YXRlIHNpbmNlIFhSU1RPUi4NCj4gPg0KPiA+IFRoaXMgcHJvYmFi
bHkgb25seSBtYXR0ZXJzIGZvciBBVlgtNTEyLXVzaW5nIGFwcHMgdGhhdCBoYXZlIHJ1biBvbiBh
DQo+ID4ga2VybmVsIHdpdGggbG90cyBvZiBrZXJuZWxfZnB1X2JlZ2luKClzIHRoYXQgZG9uJ3Qg
dXNlIEFWWC01MTIuICBTbywgbm90DQo+ID4gYSBiaWcgZGVhbCByaWdodCBub3cuDQo+IA0KPiBP
biB0b3Agb2YgdGhpcyBzZXJpZXMsIHRoaXMgZ2V0cyByYXRoZXIgYXdrd2FyZCwgSSB0aGluayAt
LSBub3cgd2UNCj4gbmVlZCB0byBiZSBhYmxlIHRvIGtlZXAgdHJhY2sgb2YgYSBzdGF0ZSBpbiB3
aGljaCBzb21lIG9mIHRoZSB1c2VyDQo+IHJlZ2lzdGVycyBsaXZlIGluIHRoZSBDUFUgYW5kIHNv
bWUgbGl2ZSBpbiBtZW1vcnksIGFuZCB3ZSBuZWVkIHRvIGJlDQo+IGFibGUgdG8gZG8gdGhlIHBh
cnRpYWwgcmVzdG9yZSBpZiB3ZSBnbyBiYWNrIHRvIHVzZXIgbW9kZSBsaWtlIHRoaXMuDQo+IFdl
IGFsc28gbmVlZCB0byBiZSBhYmxlIHRvIGRvIGEgcGFydGlhbCBzYXZlIGlmIHdlIGVuZCB1cCBj
b250ZXh0DQo+IHN3aXRjaGluZy4gIFRoaXMgc2VlbXMgcmF0aGVyIGNvbXBsaWNhdGVkLg0KDQpJ
ZiBrZXJuZWxfZnB1X2JlZ2luKCkgcmVxdWVzdHMgcmVnaXN0ZXJzIHRoYXQgYXJlICdsaXZlJyBm
b3IgdXNlcnNwYWNlLA0Kb3IgaWYgdGhlIHVzZXIgcmVnaXN0ZXJzIGhhdmUgYmVlbiBzYXZlZCB0
aGVuIHlvdSAobW9yZSBvciBsZXNzKSBoYXZlDQp0byBkaXNhYmxlIHByZS1lbXB0aW9uLg0KT1RP
SCBpZiB0aGUga2VybmVsIHdhbnRzIHRoZSBBVlgyIHJlZ2lzdGVycyBhbmQgdGhlIHVzZXIgb25l
cyBhcmUgYWxsIDANCnRoZW4gdGhlIGtlcm5lbCBjYW4ganVzdCB1c2UgdGhlIHJlZ2lzdGVycyBw
cm92aWRlZCBrZXJuZWxfZnB1X2VuZCgpDQp6ZXJvZXMgdGhlbS4gSW4gdGhpcyBjYW4geW91IGNh
biBhbGxvdyBwcmUtZW1wdGlvbiBiZWNhdXNlIGl0IHdpbGwgc2F2ZQ0KZXZlcnl0aGluZyBhbmQg
aXQgd2lsbCBhbGwgZ2V0IHJlc3RvcmVkIGNvcnJlY3RseSAod2lsbCBuZWVkIHRvIGJlDQpyZXN0
b3JlZCB3aGVuIHRoZSBwcm9jZXNzIGlzIHNjaGVkdWxlZCwgbm90IHJldHVybiB0byB1c2VyKS4N
ClRoZSByZWdpc3RlciBzYXZlIGFyZWEgbWlnaHQgbmVlZCB6YXBwaW5nIChpZiB1c2VkKSBiZWNh
dXNlIGl0IG1pZ2h0DQpiZSByZWFkYWJsZSBmcm9tIHVzZXIgc3BhY2UgKGJ5IGEgZGVidWdnZXIp
Lg0KDQpUaGUgb3RoZXIgY2FzZSBpcyBrZXJuZWwgY29kZSB0aGF0IGd1YXJhbnRlZXMgdG8gc2F2
ZSBhbmQgcmVzdG9yZQ0KYW55IHJlZ2lzdGVycyBpcyB1c2VzIChpdCBtaWdodCBvbmx5IHdhbnQg
MiByZWdpc3RlcnMgZm9yIGEgQ1JDKS4NClN1Y2ggY29kZSBjYW4gbmVzdCB3aXRoIG90aGVyIGtl
cm5lbCB1c2VycyAoZWcgaW4gYW4gSVNSKS4NCkknbSBub3Qgc3VyZSB3aGV0aGVyIGlzIG5lZWRz
IGEgc21hbGwgJ3NhdmUgYXJlYScgZm9yIGZwdSBmbGFncz8NCkl0IG1pZ2h0IGJlIHdvcnRoIGFk
ZGluZyBzdWNoIGEgc3RydWN0dXJlIHRvIHRoZSBpbnRlcmZhY2UgLSBldmVuDQppZiBpdCBpcyBj
dXJyZW50bHkgYSBkdW1teSBzdHJ1Y3R1cmUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFk
ZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywg
TUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

