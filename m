Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EDEC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23D0218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbfA3Kia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:38:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:61973 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfA3Kia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:38:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 02:38:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="140048603"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jan 2019 02:38:29 -0800
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 30 Jan 2019 02:38:29 -0800
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 30 Jan 2019 02:38:28 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.110]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.253]) with mapi id 14.03.0415.000;
 Wed, 30 Jan 2019 18:38:26 +0800
From:   "Kang, Luwei" <luwei.kang@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] KVM: x86: Sync the pending Posted-Interrupts
Thread-Topic: [PATCH v2] KVM: x86: Sync the pending Posted-Interrupts
Thread-Index: AQHUuDc/JCDEt2PmwEi/JWQKAeKmNaXG9FYAgACJIZD//4kjgIAAl80Q
Date:   Wed, 30 Jan 2019 10:38:26 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172CD60FB@SHSMSX101.ccr.corp.intel.com>
References: <1548809972-32100-1-git-send-email-luwei.kang@intel.com>
 <0e8444a1-39a3-d217-8602-ae175fedc8b2@redhat.com>
 <82D7661F83C1A047AF7DC287873BF1E172CD5EE4@SHSMSX101.ccr.corp.intel.com>
 <a876245b-6094-1767-ac63-dc8d31de9b84@redhat.com>
In-Reply-To: <a876245b-6094-1767-ac63-dc8d31de9b84@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzUyNTI0MTgtMmJiNy00OTdiLTlhNWMtZWE3ZDU0YTQzZDg4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTlA5NkJHdk1qYjFjQlk0a1E0MHlhQjJRc2JMY25PbVNpaStOUjk4QVZ1dTNRN1V2MEpQU3JQQUR5ZkV2bzhwWiJ9
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

