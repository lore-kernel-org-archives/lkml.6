Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5547C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687D02083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687D02083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbeIGUC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:02:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:35122 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729753AbeIGUC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:02:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 08:21:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,342,1531810800"; 
   d="scan'208";a="71415900"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2018 08:21:35 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 7 Sep 2018 08:21:35 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 7 Sep 2018 08:21:34 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.226]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.205]) with mapi id 14.03.0319.002;
 Fri, 7 Sep 2018 23:21:33 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Jann Horn <jannh@google.com>
CC:     kernel list <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        =?utf-8?B?UmFkaW0gS3I/bcOhPw==?= <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>
Subject: RE: [PATCH v2 7/8] KVM: PMU: support to save/restore the guest lbr
 stack on vCPU switching
Thread-Topic: [PATCH v2 7/8] KVM: PMU: support to save/restore the guest lbr
 stack on vCPU switching
Thread-Index: AQHURdlXcNvymRY/BEuEPiCMVYNqzqTkXqIAgACQz9A=
Date:   Fri, 7 Sep 2018 15:21:32 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73978F779@shsmsx102.ccr.corp.intel.com>
References: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
 <1536233456-12173-8-git-send-email-wei.w.wang@intel.com>
 <CAG48ez1MX18nNgq1mih4dBmX5C_-0ZoCAayzhuzyaDvxYmJrdw@mail.gmail.com>
In-Reply-To: <CAG48ez1MX18nNgq1mih4dBmX5C_-0ZoCAayzhuzyaDvxYmJrdw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2UyNDUyYmQtZmEyMy00YmIwLWJkNTktNjQwZWQzOGQzMWZkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSG9BQ1BLNVVHV1pmYkk2aHJ3NFZrZDdsSEJSeWRvRm1Cd2V4YmVzXC9aK2VVNDZ6YWc3cUV0K1M3TXNWOERyaGsifQ==
x-ctpclassification: CTP_NT
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

T24gRnJpZGF5LCBTZXB0ZW1iZXIgNywgMjAxOCAxMDozNyBQTSwgSmFubiBIb3JuIHdyb3RlOg0K
PiBPbiBGcmksIFNlcCA3LCAyMDE4IGF0IDQ6MjggUE0gV2VpIFdhbmcgPHdlaS53LndhbmdAaW50
ZWwuY29tPiB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCB0byBLVk0gdG8gc2F2
ZS9yZXN0b3JlIHRoZSBsYnIgc3RhY2sgb24gdkNQVQ0KPiA+IGNvbnRleHQgc3dpdGNoaW5nLg0K
PiA+DQo+ID4gV2hlbiB0aGUgZ3Vlc3Qgc2V0cyB0aGUgQUNUSVZFIGJpdCBvZiBNU1JfS1ZNX1BW
X0xCUl9DVFJMLCBhIHBlcmYNCj4gPiBldmVudCBpcyBjcmVhdGVkIG9uIHRoZSBob3N0IGZvciB0
aGUgcmVsYXRlZCB2Q1BVLiBUaGlzIHBlcmYgZXZlbnQNCj4gPiBlbnN1cmVzIHRoZSBMQlIgc3Rh
Y2sgdG8gYmUgc2F2ZWQvcmVzdG9yZWQgd2hlbiB0aGUgdkNQVSB0aHJlYWQgaXMNCj4gc2NoZWR1
bGVkIG91dC9pbi4NCj4gPiBUaGUgcGVyZiBldmVudCBpcyByZW1vdmVkIGFuZCBmcmVlZCB3aGVu
IHRoZSBndWVzdCBjbGVhcnMgdGhlIEFDVElWRQ0KPiA+IGJpdC4NCj4gWy4uLl0NCj4gPiArdm9p
ZCBndWVzdF9sYnJfZXZlbnRfcmVsZWFzZShzdHJ1Y3Qga3ZtX3BtdSAqcG11KSB7DQo+ID4gKyAg
ICAgICBzdHJ1Y3QgcGVyZl9ldmVudCAqZXZlbnQgPSBwbXUtPmd1ZXN0X2xicl9ldmVudDsNCj4g
PiArDQo+ID4gKyAgICAgICBpZiAodW5saWtlbHkoIXBtdS0+Z3Vlc3RfbGJyX2V2ZW50KSkgew0K
PiA+ICsgICAgICAgICAgICAgICBwcl9lcnIoIiVzOiBndWVzdF9sYnJfZXZlbnQgYWxyZWFkeSBm
cmVlZFxuIiwgX19mdW5jX18pOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+ID4gKyAg
ICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKGV2ZW50KSB7DQo+ID4gKyAgICAgICAgICAg
ICAgIGV2ZW50LT5wbXUtPnN0b3AoZXZlbnQsIFBFUkZfRUZfVVBEQVRFKTsNCj4gPiArICAgICAg
ICAgICAgICAgcGVyZl9ldmVudF9yZWxlYXNlX2tlcm5lbChldmVudCk7DQo+ID4gKyAgICAgICB9
DQo+ID4gKyAgICAgICBwbXUtPmd1ZXN0X2xicl9ldmVudCA9IE5VTEw7DQo+ID4gK30NCj4gDQo+
IElzIHRoZXJlIHNvbWUgZ3VhcmFudGVlIHRoYXQgdGhpcyBtZXRob2Qgd2lsbCBiZSBjYWxsZWQg
d2hlbiB0aGUgdkNQVSBpcw0KPiB0b3JuIGRvd24gb24gZ3Vlc3QgZXhpdD8NCg0KVGhhbmtzIGZv
ciByZW1pbmRpbmcgdXMgdGhpcyBjb3JuZXIgY2FzZS4gV2UgZGlkbuKAmXQgY29uc2lkZXIgdGhh
dCBpbiB0aGlzIHZlcnNpb24uIEkgdGhpbmsgd2UgY291bGQgYWRkIGd1ZXN0X2xicl9ldmVudF9y
ZWxlYXNlKCkgdG8ga3ZtX2FyY2hfdmNwdV9kZXN0cm95KCkNCg0KQmVzdCwNCldlaQ0KDQoNCg==
