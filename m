Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07346C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4C820821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="mbdZPZwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4C820821
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeJaSWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:22:07 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:19083 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeJaSWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540977887; x=1572513887;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=h2XUroPz2iYXI0zbI6L7gAOuXJw15Vr57FoAADpHtkc=;
  b=mbdZPZwAX32QGK6KXrA2P8nSqTQqd8dd1EYWO/JRkbyIUgCyJv2IWUzD
   lod4vIhngRLP/SFo5klhZekHivZcrbhJE/TisivmQUGy+M5x6QeCyLWYf
   B2W73fwXyfAT9TedU3RfSQeASrxK78tqxyOUHL4dKUnGJRgcGzf9eyoOh
   g=;
X-IronPort-AV: E=Sophos;i="5.54,447,1534809600"; 
   d="scan'208";a="365938197"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Oct 2018 09:24:45 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9V9OeU6052104
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 31 Oct 2018 09:24:44 GMT
Received: from EX13D08EUC004.ant.amazon.com (10.43.164.176) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 31 Oct 2018 09:24:44 +0000
Received: from EX13D18EUC002.ant.amazon.com (10.43.164.50) by
 EX13D08EUC004.ant.amazon.com (10.43.164.176) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 31 Oct 2018 09:24:43 +0000
Received: from EX13D18EUC002.ant.amazon.com ([10.43.164.50]) by
 EX13D18EUC002.ant.amazon.com ([10.43.164.50]) with mapi id 15.00.1367.000;
 Wed, 31 Oct 2018 09:24:43 +0000
From:   "Shah, Amit" <aams@amazon.de>
To:     "Heyne, Maximilian" <mheyne@amazon.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>, "hch@lst.de" <hch@lst.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Dannowski, Uwe" <uwed@amazon.de>,
        "Mehlan, Torsten" <tomeh@amazon.de>
