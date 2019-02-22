Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C57C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EFA2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eEaSYh5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfBVMzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:55:48 -0500
Received: from mail-eopbgr20083.outbound.protection.outlook.com ([40.107.2.83]:51790
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbfBVMzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gPp4lUAnE0sOQp1CA1ZM31buOCC28HSLxLZkDETCE8=;
 b=eEaSYh5JzEr8UXCSGYlqtXjId2EW7S1XAIovDg3y0FmfFI3v0E/UCultZAYE5jWVwFdtnj1wo8BUO70wsjpgDmepyDkS5wYoJ7R+QmmhJ7a7P9g9WozmcWUzvsaTXHJyN6p2dN2Ah1DKi5m9xSPJpffbN1F3z5SPkXhlmDUAcO4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4307.eurprd04.prod.outlook.com (52.134.92.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Fri, 22 Feb 2019 12:55:41 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1643.018; Fri, 22 Feb 2019
 12:55:41 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "labbott@redhat.com" <labbott@redhat.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: RE: [PATCH] mm/cma: cma_declare_contiguous: correct err handling
Thread-Topic: [PATCH] mm/cma: cma_declare_contiguous: correct err handling
Thread-Index: AQHUxGM3TWg8yAT7z0a/qrCp1B+TP6Xfwa8AgAedZYCAAA4lgIAEY/Hw
Date:   Fri, 22 Feb 2019 12:55:41 +0000
Message-ID: <AM0PR04MB448139C6E264579818E94CF6887F0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190214125704.6678-1-peng.fan@nxp.com>
 <20190214123824.fe95cc2e603f75382490bfb4@linux-foundation.org>
 <b78470e8-b204-4a7e-f9cc-eff9c609f480@suse.cz>
 <20190219174610.GA32749@rapoport-lnx>
In-Reply-To: <20190219174610.GA32749@rapoport-lnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afcfcf43-85ce-4b06-b806-08d698c50d0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4307;
x-ms-traffictypediagnostic: AM0PR04MB4307:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtBTTBQUjA0TUI0MzA3OzIzOk1ydVQwd0JuTHdSTXhDYlMwVzVtVXprWUpr?=
 =?gb2312?B?aFhmTHppdDFaWVdZaldCcnhvVHFieWJPMzlHUm9PQWVkekdPMXFFNnB6VWZI?=
 =?gb2312?B?Sm4wT0lkQUcxOVBPT2c1TlBoM3lkNStRZTZlaGZHVUtnSDBLaDA5ZzBTcnRp?=
 =?gb2312?B?ZDM2ekNDb0hYZEVZdUUrUHlIWDBDL1BpMW0vZ0FTckhZNUluZ1RPbHJQd1RU?=
 =?gb2312?B?WWxhb0FNakV1Q09oMURXQWZVT1NkL1g2Qld2dENLOVBkT01uN2o1bk4xaGtD?=
 =?gb2312?B?Z0JUd0ZQd1Z5cmR3Z3l1bTc1WTB2SmxXWGZUN21BWWJWcjk0dFJ5Y1ZabFJF?=
 =?gb2312?B?cjJlMkxWL2pKYllyK2hKMkk1Zml4K1J0NXlEUnE4eEs2b01nMUo1WGYzblJ1?=
 =?gb2312?B?dXZWbWI2eHFTdkVFditucEV1bUx5YW53emNWelZkQ0o1U2w1UlluNFdxWFEv?=
 =?gb2312?B?RFQvblBsRVhHd2RBWEpoYll2WHY3V1NsU3lSYUFwMXBReVU0eFJuOTJJZDV4?=
 =?gb2312?B?U0RXcFBNeEdTZlFkWEY1eU5tdEkyc0RKUDdxVXE4VTUxejRzTGVFVnRoR2ND?=
 =?gb2312?B?YzFLMkEyY0pFbnF5cUFkSENLWFRYazBzUE1acTY5ZTJpQUFpWkxNbEwwa2Va?=
 =?gb2312?B?NmZwMUxjS0tDYkM5VVJ2ZEYzeTdTN0c0QVUramZrTXArV3lUMVVBVnVqVHMr?=
 =?gb2312?B?djlERUF3ZUd2OUdJNUpKL05Zd0xuNURXV1NhVEREUlpPMm9NV21yM2o0VzNm?=
 =?gb2312?B?bjdxRHlENHJhbGtuNGRUYXRSRmlaVjZhRE9UZHhGSkxKcDhWQlVZTHU5eEZ6?=
 =?gb2312?B?blNmaXlEdzZTZkcvUklqQlJwTFJneXNhVlZ6MVp0SXpqV0dBRHg5cWs3MDNI?=
 =?gb2312?B?a3FmZnlGOWxKbjRnVy96ajFPZDhxWVM3UHpMQlhHTk9MK25Ybm1OU0hVaDNm?=
 =?gb2312?B?SStLa2RQbUtRSmdNZmNqMGtQSklkcVVtc1hjbFd5aVZTV21BNkRVTi9JM1Ex?=
 =?gb2312?B?VkpoOWpQTmFuZ3JrSnQ1VnJ0NC85MW93QTF1U3JUcFloQ2t5bFBKTjVIVlZB?=
 =?gb2312?B?NGU0VTV2UmVYTzZmQ2plejliK2Y4cXFHQVhxOE01T2p6S2FlTEF5OS83dGJQ?=
 =?gb2312?B?NVMxQkI5a1RHVnRtREk2NVUvS0lvQjVjQ2J3TUpDTE1SWCtCbTgrR1IrZDZi?=
 =?gb2312?B?SytDcDVhbDdZZFNETXBlTGo0YWlKbUZGTDJqbzk0bnBuNVhBVDAxWStmTVRi?=
 =?gb2312?B?azlpL2lRam9GTHhFcmNVeWpCaC9MZS9EWUdDYkdpTnpkYWFXQ1c4dDRKU0hx?=
 =?gb2312?B?bklTRWhacnlwbHppaHZBVlRnRHRkdUljcUFPR2V6eTdhS1F6aWZjQytvZ0Jx?=
 =?gb2312?B?YXUvR2IzdXR1SGlmV0V5QjBFN3FkM0I0NXNzQ3JQYXNxVGxXV3NIVUthSWgy?=
 =?gb2312?B?U21uR1hJNEZ5T0ZKUmRoNXBKZDRjMmV5eU1ZVTZaOExqb0w5T1BZN2V2Q3V3?=
 =?gb2312?B?V2h5dXhNVVB1U2lqaFp0NlNGZmhKdDcvd3QxNnhFMlpQb2FiY1RGVEFpclBa?=
 =?gb2312?B?bmtwUlJWbTd4S1FKUnR0YXIxNXZyRjFqNC9IOE02Nno5NkhlcVY1OG56ZmE4?=
 =?gb2312?B?OEQwWlA5UzEvS20yY294UUJZanRBbE1sT084RW1TSjJQZ2xIa1grZXY0S1FJ?=
 =?gb2312?B?UlpBU1F4UXQ4ei9COEpNaUc5SFM4MFY5RU1vTlZCM093UElNMjVoUnpERGE3?=
 =?gb2312?B?cndqOUJrVjdHd0ltS2FtS1p5RmRDWGtnS2x2VW05b3JWVk5EVTZWd2c1MGxS?=
 =?gb2312?Q?vI+OZyT9dsyQo?=
x-microsoft-antispam-prvs: <AM0PR04MB430723EE53F7D81E51F7AF01887F0@AM0PR04MB4307.eurprd04.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(346002)(376002)(199004)(189003)(13464003)(81156014)(486006)(86362001)(7416002)(81166006)(68736007)(44832011)(6246003)(53936002)(93886005)(99286004)(316002)(25786009)(4326008)(7696005)(105586002)(106356001)(256004)(14454004)(66066001)(74316002)(7736002)(476003)(8936002)(446003)(305945005)(11346002)(2906002)(97736004)(478600001)(8676002)(71200400001)(71190400001)(14444005)(6116002)(26005)(5660300002)(6346003)(102836004)(186003)(53546011)(6506007)(9686003)(55016002)(3846002)(76176011)(229853002)(110136005)(6436002)(54906003)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4307;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wpI9PIClwJ1IO4j3nV4F253funUrXweflRcrLBg7ae5ObYEoB255rrPlcdfQbMDm0esdE9rNIUU0IOgUWJwNKJ3xM4PvbV6Iy6E9/dMVEhQcKh9F3vvenmtWe9nHAFtOABoJZ+1+wMBmV7BMnvc1bJw3sNLLr7seM4jbbl2sP7KOpY1LdjLHZIcVT2/naG6AjB/jlSMHHRy3pE2H/cpEZSG5P1up0Nxz+oQH4FqFkRNmVn914vDjMRrFFQwuptdxGRp9HI/Mv3FsJbsZzco49RKvjs/ZVXyUUjAkW3snA+o+d2uRiyvPyA30QhmDGfTmkEHfkDPB/e19V8q8jX5bKQOuZA/RJytOFotbhmE0ZdNxfhPhwPqOqyeExarktVss3/uByIFaKKh9f/z3RKxxTAu5i88mR2z9OozfVc7fM1M=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afcfcf43-85ce-4b06-b806-08d698c50d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 12:55:41.3569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4307
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlrZSBSYXBvcG9ydCBb
bWFpbHRvOnJwcHRAbGludXguaWJtLmNvbV0NCj4gU2VudDogMjAxOcTqMtTCMjDI1SAxOjQ2DQo+
IFRvOiBWbGFzdGltaWwgQmFia2EgPHZiYWJrYUBzdXNlLmN6Pg0KPiBDYzogQW5kcmV3IE1vcnRv
biA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz47IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAu
Y29tPjsgbGFiYm90dEByZWRoYXQuY29tOyBtaG9ja29Ac3VzZS5jb207DQo+IGlhbWpvb25zb28u
a2ltQGxnZS5jb207IHJwcHRAbGludXgudm5ldC5pYm0uY29tOw0KPiBtLnN6eXByb3dza2lAc2Ft
c3VuZy5jb207IHJkdW5sYXBAaW5mcmFkZWFkLm9yZzsNCj4gYW5kcmV5a252bEBnb29nbGUuY29t
OyBsaW51eC1tbUBrdmFjay5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHZh
bi5mcmVlbml4QGdtYWlsLmNvbTsgQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmluYXNAYXJt
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbW0vY21hOiBjbWFfZGVjbGFyZV9jb250aWd1
b3VzOiBjb3JyZWN0IGVyciBoYW5kbGluZw0KPiANCj4gT24gVHVlLCBGZWIgMTksIDIwMTkgYXQg
MDU6NTU6MzNQTSArMDEwMCwgVmxhc3RpbWlsIEJhYmthIHdyb3RlOg0KPiA+IE9uIDIvMTQvMTkg
OTozOCBQTSwgQW5kcmV3IE1vcnRvbiB3cm90ZToNCj4gPiA+IE9uIFRodSwgMTQgRmViIDIwMTkg
MTI6NDU6NTEgKzAwMDAgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IHdyb3RlOg0KPiA+
ID4NCj4gPiA+PiBJbiBjYXNlIGNtYV9pbml0X3Jlc2VydmVkX21lbSBmYWlsZWQsIG5lZWQgdG8g
ZnJlZSB0aGUgbWVtYmxvY2sNCj4gPiA+PiBhbGxvY2F0ZWQgYnkgbWVtYmxvY2tfcmVzZXJ2ZSBv
ciBtZW1ibG9ja19hbGxvY19yYW5nZS4NCj4gPiA+Pg0KPiA+ID4+IC4uLg0KPiA+ID4+DQo+ID4g
Pj4gLS0tIGEvbW0vY21hLmMNCj4gPiA+PiArKysgYi9tbS9jbWEuYw0KPiA+ID4+IEBAIC0zNTMs
MTIgKzM1MywxNCBAQCBpbnQgX19pbml0DQo+IGNtYV9kZWNsYXJlX2NvbnRpZ3VvdXMocGh5c19h
ZGRyX3QNCj4gPiA+PiBiYXNlLA0KPiA+ID4+DQo+ID4gPj4gIAlyZXQgPSBjbWFfaW5pdF9yZXNl
cnZlZF9tZW0oYmFzZSwgc2l6ZSwgb3JkZXJfcGVyX2JpdCwgbmFtZSwNCj4gcmVzX2NtYSk7DQo+
ID4gPj4gIAlpZiAocmV0KQ0KPiA+ID4+IC0JCWdvdG8gZXJyOw0KPiA+ID4+ICsJCWdvdG8gZnJl
ZV9tZW07DQo+ID4gPj4NCj4gPiA+PiAgCXByX2luZm8oIlJlc2VydmVkICVsZCBNaUIgYXQgJXBh
XG4iLCAodW5zaWduZWQgbG9uZylzaXplIC8gU1pfMU0sDQo+ID4gPj4gIAkJJmJhc2UpOw0KPiA+
ID4+ICAJcmV0dXJuIDA7DQo+ID4gPj4NCj4gPiA+PiArZnJlZV9tZW06DQo+ID4gPj4gKwltZW1i
bG9ja19mcmVlKGJhc2UsIHNpemUpOw0KPiA+ID4+ICBlcnI6DQo+ID4gPj4gIAlwcl9lcnIoIkZh
aWxlZCB0byByZXNlcnZlICVsZCBNaUJcbiIsICh1bnNpZ25lZCBsb25nKXNpemUgLyBTWl8xTSk7
DQo+ID4gPj4gIAlyZXR1cm4gcmV0Ow0KPiA+ID4NCj4gPiA+IFRoaXMgZG9lc24ndCBsb29rIHJp
Z2h0IHRvIG1lLiAgSW4gdGhlIGBmaXhlZD09dHJ1ZScgY2FzZSB3ZSBkaWRuJ3QNCj4gPiA+IGFj
dHVhbGx5IGFsbG9jYXRlIGFueXRoaW5nIGFuZCBpbiB0aGUgYGZpeGVkPT1mYWxzZScgY2FzZSwg
dGhlDQo+ID4gPiBhbGxvY2F0ZWQgbWVtb3J5IGlzIGF0IGBhZGRyJywgbm90IGF0IGBiYXNlJy4N
Cj4gPg0KPiA+IEkgdGhpbmsgaXQncyBvayBhcyB0aGUgZml4ZWQ9PXRydWUgcGF0aCBoYXMgIm1l
bWJsb2NrX3Jlc2VydmUoKSIsIGJ1dA0KPiA+IGJldHRlciBsZWF2ZSB0aGlzIHRvIHRoZSBtZW1i
bG9jayBtYWludGFpbmVyIDopDQo+IA0KPiBBcyBQZW5nIEZhbiBub3RlZCBpbiB0aGUgb3RoZXIg
ZS1tYWlsLCBmaXhlZD09dHJ1ZSBoYXMgbWVtYmxvY2tfcmVzZXJ2ZSgpDQo+IGFuZCBmaXhlZD09
ZmFsc2UgcmVzZXRzIGJhc2UgPSBhZGRyLCBzbyB0aGlzIGlzIE9rLg0KPiANCj4gPiBUaGVyZSdz
IGFsc28gJ2ttZW1sZWFrX2lnbm9yZV9waHlzKGFkZHIpJyB3aGljaCBzaG91bGQgcHJvYmFibHkg
YmUNCj4gPiB1bmRvbmUgKG9yIG5vdCBjYWxsZWQgYXQgYWxsKSBpbiB0aGUgZmFpbHVyZSBjYXNl
LiBCdXQgaXQgc2VlbXMgdG8gYmUNCj4gPiBtaXNzaW5nIGZyb20gdGhlIGZpeGVkPT10cnVlIHBh
dGg/DQo+IA0KPiBXZWxsLCBtZW1ibG9jayBhbmQga21lbWxlYWsgaW50ZXJhY3Rpb24gZG9lcyBu
b3Qgc2VlbSB0byBoYXZlIGNsZWFyDQo+IHNlbWFudGljcyBhbnl3YXkuIG1lbWJsb2NrX2ZyZWUo
KSBjYWxscyBrbWVtbGVha19mcmVlX3BhcnRfcGh5cygpIHdoaWNoDQo+IGRvZXMgbm90IHNlZW0g
dG8gY2FyZSBhYm91dCBpZ25vcmVkIG9iamVjdHMuDQo+IEFzIGZvciB0aGUgZml4ZWQ9PXRydWUg
cGF0aCwgbWVtYmxvY2tfcmVzZXJ2ZSgpIGRvZXMgbm90IHJlZ2lzdGVyIHRoZSBhcmVhDQo+IHdp
dGgga21lbWxlYWssIHNvIHRoZXJlIHdvdWxkIGJlIG5vIG9iamVjdCB0byBmcmVlIGluIG1lbWJs
b2NrX2ZyZWUoKS4NCj4gQUZBSVUsIGttZW1sZWFrIHNpbXBseSBpZ25vcmVzIHRoaXMuDQoNCkkg
YWxzbyBnbyB0aHJvdWdoIHRoZSBtZW1ibG9ja19mcmVlIGZsb3csIGFuZCBhZ3JlZSB3aXRoIE1p
a2UNCm1lbWJsb2NrX2ZyZWUgDQogICAgLT4ga21lbWxlYWtfZnJlZV9wYXJ0X3BoeXMgDQogICAg
ICAgICAgLT4ga21lbWxlYWtfZnJlZV9wYXJ0DQogICAgICAgICAgICAgICAgIHwtPiBkZWxldGVf
b2JqZWN0X3BhcnQNCiAgICAgICAgICAgICAgICAgICAgICAgICB8LT4gb2JqZWN0ID0gZmluZF9h
bmRfcmVtb3ZlX29iamVjdChwdHIsIDEpOw0KDQptZW1ibG9ja19yZXNlcnZlIG5vdCByZWdpc3Rl
ciB0aGUgYXJlYSBpbiBrbWVtbGVhaywgc28gZmluZF9hbmRfcmVtb3ZlX29iamVjdA0Kd2lsbCBu
b3QgYmUgYWJsZSB0byBmaW5kIGEgdmFsaWQgYXJlYSBhbmQganVzdCByZXR1cm4uDQoNCldoYXQg
c2hvdWxkIEkgZG8gbmV4dCB3aXRoIHRoaXMgcGF0Y2g/DQoNClRoYW5rcywNClBlbmcuDQoNCj4g
DQo+IENhdGFsaW4sIGNhbiB5b3UgY29tbWVudCBwbGVhc2U/DQo+IA0KPiAtLQ0KPiBTaW5jZXJl
bHkgeW91cnMsDQo+IE1pa2UuDQoNCg==
