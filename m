Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B64C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BDB21726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QQBYBi8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfBAGvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 01:51:42 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:41689 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBAGvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 01:51:42 -0500
X-IronPort-AV: E=Sophos;i="5.56,547,1539673200"; 
   d="scan'208";a="23292582"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 23:51:41 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 23:51:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZDgZU6+pucwKLRCr1vWx6iiX0mB7rOL75MR4MHzrqg=;
 b=QQBYBi8W7LLywjqD2mElWgJSBwXw5h80okEJbg6vyml25Dm3il8E4Btf496PbEySCRepnOXVB/Tcjm66/WsoHJmnrp9GyIvF/ecmK8E3pQ1owEY7SpypNF/ZwdcpuRX1NKcXhzPdh3u1R0pRSUHVfHBrxUitrD1HQUhTNZUxyYk=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1954.namprd11.prod.outlook.com (10.175.101.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Fri, 1 Feb 2019 06:51:39 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Fri, 1 Feb 2019
 06:51:39 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <bbrezillon@kernel.org>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 01/10] spi: atmel-quadspi: cache MR value to avoid a
 write access
Thread-Topic: [PATCH v2 01/10] spi: atmel-quadspi: cache MR value to avoid a
 write access
Thread-Index: AQHUuYAu+viSD5s94E+u9UEZBRyorqXJmJGAgADpjwA=
Date:   Fri, 1 Feb 2019 06:51:39 +0000
Message-ID: <a0f6dbf3-e9c3-6695-2b85-3907b3f679cd@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
 <20190131161515.21605-2-tudor.ambarus@microchip.com>
 <20190131175535.3f60ccff@bbrezillon>
