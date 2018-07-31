Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C3EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51728208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P8NELGaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51728208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732131AbeGaN50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:57:26 -0400
Received: from mail-eopbgr30063.outbound.protection.outlook.com ([40.107.3.63]:21021
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731812AbeGaN5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpm4CG4E7JsM5QgwiHzXzn09xgMlPidwamhePW9lp64=;
 b=P8NELGaNCrn+z6Go+iL1Cqj6RshcLMnJdSws0SH9fOe15UIF3l6bcMkzi2g1H2NLTOZULDcpD5ErrqMgkGVr3auki3W9CvFOOuDIcTYxrOg3BFpxScDDU4Z/AMTsF3ybpkyRfo4Tm/i3Gl9BzGoYzLkz2Gf4DKOdKDFIgshtEII=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5057.eurprd04.prod.outlook.com (20.177.40.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Tue, 31 Jul 2018 12:17:17 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273%5]) with mapi id 15.20.0995.020; Tue, 31 Jul 2018
 12:17:17 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "marex@denx.de" <marex@denx.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Anson Huang <anson.huang@nxp.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2] drm/mxsfb: Fix runtime PM for unpowering lcdif block
Thread-Topic: [PATCH v2] drm/mxsfb: Fix runtime PM for unpowering lcdif block
Thread-Index: AQHUHbvBVHNun0c9gE+Re4WTXuPxrqSpTyKAgAAGPQA=
Date:   Tue, 31 Jul 2018 12:17:17 +0000
Message-ID: <c5e9f521edbca4b1b168e4ee6c8fbd41b1ca2261.camel@nxp.com>
References: <f873c5592e9907beba905ce68358d5ae2f63a4d7.1531824173.git.leonard.crestez@nxp.com>
         <1533038097.3444.13.camel@pengutronix.de>
