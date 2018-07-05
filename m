Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE326C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B94B23E5D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="MPKI1eH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B94B23E5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753998AbeGEMWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 08:22:48 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:21821 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753928AbeGEMWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 08:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1530793366; x=1562329366;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=aPeKEDs4aJjlcYgrWxxJj9I5TPSxrNMk3MtAMMTdYZQ=;
  b=MPKI1eH1qAnIWQTIelOhHGqEuixBhSLpcCvL226EUVOeGDSgo5ZnkwtK
   8bSyP6rfUzvA2ibHqmFHfDmMAJ2x35VkY/Tt+pRGmHV4LWDayLWtB+4C8
   f7nEDMrwfLLYygXPel/HlGCLEMKzzFGDoOrr2NGftB8yVMygL2HbEVubZ
   c=;
X-IronPort-AV: E=Sophos;i="5.51,312,1526342400"; 
   d="scan'208";a="686243048"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Jul 2018 12:22:44 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w65CMgmg074585
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 5 Jul 2018 12:22:43 GMT
Received: from EX13D01EUB002.ant.amazon.com (10.43.166.113) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Jul 2018 12:22:42 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB002.ant.amazon.com (10.43.166.113) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Jul 2018 12:22:41 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Thu, 5 Jul 2018 12:22:41 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
CC:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: Switch 'requests' to be 64-bit (explicitly)
Thread-Topic: [PATCH] KVM: Switch 'requests' to be 64-bit (explicitly)
Thread-Index: AQHT1D++Gdqnz/tFy0K4EdrtXKZQKaQDl3kAgDiG6QCAAAGOAIBE7U2A
Date:   Thu, 5 Jul 2018 12:22:41 +0000
Message-ID: <1530793361.23804.13.camel@amazon.de>
References: <1523744804-8220-1-git-send-email-karahmed@amazon.de>
         <53700469-74f0-f3b0-96a4-d8ace2919b36@redhat.com>
         <1527003728.13207.55.camel@amazon.de>
         <5f346c4e-73f2-6a73-7915-e9fa911191ec@redhat.com>
In-Reply-To: <5f346c4e-73f2-6a73-7915-e9fa911191ec@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.174]
Content-Type: text/plain; charset="utf-8"
Content-ID: <456DE44D538114499605594BE9C4164B@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA1LTIyIGF0IDE3OjQ3ICswMjAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBPbiAyMi8wNS8yMDE4IDE3OjQyLCBSYXNsYW4sIEthcmltQWxsYWggd3JvdGU6DQo+ID4gDQo+
ID4gT24gTW9uLCAyMDE4LTA0LTE2IGF0IDE4OjI4ICswMjAwLCBQYW9sbyBCb256aW5pIHdyb3Rl
Og0KPiA+ID4gDQo+ID4gPiBPbiAxNS8wNC8yMDE4IDAwOjI2LCBLYXJpbUFsbGFoIEFobWVkIHdy
b3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IFN3aXRjaCAncmVxdWVzdHMnIHRvIGJl
IGV4cGxpY2l0bHkgNjQtYml0IGFuZCB1cGRhdGUgQlVJTERfQlVHX09OIGNoZWNrIHRvDQo+ID4g
PiA+IHVzZSB0aGUgc2l6ZSBvZiAicmVxdWVzdHMiIGluc3RlYWQgb2YgdGhlIGhhcmQtY29kZWQg
JzMyJy4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoYXQgZ2l2ZXMgdXMgYSBiaXQgbW9yZSByb29tIGFn
YWluIGZvciBhcmNoLXNwZWNpZmljIHJlcXVlc3RzIGFzIHdlDQo+ID4gPiA+IGFscmVhZHkgcmFu
IG91dCBvZiBzcGFjZSBmb3IgeDg2IGR1ZSB0byB0aGUgaGFyZC1jb2RlZCBjaGVjay4NCj4gPiA+
ID4gDQo+ID4gPiA+IENjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPiA+
ID4gPiBDYzogUmFkaW0gS3LEjW3DocWZIDxya3JjbWFyQHJlZGhhdC5jb20+DQo+ID4gPiA+IENj
OiBrdm1Admdlci5rZXJuZWwub3JnDQo+ID4gPiA+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEthcmltQWxsYWggQWhtZWQgPGthcmFobWVk
QGFtYXpvbi5kZT4NCj4gPiA+IA0KPiA+ID4gSSdtIGFmcmFpZCBhcmNoaXRlY3R1cmVzIGxpa2Ug
QVJNIDMyIG5lZWQgdGhpcyB0byBiZSBjb25kaXRpb25hbCAodXNpbmcNCj4gPiA+IEtjb25maWcp
Lg0KPiA+IA0KPiA+IFdoeSB3b3VsZCB1c2luZyBhIDY0LWJpdCAncmVxdWVzdHMnIGJlIGEgcHJv
YmxlbSBmb3IgQVJNMzI/IEFyZSB5b3XCoA0KPiA+IGNvbmNlcm5lZCBhYm91dCBwZXJmb3JtYW5j
ZSBoZXJlIG9yIGlzIHRoZXJlIHNvbWUgc3ltYW50aWMgcHJvYmxlbT8NCj4gDQo+IFRoZXkgZG9u
J3Qgc3VwcG9ydCBhdG9taWNzIG9uIGRvdWJsZS13b3JkIGRhdGEuDQoNCkJ1dCB0aGV5IHN1cHBv
cnQgYXRvbWljcyBvbiBzaW5nbGUgd29yZHMuIE9mIHdoaWNoIHRoZXJlIGFyZSB0d28uDQpXZSBk
b24ndCBuZWVkIGF0b21pYyB1cGRhdGVzIG9mIHRoZSB3aG9sZSA2NC1iaXQgcXVhbnRpdHkgKGEg
bMOgwqANCmNtcHhjaGcpLiBEbyB3ZSBzdHJpY3RseSBuZWVkIHRoaXMgdG8gYmUgYXRvbWljIGFj
Y3Jvc3MgdGhlIDY0LWJpdD8NCg0KTG9va2luZyBhdCB0aGUgdXNlIGNhc2VzIGZvciAicmVxdWVz
dHMiOg0KDQprdm1fY2xlYXJfcmVxdWVzdA0Ka3ZtX3Rlc3RfcmVxdWVzdA0Ka3ZtX3JlcXVlc3Rf
cGVuZGluZw0Ka3ZtX2NoZWNrX3JlcXVlc3QNCg0KLi4uIGFuZCBhbGwgb2YgdGhlbSB3b3VsZCBz
dGlsbCB3b3JrIGlmIHRoZSBhdG9taWNpdHkgaXMgb25seSBhdCB0aGXCoA0Kd29yZCBsZXZlbCwg
cmlnaHQ/DQoNCj4gDQo+IFBhb2xvDQo+IA0KQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJt
YW55IEdtYkgKQmVybGluIC0gRHJlc2RlbiAtIEFhY2hlbgptYWluIG9mZmljZTogS3JhdXNlbnN0
ci4gMzgsIDEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJlcjogRHIuIFJhbGYgSGVyYnJpY2gs
IENocmlzdGlhbiBTY2hsYWVnZXIKVXN0LUlEOiBERTI4OTIzNzg3OQpFaW5nZXRyYWdlbiBhbSBB
bXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyBIUkIgMTQ5MTczIEIK

