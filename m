Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32982C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07BC2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MMYHf1uj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07BC2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeH3NOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:14:18 -0400
Received: from mail-eopbgr60084.outbound.protection.outlook.com ([40.107.6.84]:36009
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727089AbeH3NOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGz/kbtLBEweEPCKYXLBcoXQgAV9sD1K1AIdfLpd4u8=;
 b=MMYHf1ujezuiq+E4vhAgOYaTrBNFW4DuqoQnWYPvKwg81hSAVp+EhKTZaJTlxmJTia3qYPNq0LSg5SZikpDJO1zq8FotvUVOx2IpQTg0Q5x6loJStJPQfNWKd/JjenQ46w5ArFlYU1ED0o/uDGGHryDTyxj30+/dFWxvDtA7oFU=
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com (52.135.167.33) by
 AM6PR04MB5078.eurprd04.prod.outlook.com (20.177.34.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Thu, 30 Aug 2018 09:13:03 +0000
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::e955:4d48:f0eb:3fe]) by AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::e955:4d48:f0eb:3fe%2]) with mapi id 15.20.1101.007; Thu, 30 Aug 2018
 09:13:03 +0000
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
Thread-Index: AQHUQD2O4kyVAisnBk6Un+WVuMRBpqTX+6+AgAAG3OA=
Date:   Thu, 30 Aug 2018 09:13:03 +0000
Message-ID: <AM6PR04MB4357DA161E8FCDB7B0B5C42697080@AM6PR04MB4357.eurprd04.prod.outlook.com>
References: <1535618604-21706-1-git-send-email-chuanhua.han@nxp.com>
 <20180830104729.5c7fefad@bbrezillon>
