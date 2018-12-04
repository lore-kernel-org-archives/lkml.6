Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156EAC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE92B2064D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE92B2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbeLDXxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:53:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:26945 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeLDXxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:53:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 15:52:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,316,1539673200"; 
   d="scan'208";a="256842396"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga004.jf.intel.com with ESMTP; 04 Dec 2018 15:52:59 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.8]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.166]) with mapi id 14.03.0415.000;
 Tue, 4 Dec 2018 15:52:58 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "luto@kernel.org" <luto@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "jannh@google.com" <jannh@google.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
Thread-Topic: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
Thread-Index: AQHUhrIVlTqKMmCRwUWBsYfr2au/NaVuXiWAgADwQACAAENYAIAAAZmAgAA+64A=
Date:   Tue, 4 Dec 2018 23:52:58 +0000
Message-ID: <58a3b01c78b6c299f76c156f96211ff22ec28751.camel@intel.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
         <20181128000754.18056-2-rick.p.edgecombe@intel.com>
         <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
         <20181204160304.GB7195@arm.com>
         <51281e69a3722014f718a6840f43b2e6773eed90.camel@intel.com>
         <CALCETrUiEWkSjnruCbBSi8WsDm071YiU5WEqoPhZbjezS0CrFw@mail.gmail.com>
In-Reply-To: <CALCETrUiEWkSjnruCbBSi8WsDm071YiU5WEqoPhZbjezS0CrFw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.141]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C025CE13AD9EF54383CBA4E26CE01ECA@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTEyLTA0IGF0IDEyOjA5IC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+IE9uIFR1ZSwgRGVjIDQsIDIwMTggYXQgMTI6MDIgUE0gRWRnZWNvbWJlLCBSaWNrIFANCj4g
PHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUdWUsIDIw
MTgtMTItMDQgYXQgMTY6MDMgKzAwMDAsIFdpbGwgRGVhY29uIHdyb3RlOg0KPiA+ID4gT24gTW9u
LCBEZWMgMDMsIDIwMTggYXQgMDU6NDM6MTFQTSAtMDgwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4g
PiA+ID4gPiBPbiBOb3YgMjcsIDIwMTgsIGF0IDQ6MDcgUE0sIFJpY2sgRWRnZWNvbWJlIDwNCj4g
PiA+ID4gPiByaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gPiA+ID4gPiB3cm90ZToNCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBTaW5jZSB2ZnJlZSB3aWxsIGxhemlseSBmbHVzaCB0aGUgVExC
LCBidXQgbm90IGxhemlseSBmcmVlIHRoZQ0KPiA+ID4gPiA+IHVuZGVybHlpbmcNCj4gPiA+ID4g
PiBwYWdlcywNCj4gPiA+ID4gPiBpdCBvZnRlbiBsZWF2ZXMgc3RhbGUgVExCIGVudHJpZXMgdG8g
ZnJlZWQgcGFnZXMgdGhhdCBjb3VsZCBnZXQgcmUtDQo+ID4gPiA+ID4gdXNlZC4NCj4gPiA+ID4g
PiBUaGlzIGlzDQo+ID4gPiA+ID4gdW5kZXNpcmFibGUgZm9yIGNhc2VzIHdoZXJlIHRoZSBtZW1v
cnkgYmVpbmcgZnJlZWQgaGFzIHNwZWNpYWwNCj4gPiA+ID4gPiBwZXJtaXNzaW9ucw0KPiA+ID4g
PiA+IHN1Y2gNCj4gPiA+ID4gPiBhcyBleGVjdXRhYmxlLg0KPiA+ID4gPiANCj4gPiA+ID4gU28g
SSBhbSB0cnlpbmcgdG8gZmluaXNoIG15IHBhdGNoLXNldCBmb3IgcHJldmVudGluZyB0cmFuc2ll
bnQgVytYDQo+ID4gPiA+IG1hcHBpbmdzDQo+ID4gPiA+IGZyb20gdGFraW5nIHNwYWNlLCBieSBo
YW5kbGluZyBrcHJvYmVzICYgZnRyYWNlIHRoYXQgSSBtaXNzZWQgKHRoYW5rcw0KPiA+ID4gPiBh
Z2Fpbg0KPiA+ID4gPiBmb3INCj4gPiA+ID4gcG9pbnRpbmcgaXQgb3V0KS4NCj4gPiA+ID4gDQo+
ID4gPiA+IEJ1dCBhbGwgb2YgdGhlIHN1ZGRlbiwgSSBkb27igJl0IHVuZGVyc3RhbmQgd2h5IHdl
IGhhdmUgdGhlIHByb2JsZW0gdGhhdA0KPiA+ID4gPiB0aGlzDQo+ID4gPiA+ICh5b3VyKSBwYXRj
aC1zZXQgZGVhbHMgd2l0aCBhdCBhbGwuIFdlIGFscmVhZHkgY2hhbmdlIHRoZSBtYXBwaW5ncyB0
bw0KPiA+ID4gPiBtYWtlDQo+ID4gPiA+IHRoZSBtZW1vcnkgd3JpdGFibGUgYmVmb3JlIGZyZWVp
bmcgdGhlIG1lbW9yeSwgc28gd2h5IGNhbuKAmXQgd2UgbWFrZSBpdA0KPiA+ID4gPiBub24tZXhl
Y3V0YWJsZSBhdCB0aGUgc2FtZSB0aW1lPyBBY3R1YWxseSwgd2h5IGRvIHdlIG1ha2UgdGhlIG1v
ZHVsZQ0KPiA+ID4gPiBtZW1vcnksDQo+ID4gPiA+IGluY2x1ZGluZyBpdHMgZGF0YSBleGVjdXRh
YmxlIGJlZm9yZSBmcmVlaW5nIGl0Pz8/DQo+ID4gPiANCj4gPiA+IFllYWgsIHRoaXMgaXMgcmVh
bGx5IGNvbmZ1c2luZywgYnV0IEkgaGF2ZSBhIHN1c3BpY2lvbiBpdCdzIGEgY29tYmluYXRpb24N
Cj4gPiA+IG9mIHRoZSB2YXJpb3VzIGRpZmZlcmVudCBjb25maWd1cmF0aW9ucyBhbmQgaHlzdGVy
aWNhbCByYWlzaW5zLiBXZSBjYW4ndA0KPiA+ID4gcmVseSBvbiBtb2R1bGVfYWxsb2MoKSBhbGxv
Y2F0aW5nIGZyb20gdGhlIHZtYWxsb2MgYXJlYSAoc2VlIG5pb3MyKSBub3INCj4gPiA+IGNhbiB3
ZSByZWx5IG9uIGRpc2FibGVfcm9fbngoKSBiZWluZyBhdmFpbGFibGUgYXQgYnVpbGQgdGltZS4N
Cj4gPiA+IA0KPiA+ID4gSWYgd2UgKmNvdWxkKiByZWx5IG9uIG1vZHVsZSBhbGxvY2F0aW9ucyBh
bHdheXMgdXNpbmcgdm1hbGxvYygpLCB0aGVuDQo+ID4gPiB3ZSBjb3VsZCBwYXNzIGluIFJpY2sn
cyBuZXcgZmxhZyBhbmQgZHJvcCBkaXNhYmxlX3JvX254KCkgYWx0b2dldGhlcg0KPiA+ID4gYWZh
aWN0IC0tIHdobyBjYXJlcyBhYm91dCB0aGUgbWVtb3J5IGF0dHJpYnV0ZXMgb2YgYSBtYXBwaW5n
IHRoYXQncyBhYm91dA0KPiA+ID4gdG8gZGlzYXBwZWFyIGFueXdheT8NCj4gPiA+IA0KPiA+ID4g
SXMgaXQganVzdCBuaW9zMiB0aGF0IGRvZXMgc29tZXRoaW5nIGRpZmZlcmVudD8NCj4gPiA+IA0K
PiA+ID4gV2lsbA0KPiA+IA0KPiA+IFllYSBpdCBpcyByZWFsbHkgaW50ZXJ0d2luZWQuIEkgdGhp
bmsgZm9yIHg4Niwgc2V0X21lbW9yeV9ueCBldmVyeXdoZXJlDQo+ID4gd291bGQNCj4gPiBzb2x2
ZSBpdCBhcyB3ZWxsLCBpbiBmYWN0IHRoYXQgd2FzIHdoYXQgSSBmaXJzdCB0aG91Z2h0IHRoZSBz
b2x1dGlvbiBzaG91bGQNCj4gPiBiZQ0KPiA+IHVudGlsIHRoaXMgd2FzIHN1Z2dlc3RlZC4gSXQn
cyBpbnRlcmVzdGluZyB0aGF0IGZyb20gdGhlIG90aGVyIHRocmVhZCBNYXNhbWkNCj4gPiBIaXJh
bWF0c3UgcmVmZXJlbmNlZCwgc2V0X21lbW9yeV9ueCB3YXMgc3VnZ2VzdGVkIGxhc3QgeWVhciBh
bmQgd291bGQgaGF2ZQ0KPiA+IGluYWR2ZXJ0ZW50bHkgYmxvY2tlZCB0aGlzIG9uIHg4Ni4gQnV0
LCBvbiB0aGUgb3RoZXIgYXJjaGl0ZWN0dXJlcyBJIGhhdmUNCj4gPiBzaW5jZQ0KPiA+IGxlYXJu
ZWQgaXQgaXMgYSBiaXQgZGlmZmVyZW50Lg0KPiA+IA0KPiA+IEl0IGxvb2tzIGxpa2UgYWN0dWFs
bHkgbW9zdCBhcmNoJ3MgZG9uJ3QgcmUtZGVmaW5lIHNldF9tZW1vcnlfKiwgYW5kIHNvIGFsbA0K
PiA+IG9mDQo+ID4gdGhlIGZyb2JfKiBmdW5jdGlvbnMgYXJlIGFjdHVhbGx5IGp1c3Qgbm9vcHMu
IEluIHdoaWNoIGNhc2UgYWxsb2NhdGluZyBSV1gNCj4gPiBpcw0KPiA+IG5lZWRlZCB0byBtYWtl
IGl0IHdvcmsgYXQgYWxsLCBiZWNhdXNlIHRoYXQgaXMgd2hhdCB0aGUgYWxsb2NhdGlvbiBpcyBn
b2luZw0KPiA+IHRvDQo+ID4gc3RheSBhdC4gU28gaW4gdGhlc2UgYXJjaHMsIHNldF9tZW1vcnlf
bnggd29uJ3Qgc29sdmUgaXQgYmVjYXVzZSBpdCB3aWxsIGRvDQo+ID4gbm90aGluZy4NCj4gPiAN
Cj4gPiBPbiB4ODYgSSB0aGluayB5b3UgY2Fubm90IGdldCByaWQgb2YgZGlzYWJsZV9yb19ueCBm
dWxseSBiZWNhdXNlIHRoZXJlIGlzDQo+ID4gdGhlDQo+ID4gY2hhbmdpbmcgb2YgdGhlIHBlcm1p
c3Npb25zIG9uIHRoZSBkaXJlY3RtYXAgYXMgd2VsbC4gWW91IGRvbid0IHdhbnQgc29tZQ0KPiA+
IG90aGVyDQo+ID4gY2FsbGVyIGdldHRpbmcgYSBwYWdlIHRoYXQgd2FzIGxlZnQgUk8gd2hlbiBm
cmVlZCBhbmQgdGhlbiB0cnlpbmcgdG8gd3JpdGUNCj4gPiB0bw0KPiA+IGl0LCBpZiBJIHVuZGVy
c3RhbmQgdGhpcy4NCj4gPiANCj4gDQo+IEV4YWN0bHkuDQo+IA0KPiBBZnRlciBzbGlnaHRseSBt
b3JlIHRob3VnaHQsIEkgc3VnZ2VzdCByZW5hbWluZyBWTV9JTU1FRElBVEVfVU5NQVAgdG8NCj4g
Vk1fTUFZX0FESlVTVF9QRVJNUyBvciBzaW1pbGFyLiAgSXQgd291bGQgaGF2ZSB0aGUgc2VtYW50
aWNzIHlvdSB3YW50LA0KPiBidXQgaXQgd291bGQgYWxzbyBjYWxsIHNvbWUgYXJjaCBob29rcyB0
byBwdXQgYmFjayB0aGUgZGlyZWN0IG1hcA0KPiBwZXJtaXNzaW9ucyBiZWZvcmUgdGhlIGZsdXNo
LiAgRG9lcyB0aGF0IHNlZW0gcmVhc29uYWJsZT8gIEl0IHdvdWxkDQo+IG5lZWQgdG8gYmUgaG9v
a2VkIHVwIHRoYXQgaW1wbGVtZW50IHNldF9tZW1vcnlfcm8oKSwgYnV0IHRoYXQgc2hvdWxkDQo+
IGJlIHF1aXRlIGVhc3kuICBJZiBub3RoaW5nIGVsc2UsIGl0IGNvdWxkIGZhbGwgYmFjayB0byBz
ZXRfbWVtb3J5X3JvKCkNCj4gaW4gdGhlIGFic2VuY2Ugb2YgYSBiZXR0ZXIgaW1wbGVtZW50YXRp
b24uDQoNCldpdGggYXJjaCBob29rcywgSSBndWVzcyB3ZSBjb3VsZCByZW1vdmUgZGlzYWJsZV9y
b19ueCB0aGVuLiBJIHRoaW5rIHlvdSB3b3VsZA0Kc3RpbGwgaGF2ZSB0byBmbHVzaCB0d2ljZSBv
biB4ODYgdG8gcmVhbGx5IGhhdmUgbm8gV15YIHZpb2xhdGluZyB3aW5kb3cgZnJvbSB0aGUNCmRp
cmVjdCBtYXAgKEkgdGhpbmsgeDg2IGlzIHRoZSBvbmx5IG9uZSB0aGF0IHNldHMgcGVybWlzc2lv
bnMgdGhlcmU/KS4gQnV0IHRoaXMNCmNvdWxkIGJlIGRvd24gZnJvbSBzb21ldGltZXMgMy4gWW91
IGNvdWxkIGFsc28gZGlyZWN0bHkgdmZyZWUgbm9uIGV4ZWMgUk8gbWVtb3J5DQp3aXRob3V0IHNl
dF9tZW1vcnlfLCBsaWtlIGluIEJQRi4gDQoNClRoZSB2ZnJlZSBkZWZlcnJlZCBsaXN0IHdvdWxk
IG5lZWQgdG8gYmUgbW92ZWQgc2luY2UgaXQgdGhlbiBjb3VsZG4ndCByZXVzZSB0aGUNCmFsbG9j
YXRpb25zIHNpbmNlIG5vdyB0aGUgdmZyZWVkIG1lbW9yeSBtaWdodCBiZSBSTy4gSXQgY291bGQg
a21hbGxvYywgb3IgbG9va3VwDQp0aGUgdm1fc3RydWN0LiBTbyB3b3VsZCBwcm9iYWJseSBiZSBh
IGxpdHRsZSBzbG93ZXIgaW4gdGhlIGludGVycnVwdCBjYXNlLiBJcw0KdGhpcyBvaz8NCg0KVGhh
bmtzLA0KDQpSaWNrDQoNCg0K
