Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248F0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725F920663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="mlxTKiTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfBYOoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:44:01 -0500
Received: from mail-eopbgr150131.outbound.protection.outlook.com ([40.107.15.131]:25559
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbfBYOoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BY2y5iU85NowFGeHxjnDwIPAy6vqzjbYTbM+03ASnQk=;
 b=mlxTKiTD32KVx9MB3TqJGzQkVBBiMEqw7lwEnY+MXlVd8ArimVivOaDCpUrm4uzPPucpRmaedpkkNnPEYolIIHpntZYJBLMg7UnBMGRqMhS+g3k6E5C9EAByD65jChBqjBrLzvHTBZy6t8E8xvfuvC6u/Q1QuPeQjdAE9yZfaFo=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB5198.eurprd02.prod.outlook.com (20.178.80.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Mon, 25 Feb 2019 14:43:55 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1%5]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 14:43:55 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Pankaj Bansal <pankaj.bansal@nxp.com>, Leo Li <leoyang.li@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Topic: [PATCH v3 2/2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Index: AQHUzBrIcvg0ZIo5aUyXr9NSc4+4PqXwmNcA
Date:   Mon, 25 Feb 2019 14:43:54 +0000
Message-ID: <ea09336d-465f-aef1-ba7a-c80364a39f90@axentia.se>
References: <20190224135143.24770-1-pankaj.bansal@nxp.com>
 <20190224135143.24770-2-pankaj.bansal@nxp.com>
In-Reply-To: <20190224135143.24770-2-pankaj.bansal@nxp.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0352.eurprd05.prod.outlook.com
 (2603:10a6:7:92::47) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f34d68b6-abd8-46a4-ed9e-08d69b2faa8b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600110)(711020)(4605104)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB5198;
x-ms-traffictypediagnostic: VI1PR02MB5198:
x-microsoft-antispam-prvs: <VI1PR02MB5198EA0F5F5967CF74A07CCEBC7A0@VI1PR02MB5198.eurprd02.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(39830400003)(396003)(366004)(199004)(189003)(8676002)(229853002)(81156014)(446003)(6486002)(6116002)(3846002)(2616005)(186003)(305945005)(36756003)(11346002)(486006)(7736002)(31686004)(476003)(106356001)(81166006)(64126003)(26005)(105586002)(14454004)(6246003)(4326008)(74482002)(256004)(25786009)(6512007)(8936002)(97736004)(102836004)(386003)(53546011)(2906002)(110136005)(58126008)(71190400001)(71200400001)(65806001)(65956001)(508600001)(316002)(31696002)(68736007)(6436002)(86362001)(76176011)(5660300002)(6506007)(99286004)(52116002)(53936002)(66066001)(65826007)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB5198;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjAyTUI1MTk4OzIzOlZHQnp4V0NGUEt0WVJONHVGTmNIZHVCRkd6?=
 =?utf-8?B?WGdkNTI2MmRqQWRUSDFTK2ZaczVKN2dDSUNaSS9ENEFNU3RkTUdDazlkNTFz?=
 =?utf-8?B?dVZXZXdwcXpWTXZQUmxPQVlxL2krTnRUdUoyVDJiN2RkZi9FMTBOKytZSkpi?=
 =?utf-8?B?TTgxbmRwZkxHNGNKaEZwQjRwbXJOMmQySy9ETTlhelVkMkllWkY2b3ZwbW1q?=
 =?utf-8?B?MDJVUVZYZFdNZHJuaGw2TUI3WnBrVE84Q2kxKzRZbEVjZ0VXK3BsWVNlN1d1?=
 =?utf-8?B?eWNoemM2NVEzUitKUGlnaXlud3BmRmd5VTdlR09MbjlrbUtjMVpQOTI2dkdk?=
 =?utf-8?B?OHJlNW9MNzhxL25QNEw0K2ZYSVBlVXUrUXY0NjZETFM5d3NJc0hHY08weFFl?=
 =?utf-8?B?b01XR0FJNGVkZktPZmNlSGFsY3hEN3dKcWdoS3UyMmJsLzgvWStrR25Tb2hu?=
 =?utf-8?B?OEhvZkxhNVVMUDZGQTAwZmFkcm90SjRlT2M1UGRPOFo3NThseGpBMk1SaHZS?=
 =?utf-8?B?RHdUdm11VHp1VEpXRllCZkNrRHRPQ0RRZ21hb2xSNnk3YkdqRWVjeU5RYkRL?=
 =?utf-8?B?cCtjRVNzM0FQM3BDVGVoczVzdmZrMXNRRS92amdOTDFmNjF2NnMvSktrUE1O?=
 =?utf-8?B?bmZIRFAvcjJiZ0ZoNmFZNG1MWUN4cVcwUmR4eVozYUdjc3dSaXNLMkFXcVQz?=
 =?utf-8?B?NThXbDBBUHNJc3NxQmFmQUtOQUJ6RHUwSjFwZXgwRUtmc1l6U2pucXBxdnFH?=
 =?utf-8?B?RXp1VTRkam93a2dkTlIzcElDVkpwUHB0K2hoT2VBK3lwVkQyTTRhSG02VnIy?=
 =?utf-8?B?UHBRVjVvZHZ5Q3pUN0dyOWVHQi9FQWJCQ2c0Q2lCNStoLzlLeHRndkVDNm1h?=
 =?utf-8?B?Tm1UcW1xVU9nN0hyQ2F4WnBlZzVIaUpwdHdFWWozQUl4Q3MyUHFiS1hEdWZP?=
 =?utf-8?B?YTh5SXQzNmdrTUdZZE5PQ2JsUHhtM0EvcTVMb2p5eXRnWndXMTJoaXpGNGdz?=
 =?utf-8?B?U3U2WWZ5d2JtN0t2WnZhREdsWi94blhxaVc0bTNRdHRuUlVDQ1dTNE5RUDl1?=
 =?utf-8?B?S2t3Y2x3akpGWHBJcjY4bi9UYmhNaG1pclVjRHg1blg2WTUzQ0E2RzBDRnVK?=
 =?utf-8?B?NzNSaFFFc2s1R0o3ajVkN2hXbUpVVGNvWFByOXNZZEs1by9ZN2JYOU42S0RN?=
 =?utf-8?B?QTJqTlhtK05tK3k5R1VtdlNtMitSbjFpcTZRaTJXdmlIMWcrNmx0K2lMeXlv?=
 =?utf-8?B?T2pxRkJsVy9aQ1NxdFpoZWR2bkttblZqRzVxbzZOem9Pa1dHWFJDa2RzN0NR?=
 =?utf-8?B?UjB1UkVqd2xjRXhEV3k3SjdEazB4bEtyemtZUFlJeFpWd2tZcUJnMmZPc1FB?=
 =?utf-8?B?Rkd0Y3NIa0RuMTZoVk9hbjIxLy9EQmtMUmlRcktzRTVOY3Z2SFVSZnE3NEYz?=
 =?utf-8?B?QkNWVWJhbjNkNWhxdkpjcmI2T3hJeTZRSzk2cjQrSU05L1Z2QkxmUzZNdnZV?=
 =?utf-8?B?U2FzUE1DTHY0MXE5VjFLMXJ2TzNFS0tEMnJpcm9Zbm1HaDg2akdESnhnN1JD?=
 =?utf-8?B?SEZDa09iOFh4UEtCakRvNUp3WHoyZlNyMmlpR3dwSHlCQ2dNVms1T2RLSWV6?=
 =?utf-8?B?RFQyb3dTci9rb1VSZGNKSGFwajVxN2ZsRFpOUVVic3VYTXQ3MjRreGlkWTM3?=
 =?utf-8?B?anBsSnNCdlZCUk1GcVJzZlF2dGM2QmZvMTcyODdIaEFXbHlkY2JyL2NUYmV0?=
 =?utf-8?B?OVl2TktDOEltNW14SXRyZUtYWjhSbGUyaEtubVlpMndUZm9jWVBtL3hkLzF6?=
 =?utf-8?B?OUJ3YXNZc29zYnpaMTk1UzNVNkRMMlpwOWNQKzZNb3VFRmVscUMrSGlKQkp1?=
 =?utf-8?Q?T8AUe9tuWiWYYavpCFhLLBG1OiqO+Rkv?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KtQSNvywBSgNJhnN4FfClUimFY6lWCZJYeLToqAdGuW/LLupt9hRdVc/ttbjwbI5td+UodQggkfsrtgPGcex+0/aZKJ520ali79ZJK+fgvL1T1iyFyiC0szukKwgpcf2buQ4Jur8QT4RO3BqRI4pvY4T77A56z08FA2LNXv66eeY7UF+665hTz0wFeb35CA9Mpl9a2rDWwoKk6Xpi1BEC/JMuyFwuKWB5S3B3/6qv6A4yH2t36xe2sB7CiSGLNr/+lqvjNerSjoTcVKmldWazR20alZV2GZhWOjfqjmrQ3AgAZdugXlgUBVfxcu7KsNW3Q/i7x9r1EWf8XjIqvCfe4/WvLOWbAM4y4yX881p44b2fXRRHQTXaiSIGkc7vhROoY6u9jVO3pSrk+56qjd2hct0+xplThaPV4m8uxpOSeg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <420510E400FE7944B2BB8CB0B9D7B64C@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f34d68b6-abd8-46a4-ed9e-08d69b2faa8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 14:43:54.3456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMi0yNCAwOToyNywgUGFua2FqIEJhbnNhbCB3cm90ZToNCj4gR2VuZXJpYyByZWdp
c3RlciBiaXRmaWVsZC1iYXNlZCBtdWx0aXBsZXhlciB0aGF0IGNvbnRyb2xzIHRoZSBtdWx0aXBs
ZXhlcg0KPiBwcm9kdWNlciBkZWZpbmVkIHVuZGVyIGEgcGFyZW50IG5vZGUuDQo+IFRoZSBkcml2
ZXIgY29ycmVzcG9uZGluZyB0byBwYXJlbnQgbm9kZSBwcm92aWRlcyByZWdpc3RlciByZWFkL3dy
aXRlDQo+IGNhcGFiaWxpdGllcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBhbmthaiBCYW5zYWwg
PHBhbmthai5iYW5zYWxAbnhwLmNvbT4NCj4gLS0tDQo+IA0KPiBOb3RlczoNCj4gICAgIFYzOg0K
PiAgICAgLSBBZGRlZCB0aGUgcGF0Y2ggaW4gc2VyaWVzIHdpdGggZGV2aWNlIHRyZWUgYmluZGlu
ZyBwYXRjaA0KPiAgICAgLSBBZGRlZCB0aGUgTlVMTCByZXR1cm4gaGFuZGxpbmcgZm9yIHJlZ21h
cA0KPiAgICAgVjI6DQo+ICAgICAtIHJlbW92ZWQgc2VwZXJhdGUgZHJpdmVyIHJlZ21hcC5jIGFu
ZCBhZGRlZCB0aGUgcmVnbWFwIGZ1bmN0aW9uIGluIG1taW8uYw0KPiAgICAgICBiYXNlZCBvbiBj
b21wYXRpYmxlIGZpZWxkLCB0aGUgc3lzY29uIG9yIHJlZ21hcCBmdW5jdGlvbiB3b3VsZCBiZSBj
YWxsZWQNCj4gICAgIC0gTW9kaWZpZWQgdGhlIEtDb25maWcgYXMgcGVyIFBldGVyJ3MgY29tbWVu
dHMNCj4gDQo+ICBkcml2ZXJzL211eC9LY29uZmlnIHwgMTIgKysrKysrLS0tLS0tDQo+ICBkcml2
ZXJzL211eC9tbWlvLmMgIHwgMTAgKysrKysrKy0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMyBp
bnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bXV4L0tjb25maWcgYi9kcml2ZXJzL211eC9LY29uZmlnDQo+IGluZGV4IDc2NTlkNmM1ZjcxOC4u
ZTVjNTcxZmQyMzJjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL211eC9LY29uZmlnDQo+ICsrKyBi
L2RyaXZlcnMvbXV4L0tjb25maWcNCj4gQEAgLTQ2LDE0ICs0NiwxNCBAQCBjb25maWcgTVVYX0dQ
SU8NCj4gIAkgIGJlIGNhbGxlZCBtdXgtZ3Bpby4NCj4gIA0KPiAgY29uZmlnIE1VWF9NTUlPDQo+
IC0JdHJpc3RhdGUgIk1NSU8gcmVnaXN0ZXIgYml0ZmllbGQtY29udHJvbGxlZCBNdWx0aXBsZXhl
ciINCj4gLQlkZXBlbmRzIG9uIChPRiAmJiBNRkRfU1lTQ09OKSB8fCBDT01QSUxFX1RFU1QNCj4g
Kwl0cmlzdGF0ZSAiTU1JTy9SZWdtYXAgcmVnaXN0ZXIgYml0ZmllbGQtY29udHJvbGxlZCBNdWx0
aXBsZXhlciINCj4gKwlkZXBlbmRzIG9uIE9GIHx8IENPTVBJTEVfVEVTVA0KPiAgCWhlbHANCj4g
LQkgIE1NSU8gcmVnaXN0ZXIgYml0ZmllbGQtY29udHJvbGxlZCBNdWx0aXBsZXhlciBjb250cm9s
bGVyLg0KPiArCSAgTU1JTy9SZWdtYXAgcmVnaXN0ZXIgYml0ZmllbGQtY29udHJvbGxlZCBNdWx0
aXBsZXhlciBjb250cm9sbGVyLg0KPiAgDQo+IC0JICBUaGUgZHJpdmVyIGJ1aWxkcyBtdWx0aXBs
ZXhlciBjb250cm9sbGVycyBmb3IgYml0ZmllbGRzIGluIGEgc3lzY29uDQo+IC0JICByZWdpc3Rl
ci4gRm9yIE4gYml0IHdpZGUgYml0ZmllbGRzLCB0aGVyZSB3aWxsIGJlIDJeTiBwb3NzaWJsZQ0K
PiAtCSAgbXVsdGlwbGV4ZXIgc3RhdGVzLg0KPiArCSAgVGhlIGRyaXZlciBidWlsZHMgbXVsdGlw
bGV4ZXIgY29udHJvbGxlcnMgZm9yIGJpdGZpZWxkcyBpbiBlaXRoZXINCj4gKwkgIGEgc3lzY29u
IHJlZ2lzdGVyIG9yIGEgZHJpdmVyIHJlZ21hcCByZWdpc3Rlci4gRm9yIE4gYml0IHdpZGUNCj4g
KwkgIGJpdGZpZWxkcywgdGhlcmUgd2lsbCBiZSAyXk4gcG9zc2libGUgbXVsdGlwbGV4ZXIgc3Rh
dGVzLg0KPiAgDQo+ICAJICBUbyBjb21waWxlIHRoZSBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29z
ZSBNIGhlcmU6IHRoZSBtb2R1bGUgd2lsbA0KPiAgCSAgYmUgY2FsbGVkIG11eC1tbWlvLg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tdXgvbW1pby5jIGIvZHJpdmVycy9tdXgvbW1pby5jDQo+IGlu
ZGV4IDkzNWFjNDRhYTIwOS4uY2MwMjE1NWU0NjQ0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL211
eC9tbWlvLmMNCj4gKysrIGIvZHJpdmVycy9tdXgvbW1pby5jDQo+IEBAIC0yOCw2ICsyOCw3IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXV4X2NvbnRyb2xfb3BzIG11eF9tbWlvX29wcyA9IHsNCj4g
IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXV4X21taW9fZHRfaWRzW10g
PSB7DQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtbWlvLW11eCIsIH0sDQo+ICsJeyAuY29tcGF0aWJs
ZSA9ICJyZWctbXV4IiwgfSwNCj4gIAl7IC8qIHNlbnRpbmVsICovIH0NCj4gIH07DQo+ICBNT0RV
TEVfREVWSUNFX1RBQkxFKG9mLCBtdXhfbW1pb19kdF9pZHMpOw0KPiBAQCAtNDMsOSArNDQsMTIg
QEAgc3RhdGljIGludCBtdXhfbW1pb19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiAgCWludCByZXQ7DQo+ICAJaW50IGk7DQo+ICANCj4gLQlyZWdtYXAgPSBzeXNjb25fbm9k
ZV90b19yZWdtYXAobnAtPnBhcmVudCk7DQo+IC0JaWYgKElTX0VSUihyZWdtYXApKSB7DQo+IC0J
CXJldCA9IFBUUl9FUlIocmVnbWFwKTsNCj4gKwlpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUo
bnAsICJtbWlvLW11eCIpKQ0KPiArCQlyZWdtYXAgPSBzeXNjb25fbm9kZV90b19yZWdtYXAobnAt
PnBhcmVudCk7DQo+ICsJZWxzZQ0KPiArCQlyZWdtYXAgPSBkZXZfZ2V0X3JlZ21hcChkZXYtPnBh
cmVudCwgTlVMTCk7DQo+ICsJaWYgKElTX0VSUl9PUl9OVUxMKHJlZ21hcCkpIHsNCj4gKwkJcmV0
ID0gUFRSX0VSUl9PUl9aRVJPKHJlZ21hcCkgPyBQVFJfRVJSKHJlZ21hcCkgOiAtRU5PREVWOw0K
DQpUaGUgYWJvdmUgaXMgbm90IGNvcnJlY3QsIHRoaXMgc2hvdWxkIGJlIGJldHRlciAodW50ZXN0
ZWQpOg0KDQoJCXJldCA9IFBUUl9FUlIocmVnbWFwKSA/OiAtRU5PREVWOw0KDQpDaGVlcnMsDQpQ
ZXRlcg0KDQo+ICAJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGdldCByZWdtYXA6ICVkXG4iLCBy
ZXQpOw0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAgCX0NCj4gDQoNCg==
