Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28C4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4657020881
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ESvxjI1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4657020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeGKG7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 02:59:09 -0400
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]:40587
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726361AbeGKG7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 02:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smYBVTLUjmUxYj4WUHdikB7C3RzBjcbSzQkv+2uabn4=;
 b=ESvxjI1V0T2izWB/cxF1HAQ+VoehL0gHCuLKUrj/aoXy5bXDBxxmeykbCmDZII/AfSDmkx3s/PPKMNyQM4P6RLQiTLrH1cHesDuNzY51JNYzgwPBSlX+dSWVEo0vYhg7UWhTgxYTzUvtVZHu4QA1llG+h6qUFrZpmfoD5VKdg18=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3174.eurprd04.prod.outlook.com (10.170.214.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Wed, 11 Jul 2018 06:56:18 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd%4]) with mapi id 15.20.0930.022; Wed, 11 Jul 2018
 06:56:18 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy interface
Thread-Topic: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy interface
Thread-Index: AQHUGCdnmbVt1awXk0GOfzs3jCNhZKSJj1wAgAAEOQA=
Date:   Wed, 11 Jul 2018 06:56:18 +0000
Message-ID: <DB6PR04MB3223B22099D9C7A079608409895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-2-git-send-email-yibin.gong@nxp.com>
 <20180711062434.x6waumlh6wtfmvzy@pengutronix.de>
