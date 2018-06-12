Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AD494C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 02:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6181F208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 02:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6181F208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935091AbeFLCXd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 22:23:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:39952 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934840AbeFLCXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 22:23:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 19:23:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,212,1526367600"; 
   d="scan'208";a="207265017"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga004.jf.intel.com with ESMTP; 11 Jun 2018 19:23:31 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 11 Jun 2018 19:23:30 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 11 Jun 2018 19:23:30 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.51]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.116]) with mapi id 14.03.0319.002;
 Tue, 12 Jun 2018 10:23:28 +0800
From:   "Liu, Jingqi" <jingqi.liu@intel.com>
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH] KVM: x86: Expose CLDEMOTE CPU feature to guest VM
Thread-Topic: [PATCH] KVM: x86: Expose CLDEMOTE CPU feature to guest VM
Thread-Index: AQHT4oTLVZ7bVXQVyEOX5Fg+CwVuNaQj9i6AgDgk3xA=
Date:   Tue, 12 Jun 2018 02:23:28 +0000
Message-ID: <09D68D4CF52CAF489B702DEBDD12D3D352732B95@SHSMSX103.ccr.corp.intel.com>
References: <1525406146-54791-1-git-send-email-jingqi.liu@intel.com>
 <a799d2b8-9d75-0969-a98f-be5d96314dbb@redhat.com>
