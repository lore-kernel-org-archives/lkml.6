Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3533AC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A652083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A652083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeIFH17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:27:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:42672 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbeIFH17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:27:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 19:54:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="86400594"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga004.fm.intel.com with ESMTP; 05 Sep 2018 19:52:34 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 5 Sep 2018 19:52:34 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 5 Sep 2018 19:52:33 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.205]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.143]) with mapi id 14.03.0319.002;
 Thu, 6 Sep 2018 10:52:33 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v2 02/12] iommu/vt-d: Manage scalalble mode PASID tables
Thread-Topic: [PATCH v2 02/12] iommu/vt-d: Manage scalalble mode PASID tables
Thread-Index: AQHUQAHs3HUDSv3XyUCGZgqDJ7RwY6TiiUeg//+IGYCAAIcuYA==
Date:   Thu, 6 Sep 2018 02:52:32 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1912F2BBC@SHSMSX101.ccr.corp.intel.com>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
 <20180830013524.28743-3-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912F2A85@SHSMSX101.ccr.corp.intel.com>
 <44298d5c-5720-a382-07d1-a90a072ff24b@linux.intel.com>
In-Reply-To: <44298d5c-5720-a382-07d1-a90a072ff24b@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODQ2ZDhiMTUtMzk4Yi00ZGE4LWJkNjctYjc3NmUxZWI4YWI1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRWNmdVwvUE85SXc2cWhlZjl2TXdueDROcytPeFwvNGxwU2VVMkxJd1BrYUJSQTZtc05iXC9yR1gzdUQ1RGV1TE1oTCJ9
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

