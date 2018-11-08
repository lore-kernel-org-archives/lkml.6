Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20FFC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 03:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF3320684
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 03:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF3320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbeKHNWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 08:22:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:30205 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728687AbeKHNWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 08:22:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 19:49:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="278052507"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga005.fm.intel.com with ESMTP; 07 Nov 2018 19:49:19 -0800
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 7 Nov 2018 19:49:18 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.117]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.161]) with mapi id 14.03.0415.000;
 Thu, 8 Nov 2018 11:49:17 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v4 04/12] iommu/vt-d: Add 256-bit invalidation
 descriptor support
Thread-Topic: [PATCH v4 04/12] iommu/vt-d: Add 256-bit invalidation
 descriptor support
Thread-Index: AQHUdMlDcnwPlQkmSk2wysYaWtdoaqVDpZEQgAD8+ICAAJeH4A==
Date:   Thu, 8 Nov 2018 03:49:16 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D604DF@SHSMSX104.ccr.corp.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-5-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D5FAA2@SHSMSX104.ccr.corp.intel.com>
 <a6e43ddd-0889-4a4a-b908-993db28c6d87@linux.intel.com>
In-Reply-To: <a6e43ddd-0889-4a4a-b908-993db28c6d87@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGI2YTdiMDktMjhmNC00MjJkLTlkNGYtMzE2Y2QyOWM3OGZkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicjIrT2w1eE4zZHhEem5RMlNBWFpVN0hsSFoydkJkTGJsY1Q4aGUwZ2I5NTVhN25sNU5Oc3FRWFVPZHBXVm9jMiJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gRnJvbTogTHUgQmFvbHUgW21haWx0bzpiYW9sdS5sdUBsaW51eC5pbnRlbC5jb21d
DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciA4LCAyMDE4IDEwOjE3IEFNDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjQgMDQvMTJdIGlvbW11L3Z0LWQ6IEFkZCAyNTYtYml0IGludmFsaWRhdGlv
biBkZXNjcmlwdG9yDQo+IHN1cHBvcnQNCj4gDQo+IEhpIFlpLA0KPiANCj4gT24gMTEvNy8xOCAy
OjA3IFBNLCBMaXUsIFlpIEwgd3JvdGU6DQo+ID4gSGkgQmFvbHUsDQo+ID4NCj4gPj4gRnJvbTog
THUgQmFvbHUgW21haWx0bzpiYW9sdS5sdUBsaW51eC5pbnRlbC5jb21dDQo+ID4+IFNlbnQ6IE1v
bmRheSwgTm92ZW1iZXIgNSwgMjAxOCAxOjMyIFBNDQo+ID4NCj4gPiBbLi4uXQ0KPiA+DQo+ID4+
IC0tLQ0KPiA+PiAgIGRyaXZlcnMvaW9tbXUvZG1hci5jICAgICAgICAgICAgICAgIHwgODMgKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gPj4gICBkcml2ZXJzL2lvbW11L2ludGVsLXN2
bS5jICAgICAgICAgICB8IDc2ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+ID4+ICAgZHJp
dmVycy9pb21tdS9pbnRlbF9pcnFfcmVtYXBwaW5nLmMgfCAgNiArKy0NCj4gPj4gICBpbmNsdWRl
L2xpbnV4L2ludGVsLWlvbW11LmggICAgICAgICB8ICA5ICsrKy0NCj4gPj4gICA0IGZpbGVzIGNo
YW5nZWQsIDExNSBpbnNlcnRpb25zKCspLCA1OSBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvZG1hci5jIGIvZHJpdmVycy9pb21tdS9kbWFyLmMgaW5k
ZXgNCj4gPj4gZDljNzQ4YjZmOWU0Li5lYzEwNDI3Yjk4YWMgMTAwNjQ0DQo+ID4+IC0tLSBhL2Ry
aXZlcnMvaW9tbXUvZG1hci5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvZG1hci5jDQo+ID4+
IEBAIC0xMTYwLDYgKzExNjAsNyBAQCBzdGF0aWMgaW50IHFpX2NoZWNrX2ZhdWx0KHN0cnVjdCBp
bnRlbF9pb21tdQ0KPiA+PiAqaW9tbXUsIGludA0KPiA+PiBpbmRleCkNCj4gPj4gICAJaW50IGhl
YWQsIHRhaWw7DQo+ID4+ICAgCXN0cnVjdCBxX2ludmFsICpxaSA9IGlvbW11LT5xaTsNCj4gPj4g
ICAJaW50IHdhaXRfaW5kZXggPSAoaW5kZXggKyAxKSAlIFFJX0xFTkdUSDsNCj4gPj4gKwlpbnQg
c2hpZnQgPSBxaV9zaGlmdChpb21tdSk7DQo+ID4+DQo+ID4+ICAgCWlmIChxaS0+ZGVzY19zdGF0
dXNbd2FpdF9pbmRleF0gPT0gUUlfQUJPUlQpDQo+ID4+ICAgCQlyZXR1cm4gLUVBR0FJTjsNCj4g
Pj4gQEAgLTExNzMsMTMgKzExNzQsMTUgQEAgc3RhdGljIGludCBxaV9jaGVja19mYXVsdChzdHJ1
Y3QgaW50ZWxfaW9tbXUNCj4gPj4gKmlvbW11LCBpbnQgaW5kZXgpDQo+ID4+ICAgCSAqLw0KPiA+
PiAgIAlpZiAoZmF1bHQgJiBETUFfRlNUU19JUUUpIHsNCj4gPj4gICAJCWhlYWQgPSByZWFkbChp
b21tdS0+cmVnICsgRE1BUl9JUUhfUkVHKTsNCj4gPj4gLQkJaWYgKChoZWFkID4+IERNQVJfSVFf
U0hJRlQpID09IGluZGV4KSB7DQo+ID4+ICsJCWlmICgoaGVhZCA+PiBzaGlmdCkgPT0gaW5kZXgp
IHsNCj4gPj4gKwkJCXN0cnVjdCBxaV9kZXNjICpkZXNjID0gcWktPmRlc2MgKyBoZWFkOw0KPiA+
PiArDQo+ID4+ICAgCQkJcHJfZXJyKCJWVC1kIGRldGVjdGVkIGludmFsaWQgZGVzY3JpcHRvcjog
Ig0KPiA+PiAgIAkJCQkibG93PSVsbHgsIGhpZ2g9JWxseFxuIiwNCj4gPj4gLQkJCQkodW5zaWdu
ZWQgbG9uZyBsb25nKXFpLT5kZXNjW2luZGV4XS5sb3csDQo+ID4+IC0JCQkJKHVuc2lnbmVkIGxv
bmcgbG9uZylxaS0+ZGVzY1tpbmRleF0uaGlnaCk7DQo+ID4+IC0JCQltZW1jcHkoJnFpLT5kZXNj
W2luZGV4XSwgJnFpLT5kZXNjW3dhaXRfaW5kZXhdLA0KPiA+PiAtCQkJCQlzaXplb2Yoc3RydWN0
IHFpX2Rlc2MpKTsNCj4gPj4gKwkJCQkodW5zaWduZWQgbG9uZyBsb25nKWRlc2MtPnF3MCwNCj4g
Pj4gKwkJCQkodW5zaWduZWQgbG9uZyBsb25nKWRlc2MtPnF3MSk7DQo+ID4NCj4gPiBTdGlsbCBt
aXNzaW5nIHF3MiBhbmQgcXczLiBNYXkgbWFrZSB0aGUgcHJpbnQgZGlmZmVyIGJhc2VkIG9uIGlm
IHNtdHMgaXMgY29uZmlnZWQuDQo+IA0KPiBxdzIgYW5kIHF3MyBhcmUgcmVzZXJ2ZWQgZnJvbSBz
b2Z0d2FyZSBwb2ludCBvZiB2aWV3LiBXZSBkb24ndCBuZWVkIHRvIHByaW50IGl0IGZvcg0KPiBp
bmZvcm1hdGlvbi4NCg0KQnV0IGZvciBTY2FsYWJsZSBtb2RlLCBpdCBzaG91bGQgYmUgdmFsaWQ/
DQoNCj4gDQo+ID4NCj4gPj4gKwkJCW1lbWNweShkZXNjLCBxaS0+ZGVzYyArICh3YWl0X2luZGV4
IDw8IHNoaWZ0KSwNCj4gPg0KPiA+IFdvdWxkICJtZW1jcHkoZGVzYywgKHVuc2lnbmVkIGxvbmcg
bG9uZykgKHFpLT5kZXNjICsgICh3YWl0X2luZGV4IDw8DQo+ID4gc2hpZnQpLCIgYmUgbW9yZSBz
YWZlPw0KPiANCj4gQ2FuIHRoYXQgYmUgY29tcGlsZWQ/IG1lbWNweSgpIHJlcXVpcmVzIGEgImNv
bnN0IHZvaWQgKiIgZm9yIHRoZSBzZWNvbmQgcGFyYW1ldGVyLg0KPiBCeSB0aGUgd2F5LCB3aHkg
aXQncyBzYWZlciB3aXRoIHRoaXMgY2FzdGluZz8NCg0KVGhpcyBpcyBqdXN0IGFuIGV4YW1wbGUu
IE15IHBvaW50IGlzIHRoZSBwb3NzaWJpbGl0eSB0aGF0ICJxaS0+ZGVzYyArICh3YWl0X2luZGV4
IDw8IHNoaWZ0KSINCndvdWxkIGJlIHRyZWF0ZWQgYXMgInFpLT5kZXNjIHBsdXMgKHdhaXRfaW5k
ZXggPDwgc2hpZnQpKnNpemVvZigqcWktPmRlc2MpIi4gSXMgaXQgcG9zc2libGUNCmZvciBrZXJu
ZWwgYnVpbGQ/DQoNClJlZ2FyZHMsDQpZaSBMaXUNCg==
