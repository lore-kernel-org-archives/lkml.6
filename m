Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60031C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C132082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="cGL20Jfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C132082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbeLKMFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:05:31 -0500
Received: from mail-eopbgr80138.outbound.protection.outlook.com ([40.107.8.138]:16754
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbeLKMFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRHGor/D/g9bLtNih4mZw7AFQvB2ThzbjyOXlJk11jY=;
 b=cGL20Jfh0DdkJO8indfin2mLTYF2zsmLhmOHQ6hVLTJOfudntyeQm57C+TSHbgmtDZx2Q5mBbl5KwJzY3BD5H6UgAyI4cmfI/jC7U2nAuzMu3NwaGU4LrQ+hjrYbr+rwW5RXZuBo95NHtkrft5KK5zh5KxKFypziaaOTx9IVHLM=
Received: from VI1PR07MB5088.eurprd07.prod.outlook.com (20.177.203.160) by
 VI1PR07MB5679.eurprd07.prod.outlook.com (20.178.120.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.9; Tue, 11 Dec 2018 12:02:32 +0000
Received: from VI1PR07MB5088.eurprd07.prod.outlook.com
 ([fe80::c6b:1f98:e4e9:7240]) by VI1PR07MB5088.eurprd07.prod.outlook.com
 ([fe80::c6b:1f98:e4e9:7240%3]) with mapi id 15.20.1425.016; Tue, 11 Dec 2018
 12:02:32 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>, Wolfram Sang <wsa@the-dreams.de>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 2/3] i2c-axxia: check for error conditions first
Thread-Topic: [PATCH 2/3] i2c-axxia: check for error conditions first
Thread-Index: AQHUkUlly6ofdoCytkCGi3pQTiTTTw==
Date:   Tue, 11 Dec 2018 12:02:32 +0000
Message-ID: <bb305008-f552-b7d0-49f6-daf76a827e1f@nokia.com>
References: <cover.1544453688.git.krzysztof.adamski@nokia.com>
 <d9a8070357973b5078dc897a18f319cba1df5de0.1544453688.git.krzysztof.adamski@nokia.com>
In-Reply-To: <d9a8070357973b5078dc897a18f319cba1df5de0.1544453688.git.krzysztof.adamski@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.165]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
x-clientproxiedby: HE1PR05CA0383.eurprd05.prod.outlook.com
 (2603:10a6:7:94::42) To VI1PR07MB5088.eurprd07.prod.outlook.com
 (2603:10a6:803:9e::32)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR07MB5679;6:Thmtj9BWjUQUjOUFSmattJPfZ+IzxxTxcvfecApmD3ky5QqF1EwKUQIceeRwNHYvl34EsfYtOZmC4zoAnj1WKxXrQxBAFpch59ExL/u4CuJ0oVO8hSVnIZh2qy/84RhpSge0Wg0uEjuwhlqF4LgdOExdS8jzOk/b/fjz6otNh7bCXMq0hJnKp5lI/3qH3snh21v3G11Pkr0u/i9SKXH5CSDsYQc+m7qxT8NbUAxe/EoMd/NRfbK+GiLAolvgFj84H7Xedoi4tv99dQTZbw+4okp3IXtka2pGsGJPjGG4BotE+bE6EbUQSJE24ObtmYVpgkNBqAmHXNdQY3pJ3TUbIpgCy9U5OkKhKMi0PfKda1KL8Oeq2tUkIPZK0doWAv74bTxg+wm10aaZons+sLYRGVNlIn3o7EJclB0J40qKo+XDfjMHYUaHAy8WUrGatRqQDmdRums/DpbyAkeRmNuegQ==;5:PO0hDC78fceq60jVfROu0f31bXEhMKR8FTN86nA9UKR0hhAGUwzSBYQ8zqG7udbfWW3DHKSkZEhpBjrIYOmw6nlM31NLQH84eFtTXqmYFjfLuxkuz2W3tONVv7QoM3Kwqgs+egtVwauy69FnJjVsVHkm5KP+t5dDUhl4SPy8m+k=;7:6/M9UVOlm7yQ9CFIiHW8Geu0Sye95Mlqr9PYcaBqLwvHCrZuRi/9pjBiW+LDdtWd2Fyb9gl/Sh5R1SKZTU3GyzDslcZvZhlJqeVFwS728H+wR16LL60hTHGlMm4HOU22mad9OFKfpp0N0I3YNAG0Kg==
