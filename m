Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C7AC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB7420857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB7420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeKHPS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:18:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:40059 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbeKHPS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:18:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 21:45:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="89479551"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga006.jf.intel.com with ESMTP; 07 Nov 2018 21:45:12 -0800
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 7 Nov 2018 21:45:12 -0800
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 7 Nov 2018 21:45:11 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.117]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.161]) with mapi id 14.03.0415.000;
 Thu, 8 Nov 2018 13:45:10 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>
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
Thread-Index: AQHUdMlDcnwPlQkmSk2wysYaWtdoaqVDpZEQgAD8+ICAAJeH4P//nPMAgACJwKA=
Date:   Thu, 8 Nov 2018 05:45:09 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D60581@SHSMSX104.ccr.corp.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-5-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D5FAA2@SHSMSX104.ccr.corp.intel.com>
 <a6e43ddd-0889-4a4a-b908-993db28c6d87@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D604DF@SHSMSX104.ccr.corp.intel.com>
 <915876cd-6a1f-097b-b9be-9cb3df18a1df@linux.intel.com>
In-Reply-To: <915876cd-6a1f-097b-b9be-9cb3df18a1df@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODg5NTVlMGMtMzlmNi00MGM5LWFiYjUtMzA3YWQyOWM4N2M0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYU81clFPZWk1MDNSelorWkl1WWJRTDJGSW1RelpZTjNRRURRUEJDcW5rU256cHpiUzh3aWVwYlBtQm1GUUpJbiJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEZyb206IEx1IEJhb2x1IFttYWlsdG86YmFvbHUubHVAbGludXguaW50ZWwuY29tXQ0KPiBT
ZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgOCwgMjAxOCAxOjI1IFBNDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjQgMDQvMTJdIGlvbW11L3Z0LWQ6IEFkZCAyNTYtYml0IGludmFsaWRhdGlvbiBkZXNj
cmlwdG9yDQo+IHN1cHBvcnQNCj4gDQo+IEhpLA0KPiANCj4gT24gMTEvOC8xOCAxMTo0OSBBTSwg
TGl1LCBZaSBMIHdyb3RlOg0KPiA+IEhpLA0KPiA+DQo+ID4+IEZyb206IEx1IEJhb2x1IFttYWls
dG86YmFvbHUubHVAbGludXguaW50ZWwuY29tXQ0KPiA+PiBTZW50OiBUaHVyc2RheSwgTm92ZW1i
ZXIgOCwgMjAxOCAxMDoxNyBBTQ0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDA0LzEyXSBp
b21tdS92dC1kOiBBZGQgMjU2LWJpdCBpbnZhbGlkYXRpb24NCj4gPj4gZGVzY3JpcHRvciBzdXBw
b3J0DQo+ID4+DQo+ID4+IEhpIFlpLA0KPiA+Pg0KPiA+PiBPbiAxMS83LzE4IDI6MDcgUE0sIExp
dSwgWWkgTCB3cm90ZToNCj4gPj4+IEhpIEJhb2x1LA0KPiA+Pj4NCj4gPj4+PiBGcm9tOiBMdSBC
YW9sdSBbbWFpbHRvOmJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbV0NCj4gPj4+PiBTZW50OiBNb25k
YXksIE5vdmVtYmVyIDUsIDIwMTggMTozMiBQTQ0KPiA+Pj4NCj4gPj4+IFsuLi5dDQo+ID4+Pg0K
PiA+Pj4+IC0tLQ0KPiA+Pj4+ICAgIGRyaXZlcnMvaW9tbXUvZG1hci5jICAgICAgICAgICAgICAg
IHwgODMgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gPj4+PiAgICBkcml2ZXJzL2lv
bW11L2ludGVsLXN2bS5jICAgICAgICAgICB8IDc2ICsrKysrKysrKysrKysrKystLS0tLS0tLS0t
DQo+ID4+Pj4gICAgZHJpdmVycy9pb21tdS9pbnRlbF9pcnFfcmVtYXBwaW5nLmMgfCAgNiArKy0N
Cj4gPj4+PiAgICBpbmNsdWRlL2xpbnV4L2ludGVsLWlvbW11LmggICAgICAgICB8ICA5ICsrKy0N
Cj4gPj4+PiAgICA0IGZpbGVzIGNoYW5nZWQsIDExNSBpbnNlcnRpb25zKCspLCA1OSBkZWxldGlv
bnMoLSkNCj4gPj4+Pg0KPiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2RtYXIuYyBi
L2RyaXZlcnMvaW9tbXUvZG1hci5jIGluZGV4DQo+ID4+Pj4gZDljNzQ4YjZmOWU0Li5lYzEwNDI3
Yjk4YWMgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9kbWFyLmMNCj4gPj4+PiAr
KysgYi9kcml2ZXJzL2lvbW11L2RtYXIuYw0KPiA+Pj4+IEBAIC0xMTYwLDYgKzExNjAsNyBAQCBz
dGF0aWMgaW50IHFpX2NoZWNrX2ZhdWx0KHN0cnVjdCBpbnRlbF9pb21tdQ0KPiA+Pj4+ICppb21t
dSwgaW50DQo+ID4+Pj4gaW5kZXgpDQo+ID4+Pj4gICAgCWludCBoZWFkLCB0YWlsOw0KPiA+Pj4+
ICAgIAlzdHJ1Y3QgcV9pbnZhbCAqcWkgPSBpb21tdS0+cWk7DQo+ID4+Pj4gICAgCWludCB3YWl0
X2luZGV4ID0gKGluZGV4ICsgMSkgJSBRSV9MRU5HVEg7DQo+ID4+Pj4gKwlpbnQgc2hpZnQgPSBx
aV9zaGlmdChpb21tdSk7DQo+ID4+Pj4NCj4gPj4+PiAgICAJaWYgKHFpLT5kZXNjX3N0YXR1c1t3
YWl0X2luZGV4XSA9PSBRSV9BQk9SVCkNCj4gPj4+PiAgICAJCXJldHVybiAtRUFHQUlOOw0KPiA+
Pj4+IEBAIC0xMTczLDEzICsxMTc0LDE1IEBAIHN0YXRpYyBpbnQgcWlfY2hlY2tfZmF1bHQoc3Ry
dWN0DQo+ID4+Pj4gaW50ZWxfaW9tbXUgKmlvbW11LCBpbnQgaW5kZXgpDQo+ID4+Pj4gICAgCSAq
Lw0KPiA+Pj4+ICAgIAlpZiAoZmF1bHQgJiBETUFfRlNUU19JUUUpIHsNCj4gPj4+PiAgICAJCWhl
YWQgPSByZWFkbChpb21tdS0+cmVnICsgRE1BUl9JUUhfUkVHKTsNCj4gPj4+PiAtCQlpZiAoKGhl
YWQgPj4gRE1BUl9JUV9TSElGVCkgPT0gaW5kZXgpIHsNCj4gPj4+PiArCQlpZiAoKGhlYWQgPj4g
c2hpZnQpID09IGluZGV4KSB7DQo+ID4+Pj4gKwkJCXN0cnVjdCBxaV9kZXNjICpkZXNjID0gcWkt
PmRlc2MgKyBoZWFkOw0KPiA+Pj4+ICsNCj4gPj4+PiAgICAJCQlwcl9lcnIoIlZULWQgZGV0ZWN0
ZWQgaW52YWxpZCBkZXNjcmlwdG9yOiAiDQo+ID4+Pj4gICAgCQkJCSJsb3c9JWxseCwgaGlnaD0l
bGx4XG4iLA0KPiA+Pj4+IC0JCQkJKHVuc2lnbmVkIGxvbmcgbG9uZylxaS0+ZGVzY1tpbmRleF0u
bG93LA0KPiA+Pj4+IC0JCQkJKHVuc2lnbmVkIGxvbmcgbG9uZylxaS0+ZGVzY1tpbmRleF0uaGln
aCk7DQo+ID4+Pj4gLQkJCW1lbWNweSgmcWktPmRlc2NbaW5kZXhdLCAmcWktPmRlc2Nbd2FpdF9p
bmRleF0sDQo+ID4+Pj4gLQkJCQkJc2l6ZW9mKHN0cnVjdCBxaV9kZXNjKSk7DQo+ID4+Pj4gKwkJ
CQkodW5zaWduZWQgbG9uZyBsb25nKWRlc2MtPnF3MCwNCj4gPj4+PiArCQkJCSh1bnNpZ25lZCBs
b25nIGxvbmcpZGVzYy0+cXcxKTsNCj4gPj4+DQo+ID4+PiBTdGlsbCBtaXNzaW5nIHF3MiBhbmQg
cXczLiBNYXkgbWFrZSB0aGUgcHJpbnQgZGlmZmVyIGJhc2VkIG9uIGlmIHNtdHMgaXMgY29uZmln
ZWQuDQo+ID4+DQo+ID4+IHF3MiBhbmQgcXczIGFyZSByZXNlcnZlZCBmcm9tIHNvZnR3YXJlIHBv
aW50IG9mIHZpZXcuIFdlIGRvbid0IG5lZWQNCj4gPj4gdG8gcHJpbnQgaXQgZm9yIGluZm9ybWF0
aW9uLg0KPiA+DQo+ID4gQnV0IGZvciBTY2FsYWJsZSBtb2RlLCBpdCBzaG91bGQgYmUgdmFsaWQ/
DQo+IA0KPiBOby4gSXQncyByZXNlcnZlZCBmb3Igc29mdHdhcmUuDQoNCk5vLCBJIGRvbuKAmXQg
dGhpbmsgc28uIFBSUSByZXNwb25zZSB3b3VsZCBhbHNvIGJlIHF1ZXVlZCB0byBoYXJkd2FyZSBi
eSBRSS4gRm9yIHN1Y2gNClFJIGRlc2NyaXB0b3JzLCB0aGUgaGlnaCBiaXRzIGFyZSBub3QgcmVz
ZXJ2ZWQuDQoNCj4gPj4NCj4gPj4+DQo+ID4+Pj4gKwkJCW1lbWNweShkZXNjLCBxaS0+ZGVzYyAr
ICh3YWl0X2luZGV4IDw8IHNoaWZ0KSwNCj4gPj4+DQo+ID4+PiBXb3VsZCAibWVtY3B5KGRlc2Ms
ICh1bnNpZ25lZCBsb25nIGxvbmcpIChxaS0+ZGVzYyArICAod2FpdF9pbmRleCA8PA0KPiA+Pj4g
c2hpZnQpLCIgYmUgbW9yZSBzYWZlPw0KPiA+Pg0KPiA+PiBDYW4gdGhhdCBiZSBjb21waWxlZD8g
bWVtY3B5KCkgcmVxdWlyZXMgYSAiY29uc3Qgdm9pZCAqIiBmb3IgdGhlIHNlY29uZA0KPiBwYXJh
bWV0ZXIuDQo+ID4+IEJ5IHRoZSB3YXksIHdoeSBpdCdzIHNhZmVyIHdpdGggdGhpcyBjYXN0aW5n
Pw0KPiA+DQo+ID4gVGhpcyBpcyBqdXN0IGFuIGV4YW1wbGUuIE15IHBvaW50IGlzIHRoZSBwb3Nz
aWJpbGl0eSB0aGF0ICJxaS0+ZGVzYyArICh3YWl0X2luZGV4IDw8DQo+IHNoaWZ0KSINCj4gPiB3
b3VsZCBiZSB0cmVhdGVkIGFzICJxaS0+ZGVzYyBwbHVzICh3YWl0X2luZGV4IDw8DQo+ID4gc2hp
ZnQpKnNpemVvZigqcWktPmRlc2MpIi4gSXMgaXQgcG9zc2libGUgZm9yIGtlcm5lbCBidWlsZD8N
Cj4gDQo+IHFpLT5kZXNjIGlzIG9mIHR5cGUgb2YgInZvaWQgKiIuDQoNCm5vLCBJIGRvbuKAmXQg
dGhpbmsgc28uLi4gUmVmZXIgdG8gdGhlIGNvZGUgYmVsb3cuIEV2ZW4gaXQgaGFzIG5vIGNvcnJl
Y3RuZXNzIGlzc3VlIGhlciwNCkl0J3Mgbm90IGR1ZSB0byBxaS0+ZGVzYyBpcyAidm9pZCAqIiB0
eXBlLi4uDQoNCnN0cnVjdCBxaV9kZXNjIHsNCi0JdTY0IGxvdywgaGlnaDsNCisJdTY0IHF3MDsN
CisJdTY0IHF3MTsNCisJdTY0IHF3MjsNCisJdTY0IHF3MzsNCn07DQoNClJlZ2FyZHMsDQpZaSBM
aXUNCg==
