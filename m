Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E0DC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5431323F0D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="0YTZTxG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5431323F0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753921AbeGFDbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 23:31:32 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:34629 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753787AbeGFDbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 23:31:31 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4367284482
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jul 2018 15:31:28 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1530847888;
        bh=qkRrI1gd2MXnpU6b5Tey7YVgEJsH4t0usoS3oYNuo+c=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=0YTZTxG+jNtU8ee1QZ/93OMYelXeVtsyRIGDkoQMB9izvH5OURS2Lpr3mUwoqzO3N
         6s0MgKS3cJV7lPr9+L7pwdJwcr7S9J5MD3vfCXeXkKWWsRapd46KXq1QivrqBAshHt
         6ElHMhgjvNPO5Li/xdJujXofwgqMzcXmU+JsoStA=
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b3ee2900001>; Fri, 06 Jul 2018 15:31:28 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Fri, 6 Jul 2018 15:31:28 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Fri, 6 Jul 2018 15:31:28 +1200
From:   Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
To:     "xiubli@redhat.com" <xiubli@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jannh@google.com" <jannh@google.com>,
        "pkalever@redhat.com" <pkalever@redhat.com>,
        "pkarampu@redhat.com" <pkarampu@redhat.com>,
        "atumball@redhat.com" <atumball@redhat.com>,
        "sabose@redhat.com" <sabose@redhat.com>,
        "mchristi@redhat.com" <mchristi@redhat.com>
Subject: Re: [PATCH v3 0/3] uio: fix potential crash bug
Thread-Topic: [PATCH v3 0/3] uio: fix potential crash bug
Thread-Index: AQHUFNUU18qz06FIuEO79sfsnqDqpaSAwMoA
Date:   Fri, 6 Jul 2018 03:31:27 +0000
Message-ID: <0002b0fb-4612-b371-d929-bf64aa877225@alliedtelesis.co.nz>
References: <1530845836-49101-1-git-send-email-xiubli@redhat.com>
In-Reply-To: <1530845836-49101-1-git-send-email-xiubli@redhat.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.16.78]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E15B490B448BD4DBE41CB25267A5170@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWGl1Ym8sDQoNClRoYW5rcyBmb3IgeW91ciBwYXRjaCB0aGF0IGFkZHJlc3NlcyB0aGUgcmVn
cmVzc2lvbiBmb3VuZCB3aXRoIG15IA0KZWFybGllciBjb21taXQuDQoNCkkgd2lsbCB0YWtlIHlv
dXIgY29kZSBhbmQgcnVuIGl0IGluIG91ciBzY2VuYXJpbyB0aGF0IHNob3dlZCB0aGUgYnVnIA0K
dGhhdCBsZWQgdG8gbXkgY29tbWl0LiBVbmZvcnR1bmF0ZWx5IEkgd29uJ3QgYmUgYWJsZSB0byBn
ZXQgdGhhdCBkb25lIA0KdW50aWwgbWlkLW5leHQgd2Vlay4gSSBpbnRlbmQgdG8gcmVwb3J0IGJh
Y2sgdG8geW91IGJ5IEp1bHkgMTN0aC4NCg0KVGhhbmtzLA0KSGFtaXNoIE0NCg0KT24gMDcvMDYv
MjAxOCAwMjo1NyBQTSwgeGl1YmxpQHJlZGhhdC5jb20gd3JvdGU6DQo+IEZyb206IFhpdWJvIExp
IDx4aXVibGlAcmVkaGF0LmNvbT4NCj4NCj4gVGhlIFYyIHBhdGNoIHNldCBtYXliZSBub3QgcG9z
dCBzdWNjZXNzZnVsbHksIHNvIHBvc3QgaXQgYWdhaW4NCj4gd2l0aCBvbmUgbmV3IHVwZGF0aW9u
Lg0KPg0KPiBWMjoNCj4gLSByZXNlbmQgaXQgd2l0aCBzb21lIHNtYWxsIGZpeA0KPg0KPiBWMzoN
Cj4gLSBzd2l0Y2ggdG8gdXNlIHJlcXVlc3RfdGhyZWFkZWRfaXJxDQo+DQo+DQo+IFhpdWJvIExp
ICgzKToNCj4gICAgdWlvOiB1c2UgcmVxdWVzdF90aHJlYWRlZF9pcnEgaW5zdGVhZA0KPiAgICB1
aW86IGNoYW5nZSB0byB1c2UgdGhlIG11dGV4IGxvY2sgaW5zdGVhZCBvZiB0aGUgc3BpbiBsb2Nr
DQo+ICAgIHVpbzogZml4IGNyYXNoIGFmdGVyIHRoZSBkZXZpY2UgaXMgdW5yZWdpc3RlcmVkDQo+
DQo+ICAgZHJpdmVycy91aW8vdWlvLmMgICAgICAgICAgfCAxNTEgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ICAgaW5jbHVkZS9saW51eC91aW9fZHJpdmVy
LmggfCAgIDIgKy0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDExNSBpbnNlcnRpb25zKCspLCAzOCBk
ZWxldGlvbnMoLSkNCj4NCg==