x-ms-office365-filtering-correlation-id: 16cfaad2-4414-4715-a042-08d65f6087b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:VI1PR07MB5679;
x-ms-traffictypediagnostic: VI1PR07MB5679:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-microsoft-antispam-prvs: <VI1PR07MB567945EDCF5741B36891ECD688A60@VI1PR07MB5679.eurprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(11241501185)(806100)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231472)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR07MB5679;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB5679;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(136003)(366004)(39860400002)(189003)(199004)(76176011)(97736004)(106356001)(52116002)(71190400001)(71200400001)(5660300001)(105586002)(31686004)(486006)(54906003)(86362001)(6116002)(2906002)(6512007)(31696002)(316002)(110136005)(58126008)(68736007)(8676002)(186003)(7736002)(53546011)(6486002)(53936002)(446003)(3846002)(478600001)(102836004)(6246003)(2616005)(6436002)(81156014)(11346002)(305945005)(6506007)(386003)(64126003)(81166006)(66066001)(4326008)(14454004)(99286004)(25786009)(8936002)(229853002)(36756003)(26005)(256004)(14444005)(65806001)(65956001)(476003)(65826007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB5679;H:VI1PR07MB5088.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NnlZYZLHHrM95M/jy8RQAeCNCqk614W20fRtMIz1veXGBUyc9mrUUcUQsNZWez8OsmmqDk7M/c/HYerHMFrU4BKpMSXalyoTzqkJDZMCkHEfZ4qAjHyDjD6Y9760v8z1KvA7Xymx/zzQ7rKf5LNr2Ev6ZXBX9EOnu0wkKn/MGv+LHLLHeR4FsqQNIL9qNtZv8FbVWg6076ExXErjX9mv2caAKvB3GKklDeZ3GoZpdqnELghxG4ZKTsO4TQa142JPoLPajRRfMngdhRYqMM/uk5QfDCq977KQUFQaAtQ9fWz1p4pI+bvrvjicvOQ/BRgv
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2411DC2DB501F04FB6E5161538A5323A@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16cfaad2-4414-4715-a042-08d65f6087b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 12:02:32.0643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB5679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkhDQoNCk9uIDEwLzEyLzIwMTggMTY6MDEsIEFkYW1za2ksIEtyenlzenRvZiAoTm9raWEgLSBQ
TC9Xcm9jbGF3KSB3cm90ZToNCj4gSXQgd2FzIG9ic2VydmVkIHRoYXQgd2hlbiB1c2luZyBzZXFl
bnRpb25hbCBtb2RlIGNvbnRyYXJ5IHRvIHRoZQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5eXl5eXl5eXl5eDQo+IGRvY3VtZW50YXRpb24sIHRoZSBTUyBiaXQgKHdoaWNoIGlz
IHN1cHBvc2VkIHRvIG9ubHkgYmUgc2V0IGlmDQo+IGF1dG9tYXRpYy9zZXF1ZW5jZSBjb21tYW5k
IGNvbXBsZXRlZCBub3JtYWxseSksIGlzIHNvbWV0aW1lcyBzZXQNCj4gdG9nZXRoZXIgd2l0aCBO
QSAoTkFLIGluIGFkZHJlc3MgcGhhc2UpIGNhdXNpbmcgdHJhbnNmZXIgdG8gZmFsc2VseSBiZQ0K
PiBjb25zaWRlcmVkIHN1Y2Nlc3NmdWwuDQo+IA0KPiBNeSBhc3N1bXB0aW9uIGlzIHRoYXQgdGhp
cyBkb2VzIG5vdCBoYXBwZW4gZHVyaW5nIG1hbnVhbCBtb2RlIHNpbmNlIHRoZQ0KPiBjb250cm9s
bGVyIGlzIHN0b3BwaW5nIGl0cyB3b3JrIHRoZSBtb21lbnQgaXQgc2V0cyBOQS9ORCBiaXQgaW4g
c3RhdHVzDQo+IHJlZ2lzdGVyLiBUaGlzIGlzIG5vdCB0aGUgY2FzZSBpbiBBdXRvbWF0aWMvU2Vx
dWVudGlvbmFsIG1vZGUgd2hlcmUgaXQNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBeXl5eXl5eXl5eXl4NCj4gaXMgc3RpbGwgd29ya2luZyB0byBzZW5kIFNU
T1AgY29uZGl0aW9uIGFuZCB0aGUgYWN0dWFsIHN0YXR1cyB3ZSBnZXQNCj4gZGVwZW5kcyBvbiB0
aGUgdGltZSB3aGVuIHRoZSBJU1IgaXMgcnVuLg0KPiANCj4gVGhpcyBwYXRjaCBjaGFuZ2VzIHRo
ZSBvcmRlciBvZiBjaGVja2luZyBzdGF0dXMgYml0cyBpbiBJU1IgLSBlcnJvcg0KPiBjb25kaXRp
b25zIGFyZSBjaGVja2VkIGZpcnN0IGFuZCBvbmx5IGlmIG5vbmUgb2YgdGhlbSBvY2N1cnJlZCwg
dGhlDQo+IHRyYW5zZmVyIG1heSBiZSBjb25zaWRlcmVkIHN1Y2Nlc3NmdWwuIFRoaXMgaXMgcmVx
dWlyZWQgdG8gaW50cm9kdWNlDQo+IHVzaW5nIG9mIHNlcXVlbnRpb25hbCBtb2RlIGluIG5leHQg
cGF0Y2guDQogICAgICAgICAgIF5eXl5eXl5eXl5eXg0Kc2VxdWVudGlhbA0KDQpSZXZpZXdlZC1i
eTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Abm9raWEuY29tPg0KDQo+
IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBBZGFtc2tpIDxrcnp5c3p0b2YuYWRhbXNraUBub2tp
YS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1heHhpYS5jIHwgMzIgKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNl
cnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2ky
Yy9idXNzZXMvaTJjLWF4eGlhLmMgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWF4eGlhLmMNCj4g
aW5kZXggZDM3Y2FmNjk0ZmJmLi4zNTI1ODMyMWU4MWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
aTJjL2J1c3Nlcy9pMmMtYXh4aWEuYw0KPiArKysgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWF4
eGlhLmMNCj4gQEAgLTI5NiwyMiArMjk2LDcgQEAgc3RhdGljIGlycXJldHVybl90IGF4eGlhX2ky
Y19pc3IoaW50IGlycSwgdm9pZCAqX2RldikNCj4gIAkJCWkyY19pbnRfZGlzYWJsZShpZGV2LCBN
U1RfU1RBVFVTX1RGTCk7DQo+ICAJfQ0KPiAgDQo+IC0JaWYgKHN0YXR1cyAmIE1TVF9TVEFUVVNf
U0NDKSB7DQo+IC0JCS8qIFN0b3AgY29tcGxldGVkICovDQo+IC0JCWkyY19pbnRfZGlzYWJsZShp
ZGV2LCB+TVNUX1NUQVRVU19UU1MpOw0KPiAtCQljb21wbGV0ZSgmaWRldi0+bXNnX2NvbXBsZXRl
KTsNCj4gLQl9IGVsc2UgaWYgKHN0YXR1cyAmIE1TVF9TVEFUVVNfU05TKSB7DQo+IC0JCS8qIFRy
YW5zZmVyIGRvbmUgKi8NCj4gLQkJaTJjX2ludF9kaXNhYmxlKGlkZXYsIH5NU1RfU1RBVFVTX1RT
Uyk7DQo+IC0JCWlmIChpMmNfbV9yZChpZGV2LT5tc2cpICYmIGlkZXYtPm1zZ194ZnJkIDwgaWRl
di0+bXNnLT5sZW4pDQo+IC0JCQlheHhpYV9pMmNfZW1wdHlfcnhfZmlmbyhpZGV2KTsNCj4gLQkJ
Y29tcGxldGUoJmlkZXYtPm1zZ19jb21wbGV0ZSk7DQo+IC0JfSBlbHNlIGlmIChzdGF0dXMgJiBN
U1RfU1RBVFVTX1RTUykgew0KPiAtCQkvKiBUcmFuc2ZlciB0aW1lb3V0ICovDQo+IC0JCWlkZXYt
Pm1zZ19lcnIgPSAtRVRJTUVET1VUOw0KPiAtCQlpMmNfaW50X2Rpc2FibGUoaWRldiwgfk1TVF9T
VEFUVVNfVFNTKTsNCj4gLQkJY29tcGxldGUoJmlkZXYtPm1zZ19jb21wbGV0ZSk7DQo+IC0JfSBl
bHNlIGlmICh1bmxpa2VseShzdGF0dXMgJiBNU1RfU1RBVFVTX0VSUikpIHsNCj4gKwlpZiAodW5s
aWtlbHkoc3RhdHVzICYgTVNUX1NUQVRVU19FUlIpKSB7DQo+ICAJCS8qIFRyYW5zZmVyIGVycm9y
ICovDQo+ICAJCWkyY19pbnRfZGlzYWJsZShpZGV2LCB+MCk7DQo+ICAJCWlmIChzdGF0dXMgJiBN
U1RfU1RBVFVTX0FMKQ0KPiBAQCAtMzI4LDYgKzMxMywyMSBAQCBzdGF0aWMgaXJxcmV0dXJuX3Qg
YXh4aWFfaTJjX2lzcihpbnQgaXJxLCB2b2lkICpfZGV2KQ0KPiAgCQkJcmVhZGwoaWRldi0+YmFz
ZSArIE1TVF9UWF9CWVRFU19YRlJEKSwNCj4gIAkJCXJlYWRsKGlkZXYtPmJhc2UgKyBNU1RfVFhf
WEZFUikpOw0KPiAgCQljb21wbGV0ZSgmaWRldi0+bXNnX2NvbXBsZXRlKTsNCj4gKwl9IGVsc2Ug
aWYgKHN0YXR1cyAmIE1TVF9TVEFUVVNfU0NDKSB7DQo+ICsJCS8qIFN0b3AgY29tcGxldGVkICov
DQo+ICsJCWkyY19pbnRfZGlzYWJsZShpZGV2LCB+TVNUX1NUQVRVU19UU1MpOw0KPiArCQljb21w
bGV0ZSgmaWRldi0+bXNnX2NvbXBsZXRlKTsNCj4gKwl9IGVsc2UgaWYgKHN0YXR1cyAmIE1TVF9T
VEFUVVNfU05TKSB7DQo+ICsJCS8qIFRyYW5zZmVyIGRvbmUgKi8NCj4gKwkJaTJjX2ludF9kaXNh
YmxlKGlkZXYsIH5NU1RfU1RBVFVTX1RTUyk7DQo+ICsJCWlmIChpMmNfbV9yZChpZGV2LT5tc2cp
ICYmIGlkZXYtPm1zZ194ZnJkIDwgaWRldi0+bXNnLT5sZW4pDQo+ICsJCQlheHhpYV9pMmNfZW1w
dHlfcnhfZmlmbyhpZGV2KTsNCj4gKwkJY29tcGxldGUoJmlkZXYtPm1zZ19jb21wbGV0ZSk7DQo+
ICsJfSBlbHNlIGlmIChzdGF0dXMgJiBNU1RfU1RBVFVTX1RTUykgew0KPiArCQkvKiBUcmFuc2Zl
ciB0aW1lb3V0ICovDQo+ICsJCWlkZXYtPm1zZ19lcnIgPSAtRVRJTUVET1VUOw0KPiArCQlpMmNf
aW50X2Rpc2FibGUoaWRldiwgfk1TVF9TVEFUVVNfVFNTKTsNCj4gKwkJY29tcGxldGUoJmlkZXYt
Pm1zZ19jb21wbGV0ZSk7DQo+ICAJfQ0KPiAgDQo+ICBvdXQ6DQo+IA0KDQotLSANCkJlc3QgcmVn
YXJkcywNCkFsZXhhbmRlciBTdmVyZGxpbi4NCg==
