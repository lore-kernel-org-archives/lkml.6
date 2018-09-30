Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DC6C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219C02075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aZAdBizG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219C02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeI3Qmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 12:42:42 -0400
Received: from mail-eopbgr30048.outbound.protection.outlook.com ([40.107.3.48]:5056
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727861AbeI3Qmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 12:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctlKg25KTsdMiNYP8b1f+JbJ5F/5hSPCqmg6swcZQqU=;
 b=aZAdBizGyZFyW55jd/epDkFxbK5l8OnIl0pS8ro9B8Cq+OW4UNGUd0ULhYqc8bTfdOYc2eJSmHxstzNpxpNVdK3LwwT1AZskMFckZ1wwIogNpElJX3X8Qk8LhJpApSsFSXdzjP2PlwHqKf09eJxpwvkeSyPAGb13ezR47xEs4CM=
Received: from AM0PR04MB4353.eurprd04.prod.outlook.com (52.134.125.146) by
 AM0PR04MB4164.eurprd04.prod.outlook.com (52.134.126.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Sun, 30 Sep 2018 10:10:15 +0000
Received: from AM0PR04MB4353.eurprd04.prod.outlook.com
 ([fe80::a5b0:6887:b5b8:671b]) by AM0PR04MB4353.eurprd04.prod.outlook.com
 ([fe80::a5b0:6887:b5b8:671b%2]) with mapi id 15.20.1185.024; Sun, 30 Sep 2018
 10:10:15 +0000
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
Thread-Index: AQHUWJ+Hbyza9P0UEkqh7dCBW11Sq6UImWeAgAAANpA=
Date:   Sun, 30 Sep 2018 10:10:14 +0000
Message-ID: <AM0PR04MB4353B48117292E511AC1E09F97EE0@AM0PR04MB4353.eurprd04.prod.outlook.com>
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
        <20180930092535.24544-2-chuanhua.han@nxp.com>
 <20180930120659.71b0e1e5@bbrezillon>
In-Reply-To: <20180930120659.71b0e1e5@bbrezillon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chuanhua.han@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4164;6:abOdVmJC2068TcVcwLB5wRs5nDHHpV7jpZ2f4dEULMtksOhWAq8BUez2NCwIEtKDcZXOXzAxov9pjztRK/msgV/lYrNZLYmjenElRpbJDYAW0EJlbyEz6HVgIWx6Lz2p4knjK71YtnNLMWsoANUprA34OCFscaag7g23k07kGg86J57wVjr6BVc3xPYEKC+FtIvipLK7qxhtlpizGsBzRIhxeiUrzevfc0n1NWbF3rE1NZLe5yraXoXX6jiKvCOrc6kDIEfVzVPbUqVuJqsDFb6qUje+bJQNMHhAcsFhztM0LT24KQAaXJlB8F0gU1vvheTc72MOUtkpKDdoGSVCX6mSK+TmrKNA+mo1edsa0q64NiEWXPnLvgAU4u/sFK00gW/s2rk1wNjyIUBrx4/DwTSSVDps9qxncI2tdPq4XqfRzyLsAkbnw50h8ZjYDDts+DpDrZ0rjAz6hrhwy+pXKw==;5:iSP+8KDd6nL5YDv9t7FY9f1LMyuYNIYz9LgukI922WwVbnPNCOrI01r6PCVAaKyEN6YCT3/e0KKh3dAUhLy8Ar/85AIVWK9jywrQHj/E9ryrxFZJf/fTpiW/rF5WGTeGDi9ElsGKAsAwePkxhJ1/jOYvJQlAuppY6EP4GrMW1Ds=;7:ME/miHFpCtD2OA2glCUjMn/qGvHArQxIvS2lwZV+Nl0ZfR8uCC+ZDtNkD3X/gRNMOCtoWCVdBuSB0LPS0eH7DVyl58wNClRhIeD0qvRbwOX0RIMw3ge2vyR0VFmZBuiMeMdPnPD1TWyDu9S0QfcIaoGhCouMN3uSzOwD39DBJ7hAC6ccjvJlqAif+tSoxL1jdd6bHF/peEFViwgjA+YmDW0OWp3KXJ2PInmxmwPU2BON/ArWvv+1IZbruRLlFqHu
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 498e66ce-d240-4aaf-3510-08d626bcea9e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4164;
x-ms-traffictypediagnostic: AM0PR04MB4164:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB4164FCE2A27BF4C2E971352597EE0@AM0PR04MB4164.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:AM0PR04MB4164;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4164;
x-forefront-prvs: 08118EFC2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(346002)(376002)(199004)(13464003)(189003)(76176011)(8936002)(99286004)(14454004)(3846002)(6116002)(316002)(106356001)(5250100002)(476003)(25786009)(53546011)(6506007)(33656002)(229853002)(34290500001)(97736004)(256004)(105586002)(54906003)(14444005)(7696005)(2906002)(446003)(478600001)(11346002)(71190400001)(71200400001)(53936002)(86362001)(4326008)(66066001)(55016002)(74316002)(305945005)(186003)(486006)(6916009)(9686003)(7736002)(2900100001)(6246003)(26005)(6436002)(8676002)(81156014)(68736007)(81166006)(44832011)(102836004)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4164;H:AM0PR04MB4353.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tovPT3S9A5GM0J1ayl6hajgx0TfBgqX/u73xCFTEXqPqxhI4doal7LhdYPVIo0zzOWYkBbbWaDkda6T+GToYe1iMbTfzQrARIbb2DKnfSBsGdFqYWcroJ3CERBuIefuUvzsLtVaYPDe32wfzr/JVWohYlY6GeFGu3Se7EpzugcW2OR7x9W+T6rHEiaGNrZFVuuxHmNBMYFvFjWvJK81tvu4qSFmG06BzGq/uSe5SbSImwCeyswchQpFFLVwmA8JswddDvy/YSmEC0zugyPy3aVdCEqR1DQfebOjFi5Kuol6Dyv45414/q8tZ5BFEkSNjSP9WmPZH85BiGA8IMjfQJEY4lc1gLcJO8pSgQPLninE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498e66ce-d240-4aaf-3510-08d626bcea9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2018 10:10:15.0041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXMgQnJlemlsbG9u
IDxib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+DQo+IFNlbnQ6IDIwMTjE6jnUwjMwyNUgMTg6
MDcNCj4gVG86IENodWFuaHVhIEhhbiA8Y2h1YW5odWEuaGFuQG54cC5jb20+DQo+IENjOiBicm9v
bmllQGtlcm5lbC5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGVoYUBkZWlmLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDIvNF0gc3BpOiBzcGktZnNsLWRzcGk6IEZpeCBkZWxldGUgdGhlIHByb2Nlc3Npbmcgb2YNCj4g
dW5kZWZpbmVkIGJpdG1hc2sgZm9yIHJ4ZGF0YQ0KPiANCj4gT24gU3VuLCAzMCBTZXAgMjAxOCAx
NzoyNTozMyArMDgwMA0KPiBDaHVhbmh1YSBIYW4gPGNodWFuaHVhLmhhbkBueHAuY29tPiB3cm90
ZToNCj4gDQo+ID4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgcHJvYmxlbSBvZiByeGRhdGEgYmVpbmcg
ZXF1YWwgdG8gMCBkdXJpbmcgdGhlDQo+ID4gWFNQSSBtb2RlIHRyYW5zZmVyIG9mIHRoZSBkc3Bp
IGNvbnRyb2xsZXIuDQo+ID4gSW4gWFNQSSBtb2RlLCBJZiBpdCBpcyBub3QgZGVsZXRlZCwgdGhl
IHZhbHVlIG9mIHJ4ZGF0YSB3aWxsIGJlIGVxdWFsDQo+ID4gdG8gMCwgYW5kIHRoZSBkYXRhIHJl
Y2VpdmVkIHdpbGwgbm90IGJlIHJlY2VpdmVkIGNvcnJlY3RseSwgY2F1c2luZw0KPiA+IHRoZSBy
ZWNlaXZpbmcgdHJhbnNmZXIgb2YgdGhlIHNwaSB0byBmYWlsLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogQ2h1YW5odWEgSGFuIDxjaHVhbmh1YS5oYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBD
aGFuZ2VzIGluIHYyOg0KPiA+ICAtVGhlIG9yaWdpbmFsIHBhdGNoIGlzIGRpdmlkZWQgaW50byBt
dWx0aXBsZSBwYXRjaGVzKHRoZSBvcmlnaW5hbA0KPiA+IHBhdGNoIHRoZW1lIGlzICJzcGk6IHNw
aS1mc2wtZHNwaTogRml4IHN1cHBvcnQgZm9yIFhTUEkgdHJhbnNwb3J0DQo+ID4gbW9kZSIpLG9u
ZSBvZiB3aGljaCBpcyBzZWdtZW50ZWQuDQo+ID4NCj4gPiAgZHJpdmVycy9zcGkvc3BpLWZzbC1k
c3BpLmMgfCAzIC0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktZnNsLWRzcGkuYyBiL2RyaXZlcnMvc3Bp
L3NwaS1mc2wtZHNwaS5jDQo+ID4gaW5kZXggMzA4MmU3MmU0ZjZjLi40ZGMxMDY0YmY0MDggMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zcGkvc3BpLWZzbC1kc3BpLmMNCj4gPiArKysgYi9kcml2
ZXJzL3NwaS9zcGktZnNsLWRzcGkuYw0KPiA+IEBAIC0yNDMsOSArMjQzLDYgQEAgc3RhdGljIHZv
aWQgZHNwaV9wdXNoX3J4KHN0cnVjdCBmc2xfZHNwaSAqZHNwaSwgdTMyDQo+IHJ4ZGF0YSkNCj4g
PiAgCWlmICghZHNwaS0+cngpDQo+ID4gIAkJcmV0dXJuOw0KPiA+DQo+ID4gLQkvKiBNYXNrIG9m
IHVuZGVmaW5lZCBiaXRzICovDQo+ID4gLQlyeGRhdGEgJj0gKDEgPDwgZHNwaS0+Yml0c19wZXJf
d29yZCkgLSAxOw0KPiA+IC0NCj4gDQo+IFdoeSBub3QNCkluIHhzcGkgbW9kZSwgdGhlIHZhbHVl
IG9mIHJ4ZGF0YSBhZnRlciB0aGUgc3RhdGVtZW50IGlzIHByb2Nlc3NlZCBpcyBlcXVhbCB0byAw
IG5vIG1hdHRlciB3aGF0IGRhdGEgaXMgcmVjZWl2ZWQuDQo+IA0KPiAJaWYgKGRzcGktPmJpdHNf
cGVyX3dvcmQpDQo+IAkJcnhkYXRhICY9ICgxIDw8IGRzcGktPmJpdHNfcGVyX3dvcmQpIC0gMTsN
Cj4gDQo+ID4gIAlpZiAoZHNwaS0+Ynl0ZXNfcGVyX3dvcmQgPT0gMSkNCj4gPiAgCQkqKHU4ICop
ZHNwaS0+cnggPSByeGRhdGE7DQo+ID4gIAllbHNlIGlmIChkc3BpLT5ieXRlc19wZXJfd29yZCA9
PSAyKQ0KDQo=
