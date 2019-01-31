Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CECC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A614218D2
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U9An8PpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfAaItj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:49:39 -0500
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:61344
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbfAaItj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGbNyJaeIPqrNKw/d14pTNfW9GyImD7VbkEcKoGPaps=;
 b=U9An8PpGzWWpSVhHHa2C888PvILMcq+2XqcjgFaAt+G2fqdKqxCjRYw9n97pDDA5YoKVCxsBBF+7Jfb6WuCYwW18kTF0vJj9BrAyIWzFjj5RYpaIBXxeeJJsDAxsXBMTTI85+vMBUqpgnx5KPAmKlzTQP+uXBkkSzLKkHW35Qkg=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5529.eurprd04.prod.outlook.com (20.178.106.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Thu, 31 Jan 2019 08:48:55 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::d4eb:ad3a:a610:c181]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::d4eb:ad3a:a610:c181%4]) with mapi id 15.20.1580.018; Thu, 31 Jan 2019
 08:48:55 +0000
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
Thread-Index: AQHUuTJgKWsp8N+NE0K42HojVTeBgaXI/GEAgAACyeA=
Date:   Thu, 31 Jan 2019 08:48:55 +0000
Message-ID: <DB7PR04MB46189FE45531AA8FD65D5327E6910@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20190131065619.7298-1-qiangqing.zhang@nxp.com>
 <1902c81b-86fa-469e-b495-c37dca744cb9@pengutronix.de>
