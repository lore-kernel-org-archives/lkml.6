Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8778AC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3A426E0D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3A426E0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752451AbeFZVQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:16:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:16679 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752334AbeFZVQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:16:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 14:15:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,275,1526367600"; 
   d="scan'208";a="62413778"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga003.jf.intel.com with ESMTP; 26 Jun 2018 14:15:49 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 26 Jun 2018 14:15:49 -0700
Received: from lcsmsx153.ger.corp.intel.com (10.186.165.228) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 26 Jun 2018 14:15:48 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.94]) by
 LCSMSX153.ger.corp.intel.com ([169.254.8.115]) with mapi id 14.03.0319.002;
 Wed, 27 Jun 2018 00:15:46 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alan Cox <alan@linux.intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v7] tpm: separate cmd_ready/go_idle from runtime_pm
Thread-Topic: [PATCH v7] tpm: separate cmd_ready/go_idle from runtime_pm
Thread-Index: AQHUC/10xIwob4M80Eit0g6kz8euiKRw97kAgAABmYCAAg95gA==
Date:   Tue, 26 Jun 2018 21:15:45 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D954923@hasmsx108.ger.corp.intel.com>
References: <20180624205202.6597-1-tomas.winkler@intel.com>
         <19b4282d625e04bb391f497419283a191bca610d.camel@linux.intel.com>
 <cb7ecb912486ee3e504de7c0918d667ebd370080.camel@linux.intel.com>
