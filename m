Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F91C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FC120874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iZJZlhbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FC120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937379AbeFSH6W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:58:22 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:45669 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756206AbeFSH6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:58:20 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7BCE91E04A8;
        Tue, 19 Jun 2018 09:58:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529395098; bh=Zp5Gkhaw+FofHyhcNAuQm5ThtbmOAPsdYbBjopk8/3Q=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=iZJZlhbi1axXZdrvlRykyFUY9GjsnTgoshCgGUxm7QZbfWmXBIVBizSSyErdt1qR2
         UM4DvmX81GaDCtMQx2zdNiqZ9V8Y9rq/3+y3LTQhbuYGs1dmRwOxYopJCSgdphdHTS
         6WCd+abBc0NEN7hIMOnKSz8LXVvhvs6QotzlMBWshPSQMIhA8KpdeszyLGIW8AT6l0
         RGqZIsZowbTVD9/L8lOr2HqHaOrnfW9LOU1OB7PLlDbWeoNbMPglIxqzrS9lsG0loD
         kkoQrnZsYxyD0g1fS2/mXlkOTBi1qYbbcXrBE1LvSXjOKF44ffPPy7fd4zeWpqVii8
         ua5sFuH4Oqajg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7C90E3A5B;
        Tue, 19 Jun 2018 00:58:17 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 19 Jun 2018 00:58:17 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Tue,
 19 Jun 2018 09:58:13 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     "wbx@uclibc-ng.org" <wbx@uclibc-ng.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: Improve cmpxchng syscall implementation
Thread-Topic: [PATCH] ARC: Improve cmpxchng syscall implementation
Thread-Index: AQHTv3F6C4JZhTz2+k+N1OG5jGcfeKPX0MIAgAK2WQCALFtOgIBgw7WA
Date:   Tue, 19 Jun 2018 07:58:12 +0000
Message-ID: <fc12b39642a2c185a066b0e9b85910accac7865b.camel@synopsys.com>
References: <20180319110002.27419-1-abrodkin@synopsys.com>
         <5bc39838-b1c5-ef65-f97d-8777ed33bda0@synopsys.com>
         <1521633274.9805.30.camel@synopsys.com>
         <b4d35ed5-9e60-84c4-1081-c5d41498f189@synopsys.com>
