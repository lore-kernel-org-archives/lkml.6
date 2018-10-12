Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C87C67879
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DEF2147C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DEF2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeJMAiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:38:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:45793 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbeJMAiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:38:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 10:04:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,373,1534834800"; 
   d="scan'208";a="265185673"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga005.jf.intel.com with ESMTP; 12 Oct 2018 10:04:47 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 12 Oct 2018 10:04:47 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.23]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.89]) with mapi id 14.03.0319.002;
 Fri, 12 Oct 2018 10:04:46 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "jannh@google.com" <jannh@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] modules: Create rlimit for module space
Thread-Topic: [PATCH v2 1/7] modules: Create rlimit for module space
Thread-Index: AQHUYbu9YVGPZz5pJkS2xS0Q9I41w6UbONMAgAEU74A=
Date:   Fri, 12 Oct 2018 17:04:46 +0000
Message-ID: <7b0714e26c7c2216721641d7df16a49687927e37.camel@intel.com>
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
         <20181011233117.7883-2-rick.p.edgecombe@intel.com>
         <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
In-Reply-To: <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.168]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4DFCCCDEC8AE842B5E2158F760E7365@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEwLTEyIGF0IDAyOjM1ICswMjAwLCBKYW5uIEhvcm4gd3JvdGU6DQo+IE9u
IEZyaSwgT2N0IDEyLCAyMDE4IGF0IDE6NDAgQU0gUmljayBFZGdlY29tYmUNCj4gPHJpY2sucC5l
ZGdlY29tYmVAaW50ZWwuY29tPiB3cm90ZToNCj4gPiBUaGlzIGludHJvZHVjZXMgYSBuZXcgcmxp
bWl0LCBSTElNSVRfTU9EU1BBQ0UsIHdoaWNoIGxpbWl0cyB0aGUgYW1vdW50IG9mDQo+ID4gbW9k
dWxlIHNwYWNlIGEgdXNlciBjYW4gdXNlLiBUaGUgaW50ZW50aW9uIGlzIHRvIGJlIGFibGUgdG8g
bGltaXQgbW9kdWxlDQo+ID4gc3BhY2UNCj4gPiBhbGxvY2F0aW9ucyB0aGF0IG1heSBjb21lIGZy
b20gdW4tcHJpdmxpZGdlZCB1c2VycyBpbnNlcnRpbmcgZS9CUEYgZmlsdGVycy4NCj4gDQo+IE5v
dGUgdGhhdCBpbiBzb21lIGNvbmZpZ3VyYXRpb25zIChpaXJjIGUuZy4gdGhlIGRlZmF1bHQgVWJ1
bnR1DQo+IGNvbmZpZyksIG5vcm1hbCB1c2VycyBjYW4gdXNlIHRoZSBzdWJ1aWQgbWVjaGFuaXNt
ICh0aGUgL2V0Yy9zdWJ1aWQNCj4gY29uZmlnIGZpbGUgYW5kIHRoZSAvdXNyL2Jpbi9uZXd1aWRt
YXAgc2V0dWlkIGhlbHBlcikgdG8gZ2FpbiBhY2Nlc3MNCj4gdG8gNjU1MzYgVUlEcywgd2hpY2gg
bWVhbnMgdGhhdCBpbiBzdWNoIGEgY29uZmlndXJhdGlvbiwNCj4gUkxJTUlUX01PRFNQQUNFKjY1
NTM3IGlzIHRoZSBhY3R1YWwgbGltaXQgZm9yIG9uZSB1c2VyLiAoU2FtZSB0aGluZw0KPiBhcHBs
aWVzIHRvIFJMSU1JVF9NRU1MT0NLLikNCkFoLCB0aGF0IGlzIGEgcHJvYmxlbS4gVGhlcmUgaXMg
b25seSByb29tIGZvciBhYm91dCAxMzAsMDAwIGZpbHRlcnMgb24geDg2IHdpdGgNCktBU0xSLCBz
byBpdCBjb3VsZG4ndCByZWFsbHkgYmUgc2V0IHNtYWxsIGVub3VnaC4NCg0KSSdsbCBoYXZlIHRv
IGxvb2sgaW50byB3aGF0IHRoaXMgaXMuIFRoYW5rcyBmb3IgcG9pbnRpbmcgaXQgb3V0Lg0KDQo+
IEFsc28sIGl0IGlzIHByb2JhYmx5IHBvc3NpYmxlIHRvIHdhc3RlIGEgZmV3IHRpbWVzIGFzIG11
Y2ggdmlydHVhbA0KPiBtZW1vcnkgYXMgcGVybWl0dGVkIGJ5IHRoZSBsaW1pdCBieSBkZWxpYmVy
YXRlbHkgZnJhZ21lbnRpbmcgdmlydHVhbA0KPiBtZW1vcnk/DQpHb29kIHBvaW50LiBJIGd1ZXNz
IGlmIHRoZSBmaXJzdCBwb2ludCBjYW4gYmUgYWRkcmVzc2VkIHNvbWVob3csIHRoaXMgb25lIGNv
dWxkDQptYXliZSBiZSBzb2x2ZWQgYnkganVzdCBwaWNraW5nIGEgbG93ZXIgbGltaXQuDQoNCkFu
eSB0aG91Z2h0cyBvbiBpZiBpbnN0ZWFkIG9mIGFsbCB0aGlzIHRoZXJlIHdhcyBqdXN0IGEgc3lz
dGVtIHdpZGUgbGltaXQgb24gQlBGDQpKSVQgbW9kdWxlIHNwYWNlIHVzYWdlPw0KDQo+ID4gVGhl
cmUgaXMgdW5mb3J0dW5hdGVseSBubyBjcm9zcyBwbGF0Zm9ybSBwbGFjZSB0byBwZXJmb3JtIHRo
aXMgYWNjb3VudGluZw0KPiA+IGR1cmluZyBhbGxvY2F0aW9uIGluIHRoZSBtb2R1bGUgc3BhY2Us
IHNvIGluc3RlYWQgdHdvIGhlbHBlcnMgYXJlIGNyZWF0ZWQgdG8NCj4gPiBiZQ0KPiA+IGluc2Vy
dGVkIGludG8gdGhlIHZhcmlvdXMgYXJjaOKAmXMgdGhhdCBpbXBsZW1lbnQgbW9kdWxlX2FsbG9j
LiBUaGVzZQ0KPiA+IGhlbHBlcnMgcGVyZm9ybSB0aGUgY2hlY2tzIGFuZCBoZWxwIHdpdGggdHJh
Y2tpbmcuIFRoZSBpbnRlbnRpb24gaXMgdGhhdA0KPiA+IHRoZXkNCj4gPiBhbiBiZSBhZGRlZCB0
byB0aGUgdmFyaW91cyBhcmNo4oCZcyBhcyBlYXNpbHkgYXMgcG9zc2libGUuDQo+IA0KPiBuaXQ6
IHMvYW4vY2FuLw0KPiANCj4gWy4uLl0NCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL21vZHVsZS5j
IGIva2VybmVsL21vZHVsZS5jDQo+ID4gaW5kZXggNjc0NmM4NTUxMWZlLi4yZWY5ZWQ5NWJmNjAg
MTAwNjQ0DQo+ID4gLS0tIGEva2VybmVsL21vZHVsZS5jDQo+ID4gKysrIGIva2VybmVsL21vZHVs
ZS5jDQo+ID4gQEAgLTIxMTAsOSArMjExMCwxMzkgQEAgc3RhdGljIHZvaWQgZnJlZV9tb2R1bGVf
ZWxmKHN0cnVjdCBtb2R1bGUgKm1vZCkNCj4gPiAgfQ0KPiA+ICAjZW5kaWYgLyogQ09ORklHX0xJ
VkVQQVRDSCAqL2l0IA0KPiA+IA0KPiA+ICtzdHJ1Y3QgbW9kX2FsbG9jX3VzZXIgew0KPiA+ICsg
ICAgICAgc3RydWN0IHJiX25vZGUgbm9kZTsNCj4gPiArICAgICAgIHVuc2lnbmVkIGxvbmcgYWRk
cjsNCj4gPiArICAgICAgIHVuc2lnbmVkIGxvbmcgcGFnZXM7DQo+ID4gKyAgICAgICBrdWlkX3Qg
dWlkOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIHN0cnVjdCByYl9yb290IGFsbG9jX3Vz
ZXJzID0gUkJfUk9PVDsNCj4gPiArc3RhdGljIERFRklORV9TUElOTE9DSyhhbGxvY191c2Vyc19s
b2NrKTsNCj4gDQo+IFdoeSBhbGwgdGhlIHJidHJlZSBzdHVmZiBpbnN0ZWFkIG9mIHN0YXNoaW5n
IGEgcG9pbnRlciBpbiBzdHJ1Y3QNCj4gdm1hcF9hcmVhLCBvciBzb21ldGhpbmcgbGlrZSB0aGF0
Pw0KDQpTaW5jZSB0aGUgdHJhY2tpbmcgd2FzIG5vdCBmb3IgYWxsIHZtYWxsb2MgdXNhZ2UsIHRo
ZSBpbnRlbnRpb24gd2FzIHRvIG5vdCBibG9hdA0KdGhlIHN0cnVjdHVyZSBmb3Igb3RoZXIgdXNh
Z2VzIGxpa2VzIHN0YWNrcy4gSSB0aG91Z2h0IHVzdWFsbHkgdGhlcmUgd291bGRuJ3QgYmUNCm5l
YXJseSBhcyBtdWNoIG1vZHVsZSBzcGFjZSBhbGxvY2F0aW9ucyBhcyB0aGVyZSB3b3VsZCBiZSBr
ZXJuZWwgc3RhY2tzLCBidXQgSQ0KZGlkbid0IGRvIGFueSBhY3R1YWwgbWVhc3VyZW1lbnRzIG9u
IHRoZSB0cmFkZW9mZnMuDQoNCj4gWy4uLl0NCj4gPiAraW50IGNoZWNrX2luY19tb2RfcmxpbWl0
KHVuc2lnbmVkIGxvbmcgc2l6ZSkNCj4gPiArew0KPiA+ICsgICAgICAgc3RydWN0IHVzZXJfc3Ry
dWN0ICp1c2VyID0gZ2V0X2N1cnJlbnRfdXNlcigpOw0KPiA+ICsgICAgICAgdW5zaWduZWQgbG9u
ZyBtb2RzcGFjZV9wYWdlcyA9IHJsaW1pdChSTElNSVRfTU9EU1BBQ0UpID4+DQo+ID4gUEFHRV9T
SElGVDsNCj4gPiArICAgICAgIHVuc2lnbmVkIGxvbmcgY3VyX3BhZ2VzID0gYXRvbWljX2xvbmdf
cmVhZCgmdXNlci0+bW9kdWxlX3ZtKTsNCj4gPiArICAgICAgIHVuc2lnbmVkIGxvbmcgbmV3X3Bh
Z2VzID0gZ2V0X21vZF9wYWdlX2NudChzaXplKTsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAocmxp
bWl0KFJMSU1JVF9NT0RTUEFDRSkgIT0gUkxJTV9JTkZJTklUWQ0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICYmIGN1cl9wYWdlcyArIG5ld19wYWdlcyA+IG1vZHNwYWNlX3BhZ2VzKSB7DQo+
ID4gKyAgICAgICAgICAgICAgIGZyZWVfdWlkKHVzZXIpOw0KPiA+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gMTsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICBhdG9taWNfbG9uZ19h
ZGQobmV3X3BhZ2VzLCAmdXNlci0+bW9kdWxlX3ZtKTsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAo
YXRvbWljX2xvbmdfcmVhZCgmdXNlci0+bW9kdWxlX3ZtKSA+IG1vZHNwYWNlX3BhZ2VzKSB7DQo+
ID4gKyAgICAgICAgICAgICAgIGF0b21pY19sb25nX3N1YihuZXdfcGFnZXMsICZ1c2VyLT5tb2R1
bGVfdm0pOw0KPiA+ICsgICAgICAgICAgICAgICBmcmVlX3VpZCh1c2VyKTsNCj4gPiArICAgICAg
ICAgICAgICAgcmV0dXJuIDE7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgZnJl
ZV91aWQodXNlcik7DQo+IA0KPiBJZiB5b3UgZHJvcCB0aGUgcmVmZXJlbmNlIG9uIHRoZSB1c2Vy
X3N0cnVjdCwgYW4gYXR0YWNrZXIgd2l0aCB0d28NCj4gVUlEcyBjYW4gY2hhcmdlIG1vZHVsZSBh
bGxvY2F0aW9ucyB0byBVSUQgQSwga2VlcCB0aGUgYXNzb2NpYXRlZA0KPiBzb2NrZXRzIGFsaXZl
IGFzIFVJRCBCLCBhbmQgdGhlbiBsb2cgb3V0IGFuZCBiYWNrIGluIGFnYWluIGFzIFVJRCBBLg0K
PiBBdCB0aGF0IHBvaW50LCBub2JvZHkgaXMgY2hhcmdlZCBmb3IgdGhlIG1vZHVsZSBzcGFjZSBh
bnltb3JlLiBJZiB5b3UNCj4gbG9vayBhdCB0aGUgZUJQRiBpbXBsZW1lbnRhdGlvbiwgeW91J2xs
IHNlZSB0aGF0DQo+IGJwZl9wcm9nX2NoYXJnZV9tZW1sb2NrKCkgYWN0dWFsbHkgc3RvcmVzIGEg
cmVmY291bnRlZCBwb2ludGVyIHRvIHRoZQ0KPiB1c2VyX3N0cnVjdC4NCk9rLCBJJ2xsIHRha2Ug
YSBsb29rLiBUaGFua3MgSmFubi4NCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo=
