Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6392FC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279CD218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XE8vuGwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfBRHG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:06:26 -0500
Received: from mail-eopbgr10051.outbound.protection.outlook.com ([40.107.1.51]:2319
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbfBRHGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 02:06:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KH1jJBeXAZjpBpa4LlxEMAyQx+yuPC9Iwym8DS2N154=;
 b=XE8vuGwHDjf7cenKn1pPr+2vq4ylVoDqb1xsxRMyeTP2eXEihJVC5aoygma8Fafah/MX7YSP2keuWe1RvtUpEbp2xz2hOtgmDDSONWNJWwoJsdOZIB85YNy17UYGi4cn45FFD3YiFupcBpScDwExhXLu6sqlR62e4w5iVlOsTS4=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3935.eurprd04.prod.outlook.com (52.134.17.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Mon, 18 Feb 2019 07:06:19 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649%3]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 07:06:19 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vicencb@gmail.com" <vicencb@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH] ASoC: simple-card: Fix refcount underflow
Thread-Topic: [PATCH] ASoC: simple-card: Fix refcount underflow
Thread-Index: AQHUxd+7Rfekf4ZvxUOM7mRbKeq/IaXkw6YAgAAFpwCAAFvYgA==
Date:   Mon, 18 Feb 2019 07:06:19 +0000
Message-ID: <b4bee8ff1307004ec9d1122f70ab2cb0d636ea4a.camel@nxp.com>
References: <20190216100927.10017-1-daniel.baluta@nxp.com>
         <87pnrp52jl.wl-kuninori.morimoto.gx@renesas.com>
         <87lg2d51lv.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lg2d51lv.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5925418-0fe9-4d92-419f-08d6956f9564
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3935;
x-ms-traffictypediagnostic: VI1PR0402MB3935:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0MDJNQjM5MzU7MjM6MDBIRXF2dDVzMi9kTnZLd3EwZExrbEZQ?=
 =?utf-8?B?SkVuMUNQcXcwcW92S2tJRkI5ZExUaU9QcUxkczhObGs4QmhzSGNFYTBPZUpu?=
 =?utf-8?B?ZkhWZEhvRFdubFZxRDBVcEpvRlQyL3BtOHBXVGdEQ2VWaEpXN0oyRTAwREJO?=
 =?utf-8?B?RDVvRGNOQ214TmZFVGhuL3BFSXNkVHN4aVp5aUNOS1ZEVEFZMk9EYk1NVjRs?=
 =?utf-8?B?V2tkVG1DVEVpTEFHaUpGTUlvYUw3dmQ1ZUNucmRNQlh5Z3Z0d2xmQXhzb0xB?=
 =?utf-8?B?V2VkT1gwRUpPbndkRXQzSW1xbUVrbVFyVUtPbmhQWmw1MXN3NGcxbWhkNk1H?=
 =?utf-8?B?TFBGN010TXgxT3JTYlJMUi9ZZDlTOWxTaFU3SkN3S2pWU3ZWU3hjbkE4RTlC?=
 =?utf-8?B?WG44SVkyZnRQY0xGTnkyTDBudnBHMmNWK3VkTnlHajhrbDNkWTBRYUJ6cGMx?=
 =?utf-8?B?bEd3M0VaNGdIbS9kZEhUdS9qT1d0aDN5T1MvUG5pbGFTK3JySlpmS3hTaUlw?=
 =?utf-8?B?R1Nqa25mT0V4cXdnMllwQmJ1NzhEcVY4MklSSit5SFpsWFBmK3FnMU1JV1pU?=
 =?utf-8?B?V2d2b0xaMG9DZSs4TzA4YVlOUTMySmN5RUE5V2ZUZ2RBNzJIQXhFRXdxLytu?=
 =?utf-8?B?WGNWQXFFNTFMNm5ZNUtTSHNDMGI1eVVEcHp1bnhlbCtrc2IrdnRLaUJ0V2cr?=
 =?utf-8?B?U0hmcDF4M2c0Y2RYZ2NlTWxaNlhMUEZOOHdGUmpsUEIzRVRuQkhCV0JzK0ov?=
 =?utf-8?B?c253ZlpiNEc2SFBDMkFyTjdsemRLV2pMT2dGRjVaSUxLT1RtY05RUDA0WVBO?=
 =?utf-8?B?TDc3V1pXM0QzMkRYTmdFY05KR2RaQlBNMUt1TXRSaTFxVDJ5MUlGNm9JUG9j?=
 =?utf-8?B?UFR5b0JGblZpTjd6a1VTT01qNkpqVlhLaGFhamNBZy9KMk5nZThqOXJGQ2hM?=
 =?utf-8?B?RnVZWTl6WmVwMEUySm1meXhSVUl2SXNTUm4xNjVKV3R6MjV1VVR4ai9hSzVl?=
 =?utf-8?B?dSt4S1U4T0ltK2M2YjBkN3NHbHBJRXdIS2ZkZVIvd05hZEZCUS9heTFWWWdn?=
 =?utf-8?B?RG0yUnJrQ3lTU2NaZDBZSDlNcWpSZ0R5MkFBSGtNT2hFWUdTeE1GUnZRMll3?=
 =?utf-8?B?MnVZdlBtWERLUTNHRlhnVHFYc3g2UnBYeUo4cE9QNVdaYnNaVkxTKzY2NWJG?=
 =?utf-8?B?WDFQNkZvbmFLTUVLUEFQdGEwSkFCSS80RzdFVUpsZHdBQmo5dlJERzdRMk9y?=
 =?utf-8?B?dEZ2WThEZ1VyYTRwZVE5T0JqYU4ySmkwb2ZKQWN4K2tqVFh5WGVVYS9xaE1n?=
 =?utf-8?B?MkNTRVh3TkNNa3dGUUczZEtBN0ptc2JobFR5cmlUM0JFTUcrUU1DM3RIcEJj?=
 =?utf-8?B?L1MyN0ZDOUdCRzZVbCtFY3ZTUHhPaTdFRXNZYy9hOEtTU1lVejRZWTB6NDF6?=
 =?utf-8?B?aktQQ3Q1QlkvTUt1TG8xNDc4NUYzaHNTQmVWOGZuTlZmbnpiaUxZWTRPbTRu?=
 =?utf-8?B?ZHp5RHRLMThxbC9DcDIwT0pYQWFMaXJGVWdBU0QzZm1aZUlOeGJicWplYi9W?=
 =?utf-8?B?QTR3N3l6Tm45dnZJemIvSUVMK2FwQ0NHSWtxN3lScFRJMktPbXdCdklaV1lJ?=
 =?utf-8?B?bmlZcmQ5VndqTmh3TVU0STlXUGJvT0tKaEdTRzBGOWFtbmdYa201NGpUSUJt?=
 =?utf-8?B?cWFBNlBKaklqNzhPajJPOUxIRDlGT2RTRXVkSHZHWWlBQldDZnkwcEJIazZF?=
 =?utf-8?B?K1M4RER2dGtmVVNSdzBhaS9MMTkyQ090cGlCUlJFcVVMTjFvQTBEb1hJVWtR?=
 =?utf-8?B?Z0pyY1RCRmk5LzlXZGZIQ1dFUWIzRS90MFJiL1FIVjBNVkVqVmhXUHN5UmQ0?=
 =?utf-8?Q?v3W3lhRBdt8Ic=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB393594503FD638F8B33B6E80F9630@VI1PR0402MB3935.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(366004)(376002)(199004)(189003)(51234002)(6246003)(316002)(256004)(4326008)(86362001)(44832011)(8676002)(11346002)(8936002)(71190400001)(71200400001)(2616005)(6116002)(25786009)(14444005)(81156014)(3846002)(81166006)(446003)(476003)(486006)(36756003)(2501003)(478600001)(2351001)(102836004)(305945005)(6512007)(186003)(97736004)(5640700003)(229853002)(53936002)(66066001)(68736007)(6506007)(76176011)(26005)(6916009)(2906002)(105586002)(99286004)(106356001)(966005)(14454004)(6436002)(5660300002)(45080400002)(6306002)(7736002)(6486002)(54906003)(118296001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3935;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lC9TIJ6UD3idYnUgdClQlEWjg1nSj2gefAlFVCksI9ybGqX+GZtm1fOzQObTcUb7SFx7KMM04ylh2vfUSOWoiasxcB11PWVTwdZI1lPnX1a+U9XoRDwgH/+QpwnA8VdusKSppZxPmp1ucIAtNjLiVDh8vHAZqcZyZNgOhQoYpVPklQTJwiE4eo594HsjbhPKI4iIDkIkUt9TAONkB42nwATpH6vRxXCI4BSA434f7kRb0BTU1k2NyV5VjJcK6a8dsuxcS5AdnuU7mLLlJfS4PMGvgzORQoC0x+HhoS1e/SEnz1HZZZ7V6yZPTLXd8K3IYFtf5csVvgIkdxs7BVlE0EovUEOH7s30fkaGq4jdUg2PLvtTuCFkXUyIb1oaqdD3TFIFX01gU/aEnrDTvKhKNrAusM7RKV2gvvEKrdqapS8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1E390C11BF887468F67CFAE6C2A9132@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5925418-0fe9-4d92-419f-08d6956f9564
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 07:06:19.8847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3935
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTAyLTE4IGF0IDEwOjM3ICswOTAwLCBLdW5pbm9yaSBNb3JpbW90byB3cm90
ZToNCj4gSGkgRGFuaWVsLCBNYXJrLCBhZ2Fpbg0KPiANCj4gPiA+IG9mX2dldF9jaGlsZF9ieV9u
YW1lKCkgdGFrZXMgYSByZWZlcmVuY2Ugd2UnbGwgbmVlZCB0byBkcm9wDQo+ID4gPiBsYXRlciBz
byB3aGVuIHdlIHN1YnN0aXR1dGUgaW4gdG9wIHdlIG5lZWQgdG8gdGFrZSBhIHJlZmVyZW5jZQ0K
PiA+ID4gYXMgd2VsbCBhcyBqdXN0IGFzc2lnbmluZy4NCj4gPiA+IA0KPiA+ID4gV2l0aG91dCB0
aGlzIHBhdGNoIHdlIGhpdCB0aGUgZm9sbG93aW5nIGVycm9yOg0KPiA+ID4gDQo+ID4gPiBbICAg
IDEuMjQ2ODUyXSBPRjogRVJST1I6IEJhZCBvZl9ub2RlX3B1dCgpIG9uIC9zb3VuZC13bTg1MjQN
Cj4gPiA+IFsgICAgMS4yNjIyNjFdIEhhcmR3YXJlIG5hbWU6IE5YUCBpLk1YOE1RIEVWSyAoRFQp
DQo+ID4gPiBbICAgIDEuMjY2ODA3XSBXb3JrcXVldWU6IGV2ZW50cyBkZWZlcnJlZF9wcm9iZV93
b3JrX2Z1bmMNCj4gPiA+IFsgICAgMS4yNzE5NTBdIENhbGwgdHJhY2U6DQo+ID4gPiBbICAgIDEu
Mjc0NDA2XSAgZHVtcF9iYWNrdHJhY2UrMHgwLzB4MTU4DQo+ID4gPiBbICAgIDEuMjc4MDc0XSAg
c2hvd19zdGFjaysweDE0LzB4MjANCj4gPiA+IFsgICAgMS4yODEzOTZdICBkdW1wX3N0YWNrKzB4
YTgvMHhjYw0KPiA+ID4gWyAgICAxLjI4NDcxN10gIG9mX25vZGVfcmVsZWFzZSsweGIwLzB4YzgN
Cj4gPiA+IFsgICAgMS4yODg0NzRdICBrb2JqZWN0X3B1dCsweDc0LzB4ZjANCj4gPiA+IFsgICAg
MS4yOTE4NzldICBvZl9ub2RlX3B1dCsweDE0LzB4MjgNCj4gPiA+IFsgICAgMS4yOTUyODZdICBf
X29mX2dldF9uZXh0X2NoaWxkKzB4NDQvMHg3MA0KPiA+ID4gWyAgICAxLjI5OTM4N10gIG9mX2dl
dF9uZXh0X2NoaWxkKzB4M2MvMHg2MA0KPiA+ID4gWyAgICAxLjMwMzMxNV0gIHNpbXBsZV9mb3Jf
ZWFjaF9saW5rKzB4MWRjLzB4MjMwDQo+ID4gPiBbICAgIDEuMzA3Njc2XSAgc2ltcGxlX3Byb2Jl
KzB4ODAvMHg1NDANCj4gPiA+IFsgICAgMS4zMTEyNTZdICBwbGF0Zm9ybV9kcnZfcHJvYmUrMHg1
MC8weGEwDQo+ID4gPiANCj4gPiA+IFRoaXMgcGF0Y2ggaXMgYmFzZWQgb24gYW4gZWFybGllciB2
ZXJzaW9uIHBvc3RlZCBieSBLdW5pbm9yaQ0KPiA+ID4gTW9yaW1vdG8NCj4gPiA+IGFuZCBjb21t
aXQgbWVzc2FnZSBpbmNsdWRlcyBleHBsYW5hdGlvbnMgZnJvbSBNYXJrIEJyb3duLg0KPiA+ID4g
DQo+ID4gPiANCmh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29t
Lz91cmw9aHR0cHMlM0ElMkYlMkZwYXRjaHdvcmsua2VybmVsLm9yZyUyRnBhdGNoJTJGMTA4MTQy
NTUlMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2RhbmllbC5iYWx1dGElNDBueHAuY29tJTdDZWQxYjdh
ZGM2NmE1NDZjMWJiNDYwOGQ2OTU0MWFhZjglN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMw
MTYzNSU3QzAlN0MwJTdDNjM2ODYwNTA2NjE3OTgzMTc0JmFtcDtzZGF0YT1oVHN1ckRMZHRMQXRU
dzBhNXYlMkZyU3NsZVNhd0FQMnlpVlBsODclMkJIQ3pUSSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+
ID4gDQo+ID4gPiBSZXBvcnRlZC1ieTogVmljZW50ZSBCZXJnYXMgPHZpY2VuY2JAZ21haWwuY29t
Pg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAu
Y29tPg0KPiA+ID4gLS0tDQo+ID4gDQo+ID4gSSdtIG5vdCBzdXJlIHdoaWNoIG9uZSBpcyBjb3Jy
ZWN0IGluIHRoaXMgY2FzZQ0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEt1bmlub3JpIE1vcmlt
b3RvIDxrdW5pbm9yaS5tb3JpbW90by5neEByZW5lc2FzLmNvbT4NCj4gPiANCj4gPiBvcg0KPiA+
IA0KPiA+IEFja2VkLWJ5OiBLdW5pbm9yaSBNb3JpbW90byA8a3VuaW5vcmkubW9yaW1vdG8uZ3hA
cmVuZXNhcy5jb20+DQo+IA0KPiBBbmQgd2Ugd2FudCB0byBhZGQNCj4gDQo+IEZpeGVzOiBjb21t
aXQgZGEyMTUzNTRlYjU1YyAoIkFTb0M6IHNpbXBsZS1jYXJkOiBtZXJnZSBzaW1wbGUtc2N1LQ0K
PiBjYXJkIikNCj4gDQoNClRoYW5rcyEgSSB0aG91Z2h0IGFib3V0IGFkZGluZyB0aGlzIGJ1dCB0
aGUgY3VycmVudCBwYXRjaCB3aWxsIG5vdA0KY2xlYW5seSBhcHBseSBiZWNhdXNlIG9mOg0KDQoy
ZDAxYTg0NjA1YTU1YyAoIkFTb0M6IHNpbXBsZS1jYXJkOiByZWR1Y2UgbmFtaW5nIHByZWZpeCIp
DQoNCg0KDQo=
