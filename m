Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD634C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7709620833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lm6nWJBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7709620833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeI3RJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 13:09:46 -0400
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:53863
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727821AbeI3RJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 13:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLx9dWVqWQy63V25cGfYy8FQSSzviWCQKU69wh/WiBI=;
 b=Lm6nWJBc6XygmNtS2Adea6iAIabwPsDkRjOF9sOyhik2i9jnHPnJCerIUbQ/gPJmuourlCB0+/tnbdF5eBzRQf1WkCNtx3eZbdkFvLtTHu7vOYKmBM3i/xZeh4TC+R0+gkas542+qApZZpsEY5P+o8DzPpbSYlEKIIElUE1q2Uk=
Received: from AM0PR04MB4353.eurprd04.prod.outlook.com (52.134.125.146) by
 AM0PR04MB4001.eurprd04.prod.outlook.com (52.134.90.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Sun, 30 Sep 2018 10:37:13 +0000
Received: from AM0PR04MB4353.eurprd04.prod.outlook.com
 ([fe80::a5b0:6887:b5b8:671b]) by AM0PR04MB4353.eurprd04.prod.outlook.com
 ([fe80::a5b0:6887:b5b8:671b%2]) with mapi id 15.20.1185.024; Sun, 30 Sep 2018
 10:37:13 +0000
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>
Subject: RE: [PATCH v2 2/4] spi: spi-fsl-dspi: Fix delete the processing of
 undefined bitmask for rxdata
Thread-Topic: [PATCH v2 2/4] spi: spi-fsl-dspi: Fix delete the processing of
 undefined bitmask for rxdata
Thread-Index: AQHUWJ+Hbyza9P0UEkqh7dCBW11Sq6UImWeAgAAANpCAAAKfgIAABULg
Date:   Sun, 30 Sep 2018 10:37:13 +0000
Message-ID: <AM0PR04MB4353FB4E5148D16B1647BA8A97EE0@AM0PR04MB4353.eurprd04.prod.outlook.com>
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
        <20180930092535.24544-2-chuanhua.han@nxp.com>
        <20180930120659.71b0e1e5@bbrezillon>
        <AM0PR04MB4353B48117292E511AC1E09F97EE0@AM0PR04MB4353.eurprd04.prod.outlook.com>
 <20180930121707.4724edd6@bbrezillon>
In-Reply-To: <20180930121707.4724edd6@bbrezillon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4001;6:v1oUdnX5hBo/fbO+ECukgrfA7ha1F06DO9zW7uYcTCU8N/3rpGdczInIV5gJdn9rsib1fpK8cDQ63VXyDr08l9zZNWIeY8iBoKb7gvIaqRPgKcxfcCu70CI401ZuCC9xIDAigOcAfzwRuQrpMwt70WUvQEnOhvJYipRysCCpaknM3XxbOq3ohAW3zQKV7Nv+LWM8gbeDr3z7M+pP3DVfZiWcsQM1Bw6LYFYeL4QKxo/Vu3OThIe7fbzjeK4J0gQmXMETsKHfA6GJKTt+O5JBfAHFeiXvXeJlyk8sRPc6yRpbJXEqCaSu/ouo4vPi9CXzE4dW+zIX0X9vEnj4nEL8uEpTOEbPMIenuFLUBEkvL1mx8VE4whzUm5cE4QD1y34Guqq5uQN3bdHTGR3OVFiOOtF95RjUltk1YrbEYjy4RdM6fpCUy8z+KT/athImrABDx5gcHnzbCH54F3aUSP88bg==;5:x2in4HsHqwLDDBOLDRFdLo3iVUZZZ2IsbeofrPPeiQzDqZq5T+WEmPQe4hqzq7DuJrIlohWh1JjIfFHsvCoXvwa4EOUxOTHWLoStY1p6ZJX6LI6fsSKh9qrmWzA2ZUSyAgaCDHqLaXW24Jm3ODbNLwMIyyFelinSK4qhmRHzK4c=;7:HoXxLLzYuwbeX8Wmzqsvse3oA1kOU5eN65/TPdk50QVs0Vjm2VMz52NA00pQZi7AuhEZIzwQWXkgIz9o/WutXo+IPtQhoNPb75prtKtYWmWvQtlRK5fmg9ZBQBqmKDylIfz6rgp0KMjuMgaZ0M+jaWsvlwYFBJe3Z6CzBX3OY8Tiy1ombDvwdcl4rSfTldTfDr6z9aKNWiAI+utaWcoNIqppQy+4fuCXh0d48NTdMNv4xVHqEMlzBEre8P5XbWUk
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 242df1b3-6cb1-4dbb-da89-08d626c0aefe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4001;
x-ms-traffictypediagnostic: AM0PR04MB4001:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chuanhua.han@nxp.com; 
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB40017CB3339F157684449EA697EE0@AM0PR04MB4001.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(45079756050767)(189930954265078)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:AM0PR04MB4001;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4001;
x-forefront-prvs: 08118EFC2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(376002)(136003)(199004)(13464003)(189003)(14444005)(3846002)(33656002)(53936002)(14454004)(54906003)(53546011)(6506007)(6916009)(68736007)(93886005)(186003)(4326008)(478600001)(316002)(99286004)(5660300001)(26005)(2906002)(102836004)(44832011)(305945005)(2900100001)(81156014)(7736002)(8676002)(486006)(76176011)(229853002)(81166006)(74316002)(71190400001)(71200400001)(66066001)(256004)(25786009)(7696005)(8936002)(5250100002)(105586002)(6436002)(6306002)(11346002)(106356001)(45080400002)(446003)(9686003)(575784001)(97736004)(6246003)(86362001)(55016002)(34290500001)(6116002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4001;H:AM0PR04MB4353.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: d4ahjCgL22Zfo2hymPp1pDS34eJysIAESXZkTEspI3KTaiyhccx6kzvFG4QlQw1Btq9XMPI++HNibBxzWyQATiFQfubGMmpfPT5GagEzwMDxHXY8UILSine1OGPpjTYvpkRlC6t1S3UH/W/SNilrdUW1cVeL+76Y8+GZ+nodKmvdlA7WT8AQc6K0R0Vrz6yqWL4WZKV0GZ8MSzZibgaszdGExjnaxVAUfJ4vxi8ZpOy6EOpR3XYirtstFF2CjfK5keuLz8TyTP04VqZHz9n8Pi3d5Fr7KR5idCrGY7iDbWdsP30xgnEthZW5OvvuGKSG1MNoImK96DHipDNqNG+FNoQyQFTPQ9p73pIn3QM2Wog=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242df1b3-6cb1-4dbb-da89-08d626c0aefe
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2018 10:37:13.0236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXMgQnJlemlsbG9u
IDxib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+DQo+IFNlbnQ6IDIwMTjlubQ55pyIMzDml6Ug
MTg6MTcNCj4gVG86IENodWFuaHVhIEhhbiA8Y2h1YW5odWEuaGFuQG54cC5jb20+DQo+IENjOiBi
cm9vbmllQGtlcm5lbC5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGVoYUBkZWlmLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYyIDIvNF0gc3BpOiBzcGktZnNsLWRzcGk6IEZpeCBkZWxldGUgdGhlIHByb2Nlc3Npbmcgb2YN
Cj4gdW5kZWZpbmVkIGJpdG1hc2sgZm9yIHJ4ZGF0YQ0KPiANCj4gT24gU3VuLCAzMCBTZXAgMjAx
OCAxMDoxMDoxNCArMDAwMA0KPiBDaHVhbmh1YSBIYW4gPGNodWFuaHVhLmhhbkBueHAuY29tPiB3
cm90ZToNCj4gDQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTog
Qm9yaXMgQnJlemlsbG9uIDxib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+DQo+ID4gPiBTZW50
OiAyMDE45bm0OeaciDMw5pelIDE4OjA3DQo+ID4gPiBUbzogQ2h1YW5odWEgSGFuIDxjaHVhbmh1
YS5oYW5AbnhwLmNvbT4NCj4gPiA+IENjOiBicm9vbmllQGtlcm5lbC5vcmc7IGxpbnV4LXNwaUB2
Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBlaGFA
ZGVpZi5jb20NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi80XSBzcGk6IHNwaS1mc2wt
ZHNwaTogRml4IGRlbGV0ZSB0aGUNCj4gPiA+IHByb2Nlc3Npbmcgb2YgdW5kZWZpbmVkIGJpdG1h
c2sgZm9yIHJ4ZGF0YQ0KPiA+ID4NCj4gPiA+IE9uIFN1biwgMzAgU2VwIDIwMTggMTc6MjU6MzMg
KzA4MDANCj4gPiA+IENodWFuaHVhIEhhbiA8Y2h1YW5odWEuaGFuQG54cC5jb20+IHdyb3RlOg0K
PiA+ID4NCj4gPiA+ID4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgcHJvYmxlbSBvZiByeGRhdGEgYmVp
bmcgZXF1YWwgdG8gMCBkdXJpbmcgdGhlDQo+ID4gPiA+IFhTUEkgbW9kZSB0cmFuc2ZlciBvZiB0
aGUgZHNwaSBjb250cm9sbGVyLg0KPiA+ID4gPiBJbiBYU1BJIG1vZGUsIElmIGl0IGlzIG5vdCBk
ZWxldGVkLCB0aGUgdmFsdWUgb2YgcnhkYXRhIHdpbGwgYmUNCj4gPiA+ID4gZXF1YWwgdG8gMCwg
YW5kIHRoZSBkYXRhIHJlY2VpdmVkIHdpbGwgbm90IGJlIHJlY2VpdmVkIGNvcnJlY3RseSwNCj4g
PiA+ID4gY2F1c2luZyB0aGUgcmVjZWl2aW5nIHRyYW5zZmVyIG9mIHRoZSBzcGkgdG8gZmFpbC4N
Cj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2h1YW5odWEgSGFuIDxjaHVhbmh1YS5o
YW5AbnhwLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gPiA+
ICAtVGhlIG9yaWdpbmFsIHBhdGNoIGlzIGRpdmlkZWQgaW50byBtdWx0aXBsZSBwYXRjaGVzKHRo
ZSBvcmlnaW5hbA0KPiA+ID4gPiBwYXRjaCB0aGVtZSBpcyAic3BpOiBzcGktZnNsLWRzcGk6IEZp
eCBzdXBwb3J0IGZvciBYU1BJIHRyYW5zcG9ydA0KPiA+ID4gPiBtb2RlIiksb25lIG9mIHdoaWNo
IGlzIHNlZ21lbnRlZC4NCj4gPiA+ID4NCj4gPiA+ID4gIGRyaXZlcnMvc3BpL3NwaS1mc2wtZHNw
aS5jIHwgMyAtLS0NCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQ0KPiA+
ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLWZzbC1kc3BpLmMNCj4g
PiA+ID4gYi9kcml2ZXJzL3NwaS9zcGktZnNsLWRzcGkuYyBpbmRleCAzMDgyZTcyZTRmNmMuLjRk
YzEwNjRiZjQwOA0KPiA+ID4gPiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9zcGkvc3Bp
LWZzbC1kc3BpLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9zcGkvc3BpLWZzbC1kc3BpLmMNCj4g
PiA+ID4gQEAgLTI0Myw5ICsyNDMsNiBAQCBzdGF0aWMgdm9pZCBkc3BpX3B1c2hfcngoc3RydWN0
IGZzbF9kc3BpDQo+ID4gPiA+ICpkc3BpLCB1MzINCj4gPiA+IHJ4ZGF0YSkNCj4gPiA+ID4gIAlp
ZiAoIWRzcGktPnJ4KQ0KPiA+ID4gPiAgCQlyZXR1cm47DQo+ID4gPiA+DQo+ID4gPiA+IC0JLyog
TWFzayBvZiB1bmRlZmluZWQgYml0cyAqLw0KPiA+ID4gPiAtCXJ4ZGF0YSAmPSAoMSA8PCBkc3Bp
LT5iaXRzX3Blcl93b3JkKSAtIDE7DQo+ID4gPiA+IC0NCj4gPiA+DQo+ID4gPiBXaHkgbm90DQo+
ID4gSW4geHNwaSBtb2RlLCB0aGUgdmFsdWUgb2YgcnhkYXRhIGFmdGVyIHRoZSBzdGF0ZW1lbnQg
aXMgcHJvY2Vzc2VkIGlzIGVxdWFsIHRvDQo+IDAgbm8gbWF0dGVyIHdoYXQgZGF0YSBpcyByZWNl
aXZlZC4NCj4gDQo+IE9ubHkgaWYgZHNwaS0+Yml0c19wZXJfd29yZCBpcyAwLg0KPiANCj4gQWN0
dWFsbHksIEkganVzdCBoYWQgYSBsb29rLCBhbmQgeGZlci0+Yml0c19wZXJfd29yZCBzaG91bGQg
bmV2ZXIgYmUgMCBiZWNhdXNlDQo+IHNwaV92YWxpZGF0ZSgpIG1ha2VzIHN1cmUgaXQncyBpbml0
aWFsaXplZCBbMV0uIERvbid0IGtub3cgd2hlcmUNCj4gZHBzaS0+Yml0c19wZXJfd29yZCBjb21l
cyBmcm9tLCBidXQgbWF5YmUgeW91IGhhdmUgYSBwcm9ibGVtIHRoZXJlDQo+IChkcHNpLT5iaXRz
X3Blcl93b3JkIGFuZCB4ZmVyLT5iaXRzX3Blcl93b3JkIG5vdCBpbiBzeW5jKS4NCj4gDQo+IFsx
XWh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cHMlM0ElMkYlMkZlbGkNCj4geGlyLmJvb3RsaW4uY29tJTJGbGludXglMkZ2NC4xOS1yYzUlMkZz
b3VyY2UlMkZkcml2ZXJzJTJGc3BpJTJGc3BpLmMlMjMNCj4gTDI4NjkmYW1wO2RhdGE9MDIlN0Mw
MSU3Q2NodWFuaHVhLmhhbiU0MG54cC5jb20lN0NkOTJhM2I1NGNjZjANCj4gNGQxYzFmMzIwOGQ2
MjZiZGU3NzUlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MNCj4gMCU3
QzYzNjczODk5NDQxMTM2OTQ5MSZhbXA7c2RhdGE9cGlMd2ZCYzBrek1oT25JNXV1YkhZSjl0YmUl
MkJSDQo+IEtFTktiWWlMcmtZMWMzMCUzRCZhbXA7cmVzZXJ2ZWQ9MA0KT0ssIExldCBtZSBhbmFs
eXplIGl0IGFnYWluLFRoYW5rcyENCg==
