Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB33C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F2D2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="t/csZLjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F2D2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeH3NUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:20:43 -0400
Received: from mail-eopbgr00064.outbound.protection.outlook.com ([40.107.0.64]:52231
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727089AbeH3NUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDO9ECq+NmwuHWWu4wMKIyya68j+O7y6HJe7zj1EVik=;
 b=t/csZLjFAEjeZXaQ05ZLxdSX9iqAyff6aRHeo40i5fiiik8At7LC4AehMkqCfo093M0xxDIc1ORK4PdBAY1lH/gElfs6nkexe0pdLh0n924W6UiSK0XSTidpjK4JqUu/5nlf1FjBGB2LgL58We+lhuEWDuWEOZ8UXsw0yhAp7tM=
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com (52.135.167.33) by
 AM6PR04MB5205.eurprd04.prod.outlook.com (20.177.35.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Thu, 30 Aug 2018 09:19:28 +0000
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::e955:4d48:f0eb:3fe]) by AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::e955:4d48:f0eb:3fe%2]) with mapi id 15.20.1101.007; Thu, 30 Aug 2018
 09:19:28 +0000
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v5] spi: spi-mem: Adjust op len based on message/transfer
 size limitations
Thread-Topic: [PATCH v5] spi: spi-mem: Adjust op len based on message/transfer
 size limitations
Thread-Index: AQHUQD2O4kyVAisnBk6Un+WVuMRBpqTX+6+AgAAG3OCAAAE/AIAAAIdw
Date:   Thu, 30 Aug 2018 09:19:28 +0000
Message-ID: <AM6PR04MB43576978AD45C4D335E0321897080@AM6PR04MB4357.eurprd04.prod.outlook.com>
References: <1535618604-21706-1-git-send-email-chuanhua.han@nxp.com>
        <20180830104729.5c7fefad@bbrezillon>
        <AM6PR04MB4357DA161E8FCDB7B0B5C42697080@AM6PR04MB4357.eurprd04.prod.outlook.com>
 <20180830111630.19ab2fc4@bbrezillon>
