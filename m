Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E256DC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3992720671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3992720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbeGYHaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 03:30:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:56045 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728120AbeGYHaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 03:30:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 23:20:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,400,1526367600"; 
   d="scan'208";a="70088335"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2018 23:19:49 -0700
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 24 Jul 2018 23:19:49 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 24 Jul 2018 23:19:48 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.173]) with mapi id 14.03.0319.002;
 Wed, 25 Jul 2018 14:19:46 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     'Jean-Philippe Brucker' <jean-philippe.brucker@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: RE: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated
 devices
Thread-Topic: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated
 devices
Thread-Index: AQHUIYLU0u0k0vB4lUGhJp9aIAl9hqSbto0AgAFqm4CAAJkvgIABd3XwgAA4QWA=
Date:   Wed, 25 Jul 2018 06:19:46 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19127FF05@SHSMSX101.ccr.corp.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
 <1532239773-15325-4-git-send-email-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439CA143E@SHSMSX104.ccr.corp.intel.com>
 <5B568D5B.5050606@linux.intel.com>
 <ccf6890a-30c6-770b-4299-8cabfdc32f2b@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19127FB9E@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19127FB9E@SHSMSX101.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDYzZTdmMGItZGFhMi00Mjk4LTg4OWYtNzViN2ZlYWNlOThmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVFRocnNxelZqWkJmd2kwYkdneFwvT3k0ZkRKbE5CUHJHK2tVSW5KOVh0eG41RHN1NTBXVVV3RE9leVZvRUdPS1UifQ==
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

