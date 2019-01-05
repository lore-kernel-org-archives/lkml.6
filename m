Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5011DC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21447208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfAEKPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 05:15:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:11006 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfAEKPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 05:15:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jan 2019 02:15:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,442,1539673200"; 
   d="scan'208";a="115642063"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga003.jf.intel.com with ESMTP; 05 Jan 2019 02:15:21 -0800
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sat, 5 Jan 2019 02:15:21 -0800
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sat, 5 Jan 2019 02:15:21 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.63]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.46]) with mapi id 14.03.0415.000;
 Sat, 5 Jan 2019 18:15:19 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Jim Mattson <jmattson@google.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@intel.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        =?utf-8?B?UmFkaW0gS3JjbcOhcg==?= <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>, Jann Horn <jannh@google.com>,
        "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>
Subject: RE: [PATCH v4 04/10] KVM/x86: intel_pmu_lbr_enable
Thread-Topic: [PATCH v4 04/10] KVM/x86: intel_pmu_lbr_enable
Thread-Index: AQHUnQHwtVLQirWFo0mHnE6KVDBZAqWcJSwAgAEK4ICAAAOHAIABvYOA///aFwCAAVHOcA==
Date:   Sat, 5 Jan 2019 10:15:19 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73DEF6294@shsmsx102.ccr.corp.intel.com>
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
 <1545816338-1171-5-git-send-email-wei.w.wang@intel.com>
 <CALMp9eRPvxPCnAnWr8+U98PzZLQ8LzeBRMyPk0qROKBzSzSnRQ@mail.gmail.com>
 <5C2DB81F.3000906@intel.com>
 <CALMp9eR0rkF-DuOWyB16q5r8y9DrefsMd1h4GfDkA8nmpWjMEg@mail.gmail.com>
 <5C2F30CD.6010108@intel.com>
 <CALMp9eQOLpQwcjDV0ddi=xrK_ZCZj4g-tpx1-PCOS1Nn7Nx3jA@mail.gmail.com>
