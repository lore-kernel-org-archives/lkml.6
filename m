Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73344C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 03:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B18420838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 03:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jCUyq0b/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B18420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbeLGDLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:11:39 -0500
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:40120
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeLGDLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 22:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYs0sOkqWvuJWiHlbal+v6/EWZjgKLv9oSscJGVj8KE=;
 b=jCUyq0b/gIJJcenmqcnmyuE++OL7Cf0mzJfeESlSP3ew8LQ/B9gOzDJUEF7id43uTjixAULn4eiRbNnw8VJvnaTOkdePm9QDj5cmOB0iUqM+GKemPx2LwA0BEcf3jo79U3n2tdttVme21eBX6jybI6SMSfjjlB/CqEYRwgUVg48=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3786.eurprd04.prod.outlook.com (52.134.71.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Fri, 7 Dec 2018 03:11:32 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 03:11:32 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V5 2/2] thermal: imx: save one condition block for normal
 case of nvmem initialization
Thread-Topic: [PATCH V5 2/2] thermal: imx: save one condition block for normal
 case of nvmem initialization
Thread-Index: AQHUgV3+A7hSKOLYR06aazyOdDuFN6VZ5lOAgBjL/rA=
Date:   Fri, 7 Dec 2018 03:11:31 +0000
Message-ID: <DB3PR0402MB391626344F9D278D797B91CBF5AA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1542779052-29536-1-git-send-email-Anson.Huang@nxp.com>
 <1542779052-29536-2-git-send-email-Anson.Huang@nxp.com>
 <b28efba1-e04a-7e33-126b-b92c7aa5e9a9@linaro.org>
