Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C07C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6397D218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="vdNGGG9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733281AbfAaNDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:03:35 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:40358 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732877AbfAaNDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548939813; x=1580475813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=MR2CIGZSrb0pZq1K25+yhV8AjK/XvaYq05hqngRriCc=;
  b=vdNGGG9QlHw0YeBERYWYCySDdAh1i1ioP3M1UwCqapbt7kHb+EjL0/jQ
   48lK0P4s5lDAODNPbOlDnlKCD7qAaUpUNRkLc2LrOLLbG44PReJAXZl5G
   gX13lsX0qtyvi/GeYdK4M95zLrF4lcX5cxCyxrbDekvcVhMvq2f2dAp4m
   4=;
X-IronPort-AV: E=Sophos;i="5.56,544,1539648000"; 
   d="scan'208";a="779924413"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 13:03:30 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x0VD3QMN006064
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 31 Jan 2019 13:03:27 GMT
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 31 Jan 2019 13:03:27 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB003.ant.amazon.com (10.43.166.248) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 31 Jan 2019 13:03:26 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Thu, 31 Jan 2019 13:03:26 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: [PATCH v5 00/13] KVM/X86: Introduce a new guest mapping interface
Thread-Topic: [PATCH v5 00/13] KVM/X86: Introduce a new guest mapping
 interface
Thread-Index: AQHUp/+dPJ/o/42K00OzVQHcAWMqaaW9P5GAgAMoFACAB8bBgIABTE6A
Date:   Thu, 31 Jan 2019 13:03:26 +0000
Message-ID: <1548939805.28936.9.camel@amazon.de>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
         <20190123181636.GR19289@Konrads-MacBook-Pro.local>
         <1548440932.17444.29.camel@amazon.de>
         <72d9954b-37f8-3f39-37f7-b292766da480@redhat.com>
