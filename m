Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05893C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF48720873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OprCWTiQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF48720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbeK0Sld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:41:33 -0500
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:37699
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728920AbeK0Slc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtcumXpdqcxO+2wHO+PDdW+84QGeCs+LpbDiV6nnRk8=;
 b=OprCWTiQOUmS+TF7p4uiMuIVO/xGgrmE8fDtJSOZ2Hobb7H6ifzI2z7J64TKPVSjRe2uQ1ggxRIS0TMC7XbyDXtqEJ38Q3BP9CUm/ZF01MKHSHFNlcR9ONR++Oh6EtGzoB5kKijdPoxNc2x3UywcU9c59z8oFJ+/Vn755wuWotM=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB3962.eurprd04.prod.outlook.com (52.134.107.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Tue, 27 Nov 2018 07:44:29 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b%5]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 07:44:29 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng DONG <aisheng.dong@nxp.com>
Subject: RE: [PATCH] can: flexcan: Implement CAN Runtime PM
Thread-Topic: [PATCH] can: flexcan: Implement CAN Runtime PM
Thread-Index: AQHUZ5CBGViPzGvSBkmCEccitD7z+6VagACAgAjzfCA=
Date:   Tue, 27 Nov 2018 07:44:29 +0000
Message-ID: <DB7PR04MB461851E4A4C494E8AC91AAEEE6D00@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20181019094326.28185-1-qiangqing.zhang@nxp.com>
 <24a43a20-7302-c449-06b3-5ee8f6c051a0@pengutronix.de>
