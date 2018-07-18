Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2710ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7C62075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i9okY6xJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7C62075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbeGRB3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:29:54 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:46272
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731513AbeGRB3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbxOLn8C96HZaH2LlDBxzMNKD+gSkrGxQ3l9rxNa53M=;
 b=i9okY6xJ7BH9rp3P7wMp3BBCkeKtpKlojW+iRodqXvyxpZtOSQAxm+4PR9yQ0Cevv2KH2SuAVoYw1WEfYeoP9BQ7c7ky7vwLStSuzYEHe2Z7g6PVzG9cS9xlEArYyp13wLCmy7U2s9dBFUgwhIeikfPQ/7zFpKIDfcMnxhUMlng=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB1137.eurprd04.prod.outlook.com (10.163.5.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Wed, 18 Jul 2018 00:54:36 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%7]) with mapi id 15.20.0952.021; Wed, 18 Jul 2018
 00:54:36 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] gpio: mxc: add power management support
Thread-Topic: [PATCH V2] gpio: mxc: add power management support
Thread-Index: AQHUHMvLh30yJ/o0qE+lH8ymGyqiM6STcRaAgAC46BA=
Date:   Wed, 18 Jul 2018 00:54:36 +0000
Message-ID: <AM3PR04MB13159925074BB583DD83B54DF5530@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1531721186-19417-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5D9MBOwQtKVqSD8XUtDBf9RH5+soV2jreBYHZrXzLWm6A@mail.gmail.com>
In-Reply-To: <CAOMZO5D9MBOwQtKVqSD8XUtDBf9RH5+soV2jreBYHZrXzLWm6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1137;6:UgxO7Z55033aH6Z7cDRaOnr8XqjsRX3Be5O0JLPGFyYjSfgc2bN2KBT8gqoXsP5nRgK0kztQ8lr3IlaZee+XsGDjRKXH/XHoCCs+/nVBz4c3GfYkB+YUB/gThrxyT1DTjCJ/6aYf0L1pcusLx0QmjzJB9+aypsfPOPZSV+OXduxUg+Dwpl2oXXt51mBq92MNk3POlMTah+w/g2bodGoSAbgmURSeoHLt/8d88fzNASmISflVGo/WOS2sTYpmPOeT2FaZrla2IB0hiYexDp/FqTk4DRpyflcPgZexdS7ZYOSuyzOHax7PvE/5EEcjQrPX2ciIGTkGh2SyJFUJ7gmMQii7WrsTmNu2rsoRDkFFdXvAMHQFtrp+kLk/7mvaq0atGMGqkYqzmcMReumWCW6XJgwTBwFtHxdO+Ccvn5jofx6C6FkFu+b+uJacROmzv5tKgn3a3rBBsaZmvJZAWmfzGw==;5:O2bPilBf1ueODRnlbg1Fe9tba9OvKUzMSEd43VLtIWE/zdsM2odKA7HHIQ/pycqJiboWaaCqo6mfBbSceZc7NhQf5hbZZdMvuGr5AxkY/t/lTM6esrzDAYHbPgaQjDTCnutTJchIvJIweIbRaU93LRo+ZR4mOgXOjF6B2TQaA3c=;7:I5AXh/x3gH6kIiwJNytiMVn0lZWroO7xbe6j9k3j7TEjCKg1AiYYJ+8lrKxFTPH0Y2w1I4fb6qpK1MEjuBIJv3ZEGNPT+00oQ0OUn/Fnf4E5USOLWcFIz6EuloXy3FrlT85dt3ZhoB9evt9wSHo7wKGjmeJabyZtAjs8XVmoHERNgbSnfPm4ovyScAjnaeKgZGGnfZAgjmWbY3zrSC5OzPjUstUcr5jNCxgJnfAyxPsi/K28xKtQdYLx60qOCI7b
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 19a218c9-6272-44ef-0408-08d5ec4908b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1137;
x-ms-traffictypediagnostic: AM3PR04MB1137:
x-microsoft-antispam-prvs: <AM3PR04MB11370F3409539C5CCFE5F22EF5530@AM3PR04MB1137.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1137;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1137;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39850400004)(376002)(366004)(346002)(396003)(199004)(189003)(13464003)(316002)(25786009)(5660300001)(6916009)(14444005)(66066001)(4326008)(478600001)(39060400002)(256004)(5250100002)(3846002)(2900100001)(6116002)(2906002)(1411001)(6436002)(229853002)(105586002)(305945005)(7736002)(86362001)(74316002)(486006)(102836004)(106356001)(99286004)(186003)(26005)(9686003)(55016002)(44832011)(33656002)(54906003)(68736007)(6246003)(8936002)(81156014)(81166006)(8676002)(53936002)(14454004)(97736004)(476003)(6506007)(53546011)(7696005)(11346002)(446003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1137;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: m7BIcza7D35jYq+Dq94UOf8xjjRW1KTeGetcAbCoh8ERhIvdXGssuM5Boj1WWDHIBqf6LgMzrLuSiNpwDVBQSPEULYQ0LSwBvVz41ru2ywQhBsXiweBC2NJI2EPGvpTiVdFw+6VFHhWWheaKd/DY+jfh27sOu2nevQdjRlStLvo1c4mOqXvMlF8dmxJhthLGYj9Ct8ar34Hw+03cAfbtKIjEwGy7FgXCUwRBWCWXSsYHw6hqmxzDZOM7lu2JJDTjcHb2BLq8JlwNk5/9MqCn8D3UZH3sbgi5CUPFLUnSUkb0UcFHUjbAwsXxf/Xip6YqdVuRc/sAoJwYFhRAl3/snycUc4J1SkooEjP0JnpPTWo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a218c9-6272-44ef-0408-08d5ec4908b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 00:54:36.4765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCkFuc29uIEh1YW5nDQpCZXN0IFJlZ2FyZHMhDQoNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWlsdG86ZmVzdGV2YW1A
Z21haWwuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDE3LCAyMDE4IDk6NTIgUE0NCj4gVG86
IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzogTGludXMgV2FsbGVpaiA8
bGludXMud2FsbGVpakBsaW5hcm8ub3JnPjsgb3BlbiBsaXN0OkdQSU8gU1VCU1lTVEVNDQo+IDxs
aW51eC1ncGlvQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbCA8bGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZz47DQo+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggVjJdIGdwaW86IG14YzogYWRkIHBvd2VyIG1hbmFnZW1lbnQgc3Vw
cG9ydA0KPiANCj4gSGkgQW5zb24sDQo+IA0KPiBbTmV4dCB0aW1lIHBsZWFzZSBwdXQgdGhlIGku
bXggbWFpbnRhaW5lcnMgb24gQ2NdDQo+IA0KPiBPbiBNb24sIEp1bCAxNiwgMjAxOCBhdCAzOjA2
IEFNLCBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4gR1BJ
TyByZWdpc3RlcnMgY291bGQgbG9zZSBjb250ZXh0IG9uIGkuTVg3RCwgd2hlbiBlbnRlciBMUFNS
IG1vZGUsIHRoZQ0KPiA+IHdob2xlIFNvQyB3aWxsIGJlIHBvd2VyZWQgb2ZmIGV4Y2VwdCBMUFNS
IGRvbWFpbiwgR1BJTyBiYW5rcyB3aWxsIGxvc2UNCj4gPiBjb250ZXh0IGluIHRoaXMgY2FzZSwg
bmVlZCB0byByZXN0b3JlIHRoZSBjb250ZXh0IGFmdGVyIHJlc3VtZSBmcm9tDQo+ID4gTFBTUiBt
b2RlLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBhZGRzIEdQSU8gc2F2ZS9yZXN0b3JlIGZvciB0aG9z
ZSBuZWNlc3NhcnkgcmVnaXN0ZXJzLCBhbmQNCj4gPiBwdXQgdGhlIHNhdmUvcmVzdG9yZSBvcGVy
YXRpb25zIGluIG5vaXJxIHN1c3BlbmQvcmVzdW1lIHBoYXNlLCBzaW5jZQ0KPiA+IEdQSU8gaXMg
ZnVuZGFtZW50YWwgbW9kdWxlIHdoaWNoIGNvdWxkIGJlIHVzZWQgYnkgb3RoZXIgcGVyaXBoZXJh
bHMnDQo+ID4gcmVzdW1lIHBoYXNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVh
bmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+IA0KPiA+ICBzdGF0aWMgc3RydWN0IG14Y19ncGlv
X2h3ZGF0YSBpbXgxX2lteDIxX2dwaW9faHdkYXRhID0geyBAQCAtNDM0LDYNCj4gPiArNDQ1LDkg
QEAgc3RhdGljIGludCBteGNfZ3Bpb19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiA+ICAgICAgICAgfQ0KPiA+DQo+
ID4gKyAgICAgICBpZiAob2ZfbWFjaGluZV9pc19jb21wYXRpYmxlKCJmc2wsaW14N2QiKSkNCj4g
PiArICAgICAgICAgICAgICAgcG9ydC0+c3VwcG9ydF9wb3dlcl9vZmYgPSB0cnVlOw0KPiANCj4g
VGhpcyBkb2VzIG5vdCBzY2FsZSB3ZWxsIGFzIHdlIG5lZWQgdG8gc3VwcG9ydCBteDggc29vbi4N
Cj4gDQo+IExpa2UgSSByZXBsaWVkIGluIG15IGxhc3QgbWVzc2FnZSB0aGUgYmVzdCBzb2x1dGlv
biBoZXJlIGlzIHRvIGFkZCBhDQo+ICJmc2wsaW14N2QtZ3BpbyIgY29tcGF0aWJsZSBlbnRyeSBp
biB0aGlzIGRyaXZlci4NCj4gDQo+IFRoZW4geW91IGNhbiBzZXQgYSBmbGFnIGluIHRoZSAiZnNs
LGlteDdkLWdwaW8iIGNhc2UgdG8gaGFuZGxlIHRoZSAncG93ZXJfb2ZmJw0KPiBmZWF0dXJlLg0K
PiANCj4gV2l0aCB0aGlzIG1ldGhvZCB0aGVyZSB3aWxsIGJlIG5vIG5lZWQgdG8gdG91Y2ggdGhp
cyBkcml2ZXIgYWdhaW4gZm9yIGFkZGluZw0KPiBteDggc3VwcG9ydC4NCg0KVGhhbmtzIGZvciBk
ZXRhaWwgc3VnZ2VzdGlvbiwgSSB3aWxsIHNlbnQgYSBWMyBwYXRjaCBhY2NvcmRpbmdseS4NCg0K
QW5zb24uDQogDQoNCg0KDQo=
