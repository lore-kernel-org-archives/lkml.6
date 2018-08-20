Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6023C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E852154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E852154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeHTPwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:52:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:15883 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbeHTPwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:52:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 05:36:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,265,1531810800"; 
   d="scan'208";a="63770407"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga007.fm.intel.com with ESMTP; 20 Aug 2018 05:36:56 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 20 Aug 2018 05:36:55 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 20 Aug 2018 05:36:54 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.240]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.150]) with mapi id 14.03.0319.002;
 Mon, 20 Aug 2018 20:36:53 +0800
From:   "Liu, Jingqi" <jingqi.liu@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH 1/3] KVM: x86: expose UMWAIT/UMONITOR/TPAUSE CPU
 features into VM.
Thread-Topic: [PATCH 1/3] KVM: x86: expose UMWAIT/UMONITOR/TPAUSE CPU
 features into VM.
Thread-Index: AQHUGCvKcf5dcvBUXEuBx1uZ6MlWdKTIJyKAgACs58A=
Date:   Mon, 20 Aug 2018 12:36:52 +0000
Message-ID: <09D68D4CF52CAF489B702DEBDD12D3D35279F7F0@SHSMSX103.ccr.corp.intel.com>
References: <1531212883-63173-1-git-send-email-jingqi.liu@intel.com>
 <1531212883-63173-2-git-send-email-jingqi.liu@intel.com>
 <8605faeb-c46e-d54c-cc3a-d01b23405705@redhat.com>
