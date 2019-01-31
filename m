Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A94C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D379218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfAaLP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:15:57 -0500
Received: from mx20.baidu.com ([111.202.115.85]:60172 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726221AbfAaLP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:15:56 -0500
X-Greylist: delayed 91821 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Jan 2019 06:15:53 EST
Received: from M1-MAIL-EX16.internal.baidu.com (unknown [10.44.89.56])
        by Forcepoint Email with ESMTPS id B4D18E0B0454F;
        Thu, 31 Jan 2019 19:15:47 +0800 (CST)
Received: from BC-Mail-Ex13.internal.baidu.com (172.31.40.49) by
 M1-MAIL-EX16.internal.baidu.com (10.44.89.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Thu, 31 Jan 2019 19:15:48 +0800
Received: from BC-Mail-Ex13.internal.baidu.com ([172.31.40.49]) by
 Bc-Mail-Ex13.internal.baidu.com ([172.31.40.49]) with mapi id 15.01.1531.010;
 Thu, 31 Jan 2019 19:15:48 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "gkohli@codeaurora.org" <gkohli@codeaurora.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXVtWNV0gdHR5OiBmaXggcmFjZSBiZXR3ZWVuIGZsdXNo?=
 =?gb2312?B?X3RvX2xkaXNjIGFuZCB0dHlfb3Blbg==?=
Thread-Topic: [PATCH][V5] tty: fix race between flush_to_ldisc and tty_open
Thread-Index: AQHUuVN9LlUBqVRgFUmO4OHgZ/3XQqXJN3hQ
Date:   Thu, 31 Jan 2019 11:15:48 +0000
Message-ID: <22a5d8639b154119af7d7661e17025f2@baidu.com>
References: <1548927796-11348-1-git-send-email-lirongqing@baidu.com>
 <20190131105527.GB8271@kroah.com>
In-Reply-To: <20190131105527.GB8271@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.24.150.64]
x-baidu-bdmsfe-datecheck: 1_M1-MAIL-EX16_2019-01-31 19:15:48:537
x-baidu-bdmsfe-viruscheck: M1-MAIL-EX16_GRAY_Inside_WithoutAtta_2019-01-31
 19:15:48:521
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogbGludXgta2VybmVsLW93bmVyQHZn
ZXIua2VybmVsLm9yZw0KPiBbbWFpbHRvOmxpbnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5v
cmddILT6se0gR3JlZyBLcm9haC1IYXJ0bWFuDQo+ILeiy83KsbzkOiAyMDE5xOox1MIzMcjVIDE4
OjU1DQo+IMrVvP7IyzogTGksUm9uZ3FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiCzrcvN
OiBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiBqc2xhYnlAc3VzZS5jb207IGdrb2hsaUBjb2RlYXVyb3JhLm9yZw0KPiDW98ziOiBS
ZTogW1BBVENIXVtWNV0gdHR5OiBmaXggcmFjZSBiZXR3ZWVuIGZsdXNoX3RvX2xkaXNjIGFuZCB0
dHlfb3Blbg0KPiANCj4gT24gVGh1LCBKYW4gMzEsIDIwMTkgYXQgMDU6NDM6MTZQTSArMDgwMCwg
TGkgUm9uZ1Fpbmcgd3JvdGU6DQo+ID4gVGhlcmUgc3RpbGwgaXMgYSByYWNlIHdpbmRvdyBhZnRl
ciB0aGUgY29tbWl0IGIwMjdlMjI5OGJkNTg4DQo+ID4gKCJ0dHk6IGZpeCBkYXRhIHJhY2UgYmV0
d2VlbiB0dHlfaW5pdF9kZXYgYW5kIGZsdXNoIG9mIGJ1ZiIpLCBhbmQgd2UNCj4gPiBlbmNvdW50
ZXJlZCB0aGlzIGNyYXNoIGlzc3VlIGlmIHJlY2VpdmVfYnVmIGNhbGwgY29tZXMgYmVmb3JlIHR0
eQ0KPiA+IGluaXRpYWxpemF0aW9uIGNvbXBsZXRlcyBpbiB0dHlfb3BlbiBhbmQNCj4gPiB0dHkt
PmRyaXZlcl9kYXRhIG1heSBiZSBOVUxMLg0KPiA+DQo+ID4gQ1BVMCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIENQVTENCj4gPiAtLS0tICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgLS0tLQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0
dHlfb3Blbg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHR5X2luaXRf
ZGV2DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHR0eV9sZGlzY191
bmxvY2sNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzY2hlZHVs
ZSBmbHVzaF90b19sZGlzYw0KPiA+IHJlY2VpdmVfYnVmDQo+ID4gICB0dHlfcG9ydF9kZWZhdWx0
X3JlY2VpdmVfYnVmDQo+ID4gICAgdHR5X2xkaXNjX3JlY2VpdmVfYnVmDQo+ID4gICAgIG5fdHR5
X3JlY2VpdmVfYnVmX2NvbW1vbg0KPiA+ICAgICAgIF9fcmVjZWl2ZV9idWYNCj4gPiAgICAgICAg
dWFydF9mbHVzaF9jaGFycw0KPiA+ICAgICAgICAgdWFydF9zdGFydA0KPiA+ICAgICAgICAgLyp0
dHktPmRyaXZlcl9kYXRhIGlzIE5VTEwqLw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdHR5LT5vcHMtPm9wZW4NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC8qaW5pdCB0dHktPmRyaXZlcl9kYXRhKi8NCj4gPg0KPiA+IGl0IGNhbiBiZSBmaXhl
ZCBieSBleHRlbmRpbmcgbGRpc2Mgc2VtYXBob3JlIGxvY2sgaW4gdHR5X2luaXRfZGV2IHRvDQo+
ID4gZHJpdmVyX2RhdGEgaW5pdGlhbGl6ZWQgY29tcGxldGVseSBhZnRlciB0dHktPm9wcy0+b3Bl
bigpLCBidXQgdGhpcw0KPiA+IHdpbGwgbGVhZCB0byBnZXQgbG9jayBvbiBvbmUgZnVuY3Rpb24g
YW5kIHVubG9jayBpbiBzb21lIG90aGVyDQo+ID4gZnVuY3Rpb24sIGFuZCBoYXJkIHRvIG1haW50
YWluLCBzbyBmaXggdGhpcyByYWNlIG9ubHkgYnkgY2hlY2tpbmcNCj4gPiB0dHktPmRyaXZlcl9k
YXRhIHdoZW4gcmVjZWl2aW5nLCBhbmQgcmV0dXJuIGlmIHR0eS0+ZHJpdmVyX2RhdGENCj4gPiBp
cyBOVUxMLCBhbmQgbl90dHlfcmVjZWl2ZV9idWZfY29tbW9uIG1heWJlIGNhbGxzIHVhcnRfdW50
aHJvdHRsZSwgc28NCj4gPiBhZGQgdGhlIHNhbWUgY2hlY2sNCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFdhbmcgTGkgPHdhbmdsaTM5QGJhaWR1LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGFu
ZyBZdSA8emhhbmd5dTMxQGJhaWR1LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBSb25nUWlu
ZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ID4gLS0tDQo+ID4gVjU6IG1vdmUgY2hlY2sgaW50
byB1YXJ0X3N0YXJ0IGZyb20gbl90dHlfcmVjZWl2ZV9idWZfY29tbW9uDQo+ID4gVjQ6IGFkZCB2
ZXJzaW9uIGluZm9ybWF0aW9uDQo+ID4gVjM6IG5vdCB1c2VkIGxkaXNjIHNlbWFwaG9yZSBsb2Nr
LCBvbmx5IGNoZWNraW5nIHR0eS0+ZHJpdmVyX2RhdGEgd2l0aA0KPiA+IE5VTEwNCj4gPiBWMjog
Zml4IGJ1aWxkaW5nIGVycm9yIGJ5IEVYUE9SVF9TWU1CT0wgdHR5X2xkaXNjX3VubG9jaw0KPiA+
IFYxOiBleHRlbmQgbGRpc2MgbG9jayB0byBwcm90ZWN0IHRoYXQgdHR5LT5kcml2ZXJfZGF0YSBp
cyBpbml0ZWQNCj4gPg0KPiA+ICBkcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyB8IDYg
KysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYw0KPiA+IGIvZHJpdmVy
cy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMNCj4gPiBpbmRleCA1YzAxYmI2ZDFjMjQuLjU1NmY1
MGFhMWI1OCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jDQo+ID4gQEAgLTEz
MCw2ICsxMzAsOSBAQCBzdGF0aWMgdm9pZCB1YXJ0X3N0YXJ0KHN0cnVjdCB0dHlfc3RydWN0ICp0
dHkpDQo+ID4gIAlzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0Ow0KPiA+ICAJdW5zaWduZWQgbG9uZyBm
bGFnczsNCj4gPg0KPiA+ICsJaWYgKCFzdGF0ZSkNCj4gPiArCQlyZXR1cm47DQo+ID4gKw0KPiA+
ICAJcG9ydCA9IHVhcnRfcG9ydF9sb2NrKHN0YXRlLCBmbGFncyk7DQo+ID4gIAlfX3VhcnRfc3Rh
cnQodHR5KTsNCj4gPiAgCXVhcnRfcG9ydF91bmxvY2socG9ydCwgZmxhZ3MpOw0KPiA+IEBAIC03
MjcsNiArNzMwLDkgQEAgc3RhdGljIHZvaWQgdWFydF91bnRocm90dGxlKHN0cnVjdCB0dHlfc3Ry
dWN0ICp0dHkpDQo+ID4gIAl1cHN0YXRfdCBtYXNrID0gVVBTVEFUX1NZTkNfRklGTzsNCj4gPiAg
CXN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQ7DQo+ID4NCj4gPiArCWlmICghc3RhdGUpDQo+ID4gKwkJ
cmV0dXJuOw0KPiA+ICsNCj4gPiAgCXBvcnQgPSB1YXJ0X3BvcnRfcmVmKHN0YXRlKTsNCj4gPiAg
CWlmICghcG9ydCkNCj4gPiAgCQlyZXR1cm47DQo+ID4gLS0NCj4gPiAyLjE2LjINCj4gDQo+IA0K
PiBIbSwgSSB3cm90ZSB0aGlzIHBhdGNoLCBub3QgeW91LCByaWdodD8gIFNvIHNob3VsZG4ndCBJ
IGdldCB0aGUNCj4gY3JlZGl0L2JsYW1lIGZvciBpdD8gIDopDQo+IA0KDQpXZWxjb21lIHlvdSB0
byBhZGQgeW91ciBjcmVkaXQvYmxhbWUvc2lnbmF0dXJlDQphbmQgSSBhbSBub3QgY2xlYXIgdGhl
IHJ1bGUsIGFuZCBiZSBhZnJhaWQgdG8gYmVjb21lIGZha2UNCg0KPiBBbHNvLCB0aGlzIGlzIGEg
YnVnIGluIHRoZSBzZXJpYWwgY29kZSwgbm90IG5lY2Vzc2FyaWx5IHRoZSB0dHkgbGF5ZXIsDQo+
IHNvIHRoZSBzdWJqZWN0IHNob3VsZCBjaGFuZ2UuLi4NCj4gDQo+IEFuZCB5b3UgZGlkIHRlc3Qg
dGhpcywgcmlnaHQ/DQoNCkkgYWRkIHNvbWUgZGVsYXkgaW4gdHR5X2luaXRfZGV2IHRvIHNpbXVs
YXRlIHRoaXMgaXNzdWUuICBpdCBjYW4gZml4IHRoaXMgbXkgaXNzdWUuDQoNClRoYW5rcw0KDQot
Um9uZ1FpbmcNCg0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg==
