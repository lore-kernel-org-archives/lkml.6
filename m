Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D92DC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A052086D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfAQXse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:48:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:42595 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfAQXse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:48:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2019 15:48:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,489,1539673200"; 
   d="scan'208";a="136723758"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jan 2019 15:48:32 -0800
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 17 Jan 2019 15:48:32 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.62]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.145]) with mapi id 14.03.0415.000;
 Thu, 17 Jan 2019 15:48:31 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "pavel@ucw.cz" <pavel@ucw.cz>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux_dti@icloud.com" <linux_dti@icloud.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH 14/17] mm: Make hibernate handle unmapped pages
Thread-Topic: [PATCH 14/17] mm: Make hibernate handle unmapped pages
Thread-Index: AQHUrfxTlKrIPpA6H0a8MvhHJCQ6Z6Wzu1IAgADTb4CAABejgIAAAf0A
Date:   Thu, 17 Jan 2019 23:48:30 +0000
Message-ID: <3c12f9b3328ee32d04a6ed3990fdf0cd3cb27532.camel@intel.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
         <20190117003259.23141-15-rick.p.edgecombe@intel.com>
         <20190117093950.GA17930@amd>
         <b224d88d91a5c45c44e176ea06dea558a8939ccf.camel@intel.com>
         <20190117234111.GA27661@amd>
