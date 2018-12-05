Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87373C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C2320834
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C2320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbeLEBJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:09:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:25689 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbeLEBJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:09:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 17:09:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,316,1539673200"; 
   d="scan'208";a="107344557"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga003.jf.intel.com with ESMTP; 04 Dec 2018 17:09:19 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.8]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.81]) with mapi id 14.03.0415.000;
 Tue, 4 Dec 2018 17:09:19 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "luto@kernel.org" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jannh@google.com" <jannh@google.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
Thread-Topic: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
Thread-Index: AQHUhrIVlTqKMmCRwUWBsYfr2au/NaVuXiWAgAEglYCAAA2qAIAAAQsAgAAySQCAACfeAA==
Date:   Wed, 5 Dec 2018 01:09:18 +0000
Message-ID: <3c217322e990eba0269cc5ffea761cc1a5b17f4e.camel@intel.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
         <20181128000754.18056-2-rick.p.edgecombe@intel.com>
         <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
         <CALCETrXvddt148fncMJqpjK98uatiK-44knYFWU0-ytf8X+iog@mail.gmail.com>
         <08141F66-F3E6-4CC5-AF91-1ED5F101A54C@gmail.com>
         <CALCETrXLrsKDBzDkN7sc9HYPWe9aV3NQzf4vMvM+FD8j6aA6AQ@mail.gmail.com>
         <20CC2F71-308D-42E2-8C54-F64D7CC3863F@gmail.com>
