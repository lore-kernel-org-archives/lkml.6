Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629CBC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CE620857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfA2Rh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:37:58 -0500
Received: from mga02.intel.com ([134.134.136.20]:2205 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbfA2Rh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:37:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 09:37:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="113650759"
Received: from irsmsx154.ger.corp.intel.com ([163.33.192.96])
  by orsmga008.jf.intel.com with ESMTP; 29 Jan 2019 09:37:56 -0800
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.65]) by
 IRSMSX154.ger.corp.intel.com ([169.254.12.253]) with mapi id 14.03.0415.000;
 Tue, 29 Jan 2019 17:37:55 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Andrea Parri" <andrea.parri@amarulasolutions.com>
Subject: RE: [PATCH] refcount_t: add ACQUIRE ordering on success for
 dec(sub)_and_test variants
Thread-Topic: [PATCH] refcount_t: add ACQUIRE ordering on success for
 dec(sub)_and_test variants
Thread-Index: AQHUtwJjl6FToBsL5EumdKDVAgvWOaXGR+kAgAA6+MA=
Date:   Tue, 29 Jan 2019 17:37:55 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4B99139@IRSMSX102.ger.corp.intel.com>
References: <1548677377-22177-1-git-send-email-elena.reshetova@intel.com>
 <CACT4Y+aw1L7u+WJb8Ug8ED2bESfZccVK3o_7OBbjyQbQrLskbg@mail.gmail.com>
