Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D51C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A172087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfA3Ahv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 19:37:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:29610 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbfA3Ahv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 19:37:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 16:37:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,538,1539673200"; 
   d="scan'208";a="134260534"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga001.jf.intel.com with ESMTP; 29 Jan 2019 16:37:46 -0800
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 29 Jan 2019 16:37:46 -0800
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 29 Jan 2019 16:37:45 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.110]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.109]) with mapi id 14.03.0415.000;
 Wed, 30 Jan 2019 08:37:44 +0800
From:   "Kang, Luwei" <luwei.kang@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] KVM: x86: Sync the pending Posted-Interrupts
Thread-Topic: [PATCH] KVM: x86: Sync the pending Posted-Interrupts
Thread-Index: AQHUrvgng1TGbq88YUCMNKU8aNpvOaW/01aAgAR9dGCAAbiiYP//wEKAgAE/QOA=
Date:   Wed, 30 Jan 2019 00:37:43 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172CD574E@SHSMSX101.ccr.corp.intel.com>
References: <1547793240-9157-1-git-send-email-luwei.kang@intel.com>
 <a88ee1f8-ec49-f35f-5b97-65bb1ceb9ea4@redhat.com>
 <82D7661F83C1A047AF7DC287873BF1E172CD3820@SHSMSX101.ccr.corp.intel.com>
 <82D7661F83C1A047AF7DC287873BF1E172CD4BDD@SHSMSX101.ccr.corp.intel.com>
 <3344700c-e4df-0ef7-161a-0398d6799642@redhat.com>
In-Reply-To: <3344700c-e4df-0ef7-161a-0398d6799642@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTBkMTMzZTUtM2E4My00M2UzLWFkOGItOTc4ZTIwOTEwMmY1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidk5GdUJhMEZDdzRIWXgrZ1pCT2ErZHdVR2dvZ3FFMlJNZ0VOU2tBcjM0TTdiTHdGUkZ4RTVGQnk5STJ4UW5SbSJ9
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

PiA+Pj4gSG93ZXZlciwgeW91IHNob3VsZCBhdCBsZWFzdCBjaGFuZ2UgdGhlIGNvbW1lbnQgaW4g
dmNwdV9lbnRlcl9ndWVzdA0KPiA+Pj4gdG8gbWVudGlvbiAiYmVmb3JlIHJlYWRpbmcgUElSIiBp
bnN0ZWFkIG9mICJiZWZvcmUgcmVhZGluZyBQSVIuT04iLg0KPiA+Pg0KPiA+PiBXaWxsIGRvIHRo
YXQuIEkgdGhpbmsgdGhlICJjaGVja2luZyBQSVIuT04iIHNob3VsZCBiZSBQSUQuT04uIEkgd2ls
bCBmaXggaXQuDQo+ID4+DQo+ID4gSGkgUGFvbG8sDQo+ID4gICAgIEkgcmVjb25zaWRlcmVkIHRo
ZSBjb21tZW50IGluIHZjcHVfZW50ZXJfZ3Vlc3QoKSBhbmQgdGhpbmsgaXQgbWF5IGRvbid0IG5l
ZWQgdG8gY2hhbmdlLiBUaGUgb3JpZ2luYWwgY29tbWVudCBhcyBiZWxvdzoNCj4gPiAgICAgICAg
ICAqIDIpIEZvciBBUElDdiwgd2Ugc2hvdWxkIHNldCAtPm1vZGUgYmVmb3JlIGNoZWNraW5nICBQ
SVIuT04uICBUaGlzDQo+ID4gICAgICAgICAgKiBwYWlycyB3aXRoIHRoZSBtZW1vcnkgYmFycmll
ciBpbXBsaWNpdCBpbiBwaV90ZXN0X2FuZF9zZXRfb24NCj4gPiAgICAgICAgICAqIChzZWUgdm14
X2RlbGl2ZXJfcG9zdGVkX2ludGVycnVwdCkuDQo+ID4NCj4gPiAgICAgSSB0aGluayAiYmVmb3Jl
IGNoZWNraW5nIFBJUi5PTiIgaXMgbWVhbiAiYmVmb3JlIGNoZWNraW5nIFBJRC5QSVIgYW5kIFBJ
RC5PTiIuDQo+IA0KPiBJIGNhbiBzYXkgaXQgb25seSBtZWFucyBQSUQuT04gYmVjYXVzZSBJIHdy
b3RlIHRoZSBjb21tZW50LiA6KQ0KPiANCj4gVGhlIGlkZWEgaXMgdGhhdCBjaGVja2luZyBPTiBp
cyBlbm91Z2g6IEtWTSBhc3N1bWVzIHRoYXQgUElELlBJUiBpcyBvbmx5IHNldCBpZiBQSUQuT04g
aXMgc2V0LCBiZWNhdXNlIGl0IGZvbGxvd3MgdGhlIGRlZmluaXRpb24gb2YgT04gaW4gdGFibGUN
Cj4gMjktMSBvZiB0aGUgU0RNOiAiSWYgdGhpcyBiaXQgaXMgc2V0LCB0aGVyZSBpcyBhIG5vdGlm
aWNhdGlvbiBvdXRzdGFuZGluZyBmb3Igb25lIG9yIG1vcmUgcG9zdGVkIGludGVycnVwdHMgaW4g
Yml0cyAyNTU6MCIuDQo+IA0KPiBWVC1EIGJyZWFrcyB0aGlzIGFzc3VtcHRpb24gd2hlbmV2ZXIg
U049MSAoImhhcmR3YXJlIGRvZXMgbm90IGdlbmVyYXRlIG5vdGlmaWNhdGlvbiBldmVudCBub3Ig
bW9kaWZ5IHRoZSBPTiBmaWVsZCIpLCByZXN1bHRpbmcgaW4NCj4gbm9uemVybyBQSUQuUElSIGJ1
dCBQSUQuT049MC4gIEknbSBzdXJlIHRoZXJlIHdhcyBhIHJlYXNvbiBmb3IgdGhhdCwgYnV0IGl0
IGRvZXMgcmVzdWx0IGluIGluY29uc2lzdGVuY3kgYmV0d2VlbiB0aGUgUElEIGRlZmluaXRpb25z
IGluIHRoZQ0KPiBTRE0gYW5kIHRoZSBWVC1EIHNwZWNpZmljYXRpb24uICBUaGUgcmlnaHQgZml4
IGlzIGRlZmluaXRlbHkgdG8gcmVjb25jaWxlIHRoaXMgZGlmZmVyZW5jZSBhbmQgdGVzdCB0aGUg
Yml0bWFwIGFmdGVyIFNOIGlzIGNsZWFyZWQgKHdpdGgNCj4gc21wX21iX19hZnRlcl9hdG9taWMg
YWZ0ZXIgY2xlYXJpbmcgU04pLCBhbmQgc2V0IE9OPTEgaWYgdGhlIGJpdG1hcCBpcyBub3QgY2xl
YXIuDQo+IA0KSGkgUGFvbG8NCiAgICBUaGFua3MgZm9yIHlvdXIgZWxhYm9yYXRpb24sIHZlcnkg
Y2xlYXIgdG8gbWUuIEkgd2lsbCBmaXggaXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MsDQpM
dXdlaSBLYW5nDQoNCg0KDQo=
