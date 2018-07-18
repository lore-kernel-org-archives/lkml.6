Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF0AECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92EC2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="UYT2fZW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92EC2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbeGROER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:04:17 -0400
Received: from mail-he1eur01on0100.outbound.protection.outlook.com ([104.47.0.100]:55840
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726909AbeGROEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kXylYKnb0vKq4aP5iKE3aKzJM4h4OKfFF2CcB6XFrs=;
 b=UYT2fZW6/jV3C6CLCD6PSsttGQk2CbzmtKWNvD9dd5hCZ6EsFZDdDeAymnPVM631Zj3Kprw42IcfvxN8iJMG1RmzBnJoR1CvSyPE/keHe9Y9U7jIm5NhPzSeXCd6+QarH/8q1mrACcGfGSjex1N1sY3FvHWkQzSto8igN8RaE4c=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2366.eurprd05.prod.outlook.com (10.169.135.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Wed, 18 Jul 2018 13:26:12 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e%8]) with mapi id 15.20.0973.016; Wed, 18 Jul 2018
 13:26:12 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "patches@linaro.org" <patches@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Thread-Topic: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Thread-Index: AQHUHUhtmsif0KNc40KlPUM2WKHIC6SUoqmAgAADkYCAABmYgIAABUWAgAAuAQCAAANKgIAABNUA
Date:   Wed, 18 Jul 2018 13:26:12 +0000
Message-ID: <1531920370.16896.25.camel@toradex.com>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
         <20180718080913.GB4641@dell> <1531902119.16896.13.camel@toradex.com>
         <20180718095335.GD4641@dell> <20180718101227.shqf54wpt4kdrsj2@holly.lan>
         <1531918626.16896.22.camel@toradex.com> <20180718130853.GE4641@dell>