In-Reply-To: <20190131175535.3f60ccff@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0302CA0019.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::29) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [188.25.201.46]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1954;6:9vp6s1ZJyxy3qz3RPeoqLmrV6Nu7TPXXsEUvofjhekqPKCX5nnXQm4bmR0SBU9XKy5BC0eLetcI0eaT3Rt5g16S6fkhBodgHteiQ0MZYgC715QsL0szcOIOKICsf1g+BK9Rmgiewb4lgd2gAi6KVY1OMfdaY48ee4kb5ypSTus6kOkvU+MefC9oft5n0l3FAxKnpgGL37Sx6fgHyiPSwrvoeDbDgVTvMNBkzlhqCsh5LyRQKzv8om6zQdKMok+sK7ponTaVSh85SlSSXBZsj61LmhH5MdPqz8rf7szDkDD9tyRdfbiS1q1Yv7JJYn56vPi6D0hhTLV7RA4AkLjJgtl8sdGPkW5x0NfRAyxEgD0GXexRk5NIynNbY/PcpB/BIhhtYQUNHbuNBfkl7hXiZeC2B5PFD3BKbGFGHbusLHQn0v0Mau42S7o0MC6uUmqErBIB1O+6/qehdprEtIi7G1w==;5:UEKe/SKYLPtpfIpQO6ljn0asMojXmKMkg/b8cAjTBFbVddWpDOSG3GFrqvGfSozVam33ojdrRVTTkib5/kBn3DuinaMSFXTv5R5qJZgFu/c5ckZw76BoMmigdgD1FrLteTFXIcQm6gy7TjnC3as0y0OSCho9TsZgvscFPZ/3pv9nYHvFqhclDXwiHTgsGq020l0NWDpMv7XLHsxaqrn99w==;7:M0nFZptSbK0Smd0PgqFGndj+m53C00+n3iYqIM05j2txS8wbz+8f4RRJEj3MhqHlawqxlaoYtzI37Nckr/zp0yLkwPBudTjIfkZZHxYs+78RdU4YDXE5irdq1s2YjFcMvEf24yySwPXNln/TdGaQfg==
x-ms-office365-filtering-correlation-id: cc9aa2de-ed2a-43cd-15b6-08d68811b70b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1954;
x-ms-traffictypediagnostic: BN6PR11MB1954:
x-microsoft-antispam-prvs: <BN6PR11MB19542852F4151F6B5F8A5971F0920@BN6PR11MB1954.namprd11.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(346002)(136003)(39860400002)(199004)(189003)(66066001)(72206003)(6436002)(68736007)(305945005)(478600001)(4326008)(97736004)(106356001)(105586002)(36756003)(6306002)(53936002)(76176011)(6512007)(81166006)(2906002)(8936002)(2616005)(446003)(81156014)(11346002)(476003)(486006)(53546011)(386003)(256004)(6506007)(14444005)(8676002)(14454004)(6246003)(7736002)(966005)(52116002)(186003)(26005)(229853002)(6486002)(7416002)(3846002)(6116002)(316002)(54906003)(86362001)(99286004)(71190400001)(71200400001)(31696002)(6916009)(31686004)(25786009)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1954;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vbsaHPQIta9CL4V+qG15iCdoZpIGJ7RhLMQ2CGsGGyMfhuQJ6bizZ0781MUzZqSGpaG2IjH668oQbtOjFpr2iaQbXrt6G7htLGzr6lP9eBAvHtBCTbEgPptEwl5a1Vxt526ZcZsrMoHFgXzNYQ+8IgPrAqz468xQ20sLbvF3u5/qWI0m2zieK89kLulNd+s6slhpdVge8BWsbWkoEBBYYMVeUlatpnw/y5XuLvU7P9KLCB2Ct9VJLceKxd3hte8/6LYTnTOvQUmpj4NwHleYhCboHZ361bStq4z2nD+x7hH8/wVLbCTfqbSP5/mqNNqub/cM7KEDUfgJBtw4d9nLa8ysFy1VSVgdsESGcuuHpOtSlLCx5oEy4rO8XYrrDTHMUw4m4OGiluynjnVkohNuuLjkjO7YLuxgegbJn7CGGiU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD8D57D6CCC52140A936C75E8005BF0F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9aa2de-ed2a-43cd-15b6-08d68811b70b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 06:51:36.6225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1954
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAxLzMxLzIwMTkgMDY6NTUgUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24g
VGh1LCAzMSBKYW4gMjAxOSAxNjoxNToyOCArMDAwMA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2No
aXAuY29tPiB3cm90ZToNCj4gDQo+PiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVz
QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gQ2FjaGUgTVIgdmFsdWUgdG8gYXZvaWQgd3JpdGUgYWNj
ZXNzIHdoZW4gc2V0dGluZyB0aGUgY29udHJvbGxlcg0KPj4gaW4gU2VyaWFsIE1lbW9yeSBNb2Rl
IChTTU0pLiBTTU0gaXMgc2V0IGluIGV4ZWNfb3AoKSBhbmQgbm90IGF0DQo+PiBwcm9iZSB0aW1l
LCB0byBsZXQgcm9vbSBmb3IgZnV0dXJlIHJlZ3VsYXIgU1BJIHN1cHBvcnQuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0K
Pj4gLS0tDQo+PiB2MjogY2FjaGUgTVIgdmFsdWUgaW5zdGVhZCBvZiBtb3ZpbmcgdGhlIHdyaXRl
IGFjY2VzcyBhdCBwcm9iZQ0KPj4NCj4+ICBkcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMgfCA1
ICsrKystDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMgYi9kcml2
ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMNCj4+IGluZGV4IGRkYzcxMjQxMDgxMi4uZmUwNWFlZTVk
ODQ1IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jDQo+PiArKysg
Yi9kcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMNCj4+IEBAIC0xNTUsNiArMTU1LDcgQEAgc3Ry
dWN0IGF0bWVsX3FzcGkgew0KPj4gIAlzdHJ1Y3QgY2xrCQkqY2xrOw0KPj4gIAlzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlCSpwZGV2Ow0KPj4gIAl1MzIJCQlwZW5kaW5nOw0KPj4gKwl1MzIJCQltcjsN
Cj4+ICAJc3RydWN0IGNvbXBsZXRpb24JY21kX2NvbXBsZXRpb247DQo+PiAgfTsNCj4+ICANCj4+
IEBAIC0yMzgsNyArMjM5LDkgQEAgc3RhdGljIGludCBhdG1lbF9xc3BpX2V4ZWNfb3Aoc3RydWN0
IHNwaV9tZW0gKm1lbSwgY29uc3Qgc3RydWN0IHNwaV9tZW1fb3AgKm9wKQ0KPj4gIAlpY3IgPSBR
U1BJX0lDUl9JTlNUKG9wLT5jbWQub3Bjb2RlKTsNCj4+ICAJaWZyID0gUVNQSV9JRlJfSU5TVEVO
Ow0KPj4gIA0KPj4gLQlxc3BpX3dyaXRlbChhcSwgUVNQSV9NUiwgUVNQSV9NUl9TTU0pOw0KPj4g
KwkvKiBTZXQgdGhlIFFTUEkgY29udHJvbGxlciBpbiBTZXJpYWwgTWVtb3J5IE1vZGUgKi8NCj4+
ICsJaWYgKCEoYXEtPm1yICYgUVNQSV9NUl9TTU0pKQ0KPiANCj4gCWlmIChhcS0+bXIgIT0gUVNQ
SV9NUl9TTU0pDQoNCnRoZW4gSSBzaG91bGQgcHJvYmFibHkgcmVuYW1lIG1yIHRvIHNtbS4NCg0K
PiANCj4+ICsJCXFzcGlfd3JpdGVsKGFxLCBRU1BJX01SLCBRU1BJX01SX1NNTSk7DQo+IA0KPiBZ
b3UgbmVlZCB0byB1cGRhdGUgLT5tciBoZXJlLg0KDQpvZiBjb3Vyc2UsIHRoYW5rcyENCg0KPiAN
Cj4+ICANCj4+ICAJbW9kZSA9IGZpbmRfbW9kZShvcCk7DQo+PiAgCWlmIChtb2RlIDwgMCkNCj4g
DQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
PiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdA0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsDQo+IA0K
