Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C353C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3327420B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AhNZdyAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfAaJJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:09:51 -0500
Received: from mail-eopbgr00060.outbound.protection.outlook.com ([40.107.0.60]:17920
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726852AbfAaJJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uc0Eh0yB7AvWacBjx1E16HBkdhyB15TY+W52CDF1eEU=;
 b=AhNZdyAS1s1pa3B4W/F5aLkHZDzsoJz07Vi42xsEIaarEYucSYD8Ry6eZdhzGkje40XPrxeDgAKiEVJnkjCbMsZ98582SvDKn8vJvUJDA61alIUdpSVcdeRnLvvjIy15ojvCWFyLsNfsGvwZMwuhyL268Ne5VCzQj/v1YTT93Ec=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5411.eurprd04.prod.outlook.com (20.178.114.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 09:09:44 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51%2]) with mapi id 15.20.1580.019; Thu, 31 Jan 2019
 09:09:44 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] can: flexcan: fix timeout when set small bitrate
Thread-Topic: [PATCH] can: flexcan: fix timeout when set small bitrate
Thread-Index: AQHUuTJgKWsp8N+NE0K42HojVTeBgaXI/GEAgAACyeCAABTWEA==
Date:   Thu, 31 Jan 2019 09:09:44 +0000
Message-ID: <AM0PR04MB4211359EA705CE196D13A5BB80910@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190131065619.7298-1-qiangqing.zhang@nxp.com>
 <1902c81b-86fa-469e-b495-c37dca744cb9@pengutronix.de>
 <DB7PR04MB46189FE45531AA8FD65D5327E6910@DB7PR04MB4618.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB46189FE45531AA8FD65D5327E6910@DB7PR04MB4618.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5411;6:q0WQK84N+gsb0cT7DWNIbA3k+SlRN5b5auOjU2sCXscRYPvuDbwSeRsfrZEfXxO3T7DYqTbauyXQb5Y61ZL0lRj+gWFyD40XgCHsLuk0XdxRKa3XhywBR4Ztzltb/c8yUUuzyHD+zGg9R1JrA0sUxLZ/lifT4LVDpvGqOAQAtjhryfT8wpODF379qN1JOgB4Apr/PvFZ/BC2E2TN9OCanwveHFMYAJG04P4m/df4PBbDVI7GzfHZ6325sHBdhzVXKPOUecvqx52+86qdZ4ZpRhlyFe1n6ficSfzEgsuuaIqhd6c2gwClHrIU9jmGCoF4gokoqZ5OqSg1VMaI2L1ugLQRlZQ9aNWhzadyDXD2jhUAkWnMBIdus8usHSlNygCwAYWowxXhrtd/dpxQ8q1JBzm5ae2qOtInbqulu/96SewWVlyFnuLA0AS1/s1kjqd0mRtsmBElK4jjZRozqKXZ2Q==;5:w5pp5ob6FZULEtqMsn5lTYoSo/HVZTtCKgK1mqT+N/7SYWaHRCL9BU1xNRGppBj7Cc9jLMdg18yyGlLyyaS+TDYVxxVv5q0S+FwzPESzPac3DdBHhenIa79aCcFCfDgJ2ncLzB4Aux0BAsWJ0tzdqfDkMj6Zl9YynurU51t+Axg8ZlKwBF6GSLPOfUGEP73hcGjlk+68Qd00mGNxVUIhOg==;7:ddFfgg8mgLS3hiDawcnrAQDZ0OSwhp1NJ/diJ8Q36Fyg1gMwmKDlzAgn1yYjZNEDwA8EdZRITMfMlBik5skpLEDJ55LRIOvJn/VOHRyI2LQwHH5Y0NE+RhsyVFXXIx3HXMDjQXTEsXSnskxgkHfUNA==
