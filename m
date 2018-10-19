Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A893ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F8320838
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F8320838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeJTAVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:21:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:39061 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727567AbeJTAVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:21:11 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-1-mF0juKmjPuevShxwYYO93Q-1; Fri, 19 Oct 2018 17:14:23 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 19 Oct 2018 17:14:25 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 19 Oct 2018 17:14:25 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "casey.fitzpatrick@timesys.com" <casey.fitzpatrick@timesys.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "m.duckeck@kunbus.de" <m.duckeck@kunbus.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "akshay.bhat@timesys.com" <akshay.bhat@timesys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
Subject: RE: [tip:irq/core] genirq: Fix race on spurious interrupt detection
Thread-Topic: [tip:irq/core] genirq: Fix race on spurious interrupt detection
Thread-Index: AQHUZ8EwaebSceNiZEOcNx/JXfS6JKUmuolg
Date:   Fri, 19 Oct 2018 16:14:25 +0000
Message-ID: <2bbbe6ba27424b3b83d7f22bafea13ad@AcuMS.aculab.com>
References: <1dfd8bbd16163940648045495e3e9698e63b50ad.1539867047.git.lukas@wunner.de>
 <tip-746a923b863a1065ef77324e1e43f19b1a3eab5c@git.kernel.org>
In-Reply-To: <tip-746a923b863a1065ef77324e1e43f19b1a3eab5c@git.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: mF0juKmjPuevShxwYYO93Q-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTHVrYXMgV3VubmVyDQo+IFNlbnQ6IDE5IE9jdG9iZXIgMjAxOCAxNjozNA0KPiANCj4g
Z2VuaXJxOiBGaXggcmFjZSBvbiBzcHVyaW91cyBpbnRlcnJ1cHQgZGV0ZWN0aW9uDQo+IA0KPiBD
b21taXQgMWU3N2QwYTFlZDc0ICgiZ2VuaXJxOiBTYW5pdGl6ZSBzcHVyaW91cyBpbnRlcnJ1cHQg
ZGV0ZWN0aW9uIG9mDQo+IHRocmVhZGVkIGlycXMiKSBtYWRlIGRldGVjdGlvbiBvZiBzcHVyaW91
cyBpbnRlcnJ1cHRzIHdvcmsgZm9yIHRocmVhZGVkDQo+IGhhbmRsZXJzIGJ5Og0KPiANCj4gYSkg
aW5jcmVtZW50aW5nIGEgY291bnRlciBldmVyeSB0aW1lIHRoZSB0aHJlYWQgcmV0dXJucyBJUlFf
SEFORExFRCwgYW5kDQo+IGIpIGNoZWNraW5nIHdoZXRoZXIgdGhhdCBjb3VudGVyIGhhcyBpbmNy
ZWFzZWQgZXZlcnkgdGltZSB0aGUgdGhyZWFkIGlzDQo+ICAgIHdva2VuLg0KDQpUaGF0IHNlZW1z
IGhvcnJpYmx5IGJyb2tlbi4NCldoYXQgaXMgaXQgdHJ5aW5nIHRvIGFjaGlldmU/DQoNClRoZXJl
IGFyZSAoYXQgbGVhc3QpIHR3byBjb21tb24gY2FzZXMgd2hlcmUgSVJRX0hBTkRMRUQgZG9lc24n
dCBnZXQgcmV0dXJuZWQuDQooVW5sZXNzIHRoZSBkcml2ZXIgYWx3YXlzIHJldHVybnMgaXQgdG8g
YXZvaWQgdGhlIG1lc3NhZ2UuKQ0KDQoxKSBUaGUgSU9XIHRoYXQgY2F1c2VzIHRoZSBoYXJkd2Fy
ZSB0byBkcm9wIGEgbGV2ZWwgc2Vuc2l0aXZlIElSUSBpcyBwb3N0ZWQNCiAgIG9uIHRoZSBidXMg
KGV0YykgYW5kIGhhcHBlbnMgbGF0ZSBlbm91Z2ggdGhhdCB0aGUgSVJRIGxpbmUgaXMgc3RpbGwN
CiAgIGFzc2VydGVkIHdoZW4gdGhlIGlyZXQgZXhlY3V0ZXMuDQogICBJZiB0aGlzIGhhcHBlbnMg
YWxsIHRoZSB0aW1lIHlvdSBuZWVkIHRvIGZsdXNoIHRoZSBJT1csIGJ1dCBpZiBvbmx5DQogICBv
Y2Nhc2lvbmFsbHkgaXQgZG9lc24ndCBtYXR0ZXIgYW5kIHlvdSBkb24ndCB3YW50IGEgbWVzc2Fn
ZS4NCg0KMikgVHlwaWNhbGx5IGFuIGV0aGVybmV0IGRyaXZlciBJU1IgaGFzIHRvIGVuYWJsZSB0
aGUgaW50ZXJydXB0IGFuZCB0aGVuDQogICBjaGVjayB0aGUgcmluZyBmb3Igd29yayBiZWZvcmUg
cmV0dXJuaW5nIGZyb20gdGhlIGludGVycnVwdC4NCiAgIElmIGEgcGFja2V0IGFycml2ZXMgYXQg
dGhpcyB0aW1lIGl0IG1pZ2h0IGJlIHByb2Nlc3NlZCBieSB0aGUgJ29sZCcNCiAgIElTUiBpbnZv
Y2F0aW9uIGJ1dCBzdGlsbCBnZW5lcmF0ZSBhbm90aGVyIGludGVycnVwdC4NCiAgIElmIG5vIG1v
cmUgcGFja2V0cyBhcnJpdmUgdGhlIHNlY29uZCBJU1IgaW52b2NhdGlvbiB3aWxsIGZpbmQgbm8g
d29yay4NCiAgIEFnYWluIHRoaXMgaXMgbm9ybWFsIGJlaGF2aW91ci4NCiAgIChEZWZlcnJpbmcg
ZXZlcnl0aGluZyB3aXRoIE5BUEkgbWlnaHQgbWFrZSB0aGlzIG5vdCBoYXBwZW4gLSBidXQgb3Ro
ZXINCiAgIGludGVycnVwdHMgZW5kIHVwIHdvcmtpbmcgdGhlIHNhbWUgd2F5LikNCg0KSWYgeW91
IGFyZSByZWFsbHkgdHJ5aW5nIHRvIGRldGVjdCAnc3R1Y2snIGludGVycnVwdHMgdGhlbiB5b3Ug
cHJvYmFibHkNCndhbnQgdG8gY291bnQgdW4taGFuZGxlZCBvbmVzIGFuZCB6ZXJvIHRoZSBjb3Vu
dCBvbiBoYW5kbGVkIG9uZXMuDQpJJ20gYWxzbyBwcmV0dHkgc3VyZSB5b3UgZG9uJ3QgbmVlZCBh
biBhdG9taWMgY291bnRlci4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

