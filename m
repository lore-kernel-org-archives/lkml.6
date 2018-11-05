Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BA8C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FD720827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FD720827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbeKEQaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:30:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:25501 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729000AbeKEQaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:30:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 23:08:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,467,1534834800"; 
   d="scan'208";a="93709141"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Nov 2018 23:08:55 -0800
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 4 Nov 2018 23:08:55 -0800
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 4 Nov 2018 23:08:54 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.117]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.161]) with mapi id 14.03.0415.000;
 Mon, 5 Nov 2018 15:08:53 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: RE: [PATCH 1/1] iommu/vtd: Fix NULL pointer dereference in
 prq_event_thread()
Thread-Topic: [PATCH 1/1] iommu/vtd: Fix NULL pointer dereference in
 prq_event_thread()
Thread-Index: AQHUdMsI/M/bjFj9FEyLk+v3JlicsqVAwhRA
Date:   Mon, 5 Nov 2018 07:08:52 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D5E057@SHSMSX104.ccr.corp.intel.com>
References: <20181105021858.16958-1-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D5DF53@SHSMSX104.ccr.corp.intel.com>
 <f35802b2-124f-ff54-5be3-a1fb99b2b2c6@linux.intel.com>
In-Reply-To: <f35802b2-124f-ff54-5be3-a1fb99b2b2c6@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDdhY2YzNjQtZGM0Ny00YjQxLWE3ZWQtODIxZTZhYjA4OWE3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiXC9RQVA2Q0p3UzZzb3BDQlQxNWVybGZPb25FXC9Rd293MFNRTWs3a3czbDBLbnJlMkJUcERjOWg4QVEydHNleFBpIn0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMdSBCYW9sdSBbbWFpbHRvOmJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbV0NCj4gU2Vu
dDogTW9uZGF5LCBOb3ZlbWJlciA1LCAyMDE4IDE6NDUgUE0NCj4gVG86IExpdSwgWWkgTCA8eWku
bC5saXVAaW50ZWwuY29tPjsgSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+OyBEYXZpZA0K
PiBXb29kaG91c2UgPGR3bXcyQGluZnJhZGVhZC5vcmc+DQo+IENjOiBiYW9sdS5sdUBsaW51eC5p
bnRlbC5jb207IFJhaiwgQXNob2sgPGFzaG9rLnJhakBpbnRlbC5jb20+OyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIGlvbW11L3Z0ZDogRml4IE5VTEwgcG9pbnRlciBkZXJl
ZmVyZW5jZSBpbg0KPiBwcnFfZXZlbnRfdGhyZWFkKCkNCj4gDQo+IEhpIFlpLA0KPiANCj4gT24g
MTEvNS8xOCAxOjIxIFBNLCBMaXUsIFlpIEwgd3JvdGU6DQo+ID4gSGkgQmFvbHUsDQo+ID4NCj4g
Pj4gRnJvbTogaW9tbXUtYm91bmNlc0BsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyBbbWFpbHRv
OmlvbW11LQ0KPiA+PiBib3VuY2VzQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnXSBPbiBCZWhh
bGYgT2YgTHUgQmFvbHUNCj4gPj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciA1LCAyMDE4IDEwOjE5
IEFNDQo+ID4+IFRvOiBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9yZz47IERhdmlkIFdvb2Ro
b3VzZQ0KPiA+PiA8ZHdtdzJAaW5mcmFkZWFkLm9yZz4NCj4gPj4gQ2M6IFJhaiwgQXNob2sgPGFz
aG9rLnJhakBpbnRlbC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZw0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggMS8x
XSBpb21tdS92dGQ6IEZpeCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgaW4NCj4gPj4gcHJxX2V2
ZW50X3RocmVhZCgpDQo+ID4+DQo+ID4+IFdoZW4gaGFuZGxpbmcgcGFnZSByZXF1ZXN0IHdpdGhv
dXQgcGFzaWQgZXZlbnQsIGdvIHRvICJub19wYXNpZCINCj4gPj4gYnJhbmNoIGluc3RlYWQgb2Yg
ImJhZF9yZXEiLiBPdGhlcndpc2UsIGEgTlVMTCBwb2ludGVyIGRlZmVyZW5jZSB3aWxsIGhhcHBl
bg0KPiB0aGVyZS4NCj4gPj4NCj4gPj4gQ2M6IEFzaG9rIFJhaiA8YXNob2sucmFqQGludGVsLmNv
bT4NCj4gPj4gQ2M6IEphY29iIFBhbiA8amFjb2IuanVuLnBhbkBsaW51eC5pbnRlbC5jb20+DQo+
ID4+IENjOiBTb2hpbCBNZWh0YSA8c29oaWwubWVodGFAaW50ZWwuY29tPg0KPiA+PiBTaWduZWQt
b2ZmLWJ5OiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiA+PiAtLS0NCj4g
Pj4gICBkcml2ZXJzL2lvbW11L2ludGVsLXN2bS5jIHwgMiArLQ0KPiA+PiAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pb21tdS9pbnRlbC1zdm0uYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtc3ZtLmMN
Cj4gPj4gaW5kZXgNCj4gPj4gZGIzMDFlZmUxMjZkLi44ODcxNTA5MDc1MjYgMTAwNjQ0DQo+ID4+
IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwtc3ZtLmMNCj4gPj4gKysrIGIvZHJpdmVycy9pb21t
dS9pbnRlbC1zdm0uYw0KPiA+PiBAQCAtNTk1LDcgKzU5NSw3IEBAIHN0YXRpYyBpcnFyZXR1cm5f
dCBwcnFfZXZlbnRfdGhyZWFkKGludCBpcnEsIHZvaWQgKmQpDQo+ID4+ICAgCQkJcHJfZXJyKCIl
czogUGFnZSByZXF1ZXN0IHdpdGhvdXQgUEFTSUQ6ICUwOGxseCAlMDhsbHhcbiIsDQo+ID4+ICAg
CQkJICAgICAgIGlvbW11LT5uYW1lLCAoKHVuc2lnbmVkIGxvbmcgbG9uZyAqKXJlcSlbMF0sDQo+
ID4+ICAgCQkJICAgICAgICgodW5zaWduZWQgbG9uZyBsb25nICopcmVxKVsxXSk7DQo+ID4+IC0J
CQlnb3RvIGJhZF9yZXE7DQo+ID4+ICsJCQlnb3RvIG5vX3Bhc2lkOw0KPiA+PiAgIAkJfQ0KPiA+
Pg0KPiA+PiAgIAkJaWYgKCFzdm0gfHwgc3ZtLT5wYXNpZCAhPSByZXEtPnBhc2lkKSB7DQo+ID4+
IC0tDQo+ID4NCj4gPiBJJ20gYWZyYWlkIGl0IGlzIHN0aWxsIG5lY2Vzc2FyeSB0byBnb3RvICJi
YWRfcmVxIi4gVGhlIGZvbGxvd2luZyBjb2RlDQo+ID4gYmVoaW5kICJiYWRfcmVxIiB3aWxsIHRy
aWdnZXIgZmF1bHRfY2IgcmVnaXN0ZXJlZCBieSBpbi1rZXJuZWwNCj4gPiBkcml2ZXJzLiBJdCBp
cyByZWFzb25hYmxlIHRoYXQgUFJRIHdpdGhvdXQgUEFTSUQgY2FuIGJlIGhhbmRsZWQgYnkNCj4g
PiBzdWNoIGNhbGxiYWNrcy4gU28gSSB3b3VsZCBzdWdnZXN0IHRvIGtlZXAgdGhlIGV4aXN0aW5n
IGxvZ2ljLg0KPiANCj4gQSBwYWdlIGZhdWx0IHdpdGhvdXQgYSBwYXNpZCBpcyB0cmlnZ2VyZWQg
YnkgYSBETUEgdHJhbnNmZXIgd2l0aG91dCBQQVNJRC4gSXQgZG9lc24ndA0KPiByZWxhdGUgdG8g
dGhlIFNWTSBmdW5jdGlvbmFsaXR5IGhlbmNlIHRoZXJlJ3Mgbm8gQHN2bSBvciBAc2RldiByZWxh
dGVkIHRvIGl0LiBJdCdzDQo+IHVubmVjZXNzYXJ5IHRvIHJlcG9ydCBpdCB0byB0aGUgZHJpdmVy
cyBhcyBmYXIgYXMgSSBjYW4gc2VlLg0KIA0KWWVhaCwgYSBQUlEgd2l0aG91dCBQQVNJRCBoYXMg
bm8gY29ycmVzcG9uZGluZyBzdm0gb3Igc2RldiBzdHJ1Y3R1cmUuIFJlZ2FyZHMgdG8gdGhpcw0K
ZmFjdCwgaXQncyBhY2NlcHRhYmxlIGZvciB0aGlzIGZpeC4gSW4gbG9uZyB0ZXJtLCBpdCBtaWdo
dCBiZSBoZWxwZnVsIHRvIHJlZmluZSB0aGUgUFJRIGV2ZW50DQpoYW5kbGVyIHRvIGNvdmVyIFBS
USB3aXRob3V0IFBBU0lELiBJIGd1ZXNzIEphY29iJ3MgZmF1bHQgcmVwb3J0IGZyYW1ld29yayBt
YXkgaGVscC4NCg0KK0phY29iDQoNClJlZ2FyZHMsDQpZaSBMaXUNCg==
