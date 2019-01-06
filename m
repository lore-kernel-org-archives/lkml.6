Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAB1C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 20:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED48520859
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 20:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="EZ3Mzm64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbfAFUOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 15:14:14 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:41799 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfAFUOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 15:14:14 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1EF3A83640
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jan 2019 09:14:10 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1546805650;
        bh=sauq8Ak0NA/hu0r68YByY7HAbkG0FNhLK81Z2GphIBk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=EZ3Mzm64cLpBA+ZSlnqfFoPaQCbn1Eh1hsjr6Kupdn3XhssAixtAJ15IXXZhCdnFH
         o/dfYZEqwuhkn5XIEf9fWbowo9zqI9Ktea9WaNLdc3M+BeoQ935HEBCtnMCg+4ZP1Q
         8wlntULHEPor6/fN+YAPdt+SurDlGXzsoQAYQGmEA7XRrizz9xPvwU9JeI3VxSTXAL
         oUn5JcSkV+ZKihkPGvKrYpwkGSlSebhS2Go6QJHZ49Gq5n5Di/QexNKmaxwIRZ1OH2
         eRgAVpyKUUcnh7lGfyQXmPfWMC+pShqCKufpqUZgyWgbyUpa4lLo+markhDcpXYe3U
         uG/9OqhdNLpOA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c3261920000>; Mon, 07 Jan 2019 09:14:10 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Mon, 7 Jan 2019 09:14:06 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Mon, 7 Jan 2019 09:14:06 +1300
From:   Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
To:     "liujian56@huawei.com" <liujian56@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>
Subject: Re: [PATCH v2] driver: uio: fix possible memory leak and
 use-after-free in __uio_register_device
Thread-Topic: [PATCH v2] driver: uio: fix possible memory leak and
 use-after-free in __uio_register_device
