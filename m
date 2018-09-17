Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0F2ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D150E214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OdfBD+5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D150E214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeIQNR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:17:57 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:47701
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726652AbeIQNR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDqZHBh9mL8vq9offUqL9WCzsjm2QM0cCGNLxW+GzjE=;
 b=OdfBD+5xI70WYw1HbFLZdXq0Ne9JpPuVn+crn6cS/qY2fCKHQq5/R7eap6jAoNEYAVU0llRjo1a5kXwYaIqDsfE4CH9dQvGLqIwUHnbrF2j59nH7Xw8fjUB5XygBVO6YT0BLQdKylYuyX+YsikfeJW9Dc0TT99J/4llachE/v6U=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4509.eurprd04.prod.outlook.com (20.177.54.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Mon, 17 Sep 2018 07:51:36 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::29f3:ce9:e7f4:6ee0]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::29f3:ce9:e7f4:6ee0%5]) with mapi id 15.20.1143.017; Mon, 17 Sep 2018
 07:51:36 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>, Vinod Koul <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>
Subject: RE: [PATCH v2 3/4] dmaengine: imx-sdma: implement channel termination
 via worker
Thread-Topic: [PATCH v2 3/4] dmaengine: imx-sdma: implement channel
 termination via worker
Thread-Index: AQHUTE1B9pm1TCdc00eRQryEFM/8DqT0FpeQ
Date:   Mon, 17 Sep 2018 07:51:36 +0000
Message-ID: <VI1PR04MB4543E64752FFE550250A7A09891E0@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <20180914170615.12659-1-l.stach@pengutronix.de>
 <20180914170615.12659-3-l.stach@pengutronix.de>
