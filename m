Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9A1C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B171206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mNLt7JR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B171206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbeKTTg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:36:57 -0500
Received: from mail-eopbgr60079.outbound.protection.outlook.com ([40.107.6.79]:10368
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbeKTTg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Vtfgpu2Y5QlQKyzseBBsprruZNGgqzQyhRi0mpl/uE=;
 b=mNLt7JR/QDKXidvJjvYyYWygzvWweu/ti/1pEihezdswcor6yhVHvGw1CkWTjxEnIh8swzP1PuCDX71EXeDZn8Qs+WLL2fxDFEq/xfTnPqsBLJhaYrsKD4Yt8HGrpFej5Vz3cE1eJCbZvQWo5vdx4HM+26woXqk7BEFha8TRckc=
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com (52.135.138.28) by
 DB7PR04MB5292.eurprd04.prod.outlook.com (20.176.236.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.45; Tue, 20 Nov 2018 09:08:37 +0000
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::bd2a:c4b2:5356:89e2]) by DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::bd2a:c4b2:5356:89e2%4]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 09:08:37 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3 0/4] Correct dma pool for imx-sdma
Thread-Topic: [PATCH v3 0/4] Correct dma pool for imx-sdma
Thread-Index: AQHUdYJucz7zxVN5U02w+5UfDam2OKVMVYKAgAwe5sA=
Date:   Tue, 20 Nov 2018 09:08:37 +0000
Message-ID: <DB7PR04MB45382D679D013CD594F02AD689D90@DB7PR04MB4538.eurprd04.prod.outlook.com>
References: <1541504525-25720-1-git-send-email-yibin.gong@nxp.com>
 <1542038185.4011.5.camel@pengutronix.de>
