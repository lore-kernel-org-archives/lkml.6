Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E06C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F1924BC2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F1924BC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754707AbeF0VNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:13:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:8490 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751986AbeF0VNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:13:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 14:13:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,280,1526367600"; 
   d="scan'208";a="53420000"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga006.jf.intel.com with ESMTP; 27 Jun 2018 14:13:44 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 27 Jun 2018 14:13:44 -0700
Received: from hasmsx112.ger.corp.intel.com (10.184.198.40) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 27 Jun 2018 14:13:44 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.94]) by
 HASMSX112.ger.corp.intel.com ([169.254.11.94]) with mapi id 14.03.0319.002;
 Thu, 28 Jun 2018 00:13:41 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alan Cox <alan@linux.intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v7] tpm: separate cmd_ready/go_idle from runtime_pm
Thread-Topic: [PATCH v7] tpm: separate cmd_ready/go_idle from runtime_pm
Thread-Index: AQHUC/10xIwob4M80Eit0g6kz8euiKRw97kAgAABmYCAAg95gIABGJUAgAB58yA=
Date:   Wed, 27 Jun 2018 21:13:40 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D956753@hasmsx108.ger.corp.intel.com>
References: <20180624205202.6597-1-tomas.winkler@intel.com>
         <19b4282d625e04bb391f497419283a191bca610d.camel@linux.intel.com>
         <cb7ecb912486ee3e504de7c0918d667ebd370080.camel@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9D954923@hasmsx108.ger.corp.intel.com>
 <5c50d7fa2bf495f26443bd2da2e15df34c3d23f7.camel@linux.intel.com>
In-Reply-To: <5c50d7fa2bf495f26443bd2da2e15df34c3d23f7.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzE4YzNhOTUtYjdiMi00MjQyLWIzYTktZGQ3NGE1NzY0MGExIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSnJqcll3dXgwNkhWb1Q4QVVhekkwbml2TnZ1WTBmV3Z6b01pK2I4QzNsYU14bklYM2dQZFFpZ09TVmlhS2dmViJ9
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.252.30.241]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gVHVlLCAyMDE4LTA2LTI2IGF0IDIxOjE1ICswMDAwLCBXaW5rbGVyLCBUb21hcyB3
cm90ZToNCj4gPiA+IFJpZ2h0IG5vdyBpZiBJIHJlYWxseSBwdXQgaGVhZCBpbnRvIHRoaXMgSSBj
YW4gdW5kZXJzdGFuZCB0aGUgbG9naWMNCj4gPiA+IGJ1dCBpdCBpcyBhIGNvbXBsZXRlIG1lc3Mu
DQo+ID4NCj4gPiBJIHRoaW5rIHdoYXQgaXMgdGhlIG1lc3MgaXMgdGhhdCB3ZSBoYXZlIGEgcmVj
dXJzaXZlIGNhbGwgdG8NCj4gPiB0cG1fdHJhbnNtaXQgdG9wcGVkIHdpdGggcmV0cmllcy4gIEFs
bCBvdGhlciBtZXNzIGlzIGp1c3QgdGhlIHJlc3VsdCBvZiB0aGF0Lg0KPiA+DQo+ID4gPiBJIHdp
bGwgZm9yZ290IHRoZSBkZXBlbmRlbmNpZXMgYmV0d2VlbiBmbGFncyB3aXRoaW4gZmV3IHdlZWtz
Lg0KPiA+DQo+ID4gSG9wZSB0aGUgcmVhc29ucyBhcmUgd2VsbCBkb2N1bWVudGVkIGJvdGggaW4g
Y29kZSBhbmQgdGhlIGNvbW1pdA0KPiA+IG1lc3NhZ2UsIGlmIG5vdCBsZXQncyBhZGRyZXNzIHRo
YXQuIFdlIHJlYWxseSBjYW5ub3QgZGVwZW5kIG9uIG9uZSdzDQo+IG1lbW9yeS4NCj4gPiBJdCdz
IG5vdCBsaWtlIEknbSBub3Qgc3RyaXZpbmcgZm9yIHNpbXBsZXN0IHBvc3NpYmxlIGNvZGUuDQo+
ID4NCj4gPiA+IEEgZml4ZWQgcmVxdWlyZW1lbnQgKHNvIHRoYXQgeW91IGtub3cpIGlzIHRoYXQg
dGhleSBtdXN0IGJlDQo+ID4gPiBpbmRlcGVuZGVudC4NCj4gPg0KPiA+IFRoZSBmbGFncyAoaG9w
ZSB0aGlzIHdoYXQgeW91IHJlZmVycmluZyBoZXJlIHRvKSBhcmUgbm90IGluZGVwZW5kZW50DQo+
ID4gYW5kIHdlcmVuJ3QgYmVmb3JlLCAoUkFXIGNhbm5vdCBiZSBjYWxsZWQgYWxvbmUgYXMgeW91
IHdpbGwgaGF2ZQ0KPiA+IGRvdWJsZSBsb2NraW5nKSBwdXR0aW5nIHRoZW0gdW5kZXIgb25lIG5h
bWUganVzdCBzaG91bGQgbWFrZSBpdCBjbGVhci4NCj4gPiBJIGJlZyB5b3UgdG8gZ28gb3ZlciB0
aGUgIGNvZGUgb25lIG1vcmUgdGltZSwgZG9uJ3QgZ2V0IHN0dWNrIHdpdGgNCj4gPiBmbGFncyBu
YW1lcywgbWF5YmUgeW91IGV2ZW4gZGlzY292ZXIgc29tZSByZWFsIGlzc3VlLg0KPiA+DQo+ID4g
VGhhbmtzDQo+ID4gVG9tYXMNCj4gDQo+IFlvdSBzaG91bGQgdGhlbiBmaW5kIGEgc29sdXRpb24g
d2hlcmUgeW91IGNhbiByZW1vdmUNCj4gVFBNX1RSQU5TTUlUX1JBVyBjb21wbGV0ZWx5IGFuZCBt
YWtlIGl0IGFzIGEgc2VwYXJhdGUgY29tbWl0LCBub3QNCj4gcGFydCBvZiB0aGUgYnVnIGZpeC4N
Cj4gVGhpcyBpcyBub3QgaW4gYSBzaGFwZSB0aGF0IEkgd291bGQgZGFyZSB0byBwdXQgdGhpcyBp
biBhIHB1bGwgcmVxdWVzdC4NCg0KVmVyeSB3ZWxsLCBJIHdpbGwgcmVtb3ZlIHRoZSBORVNURUQg
ZmxhZy4gIHRob3VnaCBJIGhhdmUgZmVlbGluZyB5b3UgYXJlIHNob290aW5nIGZyb20gdGhlIGhp
cCB5b3UgZGlkbid0IHJlYWxseSByZWFkIHRoZSBjb2RlLiANClBsZWFzZSB0aGVyZSBhbnlvbmUg
d2hvIGNhbiByZXZpZXcgdGhlIGNvZGU/DQpUb21hcw0KDQo=
