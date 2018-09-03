Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27969C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19C02077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QfTeS5LN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19C02077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeICSLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:11:31 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:11968
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbeICSLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qrovPtB82hQq3nuZlRP2HmskWt4pfqZVoHrFK9C1e8=;
 b=QfTeS5LN4wg4AQQzNzCJKC/H5E6jnZ7ZPANRkQCaEO8v/G5zh9AWY1pyENgNGyVrGdmF5+GApuUVFoom0cwGwGQ9IiLbvorwBb0DRKvwwSfDiBENhR9Uzvv7qqOmPN5Xa7z4Fx0bMDniMxvwyvA2s7yaZUSFSYFLkTKnIzyeLss=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4627.eurprd04.prod.outlook.com (52.135.149.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Mon, 3 Sep 2018 13:51:08 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c5f:d09d:bdc1:fe03]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c5f:d09d:bdc1:fe03%2]) with mapi id 15.20.1101.016; Mon, 3 Sep 2018
 13:51:08 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "marex@denx.de" <marex@denx.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Marco Antonio Franchi <marco.franchi@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [RESEND 0/5] drm/mxsfb: Fix runtime PM for unpowering lcdif block
Thread-Topic: [RESEND 0/5] drm/mxsfb: Fix runtime PM for unpowering lcdif
 block
Thread-Index: AQHUPfalpYexy/sbbUSEDnFZe/bEH6TTf5cAgAsew4A=
Date:   Mon, 3 Sep 2018 13:51:08 +0000
Message-ID: <e07f5b7148520fd22be39e48a26f4d45f1fb79f1.camel@nxp.com>
References: <cover.1535367027.git.leonard.crestez@nxp.com>
         <1535371320.5076.4.camel@pengutronix.de>
