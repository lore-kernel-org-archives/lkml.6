Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA406ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7546F20652
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="XgU0qsGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7546F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbeGRNfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:35:03 -0400
Received: from mail-eopbgr30094.outbound.protection.outlook.com ([40.107.3.94]:57520
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726258AbeGRNfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tm4YtI3jJ8OJuPGCQCa3DXTTAr5YCmQPjk0g/ULkENk=;
 b=XgU0qsGB1ddN+i1Q4S9t0MtLA95Q0G8l1K3CU2AuFYeWO/SSFnX914lM0x0mqPceoLlNYsJahWWglrqSDZB7rMgu4B1rJgB8qHBq0q6Uk3lFFtHpsfDMO5an+VdO/azhYDapjrJa3i6GQdL+M4kh56NsBcvVYlAdfQu5pk6bczE=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2351.eurprd05.prod.outlook.com (10.169.135.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Wed, 18 Jul 2018 12:57:08 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e%8]) with mapi id 15.20.0973.016; Wed, 18 Jul 2018
 12:57:08 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "patches@linaro.org" <patches@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Thread-Topic: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Thread-Index: AQHUHUhtmsif0KNc40KlPUM2WKHIC6SUoqmAgAADkYCAABmYgIAABUWAgAAuAQA=
Date:   Wed, 18 Jul 2018 12:57:08 +0000
Message-ID: <1531918626.16896.22.camel@toradex.com>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
         <20180718080913.GB4641@dell> <1531902119.16896.13.camel@toradex.com>
         <20180718095335.GD4641@dell> <20180718101227.shqf54wpt4kdrsj2@holly.lan>
