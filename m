Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BA9ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14C220870
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xcIqDNEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14C220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbeGMKoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:44:12 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:15582
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727097AbeGMKoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrTgv4GdH87ekaYu80EUVtPNAKvYCJtLhERWuHDgXZw=;
 b=xcIqDNEbpNNLlKPZ0Pmln5u6xj9J7vRNrd1KQouZkEQN/Lp4mssVgoCNWF08Y8iRaB9aPzaTKmfyVBxPclF3xt9jXxjBKRvC2zgahP2/+DFUAcnZHpA8h396soueU6sHI935kOzd55wYpmSr4RoPtTZMa5d6aYBAgD1elFEDiYk=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4148.eurprd04.prod.outlook.com (52.134.125.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Fri, 13 Jul 2018 10:30:04 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::547e:1694:4925:dcf4]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::547e:1694:4925:dcf4%2]) with mapi id 15.20.0930.022; Fri, 13 Jul 2018
 10:30:04 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "marex@denx.de" <marex@denx.de>, Anson Huang <anson.huang@nxp.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        "airlied@linux.ie" <airlied@linux.ie>
Subject: Re: [PATCH] drm: mxsfb: fix runtime PM handling
Thread-Topic: [PATCH] drm: mxsfb: fix runtime PM handling
Thread-Index: AQHUGofRdlnHWS3Mrka4LWreO2npPKSM25uAgAABBoCAAAGlAIAAFZWA
Date:   Fri, 13 Jul 2018 10:30:04 +0000
Message-ID: <6e592ae7d5017cee55b4be3f2676b758fb3cd057.camel@nxp.com>
References: <1531472085-25174-1-git-send-email-Anson.Huang@nxp.com>
         <ea029b69-f853-4a5f-e798-70a04b02ac1d@denx.de>
         <AM3PR04MB1315E2F345752D0A64A0E2C8F5580@AM3PR04MB1315.eurprd04.prod.outlook.com>
         <90d16681-2a7a-4826-0411-478353d2afe3@denx.de>