In-Reply-To: <1902c81b-86fa-469e-b495-c37dca744cb9@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5529;6:F8JIXTipD06iQkYqouoG+O6yaXfBJ9jjjx6pYmRFJPjFJJv7rynNfJBlrEbikZQMhocGu2LxiNDRTyy3YgiTRyRsPsdib28x8O3QwWw+nHpqZMzKkHGEnicGPNuTeKngpw7APRbfPVBVwN/M7pE3PqoHp+7aqV3rmiSucJGjm1pi/E/wEmrP3ISR5nExnTyiF0sZjjfxTYaDlUVZ/323vYFTfmdrnpfRw0xMotCkdkt5Om+EXmg+I9rI7L6Vkv/tRt7HW1cPn+B5/qJ94v2ofRcbDY4+X1vCRKeNvnfxQ64jPnlaBXV7iNSe+XvZv0/IqXyFM+8NHi5kT3LKZlmf41athM2q+1dM3rlcytCxe52K2+B4FMyc21lbt8T6CIlldKSyGbQuflZI3GGOW/nLZsqTxh0NRl8HAU2ATbmyplmie/x7YsoV1ToyRXvdVFb07f9mSqyOGQ74u3ECRKqvhw==;5:fNxQgl0LVTpL5jlTYlcILfN88BUCxczA8/q2EoCjB364ZaLuSmYyOADtAwtw/2ZO8yuxBGK7IjLZXtH7ckpQLcsMPd/RrW3rI/fjPByy+6gvvYphqhCw07DVPwy3qHEIpuKLcny7QphyHB/0tbP0xUY/j6R88cUfbSdIn3VBWir/qGOOResp+c+rbripB2HHL0nyTad/thOd88Wqcv2AdQ==;7:XtEExDpuuY2dqcmxTMF8czK4+1AiZtHD2paMVHC4dPmt5d8+6+i5Y5n1WINJbSIXAfpPc1aFMNbfjRNtG3VZSlf3I82338zDZOU5bM0D6HLpBTrs7HgVlnNpT8m8PDgxIhNJjtziADoNHKvo72J5KA==
x-ms-office365-filtering-correlation-id: 4342d71b-4b45-4255-2bd4-08d68758eefb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5529;
x-ms-traffictypediagnostic: DB7PR04MB5529:
x-microsoft-antispam-prvs: <DB7PR04MB552907A8FE468E4C68E3EF3CE6910@DB7PR04MB5529.eurprd04.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39860400002)(45904002)(13464003)(189003)(199004)(99286004)(68736007)(81156014)(186003)(229853002)(446003)(33656002)(6436002)(81166006)(102836004)(8676002)(66066001)(26005)(476003)(53546011)(4326008)(53386004)(7696005)(6246003)(11346002)(2501003)(53936002)(6506007)(97736004)(8936002)(25786009)(6116002)(106356001)(105586002)(3846002)(486006)(76176011)(14454004)(71190400001)(71200400001)(966005)(86362001)(316002)(74316002)(256004)(14444005)(478600001)(7736002)(305945005)(54906003)(6306002)(55016002)(110136005)(9686003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5529;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VVTNZujxmZyahKo++9T2WTYG8RuZSkHcvdu5OfXiXB2/rz4M0OHHCvZzqRzMOm84/B6GYwBFONAxGWxJRoT7cIRkIwqJ+eqiHMRB81F0N3tg6FwXxQfQaFzildGLUkaeZ3F6NxMYh02Rxs98qEo1f9h6i9sTfEQuIHaLP0peD6Y4/4hAoZr1zWrrWkUCWSbswmYAAiZnURQImJwfQBWug+elR5787rfIifRsPtmpSyF3nfsq7Nuf/qlpYyANm1OHsoPvDGzvcI7uJWh/TJZBR1OOSpuidV3oPDSk5tTRaymukXL76lE9gCLTL9QLcGneyxghMRhNLPZdPdQQ8YtvbC9vehMU6NPQZuDH1gb7PxZSvmLmWj1g++j3WOcD9T6uDdQ0S0V4c3EcCqCh6wLI5S+u8DkJn9bTTMLMTuzJjdk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4342d71b-4b45-4255-2bd4-08d68758eefb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 08:48:55.4372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5529
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBNYXJjLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMg
S2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMTnlubQx5pyIMzHm
l6UgMTU6MzQNCj4gVG86IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+OyBs
aW51eC1jYW5Admdlci5rZXJuZWwub3JnDQo+IENjOiB3Z0BncmFuZGVnZ2VyLmNvbTsgbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGlu
dXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IEFpc2hlbmcNCj4gRG9uZyA8YWlzaGVuZy5kb25n
QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNhbjogZmxleGNhbjogZml4IHRpbWVv
dXQgd2hlbiBzZXQgc21hbGwgYml0cmF0ZQ0KPiANCj4gT24gMS8zMS8xOSA3OjU4IEFNLCBKb2Fr
aW0gWmhhbmcgd3JvdGU6DQo+ID4gRnJvbTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhw
LmNvbT4NCj4gPg0KPiA+IEN1cnJlbnQgd2UgY2FuIG1lZXQgdGltZW91dCBpc3N1ZSB3aGVuIHNl
dHRpbmcgYSBzbWFsbCBiaXRyYXRlIGxpa2UNCj4gPiAxMDAwMCBhcyBmb2xsb3dzOg0KPiA+IHJv
b3RAaW14NnFkbHNvbG86fiMgaXAgbGluayBzZXQgY2FuMCB1cCB0eXBlIGNhbiBiaXRyYXRlIDEw
MDAwIEEgbGluaw0KPiA+IGNoYW5nZSByZXF1ZXN0IGZhaWxlZCB3aXRoIHNvbWUgY2hhbmdlcyBj
b21taXR0ZWQgYWxyZWFkeS4NCj4gPiBJbnRlcmZhY2UgY2FuMCBtYXkgaGF2ZSBiZWVuIGxlZnQg
d2l0aCBhbiBpbmNvbnNpc3RlbnQgY29uZmlndXJhdGlvbiwNCj4gPiBwbGVhc2UgY2hlY2suDQo+
ID4gUlRORVRMSU5LIGFuc3dlcnM6IENvbm5lY3Rpb24gdGltZWQgb3V0DQo+IA0KPiBXaGljaCBT
b0MgYXJlIHlvdSB1c2luZz8gV2hpY2ggY2xvY2sgcmF0ZSBoYXMgdGhlIGZsZXhjYW4gSVAgY29y
ZT8NCg0KICBXZSB0ZXN0ZWQgb24gaS5NWDYgc2VyaWVzIGJvYXJkcyBhbmQgYWxsIG1ldCB0aGlz
IGlzc3VlLiBBbmQgaXBnIGNsb2NrIHJhdGUgaXMgNjZNSFosIHBlciBjbG9jayByYXRlIGlzIDMw
TUhaLg0KDQo+ID4gSXQgaXMgY2F1c2VkIGJ5IGNhbGxpbmcgb2YgZmxleGNhbl9jaGlwX3VuZnJl
ZXplKCkgdGltZW91dC4NCj4gPg0KPiA+IE9yaWdpbmFsbHkgdGhlIGNvZGUgaXMgdXNpbmcgdXNs
ZWVwX3JhbmdlKDEwLCAyMCkgZm9yIHVuZnJlZXplDQo+ID4gb3BlcmF0aW9uLCBidXQgdGhlIHBh
dGNoICg4YmFkZDY1IGNhbjogZmxleGNhbjogYXZvaWQgY2FsbGluZw0KPiA+IHVzbGVlcF9yYW5n
ZSBmcm9tIGludGVycnVwdCBjb250ZXh0KSBjaGFuZ2VkIGl0IGludG8gdWRlbGF5KDEwKSB3aGlj
aA0KPiA+IGlzIG9ubHkgYSBoYWxmIGRlbGF5IG9mIGJlZm9yZSwgdGhlcmUncmUgYWxzbyBzb21l
IG90aGVyIGRlbGF5IGNoYW5nZXMuDQo+ID4NCj4gPiBBZnRlciBvbmx5IGNoYW5nZWQgdW5mcmVl
emUgZGVsYXkgYmFjayB0byB1ZGVsYXkoMjApLCB0aGUgaXNzdWUgaXMgZ29uZS4NCj4gPiBTbyBv
dGhlciB0aW1lb3V0IHZhbHVlcyBhcmUga2VwdCB0aGUgc2FtZSBhcyA4YmFkZDY1IGNoYW5nZWQu
DQo+IA0KPiBDYW4geW91IGNoYW5nZSBGTEVYQ0FOX1RJTUVPVVRfVVMgaW5zdGVhZD8NCg0KICBP
ZiBjb3Vyc2UsIHdlIGNhbiBjaGFuZ2UgRkxFWENBTl9USU1FT1VUX1VTIHRvIDEwMCwgYnV0IHRo
aXMgd2lsbCBleHRlbmQgdGhlIHRpbWUgb2YgZW5hYmxlL2Rpc2FibGUvc29mdHJlc2V0Lg0KV2hp
Y2ggbWV0aG9kIGRvIHlvdSB0aGluayBpcyBiZXR0ZXI/DQoNCkJlc3QgUmVnYXJkcywNCkpvYWtp
bSBaaGFuZw0KDQo+ID4gU2lnbmVkLW9mZi1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdA
bnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFu
Z0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jIHwgMiAr
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jIGIvZHJpdmVycy9u
ZXQvY2FuL2ZsZXhjYW4uYw0KPiA+IGluZGV4IDJiY2E4NjdiY2ZhYS4uMWQzYTkwNTNiYmViIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMNCj4gPiArKysgYi9kcml2
ZXJzL25ldC9jYW4vZmxleGNhbi5jDQo+ID4gQEAgLTUzMCw3ICs1MzAsNyBAQCBzdGF0aWMgaW50
IGZsZXhjYW5fY2hpcF91bmZyZWV6ZShzdHJ1Y3QgZmxleGNhbl9wcml2DQo+ICpwcml2KQ0KPiA+
ICAJcHJpdi0+d3JpdGUocmVnLCAmcmVncy0+bWNyKTsNCj4gPg0KPiA+ICAJd2hpbGUgKHRpbWVv
dXQtLSAmJiAocHJpdi0+cmVhZCgmcmVncy0+bWNyKSAmIEZMRVhDQU5fTUNSX0ZSWl9BQ0spKQ0K
PiA+IC0JCXVkZWxheSgxMCk7DQo+ID4gKwkJdWRlbGF5KDIwKTsNCj4gPg0KPiA+ICAJaWYgKHBy
aXYtPnJlYWQoJnJlZ3MtPm1jcikgJiBGTEVYQ0FOX01DUl9GUlpfQUNLKQ0KPiA+ICAJCXJldHVy
biAtRVRJTUVET1VUOw0KPiA+DQo+IA0KPiBNYXJjDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBl
LksuICAgICAgICAgICAgICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAgICAgfA0KPiBJ
bmR1c3RyaWFsIExpbnV4IFNvbHV0aW9ucyAgICAgICAgfCBQaG9uZTogKzQ5LTIzMS0yODI2LTky
NCAgICAgfA0KPiBWZXJ0cmV0dW5nIFdlc3QvRG9ydG11bmQgICAgICAgICAgfCBGYXg6ICAgKzQ5
LTUxMjEtMjA2OTE3LTU1NTUgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiAg
fCBodHRwOi8vd3d3LnBlbmd1dHJvbml4LmRlICAgfA0KDQo=