In-Reply-To: <1542038185.4011.5.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5292;6:gV0jnjgKVy4OfnnZ3mSMRBrfKCyQCfAfPqM/WbRd+eOY7W/gfgjm157U9Ge8n0rGN3/LwBfoIkY+QmxFR7IfQqijKQT1EJGi8jSWOUAnbYVSR7Nj4jtMukKcLTBhNHvqlU+QFOnlbGpdS45DauR8uXyYq1zC4tVCb1kHnI/JB3XH/6gue8S38wzdTG5plB4KI6Nhr2d3rJww4ZWnjx6WVZjnBSz87PWK1fFt4fVEvghJBGgP3v1Jiomxs7kFy/gfLbXfjd3hn7QY1V6CvTc3w2LydNm5ptpWW/dYnz0IBQ/BCxeli9vyIaBg18XP0ZYmA6ZNkQYMEEg8W/jY1a7oVV2Mv7/1F8FwYkseBLpktaN7v1ckveQTypuBMnmYGicjWoXPkw2K4PasnnQ6qeLMez6K+Z6ezMs9xoD5dMX+W6iWxFxzsblfuFPBsziRWSzLCubUyQFeyBvm7Zx4qcoNeA==;5:7qTe4c91kpD5NdMR600B+JMwUwiw4A5RbSrMtcfIvHkrCuiwSaWI8SVLjeoRANqIciwaQfGrKwsGdkjSt3DL3w9m/I7wCPuQpLtomTDmdlYtKgdjtewVBAmZjKlamqWgcnDtVETAIESwJUIeIIfhVdTKXiNDN/X2psVWBcf38fM=;7:W7nVXPAKtKUTplcnBc6w4nAb73Zcv+Kh0AerBGo0NU1c0NeSeC68BD92ieMs9BLqkCXN4VN0m4Ti5tWK4H//f8T9ran4MwfZ2XHNcuCCQP4clH6ENx/VXuI39rV/wCu5flNA3JIm1W4D3kzYjq86kg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f28d55ba-72b7-4d3e-2037-08d64ec7c1cc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5292;
x-ms-traffictypediagnostic: DB7PR04MB5292:
x-microsoft-antispam-prvs: <DB7PR04MB529202B12005BDC376A5510C89D90@DB7PR04MB5292.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(45079756050767)(189930954265078)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231442)(944501410)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5292;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5292;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(346002)(39860400002)(199004)(189003)(13464003)(14454004)(71190400001)(55016002)(2900100001)(486006)(6436002)(53936002)(25786009)(966005)(6506007)(53546011)(71200400001)(81156014)(305945005)(7736002)(186003)(2906002)(33656002)(476003)(229853002)(26005)(102836004)(5660300001)(256004)(14444005)(8676002)(68736007)(45080400002)(81166006)(9686003)(105586002)(110136005)(97736004)(3846002)(6306002)(76176011)(54906003)(8936002)(6116002)(446003)(11346002)(74316002)(2501003)(86362001)(7696005)(4326008)(316002)(66066001)(6246003)(106356001)(478600001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5292;H:DB7PR04MB4538.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UjdM4e2H1E482TXFVFO3nWM55WSLXyQBZJmn8/lGmY65NV6Y9k7uvDsUeKEOoUZDXyof7+zmi6sfdR1u/UdQ7JYpIlp+wVdFKPK0slu3A99VjhFkQWHVkoPPKgMq4umKDn7SKci7n5HCqu2qbadMLqeyGZts8To2hP6jPMDuTiHMEjpU2mPwO5oUihOoaPDaWRWpnEd/Jwc6/rt34p1k4cXs5jt4K+Nrbp6Wg+QzeB6EOjBuEi52GdZhF/4XZUQqB+XhyopD33JUsykp7IlWY4vjwEJwMpjeF6QDQ/8E4JU9H7WPzp2O3w4iYOVSulfIsc7eG+ByRlupBem7ucXbXgyEt2ajQZXwODq8Zq5XqCA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28d55ba-72b7-4d3e-2037-08d64ec7c1cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:08:37.6030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5292
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVjYXMgU3RhY2ggPGwu
c3RhY2hAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMTjlubQxMeaciDEy5pelIDIzOjU2DQo+
IFRvOiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+OyB2a291bEBrZXJuZWwub3JnDQo+
IENjOiBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYzIDAvNF0gQ29ycmVjdCBkbWEgcG9vbCBmb3IgaW14LXNkbWENCj4gDQo+IEhpIFJv
YmluLA0KPiANCj4gQW0gRGllbnN0YWcsIGRlbiAwNi4xMS4yMDE4LCAwMzo0MCArMDAwMCBzY2hy
aWViIFJvYmluIEdvbmc6DQo+ID4gVGhpcyBwYXRjaCBzZXQgdG8gY29ycmVjdCBkbWEgcG9vbCB1
c2VkIGluIHRoZSBjb21taXQgZmU1Yjg1YzY1NmJjDQo+ID4gKCJkbWFlbmdpbmU6IGlteC1zZG1h
OiBhbGxvY2xhdGUgYmQgbWVtb3J5IGZyb20gZG1hIHBvb2wiKSBiZWNhdXNlIGFsbA0KPiA+IGJk
cyBzaG91bGQgYmUgY29udGlndW91cyBpbiBtZW1vcnkgaW4gbXVsdGkgYmRzIGNhc2UgZm9yIHNk
bWEsIGJ1dCBkbWENCj4gPiBwb29sIGNhbid0IHN0YXRpZnkgaXQgYW5kIGNhdXNlIHRyYW5zZmVy
IGZhaWx1cmUgdGhlbi5UaGFuayBMdWNhcyBmb3INCj4gPiB0aGUgbWFraW5nIHRoaW5ncyBvbiB0
aGUgcmlnaHQgd2F5Lg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXQgaXMgdjMgYmFzZWQgb24gTHVj
YXMncyBWMS9WMiwgdGhlIG1haW4gcmVmaW5lOg0KPiA+IMKgIC0tZml4IHRoZSBpc3N1ZSBJIHJl
cG9ydGVkIGluIFYxIGJ1dCBMdWNhcyB3b3JrYXJvdW5kIGl0IGJ5IGltcHJvcGVyDQo+ID4gwqDC
oMKgwqB3YXkgaW4gVjIuDQo+ID4gwqAgLS1hZGQgdmNoYW5fc3luY2hyb25pemUoKSB0byBraWxs
IHRhc2tsZXQgaW4gdmlydC1kbWEgaW50ZXJuYWwuDQo+ID4gwqAgLS1yZWZpbmUgbmFtZTogdXNl
IHNkbWFfZGlzYWJsZV9jaGFubmVsX2FzeW5jIGluc3RlYWQgb2YNCj4gPiDCoMKgwqDCoHNkbWFf
ZGlzYWJsZV9jaGFubmVsX3dpdGhfZGVsYXkgc2luY2Ugbm8gZGVsYXkgaW5kZWVkIGZvcg0KPiA+
IMKgwqDCoMKgZGV2aWNlX3Rlcm1pbmF0ZV9hbGwuDQo+ID4gUGxlYXNlIHJlZmVyIHRvIGJlbG93
IGxpbmsgZm9yIG1vcmUgaW5mb3JtYXRpb246DQo+ID4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnBhdA0KPiA+DQo+IGNo
d29yay5rZXJuZWwub3JnJTJGcGF0Y2glMkYxMDYwMTExMSZhbXA7ZGF0YT0wMiU3QzAxJTdDeWli
aW4uZ29uZw0KPiAlNDBuDQo+ID4NCj4geHAuY29tJTdDZThmYWVhOTg0ZGIyNDUxM2JjYTIwOGQ2
NDhiNzY2ZmMlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2QNCj4gOTljNWMNCj4gPg0KPiAzMDE2MzUl
N0MwJTdDMCU3QzYzNjc3NjM0OTg3Mzk0MDA3NyZhbXA7c2RhdGE9VTZ5M0NNVW1NZmlJekJjDQo+
IFptN2pabVhUZg0KPiA+IDRKQmdPbkJFaUhoa1k2ZWp6bDglM0QmYW1wO3Jlc2VydmVkPTANCj4g
DQo+IFRoYW5rcyBmb3IgdGFraW5nIGNhcmUgb2YgdGhvc2UuIEkndmUgdGVzdGVkIHRoZW0gb24g
bXkgYm9hcmQgYW5kIHRoaW5ncyBzZWVtDQo+IHRvIHdvcmsgZmluZSBmb3IgYWxsIG15IHVzZS1j
YXNlcy4NCj4gDQo+IEkgdGhpbmsgdGhvc2UgcGF0Y2hlcyBzaG91bGQgZ2V0IGEgQ0MgdG8gc3Rh
YmxlIDQuMTkuIEkgZ3Vlc3MgVmlub2QgY2FuIGFkZCB0aGlzDQo+IHdoZW4gYXBwbHlpbmcgdGhl
IHBhdGNoc2V0Lg0KWWVzLCB3ZSdkIGJldHRlciBmaXggb24gNC4xOS4gSG9wZSBWaW5vZCBjb3Vs
ZCBoZWxwIHVzLg0KPiANCj4gUmVnYXJkcywNCj4gTHVjYXMNCg==