In-Reply-To: <24a43a20-7302-c449-06b3-5ee8f6c051a0@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB3962;6:JdgRoEXbHakJs0YXsOWKCKe7KkdMogaWpcFNyzvcjjtcY0pxPKp54XhdUEEwkhVKqwGiMSDlzqm924KNIYbL9dmnbAcv42aCw8x0sjuO1Elr82+vL9Px5ceNeRY+wCJ6voSwmADkmvlb/+44RIamznVBOlBhTQUaWTuoJpW3ydJEQkuhpXOQviplDwI+c19CFHjoSPKVG0xqi9jI7pfRPelyq1mjJrlITzvNkw9tIQoqf1vEasy2rmzPl29SZCwHD0KSeiXZp8KoOEy+eeVUBWrjvCWAzTXz8dsN6vKAjzuIXtwinHlbn5d8BT1p+n7uSFA1m2XQsgMmyQ+fZB4zq4a7qWTAF1GdnS3R6cYVUS1ZGCF4mVvPdO20r0+XuqysXxWhtwTFnhT3n7z++enFiR8EY7wxc1EBh8rknuwsPERTTVnBOSrrhCWbW+rc40lyPdKW4fxbxuO56GcKZAtZ9g==;5:0ATzf2ziJqCOLQ1MS0oeYtQtnbuxN7YHoBBE2wsv/8n7qfM8ZDaVrwQRsU0F+V7bNAaqHeGLkUPOj7RABZsFm0C6sKn703gqVnjfw7DgTEpjTnybsJw9cTstF+7JHxVO+wKFv5gKKQCwO4OOr8+wVua8OrdwDyxV7HUS7zVkmHI=;7:BAI82Xrd3J0Hxmin/PYJeZMCBREmBYureNSahD9aORZIXqlnyoN6SWl3dwNlMbdxGp9UqE/DselYqXAjJlL5lCy8s5azo2PDLGFzcb8F26TJFssTeuHOGu1CYws2R8KTb18qjSkMWPeGhtjQ0+UV5w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 44a2727b-6977-4b7e-8a18-08d6543c29c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB3962;
x-ms-traffictypediagnostic: DB7PR04MB3962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-microsoft-antispam-prvs: <DB7PR04MB3962736BFA41C984879202ABE6D00@DB7PR04MB3962.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231443)(944501410)(4982022)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB3962;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB3962;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(39860400002)(376002)(13464003)(23433003)(189003)(199004)(9686003)(6306002)(97736004)(102836004)(229853002)(305945005)(7736002)(8676002)(6436002)(53546011)(6506007)(8936002)(81166006)(26005)(81156014)(2906002)(68736007)(6246003)(7696005)(2201001)(74316002)(53386004)(76176011)(186003)(55016002)(71190400001)(71200400001)(53936002)(486006)(86362001)(66066001)(2501003)(11346002)(110136005)(54906003)(105586002)(25786009)(476003)(14454004)(446003)(5660300001)(4326008)(99286004)(14444005)(33656002)(256004)(316002)(106356001)(6116002)(966005)(478600001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB3962;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2KE0ooV2EIV3Uxjj31mfNbKlcyCLFNzwUoxYMGEw2BkCYW8cC6wvIcEyx1QlRiNMdB6cGVaQGBanLttOTJC0NeWiAGzi7/yO8jEC4B5MAVtI5lnaaSu8j7pa8MqvuGcYVu98SWwYVNQZMnU1tj4mlo87hZXOkce7ogvntABjxfkacX0q+FfVrOUhih/5ZF6WDxsuDm//ZjrUC8z/neSDBmgRjGulizVkE+hwNQGf3UKoq63rQOlRqPVKkuIPd3x4QXuCanWul/eFreU+SwLXK+V2IxU2hmCmr1ZRqeVFqXmBYfDVWCaiHjUUmopbrHiDj/sDZ5xlloGsnyoVnjpi6+e9eM1UXpwmJTObiVMc6IM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a2727b-6977-4b7e-8a18-08d6543c29c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 07:44:29.4117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3962
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMTjlubQxMeaciDIx5pelIDIyOjM2DQo+
IFRvOiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPjsgd2dAZ3JhbmRlZ2dl
ci5jb207DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQNCj4gQ2M6IGxpbnV4LWNhbkB2Z2VyLmtlcm5l
bC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBBaXNoZW5nDQo+IERPTkcg
PGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjYW46IGZsZXhj
YW46IEltcGxlbWVudCBDQU4gUnVudGltZSBQTQ0KPiANCj4gT24gMTAvMTkvMTggMTE6NDUgQU0s
IEpvYWtpbSBaaGFuZyB3cm90ZToNCj4gPiBGcm9tOiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9u
Z0BueHAuY29tPg0KPiA+DQo+ID4gRmxleGNhbiB3aWxsIGJlIGRpc2FibGVkIGR1cmluZyBzdXNw
ZW5kIGlmIG5vIHdha2V1cCBmdW5jdGlvbiByZXF1aXJlZA0KPiA+IGFuZCBlbmFibGVkIGFmdGVy
IHJlc3VtZSBhY2NvcmRpbmdseS4gRHVyaW5nIHRoaXMgcGVyaW9kLCB3ZSBjb3VsZA0KPiA+IGV4
cGxpY2l0bHkgZGlzYWJsZSBjbG9ja3MuDQo+ID4NCj4gPiBJbXBsZW1lbnQgUnVudGltZSBQTSB3
aGljaCB3aWxsOg0KPiA+IDEpIEtlZXAgZGV2aWNlIGluIHN1c3BlbmQgc3RhdGUgKGNsb2NrcyBk
aXNhYmxlZCkgaWYgaXQncyBub3Qgb3Blbm5lZA0KPiA+IDIpIE1ha2UgUG93ZXIgRG9tYWluIGZy
YW1ld29yayBiZSBhYmxlIHRvIHNodXRkb3duIHRoZSBjb3JyZXNwb25kaW5nDQo+ID4gcG93ZXIg
ZG9tYWluIG9mIHRoaXMgZGV2aWNlLg0KPiANCj4gV2l0aG91dCBDT05GSUdfUE0gdGhlIGRldmlj
ZSBmYWlscyB0byBwcm9iZToNCj4gDQo+ID4gWyAgMjE0LjQyMDYwNl0gZmxleGNhbiAyMDkwMDAw
LmZsZXhjYW46IDIwOTAwMDAuZmxleGNhbiBzdXBwbHkgeGNlaXZlcg0KPiA+IG5vdCBmb3VuZCwg
dXNpbmcgZHVtbXkgcmVndWxhdG9yIFsgIDIxNC40NDU5NTJdIGZsZXhjYW4NCj4gPiAyMDkwMDAw
LmZsZXhjYW46IExpbmtlZCBhcyBhIGNvbnN1bWVyIHRvIHJlZ3VsYXRvci4wIFsgIDIxNC40NTM0
NDhdDQo+ID4gZmxleGNhbiAyMDkwMDAwLmZsZXhjYW46IHJlZ2lzdGVyaW5nIG5ldGRldiBmYWls
ZWQgWyAgMjE0LjQ1OTY2Nl0NCj4gPiBmbGV4Y2FuIDIwOTAwMDAuZmxleGNhbjogRHJvcHBpbmcg
dGhlIGxpbmsgdG8gcmVndWxhdG9yLjAgWw0KPiA+IDIxNC40NzIwNjZdIGZsZXhjYW46IHByb2Jl
IG9mIDIwOTAwMDAuZmxleGNhbiBmYWlsZWQgd2l0aCBlcnJvciAtMTEwDQo+IA0KPiBNYXJjDQoN
CkhpIE1hcmMsDQoNCkkgd291bGQgc2VudCBWMiByZWJhc2VkIG9uIHBhdGNoICJjYW46IGZsZXhj
YW46IGFkZCBzZWxmIHdha2V1cCBzdXBwb3J0IiwgYW5kIHJ1bnRpbWUgcG0gd29ya3Mgbm9ybWFs
bHkgb24gTVg2U1gtU0RCIGFuZCBNWDdELVNEQi4gU28sIGNvdWxkIHlvdSB0ZWxsIG1lIHdoaWNo
IGJvYXJkIHlvdSB0ZXN0ZWQgb24gdGhhdCBjYXVzZXMgdGhlIGRldmljZSBwcm9iZSBmYWlsZWQ/
DQoNCkFuZCB0aGF0IENPTkZJR19QTSBoYXMgc2V0IGluIGlteF92Nl92N19kZWZjb25maWcgd2hp
Y2ggY29uZmlnIGZpbGUgSSB1c2VkLg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCg0K
PiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgfCBNYXJjIEtsZWluZS1C
dWRkZSAgICAgICAgICAgfA0KPiBJbmR1c3RyaWFsIExpbnV4IFNvbHV0aW9ucyAgICAgICAgfCBQ
aG9uZTogKzQ5LTIzMS0yODI2LTkyNCAgICAgfA0KPiBWZXJ0cmV0dW5nIFdlc3QvRG9ydG11bmQg
ICAgICAgICAgfCBGYXg6ICAgKzQ5LTUxMjEtMjA2OTE3LTU1NTUgfA0KPiBBbXRzZ2VyaWNodCBI
aWxkZXNoZWltLCBIUkEgMjY4NiAgfCBodHRwOi8vd3d3LnBlbmd1dHJvbml4LmRlICAgfA0KDQo=