In-Reply-To: <a799d2b8-9d75-0969-a98f-be5d96314dbb@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDdmZDVmMWQtZWFkNC00MTFkLWE2ZmMtZDViZjhhY2Y1NmI0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiR2pNTTlUV2tYYSthdW1lSEVXR2dMYzdLelNIS3hEWXZFZFFsQVdHT2tlVWZjSG93UjhGUmZnTkgxUEtlREIxNyJ9
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS84LzIwMTggMTI6MzAgQU0sIFBhb2xvIEJvbnppbmkgd3JvdGU6DQoNCj4gDQo+IE9uIDA0
LzA1LzIwMTggMDU6NTUsIEppbmdxaSBMaXUgd3JvdGU6DQo+ID4gVGhlIENMREVNT1RFIGluc3Ry
dWN0aW9uIGhpbnRzIHRvIGhhcmR3YXJlIHRoYXQgdGhlIGNhY2hlIGxpbmUgdGhhdA0KPiA+IGNv
bnRhaW5zIHRoZSBsaW5lYXIgYWRkcmVzcyBzaG91bGQgYmUgbW92ZWQoImRlbW90ZWQiKSBmcm9t
IHRoZQ0KPiA+IGNhY2hlKHMpIGNsb3Nlc3QgdG8gdGhlIHByb2Nlc3NvciBjb3JlIHRvIGEgbGV2
ZWwgbW9yZSBkaXN0YW50IGZyb20NCj4gPiB0aGUgcHJvY2Vzc29yIGNvcmUuIFRoaXMgbWF5IGFj
Y2VsZXJhdGUgc3Vic2VxdWVudCBhY2Nlc3NlcyB0byB0aGUNCj4gPiBsaW5lIGJ5IG90aGVyIGNv
cmVzIGluIHRoZSBzYW1lIGNvaGVyZW5jZSBkb21haW4sIGVzcGVjaWFsbHkgaWYgdGhlDQo+ID4g
bGluZSB3YXMgd3JpdHRlbiBieSB0aGUgY29yZSB0aGF0IGRlbW90ZXMgdGhlIGxpbmUuDQo+ID4N
Cj4gPiBUaGlzIHBhdGNoIGV4cG9zZXMgdGhlIGNsZGVtb3RlIGZlYXR1cmUgdG8gdGhlIGd1ZXN0
Lg0KPiA+DQo+ID4gVGhlIHJlbGVhc2UgZG9jdW1lbnQgcmVmIGJlbG93IGxpbms6DQo+ID4gaHR0
cHM6Ly9zb2Z0d2FyZS5pbnRlbC5jb20vc2l0ZXMvZGVmYXVsdC9maWxlcy9tYW5hZ2VkL2M1LzE1
L1wNCj4gPiBhcmNoaXRlY3R1cmUtaW5zdHJ1Y3Rpb24tc2V0LWV4dGVuc2lvbnMtcHJvZ3JhbW1p
bmctcmVmZXJlbmNlLnBkZg0KPiA+IFRoaXMgcGF0Y2ggaGFzIGEgZGVwZW5kZW5jeSBvbiBodHRw
czovL2xrbWwub3JnL2xrbWwvMjAxOC80LzIzLzkyOA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
SmluZ3FpIExpdSA8amluZ3FpLmxpdUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2Vp
IFdhbmcgPHdlaS53LndhbmdAaW50ZWwuY29tPg0KPiANCj4gVGhhbmtzLiAgTm90ZSB0aGF0IHRo
ZSBTaWduZWQtb2ZmLWJ5IGNoYWluIGZvciB0aGUgcGF0Y2ggbG9va3Mgc3RyYW5nZSwgdGhlDQo+
IHN1Ym1pdHRlciBzaG91bGQgYmUgdGhlIGxhc3QgKGJlY2F1c2UgaXQgaXMgYSBjaGFpbikuDQo+
IA0KPiBJbiB0aGUgbWVhbndoaWxlLCBJbmdvLCBUaG9tYXMsIHdvdWxkIGl0IGJlIHBvc3NpYmxl
IHRvIGdldCBhIHRvcGljIGJyYW5jaCBmb3INCj4gdGhhdCBwYXRjaCAoIltQQVRDSF0geDg2L2Nw
dWZlYXR1cmVzOiBFbnVtZXJhdGUgY2xkZW1vdGUgaW5zdHJ1Y3Rpb24iKT8NCj4gDQoNCkkgaGFk
IHJlLXNlbnQgdGhlIHBhdGNoOiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOC81LzIxLzkxDQoN
CkhpIEluZ28sIFRob21hcywNCldvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIGdldCBhIHRvcGljIGJy
YW5jaCBmb3IgdGhhdCBwYXRjaCAoIltQQVRDSF0geDg2L2NwdWZlYXR1cmVzOiBFbnVtZXJhdGUg
Y2xkZW1vdGUgaW5zdHJ1Y3Rpb24iKT8NCg0KSGkgUGFvbG8sDQpDb3VsZCB5b3UgaGVscCB0byBy
ZXZpZXcgdGhpcyBwYXRjaCA/DQoNClRoYW5rcw0KSmluZ3FpDQoNCj4gVGhhbmtzLA0KPiANCj4g
UGFvbG8NCj4gDQo+IA0KPiA+IC0tLQ0KPiA+ICBhcmNoL3g4Ni9rdm0vY3B1aWQuYyB8IDMgKyst
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vY3B1aWQuYyBiL2FyY2gveDg2L2t2bS9j
cHVpZC5jIGluZGV4DQo+ID4gODIwNTViOS4uNzJkOGM0OSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNo
L3g4Ni9rdm0vY3B1aWQuYw0KPiA+ICsrKyBiL2FyY2gveDg2L2t2bS9jcHVpZC5jDQo+ID4gQEAg
LTQwMyw3ICs0MDMsOCBAQCBzdGF0aWMgaW5saW5lIGludCBfX2RvX2NwdWlkX2VudChzdHJ1Y3QN
Cj4ga3ZtX2NwdWlkX2VudHJ5MiAqZW50cnksIHUzMiBmdW5jdGlvbiwNCj4gPiAgCWNvbnN0IHUz
MiBrdm1fY3B1aWRfN18wX2VjeF94ODZfZmVhdHVyZXMgPQ0KPiA+ICAJCUYoQVZYNTEyVkJNSSkg
fCBGKExBNTcpIHwgRihQS1UpIHwgMCAvKk9TUEtFKi8gfA0KPiA+ICAJCUYoQVZYNTEyX1ZQT1BD
TlREUSkgfCBGKFVNSVApIHwgRihBVlg1MTJfVkJNSTIpIHwgRihHRk5JKQ0KPiB8DQo+ID4gLQkJ
RihWQUVTKSB8IEYoVlBDTE1VTFFEUSkgfCBGKEFWWDUxMl9WTk5JKSB8DQo+IEYoQVZYNTEyX0JJ
VEFMRyk7DQo+ID4gKwkJRihWQUVTKSB8IEYoVlBDTE1VTFFEUSkgfCBGKEFWWDUxMl9WTk5JKSB8
DQo+IEYoQVZYNTEyX0JJVEFMRykgfA0KPiA+ICsJCUYoQ0xERU1PVEUpOw0KPiA+DQo+ID4gIAkv
KiBjcHVpZCA3LjAuZWR4Ki8NCj4gPiAgCWNvbnN0IHUzMiBrdm1fY3B1aWRfN18wX2VkeF94ODZf
ZmVhdHVyZXMgPQ0KPiA+DQoNCg==