Thread-Index: AQHUo+SOnwOVcfp22Umyw8dsnaIvcKWh1weA
Date:   Sun, 6 Jan 2019 20:14:05 +0000
Message-ID: <1546805645.4217.2.camel@alliedtelesis.co.nz>
References: <1546611548-205765-1-git-send-email-liujian56@huawei.com>
In-Reply-To: <1546611548-205765-1-git-send-email-liujian56@huawei.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:24:3a2c:4aff:fe70:2ab9]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9827FD157999D447B451FE9F55068C54@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTAxLTA0IGF0IDIyOjE5ICswODAwLCBsaXVqaWFuIHdyb3RlOg0KPiAnaWRl
dicgaXMgbWFsbG9jZWQgaW4gX191aW9fcmVnaXN0ZXJfZGV2aWNlKCkgYW5kIGxlYWsgZnJlZSBp
dCBiZWZvcmUNCj4gbGVhdmluZyBmcm9tIHRoZSB1aW9fZ2V0X21pbm9yKCkgZXJyb3IgaGFuZGlu
ZyBjYXNlLCBpdCB3aWxsIGNhdXNlDQo+IG1lbW9yeSBsZWFrLg0KPiANCj4gQWxzbywgaW4gdWlv
X2Rldl9hZGRfYXR0cmlidXRlcygpIGVycm9yIGhhbmRpbmcgY2FzZSwgaWRldiBpcyB1c2VkDQo+
IGFmdGVyDQo+IGRldmljZV91bnJlZ2lzdGVyKCksIGluIHdoaWNoICdpZGV2JyBoYXMgYmVlbiBy
ZWxlYXNlZCwgdG91Y2ggaWRldg0KPiBjYXVzZQ0KPiB1c2UtYWZ0ZXItZnJlZS4NCj4gDQo+IEZp
eGVzOiBhOTNlN2IzMzE1NjggKCJ1aW86IFByZXZlbnQgZGV2aWNlIGRlc3RydWN0aW9uIHdoaWxl
IGZkcyBhcmUNCj4gb3BlbiIpDQo+IEZpeGVzOiBlNjc4OWNkM2RmYjUgKCJ1aW86IFNpbXBsaWZ5
IHVpbyBlcnJvciBwYXRoIGJ5IHVzaW5nIGRldnJlcw0KPiBmdW5jdGlvbnMiKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBsaXVqaWFuIDxsaXVqaWFuNTZAaHVhd2VpLmNvbT4NCj4gLS0tDQo+IHYxLT52MjoN
Cj4gY2hhbmdlIGdpdCBsb2cgYW5kIGZpeCBjb2RlDQo+IA0KPiDCoGRyaXZlcnMvdWlvL3Vpby5j
IHwgMTAgKysrKysrKy0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91aW8vdWlvLmMgYi9kcml2
ZXJzL3Vpby91aW8uYw0KPiBpbmRleCAxMzEzNDIyLi5iZTJhOTQzIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3Vpby91aW8uYw0KPiArKysgYi9kcml2ZXJzL3Vpby91aW8uYw0KPiBAQCAtOTQwLDkg
Kzk0MCwxMiBAQCBpbnQgX191aW9fcmVnaXN0ZXJfZGV2aWNlKHN0cnVjdCBtb2R1bGUgKm93bmVy
LA0KPiDCoAlhdG9taWNfc2V0KCZpZGV2LT5ldmVudCwgMCk7DQo+IMKgDQo+IMKgCXJldCA9IHVp
b19nZXRfbWlub3IoaWRldik7DQo+IC0JaWYgKHJldCkNCj4gKwlpZiAocmV0KSB7DQo+ICsJCWtm
cmVlKGlkZXYpOw0KPiDCoAkJcmV0dXJuIHJldDsNCj4gKwl9DQo+IMKgDQo+ICsJZGV2aWNlX2lu
aXRpYWxpemUoJmlkZXYtPmRldik7DQo+IMKgCWlkZXYtPmRldi5kZXZ0ID0gTUtERVYodWlvX21h
am9yLCBpZGV2LT5taW5vcik7DQo+IMKgCWlkZXYtPmRldi5jbGFzcyA9ICZ1aW9fY2xhc3M7DQo+
IMKgCWlkZXYtPmRldi5wYXJlbnQgPSBwYXJlbnQ7DQo+IEBAIC05NTMsNyArOTU2LDcgQEAgaW50
IF9fdWlvX3JlZ2lzdGVyX2RldmljZShzdHJ1Y3QgbW9kdWxlICpvd25lciwNCj4gwqAJaWYgKHJl
dCkNCj4gwqAJCWdvdG8gZXJyX2RldmljZV9jcmVhdGU7DQo+IMKgDQo+IC0JcmV0ID0gZGV2aWNl
X3JlZ2lzdGVyKCZpZGV2LT5kZXYpOw0KPiArCXJldCA9IGRldmljZV9hZGQoJmlkZXYtPmRldik7
DQo+IMKgCWlmIChyZXQpDQo+IMKgCQlnb3RvIGVycl9kZXZpY2VfY3JlYXRlOw0KPiDCoA0KPiBA
QCAtOTg1LDkgKzk4OCwxMCBAQCBpbnQgX191aW9fcmVnaXN0ZXJfZGV2aWNlKHN0cnVjdCBtb2R1
bGUgKm93bmVyLA0KPiDCoGVycl9yZXF1ZXN0X2lycToNCj4gwqAJdWlvX2Rldl9kZWxfYXR0cmli
dXRlcyhpZGV2KTsNCj4gwqBlcnJfdWlvX2Rldl9hZGRfYXR0cmlidXRlczoNCj4gLQlkZXZpY2Vf
dW5yZWdpc3RlcigmaWRldi0+ZGV2KTsNCj4gKwlkZXZpY2VfZGVsKCZpZGV2LT5kZXYpOw0KPiDC
oGVycl9kZXZpY2VfY3JlYXRlOg0KPiDCoAl1aW9fZnJlZV9taW5vcihpZGV2KTsNCj4gKwlwdXRf
ZGV2aWNlKCZpZGV2LT5kZXYpOw0KPiDCoAlyZXR1cm4gcmV0Ow0KPiDCoH0NCj4gwqBFWFBPUlRf
U1lNQk9MX0dQTChfX3Vpb19yZWdpc3Rlcl9kZXZpY2UpOw0KDQpMb29rcyBnb29kIHRvIG1lLiBU
aGFua3MgZm9yIGRlYWxpbmcgd2l0aCB0aG9zZSBpc3N1ZXMuDQpSZXZpZXdlZC1ieTogSGFtaXNo
IE1hcnRpbiA8aGFtaXNoLm1hcnRpbkBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0K