In-Reply-To: <1535371320.5076.4.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4627;6:hnVWw2q+9BYBEJjmGtcps7sClhKNaCTvPfO2OmunNtlkM9jDYw/URgksScUopqH9b9qSEaQvq7FTS4zP93obBdvjVRziwq4xvuH0jW1VPCH4ngw3GYRa5rt5aQly2AxO51d/1AgqpeoJ3soE8+0qsE3GB79I6+ouOU2V8oXzxPEtOqi2rwvrkibBSthMwyfxR9++t1l1jqVJ1xvhrIZmXDwA1CR3B1YIEPL8C/Vm88YimXPmJHxLzZOHWKPH8B+rD8UN2fIPISZa9b5VrbjbaLirKTrkSd/OKUvBMvY377V0AlYtYT42vVGvFnRMLyO7FMlhCpiO4T06Oyg+kkKZwcm/o+JC9yBlE7wtwZ+wFUJT756YJG3qY/SX8F+5PLLWbnv7u8BFRrKVpcE5RthDj3Kssi+fkENbuqzGG+Zn4domuYjrRtqmm83qfayLucCLerUBdSVWTA6hXLsD0xFrpQ==;5:MpBfNALePyfHoHPtXpDwWUqSOEWXHvXnVprFF/oEWgA+Cwwkcka6m7LydTtxn9oNGPPtgTJUsKtw54gXPHsQkLZrZZfMk6SftCVz7U5bip4IxckLbO5zYUa+ISRSypBp80He+j1hdqI4CPDp1fNs1Bxtc5YMimn7V6ubgCWXXF0=;7:Xto7p6hgI5ghSyoQAV8xO7oDXuikM5cmheLmwiJXomXs/u6aV8TTVBehoJlbyrKuWJlUIyha8u+5pHFbXbTtap2eunZ/hiI5XMJ9bTdJW026oNDpoueo6E2Y34Sg4BFke1GPnhxZLx40dhhSqOyXlEnOdH/xnOZ7ET6ic1DVaOE36ZEncKAncnM8+zun3DmZgphZUt3lKtGzAE5G4AeDY30Vgv68AnhS5xP7TJvyA4YSc5z93te399nSUKi4M9MW
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9cff7139-723a-453e-7cce-08d611a44cfa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4627;
x-ms-traffictypediagnostic: AM0PR04MB4627:
x-microsoft-antispam-prvs: <AM0PR04MB46278C46AAA8AD712A79C9C6EE0C0@AM0PR04MB4627.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:AM0PR04MB4627;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4627;
x-forefront-prvs: 0784C803FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(366004)(199004)(189003)(2616005)(2900100001)(97736004)(44832011)(11346002)(86362001)(106356001)(110136005)(118296001)(105586002)(2906002)(6116002)(54906003)(316002)(3846002)(6246003)(486006)(476003)(2201001)(8676002)(2501003)(4326008)(5250100002)(305945005)(7736002)(446003)(25786009)(36756003)(6486002)(102836004)(229853002)(66066001)(26005)(99286004)(186003)(6506007)(76176011)(6436002)(6512007)(50226002)(81166006)(81156014)(53936002)(14454004)(8936002)(478600001)(256004)(68736007)(5660300001)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4627;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: D3gn11r17WV2XQqEz8aMmW42irJvQPYvzYrYrSV2h14MfjOeUKos1L5UOHtAEWFc5oK3IAbNXruHIaRRPMc+hVC6ETnkyyFm9UEc9PThB+FW48duAe42WWieLyJ/hOvaG4rOBxf62//qxZAjfu8lF4GapTBAhBhK5+IpoQiVsNnF4n0IIa6ZOX7/YRzPNyhBxBBt7Uzz/V3rq5dLlqHr4kxansTTDY5aJ7NgbC1KakKftke5c//LORJhA/N264yWzuFj0HAO95ssmpDTuM8MjKW14Ae3JIlKsJ7idKgeit0cCilkIQmqOe0EGkndIHpI+NTewShaZtSNwOUHBtE4/udv8OcAph2E1GYZjVnr/Rg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9249A45080D8A14DA328152D393C86D3@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cff7139-723a-453e-7cce-08d611a44cfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 13:51:08.2203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4627
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA4LTI3IGF0IDE0OjAyICswMjAwLCBQaGlsaXBwIFphYmVsIHdyb3RlOg0K
PiBIaSBMZW9uYXJkLA0KPiANCj4gT24gTW9uLCAyMDE4LTA4LTI3IGF0IDE0OjEwICswMzAwLCBM
ZW9uYXJkIENyZXN0ZXogd3JvdGU6DQo+ID4gQWRkaW5nIGxjZGlmIG5vZGVzIHRvIGEgcG93ZXIg
ZG9tYWluIGN1cnJlbnRseSBkb2Vzbid0IHdvcmssIGl0IHJlc3VsdHMNCj4gPiBpbiBibGFjay9j
b3JydXB0ZWQgc2NyZWVucyBvciBoYW5ncy4gV2hpbGUgdGhlIGRyaXZlciBkb2VzIGVuYWJsZQ0K
PiA+IHJ1bnRpbWUgcG0gaXQgZG9lcyBub3QgZGVhbCBjb3JyZWN0bHkgd2l0aCB0aGUgYmxvY2sg
YmVpbmcgdW5wb3dlcmVkLg0KPiA+IA0KPiA+IEFsbCBwYXRjaGVzIGluIHRoaXMgc2VyaWVzIGhh
dmUgcmV2aWV3IHRhZ3MgZnJvbSBhIGZldyB3ZWVrcyBhZ28uIEknbQ0KPiA+IHJlc2VuZGluZyB0
aGlzIHRvZGF5IGJlY2F1c2UgNC4xOSByYzEgd2FzIHJlbGVhc2VkLiBJJ20gbm90IHN1cmUgaWYg
dGhpcw0KPiA+IG1hdHRlcnMgZm9yIERSTSBidXQgaW4gc29tZSBhcmVhcyB1bnJlbGF0ZWQgc2Vy
aWVzIGdldCBsb3N0IGR1cmluZyB0aGUNCj4gPiBtZXJnZSB3aW5kb3cuDQo+ID4gDQo+ID4gTWFy
ZWsvUGhpbGxpcDogSXMgb25lIG9mIHlvdSBnb2luZyB0byBwaWNrIHVwIHRoZXNlIHBhdGNoZXM/
DQo+IA0KPiBJIGFzc3VtZWQgTWFyZWsgd291bGQgcGljayB0aGVtIHVwLg0KPiANCj4gTWFyZWss
IHNob3VsZCBJIHB1c2ggdGhlc2UgcGF0Y2hlcyB0byBkcm0tbWlzYy1maXhlcz8NCg0KSXQncyBi
ZWVuIGFub3RoZXIgd2VlaywgY2FuJ3Qgd2UgYXNzdW1lIG5vYm9keSBtaW5kcyBpZiB0aHNlIHBh
dGNoZXMNCmFyZSBwdXNoZWQ/DQoNCi0tDQpSZWdhcmRzLA0KTGVvbmFyZA==
