Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F20C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F95520869
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aMgAMycM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfAaJSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:18:55 -0500
Received: from mail-eopbgr10083.outbound.protection.outlook.com ([40.107.1.83]:18509
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbfAaJSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRBMjAF3sWQClU23CpIEDG9j08VOcxhBNoMxzBYar9s=;
 b=aMgAMycMeJj4UKnS8UVwsKA4YYj/57o9xXNJtBamm2C0JpbHWe7O7JxCx3BFyUacxkItjoXizYmVbmidx/fmdYf0U7qurTMoA0TQ4VFcKDdszdLb5F++eOGC375BhXPVugB+inA8ehf3ZD9umOLtadz3YPpavnm0Rb35JyQ/lO8=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4412.eurprd04.prod.outlook.com (52.135.137.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Thu, 31 Jan 2019 09:18:25 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::d4eb:ad3a:a610:c181]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::d4eb:ad3a:a610:c181%4]) with mapi id 15.20.1580.018; Thu, 31 Jan 2019
 09:18:25 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH] can: flexcan: fix timeout when set small bitrate
Thread-Topic: [PATCH] can: flexcan: fix timeout when set small bitrate
Thread-Index: AQHUuTJgKWsp8N+NE0K42HojVTeBgaXI/GEAgAACyeCAABhcgIAAAV1Q
Date:   Thu, 31 Jan 2019 09:18:25 +0000
Message-ID: <DB7PR04MB46181BB58A06791458236D10E6910@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20190131065619.7298-1-qiangqing.zhang@nxp.com>
 <1902c81b-86fa-469e-b495-c37dca744cb9@pengutronix.de>
 <DB7PR04MB46189FE45531AA8FD65D5327E6910@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <0b660fc9-0b02-0b3f-46f5-1d194a52628c@pengutronix.de>