In-Reply-To: <CACT4Y+aw1L7u+WJb8Ug8ED2bESfZccVK3o_7OBbjyQbQrLskbg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWQwOTNmNWMtYWJlOS00YTdhLTg3MTEtMmRjNWIyM2I4YmQyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNDExUURSeXpNXC9QdUUzM2gzMUhNdGR5N3Y3eW1kUm5LckFWM2V1VDlEY0FrdFRsY25SVThwUG1jd2hiSUNqaFMifQ==
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE1vbiwgSmFuIDI4LCAyMDE5IGF0IDE6MTAgUE0gRWxlbmEgUmVzaGV0b3ZhDQo+IDxl
bGVuYS5yZXNoZXRvdmFAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgYWRkcyBhbiBz
bXBfYWNxdWlyZV9fYWZ0ZXJfY3RybF9kZXAoKSBiYXJyaWVyIG9uIHN1Y2Nlc3NmdWwNCj4gPiBk
ZWNyZWFzZSBvZiByZWZjb3VudGVyIHZhbHVlIGZyb20gMSB0byAwIGZvciByZWZjb3VudF9kZWMo
c3ViKV9hbmRfdGVzdA0KPiA+IHZhcmlhbnRzIGFuZCB0aGVyZWZvcmUgZ2l2ZXMgc3Ryb25nZXIg
bWVtb3J5IG9yZGVyaW5nIGd1YXJhbnRlZXMgdGhhbg0KPiA+IHByaW9yIHZlcnNpb25zIG9mIHRo
ZXNlIGZ1bmN0aW9ucy4NCj4gPg0KPiA+IENvLURldmVsb3BlZC1ieTogUGV0ZXIgWmlqbHN0cmEg
KEludGVsKSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogRWxlbmEg
UmVzaGV0b3ZhIDxlbGVuYS5yZXNoZXRvdmFAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1
bWVudGF0aW9uL2NvcmUtYXBpL3JlZmNvdW50LXZzLWF0b21pYy5yc3QgfCAyOA0KPiArKysrKysr
KysrKysrKysrKysrKysrKy0tLS0NCj4gPiAgYXJjaC94ODYvaW5jbHVkZS9hc20vcmVmY291bnQu
aCAgICAgICAgICAgICAgIHwgMjEgKysrKysrKysrKysrKysrKy0tLS0NCj4gPiAgbGliL3JlZmNv
dW50LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTYgKysrKysrKysrKy0tLS0t
DQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9jb3JlLWFwaS9yZWZjb3VudC12
cy1hdG9taWMucnN0DQo+IGIvRG9jdW1lbnRhdGlvbi9jb3JlLWFwaS9yZWZjb3VudC12cy1hdG9t
aWMucnN0DQo+ID4gaW5kZXggMzIyODUxYi4uOTVkNGI0ZSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2NvcmUtYXBpL3JlZmNvdW50LXZzLWF0b21pYy5yc3QNCj4gPiArKysgYi9Eb2N1
bWVudGF0aW9uL2NvcmUtYXBpL3JlZmNvdW50LXZzLWF0b21pYy5yc3QNCj4gPiBAQCAtNTQsNiAr
NTQsMTQgQEAgbXVzdCBwcm9wYWdhdGUgdG8gYWxsIG90aGVyIENQVXMgYmVmb3JlIHRoZSByZWxl
YXNlDQo+IG9wZXJhdGlvbg0KPiA+ICAoQS1jdW11bGF0aXZlIHByb3BlcnR5KS4gVGhpcyBpcyBp
bXBsZW1lbnRlZCB1c2luZw0KPiA+ICA6YzpmdW5jOmBzbXBfc3RvcmVfcmVsZWFzZWAuDQo+ID4N
Cj4gPiArQW4gQUNRVUlSRSBtZW1vcnkgb3JkZXJpbmcgZ3VhcmFudGVlcyB0aGF0IGFsbCBwb3N0
IGxvYWRzIGFuZA0KPiA+ICtzdG9yZXMgKGFsbCBwby1sYXRlciBpbnN0cnVjdGlvbnMpIG9uIHRo
ZSBzYW1lIENQVSBhcmUNCj4gPiArY29tcGxldGVkIGFmdGVyIHRoZSBhY3F1aXJlIG9wZXJhdGlv
bi4gSXQgYWxzbyBndWFyYW50ZWVzIHRoYXQgYWxsDQo+ID4gK3BvLWxhdGVyIHN0b3JlcyBvbiB0
aGUgc2FtZSBDUFUgYW5kIGFsbCBwcm9wYWdhdGVkIHN0b3JlcyBmcm9tIG90aGVyIENQVXMNCj4g
PiArbXVzdCBwcm9wYWdhdGUgdG8gYWxsIG90aGVyIENQVXMgYWZ0ZXIgdGhlIGFjcXVpcmUgb3Bl
cmF0aW9uDQo+ID4gKyhBLWN1bXVsYXRpdmUgcHJvcGVydHkpLiBUaGlzIGlzIGltcGxlbWVudGVk
IHVzaW5nDQo+ID4gKzpjOmZ1bmM6YHNtcF9hY3F1aXJlX19hZnRlcl9jdHJsX2RlcGAuDQo+IA0K
PiBUaGUgc2Vjb25kIHBhcnQgc3RhcnRpbmcgZnJvbSAiSXQgYWxzbyBndWFyYW50ZWVzIHRoYXQi
LiBJIGFtIG5vdCBzdXJlDQo+IEkgdW5kZXJzdGFuZCB3aGF0IGl0IG1lYW5zLiBJcyBpdCBqdXN0
IGEgY29weS1wYXN0ZSBmcm9tIFJFTEVBU0U/IEkgYW0NCj4gbm90IHN1cmUgQUNRVUlSRSBwcm92
aWRlcyBhbnl0aGluZyBsaWtlIHRoaXMuDQo+IAkNCg0KU28sIHlvdSBhcmUgc2F5aW5nIHRoYXQg
QUNRVUlSRSBkb2VzIG5vdCBndWFyYW50ZWUgdGhhdCAicG8tbGF0ZXIgc3RvcmVzDQpvbiB0aGUg
c2FtZSBDUFUgYW5kIGFsbCBwcm9wYWdhdGVkIHN0b3JlcyBmcm9tIG90aGVyIENQVXMNCm11c3Qg
cHJvcGFnYXRlIHRvIGFsbCBvdGhlciBDUFVzIGFmdGVyIHRoZSBhY3F1aXJlIG9wZXJhdGlvbiAi
PyANCkkgd2FzIHJlYWRpbmcgYWJvdXQgYWNxdWlyZSBiZWZvcmUgcG9zdGluZyB0aGlzIGFuZCB0
cnlpbmcgdG8gdW5kZXJzdGFuZCwNCmFuZCB0aGlzIHdhcyBteSBjb25jbHVzaW9uIHRoYXQgaXQg
c2hvdWxkIHByb3ZpZGUgdGhpcywgYnV0IEkgY2FuIGVhc2lseSBiZSB3cm9uZw0Kb24gdGhpcy4g
DQoNCkFuZHJlYSwgUGV0ZXIsIGNvdWxkIHlvdSBwbGVhc2UgY29tbWVudD8NCg0KDQo+IA0KPiA+
ICsNCj4gPiAgQSBjb250cm9sIGRlcGVuZGVuY3kgKG9uIHN1Y2Nlc3MpIGZvciByZWZjb3VudGVy
cyBndWFyYW50ZWVzIHRoYXQNCj4gPiAgaWYgYSByZWZlcmVuY2UgZm9yIGFuIG9iamVjdCB3YXMg
c3VjY2Vzc2Z1bGx5IG9idGFpbmVkIChyZWZlcmVuY2UNCj4gPiAgY291bnRlciBpbmNyZW1lbnQg
b3IgYWRkaXRpb24gaGFwcGVuZWQsIGZ1bmN0aW9uIHJldHVybmVkIHRydWUpLA0KPiA+IEBAIC0x
MTksMjQgKzEyNywzNiBAQCBNZW1vcnkgb3JkZXJpbmcgZ3VhcmFudGVlcyBjaGFuZ2VzOg0KPiA+
ICAgICByZXN1bHQgb2Ygb2J0YWluaW5nIHBvaW50ZXIgdG8gdGhlIG9iamVjdCENCj4gPg0KPiA+
DQo+ID4gLWNhc2UgNSkgLSBkZWNyZW1lbnQtYmFzZWQgUk1XIG9wcyB0aGF0IHJldHVybiBhIHZh
bHVlDQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ID4gK2Nhc2UgNSkgLSBnZW5lcmljIGRlYy9zdWIgZGVjcmVtZW50LWJhc2VkIFJN
VyBvcHMgdGhhdCByZXR1cm4gYSB2YWx1ZQ0KPiA+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPg0KPiA+ICBG
dW5jdGlvbiBjaGFuZ2VzOg0KPiA+DQo+ID4gICAqIDpjOmZ1bmM6YGF0b21pY19kZWNfYW5kX3Rl
c3RgIC0tPiA6YzpmdW5jOmByZWZjb3VudF9kZWNfYW5kX3Rlc3RgDQo+ID4gICAqIDpjOmZ1bmM6
YGF0b21pY19zdWJfYW5kX3Rlc3RgIC0tPiA6YzpmdW5jOmByZWZjb3VudF9zdWJfYW5kX3Rlc3Rg
DQo+ID4gKw0KPiA+ICtNZW1vcnkgb3JkZXJpbmcgZ3VhcmFudGVlcyBjaGFuZ2VzOg0KPiA+ICsN
Cj4gPiArICogZnVsbHkgb3JkZXJlZCAtLT4gUkVMRUFTRSBvcmRlcmluZyArIEFDUVVJUkUgb3Jk
ZXJpbmcgYW5kIGNvbnRyb2wNCj4gZGVwZW5kZW5jeQ0KPiA+ICsgICBvbiBzdWNjZXNzLg0KPiAN
Cj4gSXMgQUNRVUlSRSBzdHJpY3RseSBzdHJvbmdlciB0aGFuIGNvbnRyb2wgZGVwZW5kZW5jeT8N
Cg0KSW4gbXkgdW5kZXJzdGFuZGluZyB5ZXMuDQoNCj4gSXQgZ2VuZXJhbGx5IGxvb2tzIHNvIHVu
bGVzcyB0aGVyZSBpcyBzb21ldGhpbmcgdmVyeSBzdWJ0bGUgdGhhdCBJIGFtDQo+IG1pc3Npbmcu
IElmIHNvLCBzaG91bGQgd2UgcmVwbGFjZSBpdCB3aXRoIGp1c3QgIlJFTEVBU0Ugb3JkZXJpbmcg
Kw0KPiBBQ1FVSVJFIG9yZGVyaW5nIG9uIHN1Y2Nlc3MiPyBMb29rcyBzaW1wbGVyIHdpdGggbGVz
cyBtYWdpYyB0cmlja2VyeS4NCg0KSSB3YXMganVzdCB0cnlpbmcgdG8gbWVudGlvbiBhbGwgdGhl
IGFwcGxpY2FibGUgb3JkZXJpbmdzL2d1YXJhbnRlZXMuIA0KSSBjYW4gcmVtb3ZlICJjb250cm9s
IGRlcGVuZGVuY3kiIHBhcnQgaWYgaXQgaXMgZWFzaWVyIGZvciBwZW9wbGUgdG8gdW5kZXJzdGFu
ZA0KKHRoZSBtYWluIGdvYWwgb2YgZG9jdW1lbnRhdGlvbikuDQoNCkJlc3QgUmVnYXJkcywNCkVs
ZW5hLg0K
