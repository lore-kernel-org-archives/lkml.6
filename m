Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18479C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBD52147E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBD52147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeIMFmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 01:42:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:8907 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbeIMFmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 01:42:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 17:35:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,367,1531810800"; 
   d="scan'208";a="89984534"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga001.jf.intel.com with ESMTP; 12 Sep 2018 17:35:24 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 12 Sep 2018 17:35:23 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.205]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.240]) with mapi id 14.03.0319.002;
 Thu, 13 Sep 2018 08:35:21 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Kirti Wankhede" <kwankhede@nvidia.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [RFC PATCH v2 08/10] vfio/type1: Add domain at(de)taching group
 helpers
Thread-Topic: [RFC PATCH v2 08/10] vfio/type1: Add domain at(de)taching
 group helpers
Thread-Index: AQHUSsGwaQymE1k7kU+SruPVMmdMqqTtWXUg
Date:   Thu, 13 Sep 2018 00:35:21 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191300D35@SHSMSX101.ccr.corp.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <20180830040922.30426-9-baolu.lu@linux.intel.com>
 <c5124ac1-65fe-7f89-265c-bef229bc5ce9@arm.com>
 <a97c8f75-ff49-5b87-198f-d3c8950d4e90@linux.intel.com>
 <04f5dc9d-71b1-37ec-402b-fae5f9e08664@arm.com>
In-Reply-To: <04f5dc9d-71b1-37ec-402b-fae5f9e08664@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGMwOTM5YzQtMzhkMC00MjdkLTlmNWItYjk4ZTQxOTZlZmUzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNWl4NllOOVVHbVRJK3Q4NkVudHJUZjEzT05aSG1hWWlmK1wvMEFNQ3VPbk5neHhYUGcyQ0Z3ZXBZeFdpVENYWTkifQ==
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