In-Reply-To: <90d16681-2a7a-4826-0411-478353d2afe3@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4148;7:vXaalMyVv+DODOoRXFPmZ9wc8+UT95e9kmo1Ge4CSLHYlUJPRydtT9DeXVsgMDs9D3+iMgOqHGp+T0cslgWByQ5E8zK/vZUhFKqM/2TS+C8JpX6Fn0afPOLFfSUz34Bl4bjnhlW6P09fbh1RlIC+XrRkGo1O6YFTk2q0XqAVLnjT0Zi0RJlAkl2Tw8jZUZ0GsW6d3rCK1QdZTMtfQUMI7vewmBz1P/yI/uysxj/KMAQuLmhA1V2E1aisNgRJKWxK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7c3d7bba-8760-45c2-4777-08d5e8ab98fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4148;
x-ms-traffictypediagnostic: AM0PR04MB4148:
x-microsoft-antispam-prvs: <AM0PR04MB4148290BDC84551C65E5933EEE580@AM0PR04MB4148.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4148;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4148;
x-forefront-prvs: 07326CFBC4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(136003)(39860400002)(396003)(189003)(199004)(6636002)(25786009)(4326008)(5660300001)(110136005)(6246003)(54906003)(305945005)(26005)(8936002)(7736002)(14444005)(97736004)(2906002)(316002)(2501003)(6486002)(6436002)(2900100001)(99286004)(6512007)(6306002)(229853002)(5250100002)(186003)(14454004)(6506007)(66066001)(53546011)(2201001)(53936002)(478600001)(11346002)(102836004)(486006)(76176011)(2616005)(476003)(36756003)(118296001)(966005)(446003)(50226002)(86362001)(44832011)(106356001)(6116002)(3846002)(68736007)(81156014)(105586002)(256004)(8676002)(93886005)(81166006)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4148;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MpmkuqEqclO9KyiC/S7hhefXNDwBWoYKje4Efp895Lnv1Y6h1YqdLehYl5zeTzGke7y611uouMiyOzMBu86XxZ+3t116A8l65XLV/qPFHPraHyFo39JUj/YYTAnU26uowp7EH3lVIBSxvHlpnv/ZyrAQXx7sJbyf6aGUE5I1j11KZD16uKnLPYoIIxgeUSDDWW8cpM+G/q71JJ7dM15zL9LtRpUe6elZZbMazfuJav4YWdYMWvPXrZadiXzjl9zoIgL4hn6+rgPQqKAgq+RnYGeZzlp7o09e7w11vXyyPay1DC4Op6gZe+SVuedNhFr2bQ4qAPde7wAJ72s3HMFucAXHl98+gI/fOPxYYReEiXQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD7D17847B0F254A958796FBB903D437@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3d7bba-8760-45c2-4777-08d5e8ab98fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2018 10:30:04.5043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA3LTEzIGF0IDExOjEyICswMjAwLCBNYXJlayBWYXN1dCB3cm90ZToNCj4g
T24gMDcvMTMvMjAxOCAxMTowNiBBTSwgQW5zb24gSHVhbmcgd3JvdGU6DQo+IFsuLi5dDQo+ID4g
PiANCj4gPiA+IE9uIDA3LzEzLzIwMTggMTA6NTQgQU0sIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+
ID4gPiBBcyBkaXNwbGF5IHBvd2VyIGRvbWFpbiBpcyBjb21iaW5lZCB3aXRoIGxjZGlmIG5vZGUg
b24gc29tZSBpLk1YDQo+ID4gPiA+IHBsYXRmb3JtcyBsaWtlIGkuTVg2U0wsIHdoZW4gbGNkaWYg
ZHJpdmVyIGlzIGVuYWJsZWQsIHRoZSBteHNmYl9sb2FkDQo+ID4gPiA+IGlzIGNhbGxlZCB0byBl
bmFibGUgcnVudGltZSBwbSwgYW5kIGEgcGFpciBvZiBwbV9ydW50aW1lX2dldF9zeW5jIGFuZA0K
PiA+ID4gPiBwbV9ydW50aW1lX3B1dF9zeW5jIGFyZSBhbHNvIGNhbGxlZCwgdGhhdCB3aWxsIGNh
dXNlIGdlbmVyaWMgcG93ZXINCj4gPiA+ID4gZG9tYWluIGRyaXZlciB0byBkaXNhYmxlIGxjZGlm
IHBvd2VyIGRvbWFpbiBhbmQgbGNkaWYgaXMgbm8gbG9uZ2VyDQo+ID4gPiA+IHdvcmtpbmcsIHRo
ZSBsY2RpZiBwb3dlciBzaG91bGQgT05MWSBiZSB0dXJuZWQgb2ZmIHdoZW4gZGlzcGxheSBpcw0K
PiA+ID4gPiBkaXNhYmxlZCwgc28gbW92ZSB0aGUgcG1fcnVudGltZV9wdXRfc3luYyB0byBteHNm
Yl91bmxvYWQgYW5kIHJlbW92ZQ0KPiA+ID4gPiB0aGUgcG1fcnVudGltZV9nZXRfc3luYyBpbiBt
eHNmYl91bmxvYWQgYXMgd2VsbCwgaW4gdGhpcyB3YXksIHdoZW4NCj4gPiA+ID4gZGlzcGxheSBp
cyBlbmFibGVkLCB0aGUgbGNkaWYgcG93ZXIgd2lsbCBiZSBhbHdheXMgT04gdW50aWwgdGhlDQo+
ID4gPiA+IGRpc3BsYXkgaXMgZGlzYWJsZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+IA0KPiA+ID4gRG9l
c24ndCB0aGlzIGFsc28gbWVhbiB0aGUgYmxvY2sgd2lsbCBhbHdheXMgYmUgb24sIHRodXMgd2Fz
dGluZyBwb3dlciA/DQoNCj4gPiBJIHRoaW5rIGRybSBkcml2ZXIgc2hvdWxkIGhhdmUgc29tZXdo
ZXJlIHRvIGltcGxlbWVudCB0aGUgZGlzcGxheQ0KPiA+IGRpc2FibGUgY2FzZSwgbGlrZSB3aGVu
IGZiMCBpcyBibGFuayAoZWNobyAxID4gL3N5cy9jbGFzcy9ncmFwaGljcy9mYjAvYmxhbmspLA0K
PiANCj4gSXNuJ3QgdGhpcyBqdXN0IHRoZSBmYmRldiBlbXVsYXRpb24gb24gdG9wIG9mIGRybS9r
bXMgPw0KPiBJIHRoaW5rIHRoaXMgc3R1ZmYgY2FuIGJlIGNvbXBpbGVkIG91dCBjb21wbGV0ZWx5
Lg0KPiANCj4gPiB0aGVuIGxjZGlmIGNhbiBiZSBwb3dlcmVkIGdhdGVkLCBhbmQNCj4gPiB3aGVu
IGRpc3BsYXkgaXMgYmFjayBvbiAodW5ibGFuayksIGxjZGlmIG5lZWRzIHRvIGJlIHJlLWluaXRp
YWxpemF0aW9uIGFuZCBkaXNwbGF5IHdpbGwNCj4gPiBiZSBvbiwgY3VycmVudCBpbXBsZW1lbnRh
dGlvbiBpcyBpbmNvcnJlY3QsIHdpdGgga2VybmVsIGJvb3RpbmcgdXAsIGxjZGlmDQo+ID4gaXMg
Tk9UIHdvcmtpbmcgYXQgYWxsLg0KPiANCj4gSXQgd29ya3MgZmluZSBvbiBNWDZTWCAsIHNvIEkg
dGhpbmsgdGhpcyBpcyBpc29sYXRlZCB0byBNWDZTTCA/DQo+IEknbSBDQ2luZyBTdGVmYW4sIGhl
IG1pZ2h0IGhhdmUgc29tZSB2YWx1YWJsZSBmZWVkYmFjayBoZXJlLg0KDQpTb21lIHRpbWUgYWdv
IEkgc2VudCBhIHBhdGNoIHdoaWNoIHRyaWVzIHRvIGltcGxlbWVudCAicHJvcGVyIiBydW50aW1l
DQpQTSBmb3IgbGNkaWY6IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA0NDk3
NjEvDQoNCkl0IHNlZW1zIHRvIGhhdmUgc2xpcHBlZCB0aHJvdWdoIHRoZSBjcmFja3MsIGNhbiBz
b21lYm9keSBwbGVhc2UgdGFrZSBhDQpsb29rIGF0IGl0Pw0KDQpUaGlzIG9ubHkgYWN0dWFsbHkg
bWF0dGVycyBvbiBTT0NzIHdoZXJlIHRoZSBkaXNwbGF5IHBvd2VyIGRvbWFpbiBpcw0KZ2F0ZWQs
IGhvd2V2ZXI6DQoNCiogT24gaW14NnN4IHRoZSBESVNQIHBvd2VyIGRvbWFpbiBpcyBjdXJyZW50
bHkgbm90IGRlZmluZWQgaW4gRFRTLg0KRGVmaW5pbmcgcmVxdWlyZXMgZGVhbGluZyB3aXRoIHBj
aWUgYmVpbmcgc3ByZWFkIGluIG11bHRpcGxlIFBEcy4NCiogT24gaW14NnNsIHRoZXJlIGlzIGEg
bmFzdHkgZXJyYXRhIHNvIHRoZSBQRCB3YXMgbWFya2VkIGFsd2F5cy1vbi4NClRoaXMgd2FzIGEg
ZmV3IGRheXMgYWdvOiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOC83LzExLzQyNw0KKiBpbXg2
c2xsIGlzIG5ldywgZXZrIGR0cyBvbmx5IGluIG5leHQuDQoNClRoZSBsY2RpZiBibG9jayBpcyBh
bHNvIHVzZWQgaW4gc29tZSBpbXg4IGNoaXBzIHNvIHJ1bnRpbWUgUE0gc2hvdWxkIGJlDQpkZWFs
dCB3aXRoIGV2ZW50dWFsbHku
