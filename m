Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98114C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A382081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Isy4+3vM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A382081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeK2V0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:26:54 -0500
Received: from mail-eopbgr80040.outbound.protection.outlook.com ([40.107.8.40]:24239
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726740AbeK2V0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+DwM9PNPPymcZBelLv/9BIu2BFs/iBxr/chiGGWYkU=;
 b=Isy4+3vMbpQzhLiMlWHtH5Aj8hPnrJ3uGLSywRJXVqyZ+3kshyhAm2GryUOB9sK6ns0Z4sqwwt+jnspgq8/z0cwpbEw7g0RbmpdgYy1PIQwJawhMKU4fHJtnqpRIo5dcJA6o76SvFMtwm+2DhGV+TsSstQp7SZLDb64mY8p8ja0=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2496.eurprd08.prod.outlook.com (10.175.24.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 29 Nov 2018 10:21:53 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1382.017; Thu, 29 Nov
 2018 10:21:53 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH 7/7] lib/lzo: separate lzo-rle from lzo
Thread-Topic: [PATCH 7/7] lib/lzo: separate lzo-rle from lzo
Thread-Index: AQHUhmz8mgLwzeoYokiWGTdfe93T2aVmL1CAgABehYA=
Date:   Thu, 29 Nov 2018 10:21:53 +0000
Message-ID: <293c53a6-3313-359a-c5d0-2e2fa453494a@arm.com>
References: <20181127161913.23863-1-dave.rodgman@arm.com>
 <20181127161913.23863-8-dave.rodgman@arm.com>
 <20181129044333.GH6379@jagdpanzerIV>
In-Reply-To: <20181129044333.GH6379@jagdpanzerIV>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LNXP265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::21) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2496;6:GRzOCRnnHAuAzs/r5Lpgx5vn/pqOBScMH3TEcLVuFQlTfc1U5veqWM81VGMkqYRqf95oACNMaJbYBcq9qpR8GFs7mGsZoUAmIvgWahXPwU2ZqNHYkg1lXVHt8JS85jgzhYutR/ve62ut9L/+fc5lqAsuxuWPNCf7XZPh3C8R14p5RnrHlZU7/ioCJQK7N3wx2aBc6yZEZJK7zJg1b/xnIYNutzKvtcB8aN3i4YBxd53Ht/Nngkdi1+PYZV5IvE9I3P7UQuOBQZ+wfr7No8b4hEjOlB6EcjMhI3nytjge4zIktawDhpEs5YoobKDbAisUS1Mm7cUGXICpXHq4sQ2hOSMs3F7/GAVVNKBEcyQapasNDa/Gi9/0oMAuNPqvSi6x+zPSEmDa+18ypTaYX/gnLG9lNR5mxXwMaPo4KQ4odJrB7oeZ0b1CSi26k7DPKjv7EpoXgWTpUz+5P3S+bG9x0w==;5:jP0J1i0/HNv7nHCNJ625nISd3ZgXQWpyLQLL30xn7/jv+gRl2Q/yPH1+CNHUKpoCJDk8vZZsflw9hWLrQPnO5I/5Mrhv1+MgTNIWtBSmqkp+mcuRyh5kW0pVl8PuRk9QKfsaCJBUFahBdGuz4QAaRb+u6Y0O8tQMPHwyHO096ZQ=;7:PIyD0Wra0Jlr8TAqMOnwseGRqFv6rrycHZIa8OPlgFyOt6nim1hAZoK/d41ueYFVW7hFs0Cvpl4eE0Wm6MURqF20PCW/eu2Rs8R0uQdVmSeH/OEtWGCdHDKC21HtHZ/nyLEfqkNe28wVPfiyllofLA==
x-ms-office365-filtering-correlation-id: 5d4ee564-f93f-4108-f1d2-08d655e47b59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2496;
x-ms-traffictypediagnostic: VI1PR0802MB2496:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB24965AED9142D280B0B85F178FD20@VI1PR0802MB2496.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231453)(999002)(944501410)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2496;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2496;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(346002)(39860400002)(189003)(199004)(86362001)(44832011)(102836004)(11346002)(6506007)(105586002)(53546011)(106356001)(386003)(6436002)(186003)(6246003)(99286004)(6486002)(316002)(7736002)(305945005)(54906003)(26005)(7416002)(5660300001)(66066001)(6512007)(31686004)(53936002)(76176011)(52116002)(68736007)(36756003)(25786009)(256004)(71190400001)(97736004)(6916009)(71200400001)(4326008)(229853002)(39060400002)(31696002)(14454004)(478600001)(81156014)(476003)(8676002)(2616005)(81166006)(3846002)(446003)(486006)(2906002)(6116002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2496;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZpVfykxc892Y/Cv/YRMko6S8WhE8v3y55XoO8Z4YK+/LPw98/xR1YmcZLauBn6D54zSubrRK4F0ZuVlTA6ul7Wm9ODThHa+p3l2pohPtFITZf5XS2amPbkBTjLcFNXEiA5uxgvJIrXGk7+uJqGnLwxfSuD3gYMuOU5LtqJBUPSd9JEW6E08FMp0DyrFQuQGEAQTwJh05+ct++fFsD7dBGKPNTrEY7cq84TYWX4WENQggZzuEeFEMo/lbDQ8p/zylvMmysH33mrsuXKgSdTEMSr3/XoXAzx2sS0UDOKUP+WgdNlPaRx+BYBWWSCvyNWn3TokbF0f8IEYwDXMhfoJa2RkGo8XtuKundUKLqM6UKgY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <43615CBD4B106247BB7FAAB88D5736FC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4ee564-f93f-4108-f1d2-08d655e47b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 10:21:53.4844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2496
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI5LzExLzIwMTggNDo0MyBhbSwgU2VyZ2V5IFNlbm96aGF0c2t5IHdyb3RlOg0KPiBP
biAoMTEvMjcvMTggMTY6MTkpLCBEYXZlIFJvZGdtYW4gd3JvdGU6DQo+PiAgIERvY3VtZW50YXRp
b24vbHpvLnR4dCAgICAgICAgIHwgIDEyICsrLQ0KPj4gICBjcnlwdG8vTWFrZWZpbGUgICAgICAg
ICAgICAgICB8ICAgMiArLQ0KPj4gICBjcnlwdG8vbHpvLXJsZS5jICAgICAgICAgICAgICB8IDE3
NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgY3J5cHRv
L3RjcnlwdC5jICAgICAgICAgICAgICAgfCAgIDQgKy0NCj4+ICAgZHJpdmVycy9ibG9jay96cmFt
L3pjb21wLmMgICAgfCAgIDEgKw0KPj4gICBkcml2ZXJzL2Jsb2NrL3pyYW0venJhbV9kcnYuYyB8
ICAgMiArLQ0KPj4gICBpbmNsdWRlL2xpbnV4L2x6by5oICAgICAgICAgICB8ICAgNCArDQo+PiAg
IGxpYi9sem8vbHpvMXhfY29tcHJlc3MuYyAgICAgIHwgIDQyICsrKysrKystLS0NCj4+ICAgbGli
L2x6by9sem9kZWZzLmggICAgICAgICAgICAgfCAgIDMgKy0NCj4+ICAgOSBmaWxlcyBjaGFuZ2Vk
LCAyMjcgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+PiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBjcnlwdG8vbHpvLXJsZS5jDQo+IA0KPiBbLi5dDQo+IA0KPj4gK3N0YXRpYyBzdHJ1Y3Qg
Y3J5cHRvX2FsZyBhbGcgPSB7DQo+PiArCS5jcmFfbmFtZQkJPSAibHpvLXJsZSIsDQo+PiArCS5j
cmFfZmxhZ3MJCT0gQ1JZUFRPX0FMR19UWVBFX0NPTVBSRVNTLA0KPj4gKwkuY3JhX2N0eHNpemUJ
CT0gc2l6ZW9mKHN0cnVjdCBsem9ybGVfY3R4KSwNCj4+ICsJLmNyYV9tb2R1bGUJCT0gVEhJU19N
T0RVTEUsDQo+PiArCS5jcmFfaW5pdAkJPSBsem9ybGVfaW5pdCwNCj4+ICsJLmNyYV9leGl0CQk9
IGx6b3JsZV9leGl0LA0KPj4gKwkuY3JhX3UJCQk9IHsgLmNvbXByZXNzID0gew0KPj4gKwkuY29h
X2NvbXByZXNzCQk9IGx6b3JsZV9jb21wcmVzcywNCj4+ICsJLmNvYV9kZWNvbXByZXNzCQk9IGx6
b3JsZV9kZWNvbXByZXNzIH0gfQ0KPj4gK307DQo+IA0KPiBBIG5pdHBpY2s6DQo+ICAgIGluZGVu
dGF0aW9uIGZvciAuY29tcHJlc3MgYXNzaWdubWVudCBpcyBhIGJpdCBjb25mdXNpbmcsIG1heWJl
Lg0KDQpBZ3JlZWQgLSBJJ3ZlIGNvcGllZCB0aGlzIGRpcmVjdGx5IGZyb20gY3J5cHRvL2x6by5j
IHRob3VnaCwgc28gSSANCnJldGFpbmVkIHRoZSBzYW1lIHN0eWxlLiBDbGVhbnVwIGNvdWxkIGJl
IGEgc2VwYXJhdGUgcGF0Y2guDQoNCj4gWy4uXQ0KPj4gKysrIGIvZHJpdmVycy9ibG9jay96cmFt
L3pjb21wLmMNCj4+IEBAIC0yMCw2ICsyMCw3IEBADQo+PiAgIA0KPj4gICBzdGF0aWMgY29uc3Qg
Y2hhciAqIGNvbnN0IGJhY2tlbmRzW10gPSB7DQo+PiAgIAkibHpvIiwNCj4+ICsJImx6by1ybGUi
LA0KPj4gICAjaWYgSVNfRU5BQkxFRChDT05GSUdfQ1JZUFRPX0xaNCkNCj4+ICAgCSJsejQiLA0K
Pj4gICAjZW5kaWYNCj4gDQo+IFsuLl0NCj4gDQo+PiArKysgYi9kcml2ZXJzL2Jsb2NrL3pyYW0v
enJhbV9kcnYuYw0KPj4gQEAgLTQxLDcgKzQxLDcgQEAgc3RhdGljIERFRklORV9JRFIoenJhbV9p
bmRleF9pZHIpOw0KPj4gICBzdGF0aWMgREVGSU5FX01VVEVYKHpyYW1faW5kZXhfbXV0ZXgpOw0K
Pj4gICANCj4+ICAgc3RhdGljIGludCB6cmFtX21ham9yOw0KPj4gLXN0YXRpYyBjb25zdCBjaGFy
ICpkZWZhdWx0X2NvbXByZXNzb3IgPSAibHpvIjsNCj4+ICtzdGF0aWMgY29uc3QgY2hhciAqZGVm
YXVsdF9jb21wcmVzc29yID0gImx6by1ybGUiOw0KPiANCj4gT0ssIHNvIGl0J3Mgbm90IGp1c3Qg
InNlcGFyYXRlIGx6by1ybGUiLCBpdCdzIGFsc28gInN3aXRjaCB6cmFtIHRvDQo+IGEgbmV3IGNv
bXByZXNzaW9uIGFsZ29yaXRobSBieSBkZWZhdWx0Ii4gSSdkIHNheSB0aGF0IHVzdWFsbHkgSSdk
DQo+IGV4cGVjdCB0aGlzIHRvIGJlIHNlcGFyYXRlIHBhdGNoZXMuDQoNClllcywgZmFpciBwb2lu
dC4gYWtwbSBoYXMgcGlja2VkIHRoaXMgdXAgbm93IHRob3VnaCwgc28gcHJvYmFibHkgYSBiaXQg
DQpsYXRlIHRvIGJyZWFrIGl0IG91dCBpbnRvIGEgc2VwYXJhdGUgcGF0Y2g/DQoNCkRhdmUNCg==
