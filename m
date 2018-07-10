Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EBEC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02642089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="IvGkXDH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02642089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbeGJJhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:37:53 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:15106 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751194AbeGJJhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1531215471; x=1562751471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=5W8bkf5TtRLlfoVwotrmwLaoJHmq12pb39uyPMlZDBA=;
  b=IvGkXDH+UIQGEw7GBkHIfxxd2+uf/FkgkeBde+gEKEVI8ykgats4kIqL
   5UJzrx8f5TvkFKQza/L5ubkXXt1v6aGmw/vbowJ1ymYYNZnGV/HO38wQ7
   jNCIz+T94vZU2bYxmbaXqlhsYk1fXuyYl004+OOW7vdA+4ZD/nUCz21XZ
   8=;
X-IronPort-AV: E=Sophos;i="5.51,334,1526342400"; 
   d="scan'208";a="728037129"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Jul 2018 09:37:49 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w6A9bkVR047307
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 10 Jul 2018 09:37:49 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Jul 2018 09:37:48 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Jul 2018 09:37:47 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Tue, 10 Jul 2018 09:37:47 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: Switch 'requests' to be 64-bit (explicitly)
Thread-Topic: [PATCH] KVM: Switch 'requests' to be 64-bit (explicitly)
Thread-Index: AQHT1D++Gdqnz/tFy0K4EdrtXKZQKaSBJhiAgAeUuQA=
Date:   Tue, 10 Jul 2018 09:37:46 +0000
Message-ID: <1531215466.10099.28.camel@amazon.de>
References: <1523744804-8220-1-git-send-email-karahmed@amazon.de>
         <20180705135139.orifhe4mag7p6zj3@lakrids.cambridge.arm.com>
