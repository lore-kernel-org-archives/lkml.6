Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12B5C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 13:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CD32077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 13:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CD32077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbeJNVXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 17:23:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:48487 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeJNVXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 17:23:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2018 06:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,380,1534834800"; 
   d="scan'208";a="88250032"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Oct 2018 06:42:27 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 14 Oct 2018 06:42:27 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 14 Oct 2018 06:42:27 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.217]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.183]) with mapi id 14.03.0319.002;
 Sun, 14 Oct 2018 21:42:25 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>
Subject: RE: [PATCH v1] KVM/x86/vPMU: Guest PMI Optimization
Thread-Topic: [PATCH v1] KVM/x86/vPMU: Guest PMI Optimization
Thread-Index: AQHUYivyWC/BxHaJqkyOpiAgxus7L6UbR3QAgAEGI4CAAd5oAIAAlHYA
Date:   Sun, 14 Oct 2018 13:42:24 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73984BB8C@shsmsx102.ccr.corp.intel.com>
References: <1539346817-8638-1-git-send-email-wei.w.wang@intel.com>
 <20181012163058.GN32651@tassilo.jf.intel.com>
 <0c774dad-9f16-e9c1-56ea-3865cdfaeee0@redhat.com>
 <5BC33978.2020302@intel.com>
In-Reply-To: <5BC33978.2020302@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTliYTBmZTAtY2U2Yy00NTFiLThlZWEtZjRjYmRiZjkzODViIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUXVnbU5RdTZzeE83TEpjS1lDdEJYYk1GWEZZZWIrYlwvWmRGdVBCcTFyYzJpblBXZ2VhQXlSdW5TTklyZ0JPQ00ifQ==
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

T24gU3VuZGF5LCBPY3RvYmVyIDE0LCAyMDE4IDg6NDEgUE0sIFdlaSBXYW5nIHdyb3RlOg0KPiBI
ZXJlIGlzIHRoZSBwbGFuIEkgaGF2ZSBpbiBtaW5kOg0KPiAjMSBDcmVhdGVzIGEgaG9zdCBwZXJm
IGV2ZW50IG9uIHRoZSBndWVzdCdzIGZpcnN0IGJpdC1zZXR0aW5nIHRvDQo+IE1TUl9DT1JFX1BF
UkZfR0xPQkFMX0NUUkw7IE1lYW53aGlsZSwgZGlzYWJsZSB0aGUgaW50ZXJjZXB0IG9mIGd1ZXN0
DQo+IGFjY2VzcyB0byB0aGlzIHBlcmYgY291bnRlciByZWxhdGVkIE1TUnMgKGkuZS4gY29uZmln
X2Jhc2UgYW5kIGV2ZW50X2Jhc2UpLg0KPiAjMiBXaGVuIHRoZSB2Q1BVIGlzIHNjaGVkIGluLA0K
PiAgICAgICMyLjEgbWFrZSB0aGUgTVNScyBvZiB0aGUgcGVyZiBjb3VudGVycyAoYXNzaWduZWQg
dG8gdGhlIGd1ZXN0IGluDQo+ICMxKSBpbnRlcmNlcHRpYmxlLCBzbyB0aGF0IGd1ZXN0IGFjY2Vz
c2VzIHRvIHN1Y2ggYSBjb3VudGVyIGlzIGNhcHR1cmVkLCBhbmQNCj4gbWFya2VkIGl0ICJ1c2Vk
IiwgYW5kIGRpc2FibGUgdGhlIGludGVyY2VwdCBhZ2FpbjsNCj4gICAgICAjMi4yIGFsc28gY2hl
Y2sgaWYgdGhlcmUgaXMgYW55IGNvdW50ZXIgdGhhdCB3YXNuJ3QgInVzZWQiIGluIHRoZSBsYXN0
IHZDUFUNCj4gdGltZSBzbGljZSwgaWYgdGhlcmUgaXMsIHJlbGVhc2UgdGhhdCBjb3VudGVyIGFu
ZCB0aGUgcGVyZiBldmVudC4NCg0KSnVzdCB0aG91Z2h0IG9mIGFuIGlzc3VlIHdpdGggcGFzc2lu
ZyB0aHJvdWdoIGNvbmZpZ19iYXNlIGFuZCBldmVudCBiYXNlIC0gdGhlIGd1ZXN0J3MgdmlldyBv
ZiB0aGUgcGVyZiBjb3VudGVyIGlzIHBvc3NpYmxlIHRvIGJlIGRpZmZlcmVudCBmcm9tIHRoZSBv
bmUgYXNzaWduZWQgYnkgdGhlIGhvc3QsIHdoaWNoIHJlc3VsdHMgaW4gZ3Vlc3QgdXNpbmcgYSBk
aWZmZXJlbnQgY29uZmlnX2Jhc2UgYW5kIGV2ZW50X2Jhc2UuIFNvIHdlIHdvdWxkIHN0aWxsIG5l
ZWQga2VlcCB0aG9zZSBNU1JzIGJlaW5nIGludGVyY2VwdGVkIGJ5IHRoZSBob3N0LiBUaGUgcmVt
YWluaW5nIHBhcnQgKHRoZSBsYXp5IGFsbG9jYXRpb24gYW5kIHJlbGVhc2Ugb2YgdGhlIGhvc3Qg
cGVyZiBldmVudCkgY2FuIHN0aWxsIHdvcmsuDQoNCkJlc3QsDQpXZWkNCg==
