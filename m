Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F201C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A9D207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n1PEdYG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbfBEQ2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:28:51 -0500
Received: from mail-eopbgr50069.outbound.protection.outlook.com ([40.107.5.69]:8655
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727348AbfBEQ2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEkyVwUOELd63z2iCiDW4VSKbtoAMvMa9+6ZgDgxXT4=;
 b=n1PEdYG4HxTva30YWdA9OR2O4bRSVj+I7LQqkD7Pr6qTapA/JtPh8lrzGI1JtSrTKHG7GGXra/ZVuBW/VQvUpaIXGwe1v/qqkz4IVDd+caABA7SyZ55mkB/QYN0KzfoRjBYsgJnwy6cv1jvebJmdL5vna8+FoydFY0X2xDAXV2I=
Received: from AM6PR04MB4967.eurprd04.prod.outlook.com (20.177.33.210) by
 AM6PR04MB4437.eurprd04.prod.outlook.com (20.177.39.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Tue, 5 Feb 2019 16:28:37 +0000
Received: from AM6PR04MB4967.eurprd04.prod.outlook.com
 ([fe80::81f9:b29a:4a11:5e77]) by AM6PR04MB4967.eurprd04.prod.outlook.com
 ([fe80::81f9:b29a:4a11:5e77%3]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 16:28:37 +0000
From:   Han Xu <han.xu@nxp.com>
To:     Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: RE: [PATCH v2] mtd: rawnand: gpmi: fix MX28 bus master lockup problem
Thread-Topic: [PATCH v2] mtd: rawnand: gpmi: fix MX28 bus master lockup
 problem
Thread-Index: AQHUvWrnoQj7/g7Gn0yKuFDx/+Z5OKXRZK+Q
Date:   Tue, 5 Feb 2019 16:28:36 +0000
Message-ID: <AM6PR04MB49671F2AA5E38B5C69602ACD976E0@AM6PR04MB4967.eurprd04.prod.outlook.com>
References: <20190205155251.18733-1-martin.kepplinger@ginzinger.com>
In-Reply-To: <20190205155251.18733-1-martin.kepplinger@ginzinger.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=han.xu@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4437;6:Z5fqs4c31zeFhwwV+dGYDQtk4poT9HLdcIMXd+vCDmVGnj+uiwm7u9/X0USvnhjn/zPW0T6CR58CE/AKJaIV4TSSGbUkLQ0o03q+V85WdIrnInluh0PHV7sg1tauxCTVApHJ3lCLRtroGumxQ1eDit62164qbiBR+Z8OJQgAcZ5T6+RkfR9L8X7yGDY36KuHg6JyVY3SMkaZ0CA9OcNAZKKNSMGh3eIiCy+0e7Yp3UotpVwDRmQ7y02X73NMfreTFtRcYUzuNOiP7QoFSL1FKKyzJlCK1sSGC33jENJXR+K8ZtC8aP7Xkke2W9gLvsDZi/jd6ICwQd1wo4nngQredVZfIdh7hbPGEAdysZSKKSFhJh+bxem1Mk+RBUso6AVHjx2l2KR6vU6FqTHQT1ObBohBQB8iNwqYOm4biezraPESH4Tm0nOiC3hbmUi/SvVPzqEtcRpVEhHfkGd17eBtKA==;5:cva6WjI5aQ7fa6+SirDqf+jBGb0sVW1gHVwGzHwn+/eq24ybIJhlLMzatsrPReHT1XiDzUADRkiUMRy85efgSceo7EbdIvD/pzZzlOOGZhD01hAYDHff3Mc+GeLJcotUbr3KY9PjmpO31038PoGUtTAbEz0+/j7OdMCHeWNnbZH2ii871L4YhGvjI8tXkNCXS3T9W/njIjsq0qhqczXqDg==;7:6k/gxNlJiF66VxDogMu8+38Aj2cOReYuTTwY9Fk4lEKVyfNxC+klTE070AMRThya3Tj+QTwho57eKVpLcHQ6q81SvCfR6jYPSHGpCVP4ZUqYAU2p19+D3FyM44+fmYWrs1t+lwm4tJkKTWGFL6U2Eg==
x-ms-office365-filtering-correlation-id: 90538b60-5393-4184-2395-08d68b86fadc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4437;
x-ms-traffictypediagnostic: AM6PR04MB4437:
x-microsoft-antispam-prvs: <AM6PR04MB4437223522A0B16D27872236976E0@AM6PR04MB4437.eurprd04.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(13464003)(6116002)(316002)(26005)(14444005)(5024004)(3846002)(478600001)(305945005)(7736002)(68736007)(6436002)(7416002)(33656002)(561924002)(44832011)(186003)(229853002)(8676002)(25786009)(486006)(53936002)(66066001)(97736004)(476003)(71190400001)(76176011)(110136005)(54906003)(7696005)(2501003)(6246003)(74316002)(81166006)(81156014)(8936002)(9686003)(106356001)(2201001)(105586002)(6506007)(53546011)(14454004)(11346002)(446003)(99286004)(71200400001)(102836004)(86362001)(55016002)(2906002)(256004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4437;H:AM6PR04MB4967.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oUTi+SkeKUy5PnaR5gY1stP8s7n/m9Fac42F1Dp52+y5N5TyVpfpD3X/OZCyz+YlBAcFElHxy1v/lpxCS9Vtvp/ZBBr3Dr0TBKKn6mFmqpvVhkMn+UJEZd1U8JpItjgyYf8uNX3b3eahjGc94QtLQIb75tdfFdCIHGM1x8i+kJVYMxdrxwKm3f5RkekXAelSbeVkNBGblRK6EohlCBpr2KGNC2agyQc4kygdMK0gwP03XzZ1VoD/9IPVwpytCNEzXLfhZN+v7dlMjLtvbf5kkhCmN1q2q3ZtNXMBvGWlQOz785l+u0vXvov1oaBPVswd+GamFGksIXHiGxaz1GjTA61IO8KBYJq58PfhNYXXF00iVF6fAN8LWnHrYLGP49PiBNeH+wU/UAebkNXfQUcJ0ipX/SLBw69uYnfij62tzeM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90538b60-5393-4184-2395-08d68b86fadc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 16:28:36.9753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4437
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFydGluIEtlcHBsaW5n
ZXIgPG1hcnRpbi5rZXBwbGluZ2VyQGdpbnppbmdlci5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEZl
YnJ1YXJ5IDUsIDIwMTkgOTo1MyBBTQ0KPiBUbzogSGFuIFh1IDxoYW4ueHVAbnhwLmNvbT47IGJi
cmV6aWxsb25Aa2VybmVsLm9yZzsNCj4gbWlxdWVsLnJheW5hbEBib290bGluLmNvbTsgcmljaGFy
ZEBub2QuYXQ7IGR3bXcyQGluZnJhZGVhZC5vcmc7DQo+IGNvbXB1dGVyc2ZvcnBlYWNlQGdtYWls
LmNvbTsgbWFyZWsudmFzdXRAZ21haWwuY29tOyBsaW51eC0NCj4gbXRkQGxpc3RzLmluZnJhZGVh
ZC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmc7IE1hbmZyZWQgU2NobGFlZ2wNCj4gPG1hbmZyZWQuc2NobGFlZ2xAZ2luemluZ2Vy
LmNvbT47IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogW1BB
VENIIHYyXSBtdGQ6IHJhd25hbmQ6IGdwbWk6IGZpeCBNWDI4IGJ1cyBtYXN0ZXIgbG9ja3VwDQo+
IHByb2JsZW0NCj4gDQo+IERpc2FibGUgQkNIIHNvZnQgcmVzZXQgYWNjb3JkaW5nIHRvIE1YMjMg
ZXJyYXR1bSAjMjg0NyAoIkJDSCBzb2Z0DQo+IHJlc2V0IG1heSBjYXVzZSBidXMgbWFzdGVyIGxv
Y2sgdXAiKSBmb3IgTVgyOCB0b28uIEl0IGhhcyB0aGUgc2FtZQ0KPiBwcm9ibGVtLg0KPiANCj4g
T2JzZXJ2ZWQgcHJvYmxlbTogb25jZSBwZXIgMTAwLDAwMCsgTVgyOCByZWJvb3RzIE5BTkQgcmVh
ZCBmYWlsZWQgb24NCj4gRE1BIHRpbWVvdXQgZXJyb3JzOg0KPiBbICAgIDEuNzcwODIzXSBVQkk6
IGF0dGFjaGluZyBtdGQzIHRvIHViaTANCj4gWyAgICAyLjc2ODA4OF0gZ3BtaV9uYW5kOiBETUEg
dGltZW91dCwgbGFzdCBETUEgOjENCj4gWyAgICAzLjk1ODA4N10gZ3BtaV9uYW5kOiBCQ0ggdGlt
ZW91dCwgbGFzdCBETUEgOjENCj4gWyAgICA0LjE1NjAzM10gZ3BtaV9uYW5kOiBFcnJvciBpbiBF
Q0MtYmFzZWQgcmVhZDogLTExMA0KPiBbICAgIDQuMTYxMTM2XSBVQkkgd2FybmluZzogdWJpX2lv
X3JlYWQ6IGVycm9yIC0xMTAgd2hpbGUgcmVhZGluZyA2NA0KPiBieXRlcyBmcm9tIFBFQiAwOjAs
IHJlYWQgb25seSAwIGJ5dGVzLCByZXRyeQ0KPiBbICAgIDQuMTcxMjgzXSBzdGVwIDEgZXJyb3IN
Cj4gWyAgICA0LjE3Mzg0Nl0gZ3BtaV9uYW5kOiBDaGlwOiAwLCBFcnJvciAtMQ0KPiANCj4gV2l0
aG91dCBCQ0ggc29mdCByZXNldCB3ZSBzdWNjZXNzZnVsbHkgZXhlY3V0ZWQgMSwwMDAsMDAwIE1Y
MjggcmVib290cy4NCj4gDQo+IEkgaGF2ZSBhIHF1b3RlIGZyb20gTlhQIHJlZ2FyZGluZyB0aGlz
IHByb2JsZW0sIGZyb20gSnVseSAxOHRoIDIwMTY6DQo+IA0KPiAiQXMgdGhlIGkuTVgyMyBhbmQg
aS5NWDI4IGFyZSBvZiB0aGUgc2FtZSBnZW5lcmF0aW9uLCB0aGV5IHNoYXJlIG1hbnkNCj4gY2hh
cmFjdGVyaXN0aWNzLiBVbmZvcnR1bmF0ZWx5LCBhbHNvIHRoZSBlcnJhdGFzIG1heSBiZSBzaGFy
ZWQuDQo+IEluIGNhc2Ugb2YgdGhlIGRvY3VtZW50ZWQgZXJyYXRhcyBhbmQgdGhlIHdvcmthcm91
bmRzLCB5b3UgY2FuIGFsc28NCj4gYXBwbHkgdGhlIHdvcmthcm91bmQgc29sdXRpb24gb2Ygb25l
IGRldmljZSBvbiB0aGUgb3RoZXIgb25lLiBUaGlzIGhhdmUNCj4gYmVlbiByZXBvcnRlZCwgYnV0
IEnigJltIGFmcmFpZCB0aGF0IHRoZXJlIGFyZSBub3QgYW4gZXN0aW1hdGVkIGRhdGUgZm9yDQo+
IHVwZGF0aW5nIHRoZSBFcnJhdGEgZG9jdW1lbnRzLg0KPiBQbGVhc2UgYWNjZXB0IG91ciBhcG9s
b2dpZXMgZm9yIGFueSBpbmNvbnZlbmllbmNlcyB0aGlzIG1heSBjYXVzZS4iDQo+IA0KPiBGaXhl
czogNmYyYTZhNTI1NjBhICgibXRkOiBuYW5kOiBncG1pOiByZXNldCBCQ0ggZWFybGllciwgdG9v
LCB0byBhdm9pZA0KPiBOQU5EIHN0YXJ0dXAgcHJvYmxlbXMiKQ0KPiBDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBNYW5mcmVkIFNjaGxhZWdsIDxtYW5mcmVkLnNj
aGxhZWdsQGdpbnppbmdlci5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBLZXBwbGluZ2Vy
IDxtYXJ0aW4ua2VwcGxpbmdlckBnaW56aW5nZXIuY29tPg0KPiBSZXZpZXdlZC1ieTogTWlxdWVs
IFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEZhYmlv
IEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IEhhbiBYdSA8aGFuLnh1
QG54cC5jb20+DQoNCj4gLS0tDQo+IA0KPiANCj4gcmV2aXNpb24gaGlzdG9yeQ0KPiAtLS0tLS0t
LS0tLS0tLS0tDQo+IHYyOiBhZGQgRml4ZXMgdGFnLCBDYyBzdGFibGUgYW5kIGFkZCByZWNlbnQg
UmV2aWV3ZWQtYnkgdGFncw0KPiANCj4gDQo+ICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9ncG1pLW5h
bmQvZ3BtaS1saWIuYyB8IDEzICsrKysrKy0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
dGQvbmFuZC9yYXcvZ3BtaS1uYW5kL2dwbWktbGliLmMNCj4gYi9kcml2ZXJzL210ZC9uYW5kL3Jh
dy9ncG1pLW5hbmQvZ3BtaS1saWIuYw0KPiBpbmRleCBiZDRjZmFjNmI1YWEuLmE0NzY4ZGY1MDgz
ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvZ3BtaS1uYW5kL2dwbWktbGli
LmMNCj4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvZ3BtaS1uYW5kL2dwbWktbGliLmMNCj4g
QEAgLTE1NSw5ICsxNTUsMTAgQEAgaW50IGdwbWlfaW5pdChzdHJ1Y3QgZ3BtaV9uYW5kX2RhdGEg
KnRoaXMpDQo+IA0KPiAgCS8qDQo+ICAJICogUmVzZXQgQkNIIGhlcmUsIHRvby4gV2UgZ290IGZh
aWx1cmVzIG90aGVyd2lzZSA6KA0KPiAtCSAqIFNlZSBsYXRlciBCQ0ggcmVzZXQgZm9yIGV4cGxh
bmF0aW9uIG9mIE1YMjMgaGFuZGxpbmcNCj4gKwkgKiBTZWUgbGF0ZXIgQkNIIHJlc2V0IGZvciBl
eHBsYW5hdGlvbiBvZiBNWDIzIGFuZCBNWDI4IGhhbmRsaW5nDQo+ICAJICovDQo+IC0JcmV0ID0g
Z3BtaV9yZXNldF9ibG9jayhyLT5iY2hfcmVncywgR1BNSV9JU19NWDIzKHRoaXMpKTsNCj4gKwly
ZXQgPSBncG1pX3Jlc2V0X2Jsb2NrKHItPmJjaF9yZWdzLA0KPiArCQkJICAgICAgIEdQTUlfSVNf
TVgyMyh0aGlzKSB8fCBHUE1JX0lTX01YMjgodGhpcykpOw0KPiAgCWlmIChyZXQpDQo+ICAJCWdv
dG8gZXJyX291dDsNCj4gDQo+IEBAIC0yNjMsMTIgKzI2NCwxMCBAQCBpbnQgYmNoX3NldF9nZW9t
ZXRyeShzdHJ1Y3QgZ3BtaV9uYW5kX2RhdGENCj4gKnRoaXMpDQo+ICAJLyoNCj4gIAkqIER1ZSB0
byBlcnJhdHVtICMyODQ3IG9mIHRoZSBNWDIzLCB0aGUgQkNIIGNhbm5vdCBiZSBzb2Z0IHJlc2V0
IG9uDQo+IHRoaXMNCj4gIAkqIGNoaXAsIG90aGVyd2lzZSBpdCB3aWxsIGxvY2sgdXAuIFNvIHdl
IHNraXAgcmVzZXR0aW5nIEJDSCBvbiB0aGUNCj4gTVgyMy4NCj4gLQkqIE9uIHRoZSBvdGhlciBo
YW5kLCB0aGUgTVgyOCBuZWVkcyB0aGUgcmVzZXQsIGJlY2F1c2Ugb25lIGNhc2UNCj4gaGFzIGJl
ZW4NCj4gLQkqIHNlZW4gd2hlcmUgdGhlIEJDSCBwcm9kdWNlZCBFQ0MgZXJyb3JzIGNvbnN0YW50
bHkgYWZ0ZXIgMTAwMDANCj4gLQkqIGNvbnNlY3V0aXZlIHJlYm9vdHMuIFRoZSBsYXR0ZXIgY2Fz
ZSBoYXMgbm90IGJlZW4gc2VlbiBvbiB0aGUNCj4gTVgyMw0KPiAtCSogeWV0LCBzdGlsbCB3ZSBk
b24ndCBrbm93IGlmIGl0IGNvdWxkIGhhcHBlbiB0aGVyZSBhcyB3ZWxsLg0KPiArCSogYW5kIE1Y
MjguDQo+ICAJKi8NCj4gLQlyZXQgPSBncG1pX3Jlc2V0X2Jsb2NrKHItPmJjaF9yZWdzLCBHUE1J
X0lTX01YMjModGhpcykpOw0KPiArCXJldCA9IGdwbWlfcmVzZXRfYmxvY2soci0+YmNoX3JlZ3Ms
DQo+ICsJCQkgICAgICAgR1BNSV9JU19NWDIzKHRoaXMpIHx8IEdQTUlfSVNfTVgyOCh0aGlzKSk7
DQo+ICAJaWYgKHJldCkNCj4gIAkJZ290byBlcnJfb3V0Ow0KPiANCj4gLS0NCj4gMi4yMC4xDQoN
Cg==