PiBGcm9tOiBMdSBCYW9sdSBbbWFpbHRvOmJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbV0NCj4gU2Vu
dDogVGh1cnNkYXksIFNlcHRlbWJlciA2LCAyMDE4IDEwOjQ2IEFNDQo+DQpbLi4uXSANCj4gPj4g
QEAgLTE0Myw4ICsxNDIsOSBAQCBpbnQgaW50ZWxfcGFzaWRfYWxsb2NfdGFibGUoc3RydWN0IGRl
dmljZSAqZGV2KQ0KPiA+PiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4+ICAgCUlOSVRfTElTVF9I
RUFEKCZwYXNpZF90YWJsZS0+ZGV2KTsNCj4gPj4NCj4gPj4gLQlzaXplID0gc2l6ZW9mKHN0cnVj
dCBwYXNpZF9lbnRyeSk7DQo+ID4+ICsJc2l6ZSA9IHNpemVvZihzdHJ1Y3QgcGFzaWRfZGlyX2Vu
dHJ5KTsNCj4gPj4gICAJY291bnQgPSBtaW5fdChpbnQsIHBjaV9tYXhfcGFzaWRzKHRvX3BjaV9k
ZXYoZGV2KSksDQo+ID4+IGludGVsX3Bhc2lkX21heF9pZCk7DQo+ID4+ICsJY291bnQgPj49IFBB
U0lEX1BERV9TSElGVDsNCj4gPj4gICAJb3JkZXIgPSBnZXRfb3JkZXIoc2l6ZSAqIGNvdW50KTsN
Cj4gPj4gICAJcGFnZXMgPSBhbGxvY19wYWdlc19ub2RlKGluZm8tPmlvbW11LT5ub2RlLA0KPiA+
PiAgIAkJCQkgR0ZQX0FUT01JQyB8IF9fR0ZQX1pFUk8sDQo+ID4+IEBAIC0xNTQsNyArMTU0LDcg
QEAgaW50IGludGVsX3Bhc2lkX2FsbG9jX3RhYmxlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPj4N
Cj4gPj4gICAJcGFzaWRfdGFibGUtPnRhYmxlID0gcGFnZV9hZGRyZXNzKHBhZ2VzKTsNCj4gPj4g
ICAJcGFzaWRfdGFibGUtPm9yZGVyID0gb3JkZXI7DQo+ID4+IC0JcGFzaWRfdGFibGUtPm1heF9w
YXNpZCA9IGNvdW50Ow0KPiA+PiArCXBhc2lkX3RhYmxlLT5tYXhfcGFzaWQgPSBjb3VudCA8PCBQ
QVNJRF9QREVfU0hJRlQ7DQo+ID4NCj4gPiBhcmUgeW91IHN1cmUgb2YgdGhhdCBjb3VudCBpcyBQ
REVfU0hJRlQgYWxpZ25lZD8gb3RoZXJ3aXNlID4+DQo+ID4gdGhlbiA8PCB3b3VsZCBsb3NlIHNv
bWUgYml0cy4gSWYgc3VyZSwgdGhlbiBiZXR0ZXIgYWRkIHNvbWUgY2hlY2suDQo+IA0KPiBJIGFt
IG1ha2luZyB0aGUgbWF4X3Bhc2lkIFBERV9TSElGVCBhbGlnbmVkIGFzIHRoZSByZXN1bHQgb2Yg
c2hpZnQNCj4gb3BlcmF0aW9ucy4NCj4gDQoNCmVhcmxpZXI6DQo+ID4+ICAgCWNvdW50ID0gbWlu
X3QoaW50LCBwY2lfbWF4X3Bhc2lkcyh0b19wY2lfZGV2KGRldikpLA0KPiA+PiBpbnRlbF9wYXNp
ZF9tYXhfaWQpOw0KDQpzbyB5b3UgZGVjaWRlZCB0byB0cnVuY2F0ZSBjb3VudCB0byBiZSBQREVf
U0hJRlQgYWxpZ25lZC4gSXMgUEFTSUQNCnZhbHVlIHVzZXIgY29uZmlndXJhYmxlPyBpZiBub3Qs
IHRoZW4gaXQncyBmaW5lLg0KDQo+ID4NCj4gPj4NCj4gPj4gICBhdHRhY2hfb3V0Og0KPiA+PiAg
IAlkZXZpY2VfYXR0YWNoX3Bhc2lkX3RhYmxlKGluZm8sIHBhc2lkX3RhYmxlKTsNCj4gPj4gQEAg
LTE2MiwxNCArMTYyLDMzIEBAIGludCBpbnRlbF9wYXNpZF9hbGxvY190YWJsZShzdHJ1Y3QgZGV2
aWNlICpkZXYpDQo+ID4+ICAgCXJldHVybiAwOw0KPiA+PiAgIH0NCj4gPj4NCj4gPj4gKy8qIEdl
dCBQUkVTRU5UIGJpdCBvZiBhIFBBU0lEIGRpcmVjdG9yeSBlbnRyeS4gKi8NCj4gPj4gK3N0YXRp
YyBpbmxpbmUgYm9vbA0KPiA+PiArcGFzaWRfcGRlX2lzX3ByZXNlbnQoc3RydWN0IHBhc2lkX2Rp
cl9lbnRyeSAqcGRlKQ0KPiA+PiArew0KPiA+PiArCXJldHVybiBSRUFEX09OQ0UocGRlLT52YWwp
ICYgUEFTSURfUFRFX1BSRVNFTlQ7DQo+ID4NCj4gPiBjdXJpb3VzIHdoeSBhZGRpbmcgUkVBRF9P
TkNFIHNwZWNpZmljYWxseSBmb3IgUEFTSUQgc3RydWN0dXJlLA0KPiA+IGJ1dCBub3QgdXNlZCBm
b3IgYW55IG90aGVyIGV4aXN0aW5nIHZ0ZCBzdHJ1Y3R1cmVzPyBJcyBpdCB0byBhZGRyZXNzDQo+
ID4gc29tZSBzcGVjaWZpYyByZXF1aXJlbWVudCBvbiBQQVNJRCBzdHJ1Y3R1cmUgYXMgZGVmaW5l
ZCBpbiBzcGVjPw0KPiANCj4gUkVBRC9XUklURV9PTkNFIGFyZSB1c2VkIGluIHBhc2lkIGVudHJ5
IHJlYWQvd3JpdGUgdG8gcHJldmVudCB0aGUNCj4gY29tcGlsZXIgZnJvbSBtZXJnaW5nLCByZWZl
dGNoaW5nIG9yIHJlb3JkZXJpbmcgc3VjY2Vzc2l2ZSBpbnN0YW5jZXMgb2YNCj4gcmVhZC93cml0
ZS4NCj4gDQoNCnRoYXQncyBmaW5lLiBJJ20ganVzdCBjdXJpb3VzIHdoeSB0aGlzIGlzIHRoZSBm
aXJzdCB1c2VyIG9mIHN1Y2ggbWFjcm9zDQppbiBpbnRlbC1pb21tdSBkcml2ZXIuIEV2ZW4gYmVm
b3JlIHdpdGggZWNzIHdlIGhhdmUgUEFTSUQgdGFibGUgdG9vLg0KDQpUaGFua3MNCktldmluDQo=
