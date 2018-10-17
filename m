Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B2CECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D372098A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D372098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeJQUUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:20:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:5574 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbeJQUUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:20:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 05:24:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,392,1534834800"; 
   d="scan'208";a="78719211"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga007.fm.intel.com with ESMTP; 17 Oct 2018 05:24:32 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 17 Oct 2018 05:24:32 -0700
Received: from hasmsx112.ger.corp.intel.com (10.184.198.40) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 17 Oct 2018 05:24:31 -0700
Received: from HASMSX109.ger.corp.intel.com ([169.254.3.28]) by
 HASMSX112.ger.corp.intel.com ([169.254.11.230]) with mapi id 14.03.0319.002;
 Wed, 17 Oct 2018 15:24:29 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Nayna Jain <nayna@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 03/20] tpm: factor out tpm 1.x duration calculation
 to tpm1-cmd.c
Thread-Topic: [PATCH v6 03/20] tpm: factor out tpm 1.x duration calculation
 to tpm1-cmd.c
Thread-Index: AQHUZeXEAxkAvhY2ik6aE/XYedYfeaUjIkEAgAA4YJA=
Date:   Wed, 17 Oct 2018 12:24:28 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9F4691@hasmsx109.ger.corp.intel.com>
References: <20181017064613.19746-1-tomas.winkler@intel.com>
 <20181017064613.19746-4-tomas.winkler@intel.com>
 <05fea3e6-91a3-b508-83c0-d8f06d6bbd5c@linux.ibm.com>
