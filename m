Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3705C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A93208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A93208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeHVVN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:13:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:19684 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbeHVVN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:13:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2018 10:48:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,274,1531810800"; 
   d="scan'208";a="251075591"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga005.jf.intel.com with ESMTP; 22 Aug 2018 10:48:04 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 22 Aug 2018 10:48:03 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.245]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.106]) with mapi id 14.03.0319.002;
 Wed, 22 Aug 2018 10:48:03 -0700
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Jann Horn <jannh@google.com>
CC:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: RE: [PATCH v3 3/5] LSM: Security module checking for side-channel
 dangers
Thread-Topic: [PATCH v3 3/5] LSM: Security module checking for side-channel
 dangers
Thread-Index: AQHUOOKX5VPJ9yk/5U6pLmxaRABENqTK6xAA///w3HCAAI7tAIAAiPkQgACD7YD//5AmwA==
Date:   Wed, 22 Aug 2018 17:48:02 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC673214407ED@ORSMSX107.amr.corp.intel.com>
References: <20180821000444.7004-1-casey.schaufler@intel.com>
 <20180821000444.7004-4-casey.schaufler@intel.com>
 <CAG48ez1D-DPBP8ACA1W5=XZLNKUeVj7ZOGUG8uJ2nL1xOSR_9Q@mail.gmail.com>
 <99FC4B6EFCEFD44486C35F4C281DC673214402D3@ORSMSX107.amr.corp.intel.com>
 <CAG48ez3bh5cFgZ5ZY63pszTV+KX+KC4utRCm7E8en+uF5w6vKw@mail.gmail.com>
 <99FC4B6EFCEFD44486C35F4C281DC67321440770@ORSMSX107.amr.corp.intel.com>
 <CAG48ez3OkpcrC34LJTWAvH4ZvREW7jDVkeMBZrLQe6cRSEBheg@mail.gmail.com>
