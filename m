Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9733C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D7C20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D7C20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388508AbeGYD02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:26:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:8185 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbeGYD01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:26:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 19:16:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,400,1526367600"; 
   d="scan'208";a="75233304"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jul 2018 19:16:03 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 24 Jul 2018 19:16:02 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.100]) with mapi id 14.03.0319.002;
 Wed, 25 Jul 2018 10:16:01 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
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
Thread-Index: AQHUIYLU0u0k0vB4lUGhJp9aIAl9hqSbto0AgAFqm4CAAJkvgIABd3Xw
Date:   Wed, 25 Jul 2018 02:16:00 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19127FB94@SHSMSX101.ccr.corp.intel.com>
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

PiBGcm9tOiBKZWFuLVBoaWxpcHBlIEJydWNrZXINCj4gU2VudDogVHVlc2RheSwgSnVseSAyNCwg
MjAxOCA3OjMxIFBNDQo+IA0KPiBIaSBCYW9sdSwNCj4gDQo+IE9uIDI0LzA3LzE4IDAzOjIyLCBM
dSBCYW9sdSB3cm90ZToNCj4gPiBIaSwNCj4gPg0KPiA+IE9uIDA3LzIzLzIwMTggMTI6NDQgUE0s
IExpdSwgWWkgTCB3cm90ZToNCj4gPj4+IEZyb206IEx1IEJhb2x1IFttYWlsdG86YmFvbHUubHVA
bGludXguaW50ZWwuY29tXQ0KPiA+Pj4gU2VudDogU3VuZGF5LCBKdWx5IDIyLCAyMDE4IDI6MDkg
UE0NCj4gPj4+DQo+ID4+PiBXaXRoIHRoZSBJbnRlbCBJT01NVSBzdXBwb3J0aW5nIFBBU0lEIGdy
YW51bGFyaXR5IGlzb2xhdGlvbiBhbmQNCj4gcHJvdGVjdGlvbiwgYQ0KPiA+Pj4gbWVkaWF0ZWQg
ZGV2aWNlIGNvdWxkIGJlIGlzb2xhdGVkIGFuZCBwcm90ZWN0ZWQgYnkgYW4gSU9NTVUgdW5pdC4N
Cj4gV2UgbmVlZCB0bw0KPiA+Pj4gYWxsb2NhdGUgYSBuZXcgZ3JvdXAgaW5zdGVhZCBvZiBhIFBD
SSBncm91cC4NCj4gPj4gRXhpc3RpbmcgdmZpbyBtZGV2IGZyYW1ld29yayBhbHNvIGFsbG9jYXRl
cyBhbiBpb21tdSBncm91cCBmb3INCj4gbWVkaWF0ZSBkZXZpY2UuDQo+ID4+DQo+ID4+IG1kZXZf
cHJvYmUoKQ0KPiA+PiAgIHxfIG1kZXZfYXR0YWNoX2lvbW11KCkNCj4gPj4gICAgICAgIHxfIGlv
bW11X2dyb3VwX2FsbG9jKCkNCj4gPg0KPiA+IFdoZW4gZXh0ZXJuYWwgY29tcG9uZW50cyBhc2sg
aW9tbXUgdG8gYWxsb2NhdGUgYSBncm91cCBmb3IgYSBkZXZpY2UsDQo+ID4gaXQgd2lsbCBjYWxs
IHBjaV9kZXZpY2VfZ3JvdXAgaW4gSW50ZWwgSU9NTVUgZHJpdmVyJ3MgQGRldmljZV9ncm91cA0K
PiA+IGNhbGxiYWNrLiBJbiBhbm90aGVyIHdvcmQsIGN1cnJlbnQgSW50ZWwgSU9NTVUgZHJpdmVy
IGRvZXNuJ3QgYXdhcmUNCj4gPiB0aGUgbWVkaWF0ZWQgZGV2aWNlIGFuZCB0cmVhdCBhbGwgZGV2
aWNlcyBhcyBQQ0kgb25lcy4gVGhpcyBwYXRjaA0KPiA+IGV4dGVuZHMgdGhlIEBkZXZpY2VfZ3Jv
dXAgY2FsbCBiYWNrIHRvIG1ha2UgaXQgYXdhcmUgb2YgYSBtZWRpYXRlZA0KPiA+IGRldmljZS4N
Cj4gDQo+IEkgYWdyZWUgdGhhdCBhbGxvY2F0aW5nIHR3byBncm91cHMgZm9yIGFuIG1kZXYgc2Vl
bXMgc3RyYW5nZSwgYW5kIGluIG15DQo+IG9waW5pb24gd2Ugc2hvdWxkbid0IGV4cG9ydCB0aGUg
bm90aW9uIG9mIG1kZXYgdG8gSU9NTVUgZHJpdmVycy4NCj4gT3RoZXJ3aXNlIGVhY2ggZHJpdmVy
IHdpbGwgaGF2ZSB0byBhZGQgaXRzIG93biAiZGV2X2lzX21kZXYoKSIgc3BlY2lhbA0KPiBjYXNl
cywgd2hpY2ggd2lsbCBnZXQgbWVzc3kgaW4gdGhlIGxvbmcgcnVuLiBCZXNpZGVzLCB0aGUgbWFj
cm8gaXMNCj4gY3VycmVudGx5IHByaXZhdGUsIGFuZCB0byBiZSBleHBvcnRlZCBpdCBzaG91bGQg
YmUgd3JhcHBlZCBpbg0KPiBzeW1ib2xfZ2V0L3B1dChtZGV2X2J1c190eXBlKS4NCg0KVGhlcmUg
aXMgb25seSBvbmUgZ3JvdXAgcGVyIG1kZXYsIGJ1dCBJIGFncmVlIHRoYXQgYXZvaWRpbmcgbWRl
dg0KYXdhcmVuZXNzIGluIElPTU1VIGRyaXZlciBpcyBkZWZpbml0ZWx5IGdvb2QuLi4gV2UgZGlk
bid0IGZpbmQgYQ0KZ29vZCB3YXkgYmVmb3JlLCB3aGljaCBpcyB3aHkgY3VycmVudCBSRkMgd2Fz
IGltcGxlbWVudGVkIHRoYXQgDQp3YXkuDQoNCj4gDQo+IFRoZXJlIGlzIGFub3RoZXIgd2F5OiBh
cyB3ZSdyZSBwbGFubmluZyB0byBhZGQgYSBnZW5lcmljIHBhc2lkX2FsbG9jKCkNCj4gZnVuY3Rp
b24gdG8gdGhlIElPTU1VIEFQSSwgdGhlIG1kZXYgbW9kdWxlIGl0c2VsZiBjb3VsZCBhbGxvY2F0
ZSBhDQo+IGRlZmF1bHQgUEFTSUQgZm9yIGVhY2ggbWRldiBieSBjYWxsaW5nIHBhc2lkX2FsbG9j
KCkgb24gdGhlIG1kZXYncw0KPiBwYXJlbnQsIGFuZCB0aGVuIGRvIG1hcCgpL3VubWFwKCkgd2l0
aCB0aGF0IFBBU0lELiBUaGlzIHdheSB3ZSBkb24ndA0KPiBoYXZlIHRvIGFkZCBJT01NVSBvcHMg
dG8gdGhlIG1kZXYgYnVzLCBldmVyeXRoaW5nIGNhbiBzdGlsbCBiZSBkb25lDQo+IHVzaW5nIHRo
ZSBvcHMgb2YgdGhlIHBhcmVudC4gQW5kIElPTU1VIGRyaXZlcnMgIm9ubHkiIGhhdmUgdG8gaW1w
bGVtZW50DQo+IFBBU0lEIG9wcywgd2hpY2ggd2lsbCBiZSByZXVzZWQgYnkgZHJpdmVycyBvdGhl
ciB0aGFuIG1kZXYuDQoNCnllcywgUEFTSUQgaXMgbW9yZSBnZW5lcmFsIGFic3RyYWN0aW9uIHRo
YW4gbWRldi4gSG93ZXZlciB0aGVyZSBpcw0Kb25lIHByb2JsZW0uIFBsZWFzZSBub3RlIHdpdGgg
bmV3IHNjYWxhYmxlIG1vZGUgbm93IFBBU0lEIGlzIG5vdA0KdXNlZCBqdXN0IGZvciBTVkEuIFlv
dSBjYW4gZG8gMXN0LWxldmVsLCAybmQtbGV2ZWwgYW5kIG5lc3RlZCBpbiBQQVNJRA0KZ3JhbnVs
YXJpdHksIG1lYW5pbmcgZWFjaCBQQVNJRCBjYW4gYmUgYm91bmQgdG8gYW4gdW5pcXVlIGlvbW11
DQpkb21haW4uIEhvd2V2ZXIgdG9kYXkgSU9NTVUgZHJpdmVyIGFsbG93cyBvbmx5IG9uZSBpb21t
dV9kb21haW4gDQpwZXIgZGV2aWNlLiBJZiB3ZSBzaW1wbHkgaW5zdGFsbCBhbGxvY2F0ZWQgUEFT
SUQgdG8gcGFyZW50IGRldmljZSwgd2UgDQpzaG91bGQgYWxzbyByZW1vdmUgdGhhdCBpb21tdV9k
b21haW4gbGltaXRhdGlvbi4gSXMgaXQgdGhlIHdheSB0aGF0DQp3ZSB3YW50IHRvIHB1cnN1ZT8N
Cg0KbWRldiBhdm9pZHMgc3VjaCBwcm9ibGVtIGFzIGl0IGludHJvZHVjZXMgYSBzZXBhcmF0ZSBk
ZXZpY2UuLi4NCg0KPiANCj4gVGhlIGFsbG9jYXRlZCBQQVNJRCBhbHNvIG5lZWRzIHRvIGJlIGlu
c3RhbGxlZCBpbnRvIHRoZSBwYXJlbnQgZGV2aWNlLg0KPiBJZiB0aGUgbWRldiBtb2R1bGUga25v
d3MgdGhlIFBBU0lELCB3ZSBjYW4gZG8gdGhhdCBieSBhZGRpbmcNCj4gc2V0X3Bhc2lkKG1kZXYs
IHBhc2lkKSBhbmQgY2xlYXJfcGFzaWQobWRldiwgcGFzaWQpIG9wZXJhdGlvbnMgdG8NCj4gbWRl
dl9wYXJlbnRfb3BzLg0KPiANCg0KVGhhbmtzDQpLZXZpbg0K
