Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE951C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCCE20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCCE20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeLKJlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:41:32 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:54768 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbeLKJlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:41:32 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-188-f40uUyDMOVqSNcM9LzdinA-1; Tue, 11 Dec 2018 09:41:27 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 11 Dec 2018 09:41:37 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 11 Dec 2018 09:41:37 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Andrew Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        Jiri Kosina <jkosina@suse.cz>, "bp@alien8.de" <bp@alien8.de>,
        "julia@ni.com" <julia@ni.com>, "jeyu@kernel.org" <jeyu@kernel.org>,
        Peter Anvin <hpa@zytor.com>
Subject: RE: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Thread-Topic: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Thread-Index: AQHUiMmXfegXbM3utEG1RWox6VieR6V5V5tg
Date:   Tue, 11 Dec 2018 09:41:37 +0000
Message-ID: <9fe3867d8f06424681ec2e75d8c6a7dd@AcuMS.aculab.com>
References: <20181129124404.2fe55dd0@gandalf.local.home>
 <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
 <20181129125857.75c55b96@gandalf.local.home>
 <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
 <20181129134725.6d86ade6@gandalf.local.home>
 <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
 <CAHk-=wjN=sow0F-UtA6DtHHT_CNUV7wYVe3cQ4E8GPp4LN32+Q@mail.gmail.com>
 <CALCETrVzFk2Yv8q54Xh6qOb45AKKrQhD5OkAuTsw9HaR3Wvy4Q@mail.gmail.com>
 <20181129202452.56f4j2wdct6qbaqo@treble>
 <CAHk-=wiO87jDPP8FZ7EfwfbFNQRdr64Pa+g33do7tKiTFYz8BA@mail.gmail.com>
 <20181130162713.uoeyfau66buntyse@treble>