In-Reply-To: <20180718101227.shqf54wpt4kdrsj2@holly.lan>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2351;7:1AfEPlJytASAG2yM1mVEyl+9Tb/XwthXdmAlDFNwOIxU3Y0EUKV8jbvacrYEAZN79gZqZTr2pGyiHVDezPmbNXg9V1sT31ABHkMX+PV4J5JWEcL7PeVnmh9Anq/bnzskRGP2cGL+yjzB8xWWng3X6svYVWi2j12plvE75qXQuGaGFmYCx66Xkm+XDp71JA31ueoEz1oaOsBCXsa3c2KXLOVhdVK/t5MsUsGRazwMz8fRGG6Vp/QTwdlR3EkiAybw
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 47aea903-5e86-46b1-a519-08d5ecadf8ad
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2351;
x-ms-traffictypediagnostic: VI1PR0501MB2351:
x-microsoft-antispam-prvs: <VI1PR0501MB2351C7681CC9CF4B17A18E2BFB530@VI1PR0501MB2351.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(148322886591682)(81227570615382)(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2351;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2351;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39840400004)(376002)(346002)(366004)(199004)(189003)(476003)(68736007)(11346002)(186003)(102836004)(6512007)(446003)(26005)(2616005)(2501003)(6246003)(39060400002)(6116002)(3846002)(97736004)(305945005)(53936002)(2900100001)(256004)(5250100002)(76176011)(7736002)(2906002)(486006)(99286004)(66066001)(6506007)(103116003)(81156014)(316002)(106356001)(93886005)(81166006)(105586002)(86362001)(25786009)(7416002)(54906003)(8676002)(36756003)(44832011)(229853002)(4326008)(110136005)(478600001)(5660300001)(8936002)(14454004)(6486002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2351;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OfFocd8Y9Hsj3BeIK2Mk51KXddSGG8PvyBlQX7vW3j6hhtXPlLvsEyoDOvlsWMYb3moGKmz6fTZT8mlqJ0f/vHTdgNe6A+ptH+GZ+YMukaLFxEgykPYTHbPjHjP8TwzZwiemx4W//oP7q3wsSY4usYl0aSQ3QqP6K7g15oHKMhk0p77GIrAwxP11QEAqxgtKaF6UmUiUIPDi1th2MM7B93rv8VJpOaF9V92NhSlyY0DZvyRijsonBy5V/LjyqUcg9gVdqP9SpGfJPb9vTMzlpkPLOtXS8kG8vJGNI0IIbQQkjPOZmdSNGhNri3GMRiq/Fi/H8SwCzI0O+5Kt9v1KpneECF9UK3oNSLEooQLNgrI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <86CFB1BC0835954B8309CFE36E11BA92@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47aea903-5e86-46b1-a519-08d5ecadf8ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 12:57:08.7249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2351
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA3LTE4IGF0IDExOjEyICswMTAwLCBEYW5pZWwgVGhvbXBzb24gd3JvdGU6
DQo+IE9uIFdlZCwgSnVsIDE4LCAyMDE4IGF0IDEwOjUzOjM1QU0gKzAxMDAsIExlZSBKb25lcyB3
cm90ZToNCj4gPiBPbiBXZWQsIDE4IEp1bCAyMDE4LCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+
ID4gDQo+ID4gPiBPbiBXZWQsIDIwMTgtMDctMTggYXQgMDk6MDkgKzAxMDAsIExlZSBKb25lcyB3
cm90ZToNCj4gPiA+ID4gT24gTW9uLCAxNiBKdWwgMjAxOCwgRGFuaWVsIFRob21wc29uIHdyb3Rl
Og0KPiA+ID4gPiANCj4gPiA+ID4gPiBDdXJyZW50bHksIGlmIHRoZSBEVCBkb2VzIG5vdCBkZWZp
bmUgbnVtLWludGVycG9sYXRlZC1zdGVwcw0KPiA+ID4gPiA+IHRoZW4NCj4gPiA+ID4gPiBudW1f
c3RlcHMgaXMgdW5kZWZpbmVkIGFuZCB0aGUgaW50ZXJwb2xhdGlvbiBjb2RlIHdpbGwgZGVwbG95
DQo+ID4gPiA+ID4gcmFuZG9tbHkuDQo+ID4gPiA+ID4gRml4IHRoaXMuDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gRml4ZXM6IDU3M2ZlNmQxYzI1YyAoImJhY2tsaWdodDogcHdtX2JsOiBMaW5lYXIg
aW50ZXJwb2xhdGlvbg0KPiA+ID4gPiA+IGJldHdlZW4NCj4gPiA+ID4gPiBicmlnaHRuZXNzLWxl
dmVscyIpDQo+ID4gPiA+ID4gUmVwb3J0ZWQtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnpp
c3dpbGVyQHRvcmFkZXguY29tPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBUaG9t
cHNvbiA8ZGFuaWVsLnRob21wc29uQGxpbmFyby5vcmc+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4gPiA+
IA0KPiA+ID4gPiBUaGlzIGxpbmUgaXMgY29uZnVzaW5nLiAgRGlkIHlvdSBndXlzIGF1dGhvciB0
aGlzIHBhdGNoDQo+ID4gPiA+IHRvZ2V0aGVyPw0KPiA+ID4gDQo+ID4gPiBZZXMsIEkgcmVwb3J0
ZWQgaXQgYW5kIHdlIGNhbWUgdG8gYSBjb25jbHVzaW9uIHRvZ2V0aGVyLg0KPiA+IA0KPiA+IEl0
IHNvdW5kcyBsaWtlIHlvdSBuZWVkIHRvIGhhdmUgYWxsIG9mIHRoZSB0YWdzIChleGNlcHQgdGhp
cyBvbmUpLg0KPiA+IDopDQo+ID4gDQo+ID4gIFJlcG9ydGVkLWJ5OiAgZm9yIHJlcG9ydGluZyB0
aGUgaXNzdWUNCj4gPiAgU3VnZ2VzdGVkLWJ5OiBmb3Igc3VnZ2VzdGluZyBhIHJlc29sdXRpb24N
Cj4gPiAgQWNrZWQtYnk6ICAgICBmb3IgcmV2aWV3aW5nIGl0DQo+ID4gIFRlc3RlZC1ieTogICAg
Zm9yIHRlc3RpbmcgaXQNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5IHVzdWFsbHkgbWVhbnMgeW91
IGVpdGhlciB3cm90ZSBhIHNpZ25pZmljYW50IGFtb3VudA0KPiA+IG9mDQo+ID4gdGhlIGRpZmZz
dGF0IG9yIHlvdSB3ZXJlIHBhcnQgb2YgdGhlIHN1Ym1pc3Npb24gcGF0aC4NCj4gDQo+IEhlIGRp
ZCBbSSBkb24ndCBvYmplY3QgdG8gYnV0IHdvdWxkbid0IGhhdmUgdXNlZCB0aGUgZXh0cmEgYnJh
Y2tldHMNCj4geW91DQo+IGJyb3VnaHQgdXAgOy0pIF0uDQoNClllcywgSSB0YWtlIGFsbCB0aGUg
YmxhbWUgZm9yIHRoZSBleHRyYSBicmFja2V0cy4gUmVnYXJkbGVzcyBvZiBoYXZpbmcNCmEgbWFz
dGVycyBpbiBDUyBvciBub3QgSSBzdGlsbCBwcmVmZXIgdG9vIG1hbnkgdGhlbiB0b28gZmV3IG9m
IHRoZW0gKDstDQpwKS4NCg0KPiA+ID4gPiBNeSBndWVzcyBpcyB0aGF0IHRoaXMgbGluZSBzaG91
bGQgYmUgZHJvcHBlZCBhbmQgdGhlIFJCIGFuZCBUQg0KPiA+ID4gPiB0YWdzDQo+ID4gPiA+IHNo
b3VsZCByZW1haW4/ICBJZiBpdCB3YXMgcmV2aWV3ZWQgdG9vLCBwZXJoYXBzIGFuIEFCIHRvbz8N
Cj4gPiA+IA0KPiA+ID4gSSdtIE9LIGVpdGhlciB3YXkgYW5kIGRvIG5vdCBuZWVkIGFueSBleHBs
aWNpdCBhdXRob3JzaGlwIHRvIGJlDQo+ID4gPiBleHByZXNzZWQgZm9yIG1lLg0KPiA+IA0KPiA+
IEluIHRoaXMgaW5zdGFuY2UgSSBzdWdnZXN0IGtlZXBpbmcgUmVwb3J0ZWQtYnkgYW5kIFRlc3Rl
ZC1ieS4NCj4gPiANCj4gPiA+ID4gPiBUZXN0ZWQtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2Vs
Lnppc3dpbGVyQHRvcmFkZXguY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBkcml2ZXJz
L3ZpZGVvL2JhY2tsaWdodC9wd21fYmwuYyB8IDE3ICsrKysrKysrLS0tLS0tLS0tDQo+ID4gPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L3B3
bV9ibC5jDQo+ID4gPiA+ID4gYi9kcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9wd21fYmwuYw0KPiA+
ID4gPiA+IGluZGV4IDllZTRjMWI3MzViMi4uZTNjMjJiNzlmYmNkIDEwMDY0NA0KPiA+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L3B3bV9ibC5jDQo+ID4gPiA+ID4gKysrIGIv
ZHJpdmVycy92aWRlby9iYWNrbGlnaHQvcHdtX2JsLmMNCj4gPiA+ID4gPiBAQCAtMjk5LDE1ICsy
OTksMTQgQEAgc3RhdGljIGludA0KPiA+ID4gPiA+IHB3bV9iYWNrbGlnaHRfcGFyc2VfZHQoc3Ry
dWN0DQo+ID4gPiA+ID4gZGV2aWNlICpkZXYsDQo+ID4gPiA+ID4gIAkJICogaW50ZXJwb2xhdGlv
biBiZXR3ZWVuIGVhY2ggb2YgdGhlIHZhbHVlcw0KPiA+ID4gPiA+IG9mDQo+ID4gPiA+ID4gYnJp
Z2h0bmVzcyBsZXZlbHMNCj4gPiA+ID4gPiAgCQkgKiBhbmQgY3JlYXRlcyBhIG5ldyBwcmUtY29t
cHV0ZWQgdGFibGUuDQo+ID4gPiA+ID4gIAkJICovDQo+ID4gPiA+ID4gLQkJb2ZfcHJvcGVydHlf
cmVhZF91MzIobm9kZSwgIm51bS0NCj4gPiA+ID4gPiBpbnRlcnBvbGF0ZWQtDQo+ID4gPiA+ID4g
c3RlcHMiLA0KPiA+ID4gPiA+IC0JCQkJICAgICAmbnVtX3N0ZXBzKTsNCj4gPiA+ID4gPiAtDQo+
ID4gPiA+ID4gLQkJLyoNCj4gPiA+ID4gPiAtCQkgKiBNYWtlIHN1cmUgdGhhdCB0aGVyZSBpcyBh
dCBsZWFzdCB0d28NCj4gPiA+ID4gPiBlbnRyaWVzIGluDQo+ID4gPiA+ID4gdGhlDQo+ID4gPiA+
ID4gLQkJICogYnJpZ2h0bmVzcy1sZXZlbHMgdGFibGUsIG90aGVyd2lzZSB3ZQ0KPiA+ID4gPiA+
IGNhbid0DQo+ID4gPiA+ID4gaW50ZXJwb2xhdGUNCj4gPiA+ID4gPiAtCQkgKiBiZXR3ZWVuIHR3
byBwb2ludHMuDQo+ID4gPiA+ID4gLQkJICovDQo+ID4gPiA+ID4gLQkJaWYgKG51bV9zdGVwcykg
ew0KPiA+ID4gPiA+ICsJCWlmICgob2ZfcHJvcGVydHlfcmVhZF91MzIobm9kZSwgIm51bS0NCj4g
PiA+ID4gPiBpbnRlcnBvbGF0ZWQtDQo+ID4gPiA+ID4gc3RlcHMiLA0KPiA+ID4gPiA+ICsJCQkJ
CSAgJm51bV9zdGVwcykgPT0gMCkNCj4gPiA+ID4gPiAmJg0KPiA+ID4gPiA+IG51bV9zdGVwcykg
ew0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBpcyBwcmV0dHkgdWdseSwgYW5kIGlzbid0IGl0IHN1
ZmZlcmluZyBmcm9tIG92ZXItDQo+ID4gPiA+IGJyYWNrZXRpbmc/ICBNeQ0KPiA+ID4gPiBzdWdn
ZXN0aW9uIHdvdWxkIGJlIHRvIGJyZWFrIG91dCB0aGUgaW52b2NhdGlvbiBvZg0KPiA+ID4gPiBv
Zl9wcm9wZXJ0eV9yZWFkX3UzMigpIGZyb20gdGhlIGlmIGFuZCB0ZXN0IG9ubHkgdGhlIHJlc3Vs
dC4NCj4gPiA+ID4gDQo+ID4gPiA+IAkJb2ZfcHJvcGVydHlfcmVhZF91MzIobm9kZSwgIm51bS1p
bnRlcnBvbGF0ZWQtDQo+ID4gPiA+IHN0ZXBzIiwgDQo+ID4gPiA+ICZudW1fc3RlcHMpOw0KPiA+
ID4gDQo+ID4gPiB5b3UgbWVhbjoNCj4gPiA+IA0KPiA+ID4gCQlyZXQgPSBvZl9wcm9wZXJ0eV9y
ZWFkX3UzMihub2RlLCAibnVtLWludGVycG9sYXRlZC0NCj4gPiA+IHN0ZXBzIiwgJm51bV9zdGVw
cyk7DQo+ID4gPiANCj4gPiA+ID4gCQlpZiAoIXJldCAmJiBudW1fc3RlcHMpIHsNCj4gPiA+ID4g
DQo+ID4gPiA+IEkgaGF2ZW4ndCBjaGVja2VkIHRoZSB1bmRlcmxpbmcgY29kZSwgYnV0IGlzIGl0
IGV2ZW4gZmVhc2libGUNCj4gPiA+ID4gZm9yDQo+ID4gPiA+IG9mX3Byb3BlcnR5X3JlYWRfdTMy
KCkgdG8gbm90IHN1Y2NlZWQgQU5EIGZvciBudW1fc3RlcHMgdG8gYmUNCj4gPiA+ID4gc2V0Pw0K
PiA+ID4gPiANCj4gPiA+ID4gSWYgbm90LCB0aGUgY2hlY2sgZm9yICFyZXQgaWYgc3VwZXJmbHVv
dXMgYW5kIHlvdSBjYW4gZHJvcCBpdC4NCj4gPiA+IA0KPiA+ID4gTm8sIHRoZW4gd2UgYXJlIGJh
Y2sgdG8gdGhlIGluaXRpYWwgaXNzdWUgb2YgbnVtX3N0ZXBzDQo+ID4gPiBwb3RlbnRpYWxseSBu
b3QNCj4gPiA+IGJlaW5nIGluaXRpYWxpc2VkLiBXZSByZWFsbHkgd2FudCBib3RoIG9mX3Byb3Bl
cnR5X3JlYWRfdTMyKCkgdG8NCj4gPiA+IHN1Y2NlZWQgQU5EIG51bV9zdGVwcyB0byBhY3R1YWxs
eSBiZSBzZXQuDQo+ID4gDQo+ID4gSSBhbHNvIHRoaW5rIG51bV9zdGVwcyBzaG91bGQgYmUgcHJl
LWluaXRpYWxpc2VkLg0KDQpZZXMsIEkgZ3Vlc3MgaXQgZGVmaW5pdGVseSBkb2VzIG5vdCBodXJ0
Lg0KDQo+ID4gVGhlbiBpdCB3aWxsIG9ubHkgYmUgc2V0IGlmIG9mX3Byb3BlcnR5X3JlYWRfdTMy
KCkgc3VjY2VlZHMuDQoNClllcywgYnV0IHdlIHN0aWxsIG5lZWQgdG8gY2hlY2sgZm9yIGJvdGgs
IHRoZSBmdW5jdGlvbiBub3QgZmFpbGluZyBhbmQNCm51bV9zdGVwcyB0byBhY3R1YWxseSBiZSBu
b24gemVyby4NCg0KPiA+IC0tIA0KPiA+IExlZSBKb25lcyBb5p2O55C85pavXQ0KPiA+IExpbmFy
byBTZXJ2aWNlcyBUZWNobmljYWwgTGVhZA0KPiA+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNl
IHNvZnR3YXJlIGZvciBBUk0gU29Dcw0KPiA+IEZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdp
dHRlciB8IEJsb2c=