In-Reply-To: <05fea3e6-91a3-b508-83c0-d8f06d6bbd5c@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTAyM2E4MDgtMmUzZi00NjdiLTllZTUtZTUzYjM0MTg4NWRiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUGgxc2RJRXRMTVozSzdmY000RmRHbFBQQWZKcG5oeHltbzVmRWhQNHlVTDI2K2hTVVF4SDVZUkJpMEFmYkFCZCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.116.154]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gDQo+IA0KPiBPbiAxMC8xNy8yMDE4IDEyOjE1IFBNLCBUb21hcyBXaW5rbGVyIHdyb3Rl
Og0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV9pMmNfbnV2b3Rvbi5jDQo+
ID4gYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV9pMmNfbnV2b3Rvbi5jDQo+ID4gaW5kZXggY2FhODZi
MTljNzZkLi41ZDIwZTk4Yjg0NGYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90
cG1faTJjX251dm90b24uYw0KPiA+ICsrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX2kyY19udXZv
dG9uLmMNCj4gPiBAQCAtMzcwLDYgKzM3MCw3IEBAIHN0YXRpYyBpbnQgaTJjX251dm90b25fc2Vu
ZChzdHJ1Y3QgdHBtX2NoaXAgKmNoaXAsDQo+IHU4ICpidWYsIHNpemVfdCBsZW4pDQo+ID4gICAJ
c3RydWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHRvX2kyY19jbGllbnQoZGV2KTsNCj4gPiAgIAl1
MzIgb3JkaW5hbDsNCj4gPiAgIAlzaXplX3QgY291bnQgPSAwOw0KPiA+ICsJdW5zaWduZWQgbG9u
ZyBkdXJhdGlvbjsNCj4gPiAgIAlpbnQgYnVyc3RfY291bnQsIGJ5dGVzMndyaXRlLCByZXRyaWVz
LCByYyA9IC1FSU87DQo+ID4NCj4gPiAgIAlmb3IgKHJldHJpZXMgPSAwOyByZXRyaWVzIDwgVFBN
X1JFVFJZOyByZXRyaWVzKyspIHsgQEAgLTQ1NSwxMg0KPiA+ICs0NTYsMTEgQEAgc3RhdGljIGlu
dCBpMmNfbnV2b3Rvbl9zZW5kKHN0cnVjdCB0cG1fY2hpcCAqY2hpcCwgdTggKmJ1ZiwNCj4gc2l6
ZV90IGxlbikNCj4gPiAgIAkJcmV0dXJuIHJjOw0KPiA+ICAgCX0NCj4gPiAgIAlvcmRpbmFsID0g
YmUzMl90b19jcHUoKigoX19iZTMyICopIChidWYgKyA2KSkpOw0KPiA+IC0JcmMgPSBpMmNfbnV2
b3Rvbl93YWl0X2Zvcl9kYXRhX2F2YWlsKGNoaXAsDQo+ID4gLQkJCQkJICAgICB0cG1fY2FsY19v
cmRpbmFsX2R1cmF0aW9uKGNoaXAsDQo+ID4gLQkJCQkJCQkJICAgICAgIG9yZGluYWwpLA0KPiA+
IC0JCQkJCSAgICAgJnByaXYtPnJlYWRfcXVldWUpOw0KPiA+ICsJZHVyYXRpb24gPSB0cG0xX2Nh
bGNfb3JkaW5hbF9kdXJhdGlvbihjaGlwLCBvcmRpbmFsKTsNCj4gDQo+IA0KPiBUaGlzIHZlcnNp
b24gb2YgdGhlIHBhdGNoIGRpZG4ndCBhZGRyZXNzIG15IHByZXZpb3VzIGNvbW1lbnQgLSAiVGhl
IG9yaWdpbmFsDQo+IGNvZGUgaW4gdGhlIG51dm90b24gZHJpdmVyIGRvZXMgbm90IGRpZmZlcmVu
dGlhdGUgYmV0d2VlbiBUUE0gMS4yIGFuZCBUUE0NCj4gMi4wIGFzIGl0IGRvZXMgaW4gdHBtX3Rp
c19jb3JlLmMuDQo+IEJlZm9yZSBtYWtpbmcgYW55IGNoYW5nZXMsIEkgd291bGQgZmlyc3QgZml4
IGl0LCBzbyB0aGF0IGl0IGNvdWxkIGVhc2lseSBiZQ0KPiBiYWNrcG9ydGVkLiBPbmx5IHRoZW4g
ZG8gdGhlIHJlZmFjdG9yaW5nLiINCg0KVGhpcyBwYXRjaCBkb2Vzbid0IGNoYW5nZSB0aGUgb3Jp
Z2luYWwgYmVoYXZpb3IsIGp1c3QgY2hhbmdlIHRoZSBuYW1lIG9mIHRoZSBmdW5jdGlvbiwgIHNv
IHRoZXJlIGlzIG5vIHJlZ3Jlc3Npb24uDQpJIHdvdWxkIHN1Z2dlc3QgdGhlcmUgaXMgYW5vdGhl
ciBidWcgaW4gdGhvc2UgZHJpdmVycy9kZXZpY2VzIHRoYXQgaXMgb3J0aG9nb25hbCB0byB0aGlz
IHJlZmFjdG9yaW5nIGFuZCBzaG91bGQgbm90IGJsb2NrIHRoaXMgZnJvbSBtZXJnaW5nLg0KQWNj
b3JkaW5nIHRvIHdoYXQgeW91IHNheSAgaXQgY2FuIGNhbGwganVzdCB0cG1fY2FsY19vcmlkbmFs
X2R1cmF0aW9uKCkgaW5zdGVhZCBvZiB0cG0xX2NhbGNfb3JkaW5hbF9kdXJhdGlvbihjaGlwLCBv
cmRpbmFsKSwNCmJ1dCBJIHByZWZlciB0aGF0IHNvbWVvbmUgdGhhdCBoYXMgdGhvc2UgZGV2aWNl
cyB3aWxsIGRvIHRoYXQgY2hhbmdlIG9uIHRvcCBvZiB0aGlzIHNlcmllcyBhcyAgSSBjYW5ub3Qg
dGVzdCBpdC4NCg0KVGhhbmtzDQpUb21hcw0KDQo=