In-Reply-To: <72d9954b-37f8-3f39-37f7-b292766da480@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.222]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AC95BC4D34D104FBD019CA8EAF3A9C0@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTAxLTMwIGF0IDE4OjE0ICswMTAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBPbiAyNS8wMS8xOSAxOToyOCwgUmFzbGFuLCBLYXJpbUFsbGFoIHdyb3RlOg0KPiA+IA0KPiA+
IFNvIHRoZSBzaW1wbGUgd2F5IHRvIGRvIGl0IGlzOg0KPiA+IA0KPiA+IDEtIFBhc3MgJ21lbT0n
IGluIHRoZSBrZXJuZWwgY29tbWFuZC1saW5lIHRvIGxpbWl0IHRoZSBhbW91bnQgb2YgbWVtb3J5
IG1hbmFnZWTCoA0KPiA+IMKgIMKgYnkgdGhlIGtlcm5lbC4NCj4gPiAyLSBNYXAgdGhpcyBwaHlz
aWNhbCBtZW1vcnkgeW91IHdhbnQgdG8gZ2l2ZSB0byB0aGUgZ3Vlc3Qgd2l0aA0KPiA+IMKgIMKg
IMKgIG1tYXAoIi9kZXYvbWVtIiwgcGh5c2ljYWxfYWRkcmVzc19vZmZzZXQsIC4uKQ0KPiA+IDMt
IFVzZSB0aGUgdXNlci1zcGFjZSB2aXJ0dWFsIGFkZHJlc3MgYXMgdGhlICJ1c2Vyc3BhY2VfYWRk
ciIgZmllbGTCoA0KPiA+IMKgIMKgaW7CoEtWTV9TRVRfVVNFUl9NRU1PUllfUkVHSU9OIGlvY3Rs
Lg0KPiA+IA0KPiA+IFlvdSB3aWxsIGFsc28gbmVlZCB0aGlzIHBhdGNoIChob3BlZnVsbHkgSSB3
aWxsIHJlcG9zdCBuZXh0IHdlZWsgYXMgd2VsbCk6DQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wYXRjaC85MTkxNzU1Lw0KPiANCj4gSSB0b29rIGEgbG9vayBhZ2FpbiBhdCB0aGF0
IHBhdGNoIGFuZCBJIGd1ZXNzIEkndmUgY2hhbmdlZCBteSBtaW5kIG5vdw0KPiB0aGF0IHRoZSBr
ZXJuZWwgcHJvdmlkZXMgZTgyMF9fbWFwcGVkX2FueSBhbmQgZTgyMF9fbWFwcGVkX2FsbC4NCj4g
SG93ZXZlciwgcGxlYXNlIGRvIHVzZSBlODIwX19tYXBwZWRfYW55IGluc3RlYWQgb2YgYWRkaW5n
IGEgbmV3IGZ1bmN0aW9uDQo+IGU4MjBfaXNfcmFtLg0KDQpUaGUgcHJvYmxlbSB3aXRowqBlODIw
X19tYXBwZWRfKiBpcyB0aGF0IHRoZXkgYXJlIGl0ZXJhdGluZyBvdmVyICdlODIwX3RhYmxlJw0K
d2hpY2ggaXMgYWxyZWFkeSB0cnVuY2F0ZWQgZnJvbSB0aGUgJ21lbT0nIGFuZCAnbWVtbWFwPScg
cGFyYW1ldGVyczoNCg0KIiIiDQrCoCogLSAnZTgyMF90YWJsZSc6IHRoaXMgaXMgdGhlIG1haW4g
RTgyMCB0YWJsZSB0aGF0IGlzIG1hc3NhZ2VkIGJ5IHRoZQ0KwqAqwqDCoMKgbG93IGxldmVsIHg4
NiBwbGF0Zm9ybSBjb2RlLCBvciBtb2RpZmllZCBieSBib290IHBhcmFtZXRlcnMsIGJlZm9yZQ0K
wqAqwqDCoMKgcGFzc2VkIG9uIHRvIGhpZ2hlciBsZXZlbCBNTSBsYXllcnMuDQoiIiINCg0KLi4g
c28gSSByZWFsbHkgc3RpbGwgY2FuIG5vdCB1c2UgaXQgZm9yIHRoaXMgcHVycG9zZS4gVGhlIHN0
cnVjdHVyZSB0aGF0IEkgd2FudA0KdG8gbG9vayBhdCBpcyBhY3R1YWxseSAnZTgyMF90YWJsZV9m
aXJtd2FyZScgd2hpY2ggaXM6DQoNCiIiIg0KwqAqIC0gJ2U4MjBfdGFibGVfZmlybXdhcmUnOiB0
aGUgb3JpZ2luYWwgZmlybXdhcmUgdmVyc2lvbiBwYXNzZWQgdG8gdXMgYnkgdGhlDQrCoCrCoMKg
wqBib290bG9hZGVyIC0gbm90IG1vZGlmaWVkIGJ5IHRoZSBrZXJuZWwuIEl0IGlzIGNvbXBvc2Vk
IG9mIHR3byBwYXJ0czoNCsKgKsKgwqDCoHRoZSBmaXJzdCAxMjggRTgyMCBtZW1vcnkgZW50cmll
cyBpbiBib290X3BhcmFtcy5lODIwX3RhYmxlIGFuZCB0aGUNCnJlbWFpbmluZw0KwqAqwqDCoMKg
KGlmIGFueSkgZW50cmllcyBvZiB0aGUgU0VUVVBfRTgyMF9FWFQgbm9kZXMuIFdlIHVzZSB0aGlz
IHRvOg0KwqAqDQrCoCrCoMKgwqDCoMKgwqDCoC0gaW5mb3JtIHRoZSB1c2VyIGFib3V0IHRoZSBm
aXJtd2FyZSdzIG5vdGlvbiBvZiBtZW1vcnkgbGF5b3V0DQrCoCrCoMKgwqDCoMKgwqDCoMKgwqB2
aWEgL3N5cy9maXJtd2FyZS9tZW1tYXANCsKgKg0KwqAqwqDCoMKgwqDCoMKgwqAtIHRoZSBoaWJl
cm5hdGlvbiBjb2RlIHVzZXMgaXQgdG8gZ2VuZXJhdGUgYSBrZXJuZWwtaW5kZXBlbmRlbnQgTUQ1
DQrCoCrCoMKgwqDCoMKgwqDCoMKgwqBmaW5nZXJwcmludCBvZiB0aGUgcGh5c2ljYWwgbWVtb3J5
IGxheW91dCBvZiBhIHN5c3RlbS4NCiIiIg0KDQpUaGUgdXNlcnMgb2bCoGU4MjBfX21hcHBlZF9h
bnkgZXhwZWN0IHRoZXNlIHNlbWFudGljcywgc28gZXZlbiBjaGFuZ2luZyB0aGXCoA0KaW1wbGVt
ZW50YXRpb24gb2YgdGhlc2UgZnVuY3Rpb25zIHRvIHVzZSAnZTgyMF90YWJsZV9maXJtd2FyZScg
dG8gaGFuZGxlIHRoaXPCoA0Kd2lsbCBub3QgYmUgYW4gb3B0aW9uIQ0KDQpPbmUgb3B0aW9uIGhl
cmUgd291bGQgYmUgdG8gYWRkICdlODIwX19tYXBwZWRfcmF3X2FueScgKG9yIHdoYXRldmVywqAN
Cm90aGVyIG5hbWUpIGFuZCBtYWtlIGl0IGlkZW50aWNhbCB0byB0aGUgY3VycmVudCBpbXBsZW1l
bnRhdGlvbiBvZsKgDQplODIwX19tYXBwZWRfYW55IGF0LiBXb3VsZCB0aGF0IGJlIHNsaWdodGx5
IG1vcmUgYWNjZXB0YWJsZT8gOikNCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gUGFvbG8NCj4gDQo+
ID4gDQo+ID4gSSB3aWxsIG1ha2Ugc3VyZSB0byBleHBhbmQgb24gdGhpcyBpbiB0aGUgY292ZXIg
bGV0dGVyIGluIHY2Lg0KPiANCgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBH
bWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJlcjogQ2hyaXN0
aWFuIFNjaGxhZWdlciwgUmFsZiBIZXJicmljaApVc3QtSUQ6IERFIDI4OSAyMzcgODc5CkVpbmdl
dHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIEhSQiAxNDkxNzMgQgoK

