Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442C6ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03966215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03966215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeI0ScI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:32:08 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:25965 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727111AbeI0ScI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:32:08 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-63-qJDPQ7bwPhSZo1HHX5j1uw-1; Thu, 27 Sep 2018 13:14:01 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 27 Sep 2018 13:16:14 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 27 Sep 2018 13:16:14 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@kernel.org" <mingo@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: RE: [RFC][PATCH 3/3] locking/qspinlock: Optimize for x86
Thread-Topic: [RFC][PATCH 3/3] locking/qspinlock: Optimize for x86
Thread-Index: AQHUVYyUJvkbcmqKIk6EOuUB7ALKyaUD9acw
Date:   Thu, 27 Sep 2018 12:16:14 +0000
Message-ID: <ec232ce22c1a409180725d5e88a1175a@AcuMS.aculab.com>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.513429499@infradead.org>
In-Reply-To: <20180926111307.513429499@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: qJDPQ7bwPhSZo1HHX5j1uw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGV0ZXIgWmlqbHN0cmENCj4gU2VudDogMjYgU2VwdGVtYmVyIDIwMTggMTI6MDENCj4g
DQo+IE9uIHg4NiB3ZSBjYW5ub3QgZG8gZmV0Y2hfb3Igd2l0aCBhIHNpbmdsZSBpbnN0cnVjdGlv
biBhbmQgZW5kIHVwDQo+IHVzaW5nIGEgY21weGNoZyBsb29wLCB0aGlzIHJlZHVjZXMgZGV0ZXJt
aW5pc20uIFJlcGxhY2UgdGhlIGZldGNoX29yDQo+IHdpdGggYSB2ZXJ5IHRyaWNreSBjb21wb3Np
dGUgeGNoZzggKyBsb2FkLg0KPiANCj4gVGhlIGJhc2ljIGlkZWEgaXMgdGhhdCB3ZSB1c2UgeGNo
ZzggdG8gdGVzdC1hbmQtc2V0IHRoZSBwZW5kaW5nIGJpdA0KPiAod2hlbiBpdCBpcyBhIGJ5dGUp
IGFuZCB0aGVuIGEgbG9hZCB0byBmZXRjaCB0aGUgd2hvbGUgd29yZC4gVXNpbmcNCj4gdHdvIGlu
c3RydWN0aW9ucyBvZiBjb3Vyc2Ugb3BlbnMgYSB3aW5kb3cgd2UgcHJldmlvdXNseSBkaWQgbm90
IGhhdmUuDQouLi4NCg0KSUlSQyB0aGUgbG9hZCB3aWxsIGJlICdzbG93JyBiZWNhdXNlIGl0IHdp
bGwgaGF2ZSB0byB3YWl0IGZvciB0aGUNCmVhcmxpZXIgc3RvcmUgdG8gYWN0dWFsbHkgY29tcGxl
dGUgLSByYXRoZXIgdGhhbiBiZWluZyBzYXRpc2ZpZWQNCmJ5IGRhdGEgZnJvbSB0aGUgc3RvcmUg
YnVmZmVyIChiZWNhdXNlIHRoZSB3aWR0aHMgYXJlIGRpZmZlcmVudCkuDQoNClRoaXMgbWF5IG5v
dCBtYXR0ZXIgZm9yIHhjaGcgPw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