In-Reply-To: <1533038097.3444.13.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5057;6:MIN4i8Hmyn9TLAGKldEO7zupf1DzFs433M4FI0d5FyTUHY7//xgeovjoMiazUBeZJHLqjo8K47j9bXxAlZ1jpUM4FbNQijXdWttJFNxPZOs3UlW0SKkqH8pajUfktIhIkmvHJXotk3f8Rxs+RqyWo1q00/mlbdb+gDLKNJOvEtG4i6Ag8DFFT8MCB1EBpvHP/m/EhMwDk31HD7KagqUBnvpBi1uwogsub8DE9zCSb1bceej5MAMq9ewDCtkCYXyC5FCCd+b9znXZT15OBFwjW9R9sMmY+kxMxgavibkYICghiQTei4o2k7y5XXDOFw9aD7GxZCPj1t4aCXD1YzGzoUl/+lKTBgZvUf++3uxte6nCkIQGAqYjPTnSlcY4xPFYii+m+LaBed7wW0EIzelKDtUcuLaWFCmmoA6bhEd8TIyMr3LyUYVrSqc2DxYNZQPGTwPS1pekJaiisJQuqfzDOQ==;5:Jb/iepFNZMypnhuifN5VwQKyMzYmuhJZTBLZVseyJxrHpdSRSKSkxcYRhNtj7jp5lIgpt6shSE3bDYxPHfgTea3/rL4/nMvEsvGlPN3Jcm0TXJVKZsSZIZ0AQ4IQWs3bf8mE/IXGt5Y1DY9yixmyt9fDCCTzDuMRVg70M6nbhH8=;7:NthfMYs9p/jLeWCaT5ZvxKgrNU5NyKIyzbxYzOKPvKN6/57h98EP7lVjTfOUjlMPgKOcthfDS9JLZdsQ5y431Fg0dtAEIZ4yRDVVIO2n7j1d0kltlm/jI9SarE0srp+yrLnaSBSZ94i7LxBO2yqtmtd9xrPPDpKQ4Siz+eW2VRToFK/QeMUqGEG4ktAaJkIYW7iLUhC2kvKTtKfMMHqC8wW72Cxb88I3Nu7MINuElwD7HW80M0di1RSaQds0eT1T
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4d085ebc-ea88-4eb8-25da-08d5f6df8ea8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5057;
x-ms-traffictypediagnostic: AM0PR04MB5057:
x-microsoft-antispam-prvs: <AM0PR04MB50575D39AC39A91DF7C98875EE2E0@AM0PR04MB5057.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB5057;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5057;
x-forefront-prvs: 0750463DC9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(396003)(136003)(39860400002)(189003)(199004)(305945005)(256004)(2906002)(14454004)(66066001)(105586002)(106356001)(5250100002)(2501003)(54906003)(110136005)(44832011)(7736002)(14444005)(486006)(2616005)(476003)(478600001)(2201001)(5660300001)(99286004)(36756003)(86362001)(316002)(102836004)(68736007)(50226002)(26005)(6506007)(76176011)(3846002)(6116002)(8936002)(8676002)(186003)(97736004)(81156014)(81166006)(4326008)(25786009)(6246003)(229853002)(118296001)(2900100001)(53936002)(11346002)(446003)(6486002)(6436002)(6512007)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5057;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: U1jzc4v/0f8YNG+t2mFX2ACtZ7lFKg70CgDpmnDVaEsUzXImJyhZN12P05n4KxO6hlMMOU8YgxRj5dwgGdB+spSPCeXOkxPEhbv8t05ZotEHtmC55kGGbhK/Chtmh5R5N+c4QvBxRvXwt1FgpXoXpt++gLii33rcDS7Bph7iZYyQlIJoClFqT5V8UBGp8kzwrKXvd3oRKgh+4Xh+/33jFJsWnXLne8xbUlTtgXhanXnslqw3JqMJlsPLEX+YnRU/mloE4Sk7VApnc2rY0w5yVZweetUHeQnJ1s/TPhdf334ZKEUikaLgVXjZ4VypjSGmhioEJj0spIsqCCUPpcIwy30ab41KwQsJbdY749eamu4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA70F8922055124CBB936B2738CCACF3@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d085ebc-ea88-4eb8-25da-08d5f6df8ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2018 12:17:17.3436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTMxIGF0IDEzOjU0ICswMjAwLCBQaGlsaXBwIFphYmVsIHdyb3RlOg0K
PiBPbiBUdWUsIDIwMTgtMDctMTcgYXQgMTM6NDggKzAzMDAsIExlb25hcmQgQ3Jlc3RleiB3cm90
ZToNCj4gPiBBZGRpbmcgbGNkaWYgbm9kZXMgdG8gYSBwb3dlciBkb21haW4gY3VycmVudGx5IGRv
ZXMgd29yaywgaXQgcmVzdWx0cyBpbg0KPiA+IGJsYWNrL2NvcnJ1cHRlZCBzY3JlZW5zIG9yIGhh
bmdzLiBXaGlsZSB0aGUgZHJpdmVyIGRvZXMgZW5hYmxlIHJ1bnRpbWUNCj4gPiBwbSBpdCBkb2Vz
IG5vdCBkZWFsIGNvcnJlY3RseSB3aXRoIHRoZSBibG9jayBiZWluZyB1bnBvd2VyZWQuDQo+ID4g
DQo+ID4gRW5zdXJlIHBvd2VyIGlzIG9uIHdoZW4gcmVxdWlyZWQgYnkgYWRkaW5nIHBtX3J1bnRp
bWVfZ2V0L3B1dF9zeW5jIHRvDQo+ID4gbXhzZmJfcGlwZV9lbmFibGUvZGlzYWJsZS4NCj4gPiAN
Cj4gPiBTaW5jZSBwb3dlciBpcyBsb3N0IG9uIHN1c3BlbmQgaW1wbGVtZW50IFBNX1NMRUVQX09Q
UyB1c2luZw0KPiA+IGRybV9tb2RlX2NvbmZpZ19oZWxwZXJfc3VzcGVuZC9yZXN1bWUuDQo+ID4g
DQo+ID4gVGhlIG14c2ZiX3BsYW5lX2F0b21pY191cGRhdGUgZnVuY3Rpb24gY2FuIGdldCBjYWxs
ZWQgYmVmb3JlDQo+ID4gbXhzZmJfcGlwZV9lbmFibGUgd2hpbGUgdGhlIGJsb2NrIGlzIG5vdCB5
ZXQgcG93ZXJlZC4gV2hlbiB0aGlzIGhhcHBlbnMNCj4gPiB0aGUgd3JpdGUgdG8gTENESUZfTkVY
VF9CVUYgaXMgbG9zdCBjYXVzaW5nIGNvcnJ1cHQgZGlzcGxheSBvbiB1bmJsYW5rDQo+ID4gdW50
aWwgYSByZWZyZXNoLg0KPiANCj4gV2h5IGRvZXMgdGhpcyBoYXBwZW4/DQoNCkknbSBub3Qgc3Vy
ZSB3aGF0IHlvdSdyZSBhc2tpbmcgYnV0IHJlZ2lzdGVyIHdyaXRlcyB0byB1bnBvd2VyZWQgb3IN
CnVuY2xvY2tlZCBibG9ja3MgYXJlIG5vdCBleHBlY3RlZCB0byAianVzdCB3b3JrIi4gSGVyZSB0
aGUgd3JpdGUgaXMNCmlnbm9yZWQvbG9zdCBidXQgSSB0aGluayBvbiBpbXg4IGl0IGNhbiBldmVu
IGNhdXNlIGEgYnVzIGVycm9yLg0KDQpUaGUgYXBwcm9hY2ggaGVyZSBpcyB0byBvbmx5IHNldCB0
aGUgZnJhbWVidWZmZXIgYWRkcmVzcyBhcyBwYXJ0IG9mDQphY3RpdmF0aW5nIHRoZSBkaXNwbGF5
Lg0KDQo+ID4gRml4IHRoaXMgYnkgbm90IHdyaXRpbmcgZ2VtLT5wYWRkciBpZiB0aGUgYmxvY2sg
aXMgbm90IGVuYWJsZWQgYW5kDQo+ID4gaW5zdGVhZCBkZWxheWluZyB0aGUgd3JpdGUgdW50aWwg
dGhlIG5leHQgbXhzZmJfY3J0Y19tb2RlX3NldF9ub2ZiIGNhbGwuDQo+ID4gQXQgdGhhdCBwb2lu
dCBhbHNvIHVwZGF0ZSBjdXJfYnVmIHRvIGF2b2lkIGFuIGluaXRpYWwgY29ycnVwdCBmcmFtZQ0K
PiA+IGFmdGVyIHJlc3VtZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBMZW9uYXJkIENyZXN0
ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0KPiANCj4gVGVzdGVkLWJ5OiBQaGlsaXBwIFph
YmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPg0KPiANCj4gb24gaW14NnVsbC1ldmssIHRoaXMg
Zml4ZXMgdGhlIGluaXRpYWwgY29ycnVwdCBmcmFtZS4NCg0KQ29vbCE=
