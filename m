Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E62C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D11623E3F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="CqvPdVAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D11623E3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752887AbeGDTb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:31:58 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:33650 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbeGDTb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1530732715; x=1562268715;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=ytzG3JCtrPU5O1kkxbBQqHD8fGfHXiMd68V9XgGHul8=;
  b=CqvPdVApVY8aKmXZyAB31WqqVw2C7ukQvTzy2a+L3k347if23vPGiRTv
   gH5hTw3aJu8H2ZEZdNmDh45HP40fEq4dyswmCdPUFgPr6WMxY7sllLyML
   oFlM1VPckzUVdftObGWtJ0fIL2XQsOYVMyYR1uQ33m2mq8lQftmyZCe0B
   U=;
X-IronPort-AV: E=Sophos;i="5.51,308,1526342400"; 
   d="scan'208";a="741750101"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Jul 2018 19:31:51 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w64JVl10101236
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 4 Jul 2018 19:31:47 GMT
Received: from EX13D01EUB004.ant.amazon.com (10.43.166.180) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Jul 2018 19:31:45 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB004.ant.amazon.com (10.43.166.180) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Jul 2018 19:31:45 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Wed, 4 Jul 2018 19:31:45 +0000
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
Thread-Index: AQHT0kMOKBaNvmqL6U+Yo+BVcYCPj6P/dUQAgHYnjICAAMa/AIACizmAgAcH+QA=
Date:   Wed, 4 Jul 2018 19:31:44 +0000
Message-ID: <1530732704.23804.8.camel@amazon.de>
References: <883d24f79ad8fd475f0569a39ba6@google.com>
         <00000000000037b58a0569c49b70@google.com>
         <CACT4Y+bnUNtn3jO5fYMB5dSqA=vbc8KfnTmbajA6SYKex4KFoQ@mail.gmail.com>
         <CALMp9eSDP3XRMU-ZvSPRqgyQrtOCajz90HyQ8GM7Mg2oNuBAHw@mail.gmail.com>
         <1530346163.13559.75.camel@amazon.de>
