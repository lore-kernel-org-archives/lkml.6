Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C125C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32042244B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32042244B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeHJUEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:04:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:13753 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727404AbeHJUEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:04:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Aug 2018 10:34:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,220,1531810800"; 
   d="scan'208";a="223648662"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga004.jf.intel.com with ESMTP; 10 Aug 2018 10:34:06 -0700
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 10 Aug 2018 10:34:05 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.8]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.164]) with mapi id 14.03.0319.002;
 Fri, 10 Aug 2018 10:34:05 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Bhupesh Sharma <bhsharma@redhat.com>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "ricardo.ner@intel.com" <ricardo.ner@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Lee Chun-Yi <jlee@suse.com>, Al Stone <astone@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RE: [PATCH V1 6/6] x86/efi: Introduce EFI_WARN_ON_ILLEGAL_ACCESSES
Thread-Topic: [PATCH V1 6/6] x86/efi: Introduce EFI_WARN_ON_ILLEGAL_ACCESSES
Thread-Index: AQHUL5nwjlQMwsqeUU6o6WRW0cpG8KS5VJ2A///l7/A=
Date:   Fri, 10 Aug 2018 17:34:04 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F47CDA91A@ORSMSX114.amr.corp.intel.com>
References: <1533789077-16156-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1533789077-16156-7-git-send-email-sai.praneeth.prakhya@intel.com>
 <CACi5LpPcaiHEHV9cFm=C4UB23jmfie16VR4m3ZAkZ9bVis5Dqg@mail.gmail.com>