In-Reply-To: <CAG48ez3OkpcrC34LJTWAvH4ZvREW7jDVkeMBZrLQe6cRSEBheg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTc4YjVmYWMtNjAzYS00MWU2LWE4MzMtMTY0NjFjNTMwMTY2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibHNyQzJnVUtlV2FUaTlnU1NydmxZRGJBeUVKZEMrMkFabVhMS215ank2aVQ3bUJpblJsRzBKT1BmdGFWczQ4UyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW5uIEhvcm4gW21haWx0bzpq
YW5uaEBnb29nbGUuY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAyMiwgMjAxOCAxMDow
NCBBTQ0KPiBUbzogU2NoYXVmbGVyLCBDYXNleSA8Y2FzZXkuc2NoYXVmbGVyQGludGVsLmNvbT4N
Cj4gQ2M6IEtlcm5lbCBIYXJkZW5pbmcgPGtlcm5lbC1oYXJkZW5pbmdAbGlzdHMub3BlbndhbGwu
Y29tPjsga2VybmVsIGxpc3QNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51
eC1zZWN1cml0eS1tb2R1bGUgPGxpbnV4LXNlY3VyaXR5LQ0KPiBtb2R1bGVAdmdlci5rZXJuZWwu
b3JnPjsgc2VsaW51eEB0eWNoby5uc2EuZ292OyBIYW5zZW4sIERhdmUNCj4gPGRhdmUuaGFuc2Vu
QGludGVsLmNvbT47IERvY2ssIERlbmVlbiBUIDxkZW5lZW4udC5kb2NrQGludGVsLmNvbT47DQo+
IGtyaXN0ZW5AbGludXguaW50ZWwuY29tOyBBcmphbiB2YW4gZGUgVmVuIDxhcmphbkBsaW51eC5p
bnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMy81XSBMU006IFNlY3VyaXR5IG1v
ZHVsZSBjaGVja2luZyBmb3Igc2lkZS1jaGFubmVsDQo+IGRhbmdlcnMNCj4gDQo+IFtTTklQXQ0K
DQo+ID4gWWVzLCBidXQgaW4gYSBkaWZmZXJlbnQgbmFtZXNwYWNlLiBIZW5jZSB0aGUgbmFtZXNw
YWNlIGNoZWNrLg0KPiA+DQo+ID4gV2hhdCBJIGhlYXIgeW91IHNheWluZyBpcyB0aGF0IHlvdSBk
b24ndCB3YW50IHRoZSBjYXBhYmlsaXR5IGNoZWNrDQo+ID4gdG8gYmUgaW5kZXBlbmRlbnQgb2Yg
dGhlIG5hbWVzcGFjZSBjaGVjay4NCj4gDQo+IFRoZSBjYXBhYmlsaXR5IGNoZWNrIGRvZXNuJ3Qg
YWx3YXlzIHJlcXVpcmUgYSBuYW1lc3BhY2UgbWF0Y2gsIGFuZCBJDQo+IGRvbid0IGNhcmUgYWJv
dXQgbm9uLXVzZXIgbmFtZXNwYWNlcyBoZXJlLCBidXQgSSB3b3VsZCBwcmVmZXIgaXQgaWYNCj4g
QS0+QiB3aXRoIEEgaGF2aW5nIHNvbWUgY2FwYWJpbGl0aWVzIHJlcXVpcmVkIEEncyB1c2VyIG5h
bWVzcGFjZSB0byBiZQ0KPiBhbmNlc3Rvci1vci1zZWxmIG9mIEIncyB1c2VyIG5hbWVzcGFjZS4g
QnV0IGFsdGVybmF0aXZlbHk6DQoNCkxvb2tpbmcgYXQgYW5jZXN0b3IgcmVsYXRpb25zIHN0YXJ0
cyB0byBnZXQgdXMgcHJldHR5IGNsb3NlIHRvIHRoZQ0KcG9pbnQgd2hlcmUgdGhlIGNvc3Qgb2Yg
Y2hlY2tpbmcgd2lsbCBvdmVyd2hlbG0gdGhlIHNhdmluZ3MuIFRoaXMNCmlzIHNvbWV0aGluZyB3
ZSBoYXZlIHRvIGJlIHZlcnkgY2FyZWZ1bCBvZi4NCg0KPiA+IFRoaXMgY29uZmxpY3RzIHdpdGgg
dGhlDQo+ID4gc3Ryb25nIGRlc2lyZSBleHByZXNzZWQgdG8gbWUgd2hlbiBJIHN0YXJ0ZWQgdGhp
cyB0aGF0IHRoZSBjb25maWd1cmF0aW9uDQo+ID4gc2hvdWxkIGJlIGZsZXhpYmxlLiBJIGNhbiBi
ZWVmIHVwIHRoZSBkZXNjcmlwdGlvbiBvZiB0aGUgdmFyaW91cyBvcHRpb25zLg0KPiA+IFdvdWxk
IHRoYXQgYWRkcmVzcyB0aGUgaXNzdWU/DQo+IA0KPiBJdCBzZWVtcyB0byBtZSB0aGF0IGl0IHdv
dWxkIG1ha2Ugc2Vuc2UgdG8gZXhwcmVzcyB0aGlzIGFzIHNvbWV0aGluZw0KPiBsaWtlIGEgS2Nv
bmZpZyBkZXBlbmRlbmN5Lg0KDQpJIHRob3VnaHQgYWJvdXQgdGhhdC4gSXQgY291bGQgYmUgdGhl
IGJlc3QgY2hvaWNlLiBJIHdpbGwgaW52ZXN0aWdhdGUNCmZ1cnRoZXIuDQoNCj4gQnV0IEkgZ3Vl
c3MgaWYgeW91IGRvY3VtZW50IHRoYXQgdGhlDQo+IGNvbWJpbmF0aW9uIG9mIENPTkZJR19VU0VS
X05TPXksDQo+IENPTkZJR19TRUNVUklUWV9TSURFQ0hBTk5FTF9OQU1FU1BBQ0VTPW4gYW5kDQo+
IFNFQ1VSSVRZX1NJREVDSEFOTkVMX0NBUEFCSUxJVElFUz15IGlzIG5vbnNlbnNpY2FsLCB0aGF0
IHdvcmtzIHRvby4gSQ0KPiBqdXN0IGRvbid0IHNlZSB3aHkgeW91J2Qgd2FudCB0byBwcm92aWRl
IHN1Y2ggYSBmb290Z3VuPw0KDQpQb2ludC4NCg0KPiBDb25maWd1cmFiaWxpdHkgaXMgbmljZSwg
YnV0IGlmIHdlIGtub3cgdGhhdCBvbmUgb2YgdGhlIHBvc3NpYmxlDQo+IGNvbmZpZ3VyYXRpb25z
IGRvZXNuJ3QgbWFrZSBzZW5zZSwgaXQgc2VlbXMgbGlrZSBhIGdvb2QgaWRlYSB0byBqdXN0DQo+
IG5vdCBhbGxvdyB0aGUgc3lzdGVtIHRvIGJlIGNvbmZpZ3VyZWQgdGhhdCB3YXkuDQoNCkFub3Ro
ZXIgcG9pbnQuDQoNCj4gWW91IHNheSB0aGF0IHlvdSB3ZXJlIGFza2VkIHRvIG1ha2UgdGhlIGNv
bmZpZ3VyYXRpb24gZmxleGlibGUuIERpZA0KPiB3aG9ldmVyIHRvbGQgeW91IHRoYXQgYWN0dWFs
bHkgd2FudCB0aGUgYWJpbGl0eSB0byBjb21wYXJlIHJhdw0KPiBjYXBhYmlsaXR5IHNldHMgb24g
YSBzeXN0ZW0gd2l0aCBDT05GSUdfVVNFUl9OUz15LCBhbmQgdW5kZXJzdGFuZCB3aGF0DQo+IHNl
bWFudGljcyB0aGF0IGhhcyAoYW5kIGRvZXNuJ3QgaGF2ZSk/IE9yIHdhcyB0aGVpciBpbnRlbnQg
bW9yZSBhbG9uZw0KPiB0aGUgbGluZXMgb2YgIndlIHdhbnQgdG8gZmx1c2ggaWYgdGhlIG5ldyB0
YXNrIGhhcyBoaWdoZXIgcHJpdmlsZWdlcywNCj4gY2FwYWJpbGl0eS13aXNlLCB0aGFuIHRoZSBv
bGQgdGFzazsgYnV0IHdlIGRvbid0IGV4cGxpY2l0bHkgY2FyZSBhYm91dA0KPiBuYW1lc3BhY2Vz
Ij8NCg0KV2l0aG91dCBnb2luZyBpbnRvIHRvbyBtdWNoIGRldGFpbCwgaXQncyBhIG1hdHRlciBv
ZiBwZW9wbGUgd2hvDQp1bmRlcnN0YW5kIGNoaXBzIGFuZCBwZXJmb3JtYW5jZSBiZXR0ZXIgdGhh
biB0aGV5IHVuZGVyc3RhbmQNCnNlY3VyaXR5IG9yIHRoZSB1c2VyIGV4cGVyaWVuY2UuDQoNCg==