In-Reply-To: <20CC2F71-308D-42E2-8C54-F64D7CC3863F@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.141]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F456652EA8ABFA4E9207D1DA820F082B@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTEyLTA0IGF0IDE0OjQ4IC0wODAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPiA+
IE9uIERlYyA0LCAyMDE4LCBhdCAxMTo0OCBBTSwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5l
bC5vcmc+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFR1ZSwgRGVjIDQsIDIwMTggYXQgMTE6NDUgQU0g
TmFkYXYgQW1pdCA8bmFkYXYuYW1pdEBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4gPiBPbiBEZWMg
NCwgMjAxOCwgYXQgMTA6NTYgQU0sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPiB3
cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIE1vbiwgRGVjIDMsIDIwMTggYXQgNTo0MyBQTSBO
YWRhdiBBbWl0IDxuYWRhdi5hbWl0QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBO
b3YgMjcsIDIwMTgsIGF0IDQ6MDcgUE0sIFJpY2sgRWRnZWNvbWJlIDwNCj4gPiA+ID4gPiA+IHJp
Y2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gU2luY2UgdmZyZWUgd2lsbCBsYXppbHkgZmx1c2ggdGhlIFRMQiwgYnV0IG5vdCBsYXppbHkg
ZnJlZSB0aGUNCj4gPiA+ID4gPiA+IHVuZGVybHlpbmcgcGFnZXMsDQo+ID4gPiA+ID4gPiBpdCBv
ZnRlbiBsZWF2ZXMgc3RhbGUgVExCIGVudHJpZXMgdG8gZnJlZWQgcGFnZXMgdGhhdCBjb3VsZCBn
ZXQgcmUtDQo+ID4gPiA+ID4gPiB1c2VkLiBUaGlzIGlzDQo+ID4gPiA+ID4gPiB1bmRlc2lyYWJs
ZSBmb3IgY2FzZXMgd2hlcmUgdGhlIG1lbW9yeSBiZWluZyBmcmVlZCBoYXMgc3BlY2lhbA0KPiA+
ID4gPiA+ID4gcGVybWlzc2lvbnMgc3VjaA0KPiA+ID4gPiA+ID4gYXMgZXhlY3V0YWJsZS4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBTbyBJIGFtIHRyeWluZyB0byBmaW5pc2ggbXkgcGF0Y2gtc2V0
IGZvciBwcmV2ZW50aW5nIHRyYW5zaWVudCBXK1gNCj4gPiA+ID4gPiBtYXBwaW5ncw0KPiA+ID4g
PiA+IGZyb20gdGFraW5nIHNwYWNlLCBieSBoYW5kbGluZyBrcHJvYmVzICYgZnRyYWNlIHRoYXQg
SSBtaXNzZWQgKHRoYW5rcw0KPiA+ID4gPiA+IGFnYWluIGZvcg0KPiA+ID4gPiA+IHBvaW50aW5n
IGl0IG91dCkuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQnV0IGFsbCBvZiB0aGUgc3VkZGVuLCBJ
IGRvbuKAmXQgdW5kZXJzdGFuZCB3aHkgd2UgaGF2ZSB0aGUgcHJvYmxlbSB0aGF0DQo+ID4gPiA+
ID4gdGhpcw0KPiA+ID4gPiA+ICh5b3VyKSBwYXRjaC1zZXQgZGVhbHMgd2l0aCBhdCBhbGwuIFdl
IGFscmVhZHkgY2hhbmdlIHRoZSBtYXBwaW5ncyB0bw0KPiA+ID4gPiA+IG1ha2UNCj4gPiA+ID4g
PiB0aGUgbWVtb3J5IHdyaXRhYmxlIGJlZm9yZSBmcmVlaW5nIHRoZSBtZW1vcnksIHNvIHdoeSBj
YW7igJl0IHdlIG1ha2UgaXQNCj4gPiA+ID4gPiBub24tZXhlY3V0YWJsZSBhdCB0aGUgc2FtZSB0
aW1lPyBBY3R1YWxseSwgd2h5IGRvIHdlIG1ha2UgdGhlIG1vZHVsZQ0KPiA+ID4gPiA+IG1lbW9y
eSwNCj4gPiA+ID4gPiBpbmNsdWRpbmcgaXRzIGRhdGEgZXhlY3V0YWJsZSBiZWZvcmUgZnJlZWlu
ZyBpdD8/Pw0KPiA+ID4gPiANCj4gPiA+ID4gQWxsIHRoZSBjb2RlIHlvdSdyZSBsb29raW5nIGF0
IGlzIElNTyBhIHZlcnkgYXdrd2FyZCBhbmQgcG9zc2libHkNCj4gPiA+ID4gaW5jb3JyZWN0IG9m
IGRvaW5nIHdoYXQncyBhY3R1YWxseSBuZWNlc3Nhcnk6IHB1dHRpbmcgdGhlIGRpcmVjdCBtYXAN
Cj4gPiA+ID4gdGhlIHdheSBpdCB3YW50cyB0byBiZS4NCj4gPiA+ID4gDQo+ID4gPiA+IENhbid0
IHdlIHNob3ZlIHRoaXMgZW50aXJlbHkgbWVzcyBpbnRvIHZ1bm1hcD8gIEhhdmUgYSBmbGFnIChh
cyBwYXJ0DQo+ID4gPiA+IG9mIHZtYWxsb2MgbGlrZSBpbiBSaWNrJ3MgcGF0Y2ggb3IgYXMgYSBm
bGFnIHBhc3NlZCB0byBhIHZmcmVlIHZhcmlhbnQNCj4gPiA+ID4gZGlyZWN0bHkpIHRoYXQgbWFr
ZXMgdGhlIHZ1bm1hcCBjb2RlIHRoYXQgZnJlZXMgdGhlIHVuZGVybHlpbmcgcGFnZXMNCj4gPiA+
ID4gYWxzbyByZXNldCB0aGVpciBwZXJtaXNzaW9ucz8NCj4gPiA+ID4gDQo+ID4gPiA+IFJpZ2h0
IG5vdywgd2UgbXVjayB3aXRoIHNldF9tZW1vcnlfcncoKSBhbmQgc2V0X21lbW9yeV9ueCgpLCB3
aGljaA0KPiA+ID4gPiBib3RoIGhhdmUgdmVyeSBhd2t3YXJkIChhbmQgaW5jb25zaXN0ZW50IHdp
dGggZWFjaCBvdGhlciEpIHNlbWFudGljcw0KPiA+ID4gPiB3aGVuIGNhbGxlZCBvbiB2bWFsbG9j
IG1lbW9yeS4gIEFuZCB0aGV5IGhhdmUgdGhlaXIgb3duIGZsdXNoZXMsIHdoaWNoDQo+ID4gPiA+
IGlzIGluZWZmaWNpZW50LiAgTWF5YmUgdGhlIHJpZ2h0IHNvbHV0aW9uIGlzIGZvciB2dW5tYXAg
dG8gcmVtb3ZlIHRoZQ0KPiA+ID4gPiB2bWFwIGFyZWEgUFRFcywgY2FsbCBpbnRvIGEgZnVuY3Rp
b24gbGlrZSBzZXRfbWVtb3J5X3J3KCkgdGhhdCByZXNldHMNCj4gPiA+ID4gdGhlIGRpcmVjdCBt
YXBzIHRvIHRoZWlyIGRlZmF1bHQgcGVybWlzc2lvbnMgKndpdGhvdXQqIGZsdXNoaW5nLCBhbmQN
Cj4gPiA+ID4gdGhlbiB0byBkbyBhIHNpbmdsZSBmbHVzaCBmb3IgZXZlcnl0aGluZy4gIE9yLCBl
dmVuIGJldHRlciwgdG8gY2F1c2UNCj4gPiA+ID4gdGhlIGNoYW5nZV9wYWdlX2F0dHIgY29kZSB0
byBkbyB0aGUgZmx1c2ggYW5kIGFsc28gdG8gZmx1c2ggdGhlIHZtYXANCj4gPiA+ID4gYXJlYSBh
bGwgYXQgb25jZSBzbyB0aGF0IHZlcnkgc21hbGwgZnJlZSBvcGVyYXRpb25zIGNhbiBmbHVzaCBz
aW5nbGUNCj4gPiA+ID4gcGFnZXMgaW5zdGVhZCBvZiBmbHVzaGluZyBnbG9iYWxseS4NCj4gPiA+
IA0KPiA+ID4gVGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24uIEkgcmVhZCBpdCBqdXN0IGFmdGVy
IEkgcmVhbGl6ZWQgdGhhdCBpbmRlZWQNCj4gPiA+IHRoZQ0KPiA+ID4gd2hvbGUgcHVycG9zZSBv
ZiB0aGlzIGNvZGUgaXMgdG8gZ2V0IGNwYV9wcm9jZXNzX2FsaWFzKCkNCj4gPiA+IHVwZGF0ZSB0
aGUgY29ycmVzcG9uZGluZyBkaXJlY3QgbWFwcGluZy4NCj4gPiA+IA0KPiA+ID4gVGhpcyB0aGlu
ZyAocGFnZWF0dHIuYykgaW5kZWVkIHNlZW1zIG92ZXItZW5naW5lZXJlZCBhbmQgdmVyeSB1bmlu
dHVpdGl2ZS4NCj4gPiA+IFJpZ2h0IG5vdyBJIGhhdmUgYSBsaXN0IG9mIHBhdGNoLXNldHMgdGhh
dCBJIG93ZSwgc28gSSBkb27igJl0IGhhdmUgdGhlIHRpbWUNCj4gPiA+IHRvIGRlYWwgd2l0aCBp
dC4NCj4gPiA+IA0KPiA+ID4gQnV0LCBJIHN0aWxsIHRoaW5rIHRoYXQgZGlzYWJsZV9yb19ueCgp
IHNob3VsZCBub3QgY2FsbCBzZXRfbWVtb3J5X3goKS4NCj4gPiA+IElJVUMsIHRoaXMgYnJlYWtz
IFcrWCBvZiB0aGUgZGlyZWN0LW1hcHBpbmcgd2hpY2ggY29ycmVzcG9uZCB3aXRoIHRoZQ0KPiA+
ID4gbW9kdWxlDQo+ID4gPiBtZW1vcnkuIERvZXMgaXQgZXZlciBzdG9wIGJlaW5nIFcrWD8/IEni
gJlsbCBoYXZlIGFub3RoZXIgbG9vay4NCj4gPiANCj4gPiBEdW5uby4gIEkgZGlkIG9uY2UgY2hh
c2UgZG93biBhIGJ1ZyB3aGVyZSBzb21lIG1lbW9yeSBnb3QgZnJlZWQgd2hpbGUNCj4gPiBpdCB3
YXMgc3RpbGwgcmVhZC1vbmx5LCBhbmQgdGhlIHJlc3VsdHMgd2VyZSBoaWxhcmlvdXMgYW5kIGhh
cmQgdG8NCj4gPiBkZWJ1Zywgc2luY2UgdGhlIGV4cGxvc2lvbiBoYXBwZW5lZCBsb25nIGFmdGVy
IHRoZSBidWdneSBjb2RlDQo+ID4gZmluaXNoZWQuDQo+IA0KPiBUaGlzIHBpZWNlIG9mIGNvZGUg
Y2F1c2VzIG1lIHBhaW4gYW5kIG1pc2VyeS4NCj4gDQo+IFNvLCBpdCB0dXJucyBvdXQgdGhhdCB0
aGUgZGlyZWN0IG1hcCBpcyAqbm90KiBjaGFuZ2VkIGlmIHlvdSBqdXN0IGNoYW5nZQ0KPiB0aGUg
TlgtYml0LiBTZWUgY2hhbmdlX3BhZ2VfYXR0cl9zZXRfY2xyKCk6DQo+IA0KPiAgICAgICAgIC8q
IE5vIGFsaWFzIGNoZWNraW5nIGZvciBfTlggYml0IG1vZGlmaWNhdGlvbnMgKi8NCj4gICAgICAg
ICBjaGVja2FsaWFzID0gKHBncHJvdF92YWwobWFza19zZXQpIHwgcGdwcm90X3ZhbChtYXNrX2Ns
cikpICE9DQo+IF9QQUdFX05YOw0KPiANCj4gSG93IG1hbnkgbGV2ZWxzIG9mIGFic3RyYWN0aW9u
IGFyZSBicm9rZW4gaW4gdGhlIHdheT8gV2hhdCB3b3VsZCBoYXBwZW4NCj4gaWYgc29tZWJvZHkg
dHJpZXMgdG8gY2hhbmdlIHRoZSBOWC1iaXQgYW5kIHNvbWUgb3RoZXIgYml0IGluIHRoZSBQVEU/
DQo+IEx1Y2tpbHksIEkgZG9u4oCZdCB0aGluayBzb21lb25lIGRvZXPigKYgYXQgbGVhc3QgZm9y
IG5vdy4NCj4gDQo+IFNvLCBhZ2FpbiwgSSB0aGluayB0aGUgY2hhbmdlIEkgcHJvcG9zZWQgbWFr
ZXMgc2Vuc2UuIG5pb3MyIGRvZXMgbm90IGhhdmUNCj4gc2V0X21lbW9yeV94KCkgYW5kIGl0IHdp
bGwgbm90IGJlIGFmZmVjdGVkLg0KPiANCkhvbGQgb24uLi5zbyBvbiBhcmNoaXRlY3R1cmVzIHRo
YXQgZG9uJ3QgaGF2ZSBzZXRfbWVtb3J5XyBidXQgZG8gaGF2ZSBzb21ldGhpbmcNCmxpa2UgTlgs
IHdvbnQgdGhlIGV4ZWN1dGFibGUgc3RhbGUgVExCIGNvbnRpbnVlIHRvIGxpdmUgdG8gcmUtdXNl
ZCBwYWdlcywgYW5kIHNvDQppdCBkb2Vzbid0IGZpeCB0aGUgcHJvYmxlbSB0aGlzIHBhdGNoIGlz
IHRyeWluZyB0byBhZGRyZXNzIGdlbmVyYWxseT8gSSBzZWUgYXQNCmxlYXN0IGEgY291cGxlIGFy
Y2hzIHVzZSB2bWFsbG9jIGFuZCBoYXZlIGFuIGV4ZWMgYml0LCBidXQgZG9uJ3QgZGVmaW5lDQpz
ZXRfbWVtb3J5XyouDQoNCg==