In-Reply-To: <CALMp9eQOLpQwcjDV0ddi=xrK_ZCZj4g-tpx1-PCOS1Nn7Nx3jA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGUzYzhkOTUtZjViMi00ODc5LThkZWQtOTJkM2ViZDY1ZDZlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVENub00zWFwvNWo1T0JINFp5aWs1UTJUSktsd1ZxdUJ2XC95WEhSUk1Na1wvclhqVFpLb01seU1teUV5Ym90OGFhSSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpZGF5LCBKYW51YXJ5IDQsIDIwMTkgMTE6NTQgUE0sIEppbSBNYXR0c29uIHdyb3RlOg0K
PiBPbiBGcmksIEphbiA0LCAyMDE5IGF0IDI6MDMgQU0gV2VpIFdhbmcgPHdlaS53LndhbmdAaW50
ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIDAxLzAzLzIwMTkgMTE6MzQgUE0sIEppbSBNYXR0
c29uIHdyb3RlOg0KPiA+ID4gRmFzdCBmb3J3YXJkIHRvLCBzYXksIDIwMjEuIFlvdSdyZSBkZWNv
bW1pc3Npb25pbmcgYWxsIEJyb2Fkd2VsbA0KPiA+ID4gc2VydmVycyBpbiB5b3VyIGRhdGEgY2Vu
dGVyLiBZb3UgaGF2ZSB0byBtaWdyYXRlIHRoZSBydW5uaW5nIFZNcyBvZmYNCj4gPiA+IG9mIHRo
b3NlIEJyb2Fkd2VsbCBzeXN0ZW1zIG9udG8gbmV3ZXIgaGFyZHdhcmUuIEJ1dCwgd2l0aCB0aGUN
Cj4gPiA+IGN1cnJlbnQgaW1wbGVtZW50YXRpb24sIHRoZSBtaWdyYXRpb24gY2Fubm90IGhhcHBl
bi4gU28sIHdoYXQgZG8geW91DQo+ID4gPiBkbz8gSSBzdXBwb3NlIHlvdSBqdXN0IG5ldmVyIGVu
YWJsZSB0aGUgZmVhdHVyZSBpbiB0aGUgZmlyc3QgcGxhY2UuIFJpZ2h0Pw0KPiA+DQo+ID4gSSdt
IG5vdCBzdXJlIGlmIHRoYXQncyB0aGUgd2F5IHBlb3BsZSB3b3VsZCBkbyB3aXRoIHRoZWlyIGRh
dGEgY2VudGVycy4NCj4gPiBXaGF0IHdvdWxkIGJlIHRoZSBwb2ludCBvZiBkZWNvbW1pc3Npb25p
bmcgYWxsIHRoZSBCRFcgbWFjaGluZXMgd2hlbg0KPiA+IHRoZXJlIGFyZSBpbXBvcnRhbnQgQkRX
IFZNcyBydW5uaW5nPw0KPiANCj4gVENPIGluY3JlYXNlcyBhcyBoYXJkd2FyZSBhZ2VzLCB3aGls
ZSB0aGUgVENPIGZvciBlYWNoIHN1Y2Nlc3NpdmUNCj4gZ2VuZXJhdGlvbiBvZiBoYXJkd2FyZSB0
ZW5kcyB0byBiZSBsb3dlciB0aGFuIGl0cyBwcmVkZWNlc3Nvci4gVGh1cywgdGhlDQo+IHBvaW50
IG9mIGRlY29tbWlzc2lvbmluZyBhbGwgQkRXIGhvc3RzIHRoYXQgYXJlIGJleW9uZCB0aGVpciB1
c2VmdWwgc2VydmljZQ0KPiBsaWZlIGlzIHRvIHNhdmUgbW9uZXkuIE91ciBhc3N1bXB0aW9uIGZv
ciBHb29nbGUgQ2xvdWQgaXMgdGhhdCB3ZSB3aWxsIGFsd2F5cw0KPiBiZSBhYmxlIHRvIGVtdWxh
dGUgb2xkZXIgSW50ZWwgcHJvY2Vzc29ycyBvbiBuZXdlciBJbnRlbCBwcm9jZXNzb3JzLCBzbyB0
aGUNCj4gcnVubmluZyBCRFcgVk1zIHNob3VsZCBub3QgYmUgYWZmZWN0ZWQgYnkgdGhlIGRlY29t
bWlzc2lvbmluZyBvZiBCRFcNCj4gaGFyZHdhcmUuIE9idmlvdXNseSwgdGhhdCBtZWFucyB0aGF0
IHdlIHdvbid0IG9mZmVyIGZlYXR1cmVzIHRoYXQgZG9uJ3QNCj4gaGF2ZSBhIGZvcndhcmQgbWln
cmF0aW9uIHN0b3J5LCBzdWNoIGFzIHRoaXMgb25lLg0KPiANCj4gWWVzLCBzb21lZGF5IEludGVs
IHdpbGwgZHJvcCBzdXBwb3J0IGZvciBzb21lIGZlYXR1cmUgdGhhdCB3ZSBjdXJyZW50bHkgb2Zm
ZXINCj4gKGxpa2UgTVBYLCBwZXJoYXBzKSwgYW5kIHRoYXQgd2lsbCBjYXVzZSB1cyBzb21lIGdy
aWVmLg0KDQpUaGlzIHNvdW5kcyBsaWtlIGEgcHJldHR5IGdvb2Qgb3Bwb3J0dW5pdHkgdG8gY29u
dmluY2UgeW91ciBjdXN0b21lcnMNCnRvIHVwZ3JhZGUgdGhlaXIgVk1zIDopDQoNClNvIHRoZSBz
b2x1dGlvbiB0byB5b3VyIGFib3ZlIHByb2JsZW0gSSBoYXZlIGluIG1pbmQgY3VycmVudGx5IGlz
Og0KLSBleHBlY3QgUUVNVSdzIHN1cHBvcnQgdG8gdXBncmFkZSBWTXMgKGUuZy4gQkRXIHRvIFNL
TCkNCi0ganVzdCBkaXNhYmxlIHRoZSBub24tY29tcGF0aWJsZSBmZWF0dXJlcyBmb3Igbm9uLXVw
Z3JhZGVkIFZNcw0KKHRoaXMgY291bGQgYmUgaW4geW91ciBTTEEpDQoNCkFueXdheSwgSSB0aGlu
ayBpdCB3b3VsZCBiZSBnb29kIHRvIGdldCB0aGlzIGZlYXR1cmUgb25saW5lIGZpcnN0LA0KYW5k
IHRoZW4gcmUtdmlzaXQgdGhhdCBmdXR1cmUgY29uY2Vybi4NCg0KQmVzdCwNCldlaQ0KIA0KDQo=