In-Reply-To: <20180830104729.5c7fefad@bbrezillon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chuanhua.han@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5078;6:7sXSxtdf2RKmhmK7F5Oi/C37ceXx0XYbpqey2Jo1Q3VjnIXZTYLW5JvaK+xXUNXQlc8H0UtMWxDbi4kp6ixo0jIUmTR4/LjJ+Hp5IAh3pvQv0At1RQB/zGQohm5q9dLoJxqzFE0IVc7r+mi80w4Zm44DtEm14NcG/cTVtjOIJ5ih+HNTGbL41/rCScEufdmwhd2o9PWe1vpfBJDPXkMrkHaJRNc/06uvlJp9T6v2MSyw6ueW/+XmypFMtkxWXJZqvoL46dgrS7ozMgVSyZ9fFfMFkcmRKdJb+W66yuK0A8x+Pqo6243lPLVghRrVJ4Nf6mAWYIKP4LLJtfWh9WqIK3YhJRAmyou/c6B6Vm+zw2xaKK1Gb5try0qG+Oihc8yDIzYqxDJaPAzXUzu8F0B6YIUUrf0P+AaiG4sSmhMfNHtVjS+gmT12V19mQpb9RPGeWOfDW+EVo5osNWH6cNxACQ==;5:jdZwGAaFAOpvVVrWRW+M9rz1u60WPlSJACsFTTXJuCAxVjPtUgNAa6cBuu0I/ZMZBIuxFYcnChM0RmmLrQxvSfk7Yzt1Vtm+JRdJ2690JZuqL4ChfChQdd6H4QZh3POsHsnjKsbDK8ft+JmIZJSCbTMWlm45zds0ZFi1/MQOi7g=;7:A6+lT3JaLalgJ+wlqBwaSR29/M7xwomgx/vFXUUnk1lDULFxDKEdglMyDjf4D3eb1MiW4U9/iBNw7Oh19/I9Z0SkWgW8VjlOr5oTTbMyuN/seze9I1glfVWOcm5Q6PAOQvEozT09tqmtXC4PoEM2dg2EOrBmNdu2zSE5o3uUi6B2HLNxj9ZDq4FWPq9hxabU6brhJR7IZheq14L6PiupAb2KPj08tRWFEDoQDdSbU2Ipz+DDULbLXbUX9EjKI0oT
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 30c924d4-6f22-4104-4620-08d60e58ca6f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5078;
x-ms-traffictypediagnostic: AM6PR04MB5078:
x-microsoft-antispam-prvs: <AM6PR04MB5078C04153DE0C1B5B13107297080@AM6PR04MB5078.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM6PR04MB5078;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5078;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(13464003)(189003)(199004)(9686003)(6436002)(68736007)(15650500001)(6246003)(2900100001)(14454004)(8936002)(478600001)(33656002)(2906002)(25786009)(53936002)(55016002)(6916009)(3846002)(5660300001)(7736002)(305945005)(66066001)(6116002)(5250100002)(86362001)(14444005)(256004)(74316002)(476003)(446003)(44832011)(229853002)(99286004)(53546011)(316002)(6506007)(8676002)(54906003)(102836004)(4326008)(106356001)(7696005)(26005)(186003)(81156014)(97736004)(76176011)(11346002)(486006)(105586002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5078;H:AM6PR04MB4357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MaVtyaIzD/rfexdCcG4BeZSp74IJUnDb4uAVdSBbbA3jSxuGcUvsmCU2rX4cms9lvrbMXb0WHi+Jp4Vhm4rq/RU3w4W0VQFy/cjMPDaEfVzvpBctKvB1rGHddWu1alYHZ0avol1kMp/02ozQ7nsMXo1eJAbTYdN7uV9Te9U2Y+nHPAFT5s5bf++MM8YQzFV4MW6avsMHn6uzC7iFGWszyDIGBnmondQ4xousckGF8RHzVj5HA6LLFBn9pzlsvSddlDSqzKV9wxu5mXnjHAOKTZI0JHFjIL2LoKJ8Qlns9kb3kSsUkH2Ye8RU1TjBiLztDyREjSr1+yaha+cl7Q2S/Uqf+xgoQ2fjhx4PQKIeW28=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c924d4-6f22-4104-4620-08d60e58ca6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 09:13:03.5236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXMgQnJlemlsbG9u
IDxib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+DQo+IFNlbnQ6IDIwMTjE6jjUwjMwyNUgMTY6
NDcNCj4gVG86IENodWFuaHVhIEhhbiA8Y2h1YW5odWEuaGFuQG54cC5jb20+DQo+IENjOiBicm9v
bmllQGtlcm5lbC5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2NV0gc3BpOiBzcGktbWVtOiBBZGp1c3Qgb3AgbGVuIGJhc2VkIG9uIG1lc3NhZ2Uv
dHJhbnNmZXINCj4gc2l6ZSBsaW1pdGF0aW9ucw0KPiANCj4gSGkgQ2h1YW5odWEsDQo+IA0KPiBP
biBUaHUsIDMwIEF1ZyAyMDE4IDE2OjQzOjI0ICswODAwDQo+IENodWFuaHVhIEhhbiA8Y2h1YW5o
dWEuaGFuQG54cC5jb20+IHdyb3RlOg0KPiANCj4gPiBXZSBuZWVkIHRoYXQgdG8gYWRqdXN0IHRo
ZSBsZW4gb2YgdGhlIDJuZCB0cmFuc2ZlciAoY2FsbGVkIGRhdGEgaW4NCj4gPiBzcGktbWVtKSBp
ZiBpdCdzIHRvbyBsb25nIHRvIGZpdCBpbiBhIFNQSSBtZXNzYWdlIG9yIFNQSSB0cmFuc2Zlci4N
Cj4gDQo+IFlvdSBhbHJlYWR5IHNlbnQgdGhpcyBlbWFpbCBhIGZldyBkYXlzIGJhY2suIFBsZWFz
ZSB3YWl0IGEgYml0IGJlZm9yZSBzZW5kaW5nIGl0DQo+IGFnYWluLiBBbmQgd2hlbiB5b3UgZG8g
c28gYW5kIG5vdGhpbmcgY2hhbmdlZCBpbiB0aGUgcGF0Y2ggcGxlYXNlIHVzZSB0aGUNCj4gW1BB
VENIIFJFU0VORCB2WF0gcHJlZml4IGFuZCBleHBsYWluIHdoeSB5b3UgcmVzZW5kIGl0Lg0KSSBo
YXZlIG1vZGlmaWVkIHRoZSBwYXRjaCBmb3IgdGhlIGNvbW1lbnQgeW91IG1lbnRpb25lZCBsYXN0
IHRpbWUuIERvIHlvdSBuZWVkIGFueSBvdGhlciBtb2RpZmljYXRpb26jvw0KPiANCj4gVGhhbmtz
LA0KPiANCj4gQm9yaXMNCj4gDQo+ID4NCj4gPiBGaXhlczogYzM2ZmYyNjZkYzgyICgic3BpOiBF
eHRlbmQgdGhlIGNvcmUgdG8gZWFzZSBpbnRlZ3JhdGlvbiBvZiBTUEkNCj4gPiBtZW1vcnkgY29u
dHJvbGxlcnMiKQ0KPiA+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBDaHVhbmh1YSBIYW4gPGNodWFuaHVhLmhhbkBueHAuY29tPg0KPiA+IFJldmlld2Vk
LWJ5OiBCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJyZXppbGxvbkBib290bGluLmNvbT4NCj4gPiAt
LS0NCj4gPiBDaGFuZ2VzIGluIHY1Og0KPiA+ICAgLUFkZCB0aGUgdmFsaWRhdGlvbiBjaGVjayBh
ZnRlciB0aGUgb3AtPmRhdGEubmJ5dGVzIGFzc2lnbm1lbnQNCj4gPiAgIC1Bc3NpZ24gdGhlICJs
ZW4iIHZhcmlhYmxlIGFmdGVyIGRlZmluaW5nIGl0DQo+ID4gICAtUmVtb3ZlIHRoZSBicmFja2V0
cyBvbiBib3RoIHNpZGVzIG9mICJvcHQtPiBkYXRhLm5ieXRlcyINCj4gPiBDaGFuZ2VzIGluIHY0
Og0KPiA+ICAgLVJlbmFtZSB2YXJpYWJsZSBuYW1lICJvcGNvZGVfYWRkcl9kdW1teV9zdW0iIHRv
ICJsZW4iDQo+ID4gICAtVGhlIGNvbXBhcmlzb24gb2YgInNwaV9tYXhfbWVzc2FnZV9zaXplKG1l
bS0+c3BpKSIgYW5kICJsZW4iIHdhcw0KPiByZW1vdmVkDQo+ID4gICAtQWRqdXN0IHRoZWlyIG9y
ZGVyIHdoZW4gY29tcGFyaW5nIHRoZSBzaXplcyBvZg0KPiAic3BpX21heF9tZXNzYWdlX3NpemUo
bWVtLT5zcGkpIiBhbmQgImxlbiINCj4gPiAgIC1DaGFuZ2luZyB0aGUgInVuc2lnbmVkIGxvbmci
IHR5cGUgaW4gdGhlIGNvZGUgdG8gInNpemVfdCINCj4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+ICAg
LVJlbmFtZSB2YXJpYWJsZSBuYW1lICJ2YWwiIHRvICJvcGNvZGVfYWRkcl9kdW1teV9zdW0iDQo+
ID4gICAtUGxhY2UgdGhlIGxlZ2l0aW1hY3kgb2YgdGhlIHRyYW5zZmVyIHNpemUoaS5lLiwNCj4g
PiAic3BpX21heF9tZXNzYWdlX3NpemUobWVtLT5zcGkpIiBhbmQNCj4gPiAib3Bjb2RlX2FkZHJf
ZHVtbXlfc3VtIikgaW50byAiaWYgKCEgY3RsciAtID4gbWVtX29wcyB8IHwhIGN0bHItPg0KPiBt
ZW1fb3BzLT5leGVjX29wKSB7Ig0KPiA+IHN0cnVjdHVyZSBhbmQgYWRkICJzcGlfbWF4X3RyYW5z
ZmVyX3NpemUobWVtLT5zcGkpIGFuZA0KPiBvcGNvZGVfYWRkcl9kdW1teV9zdW0iDQo+ID4gICAt
QWRqdXN0IHRoZSBmb3JtYXR0aW5nIGFsaWdubWVudCBvZiB0aGUgY29kZQ0KPiA+ICAgLSIodW5z
aWduZWQgbG9uZylvcC0+ZGF0YS5uYnl0ZXMiIHdhcyBtb2RpZmllZCB0byAiKHVuc2lnbmVkDQo+
IGxvbmcpKG9wLT5kYXRhLm5ieXRlcykiDQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiAgIC1QbGFj
ZSB0aGUgYWRqdXN0ZWQgdHJhbnNmZXIgYnl0ZXMgY29kZSBpbiBzcGlfbWVtX2FkanVzdF9vcF9z
aXplKCkNCj4gPiBhbmQgIGNoZWNrDQo+ID4gc3BpX21heF9tZXNzYWdlX3NpemUobWVtLT5zcGkp
IHZhbHVlIGJlZm9yZSBzdWJ0cmFjdGluZyBvcGNvZGUsIGFkZHIgYW5kDQo+IGR1bW15IGJ5dGVz
DQo+ID4gICAtQ2hhbmdlIHRoZSBjb2RlIGZyb20gZnNsLWVzcGkgY29udHJvbGxlciB0byBnZW5l
cmljIGNvZGUoVGhlDQo+ID4gYWRqdXN0bWVudCBvZiBzcGkgdHJhbnNtaXNzaW9uIGxlbmd0aCB3
YXMgb3JpZ2luYWxseSBtb2RpZmllZCBpbiB0aGUNCj4gPiAiZHJpdmVycy9zcGkvc3BpLWZzbC1l
c3BpLmMiIGZpbGUsIGFuZCBub3cgdGhlIGFkanVzdG1lbnQgb2YgdHJhbnNmZXINCj4gPiBsZW5n
dGggaXMgbWFkZSBpbiB0aGUgImRyaXZlcnMvc3BpL3NwaS1tZW0uYyIgZmlsZSkNCj4gPg0KPiA+
ICBkcml2ZXJzL3NwaS9zcGktbWVtLmMgfCAxNSArKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3NwaS9zcGktbWVtLmMgYi9kcml2ZXJzL3NwaS9zcGktbWVtLmMgaW5kZXgNCj4gPiBlNDM4NDJj
Li5lYjcyZGJhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1tZW0uYw0KPiA+ICsr
KyBiL2RyaXZlcnMvc3BpL3NwaS1tZW0uYw0KPiA+IEBAIC0zNDYsMTAgKzM0NiwyNSBAQCBFWFBP
UlRfU1lNQk9MX0dQTChzcGlfbWVtX2dldF9uYW1lKTsNCj4gPiAgaW50IHNwaV9tZW1fYWRqdXN0
X29wX3NpemUoc3RydWN0IHNwaV9tZW0gKm1lbSwgc3RydWN0IHNwaV9tZW1fb3ANCj4gPiAqb3Ap
ICB7DQo+ID4gIAlzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0bHIgPSBtZW0tPnNwaS0+Y29udHJv
bGxlcjsNCj4gPiArCXNpemVfdCBsZW47DQo+ID4gKw0KPiA+ICsJbGVuID0gc2l6ZW9mKG9wLT5j
bWQub3Bjb2RlKSArIG9wLT5hZGRyLm5ieXRlcyArIG9wLT5kdW1teS5uYnl0ZXM7DQo+ID4NCj4g
PiAgCWlmIChjdGxyLT5tZW1fb3BzICYmIGN0bHItPm1lbV9vcHMtPmFkanVzdF9vcF9zaXplKQ0K
PiA+ICAJCXJldHVybiBjdGxyLT5tZW1fb3BzLT5hZGp1c3Rfb3Bfc2l6ZShtZW0sIG9wKTsNCj4g
Pg0KPiA+ICsJaWYgKCFjdGxyLT5tZW1fb3BzIHx8ICFjdGxyLT5tZW1fb3BzLT5leGVjX29wKSB7
DQo+ID4gKwkJaWYgKGxlbiA+IHNwaV9tYXhfdHJhbnNmZXJfc2l6ZShtZW0tPnNwaSkpDQo+ID4g
KwkJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiArCQlvcC0+ZGF0YS5uYnl0ZXMgPSBtaW4z
KChzaXplX3Qpb3AtPmRhdGEubmJ5dGVzLA0KPiA+ICsJCQkJICAgICAgIHNwaV9tYXhfdHJhbnNm
ZXJfc2l6ZShtZW0tPnNwaSksDQo+ID4gKwkJCQkgICAgICAgc3BpX21heF9tZXNzYWdlX3NpemUo
bWVtLT5zcGkpIC0NCj4gPiArCQkJCSAgICAgICBsZW4pOw0KPiA+ICsJCWlmICghb3AtPmRhdGEu
bmJ5dGVzKQ0KPiA+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gPiArDQo+ID4gIAly
ZXR1cm4gMDsNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9MX0dQTChzcGlfbWVtX2FkanVzdF9v
cF9zaXplKTsNCg0K
