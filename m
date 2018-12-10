Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C51C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F292084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Ph+4YOFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F292084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbeLJVwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:52:15 -0500
Received: from mail-eopbgr70121.outbound.protection.outlook.com ([40.107.7.121]:61879
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726392AbeLJVwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tp5J5aFnIS3yRqo8YUnjwuRLWDoCThdErOGfbdjoJU=;
 b=Ph+4YOFxD0iUGY+dNgK2cEAwzn5uMduUFt3FKgJvOn1Lrorpkes3WHRr6H1M6XEDcLXUM6U1gPe2KwjWuumGVoGWDojODQP9jYTMuUcu13dbIaoT9HkBGygbVefcT6oKRUkmrYrGxmQ2BMVRO+dnHyYuOwUqEOUvY8fkgIW+l4c=
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com (20.178.13.204) by
 VI1PR02MB1437.eurprd02.prod.outlook.com (10.165.232.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Mon, 10 Dec 2018 21:52:07 +0000
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39]) by VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39%3]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 21:52:07 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT 10/10] i2c: rcar: add suspend/resume support
Thread-Topic: [RFC/RFT 10/10] i2c: rcar: add suspend/resume support
Thread-Index: AQHUkMvXHJjKBWzIgky4qjb6tCVvP6V4g5QA
Date:   Mon, 10 Dec 2018 21:52:07 +0000
Message-ID: <944a2523-aa40-eaf2-2c4a-d27254e7cbca@axentia.se>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <20181210210310.12677-11-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181210210310.12677-11-wsa+renesas@sang-engineering.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR02CA0086.eurprd02.prod.outlook.com
 (2603:10a6:7:29::15) To VI1PR02MB5119.eurprd02.prod.outlook.com
 (2603:10a6:803:b7::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB1437;6:JIGjfuUK6ae2yHfmfbP4IOxV0koSvicWm3gfdg9mgpUDo5yRL4gpzhMyub6Ihg8FChmWnVb82pxlf8QMIJIwzgDqwnaqu8kv4WRN8zFXdyBb+61DXEKtUJSxgN7Z8k1sJc0UAri+6gRygHPBbdtd0cLvDmNd4OOX68FOB4VeHtnTjs5Tqi4fafmnCuU8Jja//xXxowYa7ttECqjrY5A9th7rTSPiUUy9y662lFWhvgxLBEBxNxpC0TvPeSB/KOsbctG53lyGAipBCithpAI7wdKPPVzO2Ws50gT0kxycUGZDGrqEtUsjhG5yuFbIs4gxg6bGpg8U4+VfWmTbNuXsQc5M4jsWOTm4v/0cmotks320gEnNg7jNbo4bfycLKgygbzWIErtsxEFbDBsszgh7OMpEtnJBT/8QFpSaPY9cskxY815MxQRIAljH1C6cnn1WzUKMXzFxEuC8kmmAl0aFVg==;5:mpO41CEhNusWh5D5ztArIhf/8MPuN8w522/JMX6yPCyWGD0Ijs2xHZ0uXOGaJM96wpY/nHBmCIiJGNclS71uGm/XLsy0/9ZwUj8BwLjddenMjn/+RW4TLKwUNK8nbXMg+ih3CH0mXUxML4lQPwfhfQnLaCVqLPvqy3Q7B4KSzHY=;7:ap630b0ycCUTUS5eZp9Q+IpBB7wAs2/Nbp95Q9LbyhJvWUZ3c8/jE9z1bq1Xo/UECQi22dQ/hMc/stwoEaeVbk+7Xb3EIFHo4f67EafGF2D54PBCkIWTLG4tSBFI4mioKP8c43Y7o/fnpo/DG3/NZA==
x-ms-office365-filtering-correlation-id: c4cec689-1f56-4628-3daf-08d65ee9ba6a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB1437;
x-ms-traffictypediagnostic: VI1PR02MB1437:
x-microsoft-antispam-prvs: <VI1PR02MB1437DF50045DAFCB29B8DD2DBCA50@VI1PR02MB1437.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR02MB1437;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB1437;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(39830400003)(366004)(346002)(199004)(189003)(99286004)(6116002)(6506007)(6486002)(53546011)(6436002)(386003)(102836004)(54906003)(110136005)(52116002)(6512007)(31696002)(229853002)(14444005)(256004)(68736007)(3846002)(25786009)(5660300001)(58126008)(26005)(2906002)(14454004)(316002)(186003)(575784001)(86362001)(76176011)(7736002)(71190400001)(508600001)(486006)(8676002)(36756003)(97736004)(65806001)(65956001)(64126003)(105586002)(2616005)(66066001)(81156014)(4001150100001)(15650500001)(11346002)(446003)(8936002)(81166006)(71200400001)(476003)(106356001)(65826007)(74482002)(551934003)(2501003)(4326008)(53936002)(305945005)(6246003)(31686004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB1437;H:VI1PR02MB5119.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: S+d56y/DhT/VfCOWF+kXzsgxjsZEzWMRfuw38ALSsl09NyTs4pjnMRHbALzGOR92EL3RvjYxsAK9hRdBx24bxmufja9S64DeNf6lwpeLmz+wN+99R1yIwHOcweX7j2RniJQLGILjt89jPAs8P0PhxAwXcMevrizppDRnRafclUHdnLixwg9Ls3Fpop/UnpzuSQXenRuwRtW5aHK4BEVzLG45rD8gQ/GWxXE0ObzDPyoQceItAuvX0OUB6zOdW+RGVGzQHsn8yJ34fmp8DaHPAWVCSExEbdc6EgKa8EC66/Fk1hRQneQtUR79lpXcP+h1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <982E3174F51E754C9161B38295326863@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cec689-1f56-4628-3daf-08d65ee9ba6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 21:52:07.3443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB1437
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMi0xMCAyMjowMywgV29sZnJhbSBTYW5nIHdyb3RlOg0KPiBCZWNhdXNlIHRoZSBh
ZGFwdGVyIHdpbGwgYmUgc2V0IHVwIGJlZm9yZSBldmVyeSB0cmFuc2FjdGlvbiBhbnlob3csIHdl
DQo+IGp1c3QgbmVlZCB0byBtYXJrIGl0IGFzIGFkYXB0ZWQgdG8gdGhlIEkyQyBjb3JlLg0KDQpt
YXJrIGl0IGFzICJzdXNwZW5kZWQiLCBub3QgImFkYXB0ZWQiPw0KDQpDaGVlcnMsDQpQZXRlcg0K
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIaXJvbWl0c3UgWWFtYXNha2kgPGhpcm9taXRzdS55YW1h
c2FraS55bUByZW5lc2FzLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogV29sZnJhbSBTYW5nIDx3c2Er
cmVuZXNhc0BzYW5nLWVuZ2luZWVyaW5nLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2kyYy9idXNz
ZXMvaTJjLXJjYXIuYyB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMv
YnVzc2VzL2kyYy1yY2FyLmMgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLXJjYXIuYw0KPiBpbmRl
eCAyNTRlNjIxOWU1MzguLjMwY2ZmMDY2ZTBkYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pMmMv
YnVzc2VzL2kyYy1yY2FyLmMNCj4gKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1yY2FyLmMN
Cj4gQEAgLTEwMTcsMTAgKzEwMTcsMzUgQEAgc3RhdGljIGludCByY2FyX2kyY19yZW1vdmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiAr
I2lmZGVmIENPTkZJR19QTV9TTEVFUA0KPiArc3RhdGljIGludCByY2FyX2kyY19zdXNwZW5kKHN0
cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgcmNhcl9pMmNfcHJpdiAqcHJpdiA9
IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArDQo+ICsJaTJjX21hcmtfYWRhcHRlcl9zdXNwZW5k
ZWQoJnByaXYtPmFkYXAsIHRydWUpOw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0
aWMgaW50IHJjYXJfaTJjX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+ICsJc3Ry
dWN0IHJjYXJfaTJjX3ByaXYgKnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKw0KPiAr
CWkyY19tYXJrX2FkYXB0ZXJfc3VzcGVuZGVkKCZwcml2LT5hZGFwLCBmYWxzZSk7DQo+ICsJcmV0
dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBTSU1QTEVfREVWX1BNX09QUyhyY2FyX2kyY19w
bV9vcHMsIHJjYXJfaTJjX3N1c3BlbmQsIHJjYXJfaTJjX3Jlc3VtZSk7DQo+ICsNCj4gKyNkZWZp
bmUgREVWX1BNX09QUyAoJnJjYXJfaTJjX3BtX29wcykNCj4gKyNlbHNlDQo+ICsjZGVmaW5lIERF
Vl9QTV9PUFMgTlVMTA0KPiArI2VuZGlmIC8qIENPTkZJR19QTV9TTEVFUCAqLw0KPiArDQo+ICBz
dGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciByY2FyX2kyY19kcml2ZXIgPSB7DQo+ICAJLmRy
aXZlcgk9IHsNCj4gIAkJLm5hbWUJPSAiaTJjLXJjYXIiLA0KPiAgCQkub2ZfbWF0Y2hfdGFibGUg
PSByY2FyX2kyY19kdF9pZHMsDQo+ICsJCS5wbQk9IERFVl9QTV9PUFMsDQo+ICAJfSwNCj4gIAku
cHJvYmUJCT0gcmNhcl9pMmNfcHJvYmUsDQo+ICAJLnJlbW92ZQkJPSByY2FyX2kyY19yZW1vdmUs
DQo+IA0KDQo=
