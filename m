Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A30ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1742089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CTbPg6Gi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1742089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbeGNCLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 22:11:17 -0400
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:26662
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729771AbeGNCLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 22:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlzWJ9H7ADoLvLrl+VLLWckr1IuGHkCtES5q1YyrmJE=;
 b=CTbPg6GiKl4shzZho51rf1PaTfb50zUGqY6NoIA0clAFV6HFCPg0GHdNVO+HQVspPrRYWxsQlcEqNHtFH+bgT4Wkf1kcHTvsWmTJCVAqS5cvt60az3Wgx0ROYknyazuGT2UM5Ouwixafy/oGMMlu312A4yTHd9bFVYa8Khbaplo=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB1219.eurprd04.prod.outlook.com (10.163.6.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Sat, 14 Jul 2018 01:53:58 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%7]) with mapi id 15.20.0952.017; Sat, 14 Jul 2018
 01:53:58 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] gpio: mxc: add power management support
Thread-Topic: [PATCH] gpio: mxc: add power management support
Thread-Index: AQHUGCMO6gaWWTJtjkmf4RNIPMA6nKSNf7wAgAB6AnA=
Date:   Sat, 14 Jul 2018 01:53:57 +0000
Message-ID: <AM3PR04MB131577674FDF0BC65BEF518EF55F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1531208921-23342-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BSt4jdLWmXjNmTDAegGwtRWjbMuVAwdrnRyHWvSBuU5A@mail.gmail.com>
In-Reply-To: <CAOMZO5BSt4jdLWmXjNmTDAegGwtRWjbMuVAwdrnRyHWvSBuU5A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1219;7:buGh08+9XpXSFk/r3MKKmRcZEf3aAsv1zO3sRP/TuJNoomiFjKdcgmjvENMPZggOQRBYfM+XzpOm9Meh4/CouzYqC2AjXRpgKGdGhkV36uIfCb7gdG2FEpXjwh1vgS/DFBmfKkdUdwvPPjqqgyTL4mGD7Wsq2QC834LX+u4Z0chFwqgXjDW6h7argV9sW2eVeuAnOOZdJGkT4pswV8pJMt0S5kOefBT8pjNS4AcZ2L9Vs/GLyhSSba+oGrkYBz54
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 381445b0-1121-41b5-d2be-08d5e92ca9eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1219;
x-ms-traffictypediagnostic: AM3PR04MB1219:
x-microsoft-antispam-prvs: <AM3PR04MB121957530301BE4817AC08DEF55F0@AM3PR04MB1219.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1219;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1219;
x-forefront-prvs: 07334CBCCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(366004)(13464003)(199004)(189003)(9686003)(55016002)(33656002)(478600001)(2906002)(305945005)(7736002)(74316002)(229853002)(97736004)(54906003)(53546011)(256004)(14444005)(6436002)(99286004)(86362001)(102836004)(14454004)(6506007)(186003)(486006)(316002)(476003)(11346002)(44832011)(26005)(446003)(76176011)(1411001)(68736007)(5660300001)(5250100002)(25786009)(7696005)(6246003)(8936002)(8676002)(2900100001)(81156014)(106356001)(81166006)(105586002)(66066001)(6116002)(4326008)(3846002)(39060400002)(53936002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1219;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GzlhrEW2AmQ79ylIStDjpXuBkLwZr3taR1mBQUwWY8c661RuW8qsvtGFMruWPqEEWz1P/m/DPzyab5BVVatxx7YF1IOJO9hgJM3rgqDC+UOTpOvnWsJr0okG7oJXeU2iMzusLZ+kfxlSYBx0TFK9UKQAc1e5GqWtMU7pycpBdEJpyTAdTwcU3uOu3AWeM7DC42Qi8O5JpQbXgY1PdiQCWeo5zkq/gR/AQl0nTT2BSVURlscqw3bQV1KWWLNzNpe9GjlTX4bF76KogLP2//kcwze6x0S407GQ41MG/cAzzBa3niI4QfiOixbaS49JwTLxrMhCM7iG8msNxMwD4FRxVmyz46cV7dfVIhwKJVefPkc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381445b0-1121-41b5-d2be-08d5e92ca9eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2018 01:53:58.0029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCkFuc29uIEh1YW5nDQpCZXN0IFJlZ2FyZHMhDQoNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWlsdG86ZmVzdGV2YW1A
Z21haWwuY29tXQ0KPiBTZW50OiBTYXR1cmRheSwgSnVseSAxNCwgMjAxOCAyOjM0IEFNDQo+IFRv
OiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IExpbnVzIFdhbGxlaWog
PGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz47IG9wZW4gbGlzdDpHUElPIFNVQlNZU1RFTQ0KPiA8
bGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1rZXJuZWwgPGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc+Ow0KPiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIXSBncGlvOiBteGM6IGFkZCBwb3dlciBtYW5hZ2VtZW50IHN1cHBv
cnQNCj4gDQo+IEhpIEFuc29uLA0KPiANCj4gT24gVHVlLCBKdWwgMTAsIDIwMTggYXQgNDo0OCBB
TSwgQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+IHdyb3RlOg0KPiA+IEdQSU8g
cmVnaXN0ZXJzIGNvdWxkIGxvc2UgY29udGV4dCBvbiBzb21lIGkuTVggU29DcywgbGlrZSBvbiBp
Lk1YN0QsDQo+ID4gd2hlbiBlbnRlciBMUFNSIG1vZGUsIHRoZSB3aG9sZSBTb0MNCj4gDQo+IEFm
dGVyIGZ1cnRoZXIgcmV2aWV3aW5nIHRoaXMgcGF0Y2hJIGhhdmUgYSBxdWVzdGlvbjogaGVyZSB5
b3Ugc2F5IHRoYXQgaS5NWDdEDQo+IG5lZWRzIHRvIHNhdmUgc29tZSByZWdpc3RlcnMuDQo+IA0K
PiA+IHdpbGwgYmUgcG93ZXJlZCBvZmYgZXhjZXB0IExQU1IgZG9tYWluLCBHUElPIGJhbmtzIHdp
bGwgbG9zZSBjb250ZXh0DQo+ID4gaW4gdGhpcyBjYXNlLCBuZWVkIHRvIHJlc3RvcmUgdGhlIGNv
bnRleHQgYWZ0ZXIgcmVzdW1lIGZyb20gTFBTUiBtb2RlLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBh
ZGRzIEdQSU8gc2F2ZS9yZXN0b3JlIGZvciB0aG9zZSBuZWNlc3NhcnkgcmVnaXN0ZXJzLCBhbmQN
Cj4gPiBwdXQgdGhlIHNhdmUvcmVzdG9yZSBvcGVyYXRpb25zIGluIG5vaXJxIHN1c3BlbmQvcmVz
dW1lIHBoYXNlLCBzaW5jZQ0KPiA+IEdQSU8gaXMgZnVuZGFtZW50YWwgbW9kdWxlIHdoaWNoIGNv
dWxkIGJlIHVzZWQgYnkgb3RoZXIgcGVyaXBoZXJhbHMnDQo+ID4gcmVzdW1lIHBoYXNlLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3Bpby9ncGlvLW14Yy5jIHwgNjgNCj4gPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA2OCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncGlv
L2dwaW8tbXhjLmMgYi9kcml2ZXJzL2dwaW8vZ3Bpby1teGMuYyBpbmRleA0KPiA+IDJmMjgyOTku
LjBmYzUyZDggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncGlvL2dwaW8tbXhjLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2dwaW8vZ3Bpby1teGMuYw0KPiA+IEBAIC00NSw2ICs0NSwxNSBAQCBzdHJ1
Y3QgbXhjX2dwaW9faHdkYXRhIHsNCj4gPiAgICAgICAgIHVuc2lnbmVkIGZhbGxfZWRnZTsNCj4g
PiAgfTsNCj4gPg0KPiA+ICtzdHJ1Y3QgbXhjX2dwaW9fcmVnX3NhdmVkIHsNCj4gPiArICAgICAg
IHUzMiBpY3IxOw0KPiA+ICsgICAgICAgdTMyIGljcjI7DQo+ID4gKyAgICAgICB1MzIgaW1yOw0K
PiA+ICsgICAgICAgdTMyIGdkaXI7DQo+ID4gKyAgICAgICB1MzIgZWRnZV9zZWw7DQo+ID4gKyAg
ICAgICB1MzIgZHI7DQo+ID4gK307DQo+ID4gKw0KPiA+ICBzdHJ1Y3QgbXhjX2dwaW9fcG9ydCB7
DQo+ID4gICAgICAgICBzdHJ1Y3QgbGlzdF9oZWFkIG5vZGU7DQo+ID4gICAgICAgICB2b2lkIF9f
aW9tZW0gKmJhc2U7DQo+ID4gQEAgLTU1LDYgKzY0LDcgQEAgc3RydWN0IG14Y19ncGlvX3BvcnQg
ew0KPiA+ICAgICAgICAgc3RydWN0IGdwaW9fY2hpcCBnYzsNCj4gPiAgICAgICAgIHN0cnVjdCBk
ZXZpY2UgKmRldjsNCj4gPiAgICAgICAgIHUzMiBib3RoX2VkZ2VzOw0KPiA+ICsgICAgICAgc3Ry
dWN0IG14Y19ncGlvX3JlZ19zYXZlZCBncGlvX3NhdmVkX3JlZzsNCj4gPiAgfTsNCj4gPg0KPiA+
ICBzdGF0aWMgc3RydWN0IG14Y19ncGlvX2h3ZGF0YSBpbXgxX2lteDIxX2dwaW9faHdkYXRhID0g
eyBAQCAtNDk3LDYNCj4gPiArNTA3LDggQEAgc3RhdGljIGludCBteGNfZ3Bpb19wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+DQo+ID4gICAgICAgICBsaXN0X2FkZF90YWls
KCZwb3J0LT5ub2RlLCAmbXhjX2dwaW9fcG9ydHMpOw0KPiA+DQo+ID4gKyAgICAgICBwbGF0Zm9y
bV9zZXRfZHJ2ZGF0YShwZGV2LCBwb3J0KTsNCj4gPiArDQo+ID4gICAgICAgICByZXR1cm4gMDsN
Cj4gPg0KPiA+ICBvdXRfaXJxZG9tYWluX3JlbW92ZToNCj4gPiBAQCAtNTA3LDExICs1MTksNjcg
QEAgc3RhdGljIGludCBteGNfZ3Bpb19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpw
ZGV2KQ0KPiA+ICAgICAgICAgcmV0dXJuIGVycjsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2
b2lkIG14Y19ncGlvX3NhdmVfcmVncyhzdHJ1Y3QgbXhjX2dwaW9fcG9ydCAqcG9ydCkgew0KPiA+
ICsgICAgICAgaWYgKG14Y19ncGlvX2h3dHlwZSA9PSBJTVgyMV9HUElPKQ0KPiA+ICsgICAgICAg
ICAgICAgICByZXR1cm47DQo+IA0KPiBidXQgaGVyZSB5b3Ugb25seSBibG9jayBJTVgyMV9HUElP
Lg0KPiANCj4gVGhpcyBtZWFucyB0aGF0IG14MzEvbXgzNS9teDUxL214NTMvbXg2IHdpbGwgZXhl
Y3V0ZSB0aGlzIGNvZGUgdG9vIG5vdy4NCj4gSXMgdGhpcyBhbHdheXMgc2FmZT8NCj4gDQo+IFNo
b3VsZG4ndCBpdCB0aGlzIHNhdmUvcmVzdG9yZSBiZSBleGVjdXRlZCBvbmx5IG9uIG14N2Q/DQo+
IA0KPiBQbGVhc2UgY2xhcmlmeS4NCkhlcmUgYXJlIHRoZSBkZXRhaWxzLCBpLk1YN0QgTFBTUiBt
b2RlIGFuZCBpLk1YOFFNLzhRWFAgZXRjLicgc3VzcGVuZC9yZXN1bWUNCm1heSBjYXVzZSBHUElP
IGJhbmsgbG9zZSBwb3dlciwgc28gbmVlZCB0byBzYXZlL3Jlc3RvcmUsIGZvciBvdGhlciBpLk1Y
IFNvQ3MsDQphbHRob3VnaCBubyBuZWVkIHRvIGRvIHNhdmUvcmVzdG9yZSwgYnV0IGRvaW5nIGl0
IGlzIE5PVCBoYXJtZnVsLCBzbyBkbyB5b3UgdGhpbmsNCndlIHNob3VsZCBhZGQgU29DIHR5cGUg
Y2hlY2sgaGVyZT8NCg0KQW5zb24uDQoNCg==
