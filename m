Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842EBC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E22F208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vGRJP0Ur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E22F208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbeGKFip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 01:38:45 -0400
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]:4544
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbeGKFip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 01:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISP1rkjjJdBxfta81VezsZrYx7o1gnMegDICO2C5ezQ=;
 b=vGRJP0UreK7F5UmhljVsRX4hnIXnk/MlAm3guAnaOQZNrCXUBLvMC17tIkbbqXfUMpeud4sOS+2wkHnuzAG3Z42pL5pDgw1qck6tYrNg8tczru+0x+plsXBIC3OjrLX4Ub77WBg0v8N4ZLs9m9snmFypO75WBDW2EEHPMA8DTG4=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3301.eurprd04.prod.outlook.com (10.170.216.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Wed, 11 Jul 2018 05:36:09 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd%4]) with mapi id 15.20.0930.022; Wed, 11 Jul 2018
 05:36:09 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Vinod <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1 2/4] dmaengine: imx-sdma: add check_bd_buswidth() to
 kill the dulicated code
Thread-Topic: [PATCH v1 2/4] dmaengine: imx-sdma: add check_bd_buswidth() to
 kill the dulicated code
Thread-Index: AQHUGCdqIOsnu+c+UEO5wW7nSBjgbqSIlbgAgADrxGA=
Date:   Wed, 11 Jul 2018 05:36:09 +0000
Message-ID: <DB6PR04MB3223A023C9D5CC467FC00214895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-3-git-send-email-yibin.gong@nxp.com>
 <20180710153104.GF3219@vkoul-mobl>
