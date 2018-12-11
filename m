Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECABEC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BAC20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="CLxsWO5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BAC20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbeLKMAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:00:22 -0500
Received: from mail-eopbgr50105.outbound.protection.outlook.com ([40.107.5.105]:54748
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726313AbeLKMAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEjMIYNSAJ0EA9PRdYzTlEpjf9NH0XHL8zsjmukrVCk=;
 b=CLxsWO5VVyAzy3g767rCH0LgivTzLlKiIfPt8D/62u0Oa3QXW1wCFJiSVglUx4sZvx9Ivbj9inKF7b+9LBmFJQbqOyS4wFZiBBSBqppHAv3F7KPRi3LCVyrkH48/HG4MeD50Rpq1FSEEUCscRL3c0CtU25QFny9XS9XouSWMzNQ=
Received: from VI1PR07MB5088.eurprd07.prod.outlook.com (20.177.203.160) by
 VI1PR07MB5294.eurprd07.prod.outlook.com (20.178.10.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.12; Tue, 11 Dec 2018 12:00:15 +0000
Received: from VI1PR07MB5088.eurprd07.prod.outlook.com
 ([fe80::c6b:1f98:e4e9:7240]) by VI1PR07MB5088.eurprd07.prod.outlook.com
 ([fe80::c6b:1f98:e4e9:7240%3]) with mapi id 15.20.1425.016; Tue, 11 Dec 2018
 12:00:15 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>, Wolfram Sang <wsa@the-dreams.de>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 1/3] i2c-axxia: dedicated function to set client addr
Thread-Topic: [PATCH 1/3] i2c-axxia: dedicated function to set client addr
Thread-Index: AQHUkUkT89pz+xffdEmCTMXy//2Wmg==
Date:   Tue, 11 Dec 2018 12:00:15 +0000
Message-ID: <d20df4a6-72b7-ba84-a170-38fd4d6af892@nokia.com>
References: <cover.1544453688.git.krzysztof.adamski@nokia.com>
 <120bc3dbc7fad29807ff9f7c74575a66e6da15a6.1544453688.git.krzysztof.adamski@nokia.com>
In-Reply-To: <120bc3dbc7fad29807ff9f7c74575a66e6da15a6.1544453688.git.krzysztof.adamski@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.165]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
x-clientproxiedby: HE1PR0101CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::16) To VI1PR07MB5088.eurprd07.prod.outlook.com
 (2603:10a6:803:9e::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR07MB5294;6:Lg//PikqHJdtTHXAaU1rfK3FIFSDVNOUaD8j0pjppvX8gGw/FD4HG83Lkk6fpkbFeJpIbEODEvIiFML0UIaZGA/ZKeGjufqzeGeaAsMkitW8wOq//jrgpv7moU4Zd8gXqnCgEk5UPOBHJtAbBoWaJ58wGrZ0Fa7Q2YkiXCii8a/hjBN32LW63Ac7c/e2YlSZNQ75SR6UycriyGN0Mc2kHaqRoBDWHVqDNCgPDriFH9HOsUiRFg5tVD9sjmfLSSSMO6/ZnoduzgA8TGZ392NSW597LZ67O1INR9017HJRdjbbSWaU5t6fjJ7Ov+bCTyoiiGU2ea7BxzJv4PhBRce+aJ39V9sKtBCeywkjkJrIbF7KRH00ABFM2UOWfkudyFtbSfd2rz1SwUG/cOT16k+b1vtMXhgDDIjO8r31xGAAyg4lFFG53PKd78rQx8VdTjXpuAfK41FxI2FcSC4ZcZbTfg==;5:471OhUYPT5tT1O9ym/iRyUnTimswSwbuHQ5aHBtchFnJPSCRmEEf9BZpIEg9F2l698nedw+34/480JQd1jvMP+JDRaDiC4RV6zdZXySEYj4vQmE4uiUdoNIjbKlzKG8Ed8VB6xnfxaPErQlcHRTFMqr0vLqZkPISAO9Dkuvc968=;7:dtKAXRLSRE1wFQx4rOLp8NTJoZJsDz9X9M3+Q6vjkIjmLRMVqLDBXBsLvW4IDVqQS6G9QmWmBJQPyhm41FrK4KhgznjnOSH283JvCMo2k64IKu+kNEiXyLguAOalFAV83PLY1p5sXNVHr4DBWFrWog==
x-ms-office365-filtering-correlation-id: dd1a30d0-8fce-4514-0083-08d65f603642
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:VI1PR07MB5294;
x-ms-traffictypediagnostic: VI1PR07MB5294:
x-microsoft-antispam-prvs: <VI1PR07MB5294824806FDCE0F2D6FAE9788A60@VI1PR07MB5294.eurprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(11241501185)(806100)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR07MB5294;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB5294;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(346002)(366004)(199004)(189003)(476003)(110136005)(6246003)(36756003)(486006)(54906003)(11346002)(58126008)(7736002)(6512007)(446003)(305945005)(97736004)(26005)(256004)(65956001)(186003)(6486002)(66066001)(53546011)(6506007)(386003)(86362001)(3846002)(31686004)(6116002)(2616005)(52116002)(316002)(76176011)(102836004)(53936002)(5660300001)(25786009)(106356001)(99286004)(4326008)(65806001)(2906002)(81166006)(81156014)(14454004)(31696002)(65826007)(8676002)(8936002)(68736007)(105586002)(6436002)(478600001)(64126003)(71190400001)(229853002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB5294;H:VI1PR07MB5088.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9aBR7ORjGMKWgv0AFwLbyA+AddyOOkhwi6P7WzyCIgvX4aMla7JokaOcisGfIl7KZ0xU7Y191MrU8SztRU5Neq/XWZp/nSIyC+2JLeuwB/vNV7zXkbxGJ2fS9k5AdZwtVlhxAX/o5rdkF4rJZHA0iUEasPhZho2IDPHudKQy0DFe9qctMZZPNCtKjsV4Lik+mayg7fMIZ+WuufEwMq0N3YPiUbfqpSyGEjX4/boGWkoxsHb55KSu8BnaO9k4Mp2MPXlMv7nSdGMfJWLEVxinKpYwT9zH/oaXf4zqTnnZ4d12YQE0kleIu07EGIfaZpQx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <922590F27A3DD4439B6906E355884F5F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1a30d0-8fce-4514-0083-08d65f603642
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 12:00:15.4800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB5294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkhDQoNCk9uIDEwLzEyLzIwMTggMTY6MDAsIEFkYW1za2ksIEtyenlzenRvZiAoTm9raWEgLSBQ
TC9Xcm9jbGF3KSB3cm90ZToNCj4gVGhpcyBwYXRjaCBtb3ZlcyBjb25maWd1cmF0aW9uIG9mIGhh
cmR3YXJlIHJlZ2lzdGVycyB1c2VkIGZvciBzZXR0aW5nDQo+IGkyYyBjbGllbnQgYWRkcmVzcyB0
byBzZXBhcmF0ZSBmdW5jdGlvbi4gSXQgaXMgcHJlcGFyYXRvcnkgY2hhbmdlIGZvcg0KPiBuZXh0
IGNvbW1pdC4NCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2
ZXJkbGluQG5va2lhLmNvbT4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgQWRhbXNraSA8
a3J6eXN6dG9mLmFkYW1za2lAbm9raWEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaTJjL2J1c3Nl
cy9pMmMtYXh4aWEuYyB8IDI5ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1heHhpYS5jIGIvZHJpdmVycy9pMmMvYnVz
c2VzL2kyYy1heHhpYS5jDQo+IGluZGV4IDUxZDM0OTU5NzA5Yi4uZDM3Y2FmNjk0ZmJmIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWF4eGlhLmMNCj4gKysrIGIvZHJpdmVy
cy9pMmMvYnVzc2VzL2kyYy1heHhpYS5jDQo+IEBAIC0zMzcsMTcgKzMzNyw5IEBAIHN0YXRpYyBp
cnFyZXR1cm5fdCBheHhpYV9pMmNfaXNyKGludCBpcnEsIHZvaWQgKl9kZXYpDQo+ICAJcmV0dXJu
IElSUV9IQU5ETEVEOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW50IGF4eGlhX2kyY194ZmVyX21z
ZyhzdHJ1Y3QgYXh4aWFfaTJjX2RldiAqaWRldiwgc3RydWN0IGkyY19tc2cgKm1zZykNCj4gK3N0
YXRpYyB2b2lkIGF4eGlhX2kyY19zZXRfYWRkcihzdHJ1Y3QgYXh4aWFfaTJjX2RldiAqaWRldiwg
c3RydWN0IGkyY19tc2cgKm1zZykNCj4gIHsNCj4gLQl1MzIgaW50X21hc2sgPSBNU1RfU1RBVFVT
X0VSUiB8IE1TVF9TVEFUVVNfU05TOw0KPiAtCXUzMiByeF94ZmVyLCB0eF94ZmVyOw0KPiAgCXUz
MiBhZGRyXzEsIGFkZHJfMjsNCj4gLQl1bnNpZ25lZCBsb25nIHRpbWVfbGVmdDsNCj4gLQl1bnNp
Z25lZCBpbnQgd3RfdmFsdWU7DQo+IC0NCj4gLQlpZGV2LT5tc2cgPSBtc2c7DQo+IC0JaWRldi0+
bXNnX3hmcmQgPSAwOw0KPiAtCXJlaW5pdF9jb21wbGV0aW9uKCZpZGV2LT5tc2dfY29tcGxldGUp
Ow0KPiAgDQo+ICAJaWYgKGkyY19tX3Rlbihtc2cpKSB7DQo+ICAJCS8qIDEwLWJpdCBhZGRyZXNz
DQo+IEBAIC0zNjcsNiArMzU5LDIzIEBAIHN0YXRpYyBpbnQgYXh4aWFfaTJjX3hmZXJfbXNnKHN0
cnVjdCBheHhpYV9pMmNfZGV2ICppZGV2LCBzdHJ1Y3QgaTJjX21zZyAqbXNnKQ0KPiAgCQlhZGRy
XzIgPSAwOw0KPiAgCX0NCj4gIA0KPiArCXdyaXRlbChhZGRyXzEsIGlkZXYtPmJhc2UgKyBNU1Rf
QUREUl8xKTsNCj4gKwl3cml0ZWwoYWRkcl8yLCBpZGV2LT5iYXNlICsgTVNUX0FERFJfMik7DQo+
ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgYXh4aWFfaTJjX3hmZXJfbXNnKHN0cnVjdCBheHhpYV9p
MmNfZGV2ICppZGV2LCBzdHJ1Y3QgaTJjX21zZyAqbXNnKQ0KPiArew0KPiArCXUzMiBpbnRfbWFz
ayA9IE1TVF9TVEFUVVNfRVJSIHwgTVNUX1NUQVRVU19TTlM7DQo+ICsJdTMyIHJ4X3hmZXIsIHR4
X3hmZXI7DQo+ICsJdW5zaWduZWQgbG9uZyB0aW1lX2xlZnQ7DQo+ICsJdW5zaWduZWQgaW50IHd0
X3ZhbHVlOw0KPiArDQo+ICsJaWRldi0+bXNnID0gbXNnOw0KPiArCWlkZXYtPm1zZ194ZnJkID0g
MDsNCj4gKwlyZWluaXRfY29tcGxldGlvbigmaWRldi0+bXNnX2NvbXBsZXRlKTsNCj4gKw0KPiAr
CWF4eGlhX2kyY19zZXRfYWRkcihpZGV2LCBtc2cpOw0KPiArDQo+ICAJaWYgKGkyY19tX3JkKG1z
ZykpIHsNCj4gIAkJLyogSTJDIHJlYWQgdHJhbnNmZXIgKi8NCj4gIAkJcnhfeGZlciA9IGkyY19t
X3JlY3ZfbGVuKG1zZykgPyBJMkNfU01CVVNfQkxPQ0tfTUFYIDogbXNnLT5sZW47DQo+IEBAIC0z
NzksOCArMzg4LDYgQEAgc3RhdGljIGludCBheHhpYV9pMmNfeGZlcl9tc2coc3RydWN0IGF4eGlh
X2kyY19kZXYgKmlkZXYsIHN0cnVjdCBpMmNfbXNnICptc2cpDQo+ICANCj4gIAl3cml0ZWwocnhf
eGZlciwgaWRldi0+YmFzZSArIE1TVF9SWF9YRkVSKTsNCj4gIAl3cml0ZWwodHhfeGZlciwgaWRl
di0+YmFzZSArIE1TVF9UWF9YRkVSKTsNCj4gLQl3cml0ZWwoYWRkcl8xLCBpZGV2LT5iYXNlICsg
TVNUX0FERFJfMSk7DQo+IC0Jd3JpdGVsKGFkZHJfMiwgaWRldi0+YmFzZSArIE1TVF9BRERSXzIp
Ow0KPiAgDQo+ICAJaWYgKGkyY19tX3JkKG1zZykpDQo+ICAJCWludF9tYXNrIHw9IE1TVF9TVEFU
VVNfUkZMOw0KDQotLSANCkJlc3QgcmVnYXJkcywNCkFsZXhhbmRlciBTdmVyZGxpbi4NCg==
