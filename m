Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E911ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B3B2124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="SHwjSL03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B3B2124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732630AbeGLUqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:46:09 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:46558 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732461AbeGLUqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:46:08 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D82748365B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 08:34:53 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1531427693;
        bh=xRPPUO/Vi3ybWtREwep2+EnAgsvz7vw3WgKZGSxIlFo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=SHwjSL036xKmv0KcQEGFdrS8ggxtCuRKmijxRWnDG7lmuSRuZ2wzQnw41gVEOw/Bo
         8DJOeQtkWftuV1gE682fIwaaRj1awVFal7cBjtiggKuK+ygsmrt8Qnz2YqQ4OUJrBb
         HAXMmcYslI6iLJM4KTSlZ5PJxT8zHRRwuIVj8Y24=
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b47bb6c0001>; Fri, 13 Jul 2018 08:34:52 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Fri, 13 Jul 2018 08:34:53 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Fri, 13 Jul 2018 08:34:53 +1200
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
Subject: Re: [PATCH v4 0/3] uio: fix potential crash bug
Thread-Topic: [PATCH v4 0/3] uio: fix potential crash bug
Thread-Index: AQHUFZcKWb+j+auOh0KSnc6fzl5wqaSLSzOA
Date:   Thu, 12 Jul 2018 20:34:53 +0000
Message-ID: <7c0ae0c9-2af6-c7c3-49b0-24302584a24d@alliedtelesis.co.nz>
References: <1530929139-13652-1-git-send-email-xiubli@redhat.com>
In-Reply-To: <1530929139-13652-1-git-send-email-xiubli@redhat.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.16.78]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3B4080B963C484AA69131A2EA72BF2B@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWGl1Ym8sDQoNClRlc3RlZC1ieTogSGFtaXNoIE1hcnRpbiA8aGFtaXNoLm1hcnRpbkBhbGxp
ZWR0ZWxlc2lzLmNvLm56Pg0KDQpJIHNlZSB0aGVzZSB3ZXJlIGFscmVhZHkgbWVyZ2VkIGludG8g
TGludXMnIHRyZWUgYnV0IEkgd2FudGVkIHRvIGxldCB5b3UgDQprbm93IHRoYXQgSSB0ZXN0ZWQg
djQuMTgtcmM0ICh3aGljaCBjb250YWlucyB0aGVzZSB0aHJlZSBwYXRjaGVzKSBhbmQgDQp0aGUg
aXNzdWUgd2hpY2ggbGVkIHRvIG15IG9yaWdpbmFsIHNlcmllcyBpcyBzdGlsbCBmaXhlZCBhbmQg
dGhpcyBwYXRjaCANCnNlcmllcyBvZiB5b3VycyBoYXMgY2F1c2VkIG5vIHJlZ3Jlc3Npb24gaW4g
b3VyIHNjZW5hcmlvLiBUaGlzIHdhcyANCnRlc3RlZCBvbiBQUEMgNjQgYml0IHN5c3RlbSAoTlhQ
IFQyMDgxKS4NCg0KVGhhbmtzIGZvciByZXNvbHZpbmcgdGhhdC4NCg0KUmVnYXJkcywNCkhhbWlz
aCBNLg0KDQpPbiAwNy8wNy8yMDE4IDAyOjA1IFBNLCB4aXVibGlAcmVkaGF0LmNvbSB3cm90ZToN
Cj4gRnJvbTogWGl1Ym8gTGkgPHhpdWJsaUByZWRoYXQuY29tPg0KPg0KPiBWMjoNCj4gLSByZXNl
bmQgaXQgd2l0aCBzb21lIHNtYWxsIGZpeA0KPg0KPiBWMzoNCj4gLSBzd2l0Y2ggdG8gdXNlIHJl
cXVlc3RfdGhyZWFkZWRfaXJxDQo+DQo+IFY0Og0KPiAtIHJlbW92ZSB1c2VsZXNzIGNoZWNraW5n
IGNvZGUsIFRoYW5rcyBNaWtlLg0KPiAtIFRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHRoZSByZXZpZXcg
ZnJvbSBIYW1pc2ggYW5kIE1pa2UuDQo+DQo+DQo+IFhpdWJvIExpICgzKToNCj4gICAgdWlvOiB1
c2UgcmVxdWVzdF90aHJlYWRlZF9pcnEgaW5zdGVhZA0KPiAgICB1aW86IGNoYW5nZSB0byB1c2Ug
dGhlIG11dGV4IGxvY2sgaW5zdGVhZCBvZiB0aGUgc3BpbiBsb2NrDQo+ICAgIHVpbzogZml4IGNy
YXNoIGFmdGVyIHRoZSBkZXZpY2UgaXMgdW5yZWdpc3RlcmVkDQo+DQo+ICAgZHJpdmVycy91aW8v
dWlvLmMgICAgICAgICAgfCAxMzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tDQo+ICAgaW5jbHVkZS9saW51eC91aW9fZHJpdmVyLmggfCAgIDIgKy0NCj4gICAy
IGZpbGVzIGNoYW5nZWQsIDEwNCBpbnNlcnRpb25zKCspLCAzNyBkZWxldGlvbnMoLSkNCj4NCg==
