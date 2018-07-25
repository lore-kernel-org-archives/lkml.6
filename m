Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CBAC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4871020852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4871020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388530AbeGYDp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:45:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:33459 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727353AbeGYDp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:45:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 19:36:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,400,1526367600"; 
   d="scan'208";a="75239040"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jul 2018 19:36:02 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 24 Jul 2018 19:36:02 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 24 Jul 2018 19:36:02 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.81]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.100]) with mapi id 14.03.0319.002;
 Wed, 25 Jul 2018 10:35:48 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Kirti Wankhede" <kwankhede@nvidia.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated
 devices
Thread-Topic: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated
 devices
Thread-Index: AQHUIYLUWW+rmljvH0aNyiLLdWIbJaScJaUQgAD7g4CAAJkvgIABdrog
Date:   Wed, 25 Jul 2018 02:35:47 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439CA28BB@SHSMSX104.ccr.corp.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
 <1532239773-15325-4-git-send-email-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439CA143E@SHSMSX104.ccr.corp.intel.com>
 <5B568D5B.5050606@linux.intel.com>
 <ccf6890a-30c6-770b-4299-8cabfdc32f2b@arm.com>
In-Reply-To: <ccf6890a-30c6-770b-4299-8cabfdc32f2b@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWUxNjg0N2YtZjVmYy00ODZhLTkyOGQtYzJkODUxZmRiMGM3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWWVaUlY5QVBmVlFMVVVTSmp1ZlA1VG83akp2OXJrQXFrQ0NWK003dXBvVytqVXRvd0dpUkNGYW84V1FEM3IwRiJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmVhbiwNCg0KPiBGcm9tOiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgW21haWx0bzpqZWFuLXBo
aWxpcHBlLmJydWNrZXJAYXJtLmNvbV0NCj4gU2VudDogVHVlc2RheSwgSnVseSAyNCwgMjAxOCA3
OjMxIFBNDQo+IA0KPiBIaSBCYW9sdSwNCj4gDQo+IE9uIDI0LzA3LzE4IDAzOjIyLCBMdSBCYW9s
dSB3cm90ZToNCj4gPiBIaSwNCj4gPg0KPiA+IE9uIDA3LzIzLzIwMTggMTI6NDQgUE0sIExpdSwg
WWkgTCB3cm90ZToNCj4gPj4+IEZyb206IEx1IEJhb2x1IFttYWlsdG86YmFvbHUubHVAbGludXgu
aW50ZWwuY29tXQ0KPiA+Pj4gU2VudDogU3VuZGF5LCBKdWx5IDIyLCAyMDE4IDI6MDkgUE0NCj4g
Pj4+DQo+ID4+PiBXaXRoIHRoZSBJbnRlbCBJT01NVSBzdXBwb3J0aW5nIFBBU0lEIGdyYW51bGFy
aXR5IGlzb2xhdGlvbiBhbmQgcHJvdGVjdGlvbiwgYQ0KPiA+Pj4gbWVkaWF0ZWQgZGV2aWNlIGNv
dWxkIGJlIGlzb2xhdGVkIGFuZCBwcm90ZWN0ZWQgYnkgYW4gSU9NTVUgdW5pdC4gV2UgbmVlZCB0
bw0KPiA+Pj4gYWxsb2NhdGUgYSBuZXcgZ3JvdXAgaW5zdGVhZCBvZiBhIFBDSSBncm91cC4NCj4g
Pj4gRXhpc3RpbmcgdmZpbyBtZGV2IGZyYW1ld29yayBhbHNvIGFsbG9jYXRlcyBhbiBpb21tdSBn
cm91cCBmb3IgbWVkaWF0ZSBkZXZpY2UuDQo+ID4+DQo+ID4+IG1kZXZfcHJvYmUoKQ0KPiA+PiAg
IHxfIG1kZXZfYXR0YWNoX2lvbW11KCkNCj4gPj4gICAgICAgIHxfIGlvbW11X2dyb3VwX2FsbG9j
KCkNCj4gPg0KPiA+IFdoZW4gZXh0ZXJuYWwgY29tcG9uZW50cyBhc2sgaW9tbXUgdG8gYWxsb2Nh
dGUgYSBncm91cCBmb3IgYSBkZXZpY2UsDQo+ID4gaXQgd2lsbCBjYWxsIHBjaV9kZXZpY2VfZ3Jv
dXAgaW4gSW50ZWwgSU9NTVUgZHJpdmVyJ3MgQGRldmljZV9ncm91cA0KPiA+IGNhbGxiYWNrLiBJ
biBhbm90aGVyIHdvcmQsIGN1cnJlbnQgSW50ZWwgSU9NTVUgZHJpdmVyIGRvZXNuJ3QgYXdhcmUN
Cj4gPiB0aGUgbWVkaWF0ZWQgZGV2aWNlIGFuZCB0cmVhdCBhbGwgZGV2aWNlcyBhcyBQQ0kgb25l
cy4gVGhpcyBwYXRjaA0KPiA+IGV4dGVuZHMgdGhlIEBkZXZpY2VfZ3JvdXAgY2FsbCBiYWNrIHRv
IG1ha2UgaXQgYXdhcmUgb2YgYSBtZWRpYXRlZA0KPiA+IGRldmljZS4NCj4gDQo+IEkgYWdyZWUg
dGhhdCBhbGxvY2F0aW5nIHR3byBncm91cHMgZm9yIGFuIG1kZXYgc2VlbXMgc3RyYW5nZSwgYW5k
IGluIG15DQoNClRoZXJlIHdpbGwgbm90IGJlIHR3byBncm91cHMgZm9yIGEgbWRldi4gUGxzIHJl
ZmVyIHRvIFBhdGNoIDA4LzEwIG9mIHRoaXMNCnNlcmllcy4gQmFvbHUgYWRkZWQgaW9tbXVfb3Bz
IGNoZWNrIHdoZW4gZG9pbmcgZ3JvdXAgYWxsb2NhdGlvbiBpbg0KbWRldl9hdHRhY2hfaW9tbXUo
KS4NCg0KW1JGQyBQQVRDSCAwOC8xMF0gdmZpby9tZGV2OiBTZXQgaW9tbXUgb3BzIGZvciBtZGV2
IGJ1cw0KDQpAQCAtMjEsNiArMjEsMTMgQEAgc3RhdGljIGludCBtZGV2X2F0dGFjaF9pb21tdShz
dHJ1Y3QgbWRldl9kZXZpY2UgKm1kZXYpDQogCWludCByZXQ7DQogCXN0cnVjdCBpb21tdV9ncm91
cCAqZ3JvdXA7DQogDQorCS8qDQorCSAqIElmIGlvbW11X29wcyBpcyBzZXQgZm9yIGJ1cywgYWRk
X2RldmljZSgpIHdpbGwgYWxsb2NhdGUNCisJICogYSBncm91cCBhbmQgYWRkIHRoZSBkZXZpY2Ug
aW4gdGhlIGdyb3VwLg0KKwkgKi8NCisJaWYgKGlvbW11X3ByZXNlbnQobWRldi0+ZGV2LmJ1cykp
DQorCQlyZXR1cm4gMDsNCisNCg0KPiBvcGluaW9uIHdlIHNob3VsZG4ndCBleHBvcnQgdGhlIG5v
dGlvbiBvZiBtZGV2IHRvIElPTU1VIGRyaXZlcnMuDQoNClRoZSBrZXkgaWRlYSBvZiB0aGlzIFJG
QyBpcyB0byB0YWcgaW9tbXUgZG9tYWluIHdpdGggUEFTSUQsIGlmIGFueSBtZGV2DQppcyBhZGRl
ZCB0byBzdWNoIGEgZG9tYWluLCBpdCB3b3VsZCBnZXQgdGhlIFBBU0lEIGFuZCBjb25maWcgaW4g
aXRzIHBhcmVudC4NClRodXMgdGhlIHRyYW5zYWN0aW9ucyBmcm9tIG1kZXYgY2FuIGJlIGlzb2xh
dGVkIGluIGlvbW11IGhhcmR3YXJlLg0KDQpCYXNlZCBvbiB0aGlzIGlkZWEsIG1kZXZzIGNhbiBi
ZSBtYW5hZ2VkIGluIGEgZmxleGlibGUgbWFubmVyLiBlLmcuDQppZiB0d28gbWRldnMgYXJlIGFz
c2lnbmVkIHRvIHNhbWUgVk0sIHRoZXkgY2FuIHNoYXJlIFBBU0lELiBUaGlzIHNoYXJlDQpjYW4g
YmUgZWFzaWx5IGFjaGlldmUgYnkgYWRkaW5nIHRoZW0gdG8gdGhlIHNhbWUgZG9tYWluLiBJZiB3
ZSBkZWZhdWx0DQphbGxvY2F0ZSBhIFBBU0lEIGZvciBlYWNoIG1kZXYsIGl0IG1heSBiZSBhIHdh
c3RlLg0KDQpXaXRoIHZlbmRvci1zcGVjaWZpYyBpb21tdSBkcml2ZXIgaGFuZGxlIHRoZSBtZGV2
IGRpZmZlcmVuY2UsIGl0IGNhbg0KbGFyZ2VseSBrZWVwIHRoZSBmdW5kYW1lbnRhbCBpb21tdSBj
b25jZXB0cyBpbiBjdXJyZW50IHNvZnR3YXJlDQppbXBsZW1lbnRhdGlvbi4NCg0KPiBPdGhlcndp
c2UgZWFjaCBkcml2ZXIgd2lsbCBoYXZlIHRvIGFkZCBpdHMgb3duICJkZXZfaXNfbWRldigpIiBz
cGVjaWFsDQo+IGNhc2VzLCB3aGljaCB3aWxsIGdldCBtZXNzeSBpbiB0aGUgbG9uZyBydW4uIEJl
c2lkZXMsIHRoZSBtYWNybyBpcw0KPiBjdXJyZW50bHkgcHJpdmF0ZSwgYW5kIHRvIGJlIGV4cG9y
dGVkIGl0IHNob3VsZCBiZSB3cmFwcGVkIGluDQo+IHN5bWJvbF9nZXQvcHV0KG1kZXZfYnVzX3R5
cGUpLg0KDQpBZ3JlZWQuIFNob3VsZCBmaWd1cmUgb3V0IGEgYmV0dGVyIG1hbm5lci4NCg0KPiBU
aGVyZSBpcyBhbm90aGVyIHdheTogYXMgd2UncmUgcGxhbm5pbmcgdG8gYWRkIGEgZ2VuZXJpYyBw
YXNpZF9hbGxvYygpDQo+IGZ1bmN0aW9uIHRvIHRoZSBJT01NVSBBUEksIHRoZSBtZGV2IG1vZHVs
ZSBpdHNlbGYgY291bGQgYWxsb2NhdGUgYQ0KPiBkZWZhdWx0IFBBU0lEIGZvciBlYWNoIG1kZXYg
YnkgY2FsbGluZyBwYXNpZF9hbGxvYygpIG9uIHRoZSBtZGV2J3MNCj4gcGFyZW50LCBhbmQgdGhl
biBkbyBtYXAoKS91bm1hcCgpIHdpdGggdGhhdCBQQVNJRC4gVGhpcyB3YXkgd2UgZG9uJ3QNCg0K
c28gZmFyLCBtYXAvdW5tYXAgaXMgcGVyLWRvbWFpbiBvcGVyYXRpb24uIEluIHRoaXMgd2F5LCBw
YXNzaW5nIFBBU0lEIG1ha2VzDQppdCBiZSBraW5kIG9mIHBlci1kZXZpY2Ugb3BlcmF0aW9uLiBU
aGlzIG1heSBhZmZlY3QgdG9vIG11Y2ggb2YgZXhpc3Rpbmcgc29mdHdhcmUNCmltcGxlbWVudGF0
aW9uLg0KDQo+IGhhdmUgdG8gYWRkIElPTU1VIG9wcyB0byB0aGUgbWRldiBidXMsIGV2ZXJ5dGhp
bmcgY2FuIHN0aWxsIGJlIGRvbmUNCj4gdXNpbmcgdGhlIG9wcyBvZiB0aGUgcGFyZW50LiBBbmQg
SU9NTVUgZHJpdmVycyAib25seSIgaGF2ZSB0byBpbXBsZW1lbnQNCj4gUEFTSUQgb3BzLCB3aGlj
aCB3aWxsIGJlIHJldXNlZCBieSBkcml2ZXJzIG90aGVyIHRoYW4gbWRldi4NCj4gDQo+IFRoZSBh
bGxvY2F0ZWQgUEFTSUQgYWxzbyBuZWVkcyB0byBiZSBpbnN0YWxsZWQgaW50byB0aGUgcGFyZW50
IGRldmljZS4NCj4gSWYgdGhlIG1kZXYgbW9kdWxlIGtub3dzIHRoZSBQQVNJRCwgd2UgY2FuIGRv
IHRoYXQgYnkgYWRkaW5nDQo+IHNldF9wYXNpZChtZGV2LCBwYXNpZCkgYW5kIGNsZWFyX3Bhc2lk
KG1kZXYsIHBhc2lkKSBvcGVyYXRpb25zIHRvDQo+IG1kZXZfcGFyZW50X29wcy4NCg0KWW91ciBp
ZGVhIGlzIGZhc2NpbmF0aW5nLiBQbHMgZmVlbCBmcmVlIGxldCB1cyBrbm93IGlmIHdlIG1pc3Nl
ZCBhbnkgZnJvbSB5b3UuIDopDQoNCj4gVGhhbmtzLA0KPiBKZWFuDQoNClRoYW5rcywNCllpIExp
dQ0K
