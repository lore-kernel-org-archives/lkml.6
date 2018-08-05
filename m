Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B5FC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 12:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35A0217CB
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 12:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="WnrgACoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35A0217CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbeHEObO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 10:31:14 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:50576 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeHEObO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 10:31:14 -0400
Received: from fe0vm1650.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0187.rbdmz01.com (Postfix) with ESMTPS id 41k0QH6GDvz1XLDQt;
        Sun,  5 Aug 2018 14:26:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1533472007;
        bh=5rxI6fYL9wd3HGUtcwlzBi6RuUarhfuGqGmpjdvD9c0=; l=10;
        h=From:From:Reply-To:Sender;
        b=WnrgACoegxMP9wD8eghxXwT3vgpLiBvUBMF40CaG9nPC/dtzHRpmhpOAEkuPpqmoU
         GjyJ9j8H4uPATLDrctuwhcAzxkrpRn3kmPzPTiNoAfoQ6zKS0PTkPS5IAzDkL9eOiL
         AVTBrcxAC9zTXkEG36BZDZEGLzT4miwBdIhdkfUs=
Received: from fe0vm1741.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 41k0QH5qJWz1ys;
        Sun,  5 Aug 2018 14:26:47 +0200 (CEST)
X-AuditID: 0a3aad15-1a5ff70000001291-54-5b66ed0e1375
Received: from si0vm1949.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher AES128-SHA (128/128 bits))
        (Client did not present a certificate)
        by fe0vm1741.rbesz01.com (SMG Outbound) with SMTP id 9D.1F.04753.E0DE66B5; Sun,  5 Aug 2018 14:26:54 +0200 (CEST)
Received: from FE-MBX2051.de.bosch.com (fe-mbx2051.de.bosch.com [10.3.231.61])
        by si0vm1949.rbesz01.com (Postfix) with ESMTPS id 41k0QH3x15z6D5ygD;
        Sun,  5 Aug 2018 14:26:47 +0200 (CEST)
Received: from FE-MBX2051.de.bosch.com (10.3.231.61) by
 FE-MBX2051.de.bosch.com (10.3.231.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1466.3; Sun, 5 Aug 2018 14:26:47 +0200
Received: from FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e]) by
 FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e%6]) with mapi id
 15.01.1466.008; Sun, 5 Aug 2018 14:26:47 +0200
From:   "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "WANG Xin (BT-FIR/ENG1-Zhu)" <Xin.Wang7@cn.bosch.com>,
        "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: Re: [PATCH] eeprom: at24: Fix unexpected timeout under high load
Thread-Topic: [PATCH] eeprom: at24: Fix unexpected timeout under high load
Thread-Index: AdQssSLBG+/m5vD3DUiDEkjnf1L3ZA==
Date:   Sun, 5 Aug 2018 12:26:47 +0000
Message-ID: <cd8f37876a2e466ea066bcad10b0b8e4@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.142.13.202]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA22TbUxbZRTH+/T25dJx2eWWyrFYkA5dXLIOJmizTdmMH+qm0w+GRPsBy7jQ
        zr5gb0HYEoOCDgFxdtBAKWzyFiRqGWYVurnGLo7NJfQDOmTIuqEjlDGN7kV5KXjLLWs/+OXm
        PP9zfuf8n/Pk4hjlxuW4wWyjrWadUSmSCCS7vlJsT7pTos12eNXq0PELSB22XxSrvTc8InVN
        t1ukrgvfQ+pxr0u0V6RZXrIjTffVKaFmxDkt1vg6vhRr7g6lvyZ8U7KnmDYaKmjrjuffkugv
        XH6Alf3yeGVNB1mNFjLqUQIOZC6MNg5h9UiCU+QxPnz2rz96OI9garQpelhA4OgajB58CKbf
        /0gY4UXkLjjWd0UciVPIAnAv3V2PMXKAD+2zhyOxlHwJws4WAVezH37u9CAuVsHkx33r9QIy
        C76YdYkiMUHuhrblsfX+iFTA4GAA43qmwtDsP0LONwk95zgdSBmEfluN6pngXAmys3C2/ilw
        e3dwaCY0N9wUc+2T4XLb74LjSOaM6+qMEc44whlHnEKCASQrobMrTDnP5uaorEU0cyQ7R3XI
        YhpC3KvJhpH7G9qPSBwpEwnVrRItJdRVMFUmP8rD+UoZkTderKWSiizFVXodoy+0lhtpRikn
        EI/Ho6QPZaa8yGRgGIPF7EeAY8oUYq2a1lJEsa7qCG21cJgfpeECZSohDRdoKbJUZ6Pfpuky
        2rqR3Y3jSiDSF1gPyVa6lK4sMRhtG2mlgpv5SHwmfiwfT/Cjp/FEdnbvbbYFwZTpTIyhNIo/
        yuHUhhpDf0Sv4tdqGu0YvvJnC/v9tcFhxyiB2WKm5amELGKHjFD6cvNDN/LHiMWZQ1pKFpeI
        dZxHk4jdp5RojBhJZH+UmA8ghqWuN6jkqBiDdvayDOlKBN/kOILVMwE+uFfvYNDd0yqEtc9r
        RPDh2Q9wqFttxmFsIpQA9oYbEjjde34T+IJdLNZuT4KltpbN8EPtzGZoDbWS4JvtJ8E+4pDC
        9UC3DNo9J1Kh9hMHQKfzb4D+jq/lsHjy0zRY/n5KAXX+nzKg9X5zJlyaO7cFgiPOLOhZXH4S
        7t0f3Q5rc10q8LhCqnl2yXx2yUdzIw/M2HS2/1lyVI3dTl6N9lVm7HtlmianX7/pULxX+OKV
        sjDvsHlneOumrAMvB/R5W9KbPKOd3v0a79V3n8j0nrZpLs57h/e0/ZFWe503dnDrygvB/KOS
        jLPGuWsB+lbh/Jl3FMlzz/FGZH/1HOyZ+K5pb12CsKN25pmBU4rc+vxg1ckH2wrCnbKUify+
        by/1H7itFDB6Xc42zMro/gO5uqQOwgQAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwNCg0KVGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrLg0KIA0KPiA+IC0jZGVmaW5l
IGF0MjRfbG9vcF91bnRpbF90aW1lb3V0KHRvdXQsIG9wX3RpbWUpICAgICAgICAgICAgICAgICAg
ICAgICAgIFwNCj4gPiAtICAgICAgIGZvciAodG91dCA9IGppZmZpZXMgKyBtc2Vjc190b19qaWZm
aWVzKGF0MjRfd3JpdGVfdGltZW91dCksICAgICBcDQo+ID4gLSAgICAgICAgICAgIG9wX3RpbWUg
PSAwOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+
IC0gICAgICAgICAgICBvcF90aW1lID8gdGltZV9iZWZvcmUob3BfdGltZSwgdG91dCkgOiB0cnVl
OyAgICAgICAgICAgICAgIFwNCj4gPiAtICAgICAgICAgICAgdXNsZWVwX3JhbmdlKDEwMDAsIDE1
MDApLCBvcF90aW1lID0gamlmZmllcykNCj4gDQo+IFRoaXMgb25lIHVuZGVyc3RhbmRibGUgYW5k
IHJlcHJlc2VudHMgb25lIG9wZXJhdGlvbi4NCg0KSXQganVzdCBoYXMgdGhlIGRvd25zaWRlIHRo
YXQgaXQgd2lsbCBub3QgcmV0cnkgaWYgdGhlIHRpbWVvdXQgaXMNCnJlYWNoZWQgYWZ0ZXIgdGhl
IHVzbGVlcF9yYW5nZSgpLg0KDQpJZiB5b3UgaGF2ZSBhIHN5c3RlbSB3aGljaCBjb21iaW5lcyBo
aWdoIENQVSBsb2FkIHdpdGggcmVwZWF0ZWQgRUVQUk9NDQp3cml0ZXMgeW91IHdpbGwgcnVuIGlu
dG8gdGhlIGZvbGxvd2luZyBzY2VuYXJpbzoNCg0KLSBTeXN0ZW0gbWFrZXMgYSBzdWNjZXNzZnVs
IHJlZ21hcF9idWxrX3dyaXRlKCkgdG8gRUVQUk9NLg0KLSBTeXN0ZW0gd2FudHMgdG8gcGVyZm9y
bSBhbm90aGVyIHdyaXRlIHRvIEVFUFJPTSBidXQgRUVQUk9NIGlzIHN0aWxsDQogIGJ1c3kgd2l0
aCB0aGUgbGFzdCB3cml0ZS4NCi0gQmVjYXVzZSBvZiBoaWdoIENQVSBsb2FkIHRoZSB1c2xlZXBf
cmFuZ2UoKSB3aWxsIHNsZWVwIG1vcmUgdGhhbg0KICAyNSBtcyAoYXQyNF93cml0ZV90aW1lb3V0
KS4NCi0gV2l0aGluIHRoZSBvdmVyLWxvbmcgc2xlZXBpbmcgdGhlIEVFUFJPTSBmaW5pc2hlZCB0
aGUgcHJldmlvdXMgd3JpdGUNCiAgb3BlcmF0aW9uIGFuZCBpcyByZWFkeSBhZ2Fpbi4NCi0gYXQy
NF9sb29wX3VudGlsX3RpbWVvdXQoKSB3aWxsIGRldGVjdCB0aW1lb3V0IGFuZCB3b24ndCB0cnkg
dG8gd3JpdGUuDQoNClRoZSBzY2VuYXJpbyBhYm92ZSBoYXBwZW5zIHZlcnkgb2Z0ZW4gb24gb3Vy
IHN5c3RlbSBhbmQgd2UgbmVlZCBhIGZpeC4NCg0KPiA+ICsjZGVmaW5lIGF0MjRfbG9vcF91bnRp
bF90aW1lb3V0X2JlZ2luKHRvdXQsIG9wX3RpbWUpICAgICAgICAgICBcDQo+ID4gKyAgICAgICB0
b3V0ID0gamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoYXQyNF93cml0ZV90aW1lb3V0KTsgIFwN
Cj4gPiArICAgICAgIHdoaWxlICh0cnVlKSB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXA0KPiA+ICsgICAgICAgICAgICAgICBvcF90aW1lID0gamlmZmllczsNCj4g
PiArDQo+ID4gKyNkZWZpbmUgYXQyNF9sb29wX3VudGlsX3RpbWVvdXRfZW5kKHRvdXQsIG9wX3Rp
bWUpICAgICAgICAgICAgIFwNCj4gPiArICAgICAgICAgICAgICAgaWYgKHRpbWVfYmVmb3JlKHRv
dXQsIG9wX3RpbWUpKSAgICAgICAgICAgICAgICAgXA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGJyZWFrOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ID4gKyAgICAg
ICAgICAgICAgIHVzbGVlcF9yYW5nZSgxMDAwLCAxNTAwKTsgICAgICAgICAgICAgICAgICAgICAg
IFwNCj4gPiArICAgICAgIH0NCj4gDQo+IEJlc2lkZXMgYHdoaWxlICh0cnVlKWAsIHdoaWNoIGlz
IGEgcmVkIGZsYWcgZm9yIHRpbWVvdXQgbG9vcHMsDQo+IHRoZXNlIGFyZSBkb25lIGluIGFuIGhh
Y2sgd2F5LiBKdXN0IG9wZW4gY29kZSB0aGVtIGluIGJvdGggY2FzZXMsIG9yDQo+IHJld3JpdGUg
b3JpZ2luYWwgb25lIHRvIGtlZWwgaXQncyBzZW1hbnRpY3MuDQoNCkkgaGF2ZSB0byBhZG1pdCB0
aGF0IEkgYW0gbm90IHN1cmUgd2hhdCB5b3UgbWVhbi4NCg0KV2Uga2VwdCB0aGUgbWFjcm8tc3R5
bGUgb2YgdGhlIGxvb3AgYmVjYXVzZSB3ZSBhc3N1bWVkIGl0IHdhcyBnb29kDQpzdHlsZSBpbiB0
aGlzIGNvbnRleHQuDQoNCldoYXQgZG9lcyAia2VlbCBpdCdzIHNlbWFudGljcyIgbWVhbj8NCg0K
V2l0aCAib3BlbiBjb2RlIHRoZW0gaW4gYm90aCBjYXNlcyIgZG8geW91IG1lYW4gdG8gcmlkIG9m
IHRoZSBtYWNybw0KYW5kIHRvIGRpcmVjdGx5IHdyaXRlIHRoZSBsb29wIGludG8gdGhlIGNvZGU/
IERvZXMgdGhlIGZvbGxvd2luZw0KbWF0Y2ggeW91ciBwcm9wb3NhbHM/DQoNCnJldCA9IDA7DQp0
b3V0ID0gamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoYXQyNF93cml0ZV90aW1lb3V0KTsNCmRv
IHsNCglpZiAocmV0KQ0KCQl1c2xlZXBfcmFuZ2UoMTAwMCwgMTUwMCk7DQoNCglyZWFkX3RpbWUg
PSBqaWZmaWVzOw0KDQoJcmV0ID0gcmVnbWFwX2J1bGtfcmVhZChyZWdtYXAsIG9mZnNldCwgYnVm
LCBjb3VudCk7DQoJZGV2X2RiZygmY2xpZW50LT5kZXYsICJyZWFkICV6dUAlZCAtLT4gJWQgKCVs
ZClcbiIsDQoJCWNvdW50LCBvZmZzZXQsIHJldCwgamlmZmllcyk7DQoJaWYgKCFyZXQpDQoJCXJl
dHVybiBjb3VudDsNCn0gd2hpbGUgKCF0aW1lX2JlZm9yZSh0b3V0LCByZWFkX3RpbWUpKQ0KDQpH
cmVldGluZ3MsDQpNYXJrDQoNCkJ1aWxkaW5nIFRlY2hub2xvZ2llcywgUGFuZWwgU29mdHdhcmUg
RmlyZSAoQlQtRklSL0VORzEpIA0KQm9zY2ggU2ljaGVyaGVpdHNzeXN0ZW1lIEdtYkggfCBQb3N0
ZmFjaCAxMSAxMSB8IDg1NjI2IEdyYXNicnVubiB8IEdFUk1BTlkgfCB3d3cuYm9zY2hzZWN1cml0
eS5jb20NCg0KU2l0ejogU3R1dHRnYXJ0LCBSZWdpc3RlcmdlcmljaHQ6IEFtdHNnZXJpY2h0IFN0
dXR0Z2FydCBIUkIgMjMxMTggDQpBdWZzaWNodHNyYXRzdm9yc2l0emVuZGVyOiBTdGVmYW4gSGFy
dHVuZzsgR2VzY2jDpGZ0c2bDvGhydW5nOiBUYW5qYSBSw7xja2VydCwgQW5kcmVhcyBCYXJ0eiwg
VGhvbWFzIFF1YW50ZSwgQmVybmhhcmQgU2NodXN0ZXINCg==
