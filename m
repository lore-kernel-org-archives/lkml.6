Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC97C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7302420836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7302420836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937702AbeFSLmr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:42:47 -0400
Received: from smtp-out6.electric.net ([192.162.217.182]:51257 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937477AbeFSLmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:42:46 -0400
Received: from 1fVF1y-000SlA-WA by out6e.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fVF1z-000Sr2-VO; Tue, 19 Jun 2018 04:42:39 -0700
Received: by emcmailer; Tue, 19 Jun 2018 04:42:39 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out6e.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fVF1y-000SlA-WA; Tue, 19 Jun 2018 04:42:38 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 19 Jun 2018 12:43:50 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 19 Jun 2018 12:43:50 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: RE: Lazy FPU restoration / moving kernel_fpu_end() to context switch
Thread-Topic: Lazy FPU restoration / moving kernel_fpu_end() to context switch
Thread-Index: AQHUBNpjBljIDTc4FUaOV5elJcrh/aRnequA
Date:   Tue, 19 Jun 2018 11:43:50 +0000
Message-ID: <8fcc0d8f5d8f48ca92e034d0c1a3c157@AcuMS.aculab.com>
References: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
 <CALCETrU+2mBPDfkBz1i_GT1EOJau+mzj4yOK8N0UnT2pGjiUWQ@mail.gmail.com>
 <6eecf873-9d87-5345-70ba-5c064a31714b@linux.intel.com>
 <CALCETrWoDEXzH=y9sqoGWtzLPoeWgpRyUQw5AiCubX4O+UOa3w@mail.gmail.com>
In-Reply-To: <CALCETrWoDEXzH=y9sqoGWtzLPoeWgpRyUQw5AiCubX4O+UOa3w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS:  TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (s)
X-Virus-Status: Scanned by VirusSMART (c)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBMdXRvbWlyc2tpDQo+IFNlbnQ6IDE1IEp1bmUgMjAxOCAxOTo1NA0KPiBPbiBG
cmksIEp1biAxNSwgMjAxOCBhdCAxMTo1MCBBTSBEYXZlIEhhbnNlbg0KPiA8ZGF2ZS5oYW5zZW5A
bGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIDA2LzE1LzIwMTggMTE6MzEgQU0s
IEFuZHkgTHV0b21pcnNraSB3cm90ZToNCj4gPiA+IGZvciAodGhpbmcpIHsNCj4gPiA+ICAga2Vy
bmVsX2ZwdV9iZWdpbigpOw0KPiA+ID4gICBlbmNyeXB0KHRoaW5nKTsNCj4gPiA+ICAga2VybmVs
X2ZwdV9lbmQoKTsNCj4gPiA+IH0NCj4gPg0KPiA+IERvbid0IGZvcmdldCB0aGF0IHRoZSBwcm9j
ZXNzb3IgaGFzIG9wdGltaXphdGlvbnMgZm9yIHRoaXMsIHRvby4gIFRoZQ0KPiA+ICJtb2RpZmll
ZCBvcHRpbWl6YXRpb24iIHdpbGwgbm90aWNlIHRoYXQgYmV0d2VlbjoNCj4gPg0KPiA+ICAgICAg
ICAga2VybmVsX2ZwdV9lbmQoKTsgICAtPiBYUlNUT1INCj4gPiBhbmQNCj4gPiAgICAgICAgIGtl
cm5lbF9mcHVfc3RhcnQoKTsgLT4gWFNBVkUoU3xPUFQpDQo+ID4NCj4gPiB0aGUgcHJvY2Vzc29y
IGhhcyBub3QgbW9kaWZpZWQgdGhlIHN0YXRlcy4gIEl0J2xsIHNraXAgZG9pbmcgYW55IHdyaXRl
cw0KPiA+IG9mIHRoZSBzdGF0ZS4gIERvaW5nIHdoYXQgQW5keSBpcyBkZXNjcmliaW5nIGlzIHN0
aWxsIHdheSBiZXR0ZXIgdGhhbg0KPiA+IGxldHRpbmcgdGhlIHByb2Nlc3NvciBkbyBpdCwgYnV0
IHlvdSBzaG91bGQganVzdCBrbm93IHVwIGZyb250IHRoYXQgdGhpcw0KPiA+IG1heSBub3QgYmUg
YXMgbXVjaCBvZiBhIHdpbiBhcyB5b3Ugd291bGQgZXhwZWN0Lg0KPiANCj4gRXZlbiB3aXRoIHRo
ZSBtb2RpZmllZCBvcHRpbWl6YXRpb24sIGtlcm5lbF9mcHVfZW5kKCkgc3RpbGwgbmVlZHMgdG8N
Cj4gcmVsb2FkIHRoZSBzdGF0ZSB0aGF0IHdhcyB0cmFzaGVkIGJ5IHRoZSBrZXJuZWwgRlBVIHVz
ZS4gIElmIHRoZQ0KPiBrZXJuZWwgaXMgdXNpbmcgc29tZXRoaW5nIGxpa2UgQVZYNTEyIHN0YXRl
LCB0aGVuIGtlcm5lbF9mcHVfZW5kKCkNCj4gd2lsbCB0cmFuc2ZlciBhbiBlbm9ybW91cyBhbW91
bnQgb2YgZGF0YSBubyBtYXR0ZXIgaG93IGNsZXZlciB0aGUgQ1BVDQo+IGlzLiAgQW5kIEkgdGhp
bmsgSSBvbmNlIG1lYXN1cmVkIFhTQVZFT1BUIHRha2luZyBhIGh1bmRyZWQgY3ljbGVzIG9yDQo+
IHNvIGV2ZW4gd2hlbiBSRkJNPT0wLCBzbyBpdCdzIG5vdCBleGFjdGx5IHN1cGVyIGZhc3QuDQoN
CklmIHRoZSBrZXJuZWwgd2FzIGVudGVyZWQgYnkgYSBzeXN0ZW0gY2FsbCBkbyB5b3UgbmVlZCB0
byBzYXZlIHRoZSBBVlg1MTINCnN0YXRlIGF0IGFsbD8NCklJUkMgdGhlIHJlZ2lzdGVycyBhcmUg
YWxsIGRlZmluZWQgYXMgJ2NhbGxlZCBzYXZlZCcgc28gdGhlcmUgaXMgbm8gZXhwZWN0YXRpb24N
CnRoYXQgdGhleSB3aWxsIGJlIHNhdmVkIGFjcm9zcyB0aGUgc3lzY2FsbCB3cmFwcGVyIGZ1bmN0
aW9uIGNhbGwuDQpBbGwgeW91IG5lZWQgdG8gZG8gaXMgZW5zdXJlIHRoYXQgJ2tlcm5lbCcgdmFs
dWVzIGFyZW4ndCBwYXNzZWQgYmFjayB0byB1c2Vyc3BhY2UuDQpUaGVyZSBpcyBhIHNpbmdsZSBp
bnN0cnVjdGlvbiB0byB6ZXJvIGFsbCB0aGUgQVZYNTEyIHJlZ2lzdGVycy4NCg0KCURhdmlkDQoN
Cg==
