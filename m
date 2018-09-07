Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD40C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8072520844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8072520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeIGFxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:53:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:44479 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbeIGFxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:53:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 18:15:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,340,1531810800"; 
   d="scan'208";a="86712052"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga004.fm.intel.com with ESMTP; 06 Sep 2018 18:15:03 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 6 Sep 2018 18:14:38 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 6 Sep 2018 18:14:38 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.240]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.16]) with mapi id 14.03.0319.002;
 Fri, 7 Sep 2018 09:14:34 +0800
From:   "Yang, Bin" <bin.yang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Gross, Mark" <mark.gross@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v3 4/5] x86/mm: optimize static_protection() by using
 overlap()
Thread-Topic: [PATCH v3 4/5] x86/mm: optimize static_protection() by using
 overlap()
Thread-Index: AQHUOOyiLUEwozeDmEmpKrJdpg0FR6Tfm9CAgAP8LwA=
Date:   Fri, 7 Sep 2018 01:14:33 +0000
Message-ID: <82fc8d80749f920c4a5107469924205d92037785.camel@intel.com>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
         <1534814186-37067-5-git-send-email-bin.yang@intel.com>
         <alpine.DEB.2.21.1809041413070.3395@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809041413070.3395@nanos.tec.linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.0 
x-originating-ip: [10.239.4.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E58D0E59612C094D8EA40451ECA6E0BF@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA5LTA0IGF0IDE0OjIyICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIFR1ZSwgMjEgQXVnIDIwMTgsIEJpbiBZYW5nIHdyb3RlOg0KPiA+ICANCj4gPiArc3Rh
dGljIGlubGluZSBib29sDQo+ID4gK292ZXJsYXAodW5zaWduZWQgbG9uZyBzdGFydDEsIHVuc2ln
bmVkIGxvbmcgZW5kMSwNCj4gPiArCQl1bnNpZ25lZCBsb25nIHN0YXJ0MiwgdW5zaWduZWQgbG9u
ZyBlbmQyKQ0KPiA+ICt7DQo+ID4gKwkvKiBJcyAnc3RhcnQyJyB3aXRoaW4gYXJlYSAxPyAqLw0K
PiA+ICsJaWYgKHN0YXJ0MSA8PSBzdGFydDIgJiYgZW5kMSA+IHN0YXJ0MikNCj4gPiArCQlyZXR1
cm4gdHJ1ZTsNCj4gPiArDQo+ID4gKwkvKiBJcyAnc3RhcnQxJyB3aXRoaW4gYXJlYSAyPyAqLw0K
PiA+ICsJaWYgKHN0YXJ0MiA8PSBzdGFydDEgJiYgZW5kMiA+IHN0YXJ0MSkNCj4gPiArCQlyZXR1
cm4gdHJ1ZTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gZmFsc2U7DQo+ID4gIHN0YXRpYyBpbmxpbmUg
dW5zaWduZWQgbG9uZyBoaWdobWFwX3N0YXJ0X3Bmbih2b2lkKQ0KPiA+IEBAIC0yOTMsNyArMzA4
LDcgQEAgc3RhdGljIHZvaWQgY3BhX2ZsdXNoX2FycmF5KHVuc2lnbmVkIGxvbmcgKnN0YXJ0LCBp
bnQgbnVtcGFnZXMsIGludCBjYWNoZSwNCj4gPiAgICogY2hlY2tzIGFuZCBmaXhlcyB0aGVzZSBr
bm93biBzdGF0aWMgcmVxdWlyZWQgcHJvdGVjdGlvbiBiaXRzLg0KPiA+ICAgKi8NCj4gPiAgc3Rh
dGljIGlubGluZSBwZ3Byb3RfdCBzdGF0aWNfcHJvdGVjdGlvbnMocGdwcm90X3QgcHJvdCwgdW5z
aWduZWQgbG9uZyBhZGRyZXNzLA0KPiA+IC0JCQkJICAgdW5zaWduZWQgbG9uZyBwZm4pDQo+ID4g
KwkJCQkgICB1bnNpZ25lZCBsb25nIGxlbiwgdW5zaWduZWQgbG9uZyBwZm4pDQo+ID4gIHsNCj4g
PiAgCXBncHJvdF90IGZvcmJpZGRlbiA9IF9fcGdwcm90KDApOw0KPiA+ICANCj4gPiBAQCAtMzAy
LDcgKzMxNyw5IEBAIHN0YXRpYyBpbmxpbmUgcGdwcm90X3Qgc3RhdGljX3Byb3RlY3Rpb25zKHBn
cHJvdF90IHByb3QsIHVuc2lnbmVkIGxvbmcgYWRkcmVzcywNCj4gPiAgCSAqIFBDSSBCSU9TIGJh
c2VkIGNvbmZpZyBhY2Nlc3MgKENPTkZJR19QQ0lfR09CSU9TKSBzdXBwb3J0Lg0KPiA+ICAJICov
DQo+ID4gICNpZmRlZiBDT05GSUdfUENJX0JJT1MNCj4gPiAtCWlmIChwY2liaW9zX2VuYWJsZWQg
JiYgd2l0aGluKHBmbiwgQklPU19CRUdJTiA+PiBQQUdFX1NISUZULCBCSU9TX0VORCA+PiBQQUdF
X1NISUZUKSkNCj4gPiArCWlmIChwY2liaW9zX2VuYWJsZWQgJiYNCj4gPiArCSAgICBvdmVybGFw
KHBmbiwgcGZuICsgUEZOX0RPV04obGVuKSwNCj4gPiArCQkgICAgUEZOX0RPV04oQklPU19CRUdJ
TiksIFBGTl9ET1dOKEJJT1NfRU5EKSkpDQo+IA0KPiBUaGlzIGlzIGNvbXBsZXRlbHkgdW5yZWFk
YWJsZSBhbmQgYXNpZGUgb2YgdGhhdCBpdCBpcyB3cm9uZy4gWW91IGNhbm5vdCBkbw0KPiBhbiBv
dmVybGFwIGNoZWNrIHdpdGggdGhlIGZvbGxvd2luZyBjb25zdHJhaW50czoNCj4gDQo+ICAgIAkg
ICByYW5nZTFfZW5kID0gcmFuZ2UxX3N0YXJ0ICsgc2l6ZTsNCj4gICAgCSAgIHJhbmdlMl9lbmQg
PSByYW5nZTJfc3RhcnQgKyBzaXplOw0KPiANCj4gU2VlIHRoZSBkZWZpbml0aW9uIG9mIEJJT1Nf
RU5ELiBJdCdzIDB4MTAwMDAwLCBpLmUuIDFNQiwgc28gdGhlIGZvbGxvd2luZw0KPiBvdmVybGFw
IGNoZWNrIHdpbGwgZ2l2ZSB5b3UgdGhlIGZhbHNlIHJlc3VsdDoNCj4gDQo+IAlvdmVybGFwKDI1
NiwgMjU4LCAweDAwMGEwMDAwID4+IDEyLCAweDAwMTAwMDAgPj4gMTIpDQo+IA0KPiBiZWNhdXNl
DQo+IA0KPiAJMHgwMDEwMDAwID4+IDEyID0gMjU2DQo+IA0KPiBlcmdvIHdpbGwgb3ZlcmxhcCBy
ZXR1cm4gdHJ1ZS4gQWxsIG9mIHlvdXIgb3ZlcmxhcCBjaGVja3MgYXJlIGJyb2tlbi4NCj4gDQo+
IE9oIHdlbGwuDQoNCkkganVzdCB3cml0ZSBhIHRlc3QuYyB0byBjb21wYXJlIHRoZSByZXN1bHQg
YmV0d2VlbiBvdmVybGFwKCkgYW5kDQpvcmlnaW5hbCB3aXRoaW4oKS4gDQoNCjg8LS0tLS0tLS0t
IHRlc3QuYyAtLS0tLS0tLS0tLS0tLS0tDQoNCiNpbmNsdWRlIDxzdGRpby5oPg0KDQojZGVmaW5l
IGJvb2wgaW50DQojZGVmaW5lIHRydWUgMQ0KI2RlZmluZSBmYWxzZSAwDQojZGVmaW5lIFBBR0Vf
U0hJRlQgMTINCiNkZWZpbmUgQklPU19CRUdJTiAgICAgICAgICAgICAgMHgwMDBhMDAwMA0KI2Rl
ZmluZSBCSU9TX0VORCAgICAgICAgICAgICAgICAweDAwMTAwMDAwIA0KDQpzdGF0aWMgaW5saW5l
IGludA0Kd2l0aGluKHVuc2lnbmVkIGxvbmcgYWRkciwgdW5zaWduZWQgbG9uZyBzdGFydCwgdW5z
aWduZWQgbG9uZyBlbmQpDQp7DQogICAgICAgIHByaW50ZigiYWRkcj0lbGQsIHN0YXJ0PSVsZCwg
ZW5kPSVsZFxuIiwNCiAgICAgICAgICAgICAgICBhZGRyLCBzdGFydCwgZW5kKTsNCg0KICAgICAg
ICByZXR1cm4gYWRkciA+PSBzdGFydCAmJiBhZGRyIDwgZW5kOw0KfQ0KDQpzdGF0aWMgaW5saW5l
IGJvb2wNCm92ZXJsYXAodW5zaWduZWQgbG9uZyBzdGFydDEsIHVuc2lnbmVkIGxvbmcgZW5kMSwN
CiAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIHN0YXJ0MiwgdW5zaWduZWQgbG9uZyBlbmQyKQ0K
ew0KICAgICAgICBwcmludGYoInN0YXJ0MT0lbGQsIGVuZDE9JWxkLCBzdGFydDI9JWxkLCBlbmQy
PSVsZFxuIiwNCiAgICAgICAgICAgICAgICBzdGFydDEsIGVuZDEsIHN0YXJ0MiwgZW5kMik7DQoN
CiAgICAgICAgLyogSXMgJ3N0YXJ0Micgd2l0aGluIGFyZWEgMT8gKi8NCiAgICAgICAgaWYgKHN0
YXJ0MSA8PSBzdGFydDIgJiYgZW5kMSA+IHN0YXJ0MikNCiAgICAgICAgICAgICAgICByZXR1cm4g
dHJ1ZTsNCg0KICAgICAgICAvKiBJcyAnc3RhcnQxJyB3aXRoaW4gYXJlYSAyPyAqLw0KICAgICAg
ICBpZiAoc3RhcnQyIDw9IHN0YXJ0MSAmJiBlbmQyID4gc3RhcnQxKQ0KICAgICAgICAgICAgICAg
IHJldHVybiB0cnVlOw0KDQogICAgICAgIHJldHVybiBmYWxzZTsNCn0NCg0KaW50IG1haW4odm9p
ZCkNCnsgICAgICAgDQogICAgICAgIGludCByZXQ7DQogICAgICAgIGludCBwZm47DQogICAgICAg
IA0KICAgICAgICBmb3IgKHBmbiA9IDI1NjsgcGZuIDwgMjU4OyBwZm4gKyspIHsgDQogICAgICAg
ICAgICAgICAgcmV0ID0gd2l0aGluKHBmbiwgQklPU19CRUdJTiA+PiBQQUdFX1NISUZULCBCSU9T
X0VORCA+Pg0KUEFHRV9TSElGVCk7DQogICAgICAgICAgICAgICAgcHJpbnRmKCJwZm4gPSAlZCwg
d2l0aGluKCkgcmV0dXJuOiAlZFxuIiwgcGZuLCByZXQpOw0KICAgICAgICB9DQogICAgICAgIA0K
ICAgICAgICByZXQgPSBvdmVybGFwKDI1NiwgMjU4LCBCSU9TX0JFR0lOID4+IFBBR0VfU0hJRlQs
IEJJT1NfRU5EID4+DQpQQUdFX1NISUZUKTsNCiAgICAgICAgcHJpbnRmKCJvdmVybGFwKCkgcmV0
dXJuOiAlZFxuIiwgcmV0KTsNCn0NCg0KDQo4PC0tLS0tLSBvdXRwdXQgLS0tLS0tDQoNCmFkZHI9
MjU2LCBzdGFydD0xNjAsIGVuZD0yNTYNCnBmbiA9IDI1Niwgd2l0aGluKCkgcmV0dXJuOiAwDQph
ZGRyPTI1Nywgc3RhcnQ9MTYwLCBlbmQ9MjU2DQpwZm4gPSAyNTcsIHdpdGhpbigpIHJldHVybjog
MA0Kc3RhcnQxPTI1NiwgZW5kMT0yNTgsIHN0YXJ0Mj0xNjAsIGVuZDI9MjU2DQpvdmVybGFwKCkg
cmV0dXJuOiAwDQoNCg0KaXQgbG9va3MgdGhlIG92ZXJsYXAoKSByZXN1bHQgaXMgc2FtZSBhcyBv
cmlnaW5hbCBvbmUuDQoNCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gCXRnbHgNCj4gDQo+IA0K