In-Reply-To: <20180705135139.orifhe4mag7p6zj3@lakrids.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.213]
Content-Type: text/plain; charset="utf-8"
Content-ID: <59F8F495F09166408306D258C57EEA36@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA3LTA1IGF0IDE0OjUxICswMTAwLCBNYXJrIFJ1dGxhbmQgd3JvdGU6DQo+
IE9uIFN1biwgQXByIDE1LCAyMDE4IGF0IDEyOjI2OjQ0QU0gKzAyMDAsIEthcmltQWxsYWggQWht
ZWQgd3JvdGU6DQo+ID4gDQo+ID4gU3dpdGNoICdyZXF1ZXN0cycgdG8gYmUgZXhwbGljaXRseSA2
NC1iaXQgYW5kIHVwZGF0ZSBCVUlMRF9CVUdfT04gY2hlY2sgdG8NCj4gPiB1c2UgdGhlIHNpemUg
b2YgInJlcXVlc3RzIiBpbnN0ZWFkIG9mIHRoZSBoYXJkLWNvZGVkICczMicuDQo+ID4gDQo+ID4g
VGhhdCBnaXZlcyB1cyBhIGJpdCBtb3JlIHJvb20gYWdhaW4gZm9yIGFyY2gtc3BlY2lmaWMgcmVx
dWVzdHMgYXMgd2UNCj4gPiBhbHJlYWR5IHJhbiBvdXQgb2Ygc3BhY2UgZm9yIHg4NiBkdWUgdG8g
dGhlIGhhcmQtY29kZWQgY2hlY2suDQo+ID4gDQo+ID4gQ2M6IFBhb2xvIEJvbnppbmkgPHBib256
aW5pQHJlZGhhdC5jb20+DQo+ID4gQ2M6IFJhZGltIEtyxI1tw6HFmSA8cmtyY21hckByZWRoYXQu
Y29tPg0KPiA+IENjOiBrdm1Admdlci5rZXJuZWwub3JnDQo+ID4gQ2M6IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYXJpbUFsbGFoIEFobWVkIDxrYXJh
aG1lZEBhbWF6b24uZGU+DQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvbGludXgva3ZtX2hvc3QuaCB8
IDEwICsrKysrLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9rdm1faG9z
dC5oIGIvaW5jbHVkZS9saW51eC9rdm1faG9zdC5oDQo+ID4gaW5kZXggNjkzMGM2My4uZmU0ZjQ2
YiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2t2bV9ob3N0LmgNCj4gPiArKysgYi9p
bmNsdWRlL2xpbnV4L2t2bV9ob3N0LmgNCj4gPiBAQCAtMTI5LDcgKzEyOSw3IEBAIHN0YXRpYyBp
bmxpbmUgYm9vbCBpc19lcnJvcl9wYWdlKHN0cnVjdCBwYWdlICpwYWdlKQ0KPiA+ICAjZGVmaW5l
IEtWTV9SRVFVRVNUX0FSQ0hfQkFTRSAgICAgOA0KPiA+ICANCj4gPiAgI2RlZmluZSBLVk1fQVJD
SF9SRVFfRkxBR1MobnIsIGZsYWdzKSAoeyBcDQo+ID4gLQlCVUlMRF9CVUdfT04oKHVuc2lnbmVk
KShucikgPj0gMzIgLSBLVk1fUkVRVUVTVF9BUkNIX0JBU0UpOyBcDQo+ID4gKwlCVUlMRF9CVUdf
T04oKHVuc2lnbmVkKShucikgPj0gKHNpemVvZigoKHN0cnVjdCBrdm1fdmNwdSAqKTApLT5yZXF1
ZXN0cykgKiA4KSAtIEtWTV9SRVFVRVNUX0FSQ0hfQkFTRSk7IFwNCj4gPiAgCSh1bnNpZ25lZCko
KChucikgKyBLVk1fUkVRVUVTVF9BUkNIX0JBU0UpIHwgKGZsYWdzKSk7IFwNCj4gPiAgfSkNCj4g
PiAgI2RlZmluZSBLVk1fQVJDSF9SRVEobnIpICAgICAgICAgICBLVk1fQVJDSF9SRVFfRkxBR1Mo
bnIsIDApDQo+ID4gQEAgLTIyMyw3ICsyMjMsNyBAQCBzdHJ1Y3Qga3ZtX3ZjcHUgew0KPiA+ICAJ
aW50IHZjcHVfaWQ7DQo+ID4gIAlpbnQgc3JjdV9pZHg7DQo+ID4gIAlpbnQgbW9kZTsNCj4gPiAt
CXVuc2lnbmVkIGxvbmcgcmVxdWVzdHM7DQo+ID4gKwl1NjQgcmVxdWVzdHM7DQo+IA0KPiBUaGUg
dXN1YWwgdGhpbmcgdG8gZG8gZm9yIGJpdG1hcHMgaXMgc29tZXRoaW5nIGxpa2U6DQo+IA0KPiAj
ZGVmaW5lIEtWTV9SRVFVRVNUX05SCQkoS1ZNX1JFUVVFU1RfQVJDSF9CQVNFICsgS1ZNX1JFUVVF
U1RfQVJDSF9OUikNCj4gDQo+IAl1bnNpZ25lZCBsb25nIHJlcXVlc3RzW0JJVFNfVE9fTE9OR1Mo
TlJfS1ZNX1JFUVVFU1RTKV07DQo+IA0KPiA+IA0KPiA+ICAJdW5zaWduZWQgbG9uZyBndWVzdF9k
ZWJ1ZzsNCj4gPiAgDQo+ID4gIAlpbnQgcHJlX3BjcHU7DQo+ID4gQEAgLTExMjIsNyArMTEyMiw3
IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBrdm1fbWFrZV9yZXF1ZXN0KGludCByZXEsIHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSkNCj4gPiAgCSAqIGNhbGxlci4gIFBhaXJlZCB3aXRoIHRoZSBzbXBfbWJf
X2FmdGVyX2F0b21pYyBpbiBrdm1fY2hlY2tfcmVxdWVzdC4NCj4gPiAgCSAqLw0KPiA+ICAJc21w
X3dtYigpOw0KPiA+IC0Jc2V0X2JpdChyZXEgJiBLVk1fUkVRVUVTVF9NQVNLLCAmdmNwdS0+cmVx
dWVzdHMpOw0KPiA+ICsJc2V0X2JpdChyZXEgJiBLVk1fUkVRVUVTVF9NQVNLLCAodm9pZCAqKSZ2
Y3B1LT5yZXF1ZXN0cyk7DQo+IA0KPiAuLi4gd2hpY2ggd291bGRuJ3QgcmVxdWlyZSBhIHZvaWQg
Y2FzdCB0byBtYWtlIHRoZSBiaXQgQVBJIGZ1bmN0aW9ucw0KPiBoYXBweSAoYXMgdGhlc2UgZXhw
ZWN0IGEgcG9pbnRlciB0byB0aGUgZmlyc3QgdW5zaWduZWQgbG9uZyBpbiB0aGUNCj4gYml0bWFw
KS4NCg0KQWgsIHJpZ2h0ISBHb29kIHBvaW50Lg0KDQpQYW9sbywNCg0KV291bGQgeW91IHByZWZl
ciB0byBzd2l0Y2ggInJlcXVlc3RzIiB0byBhIGJpdG1hcCBhbmTCoA0KdXBkYXRlwqBrdm1fcmVx
dWVzdF9wZW5kaW5nIHRvIGhhbmRsZSB0aGlzPw0KDQo+IA0KPiBUaGFua3MsDQo+IE1hcmsuDQo+
IA0KQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKQmVybGluIC0gRHJlc2Rl
biAtIEFhY2hlbgptYWluIG9mZmljZTogS3JhdXNlbnN0ci4gMzgsIDEwMTE3IEJlcmxpbgpHZXNj
aGFlZnRzZnVlaHJlcjogRHIuIFJhbGYgSGVyYnJpY2gsIENocmlzdGlhbiBTY2hsYWVnZXIKVXN0
LUlEOiBERTI4OTIzNzg3OQpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVy
ZyBIUkIgMTQ5MTczIEIK