PiBGcm9tOiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgW21haWx0bzpqZWFuLXBoaWxpcHBlLmJydWNr
ZXJAYXJtLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAxMywgMjAxOCAxOjU0IEFN
DQo+IA0KPiBPbiAxMi8wOS8yMDE4IDA2OjAyLCBMdSBCYW9sdSB3cm90ZToNCj4gPiBIaSwNCj4g
Pg0KPiA+IE9uIDA5LzExLzIwMTggMTI6MjMgQU0sIEplYW4tUGhpbGlwcGUgQnJ1Y2tlciB3cm90
ZToNCj4gPj4gT24gMzAvMDgvMjAxOCAwNTowOSwgTHUgQmFvbHUgd3JvdGU6DQo+ID4+PiArc3Rh
dGljIGludCB2ZmlvX2RldGFjaF9hdXhfZG9tYWluKHN0cnVjdCBkZXZpY2UgKmRldiwgdm9pZCAq
ZGF0YSkNCj4gPj4+ICt7DQo+ID4+PiArCXN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiA9IGRh
dGE7DQo+ID4+PiArDQo+ID4+PiArCXZmaW9fbWRldl9zZXRfYXV4X2RvbWFpbihkZXYsIE5VTEwp
Ow0KPiA+Pj4gKwlpb21tdV9kZXRhY2hfZGV2aWNlKGRvbWFpbiwgZGV2LT5wYXJlbnQpOw0KPiA+
Pg0KPiA+PiBJIHRoaW5rIHRoYXQncyBvbmx5IGdvaW5nIHRvIHdvcmsgZm9yIHZ0LWQsIHdoaWNo
IGRvZXNuJ3QgdXNlIGENCj4gPj4gZGVmYXVsdF9kb21haW4uIEZvciBvdGhlciBkcml2ZXJzLCBp
b21tdS5jIGVuZHMgdXAgY2FsbGluZw0KPiA+PiBkb21haW4tPm9wcy0+YXR0YWNoX2RldihkZWZh
dWx0X2RvbWFpbiwgZGV2KSBoZXJlLCB3aGljaCBpc24ndCB3aGF0DQo+IHdlIHdhbnQuDQo+ID4N
Cj4gPiBUaGlzIGRvZXNuJ3QgYnJlYWsgYW55IGZ1bmN0aW9uYWxpdHkuIEl0IHRha2VzIGVmZmVj
dCBvbmx5IGlmIGlvbW11DQo+ID4gaGFyZHdhcmUgc3VwcG9ydHMgZmluZXIgZ3JhbnVsYXIgdHJh
bnNsYXRpb24gYW5kIGFkdmVydGlzZXMgaXQgdGhyb3VnaA0KPiA+IHRoZSBBUEkuPg0KPiA+PiBU
aGF0IHdhcyBteSBjb25jZXJuIHdpdGggcmV1c2luZyBhdHRhY2gvZGV0YWNoX2RldiBjYWxsYmFj
a3MgZm9yDQo+IFBBU0lEDQo+ID4+IG1hbmFnZW1lbnQuIFRoZSBhdHRhY2hfZGV2IGNvZGUgb2Yg
SU9NTVUgZHJpdmVycyBhbHJlYWR5IGhhcyB0bw0KPiBkZWFsDQo+ID4+IHdpdGggdG9nZ2xpbmcg
YmV0d2VlbiBkZWZhdWx0IGFuZCB1bm1hbmFnZWQgZG9tYWluLiBEZWFsaW5nIHdpdGgNCj4gbW9y
ZQ0KPiA+PiBzdGF0ZSB0cmFuc2l0aW9ucyBpbiB0aGUgc2FtZSBwYXRoIGlzIGdvaW5nIHRvIGJl
IGRpZmZpY3VsdC4NCj4gPg0KPiA+IExldCdzIGNvbnNpZGVyIGl0IGZyb20gdGhlIEFQSSBwb2lu
dCBvZiB2aWV3Lg0KPiA+DQo+ID4gV2UgaGF2ZSBpb21tdV9hKGRlKXR0YWNoX2RldmljZSgpIEFQ
SXMgdG8gYXR0YWNoIG9yIGRldGFjaCBhIGRvbWFpbg0KPiA+IHRvL2Zyb20gYSBkZXZpY2UuIFdl
IHNob3VsZCBhdm9pZCBhcHBseWluZyBhIGxpbWl0YXRpb24gb2YgInRoZXNlIGFyZQ0KPiA+IG9u
bHkgZm9yIHNpbmdsZSBkb21haW4gY2FzZSwgZm9yIG11bHRpcGxlIGRvbWFpbnMsIHVzZSBhbm90
aGVyIEFQSSIuDQo+IA0KPiBUaGF0J3MgYW4gaWRlYWxpemVkIHZpZXcgb2YgdGhlIEFQSSwgdGhl
IGFjdHVhbCBzZW1hbnRpY3MgYXJlbid0IGFzDQo+IHNpbXBsZS4gRm9yIElPTU1VIGRyaXZlcnMg
dGhhdCBpbXBsZW1lbnQgSU9NTVVfRE9NQUlOX0RNQSBpbiB0aGVpcg0KPiBkb21haW5fYWxsb2Mg
b3BlcmF0aW9uIChBcm0gU01NVSwgQU1EIElPTU1VLCAuLi4pLCBhdHRhY2hfZGV2DQo+IGF0dGFj
aGVzDQo+IGFuIHVubWFuYWdlZCBkb21haW4sIGRldGFjaF9kZXYgcmVhdHRhY2hlcyB0aGUgZGVm
YXVsdCBETUEgZG9tYWluLA0KPiBhbmQNCj4gdGhlIGRldGFjaF9kZXYgSU9NTVUgb3AgaXMgbm90
IGNhbGxlZC4gV2UgY2FuJ3QgY2hhbmdlIHRoYXQgbm93LCBzbyBpdCdzDQo+IGRpZmZpY3VsdCB0
byBhZGQgbW9yZSBmdW5jdGlvbmFsaXR5IHRvIGF0dGFjaF9kZXYgYW5kIGRldGFjaF9kZXYuDQo+
IA0KDQpOb3cgd2UgaGF2ZSBmb3VyIHBvc3NpYmxlIHVzYWdlcyBvbiBhKGRlKXR0YWNoX2Rldmlj
ZToNCg0KMSkgTm9ybWFsIERNQSBBUEkgcGF0aCBpLmUuIElPTU1VX0RPTUFJTl9ETUEsIGZvciBE
TUEgb3BlcmF0aW9ucw0KaW4gaG9zdC9wYXJlbnQgZGV2aWNlIGRyaXZlcjsNCg0KMikgVkZJTyBw
YXNzdGhydSBwYXRoLCB3aGVuIHRoZSBwaHlzaWNhbCBkZXZpY2UgaXMgYXNzaWduZWQgdG8gdXNl
ciBzcGFjZQ0Kb3IgZ3Vlc3QgZHJpdmVyDQoNCjMpIG1kZXYgcGFzc3RocnUgcGF0aCAxLCB3aGVu
IG1kZXYgaXMgYXNzaWduZWQgdG8gdXNlciBzcGFjZSBvciBndWVzdA0KZHJpdmVyLiBIZXJlIG1k
ZXYgaXMgYSB3cmFwIG9uIHJhbmRvbSBQQ0kgZGV2aWNlDQoNCjQpIG1kZXYgcGFzc3RocnUgcGF0
aCAyLCB3aGVuIG1kZXYgaXMgYXNzaWduZWQgdG8gdXNlciBzcGFjZSBvciBndWVzdA0KZHJpdmVy
LiBIZXJlIG1kZXYgaXMgaW4gYSBzbWFsbGVyIGdyYW51bGFyaXR5IChlLmcuIHRhZ2dlZCBieSBQ
QVNJRCkgYXMNCnN1cHBvcnRlZCBieSB2dC1kIHNjYWxhYmxlIG1vZGUNCg0KMSkgYW5kIDIpIGFy
ZSBleGlzdGluZyB1c2FnZXMuIFdoYXQgeW91IGRlc2NyaWJlZCAodW5tYW5hZ2VkIHZzLiBkZWZh
dWx0KQ0KZmFsbHMgaW50byB0aGlzIGNhdGVnb3J5Lg0KDQozKSBpcyBhY3R1YWxseSBzYW1lIGFz
IDIpIGluIElPTU1VIGxheWVyLiBzb3J0IG9mIHBhc3NpbmcgdGhyb3VnaCBETUENCmNhcGFiaWxp
dHkgdG8gZ3Vlc3QuIFRob3VnaCB0aGVyZSBpcyBzdGlsbCBhIHBhcmVudCBkcml2ZXIsIHRoZSBw
YXJlbnQgZHJpdmVyDQppdHNlbGYgc2hvdWxkIG5vdCBkbyBETUEgLSBpLmUuIHVubWFuYWdlZCBp
biBob3N0IHNpZGUuDQoNCjQpIGlzIGEgbmV3IGNvZGUgcGF0aCBpbnRyb2R1Y2VkIGluIElPTU1V
IGxheWVyLCB3aGljaCBpcyB3aGF0DQp2ZmlvX2EoZGUpdGFjaF9hdXhfZG9tYWluIGlzIHRyeWlu
ZyB0byBhZGRyZXNzLiBJbiB0aGlzIGNhc2UgcGFyZW50IGRldmljZQ0KY2FuIHN0aWxsIGhhdmUg
aXRzIG93biBETUEgY2FwYWJpbGl0eSwgdXNpbmcgZXhpc3RpbmcgY29kZSBwYXRoIDEpICh0aHVz
DQpkZWZhdWx0IGRvbWFpbiBzdGlsbCBhcHBsaWVzKS4gYW5kIHRoZSBwYXJlbnQgZGV2aWNlIGNh
biBoYXZlIG11bHRpcGxlIA0KYXV4IGRvbWFpbnMgKGFuZCBhc3NvY2lhdGVkIHN0cnVjdHVyZXMp
LCB1c2luZyBjb2RlIHBhdGggNCkuDQoNCkkgZGlkbid0IHNlZSBob3cgdGhpcyBuZXcgY29kZSBw
YXRoIGludGVyZmVyZXMgd2l0aCBkZWZhdWx0IGRvbWFpbiANCmNvbmNlcHQgaW4gZXhpc3Rpbmcg
cGF0aC4gSW4gdGhlIGZ1dHVyZSBpZiBBUk0gb3Igb3RoZXIgYXJjaGl0ZWN0dXJlcw0KcGxhbiB0
byBzdXBwb3J0IHNpbWlsYXIgc2NhbGFibGUgbW9kZSBjYXBhYmlsaXR5LCBvbmx5IHRoZSBuZXcg
Y29kZQ0KcGF0aCBzaG91bGQgYmUgdHdlYWtlZC4NCg0KVGhhbmtzDQpLZXZpbg0K
