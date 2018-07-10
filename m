Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C7EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3673208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="abyDYb3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3673208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933278AbeGJMGj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:06:39 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:21627 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752001AbeGJMGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1531224397; x=1562760397;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding;
  bh=WIFtAK0qaiUcGaEGxpMuS60iODYAjxqwoQo2pHbL0zw=;
  b=abyDYb3avvo/qqjm7OBK6QJxNMEh8gk+eK7Mw2U/lvfnASFnjLvR+A2l
   Uc0qeQ/JiCakHPVnqoJRNhmO5ruw1SYnY8MSEa8+Hd5v99tdy+5c3Qdsu
   pBrl5ert3Ni2Lv/eYCFEN0zHtdRguaAfs+o7T6yM9/hcDTrepvnM8QXL0
   s=;
X-IronPort-AV: E=Sophos;i="5.51,334,1526342400"; 
   d="scan'208";a="743263343"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-7c6d20a4.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Jul 2018 12:06:35 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-7c6d20a4.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w6AC6YHk018420
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 10 Jul 2018 12:06:35 GMT
Received: from EX13D01EUB004.ant.amazon.com (10.43.166.180) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Jul 2018 12:06:35 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB004.ant.amazon.com (10.43.166.180) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Jul 2018 12:06:34 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Tue, 10 Jul 2018 12:06:34 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "david@redhat.com" <david@redhat.com>
Subject: Re: [PATCH v2 00/12] KVM/X86: Introduce a new guest mapping interface
Thread-Topic: [PATCH v2 00/12] KVM/X86: Introduce a new guest mapping
 interface
Thread-Index: AQHT1QRgTdVQE1Wqo0a2IXn3xPxQ2KQDPR4AgIWlvIA=
Date:   Tue, 10 Jul 2018 12:06:33 +0000
Message-ID: <1531224393.10099.37.camel@amazon.de>
References: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
         <b390f953-6fe3-1119-15eb-e3b31e609305@redhat.com>
In-Reply-To: <b390f953-6fe3-1119-15eb-e3b31e609305@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.31]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EC4B274A773D64384EC73D7DF1FE495@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA0LTE2IGF0IDEzOjEwICswMjAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBPbiAxNS8wNC8yMDE4IDIzOjUzLCBLYXJpbUFsbGFoIEFobWVkIHdyb3RlOg0KPiA+IA0KPiA+
IEd1ZXN0IG1lbW9yeSBjYW4gZWl0aGVyIGJlIGRpcmVjdGx5IG1hbmFnZWQgYnkgdGhlIGtlcm5l
bCAoaS5lLiBoYXZlIGEgInN0cnVjdA0KPiA+IHBhZ2UiKSBvciB0aGV5IGNhbiBzaW1wbHkgbGl2
ZSBvdXRzaWRlIGtlcm5lbCBjb250cm9sIChpLmUuIGRvIG5vdCBoYXZlIGENCj4gPiAic3RydWN0
IHBhZ2UiKS4gS1ZNIG1vc3RseSBzdXBwb3J0IHRoZXNlIHR3byBtb2RlcywgZXhjZXB0IGluIGEg
ZmV3IHBsYWNlcw0KPiA+IHdoZXJlIHRoZSBjb2RlIHNlZW1zIHRvIGFzc3VtZSB0aGF0IGd1ZXN0
IG1lbW9yeSBtdXN0IGhhdmUgYSAic3RydWN0IHBhZ2UiLg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2hz
ZXQgaW50cm9kdWNlcyBhIG5ldyBtYXBwaW5nIGludGVyZmFjZSB0byBtYXAgZ3Vlc3QgbWVtb3J5
IGludG8gaG9zdA0KPiA+IGtlcm5lbCBtZW1vcnkgd2hpY2ggYWxzbyBzdXBwb3J0cyBQRk4tYmFz
ZWQgbWVtb3J5IChpLmUuIG1lbW9yeSB3aXRob3V0ICdzdHJ1Y3QNCj4gPiBwYWdlJykuIEl0IGFs
c28gY29udmVydHMgYWxsIG9mZmVuZGluZyBjb2RlIHRvIHRoaXMgaW50ZXJmYWNlIG9yIHNpbXBs
eQ0KPiA+IHJlYWQvd3JpdGUgZGlyZWN0bHkgZnJvbSBndWVzdCBtZW1vcnkuDQo+ID4gDQo+ID4g
QXMgZmFyIGFzIEkgY2FuIHNlZSBhbGwgb2ZmZW5kaW5nIGNvZGUgaXMgbm93IGZpeGVkIGV4Y2Vw
dCB0aGUgQVBJQy1hY2Nlc3MgcGFnZQ0KPiA+IHdoaWNoIEkgd2lsbCBoYW5kbGUgaW4gYSBzZXBl
cmF0ZSBwYXRjaC4NCj4gDQo+IEkgYXNzdW1lIHRoZSBjYWNoaW5nIHdpbGwgYWxzbyBiZSBhIHNl
cGFyYXRlIHBhdGNoLg0KPiANCj4gSXQgbG9va3MgZ29vZCBleGNlcHQgdGhhdCBJJ2Qgc3F1YXNo
IHBhdGNoZXMgNCBhbmQgOSB0b2dldGhlci4gIEJ1dCBJJ2QNCj4gbGlrZSBhIHNlY29uZCBzZXQg
b2YgZXllcyB0byBsb29rIGF0IGl0Lg0KDQpCVFcsIFdoeSBkaWQgeW91IHdhbnQgdG8gc3F1YXNo
IHRoZXNlIDIgcGF0Y2hlcyBzcGVjaWZpY2FsbHk/IFRoZXkgYXJlwqANCnZlcnkgdW5yZWxhdGVk
IHRvIG1lLiBUaGUgb25seSBjb21tb24gdGhpbmcgaXMgdGhhdCB0aGV5IHN3aXRjaCBmcm9twqAN
CmNvZGUgdGhhdCBzdXBwb3J0cyBvbmx5ICJzdHJ1Y3QgcGFnZSIgdG8gY29kZSB0aGF0IHN1cHBv
cnRzIFBGTiBvbmx5DQpidXQgdGhpcyBpcyBhbHNvIGNvbW1vbiBmb3IgYWxsIG90aGVyIHBhdGNo
ZXMuDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IFBhb2xvDQo+IA0KQW1hem9uIERldmVsb3BtZW50
IENlbnRlciBHZXJtYW55IEdtYkgKQmVybGluIC0gRHJlc2RlbiAtIEFhY2hlbgptYWluIG9mZmlj
ZTogS3JhdXNlbnN0ci4gMzgsIDEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJlcjogRHIuIFJh
bGYgSGVyYnJpY2gsIENocmlzdGlhbiBTY2hsYWVnZXIKVXN0LUlEOiBERTI4OTIzNzg3OQpFaW5n
ZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyBIUkIgMTQ5MTczIEIK