In-Reply-To: <1530346163.13559.75.camel@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.31]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2E4E057C574E44EBB68D3BADF71EBA9@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RG1pdHJ5LA0KDQpDYW4geW91IHNoYXJlIHRoZSBob3N0IGtlcm5lbCB2ZXJzaW9uPw0KDQpJIGNh
biBub3QgcmVwcm9kdWNlIGFueSBvZiB0aGVzZSBjcmFzaCBzaWduYXR1cmVzIGFuZCBJIHRoaW5r
IGl0J3PCoA0KcmVhbGx5IGEgbmVzdGVkIHZpcnR1YWxpemF0aW9uIGJ1Zy4gU28gSSB3aWxsIG5l
ZWQgdGhlIGV4YWN0IGhvc3TCoA0Ka2VybmVsIHZlcnNpb24gYXMgd2VsbC4NCg0KSSBhbSBjdXJy
ZW50bHkgZ2V0dGluZyBhbGwgc29ydHMgb2Y6DQoNCiJLVk06IGVudHJ5IGZhaWxlZCwgaGFyZHdh
cmUgZXJyb3IgMHg3Ig0KDQouLi4gaW5zdGVhZCBvZiB0aGUgY3Jhc2ggc2lnbmF0dXJlcyB0aGF0
IHlvdSBhcmUgcG9zdGluZy4NCg0KUmVnYXJkcy4NCg0KT24gU2F0LCAyMDE4LTA2LTMwIGF0IDA4
OjA5ICswMDAwLCBSYXNsYW4sIEthcmltQWxsYWggd3JvdGU6DQo+IExvb2tpbmcgYWxzbyBhdCB0
aGUgb3RoZXIgY3Jhc2ggWzBdOg0KPiANCj4gwqAgwqAgwqAgwqAgbXNyX2JpdG1hcCA9IHRvX3Zt
eCh2Y3B1KS0+bG9hZGVkX3ZtY3MtPm1zcl9iaXRtYXA7DQo+IGZmZmZmZmZmODExZjY1Yjc6wqDC
oMKgwqDCoMKgwqBlOCA0NCBjYiA1NyAwMMKgwqDCoMKgwqDCoMKgwqDCoMKgY2FsbHHCoMKgZmZm
ZmZmZmY4MTc3MzEwMA0KPiA8X19zYW5pdGl6ZXJfY292X3RyYWNlX3BjPg0KPiBmZmZmZmZmZjgx
MWY2NWJjOsKgwqDCoMKgwqDCoMKgNDggOGIgNTQgMjQgMDjCoMKgwqDCoMKgwqDCoMKgwqDCoG1v
dsKgwqDCoMKgMHg4KCVyc3ApLCVyZHgNCj4gZmZmZmZmZmY4MTFmNjVjMTrCoMKgwqDCoMKgwqDC
oDQ4IGI4IDAwIDAwIDAwIDAwIDAwwqDCoMKgwqBtb3ZhYnMNCj4gJDB4ZGZmZmZjMDAwMDAwMDAw
MCwlcmF4DQo+IGZmZmZmZmZmODExZjY1Yzg6wqDCoMKgwqDCoMKgwqBmYyBmZiBkZg0KPiBmZmZm
ZmZmZjgxMWY2NWNiOsKgwqDCoMKgwqDCoMKgNDggYzEgZWEgMDPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHNocsKgwqDCoMKgJDB4MywlcmR4DQo+IGZmZmZmZmZmODExZjY1Y2Y6wqDCoMKgwqDC
oMKgwqA4MCAzYyAwMg0KPiAwMMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY21wYsKgwqDCoCQw
eDAsKCVyZHgsJXJheCwxKSDCoCDCoCDCoCDCoDwtIGZhdWx0IGhlcmUuDQo+IGZmZmZmZmZmODEx
ZjY1ZDM6wqDCoMKgwqDCoMKgwqAwZiA4NSAzNiAxOSAwMCAwMMKgwqDCoMKgwqDCoMKgam5lwqDC
oMKgwqBmZmZmZmZmZjgxMWY3ZjBmDQo+IDx2bXhfdmNwdV9ydW4rMHgyMzZmPg0KPiANCj4gJXJk
eCBzaG91bGQgY29udGFpbiBhIHBvaW50ZXIgdG8gbG9hZGVkX3ZtY3MuIEl0IGlzIGRpcmVjdGx5
IGxvYWRlZMKgDQo+IGZyb20gdGhlIHN0YWNrIFsweDgoJXJzcCldLiBUaGlzIHNhbWUgc3RhY2sg
bG9jYXRpb24gd2FzIGp1c3QgdXNlZMKgDQo+IGJlZm9yZSB0aGUgaW5saW5lZCBhc3NlbWJseSBm
b3IgVk1SRVNVTUUvVk1MQVVOQ0ggaGVyZToNCj4gDQo+IMKgIMKgIMKgIMKgIHZteC0+X19sYXVu
Y2hlZCA9IHZteC0+bG9hZGVkX3ZtY3MtPmxhdW5jaGVkOw0KPiBmZmZmZmZmZjgxMWY2MzlmOsKg
wqDCoMKgwqDCoMKgZTggNWMgY2QgNTcgMDDCoMKgwqDCoMKgwqDCoMKgwqDCoGNhbGxxwqDCoGZm
ZmZmZmZmODE3NzMxMDANCj4gPF9fc2FuaXRpemVyX2Nvdl90cmFjZV9wYz4NCj4gZmZmZmZmZmY4
MTFmNjNhNDrCoMKgwqDCoMKgwqDCoDQ4IDhiIDU0IDI0IDA4wqDCoMKgwqDCoMKgwqDCoMKgwqBt
b3bCoMKgwqDCoDB4OCglcnNwKSwlcmR4DQo+IGZmZmZmZmZmODExZjYzYTk6wqDCoMKgwqDCoMKg
wqA0OCBiOCAwMCAwMCAwMCAwMCAwMMKgwqDCoMKgbW92YWJzDQo+ICQweGRmZmZmYzAwMDAwMDAw
MDAsJXJheA0KPiBmZmZmZmZmZjgxMWY2M2IwOsKgwqDCoMKgwqDCoMKgZmMgZmYgZGYNCj4gZmZm
ZmZmZmY4MTFmNjNiMzrCoMKgwqDCoMKgwqDCoDQ4IGMxIGVhIDAzwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBzaHLCoMKgwqDCoCQweDMsJXJkeA0KPiBmZmZmZmZmZjgxMWY2M2I3OsKgwqDCoMKg
wqDCoMKgODAgM2MgMDINCj4gMDDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNtcGLCoMKgwqAk
MHgwLCglcmR4LCVyYXgsMSkgwqAgwqAgwqAgwqA8LSB1c2VkIGhlcmUuDQo+IA0KPiAuLi4gYW5k
IHRoaXMgc3RhY2sgbG9jYXRpb24gd2FzIG5ldmVyIHRvdWNoZWQgYnkgYW55dGhpbmcgaW4gYmV0
d2VlbiHCoA0KPiBTbyBzb21ldGhpbmcgbXVzdCBoYXZlIGNvcnJ1cHRlZCB0aGUgc3RhY2sgaXRz
ZWxmIG5vdCByZWFsbHkgdGhlwqANCj4ga3ZtX3ZjDQo+IHB1IHN0cnVjdC4NCj4gDQo+IE9idmlv
dXNseSB0aGUgaW5saW5lZCBhc3NlbWJseSBibG9jayBpcyB1c2luZyB0aGUgc3RhY2sgYXMgd2Vs
bCwgYnV0IEnCoA0KPiBjYW4gbm90IHNlZSBhbnl0aGluZyB0aGF0IHdvdWxkIGNhdXNlIHRoaXMg
Y29ycnVwdGlvbiB0aGVyZS4NCj4gDQo+IFRoYXQgYmVpbmcgc2FpZCwgbG9va2luZyBhdCB0aGUg
JXJzcCBhbmQgJXJicCB2YWx1ZXMgdGhhdCBhcmUgZHVtcGVkDQo+IGluIHRoZSBzdGFjayB0cmFj
ZToNCj4gDQo+IFJTUDogZmZmZjg4MDFiN2Q3ZjM4MA0KPiBSQlA6IGZmZmY4ODAxYjgyNjAxNDAN
Cj4gDQo+IC4uLiB0aGV5IGFyZSBhbG1vc3QgNC44IE1pQiBhcGFydCEgU2hvdWxkIG5vdCB0aGVz
ZSB0d28gcmVnaXN0ZXIgYmUgYcKgDQo+IGJpdCBjbG9zZXIgdG8gZWFjaCBvdGhlcj8gOikNCj4g
DQo+IFNvIDIgcG9zc2liaWxpdGllcyBoZXJlOg0KPiANCj4gMS0gJXJzcCBpcyB3cm9uZw0KPiAN
Cj4gVGhhdCB3b3VsZCBleHBsYWluIHdoeSB0aGUgbG9hZGVkX3ZtY3Mgd2FzIE5VTEwuIEhvd2V2
ZXIsIGl0IGlzIGEgYml0wqANCj4gaGFyZGVyIHRvIHVuZGVyc3RhbmQgaG93IGl0IGJlY2FtZSB3
cm9uZyEgSXQgc2hvdWxkIGhhdmUgYmVlbiByZXN0b3JlZMKgDQo+IGR1cmluZyB0aGUgVk1FWElU
IGZyb20gdGhlIEhPU1RfUlNQIHZhbHVlIGluIHRoZSBWTUNTIQ0KPiANCj4gSXMgdGhpcyBhIG5l
c3RlZCBzZXR1cD8NCj4gDQo+IDItICVyYnAgaXMgd3JvbmcNCj4gDQo+IFRoYXQgd291bGQgYWxz
byBleHBsYWluIHdoeSB0aGUgbG9hZGVkX3ZtY3Mgd2FzIE5VTEwuIFdoYXRldmVyDQo+IGNvcnJ1
cHRlZCB0aGUgc3RhY2sgdGhhdCBjYXVzZWQgbG9hZGVkX3ZtY3MgdG8gYmUgTlVMTCBjb3VsZCBo
YXZlIGFsc28NCj4gY29ycnVwdGVkIHRoZSAlcmJwIHNhdmVkIGluIHRoZSBzdGFjay4gVGhhdCB3
b3VsZCBtZWFuIHRoYXQgaXQgaGFwcGVuZWQNCj4gZHVyaW5nIGEgZnVuY3Rpb24gY2FsbC4gQWxs
IGZ1bmN0aW9uIGNhbGxzIHRoYXQgaGFwcGVuZWQgYmV0d2VlbiB0aGUNCj4gcG9pbnQgd2hlbiB0
aGUgc3RhY2sgd2FzIHNhbmUgKGp1c3QgYmVmb3JlIHRoZSAiYXNtIiBibG9jayBmb3INCj4gVk1M
QVVOQ0gpIGFuZCB0aGUgY3Jhc2gtc2l0ZSBhcmUgb25seSBrY292IHJlbGF0ZWQuIExvb2tpbmcg
YXQga2NvdiwgSQ0KPiBjYW4gbm90IHNlZSB3aGVyZSB0aGUgc3RhY2sgd291bGQgZ2V0IGNvcnJ1
cHRlZCB0aG91Z2ghIE9idmlvdXNseQ0KPiBhbm90aGVyIHNvdXJjZSBvZiBjb3JydXB0aW9uIGNh
biBiZSBhIGNvbXBsZXRlbHkgdW5yZWxhdGVkIHRocmVhZA0KPiBkaXJlY3RseSBjb3JydXB0aW9u
IHRoaXMgdGhyZWFkJ3PCoG1lbW9yeS4NCj4gDQo+IE1heWJlIGl0IHdvdWxkIGJlIGVhc2llciB0
byBqdXN0IHRyeSB0byByZXBybyBpdCBmaXJzdCBhbmQgc2VlIHdoaWNowqANCj4gb25lIGlzIHRy
dWUgKGlmIGF0IGFsbCkuDQo+IA0KPiBbMF3CoGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29t
L2J1Zz9leHRpZD1jYzQ4MzIwMWEzYzY0MzZkMzU1MA0KPiANCj4gDQo+IE9uIFRodSwgMjAxOC0w
Ni0yOCBhdCAxMDoxOCAtMDcwMCwgSmltIE1hdHRzb24gd3JvdGU6DQo+ID4gDQo+ID4gICAyMjog
MGYgMDEgYzMgICAgICAgICAgICAgIHZtcmVzdW1lDQo+ID4gICAyNTogNDggODkgNGMgMjQgMDgg
ICAgICAgIG1vdiAgICAlcmN4LDB4OCglcnNwKQ0KPiA+ICAgMmE6IDU5ICAgICAgICAgICAgICAg
ICAgICBwb3AgICAgJXJjeA0KPiA+IA0KPiA+IDxyaXA+Og0KPiA+ICAgMmI6IDBmIDk2IDgxIDg4
IDU2IDAwIDAwIHNldGJlICAweDU2ODgoJXJjeCkNCj4gPiAgIDMyOiA0OCA4OSA4MSAwMCAwMyAw
MCAwMCBtb3YgICAgJXJheCwweDMwMCglcmN4KQ0KPiA+ICAgMzk6IDQ4IDg5IDk5IDE4IDAzIDAw
IDAwIG1vdiAgICAlcmJ4LDB4MzE4KCVyY3gpDQo+ID4gDQo+ID4gJXJjeCBzaG91bGQgYmUgcG9p
bnRpbmcgdG8gdGhlIHZjcHVfdm14IHN0cnVjdHVyZSwgYnV0IGl0J3Mgbm90IGV2ZW4NCj4gPiBj
YW5vbmljYWw6IDFmZmZmMTAwMzU4NDJlNzguDQo+ID4gDQpBbWF6b24gRGV2ZWxvcG1lbnQgQ2Vu
dGVyIEdlcm1hbnkgR21iSApCZXJsaW4gLSBEcmVzZGVuIC0gQWFjaGVuCm1haW4gb2ZmaWNlOiBL
cmF1c2Vuc3RyLiAzOCwgMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocmVyOiBEci4gUmFsZiBI
ZXJicmljaCwgQ2hyaXN0aWFuIFNjaGxhZWdlcgpVc3QtSUQ6IERFMjg5MjM3ODc5CkVpbmdldHJh
Z2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIEhSQiAxNDkxNzMgQgo=

