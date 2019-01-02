Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E05C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604DC21871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfABG4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:56:10 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:6952 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727558AbfABG4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 01:56:10 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 0E3D04867FA1E;
        Wed,  2 Jan 2019 14:56:02 +0800 (CST)
Received: from DGGEMM528-MBX.china.huawei.com ([169.254.8.187]) by
 DGGEMM406-HUB.china.huawei.com ([10.3.20.214]) with mapi id 14.03.0415.000;
 Wed, 2 Jan 2019 14:55:54 +0800
From:   "liujian (CE)" <liujian56@huawei.com>
To:     Xiubo Li <xiubli@redhat.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liujian (CE)" <liujian56@huawei.com>
Subject: RE: [PATCH] driver: uio: fix possible memory leak in uio_open
Thread-Topic: [PATCH] driver: uio: fix possible memory leak in uio_open
Thread-Index: AQHUomQL5cJ/9lfbTk6cTYBwakUoCaWbADaAgACIq4A=
Date:   Wed, 2 Jan 2019 06:55:54 +0000
Message-ID: <4F88C5DDA1E80143B232E89585ACE27D02584121@DGGEMM528-MBX.china.huawei.com>
References: <1546446416-40831-1-git-send-email-liujian56@huawei.com>
 <50ee4818-a154-5ea7-20f8-3c0f0859f4fa@redhat.com>
In-Reply-To: <50ee4818-a154-5ea7-20f8-3c0f0859f4fa@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.97.126]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGxpbnV4LWtlcm5l
bC1vd25lckB2Z2VyLmtlcm5lbC5vcmcNCj4gW21haWx0bzpsaW51eC1rZXJuZWwtb3duZXJAdmdl
ci5rZXJuZWwub3JnXSBPbiBCZWhhbGYgT2YgWGl1Ym8gTGkNCj4gU2VudDogV2VkbmVzZGF5LCBK
YW51YXJ5IDAyLCAyMDE5IDI6MzcgUE0NCj4gVG86IGxpdWppYW4gKENFKSA8bGl1amlhbjU2QGh1
YXdlaS5jb20+DQo+IENjOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcml2ZXI6IHVpbzogZml4
IHBvc3NpYmxlIG1lbW9yeSBsZWFrIGluIHVpb19vcGVuDQo+IA0KPiBPbiAyMDE5LzEvMyAwOjI2
LCBsaXVqaWFuIHdyb3RlOg0KPiA+IEZpeGVzOiA1N2M1ZjRkZjBhNWEgKCJ1aW86IGZpeCBjcmFz
aCBhZnRlciB0aGUgZGV2aWNlIGlzDQo+ID4gdW5yZWdpc3RlcmVkIikNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBsaXVqaWFuIDxsaXVqaWFuNTZAaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZl
cnMvdWlvL3Vpby5jIHwgMyArKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vpby91aW8u
YyBiL2RyaXZlcnMvdWlvL3Vpby5jIGluZGV4DQo+ID4gNWMxMGZjNy4uYmRlN2Q3YSAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL3Vpby91aW8uYw0KPiA+ICsrKyBiL2RyaXZlcnMvdWlvL3Vpby5j
DQo+ID4gQEAgLTQ5Niw3ICs0OTYsNyBAQCBzdGF0aWMgaW50IHVpb19vcGVuKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIHN0cnVjdCBmaWxlDQo+ICpmaWxlcCkNCj4gPiAgIAlpZiAoIWlkZXYtPmluZm8p
IHsNCj4gPiAgIAkJbXV0ZXhfdW5sb2NrKCZpZGV2LT5pbmZvX2xvY2spOw0KPiA+ICAgCQlyZXQg
PSAtRUlOVkFMOw0KPiA+IC0JCWdvdG8gZXJyX2FsbG9jX2xpc3RlbmVyOw0KPiA+ICsJCWdvdG8g
ZXJyX2luZm9vcGVuOw0KPiA+ICAgCX0NCj4gPg0KPiA+ICAgCWlmIChpZGV2LT5pbmZvICYmIGlk
ZXYtPmluZm8tPm9wZW4pIEBAIC01MDgsNiArNTA4LDcgQEAgc3RhdGljIGludA0KPiA+IHVpb19v
cGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlcCkNCj4gPiAgIAlyZXR1
cm4gMDsNCj4gPg0KPiA+ICAgZXJyX2luZm9vcGVuOg0KPiANCj4gTWF5YmUgd2Ugc2hvdWxkIHJl
bmFtZSB0aGUgImVycl9pbmZvb3BlbiIgdG8gc29tZXRoaW5nIGxpa2UNCj4gImVycl9pZGV2X2lu
Zm8iLi4uDQo+IA0KWWVzLCBpdCdzIGJldHRlciB0byBjaGFuZ2UgdGhpcywgSSB3aWxsIHNlbmQg
djIsIHRoYW5rIHlvdX4NCg0KQmVzdCBSZWdhcmRzLA0KbGl1amlhbg0KDQo+IFRoYW5rcy4NCj4g
DQo+IEJScw0KPiANCj4gPiArCWZpbGVwLT5wcml2YXRlX2RhdGEgPSBOVUxMOw0KPiA+ICAgCWtm
cmVlKGxpc3RlbmVyKTsNCj4gPg0KPiA+ICAgZXJyX2FsbG9jX2xpc3RlbmVyOg0KPiANCg0K
