Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12471ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81EF2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81EF2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeJYEFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:05:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:14657 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbeJYEFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 00:05:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 12:36:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,421,1534834800"; 
   d="scan'208";a="244068057"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga004.jf.intel.com with ESMTP; 24 Oct 2018 12:36:14 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 24 Oct 2018 12:36:14 -0700
Received: from crsmsx102.amr.corp.intel.com (172.18.63.137) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 24 Oct 2018 12:36:13 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.85]) by
 CRSMSX102.amr.corp.intel.com ([169.254.2.244]) with mapi id 14.03.0415.000;
 Wed, 24 Oct 2018 13:36:11 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [v3 05/12] x86/fsgsbase/64: Preserve FS/GS state in
 __switch_to() if FSGSBASE is on
Thread-Topic: [v3 05/12] x86/fsgsbase/64: Preserve FS/GS state in
 __switch_to() if FSGSBASE is on
Thread-Index: AQHUawBO7l1gssH07kCl6Hdk10LxvKUvLBEA//+e6ZA=
Date:   Wed, 24 Oct 2018 19:36:10 +0000
Message-ID: <C9BB696F3A938947B10DCAD29FAB8FFA66CCBCEE@CRSMSX101.amr.corp.intel.com>
References: <20181023184234.14025-1-chang.seok.bae@intel.com>
 <20181023184234.14025-6-chang.seok.bae@intel.com>
 <CALCETrWZZ65pzmO_OwG0x3DWtLbLykB16DB5t8r3rkjg5VmzmA@mail.gmail.com>
