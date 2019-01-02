Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962A9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491E820874
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="kdvsxkM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfABWFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:05:19 -0500
Received: from mail-eopbgr50136.outbound.protection.outlook.com ([40.107.5.136]:9856
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727140AbfABWFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 17:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Dr8sU/vpPRzWV2322hNw2RBcMTv/DBaGy8T8plRvpY=;
 b=kdvsxkM1vZ4C5/hJBCI3Y57kqPGbEKoawNTC59kDJHMt4Z24rPDDnND7l4eHigiEJuRCTg8V+1CRMoOymUkw6H8nMGu7fSaDRvv0mxGrIQ6FAEdSnlXX9phHdOCKy6BwSncw8cSbYRwX2KdEojOpPuEjG6XqA5quGwdxCpYq7zk=
Received: from AM6PR0202MB3271.eurprd02.prod.outlook.com (52.133.28.141) by
 AM6PR0202MB3368.eurprd02.prod.outlook.com (52.133.10.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Wed, 2 Jan 2019 22:05:10 +0000
Received: from AM6PR0202MB3271.eurprd02.prod.outlook.com
 ([fe80::3ccc:e2fa:d507:5ae5]) by AM6PR0202MB3271.eurprd02.prod.outlook.com
 ([fe80::3ccc:e2fa:d507:5ae5%6]) with mapi id 15.20.1495.005; Wed, 2 Jan 2019
 22:05:10 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "talho@nvidia.com" <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V1] i2c: tegra: Fix Maximum transfer size
Thread-Topic: [PATCH V1] i2c: tegra: Fix Maximum transfer size
Thread-Index: AQHUouT30N0PYO/CsUuP4U03RR2BsqWciKUA
Date:   Wed, 2 Jan 2019 22:05:10 +0000
Message-ID: <e0f6cea5-cd18-1ed1-f8ee-aa9c58198df2@axentia.se>
References: <1546465721-12108-1-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1546465721-12108-1-git-send-email-skomatineni@nvidia.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1P189CA0026.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::39)
 To AM6PR0202MB3271.eurprd02.prod.outlook.com (2603:10a6:209:19::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0202MB3368;6:tDJAIU8eOBDTrmIw+3G5RpJKEuXoI0Itm3/SBs3FxpRUT+gJfEKSjnkNXlxSZVdTKRVFybZMJuE+ip4Cm+5tIvCTdamS/wo6wN4jQW5TUbix8grPX7drmVWw8lyOvWQ1EuC4RhfuhL8aLaORCclSbNlG1w5HcS1bRnthgxRmtiRYgNrDyAatHFkaVOGKevzr1Zzk/7uljljkmMPbXgpb/G1XLkLqMYoNWwiBThUubRoU51bW2KhWX8l6pFgppYMeeeaqZqxRj1VQ6THGSTzZL7UmBtxQhCEjDvuSsUiGzCX1AIfTkWMXE5jcO+BKkuNrDzIZFh7Viz7pyPw3HoVnTJObAl6U1tx4DLmPE7ZtFy7Gb4Qk5wZqLd0So4cLb2ISeaFsCUVdeyUbP3RAf8tOlN/Xn0e44M6Sr0PqgQ9UT/SPyXnSqf2yYCJwEN/WTByHUSitczBx4Y4zVtV2WGfBwA==;5:raPWb8wFMsYtIG/6vWp7tL1ZKoVSbOSeZUehJ2o0U+hLEfXbT5lBp3jL3DZk6bOrPNnLfhamIMSzlasbiFBxLGACyQ2EiwBU2KZ3cnmN37nTyXMJ5zurroiILowHh3ANEQtUoAuCJq4XlSze/C5EGE0QXCMhI6CYc/2WBg/7cRTCSAJZ4EVsHO/3jdojASqg8ws8DC0zXbMzhgjVT7MLIQ==;7:dDNU8t+q4b+4ZobVP7dwwmEFywzMx+RWRJTE8DB/T8iXMbdxm5RI3QOxe3DdY78WG3ppoYLyAsJpa+6D8Mbuv63A8QWvS87iYVLe/JkDqH06Jf6NJCUG3zPMR3BNI9RnK2x8OgoDwp8Cn57fqAkWag==
x-ms-office365-filtering-correlation-id: fa21f15c-c59f-4dad-e504-08d670fe5cc7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR0202MB3368;
x-ms-traffictypediagnostic: AM6PR0202MB3368:
x-microsoft-antispam-prvs: <AM6PR0202MB3368B1F2B49178ADBF24BB51BC8C0@AM6PR0202MB3368.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM6PR0202MB3368;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0202MB3368;
x-forefront-prvs: 0905A6B2C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(346002)(39830400003)(366004)(189003)(199004)(36756003)(508600001)(53936002)(65806001)(68736007)(66066001)(476003)(65956001)(2906002)(2616005)(25786009)(11346002)(6512007)(446003)(6246003)(39060400002)(105586002)(186003)(106356001)(26005)(71190400001)(71200400001)(2501003)(74482002)(31686004)(102836004)(14454004)(6116002)(64126003)(3846002)(8676002)(4326008)(575784001)(8936002)(81166006)(305945005)(110136005)(86362001)(54906003)(7736002)(2201001)(81156014)(229853002)(97736004)(52116002)(6486002)(6436002)(76176011)(99286004)(14444005)(256004)(5660300001)(486006)(31696002)(6506007)(53546011)(58126008)(316002)(386003)(65826007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3368;H:AM6PR0202MB3271.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bdy3y5akKYVkn64c9717hZygLn37EBXAEjJ+Z97vgbnrxJc5LDYEeHuRMfqcZoybOttNASkGsLEA4XNRtSgZ1Y9YyZscRzBD0o3qvVGYW6ktD4fzgSMwUVJFU9zvOBoSEzjK+4vX9W4QzBTZsJrT11M7iuHIHvJGEtoCw1d0x//jLo/PceXwrTG8HkhIOlE3jI3Qte7Cofs82LXuKfOXR0f7KCIH7wMVERqmTm92ijcxfUO46IaCRSKTIYyqSWGfCzezOPfce+GtmLxeWFidecNnKXaI7b4Wsa5B6tD2nIw1uUbxpzlxnCGcFZphNmZD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED64DC2DC28D8D4B98FF5C80D94D7379@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: fa21f15c-c59f-4dad-e504-08d670fe5cc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2019 22:05:10.2644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3368
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMS0wMiAyMjo0OCwgU293amFueWEgS29tYXRpbmVuaSB3cm90ZToNCj4gVGVncmEx
OTQgc3VwcG9ydHMgbWF4aW11bSA2NEsgQnl0ZXMgdHJhbnNmZXIgcGVyIHBhY2tldC4NCj4gVGVn
cmExODYgYW5kIHByaW9yIHN1cHBvcnRzIG1heGltdW0gNEsgQnl0ZXMgdHJhbnNmZXIgcGVyIHBh
Y2tldC4NCj4gDQo+IFRoaXMgcGF0Y2ggZml4ZXMgdGhpcyBwYXlsb2FkIGRpZmZlcmVuY2UgYmV0
d2VlbiBUZWdyYTE5NCBhbmQgcHJpb3INCj4gdGVncmEgY2hpcHNldHMuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBTb3dqYW55YSBLb21hdGluZW5pIDxza29tYXRpbmVuaUBudmlkaWEuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtdGVncmEuYyB8IDE2ICsrKysrKysrKysrKysr
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jIGIvZHJpdmVy
cy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jDQo+IGluZGV4IDQzNzI5NGVhMmYwYS4uMGMwOGVkOGI2
Yzk0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3JhLmMNCj4gKysr
IGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jDQo+IEBAIC0xNjcsNiArMTY3LDcgQEAg
c3RydWN0IHRlZ3JhX2kyY19od19mZWF0dXJlIHsNCj4gIAlib29sIGhhc19tdWx0aV9tYXN0ZXJf
bW9kZTsNCj4gIAlib29sIGhhc19zbGNnX292ZXJyaWRlX3JlZzsNCj4gIAlib29sIGhhc19tc3Rf
ZmlmbzsNCj4gKwlzdHJ1Y3QgaTJjX2FkYXB0ZXJfcXVpcmtzICpxdWlya3M7DQoNClRoaXMgY291
bGQgcGVyaGFwcyBiZSBhIHBvaW50ZXIgdG8gY29uc3Q/DQoNCj4gIH07DQo+ICANCj4gIC8qKg0K
PiBAQCAtODMzLDYgKzgzNCwxMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGkyY19hZGFwdGVyX3F1
aXJrcyB0ZWdyYV9pMmNfcXVpcmtzID0gew0KPiAgCS5tYXhfd3JpdGVfbGVuID0gNDA5NiwNCj4g
IH07DQo+ICANCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaTJjX2FkYXB0ZXJfcXVpcmtzIHRlZ3Jh
MTk0X2kyY19xdWlya3MgPSB7DQo+ICsJLmZsYWdzID0gSTJDX0FRX05PX1pFUk9fTEVOLA0KDQpU
aGlzIGlzIG5vdCBtZW50aW9uZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIGFuZCB0aGUgZmxhZyBp
cyBub3QgcHJlc2VudCBpbg0KdGhlIG9sZCBzdHJ1Y3QgdGVncmFfaTJjX3F1aXJrcyBhYm92ZS4g
QXJlIHlvdSB0cnlpbmcgdG8gc25lYWsgY2hhbmdlcyBwYXN0DQp0aGUgbWFpbnRhaW5lcnMsIG9y
IHdhcyB0aGUgY2hhbmdlIHNpbXBseSBub3QgaW50ZW50aW9uYWw/DQoNCj4gKwkubWF4X3JlYWRf
bGVuID0gNjU1MzYsDQo+ICsJLm1heF93cml0ZV9sZW4gPSA2NTUzNiwNCg0KVGhvc2UgYXJlIGhp
Z2hseSBkdWJpb3VzIHdoZW4gLm1heF9yZWFkX2xlbiBhbmQgLm1heF93cml0ZV9sZW4gYXJlIG9m
IHR5cGUNCnUxNi4gSSBiZXQgeW91IGNvdWxkIGp1c3QgcmVtb3ZlIHRoZW0uDQoNCkNoZWVycywN
ClBldGVyDQoNCj4gK307DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGVncmFfaTJjX2h3
X2ZlYXR1cmUgdGVncmEyMF9pMmNfaHcgPSB7DQo+ICAJLmhhc19jb250aW51ZV94ZmVyX3N1cHBv
cnQgPSBmYWxzZSwNCj4gIAkuaGFzX3Blcl9wa3RfeGZlcl9jb21wbGV0ZV9pcnEgPSBmYWxzZSwN
Cj4gQEAgLTg0NCw2ICs4NTEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHRlZ3JhX2kyY19od19m
ZWF0dXJlIHRlZ3JhMjBfaTJjX2h3ID0gew0KPiAgCS5oYXNfbXVsdGlfbWFzdGVyX21vZGUgPSBm
YWxzZSwNCj4gIAkuaGFzX3NsY2dfb3ZlcnJpZGVfcmVnID0gZmFsc2UsDQo+ICAJLmhhc19tc3Rf
ZmlmbyA9IGZhbHNlLA0KPiArCS5xdWlya3MgPSAmdGVncmFfaTJjX3F1aXJrcywNCj4gIH07DQo+
ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGVncmFfaTJjX2h3X2ZlYXR1cmUgdGVncmEzMF9p
MmNfaHcgPSB7DQo+IEBAIC04NTcsNiArODY1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB0ZWdy
YV9pMmNfaHdfZmVhdHVyZSB0ZWdyYTMwX2kyY19odyA9IHsNCj4gIAkuaGFzX211bHRpX21hc3Rl
cl9tb2RlID0gZmFsc2UsDQo+ICAJLmhhc19zbGNnX292ZXJyaWRlX3JlZyA9IGZhbHNlLA0KPiAg
CS5oYXNfbXN0X2ZpZm8gPSBmYWxzZSwNCj4gKwkucXVpcmtzID0gJnRlZ3JhX2kyY19xdWlya3Ms
DQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHRlZ3JhX2kyY19od19mZWF0dXJl
IHRlZ3JhMTE0X2kyY19odyA9IHsNCj4gQEAgLTg3MCw2ICs4NzksNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IHRlZ3JhX2kyY19od19mZWF0dXJlIHRlZ3JhMTE0X2kyY19odyA9IHsNCj4gIAkuaGFz
X211bHRpX21hc3Rlcl9tb2RlID0gZmFsc2UsDQo+ICAJLmhhc19zbGNnX292ZXJyaWRlX3JlZyA9
IGZhbHNlLA0KPiAgCS5oYXNfbXN0X2ZpZm8gPSBmYWxzZSwNCj4gKwkucXVpcmtzID0gJnRlZ3Jh
X2kyY19xdWlya3MsDQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHRlZ3JhX2ky
Y19od19mZWF0dXJlIHRlZ3JhMTI0X2kyY19odyA9IHsNCj4gQEAgLTg4Myw2ICs4OTMsNyBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IHRlZ3JhX2kyY19od19mZWF0dXJlIHRlZ3JhMTI0X2kyY19odyA9
IHsNCj4gIAkuaGFzX211bHRpX21hc3Rlcl9tb2RlID0gZmFsc2UsDQo+ICAJLmhhc19zbGNnX292
ZXJyaWRlX3JlZyA9IHRydWUsDQo+ICAJLmhhc19tc3RfZmlmbyA9IGZhbHNlLA0KPiArCS5xdWly
a3MgPSAmdGVncmFfaTJjX3F1aXJrcywNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgdGVncmFfaTJjX2h3X2ZlYXR1cmUgdGVncmEyMTBfaTJjX2h3ID0gew0KPiBAQCAtODk2LDYg
KzkwNyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGVncmFfaTJjX2h3X2ZlYXR1cmUgdGVncmEy
MTBfaTJjX2h3ID0gew0KPiAgCS5oYXNfbXVsdGlfbWFzdGVyX21vZGUgPSB0cnVlLA0KPiAgCS5o
YXNfc2xjZ19vdmVycmlkZV9yZWcgPSB0cnVlLA0KPiAgCS5oYXNfbXN0X2ZpZm8gPSBmYWxzZSwN
Cj4gKwkucXVpcmtzID0gJnRlZ3JhX2kyY19xdWlya3MsDQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMg
Y29uc3Qgc3RydWN0IHRlZ3JhX2kyY19od19mZWF0dXJlIHRlZ3JhMTk0X2kyY19odyA9IHsNCj4g
QEAgLTkwOSw2ICs5MjEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHRlZ3JhX2kyY19od19mZWF0
dXJlIHRlZ3JhMTk0X2kyY19odyA9IHsNCj4gIAkuaGFzX211bHRpX21hc3Rlcl9tb2RlID0gdHJ1
ZSwNCj4gIAkuaGFzX3NsY2dfb3ZlcnJpZGVfcmVnID0gdHJ1ZSwNCj4gIAkuaGFzX21zdF9maWZv
ID0gdHJ1ZSwNCj4gKwkucXVpcmtzID0gJnRlZ3JhMTk0X2kyY19xdWlya3MsDQo+ICB9Ow0KPiAg
DQo+ICAvKiBNYXRjaCB0YWJsZSBmb3Igb2ZfcGxhdGZvcm0gYmluZGluZyAqLw0KPiBAQCAtOTYw
LDcgKzk3Myw2IEBAIHN0YXRpYyBpbnQgdGVncmFfaTJjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ICAJaTJjX2Rldi0+YmFzZSA9IGJhc2U7DQo+ICAJaTJjX2Rldi0+ZGl2
X2NsayA9IGRpdl9jbGs7DQo+ICAJaTJjX2Rldi0+YWRhcHRlci5hbGdvID0gJnRlZ3JhX2kyY19h
bGdvOw0KPiAtCWkyY19kZXYtPmFkYXB0ZXIucXVpcmtzID0gJnRlZ3JhX2kyY19xdWlya3M7DQo+
ICAJaTJjX2Rldi0+aXJxID0gaXJxOw0KPiAgCWkyY19kZXYtPmNvbnRfaWQgPSBwZGV2LT5pZDsN
Cj4gIAlpMmNfZGV2LT5kZXYgPSAmcGRldi0+ZGV2Ow0KPiBAQCAtOTc2LDYgKzk4OCw4IEBAIHN0
YXRpYyBpbnQgdGVncmFfaTJjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICAJaTJjX2Rldi0+aHcgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoJnBkZXYtPmRldik7DQo+
ICAJaTJjX2Rldi0+aXNfZHZjID0gb2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUocGRldi0+ZGV2Lm9m
X25vZGUsDQo+ICAJCQkJCQkgICJudmlkaWEsdGVncmEyMC1pMmMtZHZjIik7DQo+ICsJaTJjX2Rl
di0+YWRhcHRlci5xdWlya3MgPSBpMmNfZGV2LT5ody0+cXVpcmtzOw0KPiArDQo+ICAJaW5pdF9j
b21wbGV0aW9uKCZpMmNfZGV2LT5tc2dfY29tcGxldGUpOw0KPiAgCXNwaW5fbG9ja19pbml0KCZp
MmNfZGV2LT54ZmVyX2xvY2spOw0KPiAgDQo+IA0KDQo=