In-Reply-To: <b28efba1-e04a-7e33-126b-b92c7aa5e9a9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3786;6:BHxwOOLpLQma0/bVdxKBag9MGMxTJWJi8tcbQT1bxf5/wl5PMLUXPULlYPz49JvbYmwXFrRi0zSRi9BS5C3NDX1LKwKaxhyshvu9Wj4PMIf0lnnIIkeDFk2ykSCNl+KyYXVx7Bhl1UPYKBAl8ntqlmMgg+Us/6cYPfqtC1LCN28uIPZkVd5dhmyiXGf4iJ4paiWnzAwLPfu8Wt9rD2Bqw88NzyknPfk5aEgSlajZeiYjc0156bhR4xwvyMtF34M2HVvEf+yDYsT2MPbKwMCbKii9/M/FcQntkpqldhBamZa+UUZO0yUOA7wHDGf8CmPtSaKEcT46MWAb0FCGyb+DhwFw/6rwD0WxDDiOElfh7JGE3HtuCLVlb861sgudQ7vcfFMNG8n89IPbqq4VqD2sNe4V6fdJUevfe6NsJrfUq93hs+UXbyKgJ9s2wB6v0JIcApeY37KT+l1yfyt0WFwl2g==;5:Oydi/nAC3SQjhvL2uuzo/gAbnZwCSaxrOngjXWRO7FJYN4CgRsFI+FeNeJPppZxtqdnM4WNpQokjCKpnU5Ig1vgK+u+pOtT+60BjpY5DyufRNYyQdGQ3I1N7Oa9yVbNqS/TyyaXVJcBRlfs4IMtF2pStLOaDdoqx/3nyMScj3Zo=;7:w9t91pr2D17hfc4WUdIU+Q4VTOnyZBR96NV/vVO2hrrwuS2wwHzeqKXvsgwDCHIkFoN3MikA2dUUWEcyNR7sG8XsBKx1f1MpfVMJXuGUJr6IpuYQzslAf/Ntw4tjCqTKQj1kzmTx81nil7XfC15flg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3844a613-8142-43a6-345a-08d65bf1b06a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3786;
x-ms-traffictypediagnostic: DB3PR0402MB3786:
x-microsoft-antispam-prvs: <DB3PR0402MB3786D5851EE864ED51651E7AF5AA0@DB3PR0402MB3786.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3786;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3786;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(39860400002)(376002)(346002)(366004)(136003)(13464003)(189003)(199004)(7696005)(6506007)(66066001)(11346002)(478600001)(2501003)(256004)(39060400002)(5660300001)(33656002)(4326008)(2201001)(86362001)(6116002)(316002)(486006)(110136005)(53546011)(3846002)(186003)(74316002)(102836004)(575784001)(2906002)(446003)(97736004)(44832011)(14454004)(81166006)(476003)(305945005)(99286004)(8676002)(71190400001)(9686003)(71200400001)(6246003)(6306002)(55016002)(76176011)(25786009)(8936002)(53936002)(6436002)(229853002)(68736007)(26005)(105586002)(106356001)(7736002)(81156014)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3786;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e6GkiERfj82eHNdvicytvV1Ud+KfbrW3BnhpkYNT7Fu1m7nQSKgt39L7QLiGb3scyabAMPo8407pa3bGLLKyYITuPq6jkalM7iwLP8vJ8+wchPTDIW6uoZyMMSRnhAGj/z/mVggsikfvtT436nNq7xDUBgySZkKHyK+suYguSYnPBM6i5JSqrTZctA2aiizLsw2AQwRdtvI/PQvs735zKaVWwFalZjlK2TDi8Ddrohn2/wkzIK2Hg4t3QXIDTlau3QamUI91zsgaNK9iE+CW88NIGNvAbiWsNuWJE5WoLhkXcmQWZc4t1ND9XcAiDlCWOnPmZSUSj8GE3zt0xkcOfy8IZFAaCGi4Gzqv8z/VUWo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3844a613-8142-43a6-345a-08d65bf1b06a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 03:11:31.6474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3786
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VudGxlIHBpbmcuLg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmllbCBMZXpjYW5vIFttYWlsdG86ZGFuaWVs
LmxlemNhbm9AbGluYXJvLm9yZ10NCj4gU2VudDogMjAxOOW5tDEx5pyIMjHml6UgMTY6MzENCj4g
VG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsgcnVpLnpoYW5nQGludGVsLmNv
bTsNCj4gZWR1YmV6dmFsQGdtYWlsLmNvbTsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOw0KPiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsNCj4g
bC5zdGFjaEBwZW5ndXRyb25peC5kZQ0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhw
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNSAyLzJdIHRoZXJtYWw6IGlteDogc2F2ZSBv
bmUgY29uZGl0aW9uIGJsb2NrIGZvciBub3JtYWwNCj4gY2FzZSBvZiBudm1lbSBpbml0aWFsaXph
dGlvbg0KPiANCj4gT24gMjEvMTEvMjAxOCAwNjo0OSwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4g
UHV0IHJldHVybiB2YWx1ZSBjaGVja3Mgb2YgY2FsbGluZyBpbXhfaW5pdF9mcm9tX252bWVtX2Nl
bGxzKCkgaW50bw0KPiA+IG9uZSBibG9jayB0byBzYXZlIG9uZSBjb25kaXRpb24gYmxvY2sgZm9y
IG5vcm1hbCBjYXNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29u
Lkh1YW5nQG54cC5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogRGFuaWVsIExlemNhbm8gPGRhbmll
bC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3RoZXJtYWwv
aW14X3RoZXJtYWwuYyB8IDUgKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJt
YWwvaW14X3RoZXJtYWwuYw0KPiA+IGIvZHJpdmVycy90aGVybWFsL2lteF90aGVybWFsLmMgaW5k
ZXggYzkyNDM5Ni4uYmI2NzU0YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvaW14
X3RoZXJtYWwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9pbXhfdGhlcm1hbC5jDQo+ID4g
QEAgLTc0Miw5ICs3NDIsMTAgQEAgc3RhdGljIGludCBpbXhfdGhlcm1hbF9wcm9iZShzdHJ1Y3QN
Cj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4NCj4gPiAgCWlmIChvZl9maW5kX3Byb3Bl
cnR5KHBkZXYtPmRldi5vZl9ub2RlLCAibnZtZW0tY2VsbHMiLCBOVUxMKSkgew0KPiA+ICAJCXJl
dCA9IGlteF9pbml0X2Zyb21fbnZtZW1fY2VsbHMocGRldik7DQo+ID4gLQkJaWYgKHJldCA9PSAt
RVBST0JFX0RFRkVSKQ0KPiA+IC0JCQlyZXR1cm4gcmV0Ow0KPiA+ICAJCWlmIChyZXQpIHsNCj4g
PiArCQkJaWYgKHJldCA9PSAtRVBST0JFX0RFRkVSKQ0KPiA+ICsJCQkJcmV0dXJuIHJldDsNCj4g
PiArDQo+ID4gIAkJCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byBpbml0IGZyb20gbnZt
ZW06ICVkXG4iLA0KPiA+ICAJCQkJcmV0KTsNCj4gPiAgCQkJcmV0dXJuIHJldDsNCj4gPg0KPiAN
Cj4gDQo+IC0tDQo+IA0KPiA8aHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3DQo+IC5saW5hcm8ub3JnJTJGJmFtcDtkYXRh
PTAyJTdDMDElN0NhbnNvbi5odWFuZyU0MG54cC5jb20lN0NmZDYwNDMNCj4gN2VlMzY0NGJlZjg1
OTMwOGQ2NGY4YmFiZmMlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3Qw0KPiAw
JTdDMCU3QzYzNjc4Mzg1ODY1NDk3Mzg2NSZhbXA7c2RhdGE9QmdzY0dBc0tZZW1Kc1B4T2VXbmhL
OW83DQo+IDJEbnlWJTJCNXAlMkIlMkYyRnVraGNwcU0lM0QmYW1wO3Jlc2VydmVkPTA+IExpbmFy
by5vcmcg4pSCIE9wZW4NCj4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29Dcw0KPiANCj4gRm9s
bG93IExpbmFybzoNCj4gPGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dw0KPiAuZmFjZWJvb2suY29tJTJGcGFnZXMlMkZM
aW5hcm8mYW1wO2RhdGE9MDIlN0MwMSU3Q2Fuc29uLmh1YW5nJTQwDQo+IG54cC5jb20lN0NmZDYw
NDM3ZWUzNjQ0YmVmODU5MzA4ZDY0ZjhiYWJmYyU3QzY4NmVhMWQzYmMyYjRjNmZhOTINCj4gY2Q5
OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2NzgzODU4NjU0OTczODY1JmFtcDtzZGF0YT02ekExMGxX
DQo+IHduV29BVUs3anFxdnNERE1NMlExM0FlZG1lU1BBQk1lUiUyQnhjJTNEJmFtcDtyZXNlcnZl
ZD0wPg0KPiBGYWNlYm9vayB8DQo+IDxodHRwczovL2VtZWEwMS5zYWZlbGlua3MucHJvdGVjdGlv
bi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ0d2l0dA0KPiBlci5jb20lMkYlMjMhJTJG
bGluYXJvb3JnJmFtcDtkYXRhPTAyJTdDMDElN0NhbnNvbi5odWFuZyU0MG54cC5jDQo+IG9tJTdD
ZmQ2MDQzN2VlMzY0NGJlZjg1OTMwOGQ2NGY4YmFiZmMlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5
OQ0KPiBjNWMzMDE2MzUlN0MwJTdDMCU3QzYzNjc4Mzg1ODY1NDk3Mzg2NSZhbXA7c2RhdGE9a3Vx
dUtFVXV2WFcNCj4gODhWMlFnUFFnWFlCZ3YySHR2MzdHS0RxYWgwVmVJSjglM0QmYW1wO3Jlc2Vy
dmVkPTA+IFR3aXR0ZXIgfA0KPiA8aHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3DQo+IC5saW5hcm8ub3JnJTJGbGluYXJv
LWJsb2clMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2Fuc29uLmh1YW5nJTQwbnhwLmMNCj4gb20lN0Nm
ZDYwNDM3ZWUzNjQ0YmVmODU5MzA4ZDY0ZjhiYWJmYyU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5
DQo+IGM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2NzgzODU4NjU0OTczODY1JmFtcDtzZGF0YT0wQWlZ
Y2oxSDF2YTFuDQo+IG1lZTJ0SFdXWW5tR2U1d3pGb2FvNEtaYmt4c0t6byUzRCZhbXA7cmVzZXJ2
ZWQ9MD4gQmxvZw0KDQo=
