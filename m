Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A64C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C80A20831
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Yiho4tRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C80A20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeKASIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:08:24 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:50623 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeKASIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1541063177; x=1572599177;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=1nRPoFpOYCzTFwBrou8QUupKQZCKEmcLig5wcvHDfy4=;
  b=Yiho4tRIXyvv0yWh2W9eSD+gvZrI9p847r1B+HSoip7SE02o7dRucudm
   A9webaKNw3mGl2MhCVrBEaYxLHbg6HkpxZbV1TBA/hsT3BAw89cN8k4g3
   BoFmudD1Vt6xzhSFF6cO0OQn9yJt+SDPCN9uYbwlATDZBzZY1RJCGroi9
   g=;
X-IronPort-AV: E=Sophos;i="5.54,451,1534809600"; 
   d="scan'208";a="366181535"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Nov 2018 09:06:15 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id wA196Dfu068957
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 1 Nov 2018 09:06:14 GMT
Received: from EX13D08EUC003.ant.amazon.com (10.43.164.232) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Nov 2018 09:06:13 +0000
Received: from EX13D18EUC002.ant.amazon.com (10.43.164.50) by
 EX13D08EUC003.ant.amazon.com (10.43.164.232) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Nov 2018 09:06:13 +0000
Received: from EX13D18EUC002.ant.amazon.com ([10.43.164.50]) by
 EX13D18EUC002.ant.amazon.com ([10.43.164.50]) with mapi id 15.00.1367.000;
 Thu, 1 Nov 2018 09:06:13 +0000
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
Thread-Index: AQHUcJu/T1oGSJ7npE6IhxEAy6raE6U5FeWAgAF7l4CAABGRAA==
Date:   Thu, 1 Nov 2018 09:06:12 +0000
Message-ID: <1541063172.6429.77.camel@amazon.com>
References: <20181030215739.4557-1-mheyne@amazon.de>
         <1540977883.6429.74.camel@amazon.com>
         <38013dfb-f0af-bdc1-3547-c53ff6ecd58e@amazon.de>
In-Reply-To: <38013dfb-f0af-bdc1-3547-c53ff6ecd58e@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.231]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D5CFC33E3E70546A0586CCD66AA7F64@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBEbywgMjAxOC0xMS0wMSBhdCAwOTowMyArMDEwMCwgTWF4aW1pbGlhbiBIZXluZSB3cm90
ZToNCj4gT24gMTAvMzEvMTggMTA6MjQgQU0sIFNoYWgsIEFtaXQgd3JvdGU6DQo+ID4gDQo+ID4g
T24gRGksIDIwMTgtMTAtMzAgYXQgMjE6NTcgKzAwMDAsIE1heGltaWxpYW4gSGV5bmUgd3JvdGU6
DQo+ID4gPiANCj4gPiA+IFsuLi5dDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9kaXJl
Y3QtaW8uYyBiL2ZzL2RpcmVjdC1pby5jDQo+ID4gPiBpbmRleCAwOTNmYjU0Y2QzMTYuLjE5OTE0
NjAzNjA5MyAxMDA2NDQNCj4gPiA+IC0tLSBhL2ZzL2RpcmVjdC1pby5jDQo+ID4gPiArKysgYi9m
cy9kaXJlY3QtaW8uYw0KPiA+ID4gQEAgLTMyNSw4ICszMjUsOCBAQCBzdGF0aWMgc3NpemVfdCBk
aW9fY29tcGxldGUoc3RydWN0IGRpbyAqZGlvLCBzc2l6ZV90IHJldCwgdW5zaWduZWQgaW50IGZs
YWdzKQ0KPiA+ID4gwqDCoAkJwqAqLw0KPiA+ID4gwqDCoAkJZGlvLT5pb2NiLT5raV9wb3MgKz0g
dHJhbnNmZXJyZWQ7DQo+ID4gPiDCoMKgDQo+ID4gPiAtCQlpZiAoZGlvLT5vcCA9PSBSRVFfT1Bf
V1JJVEUpDQo+ID4gPiAtCQkJcmV0ID0gZ2VuZXJpY193cml0ZV9zeW5jKGRpby0+aW9jYizCoMKg
dHJhbnNmZXJyZWQpOw0KPiA+ID4gKwkJaWYgKHJldCA+IDAgJiYgZGlvLT5vcCA9PSBSRVFfT1Bf
V1JJVEUpDQo+ID4gPiArCQkJcmV0ID0gZ2VuZXJpY193cml0ZV9zeW5jKGRpby0+aW9jYiwgcmV0
KTsNCj4gPiBJcyB0aGUgcy90cmFuc2ZlcnJlZC9yZXQvIGNoYW5nZSBuZWNlc3Nhcnk/IMKgTmVl
ZHMgZXhwbGFpbmluZywgYXQgbGVhc3QuDQo+IEluIGFuIGFib3ZlIGNvZGUgbGluZSBgcmV0YCBp
cyBzZXQgdG8gYHRyYW5zZmVycmVkYC4gU28gdGhlIGNoYW5nZSBpcw0KPiBhIG5vIG9wLiBIb3dl
dmVyLCBpbiBteSBvcGluaW9uIHRoZSBjb25zdHJ1Y3QgdGhlbiBsb29rcyBjbGVhbmVyLg0KDQpZ
ZXMsIG1ha2VzIGl0IGFsc28gaW4gbGluZSB3aXRoIHRoZSBvdGhlciBjYWxsZXJzLCBzbyB0aGlz
IGlzIGdvb2QsIHRoYW5rcy4KCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdt
YkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocmVyOiBDaHJpc3Rp
YW4gU2NobGFlZ2VyLCBSYWxmIEhlcmJyaWNoClVzdC1JRDogREUgMjg5IDIzNyA4NzkKRWluZ2V0
cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgSFJCIDE0OTE3MyBCCgo=

