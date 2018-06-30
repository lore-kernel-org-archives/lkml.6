Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A91C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 08:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF2325551
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 08:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="T+qzcO7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF2325551
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932286AbeF3IK0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 04:10:26 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:61441 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754120AbeF3IKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 04:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1530346216; x=1561882216;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=X/ItfpMiadIhFinZYiC1tO6DPvRfVJuNfso5arKLPYA=;
  b=T+qzcO7vzF4WKFtUa5qiouHpAoAWw+Ha6lePa+2HYZ6Y3ygxzl3pI5+u
   5wa90qt8CWTIm5CVfgWIE+49JPTnSCkAqIjcs05FEQwffHRW4q5F90yW0
   NbQmBOWeT9X6dGwcnvX0UTGbLctZpGtf3VY07wDq/F9X4IQFy772rcb+U
   s=;
X-IronPort-AV: E=Sophos;i="5.51,289,1526342400"; 
   d="scan'208";a="620246244"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jun 2018 08:09:30 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5U89NsR030044
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sat, 30 Jun 2018 08:09:26 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sat, 30 Jun 2018 08:09:25 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sat, 30 Jun 2018 08:09:24 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Sat, 30 Jun 2018 08:09:24 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "jmattson@google.com" <jmattson@google.com>,
        "dvyukov@google.com" <dvyukov@google.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "syzbot+cc483201a3c6436d3550@syzkaller.appspotmail.com" 
        <syzbot+cc483201a3c6436d3550@syzkaller.appspotmail.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: general protection fault in vmx_vcpu_run
Thread-Topic: general protection fault in vmx_vcpu_run
Thread-Index: AQHT0kMOKBaNvmqL6U+Yo+BVcYCPj6P/dUQAgHYnjICAAMa/AIACizmA
Date:   Sat, 30 Jun 2018 08:09:23 +0000
Message-ID: <1530346163.13559.75.camel@amazon.de>
References: <883d24f79ad8fd475f0569a39ba6@google.com>
         <00000000000037b58a0569c49b70@google.com>
         <CACT4Y+bnUNtn3jO5fYMB5dSqA=vbc8KfnTmbajA6SYKex4KFoQ@mail.gmail.com>
         <CALMp9eSDP3XRMU-ZvSPRqgyQrtOCajz90HyQ8GM7Mg2oNuBAHw@mail.gmail.com>