In-Reply-To: <20180710153104.GF3219@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3301;7:4ejy58O4elXSlN51nhqzDF7tkPl4vQxGi7GerV2L7Fjr9C/e/E3IEgAE1y4uxMBy05dRc4q9OIUh6ca71pkSAHgh4jGVaUhWcoFq8GH2c0PIHOsmbbKPTxLLwdR+C6Q+mbIdO3YIQPi4q5PW8u2zb2zyUPLcPf/2U6Tp08gQ3mcZYi771svMyEyn9yWQRZemu+lOeqidqBxX1KPrv25Hd8CAhQl7gLquEaAU/JLN/Yf0Z+9KCOrpaVXoBl9Iz6+f
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c3a5ba4d-f938-468b-bb04-08d5e6f0350c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3301;
x-ms-traffictypediagnostic: DB6PR04MB3301:
x-microsoft-antispam-prvs: <DB6PR04MB330184A0BD8414114BD760E0895A0@DB6PR04MB3301.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3301;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3301;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(346002)(366004)(13464003)(189003)(199004)(9686003)(66066001)(33656002)(6246003)(5250100002)(3846002)(6116002)(186003)(81166006)(53546011)(6506007)(8676002)(81156014)(476003)(486006)(8936002)(7696005)(76176011)(7736002)(74316002)(26005)(6916009)(102836004)(305945005)(5660300001)(2906002)(4326008)(2900100001)(446003)(256004)(25786009)(11346002)(106356001)(105586002)(478600001)(86362001)(97736004)(55016002)(54906003)(53936002)(14454004)(6436002)(99286004)(316002)(68736007)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3301;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GJTAd+EHRhpxAuSJ/4N9p+bhygt/SvzE0OxBP0CKbt8zJlLiVAfGGGstWQKNhgHFe5RrR95/fVmLh2M535/X/Scy1zMKNjYDBzYm7D+JFGoZ4g9vf0JuOR+b49XDXy3iQlLftRy5sJiblk1MY/Xz5C+ESa2Dbe5x5RtHknSXgreGa6i5sjxZom9eQVj2JdF3LSPU+frP/zX+KCxfLreeipedstncl/51ke1kXhu3rywbaDVP/xo7aS9+GTYDYDgL/SRDhAyEaVbj/tzL9O0aT61uxLA0rVHa7z1h0WN98lHt2dRhj8JPqQhWbm39wdSXNDXTx2PcDWrcyPt80wHtfMeM5oMlYClv7F/o0rH2WRI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a5ba4d-f938-468b-bb04-08d5e6f0350c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 05:36:09.9059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaW5vZCBbbWFpbHRvOnZrb3Vs
QGtlcm5lbC5vcmddDQo+IFNlbnQ6IDIwMTjE6jfUwjEwyNUgMjM6MzENCj4gVG86IFJvYmluIEdv
bmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCj4gQ2M6IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbTsg
c2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsgRmFiaW8gRXN0
ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPjsNCj4gbGludXhAYXJtbGludXgub3JnLnVrOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsgZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MSAyLzRdIGRtYWVuZ2luZTogaW14LXNkbWE6IGFkZCBjaGVja19iZF9idXN3aWR0
aCgpIHRvDQo+IGtpbGwgdGhlIGR1bGljYXRlZCBjb2RlDQo+IA0KPiBPbiAxMS0wNy0xOCwgMDA6
MjMsIFJvYmluIEdvbmcgd3JvdGU6DQo+ID4gQWRkIGNoZWNrX2JkX2J1c3dpZHRoKCkgdG8gbWlu
aW1pemUgdGhlIGNvZGUgc2l6ZS4NCj4gDQo+IHRoaXMgbG9va3MgbW9zdGx5IGZpbmUgYW5kIEkg
dGhpbmsgdGhpcyBzaG91bGQgYmUgZmlyc3QgcGF0Y2guLg0KU2luY2Ugbm8gbmVlZCB0byBjaGVj
ayBidXMgd2lkdGggaW4gbWVtY3B5IGNhc2UsIEknbGwgcmVtb3ZlIHRoaXMgcGF0Y2ggdG9vLg0K
PiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNv
bT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9kbWEvaW14LXNkbWEuYyB8IDY0DQo+ID4gKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDM1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5j
IGluZGV4DQo+ID4gMjdjY2FiZi4uZWQyMjY3ZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Rt
YS9pbXgtc2RtYS5jDQo+ID4gKysrIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KPiA+IEBAIC0x
MzI2LDYgKzEzMjYsMzMgQEAgc3RhdGljIHN0cnVjdCBzZG1hX2Rlc2MNCj4gKnNkbWFfdHJhbnNm
ZXJfaW5pdChzdHJ1Y3Qgc2RtYV9jaGFubmVsICpzZG1hYywNCj4gPiAgCXJldHVybiBOVUxMOw0K
PiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBjaGVja19iZF9idXN3aWR0aChzdHJ1Y3Qgc2Rt
YV9idWZmZXJfZGVzY3JpcHRvciAqYmQsDQo+ID4gKwkJCSAgICAgc3RydWN0IHNkbWFfY2hhbm5l
bCAqc2RtYWMsIGludCBjb3VudCwNCj4gPiArCQkJICAgICBkbWFfYWRkcl90IGRtYV9kc3QsIGRt
YV9hZGRyX3QgZG1hX3NyYykgew0KPiA+ICsJaW50IHJldCA9IDA7DQo+ID4gKw0KPiA+ICsJc3dp
dGNoIChzZG1hYy0+d29yZF9zaXplKSB7DQo+ID4gKwljYXNlIERNQV9TTEFWRV9CVVNXSURUSF80
X0JZVEVTOg0KPiA+ICsJCWJkLT5tb2RlLmNvbW1hbmQgPSAwOw0KPiA+ICsJCWlmICgoY291bnQg
fCBkbWFfZHN0IHwgZG1hX3NyYykgJiAzKQ0KPiA+ICsJCQlyZXQgPSAtRUlOVkFMOw0KPiA+ICsJ
CWJyZWFrOw0KPiANCj4gZW1wdHkgbGluZSBhZnRlciBlYWNoIGJyZWFrIHBsZWFzZQ0KPiANCj4g
PiArCWNhc2UgRE1BX1NMQVZFX0JVU1dJRFRIXzJfQllURVM6DQo+ID4gKwkJYmQtPm1vZGUuY29t
bWFuZCA9IDI7DQo+ID4gKwkJaWYgKChjb3VudCB8IGRtYV9kc3QgfCBkbWFfc3JjKSAmIDEpDQo+
ID4gKwkJCXJldCA9IC1FSU5WQUw7DQo+ID4gKwkJYnJlYWs7DQo+ID4gKwljYXNlIERNQV9TTEFW
RV9CVVNXSURUSF8xX0JZVEU6DQo+ID4gKwkJIGJkLT5tb2RlLmNvbW1hbmQgPSAxOw0KPiA+ICsJ
CWJyZWFrOw0KPiA+ICsJZGVmYXVsdDoNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0N
Cj4gPiArDQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiAtLQ0KPiB+Vmlub2QN
Cg==