In-Reply-To: <b4d35ed5-9e60-84c4-1081-c5d41498f189@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <992053909FB05548B46E4A12A6FB64C8@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluZWV0LA0KDQpPbiBXZWQsIDIwMTgtMDQtMTggYXQgMTE6MTYgLTA3MDAsIFZpbmVldCBH
dXB0YSB3cm90ZToNCj4gT24gMDMvMjEvMjAxOCAwNDo1NCBBTSwgQWxleGV5IEJyb2RraW4gd3Jv
dGU6DQo+ID4gLyoNCj4gPiA+ID4gICAgCSAqIFRoaXMgaXMgb25seSBmb3Igb2xkIGNvcmVzIGxh
Y2tpbmcgTExPQ0svU0NPTkQsIHdoaWNoIGJ5IGRlZmludGlvbg0KPiA+ID4gPiBAQCAtNjAsMjMg
KzYyLDQ4IEBAIFNZU0NBTExfREVGSU5FMyhhcmNfdXNyX2NtcHhjaGcsIGludCAqLCB1YWRkciwg
aW50LCBleHBlY3RlZCwgaW50LCBuZXcpDQo+ID4gPiA+ICAgIAkvKiBaIGluZGljYXRlcyB0byB1
c2Vyc3BhY2UgaWYgb3BlcmF0aW9uIHN1Y2NlZGVkICovDQo+ID4gPiA+ICAgIAlyZWdzLT5zdGF0
dXMzMiAmPSB+U1RBVFVTX1pfTUFTSzsNCj4gPiA+ID4gICAgDQo+ID4gPiA+IC0JaWYgKCFhY2Nl
c3Nfb2soVkVSSUZZX1dSSVRFLCB1YWRkciwgc2l6ZW9mKGludCkpKQ0KPiA+ID4gPiAtCQlyZXR1
cm4gLUVGQVVMVDsNCj4gPiA+ID4gKwlyZXQgPSBhY2Nlc3Nfb2soVkVSSUZZX1dSSVRFLCB1YWRk
ciwgc2l6ZW9mKCp1YWRkcikpOw0KPiA+ID4gPiArCWlmICghcmV0KQ0KPiA+ID4gPiArCQlnb3Rv
IGZhaWw7DQo+ID4gPiA+ICAgIA0KPiA+ID4gPiArYWdhaW46DQo+ID4gPiA+ICAgIAlwcmVlbXB0
X2Rpc2FibGUoKTsNCj4gPiA+ID4gICAgDQo+ID4gPiA+IC0JaWYgKF9fZ2V0X3VzZXIodXZhbCwg
dWFkZHIpKQ0KPiA+ID4gPiAtCQlnb3RvIGRvbmU7DQo+ID4gPiA+IC0NCj4gPiA+ID4gLQlpZiAo
dXZhbCA9PSBleHBlY3RlZCkgew0KPiA+ID4gPiAtCQlpZiAoIV9fcHV0X3VzZXIobmV3LCB1YWRk
cikpDQo+ID4gPiA+ICsJcmV0ID0gX19nZXRfdXNlcih2YWwsIHVhZGRyKTsNCj4gPiA+ID4gKwlp
ZiAocmV0ID09IC1FRkFVTFQpIHsNCj4gPiA+IA0KPiA+ID4gTGV0cyBzZWUgaWYgdGhpcyB3YXJy
YW50cyBhZGRpbmcgY29tcGxleGl0eSAhIFRoaXMgaW1wbGllcyB0aGF0IFRMQiBlbnRyeSB3aXRo
DQo+ID4gPiBSZWFkIHBlcm1pc3Npb25zIGRpZG4ndCBleGlzdCBmb3IgcmVhZGluZyB0aGUgdmFy
IGFuZCBwYWdlIGZhdWx0IGhhbmRsZXIgY291bGQgbm90DQo+ID4gPiB3aXJlIHVwIGV2ZW4gYSB6
ZXJvIHBhZ2UgZHVlIHRvIHByZWVtcHRfZGlzYWJsZSwgbWVhbmluZyBpdCB3YXMgc29tZXRoaW5n
IG5vdA0KPiA+ID4gdG91Y2hlZCBieSB1c2Vyc3BhY2UgYWxyZWFkeSAtIHNvcnQgb2YgdW5pbml0
aWFsaXplZCB2YXJpYWJsZSBpbiB1c2VyIGNvZGUuDQo+ID4gDQo+ID4gT2sgSSBjb21wbGV0ZWx5
IG1pc3NlZCB0aGUgZmFjdCB0aGF0IGZhc3QgcGF0aCBUTEIgbWlzcyBoYW5kbGVyIGlzIGJlaW5n
DQo+ID4gZXhlY3V0ZWQgZXZlbiBpZiB3ZSBoYXZlIHByZWVtcHRpb24gZGlzYWJsZWQuIFNvIGdp
dmVuIHRoZSBtYXBwaW5nIGV4aXN0DQo+ID4gd2UgZG8gbm90IG5lZWQgdG8gcmV0cnkgd2l0aCBl
bmFibGVkIHByZWVtcHRpb24uDQo+ID4gDQo+ID4gU3RpbGwgbWF5YmUgSSdtIGEgYml0IHBhcmFu
b2lkIGhlcmUgYnV0IElNSE8gaXQncyBnb29kIHRvIGJlIHJlYWR5IGZvciBhIGNvcm5lci1jYXNl
DQo+ID4gd2hlbiB0aGUgcG9pbnRlciBpcyBjb21wbGV0ZWx5IGJvZ3VzIGFuZCB0aGVyZSdzIG5v
IG1hcHBpbmcgZm9yIGhpbS4NCj4gPiBJIHVuZGVyc3RhbmQgdGhhdCB0b2RheSB3ZSBvbmx5IGV4
cGVjdCB0aGlzIHN5c2NhbGwgdG8gYmUgdXNlZCBmcm9tIGxpYmMncw0KPiA+IGludGVybmFscyBi
dXQgYXMgbG9uZyBhcyBzeXNjYWxsIGV4aXN0cyBub2JvZHkgc3RvcHMgYW55Ym9keSBmcm9tIHVz
aW5nIGl0DQo+ID4gZGlyZWN0bHkgd2l0aG91dCBsaWJjLiBTbyBtYXliZSBpbnN0ZWFkIG9mIGRv
aW5nIGdldF91c2VyX3BhZ2VzX2Zhc3QoKSBqdXN0DQo+ID4gc2VuZCBhIFNJR1NFR1YgdG8gdGhl
IHByb2Nlc3M/IEF0IGxlYXN0IHVzZXIgd2lsbCByZWFsaXplIHRoZXJlJ3Mgc29tZSBwcm9ibGVt
DQo+ID4gYXQgZWFybGllciBzdGFnZS4NCj4gDQo+IGlmIHRoZSBwb2ludGVyIGlzIGJvZ3VzLCB3
ZSBjdXJyZW50bHkgcmV0dXJuIC1FRkFVTFQsIGlzIHRoYXQgbm90IGVub3VnaCAhIEknbSANCj4g
ZmluZSBpZiB1IHdhbnQgdG8gY2hhbmdlIHRoYXQgdG8gc2Vndi4NCg0KT2sgZ29vZC4NCg0KPiA+
ID4gT3RoZXJ3aXNlIGl0IGlzIGV4dHJlbWVseSB1bmxpa2VseSB0byBzdGFydCB3aXRoIGEgVExC
IGVudHJ5IHdpdGggUmVhZA0KPiA+ID4gcGVybWlzc2lvbnMsIGZvbGxvd2VkIGJ5IHN5c2NhbGwg
VHJhcCBvbmx5IHRvIGZpbmQgdGhlIGVudHJ5IG1pc3NpbmcsIHVubGVzcyBhDQo+ID4gPiBnbG9i
YWwgVExCIGZsdXNoIGNhbWUgZnJvbSBvdGhlciBjb3JlcywgcmlnaHQgaW4gdGhlIG1pZGRsZS4g
QnV0IHRoaXMgc3lzY2FsbCBpcw0KPiA+ID4gbm90IGd1YXJhbnRlZWQgdG8gd29yayB3aXRoIFNN
UCBhbnl3YXlzLCBzbyBsZXRzIGlnbm9yZSBhbnkgU01QIG1pc2RvaW5ncyBoZXJlLg0KPiA+IA0K
PiA+IFdlbGwgYnV0IHRoYXQncyBleGFjdGx5IHRoZSBzaXR1YXRpb24gSSB3YXMgZGVidWdnaW5n
OiB3ZSBzdGFydCBmcm9tIGRhdGEgZnJvbSByZWFkLW9ubHkNCj4gPiBwYWdlIGFuZCBvbiBhdHRl
bXB0IHRvIHdyaXRlIGJhY2sgbW9kaWZpZWQgdmFsdWUgQ09XIG1hY2hpbmVyeSBnZXRzIGludm9s
dmVkLg0KPiANCj4gTm8gZXhhY3RseSB5b3VyIHNpdHVhdGlvbi4gSW4geW91ciBjYXNlIHRoZSBU
TEIgZW50cnkgKmRpZCogZXhpc3Qgd2l0aCBSZWFkIA0KPiBwZXJtaXNzaW9uLiBXaGF0IEkgd2Fz
IHBvaW50aW5nIHRvIGlzIHRoYXQgY2FzZSB3aGVyZSBpdCB3b3VkbCB2YW5pc2ggYmV0d2VlbiB1
c2VyIA0KPiByZWFkaW5nIHRoZSBiYWNraW5nIHBhZ2UgYW5kIG1ha2luZyBhIHN5c2NhbGwgIQ0K
DQpQcm9iYWJseSBJJ20gbWlzc2luZyBzb21ldGhpbmcgaGVyZS4gSW5kZWVkIHRoZXJlJ3MgYWxy
ZWFkeSBUTEIgZW50cnkgd2l0aCBSRUFEIHBlcm1pc3Npb24NCmFuZCB3ZSBuZWVkIFByb3RWIGV4
Y2VwdGlvbiB0byBoYXBwZW4gdG8gdXBkYXRlIHRoaXMgZW50cnkgc3VjaCB0aGF0IGl0IGJlY29t
ZXMgUkVBRC1XUklURQ0KZW5hYmxlZC4gQW5kIGluIGl0cyB0dXJuIGZvciBQcm90ViBleGNlcHRp
b24gdG8gaGFwcGVuIHdlIG5lZWQgdG8gZW5hYmxlIHByZWVtcHRpb24gYW5kDQpleGVjdXRlIF9f
cHV0X3VzZXIoKS4NCg0KPiA+ID4gTm93IGluIGNhc2UgaXQgd2FzICphbiogdW5pbml0aWFsaXpl
ZCB2YXIsIGRvIHdlIGhhdmUgdG8gZ3VhcmFudGVlIGFueSB3ZWxsDQo+ID4gPiBkZWZpbmVkIHNl
bWFudGljcyBmb3IgdGhlIGtlcm5lbCBlbXVsYXRpb24gb2YgY21weGNoZyA/IElNTyBpdCBzaG91
bGQgYmUgZmluZSB0bw0KPiA+ID4gcmV0dXJuIDAgb3IgLUVGQVVMVCBldGMuIEluZmFjdCAtRUZB
VUxUIGlzIGJldHRlciBhcyBpdCB3aWxsIGZvcmNlIGEgcmV0cnkgbG9vcCBvbg0KPiA+ID4gdXNl
ciBzaWRlLCBnaXZlbiB0aGUgdHlwaWNhbCBjbXB4Y2hnIHVzYWdlIHBhdHRlcm4uDQo+ID4gDQo+
ID4gVGhlIHByb2JsZW0gaXMgbGliYyBvbmx5IGV4cGVjdHMgdG8gZ2V0IGEgdmFsdWUgcmVhZCBm
cm9tIG1lbW9yeS4NCj4gPiBBbmQgaW4gdGhlb3J5IGV4cGVjdGVkIHZhbHVlIG1pZ2h0IGJlIC0x
NCB3aGljaCBpcyBiYXNpY2FsbHkgLUVGQVVMVC4NCj4gPiBJJ20gbm90IHRhbGtpbmcgYWJvdXQg
MCBhdCBhbGwgYmVjYXVzZSBpbiBzb21lIGNhc2VzIHRoYXQncyBleGFjdGx5IHdoYXQNCj4gPiB1
c2VyLXNwYWNlIGV4cGVjdHMuDQo+ID4gDQo+ID4gU28gaWYgd2UgcmVhZCB1bmV4cGVjdGVkIHZh
bHVlIHRoZW4gd2UnbGwganVzdCByZXR1cm4gaXQgd2l0aG91dCBldmVuIGF0dGVtcHRpbmcNCj4g
PiB0byB3cml0ZS4NCj4gPiANCj4gPiBJZiB3ZSByZWFkIGV4cGVjdGVkIGRhdGEgYnV0IGZhaWwg
dG8gd3JpdGUgdGhlbiB3ZSdsbCBzZW5kIGEgU0lHU0VHViBhbmQNCj4gPiByZXR1cm4gd2hhdGV2
ZXIuLi4gbGV0IGl0IGJlIC1FRkFVTFQgLSBhbnl3YXlzIHRoZSBhcHAgd2lsbCBiZSBraWxsZWQg
b24gZXhpdCBmcm9tDQo+ID4gdGhpcyBzeXNjYWxsLg0KPiANCj4gSSdtIG5vdCBzdXJlIHdoYXQg
eW91IG1lYW4gaGVyZS4gSSdtIGZpbmUgd2l0aCBhZGRpbmcgc2VndiBraWxsIHNlbWFudGljcywg
YnV0IA0KPiBkb24ndCB0aGluayBjb21wbGV4aXR5IGZvciBnZXRfdXNlciBpcyB3b3J0aCBpdCAh
DQoNClRoaXMgY29tcGxleGl0eSBhZGRzIHByZWRpY3RhYmlsaXR5IC0gaWYgd2UgY2Fubm90IHJl
YWQgb3Igd3JpdGUgZGF0YSB3ZSBraWxsIHRoZSBhcHAgYXMgaWYNCm91ciBub3JtYWwgTEQvU1Qg
ZmFpbHMgZnJvIHdoYXRldmVyIHJlYXNvbi4NCg0KLUFsZXhleQ==
