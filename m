Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EC1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D33F20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfAOMo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:44:29 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:49695 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727935AbfAOMo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:44:29 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-183-r-PJp5a0ODaRzTwhwZ3WCw-1; Tue, 15 Jan 2019 12:44:26 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 15 Jan 2019 12:44:53 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 15 Jan 2019 12:44:53 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: RE: [PATCH v6] x86: load FPU registers on return to userland
Thread-Topic: [PATCH v6] x86: load FPU registers on return to userland
Thread-Index: AQHUqBFG/2WmFKVnEEqv3ikTpa8106WwTizw
Date:   Tue, 15 Jan 2019 12:44:53 +0000
Message-ID: <2e396dbcbb1c4cc191b4208626baed07@AcuMS.aculab.com>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
In-Reply-To: <20190109114744.10936-1-bigeasy@linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: r-PJp5a0ODaRzTwhwZ3WCw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3INCj4gU2VudDogMDkgSmFudWFyeSAyMDE5
IDExOjQ3DQo+DQo+IFRoaXMgaXMgYSByZWZ1cmJpc2hlZCBzZXJpZXMgb3JpZ2luYWxseSBzdGFy
dGVkIGJ5IGJ5IFJpayB2YW4gUmllbC4gVGhlDQo+IGdvYWwgaXMgbG9hZCB0aGUgRlBVIHJlZ2lz
dGVycyBvbiByZXR1cm4gdG8gdXNlcmxhbmQgYW5kIG5vdCBvbiBldmVyeQ0KPiBjb250ZXh0IHN3
aXRjaC4gQnkgdGhpcyBvcHRpbWlzYXRpb24gd2UgY2FuOg0KPiAtIGF2b2lkIGxvYWRpbmcgdGhl
IHJlZ2lzdGVycyBpZiB0aGUgdGFzayBzdGF5cyBpbiBrZXJuZWwgYW5kIGRvZXMNCj4gICBub3Qg
cmV0dXJuIHRvIHVzZXJsYW5kDQo+IC0gbWFrZSBrZXJuZWxfZnB1X2JlZ2luKCkgY2hlYXBlcjog
aXQgb25seSBzYXZlcyB0aGUgcmVnaXN0ZXJzIG9uIHRoZQ0KPiAgIGZpcnN0IGludm9jYXRpb24u
IFRoZSBzZWNvbmQgaW52b2NhdGlvbiBkb2VzIG5vdCBuZWVkIHNhdmUgdGhlbSBhZ2Fpbi4NCj4g
DQo+IFRvIGFjY2VzcyB0aGUgRlBVIHJlZ2lzdGVycyBpbiBrZXJuZWwgd2UgbmVlZDoNCj4gLSBk
aXNhYmxlIHByZWVtcHRpb24gdG8gYXZvaWQgdGhhdCB0aGUgc2NoZWR1bGVyIHN3aXRjaGVzIHRh
c2tzLiBCeQ0KPiAgIGRvaW5nIHNvIGl0IHdvdWxkIHNldCBUSUZfTkVFRF9GUFVfTE9BRCBhbmQg
dGhlIEZQVSByZWdpc3RlcnMgd291bGQgYmUNCj4gICBub3QgdmFsaWQuDQo+IC0gZGlzYWJsZSBC
SCBiZWNhdXNlIHRoZSBzb2Z0aXJxIG1pZ2h0IHVzZSBrZXJuZWxfZnB1X2JlZ2luKCkgYW5kIHRo
ZW4NCj4gICBzZXQgVElGX05FRURfRlBVX0xPQUQgaW5zdGVhZCBsb2FkaW5nIHRoZSBGUFUgcmVn
aXN0ZXJzIG9uIGNvbXBsZXRpb24uDQoNCk9uY2UgdGhpcyBpcyBkb25lIGl0IG1pZ2h0IGJlIHdv
cnRoIHdoaWxlIGFkZGluZyBhIHBhcmFtZXRlciB0bw0Ka2VybmVsX2ZwdV9iZWdpbigpIHRvIHJl
cXVlc3QgdGhlIHJlZ2lzdGVycyBvbmx5IHdoZW4gdGhleSBkb24ndA0KbmVlZCBzYXZpbmcuDQpU
aGlzIHdvdWxkIGJlbmVmaXQgY29kZSBwYXRocyB3aGVyZSB0aGUgZ2FpbnMgYXJlIHJlYXNvbmFi
bGUgYnV0IG5vdCBtYXNzaXZlLg0KDQpUaGUgcmV0dXJuIHZhbHVlIGZyb20ga2VybmVsX2ZwdV9i
ZWdpbigpIG91Z2h0IHRvIGluZGljYXRlIHdoaWNoDQpyZWdpc3RlcnMgYXJlIGF2YWlsYWJsZSAt
IG5vbmUsIFNTRSwgU1NFMiwgQVZYLCBBVlg1MTIgZXRjLg0KU28gY29kZSBjYW4gdXNlIGFuIGFw
cHJvcHJpYXRlIGltcGxlbWVudGF0aW9uLg0KKEkndmUgbm90IGxvb2tlZCB0byBzZWUgaWYgdGhp
cyBpcyBhbHJlYWR5IHRoZSBjYXNlISkNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