PiBGcm9tOiBUaWFuLCBLZXZpbg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMjUsIDIwMTggMTA6
MTYgQU0NCj4gDQpbLi4uXQ0KPiA+DQo+ID4gVGhlcmUgaXMgYW5vdGhlciB3YXk6IGFzIHdlJ3Jl
IHBsYW5uaW5nIHRvIGFkZCBhIGdlbmVyaWMgcGFzaWRfYWxsb2MoKQ0KPiA+IGZ1bmN0aW9uIHRv
IHRoZSBJT01NVSBBUEksIHRoZSBtZGV2IG1vZHVsZSBpdHNlbGYgY291bGQgYWxsb2NhdGUgYQ0K
PiA+IGRlZmF1bHQgUEFTSUQgZm9yIGVhY2ggbWRldiBieSBjYWxsaW5nIHBhc2lkX2FsbG9jKCkg
b24gdGhlIG1kZXYncw0KPiA+IHBhcmVudCwgYW5kIHRoZW4gZG8gbWFwKCkvdW5tYXAoKSB3aXRo
IHRoYXQgUEFTSUQuIFRoaXMgd2F5IHdlIGRvbid0DQo+ID4gaGF2ZSB0byBhZGQgSU9NTVUgb3Bz
IHRvIHRoZSBtZGV2IGJ1cywgZXZlcnl0aGluZyBjYW4gc3RpbGwgYmUgZG9uZQ0KPiA+IHVzaW5n
IHRoZSBvcHMgb2YgdGhlIHBhcmVudC4gQW5kIElPTU1VIGRyaXZlcnMgIm9ubHkiIGhhdmUgdG8N
Cj4gaW1wbGVtZW50DQo+ID4gUEFTSUQgb3BzLCB3aGljaCB3aWxsIGJlIHJldXNlZCBieSBkcml2
ZXJzIG90aGVyIHRoYW4gbWRldi4NCj4gDQo+IHllcywgUEFTSUQgaXMgbW9yZSBnZW5lcmFsIGFi
c3RyYWN0aW9uIHRoYW4gbWRldi4gSG93ZXZlciB0aGVyZSBpcw0KPiBvbmUgcHJvYmxlbS4gUGxl
YXNlIG5vdGUgd2l0aCBuZXcgc2NhbGFibGUgbW9kZSBub3cgUEFTSUQgaXMgbm90DQo+IHVzZWQg
anVzdCBmb3IgU1ZBLiBZb3UgY2FuIGRvIDFzdC1sZXZlbCwgMm5kLWxldmVsIGFuZCBuZXN0ZWQg
aW4gUEFTSUQNCj4gZ3JhbnVsYXJpdHksIG1lYW5pbmcgZWFjaCBQQVNJRCBjYW4gYmUgYm91bmQg
dG8gYW4gdW5pcXVlIGlvbW11DQo+IGRvbWFpbi4gSG93ZXZlciB0b2RheSBJT01NVSBkcml2ZXIg
YWxsb3dzIG9ubHkgb25lIGlvbW11X2RvbWFpbg0KPiBwZXIgZGV2aWNlLiBJZiB3ZSBzaW1wbHkg
aW5zdGFsbCBhbGxvY2F0ZWQgUEFTSUQgdG8gcGFyZW50IGRldmljZSwgd2UNCj4gc2hvdWxkIGFs
c28gcmVtb3ZlIHRoYXQgaW9tbXVfZG9tYWluIGxpbWl0YXRpb24uIElzIGl0IHRoZSB3YXkgdGhh
dA0KPiB3ZSB3YW50IHRvIHB1cnN1ZT8NCj4gDQo+IG1kZXYgYXZvaWRzIHN1Y2ggcHJvYmxlbSBh
cyBpdCBpbnRyb2R1Y2VzIGEgc2VwYXJhdGUgZGV2aWNlLi4uDQoNCmFub3RoZXIgdGhpbmcgdG8g
dGhpbmsgYWJvdXQgaXMgdG8gc2ltcGxpZnkgdGhlIGNhbGxlciBsb2dpYy4gSXQgd291bGQNCmJl
IGdvb2QgdG8gaGF2ZSBjb25zaXN0ZW50IElPTU1VIEFQSXMgY3Jvc3MgUENJIGRldmljZSBhbmQg
DQptZGV2LCBmb3IgY29tbW9uIFZGSU8gb3BlcmF0aW9ucyBlLmcuIG1hcC91bm1hcCwgaW9tbXVf
DQphdHRhY2hfZ3JvdXAsIGV0Yy4gSWYgd2UgbmVlZCBzcGVjaWFsIHZlcnNpb24gb3BzIHdpdGgg
UEFTSUQsIGl0IA0KYnJpbmdzIGJ1cmRlbiB0byBWRklPIGFuZCBvdGhlciBJT01NVSBjbGllbnRz
Li4uDQoNCkZvciBJT01NVS1jYXBhYmxlIG1kZXYsIHRoZXJlIGFyZSB0d28gdXNlIGNhc2VzIHdo
aWNoIGhhdmUgDQpiZWVuIHRhbGtlZCBzbyBmYXI6DQoNCjEpIG1kZXYgd2l0aCBQQVNJRC1ncmFu
dWxhciBETUEgaXNvbGF0aW9uDQoyKSBtZGV2IGluaGVyaXRpbmcgUklEIGZyb20gcGFyZW50IGRl
dmljZSAobm8gc2hhcmluZykNCg0KMSkgaXMgd2hhdCB0aGlzIFJGQyBpcyBjdXJyZW50bHkgZm9y
LiAyKSBpcyB3aGF0IEFsZXggY29uY2VybmVkIA0Kd2hpY2ggaXMgbm90IGNvdmVyZWQgaW4gUkZD
IHlldC4NCg0KSW4gbXkgbWluZCwgYW4gaWRlYWwgZGVzaWduIGlzIGxpa2UgYmVsb3c6DQoNCmEp
IFZGSU8gcHJvdmlkZXMgYW4gaW50ZXJmYWNlIGZvciBwYXJlbnQgZHJpdmVyIHRvIHNwZWNpZnkg
DQp3aGV0aGVyIGEgbWRldiBpcyBJT01NVSBjYXBhYmxlLCB3aXRoIGZsYWcgdG8gaW5kaWNhdGUg
DQp3aGV0aGVyIGl0J3MgUEFTSUQtZ3JhbnVsYXIgb3IgUklELWluaGVyaXQ7DQoNCmIpIE9uY2Ug
YW4gSU9NTVUtY2FwYWJsZSBtZGV2IGlzIGNyZWF0ZWQsIFZGSU8gdHJlYXRzIGl0IG5vDQpkaWZm
ZXJlbnQgZnJvbSBub3JtYWwgcGh5c2ljYWwgZGV2aWNlcywgdXNpbmcgZXhhY3RseSBzYW1lIA0K
SU9NTVUgQVBJcyB0byBvcGVyYXRlIChpbmNsdWRpbmcgZnV0dXJlIFNWQSkuIFZGSU8gZG9lc24n
dCANCmNhcmUgd2hldGhlciBQQVNJRCBvciBSSUQgd2lsbCBiZSB1c2VkIGluIGhhcmR3YXJlOw0K
DQpjKSBJT01NVSBkcml2ZXIgdGhlbiBoYW5kbGUgUklEL1BBU0lEIGRpZmZlcmVuY2UgaW50ZXJu
YWxseSwgDQpiYXNlZCBvbiBpdHMgb3duIGNvbmZpZ3VyYXRpb24gYW5kIG1kZXYgdHlwZS4NCg0K
VG8gc3VwcG9ydCBhYm92ZSBnb2FsLCBJIGZlZWwgYSBuZXcgZGV2aWNlIGhhbmRsZSBpcyBhIG5p
Y2UgZml0IA0KdG8gcmVwcmVzZW50IG1kZXYgd2l0aGluIElPTU1VIGRyaXZlciwgd2l0aCBzYW1l
IHNldCBvZiANCmNhcGFiaWxpdGllcyBhcyBvYnNlcnZlZCBvbiBpdHMgcGFyZW50IGRldmljZS4N
Cg0KSmVhbiwgbWF5YmUgSSBkaWRuJ3QgZnVsbHkgdW5kZXJzdGFuZCB5b3VyIHByb3Bvc2FsLiBD
YW4geW91DQplbGFib3JhdGUgd2hldGhlciBhYm92ZSBnb2FsIGNhbiBiZSBhY2hpZXZlZCB3aXRo
IGl0Pw0KDQpUaGFua3MNCktldmluDQo=
