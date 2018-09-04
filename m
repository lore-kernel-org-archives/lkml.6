Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1103C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28E420652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28E420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeIDL0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:26:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:38369 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbeIDL0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:26:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 00:02:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="87416971"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga001.jf.intel.com with ESMTP; 04 Sep 2018 00:02:02 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 4 Sep 2018 00:02:01 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 4 Sep 2018 00:02:01 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.240]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.150]) with mapi id 14.03.0319.002;
 Tue, 4 Sep 2018 15:01:58 +0800
From:   "Yang, Bin" <bin.yang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Gross, Mark" <mark.gross@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v3 1/5] x86/mm: avoid redundant checking if pgprot has
 no change
Thread-Topic: [PATCH v3 1/5] x86/mm: avoid redundant checking if pgprot has
 no change
Thread-Index: AQHUOOyjY4j6eKGfo0i2H1+4H4FSu6TeqiKAgACX8wA=
Date:   Tue, 4 Sep 2018 07:01:58 +0000
Message-ID: <76cf0aca5a2f8e9b94fd0631274a3d4ad825d077.camel@intel.com>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
         <1534814186-37067-2-git-send-email-bin.yang@intel.com>
         <alpine.DEB.2.21.1809032127550.1462@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809032127550.1462@nanos.tec.linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.4.80]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DBEE01F5EDD194BBCA2DD78C5CD82C3@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA5LTAzIGF0IDIzOjU3ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIFR1ZSwgMjEgQXVnIDIwMTgsIEJpbiBZYW5nIHdyb3RlOg0KPiA+IC0tLSBhL2FyY2gv