In-Reply-To: <CACi5LpPcaiHEHV9cFm=C4UB23jmfie16VR4m3ZAkZ9bVis5Dqg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjBlNWE4ZjctYjU3Yi00Mzk2LTg4ZTYtYWQwNTNhZjIxOTlmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNDFkbkhJUlBcLzZFRWorQVFDdW1iZ3l6djI5UmlTRVR1TjJ1bWZud1k1S250MzBDem9jek5wb0FrM1g4WUpQbHUifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICtjb25maWcgRUZJX1dBUk5fT05fSUxMRUdBTF9BQ0NFU1NFUw0KPiANCj4gSG93IGFib3V0
IHNob3J0ZW5pbmcgdGhlIG5hbWUgdG8ganVzdCAnRUZJX1dBUk5fT05fSUxMRUdBTF9BQ0NFU1Mn
Pw0KPiANCg0KTWFrZXMgc2Vuc2UuLiBJIHdpbGwgc2hvcnRlbiBpdC4NCg0KPiA+ICsgICAgICAg
Ym9vbCAiV2FybiBhYm91dCBpbGxlZ2FsIG1lbW9yeSBhY2Nlc3NlcyBieSBmaXJtd2FyZSINCj4g
PiArICAgICAgIGRlcGVuZHMgb24gRUZJDQo+IA0KPiBGcm9tIGEgZGlzdHJpYnV0aW9uIHAtby12
LCBJIHdvdWxkIHN1Z2dlc3QgdGhhdCB3ZSBzZXQgdGhpcyBDT05GSUcgb3B0aW9uIG9ubHkgaWYN
Cj4gd2UgYXJlIGluIHRoZSBFWFBFUlQgbW9kZSwgYXMgdGhpcyBuZWVkIG1vcmUgdGhyYXNoaW5n
IHdpdGggdGhlIGJlaGF2aW91ciB3ZQ0KPiBzZWUgb24gb2xkLCBidWdneSBFRkkgZmlybXdhcmVz
IGF2YWlsYWJsZSBvbiB2ZXJ5IG9sZCB4ODYgbWFjaGluZXMuIFNvDQo+IHNvbWV0aGluZyBsaWtl
Og0KPiAgICAgICAgICAgIGJvb2wgIldhcm4gYWJvdXQgaWxsZWdhbCBtZW1vcnkgYWNjZXNzZXMg
YnkgZmlybXdhcmUiIGlmIEVYUEVSVA0KPiANCg0KQWdyZWVkLiBBbHRob3VnaCB0aGUgZmVhdHVy
ZSBpcyBpbnRlbmRlZCB0byB3YXJuIGFib3V0IGFsbCB0aGVzZSBidWdneSBmaXJtd2FyZSdzDQpp
bnN0ZWFkIG9mIHNpbGVudGx5IHdvcmtpbmcgYXJvdW5kIChhcyB3ZSBhcmUgZG9pbmcgcHJlc2Vu
dGx5KSwgaXQgbmVlZHMgbW9yZSB0ZXN0aW5nLg0KSGVuY2UsIGFzIHlvdSBzYWlkLCBJIHRoaW5r
IGl0J3Mgc2FmZSB0byBoYXZlIGl0IGFzIGFuIEVYUEVSVCBjb25maWcgb3B0aW9uLg0KDQo+ID4g
KyAgICAgICBoZWxwDQo+ID4gKyAgICAgICAgIEVuYWJsZSB0aGlzIGRlYnVnIGZlYXR1cmUgc28g
dGhhdCB0aGUga2VybmVsIGNhbiBkZXRlY3QgaWxsZWdhbA0KPiA+ICsgICAgICAgICBtZW1vcnkg
YWNjZXNzZXMgYnkgZmlybXdhcmUgYW5kIGlzc3VlIGEgd2FybmluZy4gQWxzbywNCj4gPiArICAg
ICAgICAgMS4gSWYgdGhlIGlsbGVnYWxseSBhY2Nlc3NlZCByZWdpb24gaXMgRUZJX0JPT1RfU0VS
VklDRVNfPENPREUvREFUQT4sDQo+ID4gKyAgICAgICAgICAgIHRoZSBrZXJuZWwgZml4ZXMgaXQg
dXAgYnkgbWFwcGluZyB0aGUgcmVxdWVzdGVkIHJlZ2lvbi4NCg0KWy4uLi5dDQoNCj4gPiBkaWZm
IC0tZ2l0IGEvaW5pdC9tYWluLmMgYi9pbml0L21haW4uYyBpbmRleA0KPiA+IDNiNGFkYTExZWQ1
Mi4uZGNlMDUyMDg2MWExIDEwMDY0NA0KPiA+IC0tLSBhL2luaXQvbWFpbi5jDQo+ID4gKysrIGIv
aW5pdC9tYWluLmMNCj4gPiBAQCAtNzMwLDcgKzczMCw4IEBAIGFzbWxpbmthZ2UgX192aXNpYmxl
IHZvaWQgX19pbml0IHN0YXJ0X2tlcm5lbCh2b2lkKQ0KPiA+ICAgICAgICAgYXJjaF9wb3N0X2Fj
cGlfc3Vic3lzX2luaXQoKTsNCj4gPiAgICAgICAgIHNmaV9pbml0X2xhdGUoKTsNCj4gPg0KPiA+
IC0gICAgICAgaWYgKGVmaV9lbmFibGVkKEVGSV9SVU5USU1FX1NFUlZJQ0VTKSkgew0KPiA+ICsg
ICAgICAgaWYgKGVmaV9lbmFibGVkKEVGSV9SVU5USU1FX1NFUlZJQ0VTKSAmJg0KPiA+ICsgICAg
ICAgICAgICFJU19FTkFCTEVEKENPTkZJR19FRklfV0FSTl9PTl9JTExFR0FMX0FDQ0VTU0VTKSkg
ew0KPiANCj4gU2luY2UgdGhpcyBpcyBhbiBhcmNoIGFnbm9zdGljIGNvZGUgbGVnLCBkbyB3ZSBy
ZWFsbHkgd2FudCB0byBpbnRyb2R1Y2UgYSBnZW5lcmljDQo+IGNoZWNrIGZvciBDT05GSUdfRUZJ
X1dBUk5fT05fSUxMRUdBTF9BQ0NFU1NFUw0KPiBoZXJlLCB3aXRob3V0IGNoZWNraW5nIGZvciB3
aGV0aGVyIHdlIGFyZSBhY3R1YWxseSBydW5uaW5nIHRoaXMgb24gYQ0KPiB4ODYgaGFyZHdhcmUs
IG9yIGFsdGVybmF0aXZlbHkgd2UgY2FuIGNvbnNpZGVyIG1vdmluZw0KPiBDT05GSUdfRUZJX1dB
Uk5fT05fSUxMRUdBTF9BQ0NFU1NFUyBvdXQgb2YgJ2FyY2gveDg2L0tjb25maWcnIHRvDQo+ICdh
cmNoL0tjb25maWcnIHNvIHRoYXQgbGF0ZXIgaXQgY2FuIGJlIHVzZWQgb24gb3RoZXIgYXJjaHMg
bGlrZSBBUk02NCBhcyB3ZWxsLg0KPiANCj4gSSB0aGluayB0aGUgbGF0ZXIgd291bGQgYmUgbW9y
ZSB1c2VmdWwuLg0KDQpUaGFua3MgZm9yIGJyaW5naW5nIHRoaXMgdXAuIEkgc2VlIHlvdXIgcG9p
bnQuIEkgd2lsbCByZWZyYWluIGZyb20gcG9sbHV0aW5nIGFyY2hpdGVjdHVyZQ0KYWdub3N0aWMg
Y29kZS4gQXMgd2UgZG9uJ3QgbmVlZCBlZmlfZnJlZV9ib290X3NlcnZpY2VzKCkgYXQgYWxsLCBp
ZiBFRklfV0FSTl9PTl9JTExFR0FMX0FDQ0VTU0VTDQppcyBlbmFibGVkLCBwcm9iYWJseSBtYWtp
bmcgY2hhbmdlcyB0byBpbmNsdWRlL2xpbnV4L2VmaS5oIHdvdWxkIGJlIGJldHRlciwgSSBndWVz
cy4uDQoNCk1vdmluZyB0aGlzIHRvIGFyY2gvS2NvbmZpZyBjb3VsZCBiZSB0b28gZnV0dXJpc3Rp
Yy4uIEkgZ3Vlc3MuLiBiZWNhdXNlIEkgYW0gbm90IHN1cmUNCmlmIHRoaXMgcHJvYmxlbSBleGlz
dHMgb24gQVJNIG1hY2hpbmVzLCBpZiBzbywgcHJvYmFibHkgQXJkIGNvdWxkIHN1Z2dlc3Qgc29t
ZXRoaW5nIGhlcmUuDQoNClJlZ2FyZHMsDQpTYWkNCg==
