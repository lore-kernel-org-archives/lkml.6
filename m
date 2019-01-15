Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E15C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0ABC20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbfAOOdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:33:08 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:50917 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726863AbfAOOdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:33:07 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-83-xaAb4goyPsKmHdSZFYvqmw-1; Tue, 15 Jan 2019 14:33:04 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 15 Jan 2019 14:33:32 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 15 Jan 2019 14:33:32 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: RE: [PATCH v6] x86: load FPU registers on return to userland
Thread-Topic: [PATCH v6] x86: load FPU registers on return to userland
Thread-Index: AQHUqBFG/2WmFKVnEEqv3ikTpa8106WwTizwgAAKZwCAABOrIA==
Date:   Tue, 15 Jan 2019 14:33:32 +0000
Message-ID: <1311521fdd274c08b379cef7252ebd8f@AcuMS.aculab.com>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <2e396dbcbb1c4cc191b4208626baed07@AcuMS.aculab.com>
 <20190115131516.ocyi34ovkgairfiy@linutronix.de>
In-Reply-To: <20190115131516.ocyi34ovkgairfiy@linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: xaAb4goyPsKmHdSZFYvqmw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogJ1NlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3InDQo+IFNlbnQ6IDE1IEphbnVhcnkgMjAx
OSAxMzoxNQ0KPiBPbiAyMDE5LTAxLTE1IDEyOjQ0OjUzIFsrMDAwMF0sIERhdmlkIExhaWdodCB3
cm90ZToNCj4gPiBPbmNlIHRoaXMgaXMgZG9uZSBpdCBtaWdodCBiZSB3b3J0aCB3aGlsZSBhZGRp
bmcgYSBwYXJhbWV0ZXIgdG8NCj4gPiBrZXJuZWxfZnB1X2JlZ2luKCkgdG8gcmVxdWVzdCB0aGUg
cmVnaXN0ZXJzIG9ubHkgd2hlbiB0aGV5IGRvbid0DQo+ID4gbmVlZCBzYXZpbmcuDQo+ID4gVGhp
cyB3b3VsZCBiZW5lZml0IGNvZGUgcGF0aHMgd2hlcmUgdGhlIGdhaW5zIGFyZSByZWFzb25hYmxl
IGJ1dCBub3QgbWFzc2l2ZS4NCj4gDQo+IFNvIGlmIHNhdmluZyArIEZQVSBjb2RlIGlzIGEgc21h
bGwgd2luIHdoeSBub3QgZG8gdGhpcyBhbHdheXM/DQoNCkkgd2FzIHRoaW5raW5nIG9mIHRoZSBj
YXNlIHdoZW4gdGhlIGNvc3Qgb2YgdGhlIGZwdSBzYXZlIGlzIGdyZWF0ZXINCnRoYW4gdGhlIHNh
dmluZy4NClRoaXMgbWlnaHQgYmUgdHJ1ZSBmb3IgKHNheSkgYSBjcmMgb24gYSBzaG9ydCBidWZm
ZXIuDQoNCj4gPiBUaGUgcmV0dXJuIHZhbHVlIGZyb20ga2VybmVsX2ZwdV9iZWdpbigpIG91Z2h0
IHRvIGluZGljYXRlIHdoaWNoDQo+ID4gcmVnaXN0ZXJzIGFyZSBhdmFpbGFibGUgLSBub25lLCBT
U0UsIFNTRTIsIEFWWCwgQVZYNTEyIGV0Yy4NCj4gPiBTbyBjb2RlIGNhbiB1c2UgYW4gYXBwcm9w
cmlhdGUgaW1wbGVtZW50YXRpb24uDQo+ID4gKEkndmUgbm90IGxvb2tlZCB0byBzZWUgaWYgdGhp
cyBpcyBhbHJlYWR5IHRoZSBjYXNlISkNCj4gDQo+IEVpdGhlciBldmVyeXRoaW5nIGlzIHNhdmVk
IG9yIG5vdGhpbmcuIFNvIGlmIFNTRSByZWdpc3RlcnMgYXJlIHNhdmVkDQo+IHRoZW4gQVZYNTEy
IGFyZSwgdG9vLg0KDQooSSBrbm93IHRoYXQgLSBJJ3ZlIHdyaXR0ZW4gZnB1IHNhdmUgY29kZSBm
b3IgQVZYKS4NCkkgd2FzIHRoaW5raW5nIHRoYXQgdGhlIHJldHVybiB2YWx1ZSB3b3VsZCBkZXBl
bmQgb24gd2hhdCB0aGUgY3B1IHN1cHBvcnRzLg0KDQpJbiBmYWN0LCBnaXZlbiBzb21lIHRhbGsg
YWJvdXQgYmlnLWxpdHRsZSBjcHVzIGl0IG1pZ2h0IGJlIHdvcnRoIGJlaW5nDQphYmxlIHRvIGFz
ayBmb3IgYSBzcGVjaWZpYyByZWdpc3RlciBzZXQuDQpQb3RlbnRpYWxseSB0aGF0IGNvdWxkIGNh
dXNlIGEgcHJvY2Vzc29yIHN3aXRjaC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

