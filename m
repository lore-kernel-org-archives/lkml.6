Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F040C6780C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E93420659
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E93420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJLDqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:46:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:45818 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbeJLDqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:46:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 13:18:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="87648430"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Oct 2018 13:16:37 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 11 Oct 2018 13:16:37 -0700
Received: from lcsmsx154.ger.corp.intel.com (10.186.165.229) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 11 Oct 2018 13:16:37 -0700
Received: from HASMSX109.ger.corp.intel.com ([169.254.3.28]) by
 LCSMSX154.ger.corp.intel.com ([169.254.7.171]) with mapi id 14.03.0319.002;
 Thu, 11 Oct 2018 23:16:35 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>
CC:     "nayna@linux.vnet.ibm.com" <nayna@linux.vnet.ibm.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 05/21] tpm: factor out tpm_get_timeouts()
Thread-Topic: [PATCH v5 05/21] tpm: factor out tpm_get_timeouts()
Thread-Index: AQHUYYSyyO4neXOPJkShTukQAENgj6UaSC8A
Date:   Thu, 11 Oct 2018 20:16:34 +0000
Message-ID: <1539288758.1669.15.camel@intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
         <20180928223035.14471-6-tomas.winkler@intel.com>
         <b6b0fb96-e955-bf86-9bac-e6acee1e33e0@linux.ibm.com>
In-Reply-To: <b6b0fb96-e955-bf86-9bac-e6acee1e33e0@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.91.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7170666EBE35A04F83AA91DFB1F6557A@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTEwLTExIGF0IDIyOjMwICswNTMwLCBOYXluYSBKYWluIHdyb3RlOg0KPiAN
Cj4gT24gMDkvMjkvMjAxOCAwNDowMCBBTSwgVG9tYXMgV2lua2xlciB3cm90ZToNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3RwbS90cG0uaCBiL2RyaXZlcnMvY2hhci90cG0v
dHBtLmgNCj4gPiBpbmRleCA3MzUxMWNkODliZWYuLmE5N2Q3MmZjZGE1YiAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbS5oDQo+ID4gKysrIGIvZHJpdmVycy9jaGFyL3RwbS90
cG0uaA0KPiA+IEBAIC01NDQsOCArNTQ0LDEwIEBAIGludCB0cG1fc3RhcnR1cChzdHJ1Y3QgdHBt
X2NoaXAgKmNoaXApOw0KPiA+ICAgc3NpemVfdCB0cG1fZ2V0Y2FwKHN0cnVjdCB0cG1fY2hpcCAq
Y2hpcCwgdTMyIHN1YmNhcF9pZCwgY2FwX3QgKmNhcCwNCj4gPiAgIAkJICAgY29uc3QgY2hhciAq
ZGVzYywgc2l6ZV90IG1pbl9jYXBfbGVuZ3RoKTsNCj4gPiAgIGludCB0cG1fZ2V0X3RpbWVvdXRz
KHN0cnVjdCB0cG1fY2hpcCAqKTsNCj4gPiAtaW50IHRwbTFfYXV0b19zdGFydHVwKHN0cnVjdCB0
cG1fY2hpcCAqY2hpcCk7DQo+ID4gICBpbnQgdHBtX2RvX3NlbGZ0ZXN0KHN0cnVjdCB0cG1fY2hp
cCAqY2hpcCk7DQo+ID4gKw0KPiA+ICtpbnQgdHBtMV9hdXRvX3N0YXJ0dXAoc3RydWN0IHRwbV9j
aGlwICpjaGlwKTsNCj4gDQo+IFdoYXQgaXMgZGlmZmVyZW50IGluIHRoaXMgdHBtMV9hdXRvX3N0
YXJ0dXAoLi4uKSBhbmQgdGhlIG9yaWdpbmFsIG9uZSA/DQo+IA0KPiBJcyB0aGlzIG5lZWRlZCA/
DQpMb29rcyBsaWtlIGFuIGFtZW5kaW5nICBoaWNjdXAsIHdpbGwgZml4Lg0KVGhhbmtzDQpUb21h
cw0K