In-Reply-To: <20181130162713.uoeyfau66buntyse@treble>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: f40uUyDMOVqSNcM9LzdinA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMzAgTm92ZW1iZXIgMjAxOCAxNjoyNw0KPiAN
Cj4gT24gVGh1LCBOb3YgMjksIDIwMTggYXQgMDM6MDQ6MjBQTSAtMDgwMCwgTGludXMgVG9ydmFs
ZHMgd3JvdGU6DQo+ID4gT24gVGh1LCBOb3YgMjksIDIwMTggYXQgMTI6MjUgUE0gSm9zaCBQb2lt
Ym9ldWYgPGpwb2ltYm9lQHJlZGhhdC5jb20+IHdyb3RlOg0KLi4uDQo+ID4gPiBNYXliZSB0aGF0
IHdvdWxkIGJlIG9rLiAgSWYgbXkgbWF0aCBpcyByaWdodCwgd2Ugd291bGQgdXNlIHRoZQ0KPiA+
ID4gb3V0LW9mLWxpbmUgdmVyc2lvbiBhbG1vc3QgNSUgb2YgdGhlIHRpbWUgZHVlIHRvIGNhY2hl
IG1pc2FsaWdubWVudCBvZg0KPiA+ID4gdGhlIGFkZHJlc3MuDQo+ID4NCj4gPiBOb3RlIHRoYXQg
SSBkb24ndCB0aGluayBjYWNoZS1saW5lIGFsaWdubWVudCBpcyBuZWNlc3NhcmlseSBzdWZmaWNp
ZW50Lg0KPiA+DQo+ID4gVGhlIEkkIGZldGNoIGZyb20gdGhlIGNhY2hlbGluZSBjYW4gaGFwcGVu
IGluIHNtYWxsZXIgY2h1bmtzLCBiZWNhdXNlDQo+ID4gdGhlIGJ1cyBiZXR3ZWVuIHRoZSBJJCBh
bmQgdGhlIGluc3RydWN0aW9uIGRlY29kZSBpc24ndCBhIGZ1bGwNCj4gPiBjYWNoZWxpbmUgKHdl
bGwsIGl0IGlzIF9ub3dfIGluIG1vZGVybiBiaWcgY29yZXMsIGJ1dCBpdCBoYXNuJ3QgYWx3YXlz
DQo+ID4gYmVlbikuDQo+ID4NCj4gPiBTbyBldmVuIGlmIHRoZSBjYWNoZWxpbmUgaXMgdXBkYXRl
ZCBhdG9taWNhbGx5LCBJIGNvdWxkIGltYWdpbmUgc2VlaW5nDQo+ID4gYSBwYXJ0aWFsIGZldGNo
IGZyb20gdGhlIEkkIChvbGQgdmFsdWVzKSBhbmQgdGhlbiBhIHNlY29uZCBwYXJ0aWFsDQo+ID4g
ZmV0Y2ggKG5ldyB2YWx1ZXMpLg0KPiA+DQo+ID4gSXQgd291bGQgYmUgaW50ZXJlc3RpbmcgdG8g
a25vdyB3aGF0IHRoZSBleGFjdCBmZXRjaCBydWxlcyBhcmUuDQo+IA0KPiBJJ3ZlIGJlZW4gZG9p
bmcgIHNvbWUgY3Jvc3MtbW9kaWZ5aW5nIGNvZGUgZXhwZXJpbWVudHMgb24gTmVoYWxlbSwgd2l0
aA0KPiBvbmUgQ1BVIHdyaXRpbmcgY2FsbCBkZXN0aW5hdGlvbnMgd2hpbGUgdGhlIG90aGVyIENQ
VXMgYXJlIGV4ZWN1dGluZw0KPiB0aGVtLiAgUmVsaWFibHksIG9uZSBvZiB0aGUgcmVhZGVycyBn
b2VzIG9mZiBpbnRvIHRoZSB3ZWVkcyB3aXRoaW4gYSBmZXcNCj4gc2Vjb25kcy4NCj4gDQo+IFRo
ZSB3cml0aW5nIHdhcyBkb25lIHdpdGgganVzdCB0ZXh0X3Bva2UoKSwgbm8gI0JQLg0KPiANCj4g
SSB3YXNuJ3QgYWJsZSB0byBmaWd1cmUgb3V0IHRoZSBwYXR0ZXJuIGluIHRoZSBhZGRyZXNzZXMg
b2YgdGhlDQo+IGNvcnJ1cHRlZCBjYWxsIHNpdGVzLiAgSXQgd2Fzbid0IGNhY2hlIGxpbmUuDQo+
IA0KPiBUaGF0IHdhcyBvbiBOZWhhbGVtLiAgU2t5bGFrZSBkaWRuJ3QgY3Jhc2ggYXQgYWxsLg0K
DQpJbnRlcmVzdGluZyB0aG91Z2h0Pw0KDQpJZiBpdCBpcyBwb3NzaWJsZSB0byBhZGQgYSBwcmVm
aXggdGhhdCBjYW4gYmUgb3ZlcndyaXR0ZW4gYnkgYW4gaW50Mw0KaXMgaXQgYWxzbyBwb3NzaWJs
ZSB0byBhZGQgc29tZXRoaW5nIHRoYXQgdGhlIGFzc2VtYmxlciB3aWxsIHVzZQ0KdG8gYWxpZ24g
dGhlIGluc3RydWN0aW9uIHNvIHRoYXQgYSB3cml0ZSB0byB0aGUgNCBieXRlIG9mZnNldA0Kd2ls
bCBiZSBhdG9taWM/DQoNCkknZCBndWVzcyB0aGF0IGF2b2lkaW5nIDggYnl0ZSBncmFudWxhcml0
eSB3b3VsZCBiZSBzdWZmaWNpZW50Lg0KU28geW91J2QgbmVlZCBhIDEsIDIgb3IgMyBieXRlIG5v
cCBkZXBlbmRpbmcgb24gdGhlIGFjdHVhbA0KYWxpZ25tZW50IC0gYWx0aG91Z2ggYSAzIGJ5dGUg
b25lIHdvdWxkIGFsd2F5cyBkby4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

