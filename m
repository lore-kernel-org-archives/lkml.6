Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C50C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFE820664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFE820664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbeJaG57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:57:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:54818 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbeJaG56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:57:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 15:02:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,446,1534834800"; 
   d="scan'208";a="103912899"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2018 15:02:45 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.166]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.196]) with mapi id 14.03.0415.000;
 Tue, 30 Oct 2018 15:02:44 -0700
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Subject: RE: [Patch v4 16/18] x86/speculation: Enable STIBP to protect
 security sensitive tasks
Thread-Topic: [Patch v4 16/18] x86/speculation: Enable STIBP to protect
 security sensitive tasks
Thread-Index: AQHUcIX0DdysJO4kRU6iUAh/q6Lda6U4RdfwgAB/M4D//4/zMA==
Date:   Tue, 30 Oct 2018 22:02:44 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC6732148DD1C@ORSMSX110.amr.corp.intel.com>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com>
 <26ec186930a8fb33033743997bd56e5ce44050ec.1540923609.git.tim.c.chen@linux.intel.com>
 <99FC4B6EFCEFD44486C35F4C281DC6732148DC8C@ORSMSX110.amr.corp.intel.com>
 <5793bddc-cd09-eebb-bc0c-51c9b3aca0c1@linux.intel.com>
In-Reply-To: <5793bddc-cd09-eebb-bc0c-51c9b3aca0c1@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzM4Mzg0OTQtODkyOS00ZTIwLTg5ODItYTY0OGY2ZjgwMjhmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiellPaGF1VzJkU25QRGt5ZEp2aERuZG9cL2xaSzIwd0sweWpGVWhxd1JINzE3RjVraGhrSVwvYkJxV09xaGRWMUFoIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaW0gQ2hlbiBbbWFpbHRvOnRp
bS5jLmNoZW5AbGludXguaW50ZWwuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDMwLCAy
MDE4IDI6MzUgUE0NCj4gVG86IFNjaGF1ZmxlciwgQ2FzZXkgPGNhc2V5LnNjaGF1ZmxlckBpbnRl
bC5jb20+OyBKaXJpIEtvc2luYQ0KPiA8amlrb3NAa2VybmVsLm9yZz47IFRob21hcyBHbGVpeG5l
ciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiBDYzogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFj
a3lAYW1kLmNvbT47IEluZ28gTW9sbmFyDQo+IDxtaW5nb0ByZWRoYXQuY29tPjsgUGV0ZXIgWmlq
bHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSm9zaCBQb2ltYm9ldWYNCj4gPGpwb2ltYm9l
QHJlZGhhdC5jb20+OyBBbmRyZWEgQXJjYW5nZWxpIDxhYXJjYW5nZUByZWRoYXQuY29tPjsgRGF2
aWQNCj4gV29vZGhvdXNlIDxkd213QGFtYXpvbi5jby51az47IEFuZGkgS2xlZW4gPGFrQGxpbnV4
LmludGVsLmNvbT47DQo+IEhhbnNlbiwgRGF2ZSA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPjsgTWFs
bGljaywgQXNpdCBLDQo+IDxhc2l0LmsubWFsbGlja0BpbnRlbC5jb20+OyBBcmphbiB2YW4gZGUg
VmVuIDxhcmphbkBsaW51eC5pbnRlbC5jb20+OyBKb24NCj4gTWFzdGVycyA8amNtQHJlZGhhdC5j
b20+OyBXYWltYW4gTG9uZyA8bG9uZ21hbjkzOTRAZ21haWwuY29tPjsNCj4gbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgeDg2QGtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQYXRjaCB2
NCAxNi8xOF0geDg2L3NwZWN1bGF0aW9uOiBFbmFibGUgU1RJQlAgdG8gcHJvdGVjdCBzZWN1cml0
eQ0KPiBzZW5zaXRpdmUgdGFza3MNCj4gDQo+IE9uIDEwLzMwLzIwMTggMDI6MDcgUE0sIFNjaGF1
ZmxlciwgQ2FzZXkgd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+
IEZyb206IFRpbSBDaGVuIFttYWlsdG86dGltLmMuY2hlbkBsaW51eC5pbnRlbC5jb21dDQo+ID4+
IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMzAsIDIwMTggMTE6NDkgQU0NCj4gPj4gVG86IEppcmkg
S29zaW5hIDxqaWtvc0BrZXJuZWwub3JnPjsgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9u
aXguZGU+DQo+ID4+IENjOiBUaW0gQ2hlbiA8dGltLmMuY2hlbkBsaW51eC5pbnRlbC5jb20+OyBU
b20gTGVuZGFja3kNCj4gPj4gPHRob21hcy5sZW5kYWNreUBhbWQuY29tPjsgSW5nbyBNb2xuYXIg
PG1pbmdvQHJlZGhhdC5jb20+OyBQZXRlcg0KPiA+PiBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVh
ZC5vcmc+OyBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAcmVkaGF0LmNvbT47DQo+ID4+IEFuZHJl
YSBBcmNhbmdlbGkgPGFhcmNhbmdlQHJlZGhhdC5jb20+OyBEYXZpZCBXb29kaG91c2UNCj4gPj4g
PGR3bXdAYW1hem9uLmNvLnVrPjsgQW5kaSBLbGVlbiA8YWtAbGludXguaW50ZWwuY29tPjsgSGFu
c2VuLCBEYXZlDQo+ID4+IDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+OyBTY2hhdWZsZXIsIENhc2V5
IDxjYXNleS5zY2hhdWZsZXJAaW50ZWwuY29tPjsNCj4gPj4gTWFsbGljaywgQXNpdCBLIDxhc2l0
LmsubWFsbGlja0BpbnRlbC5jb20+OyBBcmphbiB2YW4gZGUgVmVuDQo+ID4+IDxhcmphbkBsaW51
eC5pbnRlbC5jb20+OyBKb24gTWFzdGVycyA8amNtQHJlZGhhdC5jb20+OyBXYWltYW4gTG9uZw0K
PiA+PiA8bG9uZ21hbjkzOTRAZ21haWwuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgeDg2QGtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogW1BhdGNoIHY0IDE2LzE4XSB4ODYvc3Bl
Y3VsYXRpb246IEVuYWJsZSBTVElCUCB0byBwcm90ZWN0IHNlY3VyaXR5DQo+ID4+IHNlbnNpdGl2
ZSB0YXNrcw0KPiA+Pg0KPiA+PiBFbmFibGUgU1RJQlAgZGVmZW5zZSBvbiBoaWdoIHNlY3VyaXR5
IHRhc2tzLg0KPiA+Pg0KPiA+PiBGb3Igbm9ybWFsIHRhc2tzLCBTVElCUCBpcyB1bnVzZWQgc28g
dGhleSBhcmUgbm90IGltcGFjdGVkIGJ5IG92ZXJoZWFkDQo+ID4+IGZyb20gU1RJQlAgaW4gbGl0
ZSBwcm90ZWN0aW9uIG1vZGUuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFRpbSBDaGVuIDx0
aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBhcmNoL3g4Ni9rZXJu
ZWwvY3B1L2J1Z3MuYyB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
PiAgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykNCj4gPj4NCj4gPj4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9idWdz
LmMNCj4gPj4gaW5kZXggNTRmNDY3NS4uYjQwMmI5NiAxMDA2NDQNCj4gPj4gLS0tIGEvYXJjaC94
ODYva2VybmVsL2NwdS9idWdzLmMNCj4gPj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9idWdz
LmMNCj4gPj4gQEAgLTE0LDYgKzE0LDggQEANCj4gPj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUu
aD4NCj4gPj4gICNpbmNsdWRlIDxsaW51eC9ub3NwZWMuaD4NCj4gPj4gICNpbmNsdWRlIDxsaW51
eC9wcmN0bC5oPg0KPiA+PiArI2luY2x1ZGUgPGxpbnV4L3NjaGVkL2NvcmVkdW1wLmg+DQo+ID4+
ICsjaW5jbHVkZSA8bGludXgvc2VjdXJpdHkuaD4NCj4gPj4NCj4gPj4gICNpbmNsdWRlIDxhc20v
c3BlYy1jdHJsLmg+DQo+ID4+ICAjaW5jbHVkZSA8YXNtL2NtZGxpbmUuaD4NCj4gPj4gQEAgLTc3
MCw2ICs3NzIsMzcgQEAgc3RhdGljIGludCBzc2JfcHJjdGxfc2V0KHN0cnVjdCB0YXNrX3N0cnVj
dCAqdGFzaywNCj4gPj4gdW5zaWduZWQgbG9uZyBjdHJsKQ0KPiA+PiAgCXJldHVybiAwOw0KPiA+
PiAgfQ0KPiA+Pg0KPiA+PiArc3RhdGljIHZvaWQgc2V0X3Rhc2tfc3RpYnAoc3RydWN0IHRhc2tf
c3RydWN0ICp0c2ssIGJvb2wgc3RpYnBfb24pDQo+ID4+ICt7DQo+ID4+ICsJYm9vbCB1cGRhdGUg
PSBmYWxzZTsNCj4gPj4gKw0KPiA+PiArCWlmICghc3RhdGljX2JyYW5jaF91bmxpa2VseSgmc3Bl
Y3RyZV92Ml9hcHBfbGl0ZSkpDQo+ID4+ICsJCXJldHVybjsNCj4gPj4gKw0KPiA+PiArCWlmIChz
dGlicF9vbikNCj4gPj4gKwkJdXBkYXRlID0gIXRlc3RfYW5kX3NldF90c2tfdGhyZWFkX2ZsYWco
dHNrLCBUSUZfU1RJQlApOw0KPiA+PiArCWVsc2UNCj4gPj4gKwkJdXBkYXRlID0gdGVzdF9hbmRf
Y2xlYXJfdHNrX3RocmVhZF9mbGFnKHRzaywgVElGX1NUSUJQKTsNCj4gPj4gKw0KPiA+PiArCWlm
ICghdXBkYXRlKQ0KPiA+PiArCQlyZXR1cm47DQo+ID4+ICsNCj4gPj4gKwlpZiAodHNrID09IGN1
cnJlbnQpDQo+ID4+ICsJCXNwZWN1bGF0aW9uX2N0cmxfdXBkYXRlX2N1cnJlbnQoKTsNCj4gPj4g
K30NCj4gPj4gKw0KPiA+PiArdm9pZCBhcmNoX3NldF9zZWN1cml0eShzdHJ1Y3QgdGFza19zdHJ1
Y3QgKnRzaywgdW5zaWduZWQgaW50IHZhbHVlKQ0KPiA+DQo+ID4gSW4gdGhpcyBjb250ZXh0ICJz
ZWN1cml0eSIgaXNuJ3QgZGVzY3JpcHRpdmUuIGFyY2hfc2V0X3N0aWJwX2RlZmVuc2VzKCkNCj4g
PiB3b3VsZCBiZSBiZXR0ZXIuDQo+IA0KPiBBIG1vcmUgZ2VuZXJpYyBuYW1lIGRlY291cGxlZCBm
cm9tIFNUSUJQIHdpbGwgYmUgcHJlZmVyYWJsZS4gIFRoZXJlDQo+IGNhbiBvdGhlciBraW5kIG9m
IHNlY3VyaXR5IGRlZmVuc2VzIHRvIGJlIGVyZWN0ZWQgaW4NCj4gdGhlIGZ1dHVyZS4NCj4gDQo+
IFBlcmhhcHMgYXJjaF9zZXRfbWl0aWdhdGlvbj8NCg0KQmV0dGVyLiBPbiB0aGUgb3RoZXIgaGFu
ZCwgYWRkaW5nIGZ1bmN0aW9uIGNhbGwgbGF5ZXJzIGp1c3QgaW4gY2FzZSBsZWFkcw0KdG8gY2Fz
Y2FkZXMgb2YgZnVuY3Rpb25zIHRoYXQgZG8gbm90aGluZyBidXQgY2FsbCBvdGhlciBmdW5jdGlv
bnMsIGFuZCB0aGF0DQptYWtlcyBjb2RlIGhhcmQgdG8gdW5kZXJzdGFuZC4gSSB3b3VsZCBsZWF2
ZSBnZW5lcmFsaXphdGlvbiBmb3IgdGhlIDJuZA0KcGVyc29uIHdobyB3YW50cyB0byBhZGQgbWl0
aWdhdGlvbnMuIA0KDQo+IA0KPiBUaGFua3MuDQo+IA0KPiBUaW0NCj4gDQo+ID4NCj4gPiBTaW5j
ZSAidmFsdWUiIHNob3VsZCBvbmx5IGV2ZXIgaGF2ZSBvbmUgb2YgdHdvIHZhbHVlcywgYW5kIHRo
b3NlDQo+ID4gbWFwIGRpcmVjdGx5IHRvICJ0cnVlIiBvciAiZmFsc2UiIHRoaXMgc2hvdWxkIGJl
IGEgYm9vbCwgbWFraW5nIHRoZQ0KPiA+IGNvZGUgdHJpdmlhbDoNCj4gPg0KPiA+IHZvaWQgYXJj
aF9zZXRfc3RpYnBfZGVmZW5zZXMoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLCBib29sIHN0aWJw
KQ0KPiA+IHsNCj4gPiAJc2V0X3Rhc2tfc3RpYnAodGFzaywgc3RpYnApOw0KPiA+IH0NCj4gPg0K
PiA+IE9yIHBlcmhhcHMgYXJjaF9zZXRfc2VjdXJpdHkoKSBzaG91bGQgZ28gYXdheSwgYW5kIHRo
ZSBjYWxsaW5nDQo+ID4gY29kZSB3b3VsZCBjYWxsIHNldF90YXNrX3N0aWJwKCkgZGlyZWN0bHku
IFVubGVzcyB0aGVyZSBpcyBzb21lIGNvbXBlbGxpbmcNCj4gPiByZWFzb24gZm9yIHRoZSBhYnN0
cmFjdGlvbnMuDQo+ID4NCj4gPj4gK3sNCj4gPj4gKwlpZiAodmFsdWUgPiBTRUNVUklUWV9ISUdI
KQ0KPiA+PiArCQlyZXR1cm47DQo+ID4+ICsNCj4gPj4gKwkvKiBVcGRhdGUgU1RJQlAgZGVmZW5z
ZXMgKi8NCj4gPj4gKwlpZiAodmFsdWUgPT0gU0VDVVJJVFlfSElHSCkNCj4gPj4gKwkJc2V0X3Rh
c2tfc3RpYnAodHNrLCB0cnVlKTsNCj4gPj4gKwllbHNlDQo+ID4+ICsJCXNldF90YXNrX3N0aWJw
KHRzaywgZmFsc2UpOw0KPiA+PiArfQ0KPiA+PiArDQo+ID4+ICBpbnQgYXJjaF9wcmN0bF9zcGVj
X2N0cmxfc2V0KHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaywgdW5zaWduZWQgbG9uZyB3aGljaCwN
Cj4gPj4gIAkJCSAgICAgdW5zaWduZWQgbG9uZyBjdHJsKQ0KPiA+PiAgew0KPiA+PiAtLQ0KPiA+
PiAyLjkuNA0KPiA+DQoNCg==
