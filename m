Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B85BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1608020844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qyjPpiIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1608020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388588AbeGYCeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 22:34:03 -0400
Received: from mail-he1eur01on0054.outbound.protection.outlook.com ([104.47.0.54]:57120
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388487AbeGYCeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 22:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOIvamiw1PV/oJd+1X+l1NNO+rYZQdAdfE1jquxlFKY=;
 b=qyjPpiIQbhWKPV52b9c8Tai7ENQuUiEaWdxbqtHdnFkDFNpRPxQQBh83/fQ6l7Dm4xVSewO94pLeZ27g+YNuHMM3YppMuQdU6ShE5EgsqtbOOMPFKflhhOH2B8+6I5jps4q+crtL10AYqvIeiqyDfcomumrOf8Ts9bIlNQ6UasE=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3096.eurprd04.prod.outlook.com (10.170.214.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.20; Wed, 25 Jul 2018 01:24:45 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd%4]) with mapi id 15.20.0973.022; Wed, 25 Jul 2018
 01:24:45 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] dmaengine: imx-sdma: allocate max 20 bds for one
 transfer
Thread-Topic: [PATCH v3 3/3] dmaengine: imx-sdma: allocate max 20 bds for one
 transfer
Thread-Index: AQHUImnwBRfF8kmj8ke3SHRmSu0CG6ScoiYAgAARf8CAAWcnAIABBEDg
Date:   Wed, 25 Jul 2018 01:24:45 +0000
Message-ID: <DB6PR04MB32233768DB36BB208206EBCE89540@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <1532367972-29707-1-git-send-email-yibin.gong@nxp.com>
         <1532367972-29707-4-git-send-email-yibin.gong@nxp.com>
         <1532343252.3163.99.camel@pengutronix.de>
         <DB6PR04MB322323354B2184421502FC5889560@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <1532424136.32306.3.camel@pengutronix.de>