In-Reply-To: <20180830111630.19ab2fc4@bbrezillon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chuanhua.han@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5205;6:+zSfOC6q+DJN4lfCEfzJmTrOVOBmcsHe4nMiBtM9cMODI+od990P5GZ0rZMHQJwweXRElcqgK9MJNy0zpB561Bc0BDj0q3m2vn6FNZejH9qQnVfSmMx2VMfzuyLWYid+e3BsL5rKoGTqvbQzN5bY9UhSc44YegrruDb2dE3LwTxmuYNzNiG4F/LuIWPNq/j0sAHzOmf6zkVg7qTvi3zJ9Ycu4JFmlXzVE69K1naOC4Kv2cL8Q8GJOY81rgVsPXTluAEXNINIWtMlRLFiTol1XMQFFbIKiQDNSZlSdKhi7ejI4/MKutjrHLX6i9kvZQ/V0MVwDrwcDG/462PzOGWEgvOBDepbj30H9TURpS73OHRpctEcXeFdmrnT5sCbKw7wv2E+mtM1HTZu+pxmK84OdhKxHDfJvtTmNg1O/YQ2dqKAXXsvVM0GeXoar+O57WgggDpBn840qFovus6dqCLnfA==;5:wxndt+aHQJDejQrox8sXPsnF1kdFRgVX/bJ75OEalcc6F2W/XBp0C5gE/eMbLkYzGMEabJpcDxWUhuP1ZS/WlqmDAH4tHbdslXnek+7L5OuoQgObc1v7tLs3FCPc7jzbi1is7n07f1YcegKv7PRUAO6j5Zlo5u4WYgpEnS8J+yQ=;7:6RGXuZ6DMnrTOiT6TkUG11duZwihKHH8F8qLCadVXzaUgr0xBn3PFixJ5HsSoFTf6/IRMM+eKCqfC1zHHdHedhJo5ndSl/nAHUPACoz8X0Zsl48AJD200JSoelCMg9JlApR3uE8fvMLUyvan3BYwpq8kmYjqKh9B+smCyObDrWSSEUGUU4xGWcedtWXTt3Nzc+c4EiA9eyZqP3aNCy6uNAPjDJQwmIOJ7hCU2vpohPn04Ff+bOJJ63rpnxz1b1z6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 77bceea9-3a76-4ce1-e26f-08d60e59aff5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5205;
x-ms-traffictypediagnostic: AM6PR04MB5205:
x-microsoft-antispam-prvs: <AM6PR04MB5205B12EF398D8D54B96D90897080@AM6PR04MB5205.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:AM6PR04MB5205;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5205;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(366004)(199004)(189003)(13464003)(99286004)(6916009)(81166006)(8936002)(93886005)(105586002)(106356001)(33656002)(478600001)(8676002)(2906002)(4326008)(68736007)(7736002)(74316002)(25786009)(81156014)(54906003)(14454004)(66066001)(15650500001)(53546011)(256004)(316002)(305945005)(6116002)(2900100001)(6436002)(9686003)(186003)(102836004)(5660300001)(5250100002)(476003)(6506007)(26005)(229853002)(3846002)(55016002)(7696005)(44832011)(97736004)(53936002)(86362001)(76176011)(6246003)(486006)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5205;H:AM6PR04MB4357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: L7lr+hdWOd5w2FNti0aFNRuOLDY5kN/QeoUraEgEZIXRMvA3ocBFW7Zk3rZrVgNtXAlAUW8yLJCJNuzP5Htc4KFuOsYzm8NmHhp4xk5Skr+0MmcZuxYSCoQE1YD7WzfhYgW4iZs0s2UeR/W+QI639UA0aPYWCSCle8knXCm94v6t5bcBytP0CtDcGddUiWbQDQhO4PChRpUkeXQ7odScoMYReJUWBCrWFy6b1Lf6ph7EeP5D1y1oOYfK7BBJX8cC9T6AlXziQ5P15yub9/n6LMmSOTN3ulKoIysWSw30hrTyVNBwxWZ4FP/jU/2Vs9smte9L4wFT8bY56ynBqsFZlhcJRLPNCtpRA5r3CXVVzg8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bceea9-3a76-4ce1-e26f-08d60e59aff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 09:19:28.5884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXMgQnJlemlsbG9u
IDxib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+DQo+IFNlbnQ6IDIwMTjlubQ45pyIMzDml6Ug
MTc6MTcNCj4gVG86IENodWFuaHVhIEhhbiA8Y2h1YW5odWEuaGFuQG54cC5jb20+DQo+IENjOiBi
cm9vbmllQGtlcm5lbC5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2NV0gc3BpOiBzcGktbWVtOiBBZGp1c3Qgb3AgbGVuIGJhc2VkIG9uIG1lc3Nh
Z2UvdHJhbnNmZXINCj4gc2l6ZSBsaW1pdGF0aW9ucw0KPiANCj4gT24gVGh1LCAzMCBBdWcgMjAx
OCAwOToxMzowMyArMDAwMA0KPiBDaHVhbmh1YSBIYW4gPGNodWFuaHVhLmhhbkBueHAuY29tPiB3
cm90ZToNCj4gDQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTog
Qm9yaXMgQnJlemlsbG9uIDxib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+DQo+ID4gPiBTZW50
OiAyMDE45bm0OOaciDMw5pelIDE2OjQ3DQo+ID4gPiBUbzogQ2h1YW5odWEgSGFuIDxjaHVhbmh1
YS5oYW5AbnhwLmNvbT4NCj4gPiA+IENjOiBicm9vbmllQGtlcm5lbC5vcmc7IGxpbnV4LXNwaUB2
Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzdGFi
bGVAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1XSBzcGk6IHNw
aS1tZW06IEFkanVzdCBvcCBsZW4gYmFzZWQgb24NCj4gPiA+IG1lc3NhZ2UvdHJhbnNmZXIgc2l6
ZSBsaW1pdGF0aW9ucw0KPiA+ID4NCj4gPiA+IEhpIENodWFuaHVhLA0KPiA+ID4NCj4gPiA+IE9u
IFRodSwgMzAgQXVnIDIwMTggMTY6NDM6MjQgKzA4MDANCj4gPiA+IENodWFuaHVhIEhhbiA8Y2h1
YW5odWEuaGFuQG54cC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gV2UgbmVlZCB0aGF0IHRv
IGFkanVzdCB0aGUgbGVuIG9mIHRoZSAybmQgdHJhbnNmZXIgKGNhbGxlZCBkYXRhIGluDQo+ID4g
PiA+IHNwaS1tZW0pIGlmIGl0J3MgdG9vIGxvbmcgdG8gZml0IGluIGEgU1BJIG1lc3NhZ2Ugb3Ig
U1BJIHRyYW5zZmVyLg0KPiA+ID4NCj4gPiA+IFlvdSBhbHJlYWR5IHNlbnQgdGhpcyBlbWFpbCBh
IGZldyBkYXlzIGJhY2suIFBsZWFzZSB3YWl0IGEgYml0DQo+ID4gPiBiZWZvcmUgc2VuZGluZyBp
dCBhZ2Fpbi4gQW5kIHdoZW4geW91IGRvIHNvIGFuZCBub3RoaW5nIGNoYW5nZWQgaW4NCj4gPiA+
IHRoZSBwYXRjaCBwbGVhc2UgdXNlIHRoZSBbUEFUQ0ggUkVTRU5EIHZYXSBwcmVmaXggYW5kIGV4
cGxhaW4gd2h5IHlvdQ0KPiByZXNlbmQgaXQuDQo+ID4gSSBoYXZlIG1vZGlmaWVkIHRoZSBwYXRj
aCBmb3IgdGhlIGNvbW1lbnQgeW91IG1lbnRpb25lZCBsYXN0IHRpbWUuIERvDQo+ID4geW91IG5l
ZWQgYW55IG90aGVyIG1vZGlmaWNhdGlvbu+8nw0KPiANCj4gT29wcywgc29ycnkuIExvb2tzIGxp
a2UgdGhlIHByZXZpb3VzIG9uZSB3YXMgb25seSBzZW50IHRvIG1lLCBub3QgdGhlIE1MIGFuZA0K
PiB0aGUgU1BJIG1haW50YWluZXIuDQpJdCBkb2Vzbid0IG1hdHRlcu+8jHRoYW5rIHlvdSBmb3Ig
eW91ciB2YWx1YWJsZSBhZHZpY2XvvIENCg==