In-Reply-To: <0b660fc9-0b02-0b3f-46f5-1d194a52628c@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4412;6:pTGDwkws53eAEwdCIfxHZyZrE4hMZLgmZwTQXcFQ5WEanuCd/841szQbD4/XmUMIx45qEzrJsMXHYj4/SRTrRSqklbTwgXobyQdz0B40Ag0FUxnylOJboUmAPJ5ecRm12vLGVUzzrzU3Ad75/3oFVOry42kSqQ7P+kKiFLcz2RlIrmfdJKtwzXy076BoJI4jkpqMWE1VCb/c/QDYZKdztXG3XN7EsoSwNlIWaZ7SLX8s28vrGNY8p49L9QSO/4cDaLVA5LyZEgIS+clDsoWa1RPHY1et2GuCci7N+rpJGqU7qsfYMWvz1cEhBZV6TcR0D896pFcsiT0ZtwhZ92pvOjUd0OJUclJqu/JrKARk+DoPhVv56A8ihv4XKiK29angxtSdHvPzWZA6SH84e7xC4rqUUq1KS2Uq9XNfLt3uf+9dn+7Y0AWDGe38K2XfymlITsRtuBdT74RsholHlTiMTw==;5:wMeZ25foRYqLNeMjpCiwItctKem9+yG6z1Q/BJnGtz+LPvJxsk1B0Lhp2zpMtbPHxB39NER6kOvAahomO1KN+vHbu2d6zaZ1jViieX0VteCN1oFmKbDMjHPY5DXFxrr4dqGLHJzRVzNMQ0JdSdnn8mE4nmplUk7HDZqDfTAxqfCm6vW9Bw7/zROD5YT4kU9OBbxij7J+A6pYY/GWF+BXOQ==;7:fAdenfKmT2elOr4R1s/ojIfNdmBQWtCeRfot7kKYbfmG+nxT7K8OjaU5C+++0ZFIj7AVpmpxB2S5RDJu8mhjbsQzuo9O08ZmoLvB7bXvuuKYgcwmlcFpnLk1+jCQr2DINIjY/2pwftO5TDgmziYBsw==
x-ms-office365-filtering-correlation-id: 5432d4dd-6a4c-4862-eaa4-08d6875d0e31
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4412;
x-ms-traffictypediagnostic: DB7PR04MB4412:
x-microsoft-antispam-prvs: <DB7PR04MB4412F2BB0A384701C1A465BFE6910@DB7PR04MB4412.eurprd04.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(13464003)(189003)(199004)(74316002)(68736007)(106356001)(8676002)(81156014)(81166006)(8936002)(55016002)(966005)(229853002)(14454004)(486006)(446003)(3846002)(478600001)(71200400001)(33656002)(71190400001)(105586002)(6116002)(11346002)(86362001)(476003)(53546011)(2501003)(54906003)(6506007)(93886005)(102836004)(6436002)(186003)(305945005)(97736004)(316002)(110136005)(26005)(9686003)(7696005)(76176011)(53936002)(6246003)(6306002)(99286004)(53386004)(2906002)(25786009)(4326008)(256004)(7736002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4412;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9Z1djtnNnD7ReEsTi0AwY1OOTSDFYDLTlDNJzGVxOnvwN5J4PFTAvAv/kQ+RU/2HEOUEQMt6FDEEDE5BdQlTOG5lJif/G2fr9dFbc9b0S6IYYdSbpx9hSJqVtSBAvGRy6qc2f6DP/jGY9PCnH5TltN5TYcCntO9o1oNWhnuEsJeUnWt5XadjN9cUo/x8x2vvIjZSM79eJeRozEZ2J0P641xLLLQfbNOyLnkPq5Wm3a++d21zTBMK5WlPquTBtYH5xCSobLItQHwFNwsA5SORUpZca4AOiAXIXogbCikraatY1N4D47Kq/a5cb0zml1wfDZCVcStfnS0jHGLQraikZvtXhvRV3g5EH5GVxxFTDiikt81ed6Eu0RlhIUV1Nfro/hqh6pfa/omkYbF3y5g1k1zX09uAeDVE8lEoNIABIfU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5432d4dd-6a4c-4862-eaa4-08d6875d0e31
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 09:18:25.8033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4412
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBNYXJjLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMg
S2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMTnlubQx5pyIMzHm
l6UgMTc6MTINCj4gVG86IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+OyBs
aW51eC1jYW5Admdlci5rZXJuZWwub3JnDQo+IENjOiB3Z0BncmFuZGVnZ2VyLmNvbTsgbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGlu
dXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IEFpc2hlbmcNCj4gRG9uZyA8YWlzaGVuZy5kb25n
QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNhbjogZmxleGNhbjogZml4IHRpbWVv
dXQgd2hlbiBzZXQgc21hbGwgYml0cmF0ZQ0KPiANCj4gT24gMS8zMS8xOSA5OjQ4IEFNLCBKb2Fr
aW0gWmhhbmcgd3JvdGU6DQo+ID4+IFdoaWNoIFNvQyBhcmUgeW91IHVzaW5nPyBXaGljaCBjbG9j
ayByYXRlIGhhcyB0aGUgZmxleGNhbiBJUCBjb3JlPw0KPiA+DQo+ID4gICBXZSB0ZXN0ZWQgb24g
aS5NWDYgc2VyaWVzIGJvYXJkcyBhbmQgYWxsIG1ldCB0aGlzIGlzc3VlLiBBbmQgaXBnIGNsb2Nr
IHJhdGUNCj4gaXMgNjZNSFosIHBlciBjbG9jayByYXRlIGlzIDMwTUhaLg0KPiANCj4gb2sNCj4g
DQo+ID4NCj4gPj4+IEl0IGlzIGNhdXNlZCBieSBjYWxsaW5nIG9mIGZsZXhjYW5fY2hpcF91bmZy
ZWV6ZSgpIHRpbWVvdXQuDQo+ID4+Pg0KPiA+Pj4gT3JpZ2luYWxseSB0aGUgY29kZSBpcyB1c2lu
ZyB1c2xlZXBfcmFuZ2UoMTAsIDIwKSBmb3IgdW5mcmVlemUNCj4gPj4+IG9wZXJhdGlvbiwgYnV0
IHRoZSBwYXRjaCAoOGJhZGQ2NSBjYW46IGZsZXhjYW46IGF2b2lkIGNhbGxpbmcNCj4gPj4+IHVz
bGVlcF9yYW5nZSBmcm9tIGludGVycnVwdCBjb250ZXh0KSBjaGFuZ2VkIGl0IGludG8gdWRlbGF5
KDEwKQ0KPiA+Pj4gd2hpY2ggaXMgb25seSBhIGhhbGYgZGVsYXkgb2YgYmVmb3JlLCB0aGVyZSdy
ZSBhbHNvIHNvbWUgb3RoZXIgZGVsYXkNCj4gY2hhbmdlcy4NCj4gPj4+DQo+ID4+PiBBZnRlciBv
bmx5IGNoYW5nZWQgdW5mcmVlemUgZGVsYXkgYmFjayB0byB1ZGVsYXkoMjApLCB0aGUgaXNzdWUg
aXMgZ29uZS4NCj4gPj4+IFNvIG90aGVyIHRpbWVvdXQgdmFsdWVzIGFyZSBrZXB0IHRoZSBzYW1l
IGFzIDhiYWRkNjUgY2hhbmdlZC4NCj4gPj4NCj4gPj4gQ2FuIHlvdSBjaGFuZ2UgRkxFWENBTl9U
SU1FT1VUX1VTIGluc3RlYWQ/DQo+ID4NCj4gPiAgIE9mIGNvdXJzZSwgd2UgY2FuIGNoYW5nZSBG
TEVYQ0FOX1RJTUVPVVRfVVMgdG8gMTAwLCBidXQgdGhpcyB3aWxsDQo+IGV4dGVuZCB0aGUgdGlt
ZSBvZiBlbmFibGUvZGlzYWJsZS9zb2Z0cmVzZXQuDQo+ID4gV2hpY2ggbWV0aG9kIGRvIHlvdSB0
aGluayBpcyBiZXR0ZXI/DQo+IA0KPiBJZiB5b3UgZG91YmxlIHRvIEZMRVhDQU5fVElNRU9VVF9V
UyB0byAxMDAsIHRoZSBsb29wcyBpbiBxdWVzdGlvbiB3aWxsIHNwaW4NCj4gYXQgbWF4aW11bSB0
aGUgZG91YmxlIHRpbWUuIEJ1dCB0aGUgbG9vcHMgYXJlIGxlZnQgYXMgc29vbiBhcyB0aGUgY29u
ZGl0aW9uIGlzDQo+IHNhdGlzZmllZC4NCj4gDQo+IEl0IHdpbGwgZml4IHlvdXIgcHJvYmxlbSB3
aXRoIHRoZSAxMCBrYml0L3MgYml0cmF0ZS4gQnV0IGlmIHRoZXJlIGlzIHNvbWUga2luZCBvZg0K
PiBwcm9ibGVtIHdpdGggdGhlIElQIGNvcmUgaXQgd2lsbCBzdGlsbCBmYWlsLCBpdCBqdXN0IHRh
a2VzIGRvdWJsZSBhbW91bnQgb2YgdGltZQ0KPiAoMTAwIMK1cyArIG92ZXJoZWFkKSB1bnRpbCB0
aGUgZnVuY3Rpb24gcmV0dXJucy4NCj4gDQo+IEkgZG9uJ3Qgc2VlIGFueSBoYXJtIGluIGxvb3Bp
bmcgbG9uZ2VyOg0KPiAtIFRoZSBwcmV2aW91cyBnb29kIGNhc2UgaXMgdW5jaGFuZ2VkLg0KPiAt
IFRoZSBlcnJvciBjYXNlIHRha2VzIGRvdWJsZSBhbW91bnQgb2YgdGltZS4NCj4gLSBZb3VyIHBy
b2JsZW0gaXMgaG9wZWZ1bGx5IGZpeGVkLg0KDQpUaGFua3MgZm9yIHlvdXIgZXhwbGFuYXRpb24s
IEkgd2lsbCBjb29rIGEgcGF0Y2ggdGhlbiByZXNlbmQuDQoNCkJlc3QgUmVnYXJkcywNCkpvYWtp
bSBaaGFuZw0KPiBNYXJjDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAg
ICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAgICAgfA0KPiBJbmR1c3RyaWFsIExpbnV4
IFNvbHV0aW9ucyAgICAgICAgfCBQaG9uZTogKzQ5LTIzMS0yODI2LTkyNCAgICAgfA0KPiBWZXJ0
cmV0dW5nIFdlc3QvRG9ydG11bmQgICAgICAgICAgfCBGYXg6ICAgKzQ5LTUxMjEtMjA2OTE3LTU1
NTUgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiAgfCBodHRwOi8vd3d3LnBl
bmd1dHJvbml4LmRlICAgfA0KDQo=