In-Reply-To: <1532424136.32306.3.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3096;6:6mmH0tbEdR4XITtTu2GgCMSL/Wx4IA6NY+TJSEg5kwXSl9PrwaXZ2uHGppVaKrCC0xQxY0ihokprioE0EsYmhYok60uW0JoUm+AjDi/lmvZ9Ar8YXYieIkLz/TlLmUZibw2Q3MFxP+xkdC4+T5LN+8rWv5HIUkbs6g5V8XU0lwOPSxpfvW0dAu3VgZ/ssMtkRqIqlcHDeFVOyftuXellUSyp1vT1Iqjf2aiiAFGahxL91o4UrJC/lVTIHpbGqiE9/If+cC1aKtpeSuOYgTZX1Zv+8dgaXdp6lAKXRPxyQ0kDFQxm89uWLM20HNQZpk5/367R+yd+eKoCRAjnt9BkTUNGhgcXDW9JiKS4IoD/AM9lkRSS5I0YnA6kEBQqLx2axx36n4qKmUvF5u/kZ51DSjwqw+CsXjN9QIY55y69CZYD34jlNQKt/i80bxtPqmGcl33Fr8Wib1wiVH0Lkcc4+Q==;5:/D/USr7F3mvdBH2rzzdJaXfgeKIVY9W5j5w5lwOJmddG8sTlddxyshoCfj2z1Q5amH8CpMwLtbQ2tnuo8Zoc6FPwas25OXifZLBQBW5ygE8dX0eQ3+osltGmexHZuXhHJfQzYpFu8jh1F23Eo7AU6/KZWhMcslKvNl3UU6teYWU=;7:OlEHztHxKA0vGzvRdQcfHFqzjot2hq1/zU9JIBLr6UTvtbV7R864TL6zFAJDfQdrd7lU5LuZ/GUcsTrlMkcAJ01Sc4n/NS35dC9gmJ7FjuigoG7TEeUmcRnKhZxG6BhU5u7Tdh9H7Pi1rwMLAXOW1k+MT74o7lh5HFdcY8JF2QwZWhI+MtouutxJwx8RvZ1wBjdp9SziGtFa7a2YWqtHfQGy6NxUC6Iqnw1gy3HICuQsHczqB8JTlNvEuajz93n+
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 52cfa918-7ebf-4a36-fe9d-08d5f1cd67f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3096;
x-ms-traffictypediagnostic: DB6PR04MB3096:
x-microsoft-antispam-prvs: <DB6PR04MB30962E12D21D018C0A9352FC89540@DB6PR04MB3096.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3096;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3096;
x-forefront-prvs: 0744CFB5E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(136003)(376002)(199004)(189003)(13464003)(102836004)(33656002)(76176011)(53546011)(14444005)(2201001)(476003)(256004)(486006)(99286004)(106356001)(105586002)(5660300001)(2906002)(7696005)(3846002)(14454004)(93886005)(4326008)(6246003)(316002)(478600001)(8676002)(5250100002)(2501003)(6506007)(81166006)(81156014)(6116002)(2900100001)(8936002)(7736002)(68736007)(74316002)(305945005)(54906003)(110136005)(229853002)(6436002)(55016002)(53936002)(97736004)(9686003)(66066001)(186003)(25786009)(86362001)(446003)(26005)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3096;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xdb9fmsJmZ/0K/QaKI1xLsukWsvTXoeTpPEmZ0nZ5v/xDRYexMi2ZzHakXiuHiu+NBfciA8hgpllCJda1QCLL4084WZdm5LCNQAYUKnqWls+Wr1xUyNJs2eaafDyLZxGJX/MX9u5zCTg8MCSk2gbaKJS9wfdWm7F61AeT3h/9wXGIbyy2+ciuQosEVuzxU6DVQPr4yJdUmn9TAfEHvNVtUaybrOqOamOa4CDoL/jTsi338BYfmzIMH45NCXKeF5RXyeNiPICLnYyIhm04ihJuH6EeAgwBY7bmSwTZdLf9H6oy8BBCuWAhsEJPL5KI+Bfyfo803L6AY8YAgaUqiyoBDUfibatzd5odT5ik7YaTuY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52cfa918-7ebf-4a36-fe9d-08d5f1cd67f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2018 01:24:45.7179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCBbbWFpbHRv
Omwuc3RhY2hAcGVuZ3V0cm9uaXguZGVdDQo+IFNlbnQ6IDIwMTjlubQ35pyIMjTml6UgMTc6MjIN
Cj4gVG86IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT47IHZrb3VsQGtlcm5lbC5vcmc7
DQo+IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbTsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsgbGlu
dXhAYXJtbGludXgub3JnLnVrDQo+IENjOiBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyBkbC1s
aW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAzLzNdIGRtYWVuZ2luZTogaW14
LXNkbWE6IGFsbG9jYXRlIG1heCAyMCBiZHMgZm9yIG9uZQ0KPiB0cmFuc2Zlcg0KPiANCj4gQW0g
TW9udGFnLCBkZW4gMjMuMDcuMjAxOCwgMTM6NTUgKzAwMDAgc2NocmllYiBSb2JpbiBHb25nOg0K
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEx1Y2FzIFN0YWNo
IFttYWlsdG86bC5zdGFjaEBwZW5ndXRyb25peC5kZV0NCj4gPiA+IFNlbnQ6IDIwMTjlubQ35pyI
MjPml6UgMTg6NTQNCj4gPiA+IFRvOiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+OyB2
a291bEBrZXJuZWwub3JnOw0KPiA+ID4gZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tOyBzLmhhdWVy
QHBlbmd1dHJvbml4LmRlOyBsaW51eEBhcm1saW51eC5vcg0KPiA+ID4gZy51aw0KPiA+ID4gQ2M6
IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5j
b20+Ow0KPiA+ID4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4g
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDMvM10gZG1hZW5naW5lOiBpbXgtc2RtYTogYWxsb2Nh
dGUgbWF4IDIwIGJkcw0KPiA+ID4gZm9yIG9uZSB0cmFuc2Zlcg0KPiA+ID4NCj4gPiA+IEFtIERp
ZW5zdGFnLCBkZW4gMjQuMDcuMjAxOCwgMDE6NDYgKzA4MDAgc2NocmllYiBSb2JpbiBHb25nOg0K
PiA+ID4gPiBJZiBtdWx0aS1iZHMgdXNlZCBpbiBvbmUgdHJhbnNmZXIsIGFsbCBiZHMgc2hvdWxk
IGJlIGNvbnNpc3Rlbg0KPiA+ID4gPiBtZW1vcnkuVG8gZWFzaWx5IGZvbGxvdyBpdCwgZW5sYXJn
ZSB0aGUgZG1hIHBvb2wgc2l6ZSBpbnRvIDIwIGJkcywNCj4gPiA+ID4gYW5kIGl0IHdpbGwgcmVw
b3J0IGVycm9yIGlmIHRoZSBudW1iZXIgb2YgYmRzIGlzIG92ZXIgdGhhbiAyMC4gRm9yDQo+ID4g
PiA+IGRtYXRlc3QsIHRoZSBtYXggY291bnQgZm9yIHNpbmdsZSB0cmFuc2ZlciBpcyBOVU1fQkQg
Kg0KPiA+ID4NCj4gPiA+IFNETUFfQkRfTUFYX0NOVA0KPiA+ID4gPiA9IDIwICogNjU1MzUgPSB+
MS4yOE1CLg0KPiA+ID4NCj4gPiA+IEJvdGggdGhlIGNvbW1pdCBtZXNzYWdlIGFuZCB0aGUgY29t
bWVudCBuZWVkIGEgbG90IG1vcmUgY2FyZSB0bw0KPiA+ID4gYWN0dWFsbHkgdGVsbCB3aGF0IHRo
aXMgY29tbWl0IGlzIHRyeWluZyB0byBhY2hpZXZlLiBDdXJyZW50bHkgSQ0KPiA+ID4gZG9uJ3Qg
Zm9sbG93IGF0IGFsbC4gV2hhdCBkb2VzICJjb25zaXN0ZW4iIG1lYW4/IERvIHlvdSBtZWFuIEJE
cw0KPiA+ID4gc2hvdWxkIGJlIGNvbnRpZ3VvdXMgaW4gbWVtb3J5Pw0KPiA+DQo+ID4gWWVzLCBC
RHMgc2hvdWxkIGJlIGNvbnRpZ3VvdXPCoMKgb25lIGJ5IG9uZSBpbiBtZW1vcnkuDQo+IA0KPiBP
a2F5LCBidXQgdGhpcyBpc24ndCB3aGF0IHRoZSBjb2RlIGNoYW5nZSBkb2VzLiBCeSBpbmNyZWFz
aW5nIHRoZSBzaXplDQo+IHBhcmFtZXRlciBvZiB0aGUgZG1hIHBvb2wgeW91IGp1c3QgYWxsb2Nh
dGUgMjAgdGltZXMgYXMgbXVjaCBtZW1vcnkgYXMNCj4gbmVlZGVkIGZvciBlYWNoIEJELiBTbyBh
Y3R1YWxseSB0aGUgQkRzIGVuZCB1cCBiZWluZyB2ZXJ5IG5vbi0gY29udGlndW91cyBpbg0KPiBt
ZW1vcnkgYXMgdGhlcmUgYXJlIG5vdyBob2xlcyBvZiAxOSBCRCBzaXplcyBiZXR3ZWVuIHRoZSBz
dGFydCBvZiBlYWNoIEJELg0KUGxlYXNlIG5vdGljZSBvbmx5IGFsbG9jYXRlIGJkcyBtZW1vcnkg
ZnJvbSBkbWEgcG9vbCBvbmUgdGltZSBldmVuIGluIG11bHRpIGJkcy4NClRoYXQncyBkaWZmZXJl
bnQgd2l0aCB0aGUgY29tbW9uIHVzZSBjYXNlIHRoYXQgYWxsb2NhdGUgbWVtb3J5IGZyb20gZG1h
IHBvb2wgZXZlcnl0aW1lDQpmb3IgZXZlcnkgYmQuIFdoeSBkbyB0aGlzIGlzIHRvIG1ha2Ugc3Vy
ZSBhbGwgYmQgbWVtb3J5IGlzIGNvbnRpZ3VvdXMgZm9yIHNpbmdsZSB0cmFuc2Zlcg0Kd2hhdGV2
ZXIgc2luZ2xlIGJkIG9yIG11bHRpLWJkcywgc2luY2UgdHdvIGNhbGwgZG1hX3Bvb2xfYWxsb2Mo
KSBjYW4ndCBwcm9taXNlIHRoZSBhZGRyZXNzDQppcyBjb250aWd1b3VzIGVzcGVjaWFsbHkgZm9y
IG11bHRpIHRocmVhZCBjYXNlIHN1Y2ggYXMgZG1hdGVzdCAndGhyZWFkc19wZXJfY2hhbiA9IDUn
LiBZb3UNCmNhbiBjaGFuZ2UgdG8gJyBub3JhbmRvbT10cnVlICcgYW5kICcgdGVzdF9idWZfc2l6
ZSA9IDE2Mzg0MCcgaW4gZG1hdGVzdC5jIHRvIGxvb2sgd2hhdA0KaXNzdWUgY29taW5nIHdpdGhv
dXQgdGhpcyBwYXRjaC4NCj4gDQo+IFNvIHNvbWV0aGluZyBpc24ndCByaWdodCB3aXRoIHRoaXMg
Y2hhbmdlLg0KSSB0aGluayB0aGlzIHBhdGNoIGlzIHRoZSBlYXN5IHdheSB0byByZXNvbHZlIHRo
ZSBiZCBjb250aWd1b3VzIGlzc3VlLCBidXQgdGhlIGNvc3QgaXMgdG8NCmFsbG9jYXRlIG1vcmUg
ZG1hIHBvb2wgbWVtb3J5IHdoaWNoIG1heSBub3QgdXNlZC4NCj4gDQo+IFJlZ2FyZHMsDQo+IEx1
Y2FzDQo+IA0KPiA+ID4NCj4gPiA+IFdoYXQgZG8geW91IGdhaW4gYnkgb3Zlci1hbGxvY2F0aW5n
IGVhY2ggQkQgYnkgYSBmYWN0b3Igb2YgMjA/DQo+ID4NCj4gPiBJIGd1ZXNzIGRtYV9wb29sX2Fs
bG9jIHdpbGwgcmV0dXJuIGVycm9yIGluIHN1Y2ggY2FzZSwgYW5kIHRoZW4gY2F1c2UNCj4gPiBk
bWEgc2V0dXAgdHJhbnNmZXIgZmFpbHVyZS4NCj4gPiA+DQo+ID4gPiBSZWdhcmRzLA0KPiA+ID4g
THVjYXMNCj4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdv
bmdAbnhwLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IMKgZHJpdmVycy9kbWEvaW14LXNkbWEu
YyB8IDE3ICsrKysrKysrKysrKysrKystDQo+ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDE2IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZG1hL2lteC1zZG1hLmMgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jIGluZGV4DQo+
ID4gPiA+IGI0ZWMyZDIuLjU5NzM0ODkgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZG1h
L2lteC1zZG1hLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KPiA+ID4g
PiBAQCAtMjk4LDYgKzI5OCwxNSBAQCBzdHJ1Y3Qgc2RtYV9jb250ZXh0X2RhdGEgew0KPiA+ID4g
PiA+IMKgCXUzMsKgwqBzY3JhdGNoNzsNCj4gPiA+ID4NCj4gPiA+ID4gwqB9IF9fYXR0cmlidXRl
X18gKChwYWNrZWQpKTsNCj4gPiA+ID4NCj4gPiA+ID4gKy8qDQo+ID4gPiA+ICsgKiBBbGwgYmRz
IGluIG9uZSB0cmFuc2ZlciBzaG91bGQgYmUgY29uc2l0ZW50IG9uIFNETUEuIFRvDQo+ID4gPiA+
IGVhc2lseQ0KPiA+ID4gPiArZm9sbG93IGl0LGp1c3QNCj4gPiA+ID4gKyAqIHNldCB0aGUgZG1h
IHBvb2wgc2l6ZSBhcyB0aGUgZW5vdWdoIGJkcy4gRm9yIGV4YW1wbGUsIGluDQo+ID4gPiA+IGRt
YXRlc3QNCj4gPiA+ID4gK2Nhc2UsIHRoZQ0KPiA+ID4gPiArICogbWF4IDIwIGJkcyBtZWFucyB0
aGUgbWF4IGZvciBzaW5nbGUgdHJhbnNmZXIgaXMgTlVNX0JEICoNCj4gPiA+ID4gK1NETUFfQkRf
TUFYX0NOVCA9IDIwDQo+ID4gPiA+ICsgKiAqIDY1NTM1ID0gfjEuMjhNQi4gMjAgYmRzIHN1cHBv
c2VkIHRvIGJlIGVub3VnaCBiYXNpY2FsbHkuSWYNCj4gPiA+ID4gaXQncw0KPiA+ID4gPiArc3Rp
bGwgbm90DQo+ID4gPiA+ICsgKiBlbm91Z2ggaW4gc29tZSBzcGVjaWZpYyBjYXNlcywgZW5sYXJn
ZSBpdCBoZXJlLldhcm5pbmcNCj4gPiA+ID4gbWVzc2FnZQ0KPiA+ID4gPiArd291bGQgYWxzbw0K
PiA+ID4gPiArICogYXBwZWFyIGlmIHRoZSBiZCBudW1iZXJzIGlzIG92ZXIgdGhhbiAyMC4NCj4g
PiA+ID4gKyAqLw0KPiA+ID4gPiArI2RlZmluZSBOVU1fQkQgMjANCj4gPiA+ID4NCj4gPiA+ID4g
wqBzdHJ1Y3Qgc2RtYV9lbmdpbmU7DQo+ID4gPiA+DQo+ID4gPiA+IEBAIC0xMjczLDcgKzEyODIs
NyBAQCBzdGF0aWMgaW50IHNkbWFfYWxsb2NfY2hhbl9yZXNvdXJjZXMoc3RydWN0DQo+ID4gPiA+
IGRtYV9jaGFuICpjaGFuKQ0KPiA+ID4gPiA+IMKgCQlnb3RvIGRpc2FibGVfY2xrX2FoYjsNCj4g
PiA+ID4gPiDCoAlzZG1hYy0+YmRfcG9vbCA9IGRtYV9wb29sX2NyZWF0ZSgiYmRfcG9vbCIsIGNo
YW4tDQo+ID4gPiA+ID4gPmRldmljZS0+ZGV2LA0KPiA+ID4gPiA+IC0JCQkJc2l6ZW9mKHN0cnVj
dA0KPiA+ID4gPiA+IHNkbWFfYnVmZmVyX2Rlc2NyaXB0b3IpLA0KPiA+ID4gPiA+ICsJCQkJTlVN
X0JEICogc2l6ZW9mKHN0cnVjdA0KPiA+ID4gPiA+IHNkbWFfYnVmZmVyX2Rlc2NyaXB0b3IpLA0K
PiA+ID4gPiA+IMKgCQkJCTMyLCAwKTsNCj4gPiA+ID4gPiDCoAlyZXR1cm4gMDsNCj4gPiA+ID4N
Cj4gPiA+ID4gQEAgLTEzMTQsNiArMTMyMywxMiBAQCBzdGF0aWMgc3RydWN0IHNkbWFfZGVzYw0K
PiA+ID4gPiAqc2RtYV90cmFuc2Zlcl9pbml0KHN0cnVjdCBzZG1hX2NoYW5uZWwgKnNkbWFjLA0K
PiA+ID4gPiDCoHsNCj4gPiA+ID4gPiDCoAlzdHJ1Y3Qgc2RtYV9kZXNjICpkZXNjOw0KPiA+ID4g
PiA+ICsJaWYgKGJkcyA+IE5VTV9CRCkgew0KPiA+ID4gPiA+ICsJCWRldl9lcnIoc2RtYWMtPnNk
bWEtPmRldiwgIiVkIGJkcyBleGNlZWQgdGhlDQo+ID4gPiA+ID4gbWF4ICVkXG4iLA0KPiA+ID4g
PiA+ICsJCQliZHMsIE5VTV9CRCk7DQo+ID4gPiA+ID4gKwkJZ290byBlcnJfb3V0Ow0KPiA+ID4g
PiA+ICsJfQ0KPiA+ID4gPg0KPiA+ID4gPiArDQo+ID4gPiA+ID4gwqAJZGVzYyA9IGt6YWxsb2Mo
KHNpemVvZigqZGVzYykpLCBHRlBfTk9XQUlUKTsNCj4gPiA+ID4gPiDCoAlpZiAoIWRlc2MpDQo+
ID4gPiA+ID4gwqAJCWdvdG8gZXJyX291dDsNCg==