In-Reply-To: <8605faeb-c46e-d54c-cc3a-d01b23405705@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjEzYzJiNWItOGM1NC00ODgzLTg1NmQtZmY3YmViZTdmNTZlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYlp6QTB0TFVBajB3MmMwTEZFNzN3RVhXem1vM1ZBb3BtNklwQ0ptT0J6eVFwQzRCYWRacUxQSDBiOThDcWFWciJ9
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBCb256aW5pIFttYWls
dG86cGJvbnppbmlAcmVkaGF0LmNvbV0NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMjAsIDIwMTgg
NjoxNiBQTQ0KPiBUbzogTGl1LCBKaW5ncWkgPGppbmdxaS5saXVAaW50ZWwuY29tPjsgcmtyY21h
ckByZWRoYXQuY29tOyB0Z2x4QGxpbnV0cm9uaXguZGU7DQo+IG1pbmdvQHJlZGhhdC5jb207IGhw
YUB6eXRvci5jb20NCj4gQ2M6IHg4NkBrZXJuZWwub3JnOyBrdm1Admdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBXYW5nLA0KPiBXZWkgVyA8d2VpLncud2FuZ0Bp
bnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBLVk06IHg4NjogZXhwb3NlIFVN
V0FJVC9VTU9OSVRPUi9UUEFVU0UgQ1BVDQo+IGZlYXR1cmVzIGludG8gVk0uDQo+IA0KPiBPbiAx
MC8wNy8yMDE4IDEwOjU0LCBKaW5ncWkgTGl1IHdyb3RlOg0KPiA+IFVNT05JVE9SLCBVTVdBSVQs
IGFuZCBUUEFVU0UgYXJlIGEgc2V0IG9mIHVzZXIgd2FpdCBpbnN0cnVjdGlvbnMuDQo+ID4NCj4g
PiBVTU9OSVRPUiBhcm1zIGFkZHJlc3MgbW9uaXRvcmluZyBoYXJkd2FyZSB1c2luZyBhbiBhZGRy
ZXNzLiBBIHN0b3JlIHRvDQo+ID4gYW4gYWRkcmVzcyB3aXRoaW4gdGhlIHNwZWNpZmllZCBhZGRy
ZXNzIHJhbmdlIHRyaWdnZXJzIHRoZSBtb25pdG9yaW5nDQo+ID4gaGFyZHdhcmUgdG8gd2FrZSB1
cCB0aGUgcHJvY2Vzc29yIHdhaXRpbmcgaW4gdW13YWl0Lg0KPiA+DQo+ID4gVU1XQUlUIGluc3Ry
dWN0cyB0aGUgcHJvY2Vzc29yIHRvIGVudGVyIGFuIGltcGxlbWVudGF0aW9uLWRlcGVuZGVudA0K
PiA+IG9wdGltaXplZCBzdGF0ZSB3aGlsZSBtb25pdG9yaW5nIGEgcmFuZ2Ugb2YgYWRkcmVzc2Vz
LiBUaGUgb3B0aW1pemVkDQo+ID4gc3RhdGUgbWF5IGJlIGVpdGhlciBhIGxpZ2h0LXdlaWdodCBw
b3dlci9wZXJmb3JtYW5jZSBvcHRpbWl6ZWQgc3RhdGUNCj4gPiAoYzAuMSBzdGF0ZSkgb3IgYW4g
aW1wcm92ZWQgcG93ZXIvcGVyZm9ybWFuY2Ugb3B0aW1pemVkIHN0YXRlDQo+ID4gKGMwLjIgc3Rh
dGUpLg0KPiA+DQo+ID4gVFBBVVNFIGluc3RydWN0cyB0aGUgcHJvY2Vzc29yIHRvIGVudGVyIGFu
IGltcGxlbWVudGF0aW9uLWRlcGVuZGVudA0KPiA+IG9wdGltaXplZCBzdGF0ZSBjMC4xIG9yIGMw
LjIgc3RhdGUgYW5kIHdha2UgdXAgd2hlbiB0aW1lLXN0YW1wIGNvdW50ZXINCj4gPiByZWFjaGVz
IHNwZWNpZmllZCB0aW1lb3V0Lg0KPiA+DQo+ID4gQXZhaWxhYmlsaXR5IG9mIHRoZSB1c2VyIHdh
aXQgaW5zdHJ1Y3Rpb25zIGlzIGluZGljYXRlZCBieSB0aGUNCj4gPiBwcmVzZW5jZSBvZiB0aGUg
Q1BVSUQgZmVhdHVyZSBmbGFnIFdBSVRQS0cgQ1BVSUQuMHgwNy4weDA6RUNYWzVdLg0KPiA+DQo+
ID4gVGhpcyBwYXRjaCBleHBvc2VzIHRoZSB1bW9uaXRvcix1bXdhaXQsIGFuZCB0cGF1c2UgZmVh
dHVyZXMgdG8gdGhlIGd1ZXN0Lg0KPiA+DQo+ID4gVGhlIHJlbGVhc2UgZG9jdW1lbnQgcmVmIGJl
bG93IGxpbms6DQo+ID4gaHR0cHM6Ly9zb2Z0d2FyZS5pbnRlbC5jb20vc2l0ZXMvZGVmYXVsdC9m
aWxlcy9tYW5hZ2VkL2M1LzE1L1wNCj4gPiBhcmNoaXRlY3R1cmUtaW5zdHJ1Y3Rpb24tc2V0LWV4
dGVuc2lvbnMtcHJvZ3JhbW1pbmctcmVmZXJlbmNlLnBkZg0KPiA+IFRoaXMgcGF0Y2ggaGFzIGEg
ZGVwZW5kZW5jeSBvbiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOC82LzE1LzY1Ny4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEppbmdxaSBMaXUgPGppbmdxaS5saXVAaW50ZWwuY29tPg0KPiAN
Cj4gSGkgSmluZ3FpLCB5b3UgYWxzbyBuZWVkIHRvIHRyYWNrIGFuZCBzYXZlL3Jlc3RvcmUgSUEz
Ml9VTVdBSVRfQ09OVFJPTC4NCg0KWWVzLCBJJ2xsIGhhbmRsZSBJQTMyX1VNV0FJVF9DT05UUk9M
IGluIHRoZSBzZWNvbmQgdmVyc2lvbi4NClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQoNCj4gDQo+
IFRoYW5rcywNCj4gDQo+IFBhb2xvDQo+IA0KPiA+IC0tLQ0KPiA+ICBhcmNoL3g4Ni9rdm0vY3B1
aWQuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL2NwdWlkLmMgYi9hcmNo
L3g4Ni9rdm0vY3B1aWQuYyBpbmRleA0KPiA+IDdlMDQyZTMuLmUxNmMwNWUgMTAwNjQ0DQo+ID4g
LS0tIGEvYXJjaC94ODYva3ZtL2NwdWlkLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rdm0vY3B1aWQu
Yw0KPiA+IEBAIC00MDYsNyArNDA2LDcgQEAgc3RhdGljIGlubGluZSBpbnQgX19kb19jcHVpZF9l
bnQoc3RydWN0DQo+IGt2bV9jcHVpZF9lbnRyeTIgKmVudHJ5LCB1MzIgZnVuY3Rpb24sDQo+ID4g
IAkJRihBVlg1MTJWQk1JKSB8IEYoTEE1NykgfCBGKFBLVSkgfCAwIC8qT1NQS0UqLyB8DQo+ID4g
IAkJRihBVlg1MTJfVlBPUENOVERRKSB8IEYoVU1JUCkgfCBGKEFWWDUxMl9WQk1JMikgfCBGKEdG
TkkpDQo+IHwNCj4gPiAgCQlGKFZBRVMpIHwgRihWUENMTVVMUURRKSB8IEYoQVZYNTEyX1ZOTkkp
IHwNCj4gRihBVlg1MTJfQklUQUxHKSB8DQo+ID4gLQkJRihDTERFTU9URSk7DQo+ID4gKwkJRihD
TERFTU9URSkgfCBGKFdBSVRQS0cpOw0KPiA+DQo+ID4gIAkvKiBjcHVpZCA3LjAuZWR4Ki8NCj4g
PiAgCWNvbnN0IHUzMiBrdm1fY3B1aWRfN18wX2VkeF94ODZfZmVhdHVyZXMgPQ0KPiA+DQoNCg==