In-Reply-To: <20180718130853.GE4641@dell>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2366;6:O5rSVJyqjlqE2pvIrOZgI+WX7bJkKiGrlVlZN4N6yanvn1LePXgLnVdsjBScS43NL0Dmeu8QCfjuTEOAJKvLtRv/tzyTK6qmEiLbdIA6csXCVf0FkXvVDVDW4SCTDHez9aQ/vo4YUPBsK1o8hYLC0kwZbtyAAUkIaoN9oelNpGLZ1AfMOXNJhycr0GY7H1nnWwxjO2oN4lAX3i7xxJ7XjUPj81SmEVYW+ufcu/Rd6HZz0ZasAJab3zfiZoBsX+1tIUxBhEuy94Ac92l3pdmFVxYgMdUiqbMhNMLU9gLCQw3t0LvVAElslVz4OUh+C15DaTu5eWVor33VqK9gAVhcZujM2A+S63KEfcVtIfIxBxktD/s0kVqozl9UUFYX8zDWwyYrKqxaOMZNlQYuw+4veNtjwO7BgHgl9prLCmkJLjpPAlP0gRUd8u3efCKXeT2fAvIKEnzWW2m5+Y5EBhWfcg==;5:tbdpDblepwEeZs++MxFJJIXIWjTklPWsM+66NZ75GMQF+kPUM9nQ20IfcOkyjwKPD20FI9LTJqc0XSv/lBhLwPC56h1sUbQIO6zWl3yTt2YWsVDA5/YWqPFzARxiKGf2nYXJyiJEmHg84rKSTvFoQeyOD5bQ4iHBtYT2GM8pwAM=;7:UGS2SR/5/1S06gkg2xThqM011bbqWKgESCHLGud/GyT9GXehBol6ASJFDyj3NJr/fia5hR/IXnRGCgZe9Yv9g1RE7NF10XLyxHrzn4ZcIy52hJH555uRlk5lqttkNPa9vpZu2Tui9jC7SPJA8HlJ5iG5AbYf/muElIQ171hEBa9jgfkAIv9zzz2+9jAs04h98g1wlvyqPwlWmg1L+W9+SJ+NlqEvQwlLjo2hRWwGtZZXqk779Kx7RsHg2nAY04YI
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1a8d1ce2-6397-44d9-1e17-08d5ecb20813
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600064)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2366;
x-ms-traffictypediagnostic: VI1PR0501MB2366:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-microsoft-antispam-prvs: <VI1PR0501MB2366D537A928929312D547F8FB530@VI1PR0501MB2366.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2366;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2366;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39840400004)(366004)(136003)(189003)(199004)(14454004)(11346002)(5660300001)(44832011)(446003)(486006)(476003)(7416002)(478600001)(81166006)(229853002)(6486002)(2616005)(86362001)(8936002)(8676002)(2351001)(2906002)(105586002)(106356001)(93886005)(6916009)(256004)(5250100002)(99286004)(316002)(2501003)(66066001)(97736004)(54906003)(81156014)(39060400002)(3846002)(26005)(102836004)(6116002)(2900100001)(6512007)(6506007)(25786009)(4326008)(53936002)(186003)(36756003)(103116003)(68736007)(7736002)(6436002)(6246003)(76176011)(305945005)(5640700003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2366;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uu/ZAQCSNIYZbGZ4Z0ylOOp4xSHc6f2eaJoGMKnuoJ8xbC4JjLqVIie/Nq5bv5/n4RRza3Mi6XHQJqGkUjkfJFRuRGiOO44Fpve3qAtBZ01mR6FYXjUhnU5GAHn7CDaVtA7V+aMkdmXAfWaeP7nBLo1n56qY5C0NtpDiR94tRFL4Bkej8rkZJVCPC8TmkInk7JlRb9t9OxMWdKOvbiDne6NBELfIm3zLWQoJFuGdWyET1rjKG5T3IJgys3whAXdLEBoSqfXG16tHBF0YHMRBlsiEs9RUUJzPJca6joqce/k7lq0Y9Ok0lwPbzoo8hOm/HZmT0riQsInSYNtPuMgdttJQs29zFfYqhIFd6gjcZWo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC505194FC199947951BD903EDBA233F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8d1ce2-6397-44d9-1e17-08d5ecb20813
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 13:26:12.5046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2366
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA3LTE4IGF0IDE0OjA4ICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6DQo+IE9u
IFdlZCwgMTggSnVsIDIwMTgsIE1hcmNlbCBaaXN3aWxlciB3cm90ZToNCj4gDQo+ID4gT24gV2Vk
LCAyMDE4LTA3LTE4IGF0IDExOjEyICswMTAwLCBEYW5pZWwgVGhvbXBzb24gd3JvdGU6DQo+ID4g
PiBPbiBXZWQsIEp1bCAxOCwgMjAxOCBhdCAxMDo1MzozNUFNICswMTAwLCBMZWUgSm9uZXMgd3Jv
dGU6DQo+ID4gPiA+IE9uIFdlZCwgMTggSnVsIDIwMTgsIE1hcmNlbCBaaXN3aWxlciB3cm90ZToN
Cj4gPiA+ID4gDQo+ID4gPiA+ID4gT24gV2VkLCAyMDE4LTA3LTE4IGF0IDA5OjA5ICswMTAwLCBM
ZWUgSm9uZXMgd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBNb24sIDE2IEp1bCAyMDE4LCBEYW5pZWwg
VGhvbXBzb24gd3JvdGU6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gQ3VycmVudGx5LCBp
ZiB0aGUgRFQgZG9lcyBub3QgZGVmaW5lIG51bS1pbnRlcnBvbGF0ZWQtDQo+ID4gPiA+ID4gPiA+
IHN0ZXBzDQo+ID4gPiA+ID4gPiA+IHRoZW4NCj4gPiA+ID4gPiA+ID4gbnVtX3N0ZXBzIGlzIHVu
ZGVmaW5lZCBhbmQgdGhlIGludGVycG9sYXRpb24gY29kZSB3aWxsDQo+ID4gPiA+ID4gPiA+IGRl
cGxveQ0KPiA+ID4gPiA+ID4gPiByYW5kb21seS4NCj4gPiA+ID4gPiA+ID4gRml4IHRoaXMuDQo+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBGaXhlczogNTczZmU2ZDFjMjVjICgiYmFja2xp
Z2h0OiBwd21fYmw6IExpbmVhcg0KPiA+ID4gPiA+ID4gPiBpbnRlcnBvbGF0aW9uDQo+ID4gPiA+
ID4gPiA+IGJldHdlZW4NCj4gPiA+ID4gPiA+ID4gYnJpZ2h0bmVzcy1sZXZlbHMiKQ0KPiA+ID4g
PiA+ID4gPiBSZXBvcnRlZC1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9y
YWRleC5jb20NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBE
YW5pZWwgVGhvbXBzb24gPGRhbmllbC50aG9tcHNvbkBsaW5hcm8ub3INCj4gPiA+ID4gPiA+ID4g
Zz4NCj4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwu
emlzd2lsZXJAdG9yYWRleC5jDQo+ID4gPiA+ID4gPiA+IG9tPg0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiBUaGlzIGxpbmUgaXMgY29uZnVzaW5nLiAgRGlkIHlvdSBndXlzIGF1dGhvciB0aGlz
IHBhdGNoDQo+ID4gPiA+ID4gPiB0b2dldGhlcj8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBZZXMs
IEkgcmVwb3J0ZWQgaXQgYW5kIHdlIGNhbWUgdG8gYSBjb25jbHVzaW9uIHRvZ2V0aGVyLg0KPiA+
ID4gPiANCj4gPiA+ID4gSXQgc291bmRzIGxpa2UgeW91IG5lZWQgdG8gaGF2ZSBhbGwgb2YgdGhl
IHRhZ3MgKGV4Y2VwdCB0aGlzDQo+ID4gPiA+IG9uZSkuDQo+ID4gPiA+IDopDQo+ID4gPiA+IA0K
PiA+ID4gPiAgUmVwb3J0ZWQtYnk6ICBmb3IgcmVwb3J0aW5nIHRoZSBpc3N1ZQ0KPiA+ID4gPiAg
U3VnZ2VzdGVkLWJ5OiBmb3Igc3VnZ2VzdGluZyBhIHJlc29sdXRpb24NCj4gPiA+ID4gIEFja2Vk
LWJ5OiAgICAgZm9yIHJldmlld2luZyBpdA0KPiA+ID4gPiAgVGVzdGVkLWJ5OiAgICBmb3IgdGVz
dGluZyBpdA0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieSB1c3VhbGx5IG1lYW5zIHlv
dSBlaXRoZXIgd3JvdGUgYSBzaWduaWZpY2FudA0KPiA+ID4gPiBhbW91bnQNCj4gPiA+ID4gb2YN
Cj4gPiA+ID4gdGhlIGRpZmZzdGF0IG9yIHlvdSB3ZXJlIHBhcnQgb2YgdGhlIHN1Ym1pc3Npb24g
cGF0aC4NCj4gPiA+IA0KPiA+ID4gSGUgZGlkIFtJIGRvbid0IG9iamVjdCB0byBidXQgd291bGRu
J3QgaGF2ZSB1c2VkIHRoZSBleHRyYQ0KPiA+ID4gYnJhY2tldHMNCj4gPiA+IHlvdQ0KPiA+ID4g
YnJvdWdodCB1cCA7LSkgXS4NCj4gPiANCj4gPiBZZXMsIEkgdGFrZSBhbGwgdGhlIGJsYW1lIGZv
ciB0aGUgZXh0cmEgYnJhY2tldHMuIFJlZ2FyZGxlc3Mgb2YNCj4gPiBoYXZpbmcNCj4gPiBhIG1h
c3RlcnMgaW4gQ1Mgb3Igbm90IEkgc3RpbGwgcHJlZmVyIHRvbyBtYW55IHRoZW4gdG9vIGZldyBv
ZiB0aGVtDQo+ID4gKDstDQo+ID4gcCkuDQo+ID4gDQo+ID4gPiA+ID4gPiBNeSBndWVzcyBpcyB0
aGF0IHRoaXMgbGluZSBzaG91bGQgYmUgZHJvcHBlZCBhbmQgdGhlIFJCIGFuZA0KPiA+ID4gPiA+
ID4gVEINCj4gPiA+ID4gPiA+IHRhZ3MNCj4gPiA+ID4gPiA+IHNob3VsZCByZW1haW4/ICBJZiBp
dCB3YXMgcmV2aWV3ZWQgdG9vLCBwZXJoYXBzIGFuIEFCIHRvbz8NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBJJ20gT0sgZWl0aGVyIHdheSBhbmQgZG8gbm90IG5lZWQgYW55IGV4cGxpY2l0IGF1dGhv
cnNoaXAgdG8NCj4gPiA+ID4gPiBiZQ0KPiA+ID4gPiA+IGV4cHJlc3NlZCBmb3IgbWUuDQo+ID4g
PiA+IA0KPiA+ID4gPiBJbiB0aGlzIGluc3RhbmNlIEkgc3VnZ2VzdCBrZWVwaW5nIFJlcG9ydGVk
LWJ5IGFuZCBUZXN0ZWQtYnkuDQo+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBUZXN0ZWQtYnk6IE1h
cmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KPiA+ID4gPiA+ID4g
PiAtLS0NCj4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L3B3bV9ibC5jIHwg
MTcgKysrKysrKystLS0tLS0tLS0NCj4gPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvcHdtX2JsLmMNCj4gPiA+ID4g
PiA+ID4gYi9kcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9wd21fYmwuYw0KPiA+ID4gPiA+ID4gPiBp
bmRleCA5ZWU0YzFiNzM1YjIuLmUzYzIyYjc5ZmJjZCAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gLS0t
IGEvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvcHdtX2JsLmMNCj4gPiA+ID4gPiA+ID4gKysrIGIv
ZHJpdmVycy92aWRlby9iYWNrbGlnaHQvcHdtX2JsLmMNCj4gPiA+ID4gPiA+ID4gQEAgLTI5OSwx
NSArMjk5LDE0IEBAIHN0YXRpYyBpbnQNCj4gPiA+ID4gPiA+ID4gcHdtX2JhY2tsaWdodF9wYXJz
ZV9kdChzdHJ1Y3QNCj4gPiA+ID4gPiA+ID4gZGV2aWNlICpkZXYsDQo+ID4gPiA+ID4gPiA+ICAJ
CSAqIGludGVycG9sYXRpb24gYmV0d2VlbiBlYWNoIG9mIHRoZQ0KPiA+ID4gPiA+ID4gPiB2YWx1
ZXMNCj4gPiA+ID4gPiA+ID4gb2YNCj4gPiA+ID4gPiA+ID4gYnJpZ2h0bmVzcyBsZXZlbHMNCj4g
PiA+ID4gPiA+ID4gIAkJICogYW5kIGNyZWF0ZXMgYSBuZXcgcHJlLWNvbXB1dGVkIHRhYmxlLg0K
PiA+ID4gPiA+ID4gPiAgCQkgKi8NCj4gPiA+ID4gPiA+ID4gLQkJb2ZfcHJvcGVydHlfcmVhZF91
MzIobm9kZSwgIm51bS0NCj4gPiA+ID4gPiA+ID4gaW50ZXJwb2xhdGVkLQ0KPiA+ID4gPiA+ID4g
PiBzdGVwcyIsDQo+ID4gPiA+ID4gPiA+IC0JCQkJICAgICAmbnVtX3N0ZXBzKTsNCj4gPiA+ID4g
PiA+ID4gLQ0KPiA+ID4gPiA+ID4gPiAtCQkvKg0KPiA+ID4gPiA+ID4gPiAtCQkgKiBNYWtlIHN1
cmUgdGhhdCB0aGVyZSBpcyBhdCBsZWFzdCB0d28NCj4gPiA+ID4gPiA+ID4gZW50cmllcyBpbg0K
PiA+ID4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiA+ID4gLQkJICogYnJpZ2h0bmVzcy1sZXZlbHMg
dGFibGUsIG90aGVyd2lzZSB3ZQ0KPiA+ID4gPiA+ID4gPiBjYW4ndA0KPiA+ID4gPiA+ID4gPiBp
bnRlcnBvbGF0ZQ0KPiA+ID4gPiA+ID4gPiAtCQkgKiBiZXR3ZWVuIHR3byBwb2ludHMuDQo+ID4g
PiA+ID4gPiA+IC0JCSAqLw0KPiA+ID4gPiA+ID4gPiAtCQlpZiAobnVtX3N0ZXBzKSB7DQo+ID4g
PiA+ID4gPiA+ICsJCWlmICgob2ZfcHJvcGVydHlfcmVhZF91MzIobm9kZSwgIm51bS0NCj4gPiA+
ID4gPiA+ID4gaW50ZXJwb2xhdGVkLQ0KPiA+ID4gPiA+ID4gPiBzdGVwcyIsDQo+ID4gPiA+ID4g
PiA+ICsJCQkJCSAgJm51bV9zdGVwcykgPT0NCj4gPiA+ID4gPiA+ID4gMCkNCj4gPiA+ID4gPiA+
ID4gJiYNCj4gPiA+ID4gPiA+ID4gbnVtX3N0ZXBzKSB7DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IFRoaXMgaXMgcHJldHR5IHVnbHksIGFuZCBpc24ndCBpdCBzdWZmZXJpbmcgZnJvbSBvdmVy
LQ0KPiA+ID4gPiA+ID4gYnJhY2tldGluZz8gIE15DQo+ID4gPiA+ID4gPiBzdWdnZXN0aW9uIHdv
dWxkIGJlIHRvIGJyZWFrIG91dCB0aGUgaW52b2NhdGlvbiBvZg0KPiA+ID4gPiA+ID4gb2ZfcHJv
cGVydHlfcmVhZF91MzIoKSBmcm9tIHRoZSBpZiBhbmQgdGVzdCBvbmx5IHRoZQ0KPiA+ID4gPiA+
ID4gcmVzdWx0Lg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiAJCW9mX3Byb3BlcnR5X3JlYWRf
dTMyKG5vZGUsICJudW0taW50ZXJwb2xhdGVkLQ0KPiA+ID4gPiA+ID4gc3RlcHMiLCANCj4gPiA+
ID4gPiA+ICZudW1fc3RlcHMpOw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IHlvdSBtZWFuOg0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IAkJcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91MzIobm9kZSwgIm51
bS0NCj4gPiA+ID4gPiBpbnRlcnBvbGF0ZWQtDQo+ID4gPiA+ID4gc3RlcHMiLCAmbnVtX3N0ZXBz
KTsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IAkJaWYgKCFyZXQgJiYgbnVtX3N0ZXBzKSB7DQo+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEkgaGF2ZW4ndCBjaGVja2VkIHRoZSB1bmRlcmxpbmcg
Y29kZSwgYnV0IGlzIGl0IGV2ZW4NCj4gPiA+ID4gPiA+IGZlYXNpYmxlDQo+ID4gPiA+ID4gPiBm
b3INCj4gPiA+ID4gPiA+IG9mX3Byb3BlcnR5X3JlYWRfdTMyKCkgdG8gbm90IHN1Y2NlZWQgQU5E
IGZvciBudW1fc3RlcHMgdG8NCj4gPiA+ID4gPiA+IGJlDQo+ID4gPiA+ID4gPiBzZXQ/DQo+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+IElmIG5vdCwgdGhlIGNoZWNrIGZvciAhcmV0IGlmIHN1cGVy
Zmx1b3VzIGFuZCB5b3UgY2FuIGRyb3ANCj4gPiA+ID4gPiA+IGl0Lg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IE5vLCB0aGVuIHdlIGFyZSBiYWNrIHRvIHRoZSBpbml0aWFsIGlzc3VlIG9mIG51bV9z
dGVwcw0KPiA+ID4gPiA+IHBvdGVudGlhbGx5IG5vdA0KPiA+ID4gPiA+IGJlaW5nIGluaXRpYWxp
c2VkLiBXZSByZWFsbHkgd2FudCBib3RoIG9mX3Byb3BlcnR5X3JlYWRfdTMyKCkNCj4gPiA+ID4g
PiB0bw0KPiA+ID4gPiA+IHN1Y2NlZWQgQU5EIG51bV9zdGVwcyB0byBhY3R1YWxseSBiZSBzZXQu
DQo+ID4gPiA+IA0KPiA+ID4gPiBJIGFsc28gdGhpbmsgbnVtX3N0ZXBzIHNob3VsZCBiZSBwcmUt
aW5pdGlhbGlzZWQuDQo+ID4gDQo+ID4gWWVzLCBJIGd1ZXNzIGl0IGRlZmluaXRlbHkgZG9lcyBu
b3QgaHVydC4NCj4gPiANCj4gPiA+ID4gVGhlbiBpdCB3aWxsIG9ubHkgYmUgc2V0IGlmIG9mX3By
b3BlcnR5X3JlYWRfdTMyKCkgc3VjY2VlZHMuDQo+ID4gDQo+ID4gWWVzLCBidXQgd2Ugc3RpbGwg
bmVlZCB0byBjaGVjayBmb3IgYm90aCwgdGhlIGZ1bmN0aW9uIG5vdCBmYWlsaW5nDQo+ID4gYW5k
DQo+ID4gbnVtX3N0ZXBzIHRvIGFjdHVhbGx5IGJlIG5vbiB6ZXJvLg0KPiANCj4gV2h5PyAgWW91
IGRvbid0IGRvIGFueXRoaW5nIGRpZmZlcmVudGx5IGlmIGl0IGZhaWxzLg0KDQpXZWxsLCBtYXli
ZSB3ZSBzaG91bGQgYnV0IGdpdmVuIHRoaXMgYmVpbmcgYW4gb3B0aW9uYWwgcHJvcGVydHkgbm9i
b2R5DQpjYXJlZC4=
