Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2984FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA17D208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA17D208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbeKZVF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:05:56 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:45850 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726176AbeKZVFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:05:55 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-137-_152VRO_PfyeL8BccYBtBg-1; Mon, 26 Nov 2018 10:12:15 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 26 Nov 2018 10:12:23 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 26 Nov 2018 10:12:23 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
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
Thread-Index: AQHUgaBY0KBBfG3q00apJLDxEV5GB6VcD8pwgAAXuEiAAPNRcIAAB5wwgACbAc2ABB2pkA==
Date:   Mon, 26 Nov 2018 10:12:23 +0000
Message-ID: <afebfe59fadb46fbbd4b09eaf0798592@AcuMS.aculab.com>
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
 <CAHk-=wjrdrZW5VgnKXqdayafYmQC2HBEA4kzMWYTyaj5jgURdA@mail.gmail.com>
 <C74CD745-0E6D-410C-B942-416AF365B492@amacapital.net>
 <CAHk-=wgpmV2B=s2xE5385Jzy2tEZuiW+MSPveJBfpqUoFdGydg@mail.gmail.com>
 <0D9E579C-F980-4BB7-A282-42206F6636F3@amacapital.net>
In-Reply-To: <0D9E579C-F980-4BB7-A282-42206F6636F3@amacapital.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: _152VRO_PfyeL8BccYBtBg-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBMdXRvbWlyc2tpDQo+IFNlbnQ6IDIzIE5vdmVtYmVyIDIwMTggMTk6MTENCj4g
PiBPbiBOb3YgMjMsIDIwMTgsIGF0IDExOjQ0IEFNLCBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNA
bGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiA+DQo+ID4+IE9uIEZyaSwgTm92IDIzLCAy
MDE4IGF0IDEwOjM5IEFNIEFuZHkgTHV0b21pcnNraSA8bHV0b0BhbWFjYXBpdGFsLm5ldD4gd3Jv
dGU6DQo+ID4+DQo+ID4+IFdoYXQgaXMgbWVtY3B5X3RvX2lvIGV2ZW4gc3VwcG9zZWQgdG8gZG8/
ICBJ4oCZbSBndWVzc2luZyBpdOKAmXMgZGVmaW5lZCBhcw0KPiA+PiBzb21ldGhpbmcgbGlrZSDi
gJxjb3B5IHRoaXMgZGF0YSB0byBJTyBzcGFjZSB1c2luZyBhdCBtb3N0IGxvbmctc2l6ZWQgd3Jp
dGVzLA0KPiA+PiBhbGwgYWxpZ25lZCwgYW5kIHdyaXRpbmcgZWFjaCBieXRlIGV4YWN0bHkgb25j
ZSwgaW4gb3JkZXIu4oCdDQo+ID4+IFRoYXQgc291bmRzLi4uIGR1YmlvdXNseSB1c2VmdWwuDQo+
ID4NCj4gPiBXZSd2ZSBnb3QgaHVuZHJlZHMgb2YgdXNlcnMgb2YgaXQsIHNvIGl0J3MgZmFpcmx5
IGNvbW1vbi4uDQo+IA0KPiBJ4oCZbSB3b25kZXJpbmcgaWYgdGhlIOKAnGF0IG1vc3QgbG9uZy1z
aXplc+KAnSByZXN0cmljdGlvbiBtYXR0ZXJzLCBlc3BlY2lhbGx5DQo+IGdpdmVuIHRoYXQgd2Xi
gJlyZSBhcHBhcmVudGx5IGFjY2Vzc2luZyBzb21lIG9mIHRoZSBzYW1lIGJ5dGVzIG1vcmUgdGhh
biBvbmNlLg0KPiBJIHdvdWxkIGJlbGlldmUgdGhhdCB0cnlpbmcgdG8gZW5jb3VyYWdlIDE2LWJ5
dGUgd3JpdGVzICh3aXRoIEFWWCwgdWdoKSBvcg0KPiA2NC1ieXRlIHdyaXRlcyAod2l0aCBNT1ZE
SVI2NEIpIHdvdWxkIGJlIHNhZmUgYW5kIGNvdWxkIG1lYW5pbmdmdWxseSBzcGVlZA0KPiB1cCBz
b21lIHdvcmtsb2Fkcy4NCg0KVGhlIHJlYWwgZ2FpbnMgY29tZSBmcm9tIGluY3JlYXNpbmcgdGhl
IHdpZHRoIG9mIElPIHJlYWRzLCBub3QgSU8gd3JpdGVzLg0KTm9uZSBvZiB0aGUgeDg2IGNwdXMg
SSd2ZSBnb3QgaXNzdWUgbXVsdGlwbGUgY29uY3VycmVudCBQQ0llIHJlYWRzDQoodGhlIFBDSWUg
Y29tcGxldGlvbiB0YWcgc2VlbXMgdG8gbWF0Y2ggdGhlIGNvcmUgbnVtYmVyKS4NClBDSWUgd3Jp
dGVzIGFyZSBhbGwgJ3Bvc3RlZCcgc28gdGhlcmUgYXJlbid0IGJpZyBnYXBzIGJldHdlZW4gdGhl
bS4NCg0KPiA+PiBJIGNvdWxkIHNlZSBhIGZ1bmN0aW9uIHRoYXQgd3JpdGVzIHRvIGFsaWduZWQg
bWVtb3J5IGluIHNwZWNpZmllZC1zaXplZCBjaHVua3MuDQo+ID4NCj4gPiBXZSBoYXZlIHRoYXQu
IEl0J3MgY2FsbGVkICJfX2lvd3JpdGV7MzIsNjR9X2NvcHkoKSIuIEl0IGhhcyB2ZXJ5IGZldyB1
c2Vycy4NCg0KRm9yIHg4NiB5b3Ugd2FudCBzZXBhcmF0ZSBlbnRyeSBwb2ludHMgZm9yIHRoZSAn
cmVwIG1vdnEnIGNvcHkNCmFuZCBvbmUgdXNpbmcgYW4gaW5zdHJ1Y3Rpb24gbG9vcC4NCihQZXJo
YXBzIHdpdGggZ3VpZGFuY2UgdG8gdGhlIGN1dG92ZXIgbGVuZ3RoLikNCkluIG1vc3QgcGxhY2Vz
IHRoZSBkcml2ZXIgd2lsbCBrbm93IHdoZXRoZXIgdGhlIHNpemUgaXMgYWJvdmUgb3IgYmVsb3cN
CnRoZSBjdXRvdmVyIC0gd2hpY2ggbWlnaHQgYmUgMjU2Lg0KQ2VydGFpbmx5IHRyYW5zZmVycyBi
ZWxvdyA2NCBieXRlcyBhcmUgJ3Nob3J0Jy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBN
SzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