In-Reply-To: <cb7ecb912486ee3e504de7c0918d667ebd370080.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2ZjMzM2OTktOWFjMS00YTE4LThkMTEtNjAwMjY5YTk1NmEyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiS1NvaWVHaWZ6NHlLakdYXC91MVFxbzc1K2JqWXRcL1BzV1h1MEN3VUNQRDNHSnFDTE1Kd0R1WXcycE9qb3h0VzUyIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.252.8.113]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiBPbiBNb24sIDIwMTgtMDYtMjUgYXQgMTk6MjQgKzAzMDAsIEphcmtrbyBTYWtraW5l
biB3cm90ZToNCj4gPiBPbiBTdW4sIDIwMTgtMDYtMjQgYXQgMjM6NTIgKzAzMDAsIFRvbWFzIFdp
bmtsZXIgd3JvdGU6DQo+ID4gPiBGaXggdHBtIHB0dCBpbml0aWFsaXphdGlvbiBlcnJvcjoNCj4g
PiA+IHRwbSB0cG0wOiBBIFRQTSBlcnJvciAoMzc4KSBvY2N1cnJlZCBnZXQgdHBtIHBjciBhbGxv
Y2F0aW9uLg0KPiA+ID4NCj4gPiA+IFdlIGNhbm5vdCB1c2UgZ29faWRsZSBjbWRfcmVhZHkgY29t
bWFuZHMgdmlhIHJ1bnRpbWVfcG0gaGFuZGxlcyBhcw0KPiA+ID4gd2l0aCB0aGUgaW50cm9kdWN0
aW9uIG9mIGxvY2FsaXRpZXMgdGhpcyBpcyBubyBsb25nZXIgYW4gb3B0aW9uYWwNCj4gPiA+IGZl
YXR1cmUsIHdoaWxlIHJ1bnRpbWUgcG0gY2FuIGJlIG5vdCBlbmFibGVkLg0KPiA+ID4gVGhvdWdo
IGNtZF9yZWFkeS9nb19pZGxlIHByb3ZpZGVzIGEgcG93ZXIgc2F2aW5nLCBpdCdzIGFsc28gYSBw
YXJ0DQo+ID4gPiBvZg0KPiA+ID4gVFBNMiBwcm90b2NvbCBhbmQgc2hvdWxkIGJlIGNhbGxlZCBl
eHBsaWNpdGx5Lg0KPiA+ID4gVGhpcyBwYXRjaCBleHBvc2VzIGNtZF9yZWFkL2dvX2lkbGUgdmlh
IHRwbSBjbGFzcyBvcHMgYW5kIHJlbW92ZXMNCj4gPiA+IHJ1bnRpbWUgcG0gc3VwcG9ydCBhcyBp
dCBpcyBub3QgdXNlZCBieSBhbnkgZHJpdmVyLg0KPiA+ID4NCj4gPiA+IEEgbmV3IHRwbSB0cmFu
c21pdCBmbGFnIGlzIGFkZGVkIFRQTV9UUkFOU01JVF9ORVNURUQsIHdoaWNoIGltcGxpZXMNCj4g
PiA+IFRQTV9UUkFOU01JVF9VTkxPQ0tFRCBhbmQgVFBNX1RSQU5TTUlUX1JBVy4gQm90aCBhcmUg
bmVlZGVkDQo+IHRvDQo+ID4gPiByZXNvbHZlIHRwbSBzcGFjZXMgYW5kIGxvY2FsaXR5IHJlcXVl
c3QgcmVjdXJzaXZlIGNhbGxzIHRvIHRwbV90cmFuc21pdCgpLg0KPiA+ID4NCj4gPiA+IE5ldyB3
cmFwcGVycyBhcmUgYWRkZWQgdHBtX2NtZF9yZWFkeSgpIGFuZCB0cG1fZ29faWRsZSgpIHRvDQo+
ID4gPiBzdHJlYW1saW5lIHRwbV90cnlfdHJhbnNtaXQgY29kZS4NCj4gPiA+DQo+ID4gPiB0cG1f
Y3JiIG5vIGxvbmdlciBuZWVkcyBvd24gcG93ZXIgc2F2aW5nIGZ1bmN0aW9ucyBhbmQgY2FuIGRy
b3ANCj4gPiA+IHVzaW5nIHRwbV9wbV9zdXNwZW5kL3Jlc3VtZS4NCj4gPiA+DQo+ID4gPiBUaGlz
IHBhdGNoIGNhbm5vdCBiZSByZWFsbHkgc2VwYXJhdGVkIGZyb20gdGhlIGxvY2FsaXR5IGZpeC4N
Cj4gPiA+IEZpeGVzOiA4ODhkODY3ZGY0NDEgKHRwbTogY21kX3JlYWR5IGNvbW1hbmQgY2FuIGJl
IGlzc3VlZCBvbmx5IGFmdGVyDQo+ID4gPiBncmFudGluZw0KPiA+ID4gbG9jYWxpdHkpDQo+ID4g
Pg0KPiA+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IEZpeGVzOiA4ODhkODY3
ZGY0NDEgKHRwbTogY21kX3JlYWR5IGNvbW1hbmQgY2FuIGJlIGlzc3VlZCBvbmx5IGFmdGVyDQo+
ID4gPiBncmFudGluZw0KPiA+ID4gbG9jYWxpdHkpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUb21h
cyBXaW5rbGVyIDx0b21hcy53aW5rbGVyQGludGVsLmNvbT4NCj4gPg0KPiA+IFBsZWFzZToNCj4g
Pg0KPiA+IDEuIFJlbW92ZSBORVNURUQuDQo+ID4gMi4gV2hlcmUgeW91IG5lZWQgY2FsbCBSQVcg
fCBVTkxPQ0tFRC4NCj4gPiAzLiBEbyBub3QgYWRkIF9fIHByZWZpeC4NCj4gDQo+IFJpZ2h0IG5v
dyBpZiBJIHJlYWxseSBwdXQgaGVhZCBpbnRvIHRoaXMgSSBjYW4gdW5kZXJzdGFuZCB0aGUgbG9n
aWMgYnV0IGl0IGlzIGENCj4gY29tcGxldGUgbWVzcy4NCg0KSSB0aGluayB3aGF0IGlzIHRoZSBt
ZXNzIGlzIHRoYXQgd2UgaGF2ZSBhIHJlY3Vyc2l2ZSBjYWxsIHRvIHRwbV90cmFuc21pdCB0b3Bw
ZWQgd2l0aCByZXRyaWVzLiAgQWxsIG90aGVyIG1lc3MgaXMganVzdCB0aGUgcmVzdWx0IG9mIHRo
YXQuDQoNCj5JIHdpbGwgZm9yZ290IHRoZSBkZXBlbmRlbmNpZXMgYmV0d2VlbiBmbGFncyB3aXRo
aW4gZmV3DQo+IHdlZWtzLiANCkhvcGUgdGhlIHJlYXNvbnMgYXJlIHdlbGwgZG9jdW1lbnRlZCBi
b3RoIGluIGNvZGUgYW5kIHRoZSBjb21taXQgbWVzc2FnZSwgaWYgbm90IGxldCdzIGFkZHJlc3Mg
dGhhdC4gV2UgcmVhbGx5IGNhbm5vdCBkZXBlbmQgb24gb25lJ3MgbWVtb3J5Lg0KSXQncyBub3Qg
bGlrZSBJJ20gbm90IHN0cml2aW5nIGZvciBzaW1wbGVzdCBwb3NzaWJsZSBjb2RlLiANCg0KPkEg
Zml4ZWQgcmVxdWlyZW1lbnQgKHNvIHRoYXQgeW91IGtub3cpIGlzIHRoYXQgdGhleSBtdXN0IGJl
DQo+IGluZGVwZW5kZW50Lg0KVGhlIGZsYWdzIChob3BlIHRoaXMgd2hhdCB5b3UgcmVmZXJyaW5n
IGhlcmUgdG8pIGFyZSBub3QgaW5kZXBlbmRlbnQgYW5kIHdlcmVuJ3QgYmVmb3JlLCAoUkFXIGNh
bm5vdCBiZSBjYWxsZWQgYWxvbmUgYXMgeW91IHdpbGwgaGF2ZSBkb3VibGUgbG9ja2luZykgcHV0
dGluZyB0aGVtIHVuZGVyIG9uZSBuYW1lIGp1c3Qgc2hvdWxkIG1ha2UgaXQgY2xlYXIuIA0KSSBi
ZWcgeW91IHRvIGdvIG92ZXIgdGhlICBjb2RlIG9uZSBtb3JlIHRpbWUsIGRvbid0IGdldCBzdHVj
ayB3aXRoIGZsYWdzIG5hbWVzLCBtYXliZSB5b3UgZXZlbiBkaXNjb3ZlciBzb21lIHJlYWwgaXNz
dWUuIA0KDQpUaGFua3MNClRvbWFzDQoNCg==
