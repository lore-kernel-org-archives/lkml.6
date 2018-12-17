Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49D4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F502145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Mu8AYqdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbeLQXCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 18:02:16 -0500
Received: from mail-eopbgr10113.outbound.protection.outlook.com ([40.107.1.113]:13644
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726904AbeLQXCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 18:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFPvfOQE/ZPAJ4VIarQjxIxt7apx69JSOilqJzgP1XE=;
 b=Mu8AYqdil6bocRD0SEYYjxsAYAm11O6JhQEm3BkGOp6CBFf9nKb48tKHaFkRZlSYPAITfctzYFNk8euHtktGu9XkYq4nhUc914MvGHqaWHbPdoZqiSxymaf9NRaJMtvEiN+b427kCU/5YRweXKCp2MiqO9FWbmeUcE/2BKoyJaA=
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com (20.178.13.204) by
 VI1PR02MB4861.eurprd02.prod.outlook.com (20.177.202.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Mon, 17 Dec 2018 23:02:09 +0000
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::11d9:9fe:f412:46a8]) by VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::11d9:9fe:f412:46a8%4]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 23:02:09 +0000
From:   Peter Rosin <peda@axentia.se>
To:     =?utf-8?B?S3J6eXN6dG9mIEhhxYJhc2E=?= <khalasa@piap.pl>,
        Fabio Estevam <festevam@gmail.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] ARM i.MX: Fix a kernel panic in
 i2c_imx_clk_notifier_call().
Thread-Topic: [PATCH] ARM i.MX: Fix a kernel panic in
 i2c_imx_clk_notifier_call().
Thread-Index: AQHUivoCFZJ/Cu8YiUGtTQuLje+MLqVs3rsAgBXckK+AAOfMgA==
Date:   Mon, 17 Dec 2018 23:02:09 +0000
Message-ID: <f324c18c-364e-c0fa-05c9-649b8946c977@axentia.se>
References: <m3o9a2hni5.fsf@t19.piap.pl>
 <CAOMZO5Bhe9t0x0Ke0VJTR3BaeT+ww9vCZBit-8ubyRQjtjM4=Q@mail.gmail.com>
 <m3va3sh5zl.fsf@t19.piap.pl>