In-Reply-To: <CALMp9eSDP3XRMU-ZvSPRqgyQrtOCajz90HyQ8GM7Mg2oNuBAHw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.144]
Content-Type: text/plain; charset="utf-8"
Content-ID: <987F2B552700854A8AA79D3F4F433B61@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TG9va2luZyBhbHNvIGF0IHRoZSBvdGhlciBjcmFzaCBbMF06DQoNCsKgIMKgIMKgIMKgIG1zcl9i
aXRtYXAgPSB0b192bXgodmNwdSktPmxvYWRlZF92bWNzLT5tc3JfYml0bWFwOw0KZmZmZmZmZmY4
MTFmNjViNzrCoMKgwqDCoMKgwqDCoGU4IDQ0IGNiIDU3IDAwwqDCoMKgwqDCoMKgwqDCoMKgwqBj
YWxsccKgwqBmZmZmZmZmZjgxNzczMTAwDQo8X19zYW5pdGl6ZXJfY292X3RyYWNlX3BjPg0KZmZm
ZmZmZmY4MTFmNjViYzrCoMKgwqDCoMKgwqDCoDQ4IDhiIDU0IDI0IDA4wqDCoMKgwqDCoMKgwqDC
oMKgwqBtb3bCoMKgwqDCoDB4OCglcnNwKSwlcmR4DQpmZmZmZmZmZjgxMWY2NWMxOsKgwqDCoMKg
wqDCoMKgNDggYjggMDAgMDAgMDAgMDAgMDDCoMKgwqDCoG1vdmFicw0KJDB4ZGZmZmZjMDAwMDAw
MDAwMCwlcmF4DQpmZmZmZmZmZjgxMWY2NWM4OsKgwqDCoMKgwqDCoMKgZmMgZmYgZGYNCmZmZmZm
ZmZmODExZjY1Y2I6wqDCoMKgwqDCoMKgwqA0OCBjMSBlYSAwM8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgc2hywqDCoMKgwqAkMHgzLCVyZHgNCmZmZmZmZmZmODExZjY1Y2Y6wqDCoMKgwqDCoMKg
wqA4MCAzYyAwMg0KMDDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNtcGLCoMKgwqAkMHgwLCgl
cmR4LCVyYXgsMSkgwqAgwqAgwqAgwqA8LSBmYXVsdCBoZXJlLg0KZmZmZmZmZmY4MTFmNjVkMzrC
oMKgwqDCoMKgwqDCoDBmIDg1IDM2IDE5IDAwIDAwwqDCoMKgwqDCoMKgwqBqbmXCoMKgwqDCoGZm
ZmZmZmZmODExZjdmMGYNCjx2bXhfdmNwdV9ydW4rMHgyMzZmPg0KDQolcmR4IHNob3VsZCBjb250
YWluIGEgcG9pbnRlciB0byBsb2FkZWRfdm1jcy4gSXQgaXMgZGlyZWN0bHkgbG9hZGVkwqANCmZy
b20gdGhlIHN0YWNrIFsweDgoJXJzcCldLiBUaGlzIHNhbWUgc3RhY2sgbG9jYXRpb24gd2FzIGp1
c3QgdXNlZMKgDQpiZWZvcmUgdGhlIGlubGluZWQgYXNzZW1ibHkgZm9yIFZNUkVTVU1FL1ZNTEFV
TkNIIGhlcmU6DQoNCsKgIMKgIMKgIMKgIHZteC0+X19sYXVuY2hlZCA9IHZteC0+bG9hZGVkX3Zt
Y3MtPmxhdW5jaGVkOw0KZmZmZmZmZmY4MTFmNjM5ZjrCoMKgwqDCoMKgwqDCoGU4IDVjIGNkIDU3
IDAwwqDCoMKgwqDCoMKgwqDCoMKgwqBjYWxsccKgwqBmZmZmZmZmZjgxNzczMTAwDQo8X19zYW5p
dGl6ZXJfY292X3RyYWNlX3BjPg0KZmZmZmZmZmY4MTFmNjNhNDrCoMKgwqDCoMKgwqDCoDQ4IDhi
IDU0IDI0IDA4wqDCoMKgwqDCoMKgwqDCoMKgwqBtb3bCoMKgwqDCoDB4OCglcnNwKSwlcmR4DQpm
ZmZmZmZmZjgxMWY2M2E5OsKgwqDCoMKgwqDCoMKgNDggYjggMDAgMDAgMDAgMDAgMDDCoMKgwqDC
oG1vdmFicw0KJDB4ZGZmZmZjMDAwMDAwMDAwMCwlcmF4DQpmZmZmZmZmZjgxMWY2M2IwOsKgwqDC
oMKgwqDCoMKgZmMgZmYgZGYNCmZmZmZmZmZmODExZjYzYjM6wqDCoMKgwqDCoMKgwqA0OCBjMSBl
YSAwM8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2hywqDCoMKgwqAkMHgzLCVyZHgNCmZmZmZm
ZmZmODExZjYzYjc6wqDCoMKgwqDCoMKgwqA4MCAzYyAwMg0KMDDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGNtcGLCoMKgwqAkMHgwLCglcmR4LCVyYXgsMSkgwqAgwqAgwqAgwqA8LSB1c2VkIGhl
cmUuDQoNCi4uLiBhbmQgdGhpcyBzdGFjayBsb2NhdGlvbiB3YXMgbmV2ZXIgdG91Y2hlZCBieSBh
bnl0aGluZyBpbiBiZXR3ZWVuIcKgDQpTbyBzb21ldGhpbmcgbXVzdCBoYXZlIGNvcnJ1cHRlZCB0
aGUgc3RhY2sgaXRzZWxmIG5vdCByZWFsbHkgdGhlwqANCmt2bV92Yw0KcHUgc3RydWN0Lg0KDQpP
YnZpb3VzbHkgdGhlIGlubGluZWQgYXNzZW1ibHkgYmxvY2sgaXMgdXNpbmcgdGhlIHN0YWNrIGFz
IHdlbGwsIGJ1dCBJwqANCmNhbiBub3Qgc2VlIGFueXRoaW5nIHRoYXQgd291bGQgY2F1c2UgdGhp
cyBjb3JydXB0aW9uIHRoZXJlLg0KDQpUaGF0IGJlaW5nIHNhaWQsIGxvb2tpbmcgYXQgdGhlICVy
c3AgYW5kICVyYnAgdmFsdWVzIHRoYXQgYXJlIGR1bXBlZA0KaW4gdGhlIHN0YWNrIHRyYWNlOg0K
DQpSU1A6IGZmZmY4ODAxYjdkN2YzODANClJCUDogZmZmZjg4MDFiODI2MDE0MA0KDQouLi4gdGhl
eSBhcmUgYWxtb3N0IDQuOCBNaUIgYXBhcnQhIFNob3VsZCBub3QgdGhlc2UgdHdvIHJlZ2lzdGVy
IGJlIGHCoA0KYml0IGNsb3NlciB0byBlYWNoIG90aGVyPyA6KQ0KDQpTbyAyIHBvc3NpYmlsaXRp
ZXMgaGVyZToNCg0KMS0gJXJzcCBpcyB3cm9uZw0KDQpUaGF0IHdvdWxkIGV4cGxhaW4gd2h5IHRo
ZSBsb2FkZWRfdm1jcyB3YXMgTlVMTC4gSG93ZXZlciwgaXQgaXMgYSBiaXTCoA0KaGFyZGVyIHRv
IHVuZGVyc3RhbmQgaG93IGl0IGJlY2FtZSB3cm9uZyEgSXQgc2hvdWxkIGhhdmUgYmVlbiByZXN0
b3JlZMKgDQpkdXJpbmcgdGhlIFZNRVhJVCBmcm9tIHRoZSBIT1NUX1JTUCB2YWx1ZSBpbiB0aGUg
Vk1DUyENCg0KSXMgdGhpcyBhIG5lc3RlZCBzZXR1cD8NCg0KMi0gJXJicCBpcyB3cm9uZw0KDQpU
aGF0IHdvdWxkIGFsc28gZXhwbGFpbiB3aHkgdGhlIGxvYWRlZF92bWNzIHdhcyBOVUxMLiBXaGF0
ZXZlcg0KY29ycnVwdGVkIHRoZSBzdGFjayB0aGF0IGNhdXNlZCBsb2FkZWRfdm1jcyB0byBiZSBO
VUxMIGNvdWxkIGhhdmUgYWxzbw0KY29ycnVwdGVkIHRoZSAlcmJwIHNhdmVkIGluIHRoZSBzdGFj
ay4gVGhhdCB3b3VsZCBtZWFuIHRoYXQgaXQgaGFwcGVuZWQNCmR1cmluZyBhIGZ1bmN0aW9uIGNh
bGwuIEFsbCBmdW5jdGlvbiBjYWxscyB0aGF0IGhhcHBlbmVkIGJldHdlZW4gdGhlDQpwb2ludCB3
aGVuIHRoZSBzdGFjayB3YXMgc2FuZSAoanVzdCBiZWZvcmUgdGhlICJhc20iIGJsb2NrIGZvcg0K
Vk1MQVVOQ0gpIGFuZCB0aGUgY3Jhc2gtc2l0ZSBhcmUgb25seSBrY292IHJlbGF0ZWQuIExvb2tp
bmcgYXQga2NvdiwgSQ0KY2FuIG5vdCBzZWUgd2hlcmUgdGhlIHN0YWNrIHdvdWxkIGdldCBjb3Jy
dXB0ZWQgdGhvdWdoISBPYnZpb3VzbHkNCmFub3RoZXIgc291cmNlIG9mIGNvcnJ1cHRpb24gY2Fu
IGJlIGEgY29tcGxldGVseSB1bnJlbGF0ZWQgdGhyZWFkDQpkaXJlY3RseSBjb3JydXB0aW9uIHRo
aXMgdGhyZWFkJ3PCoG1lbW9yeS4NCg0KTWF5YmUgaXQgd291bGQgYmUgZWFzaWVyIHRvIGp1c3Qg
dHJ5IHRvIHJlcHJvIGl0IGZpcnN0IGFuZCBzZWUgd2hpY2jCoA0Kb25lIGlzIHRydWUgKGlmIGF0
IGFsbCkuDQoNClswXcKgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPWNj
NDgzMjAxYTNjNjQzNmQzNTUwDQoNCg0KT24gVGh1LCAyMDE4LTA2LTI4IGF0IDEwOjE4IC0wNzAw
LCBKaW0gTWF0dHNvbiB3cm90ZToNCj4gICAyMjogMGYgMDEgYzMgICAgICAgICAgICAgIHZtcmVz
dW1lDQo+ICAgMjU6IDQ4IDg5IDRjIDI0IDA4ICAgICAgICBtb3YgICAgJXJjeCwweDgoJXJzcCkN
Cj4gICAyYTogNTkgICAgICAgICAgICAgICAgICAgIHBvcCAgICAlcmN4DQo+IA0KPiA8cmlwPjoN
Cj4gICAyYjogMGYgOTYgODEgODggNTYgMDAgMDAgc2V0YmUgIDB4NTY4OCglcmN4KQ0KPiAgIDMy
OiA0OCA4OSA4MSAwMCAwMyAwMCAwMCBtb3YgICAgJXJheCwweDMwMCglcmN4KQ0KPiAgIDM5OiA0
OCA4OSA5OSAxOCAwMyAwMCAwMCBtb3YgICAgJXJieCwweDMxOCglcmN4KQ0KPiANCj4gJXJjeCBz
aG91bGQgYmUgcG9pbnRpbmcgdG8gdGhlIHZjcHVfdm14IHN0cnVjdHVyZSwgYnV0IGl0J3Mgbm90
IGV2ZW4NCj4gY2Fub25pY2FsOiAxZmZmZjEwMDM1ODQyZTc4Lg0KPiANCkFtYXpvbiBEZXZlbG9w
bWVudCBDZW50ZXIgR2VybWFueSBHbWJICkJlcmxpbiAtIERyZXNkZW4gLSBBYWNoZW4KbWFpbiBv
ZmZpY2U6IEtyYXVzZW5zdHIuIDM4LCAxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhyZXI6IERy
LiBSYWxmIEhlcmJyaWNoLCBDaHJpc3RpYW4gU2NobGFlZ2VyClVzdC1JRDogREUyODkyMzc4NzkK
RWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgSFJCIDE0OTE3MyBCCg==

