Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D4EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D031B20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VZGjbuge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfAOMAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:00:39 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:56572 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfAOMAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:00:37 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2630B24E169C;
        Tue, 15 Jan 2019 04:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547553637; bh=yssTv8ar/TRQVPo1Tqh9CHf4+LK6XjKXTExcfzGWK04=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=VZGjbuget65jawfsRI7xqJC/Lu+GyCs6Jlre/rKLDr8+2Ccy7qNhOKRrzftvzOM4r
         NuFfsUYoyzWFxvR0wJYsQT7ZRyHaYFxWQSIO8YUf9DsenZ8mPoGdZSaGGKVA8wWA89
         RMc82WB41AjdVVCytrnB0JSqa6V/UCCm+ejKtckAIOE16mfdKuJ1gxTrISBnTdavVZ
         5ZjsGSke42L/AeN8eT8yPs9ZdVlSCAfsPxu4AqCA9Re325b7hSc50SOcga2s7wfGed
         ehLkatFh5/sg/+UnIKUvE9VJjXcfaApQ9oDEG6e2RmJ3ScokytZEaMChwjuTd8sXbM
         v8g6/mDf+0ONQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1189052C5;
        Tue, 15 Jan 2019 04:00:37 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 15 Jan 2019 04:00:05 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 15 Jan 2019 13:00:04 +0100
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH 1/2] ARCv2: LIB: memeset: fix doing prefetchw outside of
 buffer
Thread-Topic: [PATCH 1/2] ARCv2: LIB: memeset: fix doing prefetchw outside
 of buffer
