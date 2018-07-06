Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073D3C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D7223FEF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="GaSMV0Jd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D7223FEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753954AbeGFDjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 23:39:48 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:34676 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753902AbeGFDjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 23:39:47 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E71768364F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jul 2018 15:39:44 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1530848384;
        bh=OQDl+6vLTioEEakgAQrnZ+xg2Ab2DcJNV8ckCjl6VHM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=GaSMV0JdExQjcZY+fyVxtQfwkDqdy1CGL6pnYmV3KpiwweC2KzWC6pFVIpGTKAZEV
         aNqg7G2LuGzIhTmVdOA2HVe7C0FbxWonx9m//RmwFxoFjQN8KBk8twl6izEi/w7r98
         0eC1jrcu3b405maa8msXzbT61ec7gViTlpYVOTUY=
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b3ee4810000>; Fri, 06 Jul 2018 15:39:45 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Fri, 6 Jul 2018 15:39:40 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Fri, 6 Jul 2018 15:39:40 +1200
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
Subject: Re: [PATCH v3 2/3] uio: change to use the mutex lock instead of the
 spin lock
Thread-Topic: [PATCH v3 2/3] uio: change to use the mutex lock instead of the
 spin lock
Thread-Index: AQHUFNUZvvjA7arb+UynkbW7hv9cxaSAwxQA
Date:   Fri, 6 Jul 2018 03:39:39 +0000
Message-ID: <3d76c395-399a-bb9a-4e22-c3cff81ab6a8@alliedtelesis.co.nz>
References: <1530845836-49101-1-git-send-email-xiubli@redhat.com>
 <1530845836-49101-3-git-send-email-xiubli@redhat.com>