eDg2L21tL3BhZ2VhdHRyLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9tbS9wYWdlYXR0ci5jDQo+ID4g
QEAgLTYyOSw2ICs2MjksMjIgQEAgdHJ5X3ByZXNlcnZlX2xhcmdlX3BhZ2UocHRlX3QgKmtwdGUs
IHVuc2lnbmVkIGxvbmcgYWRkcmVzcywNCj4gPiAgCW5ld19wcm90ID0gc3RhdGljX3Byb3RlY3Rp
b25zKHJlcV9wcm90LCBhZGRyZXNzLCBwZm4pOw0KPiA+ICANCj4gPiAgCS8qDQo+ID4gKwkgKiBU
aGUgc3RhdGljX3Byb3RlY3Rpb25zKCkgaXMgdXNlZCB0byBjaGVjayBzcGVjaWZpYyBwcm90ZWN0
aW9uIGZsYWdzDQo+ID4gKwkgKiBmb3IgY2VydGFpbiBhcmVhcyBvZiBtZW1vcnkuIFRoZSBvbGQg
cGdwcm90IHNob3VsZCBiZSBjaGVja2VkIGFscmVhZHkNCj4gPiArCSAqIHdoZW4gaXQgd2FzIGFw
cGxpZWQgYmVmb3JlLiBJZiBpdCdzIG5vdCwgdGhlbiB0aGlzIGlzIGEgYnVnIGluIHNvbWUNCj4g
PiArCSAqIG90aGVyIGNvZGUgYW5kIG5lZWRzIHRvIGJlIGZpeGVkIHRoZXJlLg0KPiA+ICsJICoN
Cj4gPiArCSAqIElmIG5ldyBwZ3Byb3QgaXMgc2FtZSBhcyBvbGQgcGdwcm90LCByZXR1cm4gZGly
ZWN0bHkgd2l0aG91dCBhbnkNCj4gPiArCSAqIGFkZGl0aW9uYWwgY2hlY2tpbmcuIFRoZSBmb2xs
b3dpbmcgc3RhdGljX3Byb3RlY3Rpb25zKCkgY2hlY2tpbmcgaXMNCj4gPiArCSAqIHBvaW50bGVz
cyBpZiBwZ3Byb3QgaGFzIG5vIGNoYW5nZS4gSXQgY2FuIGF2b2lkIHRoZSByZWR1bmRhbnQNCj4g
PiArCSAqIGNoZWNraW5nIGFuZCBvcHRpbWl6ZSB0aGUgcGVyZm9ybWFuY2Ugb2YgbGFyZ2UgcGFn
ZSBzcGxpdCBjaGVja2luZy4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKHBncHJvdF92YWwobmV3X3By
b3QpID09IHBncHJvdF92YWwob2xkX3Byb3QpKSB7DQo+IA0KPiBUaGlzIGlzIGFjdHVhbGx5IGJy
b2tlbi4NCj4gDQo+IEFzc3VtZSB0aGF0IGZvciB0aGUgc3RhcnQgYWRkcmVzczoNCj4gDQo+ICAg
ICAgICByZXFfcHJvdCAhPSBvbGRfcHJvdA0KPiBhbmQNCj4gICAgICAgIG5ld19wcm90ICE9IHJl
cV9wcm90DQo+IGFuZA0KPiAgICAgICAgbmV3X3Byb3QgPT0gb2xkX3Byb3QNCj4gYW5kDQo+ICAg
ICAgICBudW1wYWdlcyA+IG51bWJlcl9vZl9zdGF0aWNfcHJvdGVjdGVkX3BhZ2VzKGFkZHJlc3Mp
DQo+IA0KPiBUaGVuIHRoZSBuZXcgY2hlY2sgd2lsbCByZXR1cm4gd2l0aCBzcGxpdCA9IE5PIGFu
ZCB0aGUgcGFnZXMgYWZ0ZXIgdGhlDQo+IHN0YXRpYyBwcm90ZWN0ZWQgYXJlYSB3b24ndCBiZSB1
cGRhdGVkIC0+IEZBSUwhIElPVywgeW91IHBhcnRpYWxseQ0KPiByZWludHJvZHVjZSB0aGUgYnVn
IHdoaWNoIHdhcyBmaXhlZCBieSBhZGRpbmcgdGhpcyBjaGVjayBsb29wLg0KPiANCj4gU28gdGhp
cyBpcyBhIG5ldyBvcHRpbWl6YXRpb24gY2hlY2sgd2hpY2ggbmVlZHMgdG8gYmU6DQo+IA0KPiAJ
aWYgKHBncHJvdF92YWwocmVxX3Byb3QpID09IHBncHJvdF92YWwob2xkX3Byb3QpKQ0KPiANCj4g
YW5kIHRoYXQgY2hlY2sgd2FudHMgdG8gZ28gYWJvdmU6DQo+IA0KPiAgIAluZXdfcHJvdCA9IHN0
YXRpY19wcm90ZWN0aW9ucyhyZXFfcHJvdCwgYWRkcmVzcywgcGZuKTsNCg0KdGhhbmtzIGZvciB5
b3VyIHN1Z2dlc3Rpb24uIEkgd2lsbCBmaXggaXQuDQoNCj4gDQo+IEJvdGggdW5kZXIgdGhlIGFz
c3VtcHRpb24gdGhhdCBvbGRfcHJvdCBpcyBjb3JyZWN0IGFscmVhZHkuDQo+IA0KPiBOb3cgdGhl
IHF1ZXN0aW9uIGlzIHdoZXRoZXIgdGhpcyBhc3N1bXB0aW9uIGNhbiBiZSBtYWRlLiBUaGUgY3Vy
cmVudCBjb2RlDQo+IGRvZXMgdGhhdCBhbHJlYWR5IHRvZGF5IGluIGNhc2Ugb2YgcGFnZSBzcGxp
dHMgYmVjYXVzZSBpdCBjb3BpZXMgdGhlDQo+IGV4aXN0aW5nIHBncHJvdCBvZiB0aGUgbGFyZ2Ug
cGFnZSB1bm1vZGlmaWVkIG92ZXIgdG8gdGhlIG5ldyBzcGxpdCBQVEUNCj4gcGFnZS4gSU9XLCBp
ZiB0aGUgY3VycmVudCBtYXBwaW5nIGlzIGluY29ycmVjdCBpdCB3aWxsIHN0YXkgdGhhdCB3YXkg
aWYNCj4gaXQncyBub3QgcGFydCBvZiB0aGUgYWN0dWFsbHkgbW9kaWZpZWQgcmFuZ2UuDQo+IA0K
PiBJJ20gYSBiaXQgd29ycmllZCBhYm91dCBub3QgaGF2aW5nIHN1Y2ggYSBjaGVjaywgYnV0IGlm
IHdlIGFkZCB0aGF0IHRoZW4NCj4gdGhpcyBzaG91bGQgYmUgZG9uZSB1bmRlciBhIGRlYnVnIG9w
dGlvbiBmb3IgcGVyZm9ybWFuY2UgcmVhc29ucy4NCj4gDQo+IFRoZSBsYXN0IHBhdGNoIHdoaWNo
IGRvZXMgdGhlIG92ZXJsYXAgY2hlY2sgaXMgZXF1YWxseSBicm9rZW46DQoNClNvcnJ5IHRoYXQg
SSBkaWQgbm90IHVuZGVyc3RhbmQgdGhlIGJyb2tlbiBvZiBsYXN0IHBhdGNoLiBJdCBjaGVja3Mg
dGhlIG9sZCBwcm90DQp0byBtYWtlIHN1cmUgd2hldGhlciBjdXJyZW50IG1hcHBpbmcgaXMgY29y
cmVjdCBhcyBiZWxvdzoNCg0KICAgIFdBUk5fT05fT05DRShuZWVkc19zdGF0aWNfcHJvdGVjdGlv
bnMob2xkX3Byb3QsIGFkZHIsIHBzaXplLCBvbGRfcGZuKSk7DQoNCklmIGl0IGlzIGNvcnJlY3Qs
IHRoZSBhYm92ZSBhc3N1bXB0aW9uIHNob3VsZCBiZSBjb3JyZWN0IGFscmVhZHkuIElmIG5vdCwg
d2UgY2FuIHNwbGl0DQp0aGUgbGFyZ2UgcGFnZS4gSXQgbG9va3Mgc2FmZSB0byBzcGxpdCBhIHdy
b25nIG1hcHBpbmcgbGFyZ2UgcGFnZS4gSSBwcmVmZXIgdG8gY2hhbmdlDQphYm92ZSB3YXJuaW5n
IGNvZGUgYXMgYmVsb3c6DQoNCiAgICBpZiAobmVlZHNfc3RhdGljX3Byb3RlY3Rpb25zKG9sZF9w
cm90LCBhZGRyLCBwc2l6ZSwgb2xkX3BmbikpIHsNCiAgICAgICAgICAgIFdBUk5fT05fT05DRSgx
KTsNCiAgICAgICAgICAgIGdvdG8gb3V0X3VubG9jazsNCiAgICB9DQoNCj4gDQo+ICsgICAgICAg
LyoNCj4gKyAgICAgICAgKiBFbnN1cmUgdGhhdCB0aGUgcmVxdWVzdGVkIHBncHJvdCBkb2VzIG5v
dCB2aW9sYXRlIHN0YXRpYyBwcm90ZWN0aW9uDQo+ICsgICAgICAgICogcmVxdWlyZW1lbnRzLg0K
PiArICAgICAgICAqLw0KPiArICAgICAgIG5ld19wcm90ID0gc3RhdGljX3Byb3RlY3Rpb25zKHJl
cV9wcm90LCBhZGRyZXNzLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG51bXBhZ2VzIDw8IFBBR0VfU0hJRlQsIHBmbik7DQo+IA0KPiBJdCBleHBhbmRzIG5ld19wcm90
IHRvIHRoZSB3aG9sZSByYW5nZSBldmVuIGlmIHRoZSBwcm90ZWN0aW9ucyBvbmx5DQo+IG92ZXJs
YXAuIFRoYXQgc2hvdWxkIG5vdCBoYXBwZW4gaW4gcHJhY3RpY2UsIGJ1dCB3ZSBoYXZlIG5vIGNo
ZWNrcyBmb3IgdGhhdA0KPiBhdCBhbGwuDQoNCkJlbG93IGNvZGUgaW4gcGF0Y2ggIzMgc2hvdWxk
IGNvdmVyIHRoaXMgY2hlY2suIEl0IHdpbGwgZG91YmxlIGNoZWNrDQpuZXdfcHJvdCBpbiB3aG9s
ZSBsYXJnZSBwYWdlIHJhbmdlLg0KDQogICAgaWYgKG5lZWRzX3N0YXRpY19wcm90ZWN0aW9ucyhu
ZXdfcHJvdCwgYWRkciwgcHNpemUsIG9sZF9wZm4pKQ0KICAgICAgICAgICAgZ290byBvdXRfdW5s
b2NrOw0KDQo+IA0KPiBUaGUgd2hvbGUgdGhpbmcgbmVlZHMgd2F5IG1vcmUgdGhvdWdodCBpbiBv
cmRlciBub3QgdG8gKHJlKWludHJvZHVjZSBzdWJ0bGUNCj4gYW5kIGhhcmQgdG8gZGVidWcgYnVn
cy4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IAl0Z2x4DQo+IA0KPiANCj4gDQo+IA0KPiANCj4gDQo+
IA0KPiANCg==