In-Reply-To: <20180711062434.x6waumlh6wtfmvzy@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3174;7:6mtM7m5Nt3JLA7HWU9I1icA++PuhuQ6nVCapCVzlGS5KcyFM2el7p6r90hgpUIOsHvJHfTh+neAvpiNQUGFrJa5j81QIgzKvBLoeHzi0Um9PV4MeLL+8rCD9qn7yFZjBOKr6MhSQn3MWk6p8x4nNVzwnFB+lG/qMxSWn30R7AXlX5AUpCcN5flj6fVQrN/UFCi1UQc5/dqOn6r/3159KF58xhMfzkgPM+mC7DRByNSAwvtsa6v2ssiRK3RfwVQ+H
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2564f53e-9cc0-45f3-ed6e-08d5e6fb672d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3174;
x-ms-traffictypediagnostic: DB6PR04MB3174:
x-microsoft-antispam-prvs: <DB6PR04MB3174A9EC00CF9E4C6D0B0F48895A0@DB6PR04MB3174.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(189930954265078)(185117386973197)(258649278758335)(45079756050767)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3174;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3174;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(189003)(199004)(13464003)(305945005)(102836004)(2906002)(53936002)(68736007)(6246003)(99286004)(446003)(476003)(11346002)(7696005)(7736002)(74316002)(256004)(2900100001)(966005)(33656002)(6506007)(486006)(3846002)(6116002)(76176011)(53546011)(14454004)(229853002)(8676002)(6916009)(186003)(66066001)(478600001)(97736004)(26005)(5250100002)(106356001)(105586002)(8936002)(316002)(81156014)(86362001)(54906003)(55016002)(6436002)(45080400002)(6306002)(575784001)(9686003)(81166006)(4326008)(25786009)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3174;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iq2efdPOvsuFb+sYZVZft+8jh4MmfgU8Eifw0d/66QDM+F7dIkIK9OGtXy5GvNlsGbEx1J2FKyt07atW7ZX7tYEw1lWnKBxPo7QJjeJ87JzH5Uycx8w+WQReqpN7BXC01jBB+GEQotYxopFF8FqCzWFk4XX5558VUq/PkQmFM+ufpilurKYXRczzejGF9UvlYNlydzjeXWXmwy+GbAeKHbS7981Fz3u059P76K9RfMs33SDV4N9d/tBRp+uTPG2Vms4fydO4iPICvl4IVJWu7+fOQdZro5aAQiV4BSwyOW82uy8fgBDhhB2gT/tpmXdzUrlzY4IQpx7wvPEZwI/82FxkMBBcfwKcBh1qbWvRsCE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2564f53e-9cc0-45f3-ed6e-08d5e6fb672d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 06:56:18.3585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNhc2NoYSBIYXVlciBbbWFp
bHRvOnMuaGF1ZXJAcGVuZ3V0cm9uaXguZGVdDQo+IFNlbnQ6IDIwMTjE6jfUwjExyNUgMTQ6MjUN
Cj4gVG86IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCj4gQ2M6IHZrb3VsQGtlcm5l
bC5vcmc7IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgRmFi
aW8NCj4gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPjsgbGludXhAYXJtbGludXgub3Jn
LnVrOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsNCj4gZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MSAxLzRdIGRtYWVuZ2luZTogaW14LXNkbWE6IGFkZCBtZW1jcHkg
aW50ZXJmYWNlDQo+IA0KPiBPbiBXZWQsIEp1bCAxMSwgMjAxOCBhdCAxMjoyMzoxMEFNICswODAw
LCBSb2JpbiBHb25nIHdyb3RlOg0KPiA+IEFkZCBNRU1DUFkgc3VwcG9ydCwgbWVhbndoaWxlLCBh
ZGQgU0RNQV9CRF9NQVhfQ05UIGluc3RlYWQgb2YNCj4gPiAnMHhmZmZmJy4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4g
PiArc3RhdGljIHN0cnVjdCBkbWFfYXN5bmNfdHhfZGVzY3JpcHRvciAqc2RtYV9wcmVwX21lbWNw
eSgNCj4gPiArCQlzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4sIGRtYV9hZGRyX3QgZG1hX2RzdCwNCj4g
PiArCQlkbWFfYWRkcl90IGRtYV9zcmMsIHNpemVfdCBsZW4sIHVuc2lnbmVkIGxvbmcgZmxhZ3Mp
IHsNCj4gPiArCXN0cnVjdCBzZG1hX2NoYW5uZWwgKnNkbWFjID0gdG9fc2RtYV9jaGFuKGNoYW4p
Ow0KPiA+ICsJc3RydWN0IHNkbWFfZW5naW5lICpzZG1hID0gc2RtYWMtPnNkbWE7DQo+ID4gKwlp
bnQgY2hhbm5lbCA9IHNkbWFjLT5jaGFubmVsOw0KPiA+ICsJc2l6ZV90IGNvdW50Ow0KPiA+ICsJ
aW50IGkgPSAwLCBwYXJhbTsNCj4gPiArCXN0cnVjdCBzZG1hX2J1ZmZlcl9kZXNjcmlwdG9yICpi
ZDsNCj4gPiArCXN0cnVjdCBzZG1hX2Rlc2MgKmRlc2M7DQo+ID4gKw0KPiA+ICsJaWYgKCFjaGFu
IHx8ICFsZW4pDQo+ID4gKwkJcmV0dXJuIE5VTEw7DQo+ID4gKw0KPiA+ICsJZGV2X2RiZyhzZG1h
LT5kZXYsICJtZW1jcHk6ICVwYWQtPiVwYWQsIGxlbj0lenUsIGNoYW5uZWw9JWQuXG4iLA0KPiA+
ICsJCSZkbWFfc3JjLCAmZG1hX2RzdCwgbGVuLCBjaGFubmVsKTsNCj4gPiArDQo+ID4gKwlkZXNj
ID0gc2RtYV90cmFuc2Zlcl9pbml0KHNkbWFjLCBETUFfTUVNX1RPX01FTSwgbGVuIC8NCj4gU0RN
QV9CRF9NQVhfQ05UDQo+ID4gKwkJCQkJKyAxKTsNCj4gPiArCWlmICghZGVzYykNCj4gPiArCQln
b3RvIGVycl9vdXQ7DQo+ID4gKw0KPiA+ICsJZG8gew0KPiA+ICsJCWNvdW50ID0gbWluX3Qoc2l6
ZV90LCBsZW4sIFNETUFfQkRfTUFYX0NOVCk7DQo+IA0KPiBXaGVuIGxlbiBpcyBiaWdnZXIgdGhh
biAweGZmZmYgeW91IGluaXRpYWxpemUgY291bnQgdG8gMHhmZmZmLi4uDQpJbiB0aGlzIGNhc2Us
IHRoZSBkYXRhIHdpbGwgYmUgc3BsaXQgaW50byBzZXZlcmFsIGJkcywgZm9yIGV4YW1wbGUsDQpJ
ZiB0aGUgdG90YWwgY291bnQgaXMgMHgxMDAwMCwgdHdvIGJkIHVzZWQgdGhlbi4gT25lIGlzIGZv
ciAweGZmZmYsDQpBbm90aGVyIGlzIGZvciB0aGUgbGFzdCAxDQo+IA0KPiA+ICsJCWJkID0gJmRl
c2MtPmJkW2ldOw0KPiA+ICsJCWJkLT5idWZmZXJfYWRkciA9IGRtYV9zcmM7DQo+ID4gKwkJYmQt
PmV4dF9idWZmZXJfYWRkciA9IGRtYV9kc3Q7DQo+ID4gKwkJYmQtPm1vZGUuY291bnQgPSBjb3Vu
dDsNCj4gPiArCQlkZXNjLT5jaG5fY291bnQgKz0gY291bnQ7DQo+ID4gKw0KPiA+ICsJCXN3aXRj
aCAoc2RtYWMtPndvcmRfc2l6ZSkgew0KPiA+ICsJCWNhc2UgRE1BX1NMQVZFX0JVU1dJRFRIXzRf
QllURVM6DQo+ID4gKwkJCWJkLT5tb2RlLmNvbW1hbmQgPSAwOw0KPiA+ICsJCQlpZiAoKGNvdW50
IHwgZG1hX3NyYyB8IGRtYV9kc3QpICYgMykNCj4gPiArCQkJCWdvdG8gZXJyX2JkX291dDsNCj4g
PiArCQkJYnJlYWs7DQo+IA0KPiAuLi5JbiB3aGljaCBjYXNlIHlvdSBiYWlsIG91dCBoZXJlIHdp
dGggYW4gZXJyb3IuDQpJbiBjYXNlIGRtYV9zcmMvZG1hX2RzdCBpcyBub3QgYWxpZ24gd2l0aCBi
dXMgd2lkdGguDQpCdXQgSSdsbCByZW1vdmUgc3VjaCBidXMgd2lkdGggaW4gdjIgYXMgVmlub2Qg
Y29tbWVudHMuDQo+IA0KPiBQbGVhc2UgbWFrZSBzdXJlIGJpZ2dlciB0cmFuc2ZlcnMgYXJlIHdv
cmtpbmcuDQo+IA0KPiA+ICsJCWNhc2UgRE1BX1NMQVZFX0JVU1dJRFRIXzJfQllURVM6DQo+ID4g
KwkJCWJkLT5tb2RlLmNvbW1hbmQgPSAyOw0KPiA+ICsJCQlpZiAoKGNvdW50IHwgZG1hX3NyYyB8
IGRtYV9kc3QpICYgMSkNCj4gPiArCQkJCWdvdG8gZXJyX2JkX291dDsNCj4gPiArCQkJYnJlYWs7
DQo+ID4gKwkJY2FzZSBETUFfU0xBVkVfQlVTV0lEVEhfMV9CWVRFOg0KPiA+ICsJCQliZC0+bW9k
ZS5jb21tYW5kID0gMTsNCj4gPiArCQkJYnJlYWs7DQo+ID4gKwkJZGVmYXVsdDoNCj4gPiArCQkJ
Z290byBlcnJfYmRfb3V0Ow0KPiA+ICsJCX0NCj4gPiArDQo+ID4gKwkJZG1hX3NyYyArPSBjb3Vu
dDsNCj4gPiArCQlkbWFfZHN0ICs9IGNvdW50Ow0KPiA+ICsJCWxlbiAtPSBjb3VudDsNCj4gPiAr
CQlpKys7DQo+ID4gKw0KPiA+ICsJCXBhcmFtID0gQkRfRE9ORSB8IEJEX0VYVEQgfCBCRF9DT05U
Ow0KPiANCj4gUHJvYmFibHkgYmV0dGVyIHJlYWRhYmxlIGlmIHlvdSBkcm9wIEJEX0NPTlQgaGVy
ZSBhbmQgZG8gYQ0KPiANCj4gCWlmIChsZW4pIHsNCj4gCQlwYXJhbSB8PSBCRF9DT05UOw0KPiAJ
fSBlbHNlICB7DQo+IAkJLi4uDQo+IAl9DQpPa2F5LiBXaWxsIGltcHJvdmUgaXQuDQo+IA0KPiBT
YXNjaGENCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgICAgICAg
ICAgICB8DQo+IHwNCj4gSW5kdXN0cmlhbCBMaW51eCBTb2x1dGlvbnMgICAgICAgICAgICAgICAg
IHwNCj4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwJTNBJTJGJTJGd3d3Lg0KPiBwZW5ndXRyb25peC5kZSUyRiZhbXA7ZGF0YT0wMiU3QzAx
JTdDeWliaW4uZ29uZyU0MG54cC5jb20lN0MwYWE5Ng0KPiAxMzU3MDJiNDQxNGRiZTcwOGQ1ZTZm
NzA5ZmUlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3Qw0KPiAwJTdDMCU3QzYz
NjY2ODg3MTA2MDEwMzU4NSZhbXA7c2RhdGE9azJoMFJJV2x1amFDczhpb2R1SnNuSkFmR1cwDQo+
IFpTN3V6bEhNTXRqcFElMkZ3NCUzRCZhbXA7cmVzZXJ2ZWQ9MCAgfA0KPiBQZWluZXIgU3RyLiA2
LTgsIDMxMTM3IEhpbGRlc2hlaW0sIEdlcm1hbnkgfCBQaG9uZTogKzQ5LTUxMjEtMjA2OTE3LTAg
ICAgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiAgICAgICAgICAgfCBGYXg6
DQo+ICs0OS01MTIxLTIwNjkxNy01NTU1IHwNCg==