In-Reply-To: <CALCETrWZZ65pzmO_OwG0x3DWtLbLykB16DB5t8r3rkjg5VmzmA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDdkZTBiMjktNjBiOS00ZGVmLTk4Y2EtMGI4ZjZlOWRmMWVhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTExFNFRoN1Flclp5SFduY0pEbk5mVDFVaHRWWnpnSUd3UE92Qkx4QnRpYmtPZHo5TUlRQ1hhdk82VHcrXC9YSDAifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBPY3QgMjQsIDIwMTggYXQgMTI6MjEgUE0gQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiBPbiBUdWUsIE9jdCAyMywgMjAxOCBhdCAxMTo0MyBBTSBDaGFu
ZyBTLiBCYWUgPGNoYW5nLnNlb2suYmFlQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBG
cm9tOiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4NCj4gPg0KPiA+IFdpdGggdGhl
IG5ldyBGU0dTQkFTRSBpbnN0cnVjdGlvbnMsIHdlIGNhbiBlZmZpY2llbnRseSByZWFkIGFuZCB3
cml0ZQ0KPiA+IHRoZSBGU0JBU0UgYW5kIEdTQkFTRSBpbiBfX3N3aXRjaF90bygpLiAgVXNlIHRo
YXQgY2FwYWJpbGl0eSB0byBwcmVzZXJ2ZQ0KPiA+IHRoZSBmdWxsIHN0YXRlLg0KPiA+DQo+ID4g
VGhpcyB3aWxsIGVuYWJsZSB1c2VyIGNvZGUgdG8gZG8gd2hhdGV2ZXIgaXQgd2FudHMgd2l0aCB0
aGUgbmV3DQo+ID4gaW5zdHJ1Y3Rpb25zIHdpdGhvdXQgYW55IGtlcm5lbC1pbmR1Y2VkIGdvdGNo
YXMuICAoVGhlcmUgY2FuIHN0aWxsIGJlDQo+ID4gYXJjaGl0ZWN0dXJhbCBnb3RjaGFzOiBtb3Zs
ICVncywlZWF4OyBtb3ZsICVlYXgsJWdzIG1heSBjaGFuZ2UgR1NCQVNFDQo+ID4gaWYgV1JHU0JB
U0Ugd2FzIHVzZWQsIGJ1dCB1c2VycyBhcmUgZXhwZWN0ZWQgdG8gcmVhZCB0aGUgQ1BVIG1hbnVh
bA0KPiA+IGJlZm9yZSBkb2luZyB0aGluZ3MgbGlrZSB0aGF0LikNCj4gPg0KPiA+IFRoaXMgaXMg
YSBjb25zaWRlcmFibGUgc3BlZWR1cC4gIEl0IHNlZW1zIHRvIHNhdmUgYWJvdXQgMTAwIGN5Y2xl
cw0KPiA+IHBlciBjb250ZXh0IHN3aXRjaCBjb21wYXJlZCB0byB0aGUgYmFzZWxpbmUgNC42LXJj
MSBiZWhhdmlvciBvbiBteQ0KPiA+IFNreWxha2UgbGFwdG9wLg0KPiA+DQo+ID4gWyBjaGFuZzog
NX4xMCUgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnRzIHdlcmUgc2VlbiBieSBhIGNvbnRleHQgc3dp
dGNoDQo+ID4gICBiZW5jaG1hcmsgdGhhdCByYW4gdGhyZWFkcyB3aXRoIGRpZmZlcmVudCBGUy9H
U0JBU0UgdmFsdWVzLiBNaW5vcg0KPiA+ICAgZWRpdCBvbiB0aGUgY2hhbmdlbG9nLiBdDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBDaGFuZyBTLiBCYWUgPGNoYW5nLnNlb2suYmFlQGludGVsLmNvbT4N
Cj4gPiBSZXZpZXdlZC1ieTogQW5kaSBLbGVlbiA8YWtAbGludXguaW50ZWwuY29tPg0KPiA+IENj
OiBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4NCj4gPiBDYzogVGhvbWFzIEdsZWl4bmVy
IDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+ID4gQ2M6IEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwu
b3JnPg0KPiA+IENjOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPg0K
PiA+IC0tLQ0KPiA+ICBhcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzc182NC5jIHwgMzQgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9r
ZXJuZWwvcHJvY2Vzc182NC5jIGIvYXJjaC94ODYva2VybmVsL3Byb2Nlc3NfNjQuYw0KPiA+IGlu
ZGV4IGZjZjE4MDQ2YzNkNi4uMWQ5NzVjYWRjMjU2IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2
L2tlcm5lbC9wcm9jZXNzXzY0LmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzc182
NC5jDQo+ID4gQEAgLTIzOCw4ICsyMzgsMTggQEAgc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lk
IHNhdmVfZnNncyhzdHJ1Y3QNCj4gdGFza19zdHJ1Y3QgKnRhc2spDQo+ID4gIHsNCj4gPiAgICAg
ICAgIHNhdmVzZWdtZW50KGZzLCB0YXNrLT50aHJlYWQuZnNpbmRleCk7DQo+ID4gICAgICAgICBz
YXZlc2VnbWVudChncywgdGFzay0+dGhyZWFkLmdzaW5kZXgpOw0KPiA+IC0gICAgICAgc2F2ZV9i
YXNlX2xlZ2FjeSh0YXNrLCB0YXNrLT50aHJlYWQuZnNpbmRleCwgRlMpOw0KPiA+IC0gICAgICAg
c2F2ZV9iYXNlX2xlZ2FjeSh0YXNrLCB0YXNrLT50aHJlYWQuZ3NpbmRleCwgR1MpOw0KPiA+ICsg
ICAgICAgaWYgKHN0YXRpY19jcHVfaGFzKFg4Nl9GRUFUVVJFX0ZTR1NCQVNFKSkgew0KPiA+ICsg
ICAgICAgICAgICAgICAvKg0KPiA+ICsgICAgICAgICAgICAgICAgKiBJZiBGU0dTQkFTRSBpcyBl
bmFibGVkLCB3ZSBjYW4ndCBtYWtlIGFueSB1c2VmdWwgZ3Vlc3Nlcw0KPiA+ICsgICAgICAgICAg
ICAgICAgKiBhYm91dCB0aGUgYmFzZSwgYW5kIHVzZXIgY29kZSBleHBlY3RzIHVzIHRvIHNhdmUg
dGhlIGN1cnJlbnQNCj4gPiArICAgICAgICAgICAgICAgICogdmFsdWUuICBGb3J0dW5hdGVseSwg
cmVhZGluZyB0aGUgYmFzZSBkaXJlY3RseSBpcyBlZmZpY2llbnQuDQo+ID4gKyAgICAgICAgICAg
ICAgICAqLw0KPiA+ICsgICAgICAgICAgICAgICB0YXNrLT50aHJlYWQuZnNiYXNlID0gcmRmc2Jh
c2UoKTsNCj4gPiArICAgICAgICAgICAgICAgdGFzay0+dGhyZWFkLmdzYmFzZSA9IHJkX2luYWN0
aXZlX2dzYmFzZSgpOw0KPiA+ICsgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgICAg
c2F2ZV9iYXNlX2xlZ2FjeSh0YXNrLCB0YXNrLT50aHJlYWQuZnNpbmRleCwgRlMpOw0KPiA+ICsg
ICAgICAgICAgICAgICBzYXZlX2Jhc2VfbGVnYWN5KHRhc2ssIHRhc2stPnRocmVhZC5nc2luZGV4
LCBHUyk7DQo+ID4gKyAgICAgICB9DQo+ID4gIH0NCj4gPg0KPiA+ICAjaWYgSVNfRU5BQkxFRChD
T05GSUdfS1ZNKQ0KPiA+IEBAIC0zMTgsMTAgKzMyOCwyMiBAQCBzdGF0aWMgX19hbHdheXNfaW5s
aW5lIHZvaWQNCj4gbG9hZF9zZWdfbGVnYWN5KHVuc2lnbmVkIHNob3J0IHByZXZfaW5kZXgsDQo+
ID4gIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCB4ODZfZnNnc2Jhc2VfbG9hZChzdHJ1Y3Qg
dGhyZWFkX3N0cnVjdCAqcHJldiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IHRocmVhZF9zdHJ1Y3QgKm5leHQpDQo+ID4gIHsNCj4gPiAt
ICAgICAgIGxvYWRfc2VnX2xlZ2FjeShwcmV2LT5mc2luZGV4LCBwcmV2LT5mc2Jhc2UsDQo+ID4g
LSAgICAgICAgICAgICAgICAgICAgICAgbmV4dC0+ZnNpbmRleCwgbmV4dC0+ZnNiYXNlLCBGUyk7
DQo+ID4gLSAgICAgICBsb2FkX3NlZ19sZWdhY3kocHJldi0+Z3NpbmRleCwgcHJldi0+Z3NiYXNl
LA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIG5leHQtPmdzaW5kZXgsIG5leHQtPmdzYmFz
ZSwgR1MpOw0KPiA+ICsgICAgICAgaWYgKHN0YXRpY19jcHVfaGFzKFg4Nl9GRUFUVVJFX0ZTR1NC
QVNFKSkgew0KPiA+ICsgICAgICAgICAgICAgICAvKiBVcGRhdGUgdGhlIEZTIGFuZCBHUyBzZWxl
Y3RvcnMgaWYgdGhleSBjb3VsZCBoYXZlIGNoYW5nZWQuICovDQo+ID4gKyAgICAgICAgICAgICAg
IGlmICh1bmxpa2VseShwcmV2LT5mc2luZGV4IHx8IG5leHQtPmZzaW5kZXgpKQ0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGxvYWRzZWcoRlMsIG5leHQtPmZzaW5kZXgpOw0KPiA+ICsgICAg
ICAgICAgICAgICBpZiAodW5saWtlbHkocHJldi0+Z3NpbmRleCB8fCBuZXh0LT5nc2luZGV4KSkN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBsb2Fkc2VnKEdTLCBuZXh0LT5nc2luZGV4KTsN
Cj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIC8qIFVwZGF0ZSB0aGUgYmFzZXMuICovDQo+ID4g
KyAgICAgICAgICAgICAgIHdyZnNiYXNlKG5leHQtPmZzYmFzZSk7DQo+ID4gKyAgICAgICAgICAg
ICAgIHdyX2luYWN0aXZlX2dzYmFzZShuZXh0LT5nc2Jhc2UpOw0KPiANCj4gQWhhLCBJIHNlZSB3
aGF0IHlvdSdyZSBkb2luZyB3aXRoIHRoZSBGU0dTQkFTRS1vcHRpbWl6ZWQgdmVyc2lvbiBiZWlu
Zw0KPiBvdXQgb2YgbGluZS4gIEJ1dCBpdCdzIHdheSB0b28gdW5jbGVhciBmcm9tIHRoZSBjb2Rl
LiAgWW91IHNob3VsZCBuYW1lDQo+IHRoZSBoZWxwZXIgd3Jnc2Jhc2VfaW5hY3RpdmUgb3IgbWF5
YmUgX193cmdzYmFzZV9pbmFjdGl2ZSgpIHRvDQo+IGVtcGhhc2l6ZSB0aGF0IHlvdSdyZSBsaXRl
cmFsbHkgdXNpbmcgdGhlIFdSR1NCQVNFIGluc3RydWN0aW9uLiAgKE9yDQo+IGl0J3MgWGVuIFBW
IGVxdWl2YWxlbnQuICBIbW0uKQ0KDQpPa2F5LiBXaWxsIHJlbmFtZSB0aGUgcmVsZXZhbnRzLg0K
