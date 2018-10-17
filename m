Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F196AECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B902098A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B902098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeJQTlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:41:19 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:52023 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726954AbeJQTlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:41:19 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-121-4RlVP7BLPhCT5Q8QqMIR6w-1; Wed, 17 Oct 2018 12:45:57 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 17 Oct 2018 12:45:59 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 17 Oct 2018 12:45:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: RE: [PATCH 1/3] x86/mm/pat: Disable preemption around
 __flush_tlb_all()
Thread-Topic: [PATCH 1/3] x86/mm/pat: Disable preemption around
 __flush_tlb_all()
Thread-Index: AQHUZY51U8Z+zAYLBkKoYwavGs3hNaUjMz8g///8O4CAACKJAA==
Date:   Wed, 17 Oct 2018 11:45:59 +0000
Message-ID: <903c4734c77f4fbaba8598bc2effaf78@AcuMS.aculab.com>
References: <20181016202525.29437-1-bigeasy@linutronix.de>
 <20181016202525.29437-2-bigeasy@linutronix.de>
 <acaca255a70b411488b889db9d1c31e4@AcuMS.aculab.com>
 <20181017103926.okjwwinlsyegyrhu@linutronix.de>
In-Reply-To: <20181017103926.okjwwinlsyegyrhu@linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 4RlVP7BLPhCT5Q8QqMIR6w-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogJ1NlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3InDQo+IFNlbnQ6IDE3IE9jdG9iZXIgMjAx
OCAxMTozOQ0KPiBPbiAyMDE4LTEwLTE3IDA5OjU0OjM4IFsrMDAwMF0sIERhdmlkIExhaWdodCB3
cm90ZToNCj4gPiBDYW4gaXQgbWFrZSBhbnkgc2Vuc2UgdG8gZmx1c2ggdGhlIHRsYiB3aXRoIHBy
ZWVtcHRpb24gZW5hYmxlZD8NCj4gaXQgbWlnaHQuIFVzdWFsbHkgaXQgaXMgZGlzYWJsZWQgZm9y
IG90aGVyIHJlYXNvbnMuDQoNClRoYXQncyB3aGF0IEkgbWVhbiwgaXQgc2hvdWxkIGJlIGRpc2Fi
bGVkIGJ5IHRoZSBjYWxsZXIuDQoNCj4gPiBTdXJlbHkgcHJlZW1wdGlvbiBtdXN0IGJlIGRpc2Fi
bGVkIG92ZXIgc29tZXRoaW5nIGVsc2UgYXMgd2VsbD8NCj4gSW4gdGhpcyBjYXNlIGl0IGlzIGR1
ZSB0byB0aGUgQ1IzIHJlbG9hZC4gSSBkb24ndCBzZWUgYW55dGhpbmcgZWxzZS4NCg0KUmlnaHQs
IHNvIGl0IHNob3VsZCBiZSBkaXNhYmxlZCBiZWZvcmUgdGhlIENSMyByZWxvYWQgYW5kIGVuYWJs
ZWQgYWZ0ZXI/DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