x-ms-office365-filtering-correlation-id: e400c8cf-780a-495b-4d52-08d6875bd77b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5411;
x-ms-traffictypediagnostic: AM0PR04MB5411:
x-microsoft-antispam-prvs: <AM0PR04MB54117AF374B01A180C10964380910@AM0PR04MB5411.eurprd04.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(366004)(346002)(376002)(199004)(45904002)(189003)(256004)(81166006)(14444005)(7696005)(6506007)(66066001)(26005)(102836004)(229853002)(81156014)(8936002)(8676002)(99286004)(76176011)(33656002)(305945005)(97736004)(68736007)(2501003)(7736002)(86362001)(2906002)(486006)(9686003)(446003)(71190400001)(6436002)(53936002)(11346002)(478600001)(6246003)(186003)(476003)(4326008)(106356001)(53386004)(6306002)(25786009)(105586002)(316002)(44832011)(14454004)(966005)(71200400001)(110136005)(55016002)(54906003)(3846002)(6116002)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5411;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ojaJKpBe4KFumP3x4pcY21Xlw3YFLnoVAXOxJGOx+HiLj/XTqOsagCWvqUtipAfuYWTNcBYDIJ/eGh83CbnGf1a0i7F9M1alW7fH/PN+0TalH0WG5lC5Jzlowc8+xUhM+QpZcvDZZm1LrfZwr3uwmHBkecMLoal2BE9jsLukpG/OA/UCZGYxKGTB4q7kJiSbonAQvyhOP7vpKUQ0ROZY+JAAcvUzoz2jxCoVdKeVWpafVgxENA3wadRXXTaGt5eBUc2Y8nahMR5yZSfn9E4iPghf56xYQGKOqmC0dgSY6ngen0oa123qt/SM7XH9pnu1aUTjEf1PgKE6Pekp8BmOp34T/PD9qiAnvtr32OL8dKrKjxWRYmwVB0sOOV6QXVEhUQX/9ceBLmMNw2MKXJY7RxXzRwhkkE49aNBQ08Wi5ZY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e400c8cf-780a-495b-4d52-08d6875bd77b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 09:09:44.4808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5411
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKb2FraW0gWmhhbmcNCj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMzEsIDIwMTkg
NDo0OSBQTQ0KWy4uLl0NCj4gPiA+IEN1cnJlbnQgd2UgY2FuIG1lZXQgdGltZW91dCBpc3N1ZSB3
aGVuIHNldHRpbmcgYSBzbWFsbCBiaXRyYXRlIGxpa2UNCj4gPiA+IDEwMDAwIGFzIGZvbGxvd3M6
DQo+ID4gPiByb290QGlteDZxZGxzb2xvOn4jIGlwIGxpbmsgc2V0IGNhbjAgdXAgdHlwZSBjYW4g
Yml0cmF0ZSAxMDAwMCBBDQo+ID4gPiBsaW5rIGNoYW5nZSByZXF1ZXN0IGZhaWxlZCB3aXRoIHNv
bWUgY2hhbmdlcyBjb21taXR0ZWQgYWxyZWFkeS4NCj4gPiA+IEludGVyZmFjZSBjYW4wIG1heSBo
YXZlIGJlZW4gbGVmdCB3aXRoIGFuIGluY29uc2lzdGVudA0KPiA+ID4gY29uZmlndXJhdGlvbiwg
cGxlYXNlIGNoZWNrLg0KPiA+ID4gUlRORVRMSU5LIGFuc3dlcnM6IENvbm5lY3Rpb24gdGltZWQg
b3V0DQo+ID4NCj4gPiBXaGljaCBTb0MgYXJlIHlvdSB1c2luZz8gV2hpY2ggY2xvY2sgcmF0ZSBo
YXMgdGhlIGZsZXhjYW4gSVAgY29yZT8NCj4gDQo+ICAgV2UgdGVzdGVkIG9uIGkuTVg2IHNlcmll
cyBib2FyZHMgYW5kIGFsbCBtZXQgdGhpcyBpc3N1ZS4gQW5kIGlwZyBjbG9jayByYXRlIGlzDQo+
IDY2TUhaLCBwZXIgY2xvY2sgcmF0ZSBpcyAzME1IWi4NCj4gDQo+ID4gPiBJdCBpcyBjYXVzZWQg
YnkgY2FsbGluZyBvZiBmbGV4Y2FuX2NoaXBfdW5mcmVlemUoKSB0aW1lb3V0Lg0KPiA+ID4NCj4g
PiA+IE9yaWdpbmFsbHkgdGhlIGNvZGUgaXMgdXNpbmcgdXNsZWVwX3JhbmdlKDEwLCAyMCkgZm9y
IHVuZnJlZXplDQo+ID4gPiBvcGVyYXRpb24sIGJ1dCB0aGUgcGF0Y2ggKDhiYWRkNjUgY2FuOiBm
bGV4Y2FuOiBhdm9pZCBjYWxsaW5nDQo+ID4gPiB1c2xlZXBfcmFuZ2UgZnJvbSBpbnRlcnJ1cHQg
Y29udGV4dCkgY2hhbmdlZCBpdCBpbnRvIHVkZWxheSgxMCkNCj4gPiA+IHdoaWNoIGlzIG9ubHkg
YSBoYWxmIGRlbGF5IG9mIGJlZm9yZSwgdGhlcmUncmUgYWxzbyBzb21lIG90aGVyIGRlbGF5DQo+
IGNoYW5nZXMuDQo+ID4gPg0KPiA+ID4gQWZ0ZXIgb25seSBjaGFuZ2VkIHVuZnJlZXplIGRlbGF5
IGJhY2sgdG8gdWRlbGF5KDIwKSwgdGhlIGlzc3VlIGlzIGdvbmUuDQo+ID4gPiBTbyBvdGhlciB0
aW1lb3V0IHZhbHVlcyBhcmUga2VwdCB0aGUgc2FtZSBhcyA4YmFkZDY1IGNoYW5nZWQuDQo+ID4N
Cj4gPiBDYW4geW91IGNoYW5nZSBGTEVYQ0FOX1RJTUVPVVRfVVMgaW5zdGVhZD8NCj4gDQo+ICAg
T2YgY291cnNlLCB3ZSBjYW4gY2hhbmdlIEZMRVhDQU5fVElNRU9VVF9VUyB0byAxMDAsIGJ1dCB0
aGlzIHdpbGwNCj4gZXh0ZW5kIHRoZSB0aW1lIG9mIGVuYWJsZS9kaXNhYmxlL3NvZnRyZXNldC4N
Cj4gV2hpY2ggbWV0aG9kIGRvIHlvdSB0aGluayBpcyBiZXR0ZXI/DQo+IA0KDQpUaGF0IHNlZW1z
IG5vdCBhIGJpZyBkZWFsIGZvciBhbiBlcnJvciBjYXNlLg0KU28gY2hhbmdlIEZMRVhDQU5fVElN
RU9VVF9VUyBzZWVtcyBsaWtlIGEgZ29vZCBzdWdnZXN0aW9uIHRvIG1lLg0KWW91IGNhbiBjb29r
IGEgcGF0Y2ggd2l0aCBjb21taXQgbWVzc2FnZSB1cGRhdGVkLiBObyBuZWVkIGtlZXAgbXkgYXV0
aG9yIG5hbWUNCmFzIGl0J3MgYSBkaWZmZXJlbnQgc29sdXRpb24uDQoNClJlZ2FyZHMNCkRvbmcg
QWlzaGVuZw0KDQo+IEJlc3QgUmVnYXJkcywNCj4gSm9ha2ltIFpoYW5nDQo+IA0KPiA+ID4gU2ln
bmVkLW9mZi1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQo+ID4g
PiAtLS0NCj4gPiA+ICBkcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jIHwgMiArLQ0KPiA+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jIGIvZHJpdmVycy9uZXQvY2Fu
L2ZsZXhjYW4uYw0KPiA+ID4gaW5kZXggMmJjYTg2N2JjZmFhLi4xZDNhOTA1M2JiZWIgMTAwNjQ0
DQo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jDQo+ID4gPiArKysgYi9kcml2
ZXJzL25ldC9jYW4vZmxleGNhbi5jDQo+ID4gPiBAQCAtNTMwLDcgKzUzMCw3IEBAIHN0YXRpYyBp
bnQgZmxleGNhbl9jaGlwX3VuZnJlZXplKHN0cnVjdA0KPiA+ID4gZmxleGNhbl9wcml2DQo+ID4g
KnByaXYpDQo+ID4gPiAgCXByaXYtPndyaXRlKHJlZywgJnJlZ3MtPm1jcik7DQo+ID4gPg0KPiA+
ID4gIAl3aGlsZSAodGltZW91dC0tICYmIChwcml2LT5yZWFkKCZyZWdzLT5tY3IpICYNCj4gRkxF
WENBTl9NQ1JfRlJaX0FDSykpDQo+ID4gPiAtCQl1ZGVsYXkoMTApOw0KPiA+ID4gKwkJdWRlbGF5
KDIwKTsNCj4gPiA+DQo+ID4gPiAgCWlmIChwcml2LT5yZWFkKCZyZWdzLT5tY3IpICYgRkxFWENB
Tl9NQ1JfRlJaX0FDSykNCj4gPiA+ICAJCXJldHVybiAtRVRJTUVET1VUOw0KPiA+ID4NCj4gPg0K
PiA+IE1hcmMNCj4gPg0KPiA+IC0tDQo+ID4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAg
ICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUgICAgICAgICAgIHwNCj4gPiBJbmR1c3RyaWFsIExpbnV4
IFNvbHV0aW9ucyAgICAgICAgfCBQaG9uZTogKzQ5LTIzMS0yODI2LTkyNCAgICAgfA0KPiA+IFZl
cnRyZXR1bmcgV2VzdC9Eb3J0bXVuZCAgICAgICAgICB8IEZheDogICArNDktNTEyMS0yMDY5MTct
NTU1NSB8DQo+ID4gQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgIHwgaHR0cDovL3d3
dy5wZW5ndXRyb25peC5kZSAgIHwNCg0K
