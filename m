Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2701C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47082190C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391930AbfBOJAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:00:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:53675 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbfBOJAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:00:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 01:00:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,372,1544515200"; 
   d="scan'208";a="319261848"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga006.fm.intel.com with ESMTP; 15 Feb 2019 01:00:05 -0800
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 15 Feb 2019 01:00:04 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 15 Feb 2019 01:00:03 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.207]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.172]) with mapi id 14.03.0415.000;
 Fri, 15 Feb 2019 17:00:01 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     'Like Xu' <like.xu@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "Liang, Kan" <kan.liang@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>,
        "jannh@google.com" <jannh@google.com>,
        "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
        "jmattson@google.com" <jmattson@google.com>
Subject: RE: [PATCH v5 10/12] KVM/x86/lbr: lazy save the guest lbr stack
Thread-Topic: [PATCH v5 10/12] KVM/x86/lbr: lazy save the guest lbr stack
Thread-Index: AQHUxEm+u4LNnDlAjkSk6RajZ9qMLKXfkrqAgADETHA=
Date:   Fri, 15 Feb 2019 09:00:00 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73DF71F0B@shsmsx102.ccr.corp.intel.com>
References: <1550135174-5423-1-git-send-email-wei.w.wang@intel.com>
 <1550135174-5423-11-git-send-email-wei.w.wang@intel.com>
 <fbf4e2ad-93f9-bb19-81f4-3b9d0b99cca8@linux.intel.com>
In-Reply-To: <fbf4e2ad-93f9-bb19-81f4-3b9d0b99cca8@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGNmNmVlOTktZDViMC00YmZmLWE2ZTQtZDZkNzNhNGUwYzQ0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZWtJS2w2b1o0cDg0ckFcL0NCYTZ2b3E1eU5WemNHOTlGZGdEWXU0NFA2TWwxWHhpcWdcL2lJRHI0enIzbDJNV0tGIn0=
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

T24gRnJpZGF5LCBGZWJydWFyeSAxNSwgMjAxOSA5OjUwIEFNLCBMaWtlIFh1IHdyb3RlOg0KPiBU
bzogV2FuZywgV2VpIFcgPHdlaS53LndhbmdAaW50ZWwuY29tPjsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsNCj4ga3ZtQHZnZXIua2VybmVsLm9yZzsgcGJvbnppbmlAcmVkaGF0LmNvbTsg
YWtAbGludXguaW50ZWwuY29tOw0KPiBwZXRlcnpAaW5mcmFkZWFkLm9yZw0KPiBDYzogTGlhbmcs
IEthbiA8a2FuLmxpYW5nQGludGVsLmNvbT47IG1pbmdvQHJlZGhhdC5jb207DQo+IHJrcmNtYXJA
cmVkaGF0LmNvbTsgWHUsIExpa2UgPGxpa2UueHVAaW50ZWwuY29tPjsgamFubmhAZ29vZ2xlLmNv
bTsNCj4gYXJlaS5nb25nbGVpQGh1YXdlaS5jb207IGptYXR0c29uQGdvb2dsZS5jb20NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2NSAxMC8xMl0gS1ZNL3g4Ni9sYnI6IGxhenkgc2F2ZSB0aGUgZ3Vl
c3QgbGJyIHN0YWNrDQo+IA0KPiBPbiAyMDE5LzIvMTQgMTc6MDYsIFdlaSBXYW5nIHdyb3RlOg0K
PiA+IFdoZW4gdGhlIHZDUFUgaXMgc2NoZWR1bGVkIGluOg0KPiA+IC0gaWYgdGhlIGxiciBmZWF0
dXJlIHdhcyB1c2VkIGluIHRoZSBsYXN0IHZDUFUgdGltZSBzbGljZSwgc2V0IHRoZSBsYnINCj4g
PiAgICBzdGFjayB0byBiZSBpbnRlcmNlcHRpYmxlLCBzbyB0aGF0IHRoZSBob3N0IGNhbiBjYXB0
dXJlIHdoZXRoZXIgdGhlDQo+ID4gICAgbGJyIGZlYXR1cmUgd2lsbCBiZSB1c2VkIGluIHRoaXMg
dGltZSBzbGljZTsNCj4gPiAtIGlmIHRoZSBsYnIgZmVhdHVyZSB3YXNuJ3QgdXNlZCBpbiB0aGUg
bGFzdCB2Q1BVIHRpbWUgc2xpY2UsIGRpc2FibGUNCj4gPiAgICB0aGUgdkNQVSBzdXBwb3J0IG9m
IHRoZSBndWVzdCBsYnIgc3dpdGNoaW5nLg0KPiA+DQo+ID4gVXBvbiB0aGUgZmlyc3QgYWNjZXNz
IHRvIG9uZSBvZiB0aGUgbGJyIHJlbGF0ZWQgTVNScyAoc2luY2UgdGhlIHZDUFUNCj4gPiB3YXMg
c2NoZWR1bGVkIGluKToNCj4gPiAtIHJlY29yZCB0aGF0IHRoZSBndWVzdCBoYXMgdXNlZCB0aGUg
bGJyOw0KPiA+IC0gY3JlYXRlIGEgaG9zdCBwZXJmIGV2ZW50IHRvIGhlbHAgc2F2ZS9yZXN0b3Jl
IHRoZSBndWVzdCBsYnIgc3RhY2s7DQo+IA0KPiBCYXNlZCBvbiBjb21taXQgIjE1YWQ3MTQ2MCIg
YW5kIGd1ZXN0LXVzZS1sYnItb25seSB1c2FnZSwgaXMgdGhpcyBwb3NzaWJsZQ0KPiB0byBjcmVh
dGUgbm9uZSBvZiBob3N0IHBlcmYgZXZlbnQgZm9yIHZjcHUgYW5kIHNpbXBseSByZXVzZQ0KPiBf
X2ludGVsX3BtdV9sYnJfc2F2ZS9yZXN0b3JlIGluIGludGVsX3BtdV9zY2hlZF9vdXQvaW4gYW5k
IGtlZXAgdGhlDQo+IGxicl9zdGFjayBzeW5jIHdpdGgga3ZtX3BtdS0+bGJyX3N0YWNrIHJhdGhl
ciB0aGFuIHRhc2tfY3R4IG9mIHBlcmZfZXZlbnQgPw0KDQpZZXMsIGJvdGggbWV0aG9kIHNob3Vs
ZCB3b3JrLiBQZW9wbGUgbWF5IGhhdmUgZGlmZmVyZW50IG9waW5pb25zIGFib3V0DQprdm0gb3Ig
cGVyZiB0byBvd24gdGhlIGpvYiBvZiBsYnIgc3dpdGNoaW5nLiBMZXQncyBzZWUuLiBpZiBtb3N0
IHBlb3BsZSB2b3RlIGZvcg0Ka3ZtIHRvIGRvIHRoZSBzd2l0Y2hpbmcsIEknbGwgbWFrZSB0aGF0
IGNoYW5nZS4NCk90aGVyd2lzZSwgSSdsbCBzdGF5IHdpdGggd2hhdCB3ZSBhbHJlYWR5IGhhdmUu
DQoNCkJlc3QsDQpXZWkNCg==