Thread-Index: AQHUrBw9ON70BEbtlEmwQBzmBQVtyqWwKraA
Date:   Tue, 15 Jan 2019 12:00:04 +0000
Message-ID: <1547553603.24248.49.camel@synopsys.com>
References: <20190114151649.32726-1-Eugeniy.Paltsev@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA2307501464272C9@US01WEMBX2.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501464272C9@US01WEMBX2.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.66]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8A3926C9F6F7F4FBAE0E8FD779A9468@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluZWV0LA0KDQpPbiBUdWUsIDIwMTktMDEtMTUgYXQgMDE6MDkgKzAwMDAsIFZpbmVldCBH
dXB0YSB3cm90ZToNCj4gT24gMS8xNC8xOSA3OjE3IEFNLCBFdWdlbml5IFBhbHRzZXYgd3JvdGU6
DQo+ID4gQ3VycmVudCBBUkN2MiBtZW1lc2V0IGltcGxlbWVudGF0aW9uIG1heSBjYWxsICdwcmVm
ZXRjaHcnDQo+ID4gaW5zdHJ1Y3Rpb24gZm9yIGFkZHJlc3Mgd2hpY2ggbGllcyBvdXRzaWRlIG9m
IG1lbXNldCBhcmVhLg0KPiA+IFNvIHdlIGdvdCBvbmUgbW9kaWZpZWQgKGRpcnR5KSBjYWNoZSBs
aW5lIG91dHNpZGUgb2YgbWVtc2V0DQo+ID4gYXJlYS4gVGhpcyBtYXkgbGVhZCB0byBkYXRhIGNv
cnJ1cHRpb24gaWYgdGhpcyBhcmVhIGlzIHVzZWQNCj4gPiBmb3IgRE1BIElPLg0KPiA+IA0KPiA+
IEFub3RoZXIgaXNzdWUgaXMgdGhhdCBjdXJyZW50IEFSQ3YyIG1lbWVzZXQgaW1wbGVtZW50YXRp
b24NCj4gPiBtYXkgY2FsbCAncHJlYWxsb2MnIGluc3RydWN0aW9uIGZvciBMMSBjYWNoZSBsaW5l
IHdoaWNoDQo+ID4gZG9lc24ndCBmdWxseSBiZWxvbmdzIHRvIG1lbWVzZXQgYXJlYSBpbiBjYXNl
IG9mIDEyOEIgTDEgRCQNCj4gPiBsaW5lIGxlbmd0aC4gVGhhdCBsZWFkcyB0byBkYXRhIGNvcnJ1
cHRpb24uDQo+ID4gDQo+ID4gDQogKiBGaXggcHJlZmV0Y2h3L3ByZWFsbG9jIGluc3RydWN0aW9u
cyB1c2luZyBpbiBjYXNlIG9mIDY0QiBMMSBkYXRhDQo+ID4gY2FjaGUgbGluZSAoZGVmYXVsdCBj
YXNlKSBhbmQgZG9uJ3QgdXNlIHByZWZldGNoKiBpbnN0cnVjdGlvbnMNCj4gPiBmb3Igb3RoZXIg
cG9zc2libGUgTDEgZGF0YSBjYWNoZSBsaW5lIGxlbmd0aHMgKDMyQiBhbmQgMTI4QikuDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogRXVnZW5peSBQYWx0c2V2IDxFdWdlbml5LlBhbHRzZXZAc3lu
b3BzeXMuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FyYy9saWIvbWVtc2V0LWFyY2hzLlMgfCAz
MCArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIz
IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJjL2xpYi9tZW1zZXQtYXJjaHMuUyBiL2FyY2gvYXJjL2xpYi9tZW1zZXQtYXJjaHMuUw0K
PiA+IGluZGV4IDYyYWQ0YmNiODQxYS4uYzc3MTc4MzIzMzZmIDEwMDY0NA0KPiA+IC0tLSBhL2Fy
Y2gvYXJjL2xpYi9tZW1zZXQtYXJjaHMuUw0KPiA+ICsrKyBiL2FyY2gvYXJjL2xpYi9tZW1zZXQt
YXJjaHMuUw0KPiA+IEBAIC03LDExICs3LDMyIEBADQo+ID4gICAqLw0KPiA+ICANCj4gPiAgI2lu
Y2x1ZGUgPGxpbnV4L2xpbmthZ2UuaD4NCj4gPiArI2luY2x1ZGUgPGFzbS9jYWNoZS5oPg0KPiA+
ICANCj4gPiAgI3VuZGVmIFBSRUFMTE9DX05PVF9BVkFJTA0KPiA+ICANCj4gPiArLyoNCj4gPiAr
ICogVGhlIG1lbXNldCBpbXBsZW1lbnRhdGlvbiBiZWxvdyBpcyBvcHRpbWl6ZWQgdG8gdXNlIHBy
ZWZldGNodyBhbmQgcHJlYWxsb2MNCj4gPiArICogaW5zdHJ1Y3Rpb24gaW4gY2FzZSBvZiBDUFUg
d2l0aCA2NEIgTDEgZGF0YSBjYWNoZSBsaW5lIChMMV9DQUNIRV9TSElGVCA9PSA2KQ0KPiA+ICsg
KiBJZiB5b3Ugd2FudCB0byBpbXBsZW1lbnQgb3B0aW1pemVkIG1lbXNldCBmb3Igb3RoZXIgcG9z
c2libGUgTDEgZGF0YSBjYWNoZQ0KPiA+ICsgKiBsaW5lIGxlbmd0aHMgKDMyQiBhbmQgMTI4Qikg
eW91IHNob3VsZCByZXdyaXRlIGNvZGUgY2FyZWZ1bGx5IGNoZWNraW5nDQo+ID4gKyAqIHdlIGRv
bid0IGNhbGwgYW55IHByZWZldGNody9wcmVhbGxvYyBpbnN0cnVjdGlvbiBmb3IgTDEgY2FjaGUg
bGluZXMgd2hpY2gNCj4gPiArICogZG9uJ3QgYmVsb25ncyB0byBtZW1zZXQgYXJlYS4NCj4gDQo+
IEdvb2QgcG9pbnQuIEZXSVcsIGl0IGlzIHBvc3NpYmxlIHRvIHN1cHBvcnQgdGhvc2Ugbm9uIGNv
bW1vbiBsaW5lIGxlbmd0aHMgYnkgdXNpbmcNCj4gTDFfQ0FDSEVfU0hJRlQgZXRjIGluIGFzbSBj
b2RlIGJlbG93IGJ1dCBJIGFncmVlIGl0cyBub3Qgd29ydGggdGhlIHRyb3VibGUuDQo+IA0KPiA+
ICsgKi8NCj4gPiArI2lmIEwxX0NBQ0hFX1NISUZUIT02DQo+ID4gKyMgZGVmaW5lIFBSRUFMTE9D
X0lOU1RSKC4uLikNCj4gPiArIyBkZWZpbmUgUFJFRkVUQ0hXX0lOU1RSKC4uLikNCj4gPiArI2Vs
c2UgIC8qIEwxX0NBQ0hFX1NISUZUIT02ICovDQo+ID4gKyMgZGVmaW5lIFBSRUZFVENIV19JTlNU
UiguLi4pCXByZWZldGNodyBfX1ZBX0FSR1NfXw0KPiA+ICsjIGlmZGVmIFBSRUFMTE9DX05PVF9B
VkFJTA0KPiA+ICsjICBkZWZpbmUgUFJFQUxMT0NfSU5TVFIoLi4uKQlwcmVmZXRjaHcgX19WQV9B
UkdTX18NCj4gPiArIyBlbHNlDQo+ID4gKyMgIGRlZmluZSBQUkVBTExPQ19JTlNUUiguLi4pCXBy
ZWFsbG9jIF9fVkFfQVJHU19fDQo+ID4gKyMgZW5kaWYNCj4gPiArI2VuZGlmIC8qIEwxX0NBQ0hF
X1NISUZUIT02ICovDQo+ID4gKw0KPiA+ICBFTlRSWV9DRkkobWVtc2V0KQ0KPiA+IC0JcHJlZmV0
Y2h3IFtyMF0JCTsgUHJlZmV0Y2ggdGhlIHdyaXRlIGxvY2F0aW9uDQo+ID4gKwlQUkVGRVRDSFdf
SU5TVFIoW3IwXSkJOyBQcmVmZXRjaCB0aGUgZmlyc3Qgd3JpdGUgbG9jYXRpb24NCj4gPiAgCW1v
di5mCTAsIHIyDQo+ID4gIDs7OyBpZiBzaXplIGlzIHplcm8NCj4gPiAgCWp6LmQJW2JsaW5rXQ0K
PiA+IEBAIC00OCwxMSArNjksNyBAQCBFTlRSWV9DRkkobWVtc2V0KQ0KPiA+ICANCj4gPiAgCWxw
bnoJQC5Mc2V0NjRieXRlcw0KPiA+ICAJOzsgTE9PUCBTVEFSVA0KPiA+IC0jaWZkZWYgUFJFQUxM
T0NfTk9UX0FWQUlMDQo+ID4gLQlwcmVmZXRjaHcgW3IzLCA2NF0JO1ByZWZldGNoIHRoZSBuZXh0
IHdyaXRlIGxvY2F0aW9uDQo+ID4gLSNlbHNlDQo+ID4gLQlwcmVhbGxvYyAgW3IzLCA2NF0NCj4g
PiAtI2VuZGlmDQo+ID4gKwlQUkVBTExPQ19JTlNUUihbcjMsIDY0XSkgO1ByZWZldGNoIHRoZSBu
ZXh0IHdyaXRlIGxvY2F0aW9uDQo+IA0KPiBUaGVzZSBhcmUgbm90IHNvbHZpbmcgdGhlIGlzc3Vl
IC0gSSdkIGJyZWFrIHRoaXMgdXAgYW5kIG1vdmUgdGhlc2UgYml0cyB0byB5b3VyDQo+IG5leHQg
cGF0Y2guDQoNCkFjdHVhbGx5IHRoZXNlIGFyZSBzb2x2aW5nIGFub3RoZXIgaXNzdWUgLSBjdXJy
ZW50IGltcGxlbWVudGF0aW9uIG1heSBjYWxsDQoncHJlYWxsb2MnIGluc3RydWN0aW9uIGZvciBM
MSBjYWNoZSBsaW5lIHdoaWNoIGRvZXNuJ3QgZnVsbHkgYmVsb25ncyB0bw0KbWVtZXNldCBhcmVh
IGluIGNhc2Ugb2YgMTI4QiBMMSBEJCBsaW5lIGxlbmd0aC4gQXMgdGhlICdwcmVhbGxvYycgZmls
bCBjYWNoZSBsaW5lDQp3aXRoIHplcm9zIHRoaXMgbGVhZHMgdG8gZGF0YSBjb3JydXB0aW9uLg0K
DQpTbyBJIHdvdWxkIGJldHRlciBrZWVwIHRoZXNlIGNoYW5nZXMgaW4gdGhpcyAnZml4JyBwYXRj
aC4NCg0KDQpCVFcsIEkndmUgZm9yZ290IGFnYWluIHRvIGFkZCBDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZywgY291bGQgeW91IGFkZCBpdCBmb3IgbWUsDQp3aGVuIGFwcGx5aW5nIHBhdGNoPw0K
VGhhbmtzLg0KDQoNCj4gPiAgI2lmZGVmIENPTkZJR19BUkNfSEFTX0xMNjQNCj4gPiAgCXN0ZC5h
YglyNCwgW3IzLCA4XQ0KPiA+ICAJc3RkLmFiCXI0LCBbcjMsIDhdDQo+ID4gQEAgLTg1LDcgKzEw
Miw2IEBAIEVOVFJZX0NGSShtZW1zZXQpDQo+ID4gIAlsc3IuZglscF9jb3VudCwgcjIsIDUgO0xh
c3QgcmVtYWluaW5nICBtYXggMTI0IGJ5dGVzDQo+ID4gIAlscG56CS5Mc2V0MzJieXRlcw0KPiA+
ICAJOzsgTE9PUCBTVEFSVA0KPiA+IC0JcHJlZmV0Y2h3ICAgW3IzLCAzMl0JO1ByZWZldGNoIHRo
ZSBuZXh0IHdyaXRlIGxvY2F0aW9uDQo+IA0KPiBTbyB0aGUgcmVhbCBmaXggZm9yIGlzc3VlIGF0
IGhhbmQgaXMgdGhpcyBsaW5lLiBJJ2xsIGtlZXAgdGhpcyBmb3IgdGhlIGZpeCBhbmQNCj4gYmVl
ZiB1cCB0aGUgY2hhbmdlbG9nLiBUaGluZyBpcyBleGlzdGluZyBjb2RlIHdhcyBhbHJlYWR5IHNr
aXBwaW5nIHRoZSBsYXN0IDY0Qg0KPiBmcm9tIHRoZSBtYWluIGxvb3AgKHRodXMgYXZvaWRlZCBw
cmVmZXRjaGluZyB0aGUgbmV4dCBsaW5lKSwgYnV0IHRoZW4gcmVpbnRyb2R1Y2VkDQo+IHByZWZl
dGNodyBpcyBsYXN0IDMyQiBsb29wLCBzcG9pbGluZyB0aGUgcGFydHkuICBUaGF0IHByZWZldGNo
dyB3YXMgcG9pbnRsZXNzIGFueXdheXMNCj4gDQo+IC1WaW5lZXQNCi0tIA0KIEV1Z2VuaXkgUGFs
dHNldg==