In-Reply-To: <1530845836-49101-3-git-send-email-xiubli@redhat.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.16.78]
Content-Type: text/plain; charset="utf-8"
Content-ID: <32C712ACD8C3264E93A0B712BF3C1FE8@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TG9va3Mgb2sgdG8gbWUuDQoNClJldmlld2VkLWJ5OiBIYW1pc2ggTWFydGluIDxoYW1pc2gubWFy
dGluQGFsbGllZHRlbGVzaXMuY28ubno+DQoNCk9uIDA3LzA2LzIwMTggMDI6NTcgUE0sIHhpdWJs
aUByZWRoYXQuY29tIHdyb3RlOg0KPiBGcm9tOiBYaXVibyBMaSA8eGl1YmxpQHJlZGhhdC5jb20+
DQo+DQo+IFdlIGFyZSBoaXR0aW5nIGEgcmVncmVzc2lvbiB3aXRoIHRoZSBmb2xsb3dpbmcgY29t
bWl0Og0KPg0KPiBjb21taXQgYTkzZTdiMzMxNTY4MjI3NTAwMTg2YTQ2NWZlZTNjMmNiNWRmZmQx
Zg0KPiBBdXRob3I6IEhhbWlzaCBNYXJ0aW4gPGhhbWlzaC5tYXJ0aW5AYWxsaWVkdGVsZXNpcy5j
by5uej4NCj4gRGF0ZTogICBNb24gTWF5IDE0IDEzOjMyOjIzIDIwMTggKzEyMDANCj4NCj4gICAg
ICB1aW86IFByZXZlbnQgZGV2aWNlIGRlc3RydWN0aW9uIHdoaWxlIGZkcyBhcmUgb3Blbg0KPg0K
PiBUaGUgcHJvYmxlbSBpcyB0aGUgYWRkaXRpb24gb2Ygc3Bpbl9sb2NrX2lycXNhdmUgaW4gdWlv
X3dyaXRlLiBUaGlzDQo+IGxlYWRzIHRvIGhpdHRpbmcgIHVpb193cml0ZSAtPiBjb3B5X2Zyb21f
dXNlciAtPiBfY29weV9mcm9tX3VzZXIgLT4NCj4gbWlnaHRfZmF1bHQgYW5kIHRoZSBsb2dzIGZp
bGxpbmcgdXAgd2l0aCBzbGVlcGluZyB3YXJuaW5ncy4NCj4NCj4gSSBhbHNvIG5vdGljZWQgc29t
ZSB1aW8gZHJpdmVycyBhbGxvY2F0ZSBtZW1vcnksIHNsZWVwLCBncmFiIG11dGV4ZXMNCj4gZnJv
bSBjYWxsb3V0cyBsaWtlIG9wZW4oKSBhbmQgcmVsZWFzZSBhbmQgdWlvIGlzIG5vdyBkb2luZw0K
PiBzcGluX2xvY2tfaXJxc2F2ZSB3aGlsZSBjYWxsaW5nIHRoZW0uDQo+DQo+IFJlcG9ydGVkLWJ5
OiBNaWtlIENocmlzdGllIDxtY2hyaXN0aUByZWRoYXQuY29tPg0KPiBDQzogSGFtaXNoIE1hcnRp
biA8aGFtaXNoLm1hcnRpbkBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPiBTaWduZWQtb2ZmLWJ5OiBY
aXVibyBMaSA8eGl1YmxpQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvdWlvL3Vpby5j
ICAgICAgICAgIHwgMzIgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICBpbmNs
dWRlL2xpbnV4L3Vpb19kcml2ZXIuaCB8ICAyICstDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxNCBp
bnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dWlvL3Vpby5jIGIvZHJpdmVycy91aW8vdWlvLmMNCj4gaW5kZXggYjRiMmFlMS4uNjU1YWRlNCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy91aW8vdWlvLmMNCj4gKysrIGIvZHJpdmVycy91aW8vdWlv
LmMNCj4gQEAgLTQzMyw3ICs0MzMsNiBAQCBzdGF0aWMgaW50IHVpb19vcGVuKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlcCkNCj4gICAJc3RydWN0IHVpb19kZXZpY2UgKmlk
ZXY7DQo+ICAgCXN0cnVjdCB1aW9fbGlzdGVuZXIgKmxpc3RlbmVyOw0KPiAgIAlpbnQgcmV0ID0g
MDsNCj4gLQl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAgIA0KPiAgIAltdXRleF9sb2NrKCZtaW5v
cl9sb2NrKTsNCj4gICAJaWRldiA9IGlkcl9maW5kKCZ1aW9faWRyLCBpbWlub3IoaW5vZGUpKTsN
Cj4gQEAgLTQ2MCwxMCArNDU5LDEwIEBAIHN0YXRpYyBpbnQgdWlvX29wZW4oc3RydWN0IGlub2Rl
ICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGVwKQ0KPiAgIAlsaXN0ZW5lci0+ZXZlbnRfY291bnQg
PSBhdG9taWNfcmVhZCgmaWRldi0+ZXZlbnQpOw0KPiAgIAlmaWxlcC0+cHJpdmF0ZV9kYXRhID0g
bGlzdGVuZXI7DQo+ICAgDQo+IC0Jc3Bpbl9sb2NrX2lycXNhdmUoJmlkZXYtPmluZm9fbG9jaywg
ZmxhZ3MpOw0KPiArCW11dGV4X2xvY2soJmlkZXYtPmluZm9fbG9jayk7DQo+ICAgCWlmIChpZGV2
LT5pbmZvICYmIGlkZXYtPmluZm8tPm9wZW4pDQo+ICAgCQlyZXQgPSBpZGV2LT5pbmZvLT5vcGVu
KGlkZXYtPmluZm8sIGlub2RlKTsNCj4gLQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZpZGV2LT5p
bmZvX2xvY2ssIGZsYWdzKTsNCj4gKwltdXRleF91bmxvY2soJmlkZXYtPmluZm9fbG9jayk7DQo+
ICAgCWlmIChyZXQpDQo+ICAgCQlnb3RvIGVycl9pbmZvb3BlbjsNCj4gICANCj4gQEAgLTQ5NSwx
MiArNDk0LDExIEBAIHN0YXRpYyBpbnQgdWlvX3JlbGVhc2Uoc3RydWN0IGlub2RlICppbm9kZSwg
c3RydWN0IGZpbGUgKmZpbGVwKQ0KPiAgIAlpbnQgcmV0ID0gMDsNCj4gICAJc3RydWN0IHVpb19s
aXN0ZW5lciAqbGlzdGVuZXIgPSBmaWxlcC0+cHJpdmF0ZV9kYXRhOw0KPiAgIAlzdHJ1Y3QgdWlv
X2RldmljZSAqaWRldiA9IGxpc3RlbmVyLT5kZXY7DQo+IC0JdW5zaWduZWQgbG9uZyBmbGFnczsN
Cj4gICANCj4gLQlzcGluX2xvY2tfaXJxc2F2ZSgmaWRldi0+aW5mb19sb2NrLCBmbGFncyk7DQo+
ICsJbXV0ZXhfbG9jaygmaWRldi0+aW5mb19sb2NrKTsNCj4gICAJaWYgKGlkZXYtPmluZm8gJiYg
aWRldi0+aW5mby0+cmVsZWFzZSkNCj4gICAJCXJldCA9IGlkZXYtPmluZm8tPnJlbGVhc2UoaWRl
di0+aW5mbywgaW5vZGUpOw0KPiAtCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmlkZXYtPmluZm9f
bG9jaywgZmxhZ3MpOw0KPiArCW11dGV4X3VubG9jaygmaWRldi0+aW5mb19sb2NrKTsNCj4gICAN
Cj4gICAJbW9kdWxlX3B1dChpZGV2LT5vd25lcik7DQo+ICAgCWtmcmVlKGxpc3RlbmVyKTsNCj4g
QEAgLTUxMywxMiArNTExLDExIEBAIHN0YXRpYyBfX3BvbGxfdCB1aW9fcG9sbChzdHJ1Y3QgZmls
ZSAqZmlsZXAsIHBvbGxfdGFibGUgKndhaXQpDQo+ICAgCXN0cnVjdCB1aW9fbGlzdGVuZXIgKmxp
c3RlbmVyID0gZmlsZXAtPnByaXZhdGVfZGF0YTsNCj4gICAJc3RydWN0IHVpb19kZXZpY2UgKmlk
ZXYgPSBsaXN0ZW5lci0+ZGV2Ow0KPiAgIAlfX3BvbGxfdCByZXQgPSAwOw0KPiAtCXVuc2lnbmVk
IGxvbmcgZmxhZ3M7DQo+ICAgDQo+IC0Jc3Bpbl9sb2NrX2lycXNhdmUoJmlkZXYtPmluZm9fbG9j
aywgZmxhZ3MpOw0KPiArCW11dGV4X2xvY2soJmlkZXYtPmluZm9fbG9jayk7DQo+ICAgCWlmICgh
aWRldi0+aW5mbyB8fCAhaWRldi0+aW5mby0+aXJxKQ0KPiAgIAkJcmV0ID0gLUVJTzsNCj4gLQlz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZpZGV2LT5pbmZvX2xvY2ssIGZsYWdzKTsNCj4gKwltdXRl
eF91bmxvY2soJmlkZXYtPmluZm9fbG9jayk7DQo+ICAgDQo+ICAgCWlmIChyZXQpDQo+ICAgCQly
ZXR1cm4gcmV0Ow0KPiBAQCAtNTM3LDEyICs1MzQsMTEgQEAgc3RhdGljIHNzaXplX3QgdWlvX3Jl
YWQoc3RydWN0IGZpbGUgKmZpbGVwLCBjaGFyIF9fdXNlciAqYnVmLA0KPiAgIAlERUNMQVJFX1dB
SVRRVUVVRSh3YWl0LCBjdXJyZW50KTsNCj4gICAJc3NpemVfdCByZXR2YWwgPSAwOw0KPiAgIAlz
MzIgZXZlbnRfY291bnQ7DQo+IC0JdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gICANCj4gLQlzcGlu
X2xvY2tfaXJxc2F2ZSgmaWRldi0+aW5mb19sb2NrLCBmbGFncyk7DQo+ICsJbXV0ZXhfbG9jaygm
aWRldi0+aW5mb19sb2NrKTsNCj4gICAJaWYgKCFpZGV2LT5pbmZvIHx8ICFpZGV2LT5pbmZvLT5p
cnEpDQo+ICAgCQlyZXR2YWwgPSAtRUlPOw0KPiAtCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmlk
ZXYtPmluZm9fbG9jaywgZmxhZ3MpOw0KPiArCW11dGV4X3VubG9jaygmaWRldi0+aW5mb19sb2Nr
KTsNCj4gICANCj4gICAJaWYgKHJldHZhbCkNCj4gICAJCXJldHVybiByZXR2YWw7DQo+IEBAIC01
OTIsOSArNTg4LDggQEAgc3RhdGljIHNzaXplX3QgdWlvX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxl
cCwgY29uc3QgY2hhciBfX3VzZXIgKmJ1ZiwNCj4gICAJc3RydWN0IHVpb19kZXZpY2UgKmlkZXYg
PSBsaXN0ZW5lci0+ZGV2Ow0KPiAgIAlzc2l6ZV90IHJldHZhbDsNCj4gICAJczMyIGlycV9vbjsN
Cj4gLQl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAgIA0KPiAtCXNwaW5fbG9ja19pcnFzYXZlKCZp
ZGV2LT5pbmZvX2xvY2ssIGZsYWdzKTsNCj4gKwltdXRleF9sb2NrKCZpZGV2LT5pbmZvX2xvY2sp
Ow0KPiAgIAlpZiAoIWlkZXYtPmluZm8gfHwgIWlkZXYtPmluZm8tPmlycSkgew0KPiAgIAkJcmV0
dmFsID0gLUVJTzsNCj4gICAJCWdvdG8gb3V0Ow0KPiBAQCAtNjE4LDcgKzYxMyw3IEBAIHN0YXRp
YyBzc2l6ZV90IHVpb193cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZXAsIGNvbnN0IGNoYXIgX191c2Vy
ICpidWYsDQo+ICAgCXJldHZhbCA9IGlkZXYtPmluZm8tPmlycWNvbnRyb2woaWRldi0+aW5mbywg
aXJxX29uKTsNCj4gICANCj4gICBvdXQ6DQo+IC0Jc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmaWRl
di0+aW5mb19sb2NrLCBmbGFncyk7DQo+ICsJbXV0ZXhfdW5sb2NrKCZpZGV2LT5pbmZvX2xvY2sp
Ow0KPiAgIAlyZXR1cm4gcmV0dmFsID8gcmV0dmFsIDogc2l6ZW9mKHMzMik7DQo+ICAgfQ0KPiAg
IA0KPiBAQCAtODY1LDcgKzg2MCw3IEBAIGludCBfX3Vpb19yZWdpc3Rlcl9kZXZpY2Uoc3RydWN0
IG1vZHVsZSAqb3duZXIsDQo+ICAgDQo+ICAgCWlkZXYtPm93bmVyID0gb3duZXI7DQo+ICAgCWlk
ZXYtPmluZm8gPSBpbmZvOw0KPiAtCXNwaW5fbG9ja19pbml0KCZpZGV2LT5pbmZvX2xvY2spOw0K
PiArCW11dGV4X2luaXQoJmlkZXYtPmluZm9fbG9jayk7DQo+ICAgCWluaXRfd2FpdHF1ZXVlX2hl
YWQoJmlkZXYtPndhaXQpOw0KPiAgIAlhdG9taWNfc2V0KCZpZGV2LT5ldmVudCwgMCk7DQo+ICAg
DQo+IEBAIC05MjksNyArOTI0LDYgQEAgaW50IF9fdWlvX3JlZ2lzdGVyX2RldmljZShzdHJ1Y3Qg
bW9kdWxlICpvd25lciwNCj4gICB2b2lkIHVpb191bnJlZ2lzdGVyX2RldmljZShzdHJ1Y3QgdWlv
X2luZm8gKmluZm8pDQo+ICAgew0KPiAgIAlzdHJ1Y3QgdWlvX2RldmljZSAqaWRldjsNCj4gLQl1
bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAgIA0KPiAgIAlpZiAoIWluZm8gfHwgIWluZm8tPnVpb19k
ZXYpDQo+ICAgCQlyZXR1cm47DQo+IEBAIC05NDMsOSArOTM3LDkgQEAgdm9pZCB1aW9fdW5yZWdp
c3Rlcl9kZXZpY2Uoc3RydWN0IHVpb19pbmZvICppbmZvKQ0KPiAgIAlpZiAoaW5mby0+aXJxICYm
IGluZm8tPmlycSAhPSBVSU9fSVJRX0NVU1RPTSkNCj4gICAJCWZyZWVfaXJxKGluZm8tPmlycSwg
aWRldik7DQo+ICAgDQo+IC0Jc3Bpbl9sb2NrX2lycXNhdmUoJmlkZXYtPmluZm9fbG9jaywgZmxh
Z3MpOw0KPiArCW11dGV4X2xvY2soJmlkZXYtPmluZm9fbG9jayk7DQo+ICAgCWlkZXYtPmluZm8g
PSBOVUxMOw0KPiAtCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmlkZXYtPmluZm9fbG9jaywgZmxh
Z3MpOw0KPiArCW11dGV4X3VubG9jaygmaWRldi0+aW5mb19sb2NrKTsNCj4gICANCj4gICAJZGV2
aWNlX3VucmVnaXN0ZXIoJmlkZXYtPmRldik7DQo+ICAgDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L3Vpb19kcml2ZXIuaCBiL2luY2x1ZGUvbGludXgvdWlvX2RyaXZlci5oDQo+IGluZGV4
IDZjNWYyMDcuLjZmOGI2OGMgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvdWlvX2RyaXZl
ci5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvdWlvX2RyaXZlci5oDQo+IEBAIC03NSw3ICs3NSw3
IEBAIHN0cnVjdCB1aW9fZGV2aWNlIHsNCj4gICAgICAgICAgIHN0cnVjdCBmYXN5bmNfc3RydWN0
ICAgICphc3luY19xdWV1ZTsNCj4gICAgICAgICAgIHdhaXRfcXVldWVfaGVhZF90ICAgICAgIHdh
aXQ7DQo+ICAgICAgICAgICBzdHJ1Y3QgdWlvX2luZm8gICAgICAgICAqaW5mbzsNCj4gLQlzcGlu
bG9ja190CQlpbmZvX2xvY2s7DQo+ICsJc3RydWN0IG11dGV4CQlpbmZvX2xvY2s7DQo+ICAgICAg
ICAgICBzdHJ1Y3Qga29iamVjdCAgICAgICAgICAqbWFwX2RpcjsNCj4gICAgICAgICAgIHN0cnVj
dCBrb2JqZWN0ICAgICAgICAgICpwb3J0aW9fZGlyOw0KPiAgIH07DQo=