Subject: Re: [PATCH] fs: fix lost error code in dio_complete
Thread-Topic: [PATCH] fs: fix lost error code in dio_complete
Thread-Index: AQHUcJu/T1oGSJ7npE6IhxEAy6raE6U5FeWA
Date:   Wed, 31 Oct 2018 09:24:43 +0000
Message-ID: <1540977883.6429.74.camel@amazon.com>
References: <20181030215739.4557-1-mheyne@amazon.de>
In-Reply-To: <20181030215739.4557-1-mheyne@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.231]
Content-Type: text/plain; charset="utf-8"
Content-ID: <349323C0013D7842B5B361F149F7BD06@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRGksIDIwMTgtMTAtMzAgYXQgMjE6NTcgKzAwMDAsIE1heGltaWxpYW4gSGV5bmUgd3JvdGU6
DQo+IGNvbW1pdCBlMjU5MjIxNzYzYTQwNDAzZDViYjIzMjIwOTk5OGU4YzQ1ODA0YWI4ICgiZnM6
IHNpbXBsaWZ5IHRoZQ0KPiBnZW5lcmljX3dyaXRlX3N5bmMgcHJvdG90eXBlIikgcmV3b3JrZWQg
Y2FsbGVycyBvZiBnZW5lcmljX3dyaXRlX3N5bmMoKSwNCj4gYW5kIGVuZGVkIHVwIGRyb3BwaW5n
IHRoZSBlcnJvciByZXR1cm4gZm9yIHRoZSBkaXJlY3RpbyBwYXRoLiBQcmlvciB0bw0KPiB0aGF0
IGNvbW1pdCwgaW4gZGlvX2NvbXBsZXRlKCksIGFuIGVycm9yIHdvdWxkIGJlIGJ1YmJsZWQgdXAg
dGhlIHN0YWNrLA0KPiBidXQgYWZ0ZXIgdGhhdCBjb21taXQsIGVycm9ycyBwYXNzZWQgb24gdG8g
ZGlvX2NvbXBsZXRlIHdlcmUgZWF0ZW4gdXAuDQo+IA0KPiBUaGlzIHdhcyByZXBvcnRlZCBvbiB0
aGUgbGlzdCBlYXJsaWVyLCBhbmQgYSBmaXggd2FzIHByb3Bvc2VkIGluDQo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvMjAxNjA5MjExNDE1MzkuR0ExNzg5OEBpbmZyYWRlYWQub3JnLywg
YnV0DQo+IG5ldmVyIGZvbGxvd2VkIHVwIHdpdGguwqDCoFdlIHJlY2VudGx5IGhpdCB0aGlzIGJ1
ZyBpbiBvdXIgdGVzdGluZyB3aGVyZQ0KPiBmZW5jaW5nIGlvIGVycm9ycywgd2hpY2ggd2VyZSBw
cmV2aW91c2x5IGVycm9yaW5nIG91dCB3aXRoIEVJTywgd2VyZQ0KPiBiZWluZyByZXR1cm5lZCBh
cyBzdWNjZXNzIG9wZXJhdGlvbnMgYWZ0ZXIgdGhpcyBjb21taXQuDQo+IA0KPiBUaGUgZml4IHBy
b3Bvc2VkIG9uIHRoZSBsaXN0IGVhcmxpZXIgd2FzIGEgbGl0dGxlIHNob3J0IC0tIGl0IHdvdWxk
IGhhdmUNCj4gc3RpbGwgY2FsbGVkIGdlbmVyaWNfd3JpdGVfc3luYygpIGluIGNhc2UgYHJldGAg
YWxyZWFkeSBjb250YWluZWQgYW4NCj4gZXJyb3IuwqDCoFRoaXMgZml4IGVuc3VyZXMgZ2VuZXJp
Y193cml0ZV9zeW5jKCkgaXMgb25seSBjYWxsZWQgd2hlbg0KPiB0aGVyZSdzIG5vIHBlbmRpbmcg
ZXJyb3IgaW4gdGhlIHdyaXRlLg0KPiANCj4gQ0M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
UmVwb3J0ZWQtYnk6IFJhdmkgTmFua2FuaSA8cm5hbmthbmlAYW1hem9uLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogTWF4aW1pbGlhbiBIZXluZSA8bWhleW5lQGFtYXpvbi5kZT4NCj4gU2lnbmVkLW9m
Zi1ieTogVG9yc3RlbiBNZWhsYW4gPHRvbWVoQGFtYXpvbi5kZT4NCj4gU2lnbmVkLW9mZi1ieTog
VXdlIERhbm5vd3NraSA8dXdlZEBhbWF6b24uZGU+DQo+IFNpZ25lZC1vZmYtYnk6IEFtaXQgU2hh
aCA8YWFtc0BhbWF6b24uZGU+DQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIFdvb2Rob3VzZSA8ZHdt
d0BhbWF6b24uY28udWs+DQo+IC0tLQ0KPiDCoGZzL2RpcmVjdC1pby5jIHwgNCArKy0tDQo+IMKg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9mcy9kaXJlY3QtaW8uYyBiL2ZzL2RpcmVjdC1pby5jDQo+IGluZGV4IDA5M2Zi
NTRjZDMxNi4uMTk5MTQ2MDM2MDkzIDEwMDY0NA0KPiAtLS0gYS9mcy9kaXJlY3QtaW8uYw0KPiAr
KysgYi9mcy9kaXJlY3QtaW8uYw0KPiBAQCAtMzI1LDggKzMyNSw4IEBAIHN0YXRpYyBzc2l6ZV90
IGRpb19jb21wbGV0ZShzdHJ1Y3QgZGlvICpkaW8sIHNzaXplX3QgcmV0LCB1bnNpZ25lZCBpbnQg
ZmxhZ3MpDQo+IMKgCQnCoCovDQo+IMKgCQlkaW8tPmlvY2ItPmtpX3BvcyArPSB0cmFuc2ZlcnJl
ZDsNCj4gwqANCj4gLQkJaWYgKGRpby0+b3AgPT0gUkVRX09QX1dSSVRFKQ0KPiAtCQkJcmV0ID0g
Z2VuZXJpY193cml0ZV9zeW5jKGRpby0+aW9jYizCoMKgdHJhbnNmZXJyZWQpOw0KPiArCQlpZiAo
cmV0ID4gMCAmJiBkaW8tPm9wID09IFJFUV9PUF9XUklURSkNCj4gKwkJCXJldCA9IGdlbmVyaWNf
d3JpdGVfc3luYyhkaW8tPmlvY2IsIHJldCk7DQoNCklzIHRoZSBzL3RyYW5zZmVycmVkL3JldC8g
Y2hhbmdlIG5lY2Vzc2FyeT8gwqBOZWVkcyBleHBsYWluaW5nLCBhdCBsZWFzdC4NCg0KPiDCoAkJ
ZGlvLT5pb2NiLT5raV9jb21wbGV0ZShkaW8tPmlvY2IsIHJldCwgMCk7DQo+IMKgCX0NCj4gwqAN
Cg0KVGhhbmtzLA0KDQoNCg0KCQkJCUFtaXQKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJt
YW55IEdtYkgKQmVybGluIC0gRHJlc2RlbiAtIEFhY2hlbgptYWluIG9mZmljZTogS3JhdXNlbnN0
ci4gMzgsIDEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJlcjogRHIuIFJhbGYgSGVyYnJpY2gs
IENocmlzdGlhbiBTY2hsYWVnZXIKVXN0LUlEOiBERTI4OTIzNzg3OQpFaW5nZXRyYWdlbiBhbSBB
bXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyBIUkIgMTQ5MTczIEIK

