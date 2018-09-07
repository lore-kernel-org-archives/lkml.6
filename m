Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829B9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479062075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479062075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeIGXuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:50:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:42962 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbeIGXuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:50:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 12:08:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,343,1531810800"; 
   d="scan'208";a="231098312"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga004.jf.intel.com with ESMTP; 07 Sep 2018 12:08:28 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.8]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.80]) with mapi id 14.03.0319.002;
 Fri, 7 Sep 2018 12:08:27 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Bhupesh Sharma <bhsharma@redhat.com>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Peter Zijlstra" <peterz@infradead.org>
Subject: RE: [PATCH V4 3/3] x86/efi: Introduce EFI_PAGE_FAULT_HANDLER
Thread-Topic: [PATCH V4 3/3] x86/efi: Introduce EFI_PAGE_FAULT_HANDLER
Thread-Index: AQHURjlkrx/qzR68D063Dk4PQNG656TlIuuA///95NCAAH8gAP//jr8A
Date:   Fri, 7 Sep 2018 19:08:27 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485BA620@ORSMSX114.amr.corp.intel.com>
References: <1536276468-28499-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1536276468-28499-4-git-send-email-sai.praneeth.prakhya@intel.com>
 <20180907112207.GS24106@hirez.programming.kicks-ass.net>
 <FFF73D592F13FD46B8700F0A279B802F485BA5C1@ORSMSX114.amr.corp.intel.com>
 <e10acaa8-f5d8-85f3-219c-86fafd793a87@redhat.com>
In-Reply-To: <e10acaa8-f5d8-85f3-219c-86fafd793a87@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODRhMDcwYzctOTYyOC00Nzk3LWJkZDEtMzY5M2MwZGM4NjBiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicjJrRHVtUTJIcVE1bmQxSHIrVkpzd2U4SWYrME1YV1BYZlJIaWFvY3RUbnFNMWN5SWJ1YjFGTkVSbE4yMHM5KyJ9
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

PiA+ID4gV2h5IG1ha2UgdGhpcyBvcHRpb25hbD8NCj4gPg0KPiA+IEkgbWFkZSBpdCBhcyBhIGNv
bmZpZyBvcHRpb24gaW4gUkZDIGJlY2F1c2UgdGhlIHBhZ2UgZmF1bHQgaGFuZGxlciB3YXMNCj4g
PiBjb21wbGljYXRlZCBhbmQgdG91Y2hpbmcgbWFueSBwYXJ0cyAoaXQgaGFkIGxvdHMgb2YgY29k
ZSBjaGFuZ2UgYW5kIEkNCj4gPiBkaWRuJ3Qgd2FudCB0byBicmVhayBhbnkgZXhpc3RpbmcgZnVu
Y3Rpb25hbGl0eSkuIE5vdyB0aGF0IGl0J3MNCj4gPiBzaW1wbGUsIEkgZG9uJ3QgdGhpbmsgd2Ug
bmVlZCB0aGUgY29uZmlnIG9wdGlvbi4NCj4gPg0KPiA+IFdpdGhvdXQgZWZpIHBhZ2UgZmF1bHQg
aGFuZGxlciwgYW55IHBhZ2UgZmF1bHQgY2F1c2VkIGJ5IGZpcm13YXJlDQo+ID4gc2hvdWxkIHBh
bmljIGtlcm5lbCBidXQgd2l0aCB0aGlzIHBhdGNoIEkgdGhpbmsgd2UgYXJlIGp1c3QgaW1wcm92
aW5nIGV4aXN0aW5nDQo+IGNvbmRpdGlvbiAoaWRlYWxseSkuDQo+ID4NCj4gPiBTbywgaWYgVGhv
bWFzLCBJbmdvLCBBbmR5LCBBcmQgYW5kIEJvcmlzIGFyZSBvay4uIEkgd2lsbCBtYWtlIGl0IGFz
DQo+ID4gZGVmYXVsdCAoaS5lLiB3aXRob3V0IGNvbmZpZykuDQo+ID4NCj4gPiBSZWdhcmRzLA0K
PiA+IFNhaQ0KPiA+DQo+IEFsc28sIHNvbWUgZGlzdHJpYnV0aW9ucyBhbHJlYWR5IGhhdmUgc3Bl
Y2lmaWMgd2F5cyB0byBoYW5kbGUgYnVnZ3kgZmlybXdhcmVzDQo+IHdoaWNoIGNhbiBiZSBhdCB0
aW1lcyBkZXBlbmRlbnQgb24gdGhlIHVuZGVybHlpbmcgaGFyZHdhcmUgYW5kIHRoZSBmaXJtd2Fy
ZQ0KPiB2ZXJzaW9ucy4NCj4gDQo+IEkgd291bGQgc3VnZ2VzdCB0aGF0IHdlIGVuYWJsZSB0aGlz
IHVuZGVyIGEgQ09ORklHIGZvciB0aGUgZmlyc3Qgcm91bmQgYW5kIG9uY2UNCj4gaXQgaXMgdGVz
dGVkIHdpdGggd2lkZXIgdmFyaWV0eSBvZiB4ODYgbWFjaGluZXMgd2hpY2ggaGF2ZSBidWdneSBv
ciBvcnBoYW5lZA0KPiBmaXJtd2FyZSBhbmQgbGludXggKGFuZCByZWJvb3QpIHdvcmtzIGZpbmUg
d2l0aCB0aGVtLCB3ZSBjYW4gZHJvcCB0aGUgQ09ORklHDQo+IG9wdGlvbiBpbiBmdXR1cmUgYW5k
IGVuYWJsZSB0aGlzIGJ5IGRlZmF1bHQuDQoNClNvdW5kcyBmYWlyIHRvIG1lLCBidXQsIEkgd291
bGQgbGlrZSB0byB3YWl0IGZvciBzb21lb25lIGV4cGVyaWVuY2VkIHRvIG1ha2UgdGhlIGZpbmFs
IGNhbGwuDQoNClJlZ2FyZHMsDQpTYWkNCg==