In-Reply-To: <20190117234111.GA27661@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.79]
Content-Type: text/plain; charset="utf-8"
Content-ID: <303A1B4A3E7D644A826569E054F1E051@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTAxLTE4IGF0IDAwOjQxICswMTAwLCBQYXZlbCBNYWNoZWsgd3JvdGU6DQo+
IEhpIQ0KPiANCj4gPiA+ID4gRm9yIGFyY2hpdGVjdHVyZXMgd2l0aCBDT05GSUdfQVJDSF9IQVNf
U0VUX0FMSUFTLCBwYWdlcyBjYW4gYmUgdW5tYXBwZWQNCj4gPiA+ID4gYnJpZWZseSBvbiB0aGUg
ZGlyZWN0bWFwLCBldmVuIHdoZW4gQ09ORklHX0RFQlVHX1BBR0VBTExPQyBpcyBub3QNCj4gPiA+
ID4gY29uZmlndXJlZC4NCj4gPiA+ID4gU28gdGhpcyBjaGFuZ2VzIGtlcm5lbF9tYXBfcGFnZXMg
YW5kIGtlcm5lbF9wYWdlX3ByZXNlbnQgdG8gYmUgZGVmaW5lZA0KPiA+ID4gPiB3aGVuDQo+ID4g
PiA+IENPTkZJR19BUkNIX0hBU19TRVRfQUxJQVMgaXMgZGVmaW5lZCBhcyB3ZWxsLiBJdCBhbHNv
IGNoYW5nZXMgcGxhY2VzDQo+ID4gPiA+IChwYWdlX2FsbG9jLmMpIHdoZXJlIHRob3NlIGZ1bmN0
aW9ucyBhcmUgYXNzdW1lZCB0byBvbmx5IGJlIGltcGxlbWVudGVkDQo+ID4gPiA+IHdoZW4NCj4g
PiA+ID4gQ09ORklHX0RFQlVHX1BBR0VBTExPQyBpcyBkZWZpbmVkLg0KPiA+ID4gDQo+ID4gPiBX
aGljaCBhcmNoaXRlY3R1cmVzIGFyZSB0aGF0Pw0KPiA+ID4gDQo+ID4gPiBTaG91bGQgdGhpcyBi
ZSBtZXJnZWQgdG8gdGhlIHBhdGNoIHdoZXJlIEhBU19TRVRfQUxJQVMgaXMgaW50cm9kdWNlZD8g
V2UNCj4gPiA+IGRvbid0IHdhbnQgYnJva2VuIGhpYmVybmF0aW9uIGluIGJldHdlZW4uLi4uDQo+
ID4gDQo+ID4gVGhhbmtzIGZvciB0YWtpbmcgYSBsb29rLiBJdCB3YXMgYWRkZWQgZm9yIHg4NiBm
b3IgcGF0Y2ggMTMgaW4gdGhpcyBwYXRjaHNldA0KPiA+IGFuZA0KPiA+IHRoZXJlIHdhcyBpbnRl
cmVzdCBleHByZXNzZWQgZm9yIGFkZGluZyBmb3IgYXJtNjQuIElmIHlvdSBkaWRuJ3QgZ2V0IHRo
ZQ0KPiA+IHdob2xlDQo+ID4gc2V0IGFuZCB3YW50IHRvIHNlZSBsZXQgbWUga25vdyBhbmQgSSBj
YW4gc2VuZCBpdC4NCj4gDQo+IEkgZ29vZ2xlZCBpbiBpbiB0aGUgbWVhbnRpbWUuDQo+IA0KPiBB
bnl3YXksIGlmIHNvbWV0aGluZyBpcyBicm9rZW4gYmV0d2VlbiBwYXRjaCAxMyBhbmQgMTQsIHRo
ZW4gdGhleQ0KPiBzaG91bGQgYmUgc2FtZSBwYXRjaC4NCkdyZWF0LiBJdCBzaG91bGQgYmUgb2sg
YmVjYXVzZSB0aGUgbmV3IGZ1bmN0aW9ucyBhcmUgbm90IHVzZWQgYW55d2hlcmUgdW50aWwNCmFm
dGVyIHRoaXMgcGF0Y2guDQoNClRoYW5rcywNCg0KUmljaw0KDQo+ID4gPiA+IC0jaWZkZWYgQ09O
RklHX0RFQlVHX1BBR0VBTExPQw0KPiA+ID4gPiAgZXh0ZXJuIGJvb2wgX2RlYnVnX3BhZ2VhbGxv
Y19lbmFibGVkOw0KPiA+ID4gPiAtZXh0ZXJuIHZvaWQgX19rZXJuZWxfbWFwX3BhZ2VzKHN0cnVj
dCBwYWdlICpwYWdlLCBpbnQgbnVtcGFnZXMsIGludA0KPiA+ID4gPiBlbmFibGUpOw0KPiA+ID4g
PiAgDQo+ID4gPiA+ICBzdGF0aWMgaW5saW5lIGJvb2wgZGVidWdfcGFnZWFsbG9jX2VuYWJsZWQo
dm9pZCkNCj4gPiA+ID4gIHsNCj4gPiA+ID4gLQlyZXR1cm4gX2RlYnVnX3BhZ2VhbGxvY19lbmFi
bGVkOw0KPiA+ID4gPiArCXJldHVybiBJU19FTkFCTEVEKENPTkZJR19ERUJVR19QQUdFQUxMT0Mp
ICYmDQo+ID4gPiA+IF9kZWJ1Z19wYWdlYWxsb2NfZW5hYmxlZDsNCj4gPiA+ID4gIH0NCj4gPiA+
IA0KPiA+ID4gVGhpcyB3aWxsIGJyZWFrIGJ1aWxkIEFGQUlDVC4gX2RlYnVnX3BhZ2VhbGxvY19l
bmFibGVkIHZhcmlhYmxlIGRvZXMNCj4gPiA+IG5vdCBleGlzdCBpbiAhQ09ORklHX0RFQlVHX1BB
R0VBTExPQyBjYXNlLg0KPiA+ID4gDQo+ID4gPiAJCQkJCQkJCQlQYXZlbA0KPiA+IA0KPiA+IEFm
dGVyIGFkZGluZyBpbiB0aGUgQ09ORklHX0FSQ0hfSEFTX1NFVF9BTElBUyBjb25kaXRpb24gdG8g
dGhlIGlmZGVmcyBpbg0KPiA+IHRoaXMNCj4gPiBhcmVhIGl0IGxvb2tlZCBhIGxpdHRsZSBoYXJk
IHRvIHJlYWQgdG8gbWUsIHNvIEkgbW92ZWQNCj4gPiBkZWJ1Z19wYWdlYWxsb2NfZW5hYmxlZA0K
PiA+IGFuZCBleHRlcm4gYm9vbCBfZGVidWdfcGFnZWFsbG9jX2VuYWJsZWQgb3V0c2lkZSB0byBt
YWtlIGl0IGVhc2llci4gSSB0aGluaw0KPiA+IHlvdQ0KPiA+IGFyZSByaWdodCwgdGhlIGFjdHVh
bCBub24tZXh0ZXJuIHZhcmlhYmxlIGNhbiBub3QgYmUgdGhlcmUsIGJ1dCB0aGUNCj4gPiByZWZl
cmVuY2UNCj4gPiBoZXJlIGdldHMgb3B0aW1pemVkIG91dCBpbiB0aGF0IGNhc2UuDQo+ID4gDQo+
ID4gSnVzdCBkb3VibGUgY2hlY2tlZCBhbmQgaXQgYnVpbGRzIGZvciBib3RoIENPTkZJR19ERUJV
R19QQUdFQUxMT0M9biBhbmQNCj4gPiBDT05GSUdfREVCVUdfUEFHRUFMTE9DPXkgZm9yIG1lLg0K
PiANCj4gT2suDQo+IA0KPiBUaGFua3MsDQo+IAkJCQkJCQkJCVBhdmVsDQo=