PiA+PiBUaGlzIGlzIG5vdCB3aGF0IEkgYXNrZWQuICBZb3Ugc2hvdWxkIGluc3RlYWQgZG8gdGhl
IGNoZWNrIGFmdGVyIHBpX2NsZWFyX3NuLg0KPiA+Pg0KPiA+DQo+ID4gSSB0aGluayB0aGUgU04g
aGFzIGJlZW4gY2xlYXJlZCBoZXJlIGJlZm9yZSB0ZXN0IHRoZSBiaXRtYXAuDQo+ID4gVGhlIFNO
IHdpbGwgYmUgc2V0IHdoZW4gdGhlICB2Q1BVIGlzIHNjaGVkdWxlIG91dC4gSUQ6DQo+ID4gMjhi
ODM1ZDYwZmNjMjQ5OGU3MTdjZjVlNmYwYzM2OTFjMjQ1NDZmNw0KPiA+IEJ1dCBTTiB3aWxsIGJl
IGNsZWFyZWQgd2hlbiBzY2hlZCBpbi4NCj4gPg0KPiA+IEFub3RoZXIgcGxhY2UgaXMgd2hlbiB2
Q1BVIHJ1biBvdXQgb2YgdGhlIHZjcHVfcnVuKCkgZnVuY3Rpb246DQo+ID4gICAgICBrdm1fYXJj
aF92Y3B1X2lvY3RsX3J1bigpDQo+ID4gICAgICAgICAgdmNwdV9sb2FkKHZjcHUpOyAtPiBrdm1f
YXJjaF92Y3B1X2xvYWQgLT4gdm14X3ZjcHVfbG9hZCAtPiB2bXhfdmNwdV9waV9sb2FkIC0+IG5l
dy5zbiA9IDA7DQo+ID4gICAgICAgICAgdmNwdV9ydW4odmNwdSk7DQo+ID4gICAgICAgICAgICAg
IGZvcig7OykNCj4gPiAgICAgICAgICB2Y3B1X3B1dCh2Y3B1KTsgLT4ga3ZtX2FyY2hfdmNwdV9w
dXQgLT4gdm14X3ZjcHVfcHV0IC0+DQo+ID4gdm14X3ZjcHVfcGlfcHV0IC0+IHBpX3NldF9zbigp
IEJ1dCBTTiB3aWxsIGJlIGNsZWFyZWQgaW4gdmNwdV9sb2FkKCkNCj4gPiBiZWZvcmUgYmFjayB0
byB2Y3B1X3J1bigpDQo+IA0KPiBZZXMsIGJ1dCB5b3UncmUgY2hhbmdpbmcgdGhlIHdyb25nIHBh
dGguICBUaGUgcGF0Y2ggaXMgYWZmZWN0aW5nIF9hbGxfIHZtZW50cmllcywgbm90IGp1c3QgdGhv
c2UgYWZ0ZXIgUElELlNOIGhhcyBiZWVuIGNsZWFyZWQuDQo+IA0KPiBBcyBJIG1lbnRpb25lZCBp
biB0aGUgcHJldmlvdXMgZW1haWwsIEtWTSByZWxpZXMgb24gdGhlIFNETSdzIGludmFyaWFudCB0
aGF0IE9OIHdoZXJlIFBJRC5PTj0xIHdoZW5ldmVyIFBJRC5QSVIhPTAuICBJbnZhcmlhbnRzIGFy
ZSB5b3VyDQo+IGJlc3QgZnJpZW5kIHdoZW4gZGVhbGluZyB3aXRoIGNvbXBsaWNhdGVkIG11bHRp
LXByb2Nlc3NvciBjb2RlIHNvIEkgZG9uJ3Qgd2FudCB0byBjaGFuZ2UgdGhhdC4NCj4gDQo+IEl0
J3MgdGhlIFZULWQgcGlfY2xlYXJfc24gcGF0aCB0aGF0IEkgd2FudCB0byBiZSBjaGFuZ2VkLCBi
ZWNhdXNlIGl0J3MgVlQtZCBhbmQgc3BlY2lmaWNhbGx5IFNOIHRoYXQgY29tcGxpY2F0ZXMgdGhl
IHZlcnkgc2ltcGxlIGRlZmluaXRpb24gaW4NCj4gdGhlIFNETS4gIEJ5IG1vZGlmeWluZyB0aGUg
cGlfY2xlYXJfc24gcGF0aCwgeW91IGVuc3VyZSB0aGUgaW52YXJpYW50IGlzIHJlc3BlY3RlZCBh
bmQgZXZlcnlvbmUgaXMgaGFwcHkuDQoNCkhpIFBhb2xvLA0KICAgIEhvdyBhYm91dCBsaWtlIHRo
aXM6DQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jIGIvYXJjaC94ODYva3Zt
L3ZteC92bXguYw0KaW5kZXggODIwYTAzYi4uZGZjNWUzZCAxMDA2NDQNCi0tLSBhL2FyY2gveDg2
L2t2bS92bXgvdm14LmMNCisrKyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMNCkBAIC0xMjE5LDYg
KzEyMTksOSBAQCBzdGF0aWMgdm9pZCB2bXhfdmNwdV9waV9sb2FkKHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSwgaW50IGNwdSkNCiAgICAgICAgICAgICAgICAgICAgICAgIG5ldy5uZHN0ID0gKGRlc3Qg
PDwgOCkgJiAweEZGMDA7DQoNCiAgICAgICAgICAgICAgICBuZXcuc24gPSAwOw0KKw0KKyAgICAg
ICAgICAgICAgIGlmICghYml0bWFwX2VtcHR5KCh1bnNpZ25lZCBsb25nICopbmV3LnBpciwgTlJf
VkVDVE9SUykpDQorICAgICAgICAgICAgICAgICAgICAgICBuZXcub24gPSAxOw0KICAgICAgICB9
IHdoaWxlIChjbXB4Y2hnNjQoJnBpX2Rlc2MtPmNvbnRyb2wsIG9sZC5jb250cm9sLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbmV3LmNvbnRyb2wpICE9IG9sZC5jb250cm9sKTsNCiB9DQoN
ClRoYW5rcywNCkx1d2VpIEthbmcNCg==