In-Reply-To: <20180914170615.12659-3-l.stach@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4509;6:YEIl7UCGR1OH80G/rLzAVImgN90u9g/iMOblqPyLw6SWO6Bvfqv5wQaZtLuH6e9o2EB9EqrkP8GeedZwYobM2iSatSVbl5sW1/OwQS+Emfb4++S+njl8EVN0hRh0jcOTg99a6Fx3skrkuEzd6WPKvHXl6yEML0kpKS12350vYgY/Bx1PcZ+6wOv4jKpdEhFEGwWHn4GyMYgYaVykfqetI8aIUuPGEsIGbVyzYu5WcjwKbG9A5jhZR78AR0nyYrh2MclgGVL7w36B9nRDEnVjjl74goL0iTHTOvqqhTilLag8uOTTh5jXmtX8P/e5yjXW9m1+RteCphP44YmMjtZZEHmpUmUMYalYm+YreXY8sNGVaYmI/SvGFpqU9YTgPfeHWBD7qXwJjTzh9iVsNY48imC+RfyGAiDQ2dWD9fn7U3Z6FBXcIkcyqmJYSAf58fZz9DtakKV3LN59q5Q0UNvCDQ==;5:/wb96sXCxDqyKgCxeg1c1zY+tuKsi6l66hPdGfASyIRLsbbxpwr1Fpi2noO2IBFZsdcYz8nsYwYmrl9HzgMf733YwH8fpuo3lPUfkCYCwi5nyOZOq2ASmSPHodSxnaMI09PX+EqMH8xWtV54qQfvzOPoQ92aZblWl+AgOsXSBpc=;7:vfRdTqDROP0yR5BTfcHznF1dGPbttEj0hgoj3bDElkw8wxmZCgUvkqMF/3G3OjE5FLb98QIAXiwAE3bYREYTx6bmSOOiG+qY0oDhHgMaoqGtP5Ga2Bl91iK6GFC97s8RExjsBvkJdMkGt3C6oj8IqkWNFeOy6M2Jyx5A/dlvVrusqoKZFTHTJEJ/pC4nfIrxbaT5ZLY1nFrk/p8Y243nZDI50tcMMMRSWpeqj1SisWjJgUSXVwr421vXEu1NnpVL
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8f5efcc4-8e18-483c-860d-08d61c7264f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4509;
x-ms-traffictypediagnostic: VI1PR04MB4509:
x-microsoft-antispam-prvs: <VI1PR04MB45096AEA99E5B2FE43C3A951891E0@VI1PR04MB4509.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:VI1PR04MB4509;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4509;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39860400002)(136003)(13464003)(199004)(189003)(106356001)(6436002)(8676002)(105586002)(3846002)(6116002)(446003)(6246003)(305945005)(74316002)(7736002)(14454004)(478600001)(33656002)(55016002)(53936002)(14444005)(256004)(66066001)(9686003)(6506007)(8936002)(2900100001)(186003)(81166006)(68736007)(81156014)(5660300001)(102836004)(53546011)(26005)(7696005)(4326008)(486006)(2906002)(229853002)(97736004)(25786009)(316002)(476003)(54906003)(110136005)(5250100002)(11346002)(86362001)(76176011)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4509;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pUJ7pE3tDJSzwW/AeLqrJxVzbaqgX/IkRSguQeRCV43rLH39RE9eUjuYQb+ClCcGahPSDBlm19f2JPkUA1Jlerib/lwaA3I2FPjfKTX/MWFLT+/xPC1GqKox8+oIAtD/2lBrwA90TAtWfUzvSnZ5Z0uTzEIMn8glibwd8xdjjjTCCQM+4sHnLb86fcuWxEffZrEzpyfMkICrXXeOEnILNZCgu+fGkEi/L/znGWYce96mUateEZVCGHZghl2Z8RyfvMtyNXYBdck1h4reeu+8qwjDp8GUm1XPuqTmgU9n4tbJz8o0IZuyLIhajLw4qe11j060WU5b7wQ9lMfpOpg3y6nOHau7bhrGX2kjhfPFxik=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5efcc4-8e18-483c-860d-08d61c7264f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 07:51:36.3702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAxOMTqOdTCMTXI1SAxOjA2DQo+IFRvOiBWaW5v
ZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPg0KPiBDYzogZG1hZW5naW5lQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgUm9iaW4gR29uZw0KPiA8eWliaW4uZ29u
Z0BueHAuY29tPjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGtlcm5lbEBw
ZW5ndXRyb25peC5kZTsgcGF0Y2h3b3JrLWxzdEBwZW5ndXRyb25peC5kZQ0KPiBTdWJqZWN0OiBb
UEFUQ0ggdjIgMy80XSBkbWFlbmdpbmU6IGlteC1zZG1hOiBpbXBsZW1lbnQgY2hhbm5lbCB0ZXJt
aW5hdGlvbg0KPiB2aWEgd29ya2VyDQo+IA0KPiBUaGUgZG1hZW5naW5lIGRvY3VtZW50YXRpb24g
c3RhdGVzIHRoYXQgZGV2aWNlX3Rlcm1pbmF0ZV9hbGwgbWF5IGJlDQo+IGFzeW5jaHJvbm91cyBh
bmQgbmVlZCBub3Qgd2FpdCBmb3IgdGhlIGFjdGl2ZSB0cmFuc2ZlcnMgaGF2ZSBzdG9wcGVkLg0K
PiANCj4gVGhpcyBhbGxvd3MgdXMgdG8gbW92ZSBtb3N0IG9mIHRoZSBmdW5jdGlvbmFsaXR5IGN1
cnJlbnRseSBpbXBsZW1lbnRlZCBpbiB0aGUNCj4gc2RtYSBjaGFubmVsIHRlcm1pbmF0aW9uIGZ1
bmN0aW9uIHRvIHJ1biBpbiBhIHdvcmtlciwgb3V0c2lkZSBvZiBhbnkgYXRvbWljDQo+IGNvbnRl
eHQuIE1vdmluZyB0aGlzIG91dCBvZiBhdG9taWMgY29udGV4dCBoYXMgdHdvDQo+IGJlbmVmaXRz
OiB3ZSBjYW4gbm93IHNsZWVwIHdoaWxlIHdhaXRpbmcgZm9yIHRoZSBjaGFubmVsIHRvIHRlcm1p
bmF0ZSwgaW5zdGVhZA0KPiBvZiBidXN5IHdhaXRpbmcgYW5kIHRoZSBmcmVlaW5nIG9mIHRoZSBk
bWEgZGVzY3JpcHRvcnMgaGFwcGVucyB3aXRoIElSUXMNCj4gZW5hYmxlZCwgZ2V0dGluZyByaWQg
b2YgYSB3YXJuaW5nIGluIHRoZSBkbWEgbWFwcGluZyBjb2RlLg0KPiANCj4gQXMgdGhlIHRlcm1p
bmF0aW9uIGlzIG5vdyBhc25jLCB3ZSBuZWVkIHRvIGltcGxlbWVudCB0aGUgZGV2aWNlX3N5bmNo
cm9uaXplDQo+IGRtYSBlbmdpbmUgZnVuY3Rpb24sIHdoaWNoIHNpbXBseSB3YWl0cyBmb3IgdGhl
IHdvcmtlciB0byBmaW5pc2ggaXRzIGV4ZWN1dGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEx1
Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0KPiAtLS0NCj4gdjI6IEtlZXAgdmNo
YW5fZ2V0X2FsbF9kZXNjcmlwdG9ycyBpbiB0aGUgdGVybWluYXRlX2FsbCBjYWxsLCBzbyB0aGUN
Cj4gICAgIHdvcmtlciBkb2Vzbid0IGNvcnJ1cHQgdGhlIG5leHQgdHJhbnNmZXIgaWYgdGhhdCdz
IGFscmVhZHkgaW4NCj4gICAgIHRoZSBzZXR1cCBwcm9jZXNzLg0KPiAtLS0NCj4gIGRyaXZlcnMv
ZG1hL2lteC1zZG1hLmMgfCA0MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jIGIvZHJpdmVycy9k
bWEvaW14LXNkbWEuYyBpbmRleA0KPiA4ZDJmZWM4YjE2Y2MuLmRhNDFlOGZiZjE1MSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KPiArKysgYi9kcml2ZXJzL2RtYS9pbXgt
c2RtYS5jDQo+IEBAIC0zMiw2ICszMiw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVz
cy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L29mX2RtYS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3dvcmtxdWV1ZS5oPg0KPiANCj4gICNpbmNs
dWRlIDxhc20vaXJxLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGF0YS9kbWEtaW14
LXNkbWEuaD4NCj4gQEAgLTM3NSw2ICszNzYsOCBAQCBzdHJ1Y3Qgc2RtYV9jaGFubmVsIHsNCj4g
IAl1MzIJCQkJc2hwX2FkZHIsIHBlcl9hZGRyOw0KPiAgCWVudW0gZG1hX3N0YXR1cwkJCXN0YXR1
czsNCj4gIAlzdHJ1Y3QgaW14X2RtYV9kYXRhCQlkYXRhOw0KPiArCXN0cnVjdCB3b3JrX3N0cnVj
dAkJdGVybWluYXRlX3dvcmtlcjsNCj4gKwlzdHJ1Y3QgbGlzdF9oZWFkCQlkZWZlcnJlZF9kZXNj
X2xpc3Q7DQo+ICB9Ow0KPiANCj4gICNkZWZpbmUgSU1YX0RNQV9TR19MT09QCQlCSVQoMCkNCj4g
QEAgLTEwMjUsMzEgKzEwMjgsNDcgQEAgc3RhdGljIGludCBzZG1hX2Rpc2FibGVfY2hhbm5lbChz
dHJ1Y3QgZG1hX2NoYW4NCj4gKmNoYW4pDQo+IA0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiArc3Rh
dGljIHZvaWQgc2RtYV9jaGFubmVsX3Rlcm1pbmF0ZShzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmsp
IHsNCj4gKwlzdHJ1Y3Qgc2RtYV9jaGFubmVsICpzZG1hYyA9IGNvbnRhaW5lcl9vZih3b3JrLCBz
dHJ1Y3Qgc2RtYV9jaGFubmVsLA0KPiArCQkJCQkJICB0ZXJtaW5hdGVfd29ya2VyKTsNCj4gKw0K
PiArCS8qDQo+ICsJICogQWNjb3JkaW5nIHRvIE5YUCBSJkQgdGVhbSBhIGRlbGF5IG9mIG9uZSBC
RCBTRE1BIGNvc3QgdGltZQ0KPiArCSAqIChtYXhpbXVtIGlzIDFtcykgc2hvdWxkIGJlIGFkZGVk
IGFmdGVyIGRpc2FibGUgb2YgdGhlIGNoYW5uZWwNCj4gKwkgKiBiaXQsIHRvIGVuc3VyZSBTRE1B
IGNvcmUgaGFzIHJlYWxseSBiZWVuIHN0b3BwZWQgYWZ0ZXIgU0RNQQ0KPiArCSAqIGNsaWVudHMg
Y2FsbCAuZGV2aWNlX3Rlcm1pbmF0ZV9hbGwuDQo+ICsJICovDQo+ICsJdXNsZWVwX3JhbmdlKDEw
MDAsIDIwMDApOw0KPiArDQo+ICsJdmNoYW5fZG1hX2Rlc2NfZnJlZV9saXN0KCZzZG1hYy0+dmMs
ICZzZG1hYy0+ZGVmZXJyZWRfZGVzY19saXN0KTsNCj4gKwlJTklUX0xJU1RfSEVBRCgmc2RtYWMt
PmRlZmVycmVkX2Rlc2NfbGlzdCk7DQo+ICt9DQo+IA0KPiAgc3RhdGljIGludCBzZG1hX2Rpc2Fi
bGVfY2hhbm5lbF93aXRoX2RlbGF5KHN0cnVjdCBkbWFfY2hhbiAqY2hhbikgIHsNCj4gIAlzdHJ1
Y3Qgc2RtYV9jaGFubmVsICpzZG1hYyA9IHRvX3NkbWFfY2hhbihjaGFuKTsNCj4gIAl1bnNpZ25l
ZCBsb25nIGZsYWdzOw0KPiAtCUxJU1RfSEVBRChoZWFkKTsNCj4gDQo+ICAJc2RtYV9kaXNhYmxl
X2NoYW5uZWwoY2hhbik7DQo+ICsNCj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmc2RtYWMtPnZjLmxv
Y2ssIGZsYWdzKTsNCj4gLQl2Y2hhbl9nZXRfYWxsX2Rlc2NyaXB0b3JzKCZzZG1hYy0+dmMsICZo
ZWFkKTsNCj4gKwl2Y2hhbl9nZXRfYWxsX2Rlc2NyaXB0b3JzKCZzZG1hYy0+dmMsICZzZG1hYy0+
ZGVmZXJyZWRfZGVzY19saXN0KTsNCj4gIAlzZG1hYy0+ZGVzYyA9IE5VTEw7DQo+ICAJc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmc2RtYWMtPnZjLmxvY2ssIGZsYWdzKTsNCj4gLQl2Y2hhbl9kbWFf
ZGVzY19mcmVlX2xpc3QoJnNkbWFjLT52YywgJmhlYWQpOw0KPiANCj4gLQkvKg0KPiAtCSAqIEFj
Y29yZGluZyB0byBOWFAgUiZEIHRlYW0gYSBkZWxheSBvZiBvbmUgQkQgU0RNQSBjb3N0IHRpbWUN
Cj4gLQkgKiAobWF4aW11bSBpcyAxbXMpIHNob3VsZCBiZSBhZGRlZCBhZnRlciBkaXNhYmxlIG9m
IHRoZSBjaGFubmVsDQo+IC0JICogYml0LCB0byBlbnN1cmUgU0RNQSBjb3JlIGhhcyByZWFsbHkg
YmVlbiBzdG9wcGVkIGFmdGVyIFNETUENCj4gLQkgKiBjbGllbnRzIGNhbGwgLmRldmljZV90ZXJt
aW5hdGVfYWxsLg0KPiAtCSAqLw0KPiAtCW1kZWxheSgxKTsNCj4gKwlzY2hlZHVsZV93b3JrKCZz
ZG1hYy0+dGVybWluYXRlX3dvcmtlcik7DQo+IA0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiANCj4g
K3N0YXRpYyB2b2lkIHNkbWFfY2hhbm5lbF9zeW5jaHJvbml6ZShzdHJ1Y3QgZG1hX2NoYW4gKmNo
YW4pIHsNCj4gKwlzdHJ1Y3Qgc2RtYV9jaGFubmVsICpzZG1hYyA9IHRvX3NkbWFfY2hhbihjaGFu
KTsNCj4gKw0KUGxlYXNlIGFkZCB0aGUgYmVsb3cgdG8gbWFrZSBzdXJlIGludGVybmFsIHZpcnQg
ZG1hIHRhc2tsZXQga2lsbGVkIHRvby4NCnRhc2tsZXRfa2lsbCgmc2RtYWMtPnZjLnRhc2spOw0K
PiArCWZsdXNoX3dvcmsoJnNkbWFjLT50ZXJtaW5hdGVfd29ya2VyKTsNCj4gK30NCj4gKw0KPiAg
c3RhdGljIHZvaWQgc2RtYV9zZXRfd2F0ZXJtYXJrbGV2ZWxfZm9yX3AycChzdHJ1Y3Qgc2RtYV9j
aGFubmVsICpzZG1hYykNCj4gew0KPiAgCXN0cnVjdCBzZG1hX2VuZ2luZSAqc2RtYSA9IHNkbWFj
LT5zZG1hOyBAQCAtMTk5Myw2ICsyMDEyLDggQEANCj4gc3RhdGljIGludCBzZG1hX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+IA0KPiAgCQlzZG1hYy0+Y2hhbm5lbCA9IGk7
DQo+ICAJCXNkbWFjLT52Yy5kZXNjX2ZyZWUgPSBzZG1hX2Rlc2NfZnJlZTsNCj4gKwkJSU5JVF9X
T1JLKCZzZG1hYy0+dGVybWluYXRlX3dvcmtlciwNCj4gc2RtYV9jaGFubmVsX3Rlcm1pbmF0ZSk7
DQo+ICsJCUlOSVRfTElTVF9IRUFEKCZzZG1hYy0+ZGVmZXJyZWRfZGVzY19saXN0KTsNCj4gIAkJ
LyoNCj4gIAkJICogQWRkIHRoZSBjaGFubmVsIHRvIHRoZSBETUFDIGxpc3QuIERvIG5vdCBhZGQg
Y2hhbm5lbCAwIHRob3VnaA0KPiAgCQkgKiBiZWNhdXNlIHdlIG5lZWQgaXQgaW50ZXJuYWxseSBp
biB0aGUgU0RNQSBkcml2ZXIuIFRoaXMgYWxzbyBtZWFucw0KPiBAQCAtMjA0NSw2ICsyMDY2LDcg
QEAgc3RhdGljIGludCBzZG1hX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYp
DQo+ICAJc2RtYS0+ZG1hX2RldmljZS5kZXZpY2VfcHJlcF9kbWFfY3ljbGljID0gc2RtYV9wcmVw
X2RtYV9jeWNsaWM7DQo+ICAJc2RtYS0+ZG1hX2RldmljZS5kZXZpY2VfY29uZmlnID0gc2RtYV9j
b25maWc7DQo+ICAJc2RtYS0+ZG1hX2RldmljZS5kZXZpY2VfdGVybWluYXRlX2FsbCA9DQo+IHNk
bWFfZGlzYWJsZV9jaGFubmVsX3dpdGhfZGVsYXk7DQo+ICsJc2RtYS0+ZG1hX2RldmljZS5kZXZp
Y2Vfc3luY2hyb25pemUgPSBzZG1hX2NoYW5uZWxfc3luY2hyb25pemU7DQo+ICAJc2RtYS0+ZG1h
X2RldmljZS5zcmNfYWRkcl93aWR0aHMgPSBTRE1BX0RNQV9CVVNXSURUSFM7DQo+ICAJc2RtYS0+
ZG1hX2RldmljZS5kc3RfYWRkcl93aWR0aHMgPSBTRE1BX0RNQV9CVVNXSURUSFM7DQo+ICAJc2Rt
YS0+ZG1hX2RldmljZS5kaXJlY3Rpb25zID0gU0RNQV9ETUFfRElSRUNUSU9OUzsNCj4gLS0NCj4g
Mi4xOS4wDQoNCg==