In-Reply-To: <m3va3sh5zl.fsf@t19.piap.pl>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0402CA0048.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::37) To VI1PR02MB5119.eurprd02.prod.outlook.com
 (2603:10a6:803:b7::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB4861;6:RtuoiTbPEIwhd4djKkJgud9dWcnirRU9lPc3D6u7qqGMePgps4JKw2DTtxhGvwgNNG7/e8Vt4r74HoI5QVkksRemzcb74MK8IdVsIq1IqWpJv0UHyYJp+yZK8BJwk5KthkiVyOp/K9l75hTToOPlGm0Uv2whQ+Jc4MvDi0Q9h5bdGCrB1+1HTboJ8PsCURcs+JbhdYT/cm3VWYouG+B61RX+Se4DOp443x4ERaFtQnchIwMX/TLVtb4gakQ08qbXeJt/lFc8PLROm85yGbVer4gX+zqY0qrfwmpyQscLpdj+K6E8z+4kovghC6JH7oNnbRw8VFmi1D+xQSdHCKDlJ5r5XcBN/UEQ2Qu8SdUm0hdvNUb8lQoS+iOf3NVOyeTwPVDQNsqOJdX5b/ungiLV27vql+OwBDyt2sMITGAUylIJrWrmJDGmkC1IXws1dNbd2VhSzIzCVFbO/3zfpPoBYQ==;5:JW2g0IXi8+q1Wg0616PHGtk5akzbstwiWhLdzyfeN3uvYanu9vDPHtZ9VPjTP4go0taI+w75VhzbcPkOPX3gHdXzHbLeufmB9jPyfBVECjdBxGKN0Ol1gbvGlkkdzcMO1GAJRzkOON/AIfFCuDNUzhPterQ7orO+sfCiNawc1XQ=;7:KcDuLllnu+ykE4vECnpNEO6kcVm3XD4Ho4oXgp6SL5dTjkbPo5yuQNNIt4Qit/7erBhVb/ZBSZ4LHXFCwysGurCgfPfv4z/2exDMCRYPQUoVmjkPyYJjmW2leqwDWu98Fq4gm3cIkC6SkjFnMN0mow==
x-ms-office365-filtering-correlation-id: dd4edf7f-da32-4b4d-4893-08d66473ac10
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB4861;
x-ms-traffictypediagnostic: VI1PR02MB4861:
x-microsoft-antispam-prvs: <VI1PR02MB48613D188641E4707844C017BCBC0@VI1PR02MB4861.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR02MB4861;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB4861;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39830400003)(376002)(366004)(346002)(199004)(189003)(65826007)(316002)(97736004)(6246003)(110136005)(3846002)(6116002)(54906003)(58126008)(476003)(4326008)(486006)(99286004)(8936002)(6436002)(5660300001)(14454004)(86362001)(6486002)(81156014)(39060400002)(8676002)(81166006)(508600001)(575784001)(256004)(31696002)(2906002)(64126003)(305945005)(74482002)(7736002)(36756003)(11346002)(446003)(2616005)(6512007)(71190400001)(71200400001)(31686004)(53546011)(6506007)(386003)(229853002)(68736007)(76176011)(4001150100001)(52116002)(26005)(53936002)(186003)(102836004)(105586002)(65956001)(66066001)(106356001)(65806001)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4861;H:VI1PR02MB5119.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6TWIlf6epjF43egwl19H5PNGd9ZHHhpD44JPNPbAHA/DSPrtHHYGwu5iCfUPKCpXSHKlOJeNrZ4NPJuaSEFYmPNWCUfVo+xMubwZW0GVwSzlyHIZ3Qma3piekrp7Uf59xVx1pBfnALMLFbls7tj8+UI9ADWeBcoV8L7MR87yinoZfswgrNxQzJn33vy3Nst2indF3N541vu1IAADb6ZFNgd+0HSaGLsZpqVRqqvFPOIjbqEXX+wYlro13JoaiVhUXV06+nfx5V3QCrXkNE6k4ABA/n+d3B4/WZEkDTdFBY9q/k+2JTqv6bdxVsPb8jmB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <812FE0E52CEAD54A9E4CDBDAA59AD677@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4edf7f-da32-4b4d-4893-08d66473ac10
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 23:02:09.3081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4861
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMi0xNyAxMDoxMiwgS3J6eXN6dG9mIEhhxYJhc2Egd3JvdGU6DQo+IDkwYWQyY2Jl
ODhjMjJkMDIxNTIyNWFiOTU5NGVlZWFkMGViMjRmZGUgY2hhbmdlZCB0aGUgaS5NWCBJMkMgYnVz
IGRyaXZlcg0KDQpUaGlzIHJlZmVyZW5jZSBzaG91bGQgaWRlYWxseSBiZSBpbiBhIGZpeGVzLXRh
ZywgYmVsb3cuLi4NCg0KPiB0byB1c2UgYSBub3RpZmllciB3aGVuZXZlciB0aGUgYmFzZSBjbG9j
ayAoImlwZyIgLSA2NiBNSHogcGVyaXBoZXJhbA0KPiBjbG9jaykgcmF0ZSBjaGFuZ2VzLg0KPiAN
Cj4gVW5mb3J0dW5hdGVseSBvbmUgY2FuJ3QgdXNlIHRoZSBjb250YWluZXJfb2YoKSBtYWNybyB0
aGlzIHdheSAtIHRoZQ0KPiBmaXJzdCBhcmd1bWVudCBoYXMgdG8gcG9pbnQgdG8gYSBtZW1iZXIg
b2YgdGhlIGJpZ2dlciBzdHJ1Y3QgKGxhc3QNCj4gYXJndW1lbnQpLiBNZXJlbHkgcG9pbnRpbmcg
dG8gdGhlIHNhbWUgdmFsdWUgaXNuJ3QgZW5vdWdoICh0aGUgY2xrDQo+IHZhcmlhYmxlIHdoaWNo
IGhhcyBpdHMgYWRkcmVzcyBwYXNzZWQgdG8gdGhlIG1hY3JvIGlzIHRoZSBjbGsgaW4NCj4gbm90
aWZpZXJfYmxvY2ssIG5vdCB0aGUgb25lIGluIGlteF9pMmNfc3RydWN0LCBldmVuIHRob3VnaCBi
b3RoIHBvaW50ZXJzDQo+IHBvaW50IHRvIHRoZSBzYW1lIGNsayBzdHJ1Y3QpLg0KPiANCj4gVGhp
cyBidWcgY2F1c2VzIGtlcm5lbCBwYW5pYyB3aGVuIHRoZSBJUEcgY2xvY2sgcmF0ZSBjaGFuZ2Vz
IChlLmcuIGlmDQo+IGFueSBjbG9jayBkZXJpdmVkIGZyb20gSVBHIGNoYW5nZXMpLg0KPiANCg0K
Li4ucmlnaHQgaGVyZS4NCg0KRml4ZXM6IDkwYWQyY2JlODhjMiAoImkyYzogaW14OiB1c2UgY2xr
IG5vdGlmaWVyIGZvciByYXRlIGNoYW5nZXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2Yg
SGFsYXNhIDxraGFsYXNhQHBpYXAucGw+DQo+IA0KPiAtLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMv
aTJjLWlteC5jDQo+ICsrKyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtaW14LmMNCj4gQEAgLTUx
MCw5ICs1MTAsOSBAQCBzdGF0aWMgaW50IGkyY19pbXhfY2xrX25vdGlmaWVyX2NhbGwoc3RydWN0
IG5vdGlmaWVyX2Jsb2NrICpuYiwNCj4gIAkJCQkgICAgIHVuc2lnbmVkIGxvbmcgYWN0aW9uLCB2
b2lkICpkYXRhKQ0KPiAgew0KPiAgCXN0cnVjdCBjbGtfbm90aWZpZXJfZGF0YSAqbmRhdGEgPSBk
YXRhOw0KPiAtCXN0cnVjdCBpbXhfaTJjX3N0cnVjdCAqaTJjX2lteCA9IGNvbnRhaW5lcl9vZigm
bmRhdGEtPmNsaywNCj4gKwlzdHJ1Y3QgaW14X2kyY19zdHJ1Y3QgKmkyY19pbXggPSBjb250YWlu
ZXJfb2YobmIsDQo+ICAJCQkJCQkgICAgICBzdHJ1Y3QgaW14X2kyY19zdHJ1Y3QsDQo+IC0JCQkJ
CQkgICAgICBjbGspOw0KPiArCQkJCQkJICAgICAgY2xrX2NoYW5nZV9uYik7DQo+ICANCj4gIAlp
ZiAoYWN0aW9uICYgUE9TVF9SQVRFX0NIQU5HRSkNCj4gIAkJaTJjX2lteF9zZXRfY2xrKGkyY19p
bXgsIG5kYXRhLT5uZXdfcmF0ZSk7DQo+IA0KDQo=
