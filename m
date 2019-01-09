Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A952BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D88F20652
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Y6Z1fT0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfAILhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:37:25 -0500
Received: from mail-eopbgr130139.outbound.protection.outlook.com ([40.107.13.139]:62688
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730111AbfAILhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAalFn861qDG0kSiTqVPf2yVqsW/Ab8NVmJFvoVZtsg=;
 b=Y6Z1fT0vfheTZgYnlevbCMz/dTu7Z97qQ8NoBEWCGQ2at62sq2Twgfw1ncboF9qUkBualCBk21Bpg80WEYX39aZf1sElKiOB+ixyGE/ImwzvR935ysGYfUPoykwwtjU+6aA28i8KGXrUyjTVPWjc7CZB7VPNyk1SRQMXEsKdpb8=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6SPR01MB0047.eurprd02.prod.outlook.com (20.178.87.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Wed, 9 Jan 2019 11:37:20 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.010; Wed, 9 Jan 2019
 11:37:19 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] drm/atmel-hlcdc: prevent divide by zero
Thread-Topic: [PATCH] drm/atmel-hlcdc: prevent divide by zero
Thread-Index: AQHUp04YoDtjtNas+0efeF6OnACb7KWmuQUAgAAXtgA=
Date:   Wed, 9 Jan 2019 11:37:19 +0000
Message-ID: <9b73f5fa-e5c2-ea55-8d96-be6de8a1f34a@axentia.se>
References: <20190108123129.20031-1-peda@axentia.se>
 <20190109101224.GT21184@phenom.ffwll.local>
In-Reply-To: <20190109101224.GT21184@phenom.ffwll.local>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0330.eurprd05.prod.outlook.com
 (2603:10a6:7:92::25) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6SPR01MB0047;6:rz0aFzGvYtgGOpVkEoAVDZZagngOuteg1To4JRQIxfi+Ozn+Jgp4nkMJR+aOQIOoLyTUy95zMzYHMQG1XOE+eSCr81edlT+HN/LsktChLhv3gP7eQ2cJQoCRJ+kPb4zOXJVb2acbWv0FvlzQulfZWRRZt5CArKkHmn8Rb3gF6EEcGq66LR/RfQ0sEkgzKLe2iGx6xapnx9tTETpBR7F7gPZOIdH0w0Diqd/KdhSoZ4zANHpqGp8jttqbg1s5NOUXHyhCRT8XdCfNTeg2FRwErkHkCcCLvtZ/r+by5xoKLVTMMX3ZhMurmspseqCCOLDgpA9bzWNRAhEW6xQMlvTPd8cLr34NwJaJguOQ3onfdWUnBYiX6B85OZ97ir0rzeW72yIcbZPB5SX1SK5DSPP08XATt5Pj7bACyyDdpKdW8eLbdjpqP/dG45bsiLC5OkZOTVxzEapCArJN0t6aC7z/Sw==;5:YGe0duJJKccr3y/Ghe8HEVm7IUErz7xGiltTj9fRKsFzP1jZNjzvwagxbj7Z8ShbG2nwgelBgvEmbs+SwdcqQP/mQYyJjyCMiwqNuQfSCxoY25bQTeTBFRCq7/uFpRor+qcGYal3QogeMN+qdbdBQeawFXKPG3f97s6YVt277P6163AMKtFoPmGv97H8ETnPuEXQR/Q3hf70xE6x7asGsw==;7:7rDE+TPOrd+UN97R3sWTXu0mDUtjL5gZO485NlZ8rzwsZLbcie81SW5POn8dXocXWdngDVfOb82ooewkTI0zraD9Hmu2vBKaAYs1s9Ja1SPWk8wcpHNYLI9DjwNntb0WhUGa5JnsS29desyl8vW3/g==
x-ms-office365-filtering-correlation-id: bf483fa5-9247-4852-c436-08d67626d06c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6SPR01MB0047;
x-ms-traffictypediagnostic: AM6SPR01MB0047:
x-microsoft-antispam-prvs: <AM6SPR01MB0047CDDAD533659DC0B46875BC8B0@AM6SPR01MB0047.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM6SPR01MB0047;BCL:0;PCL:0;RULEID:;SRVR:AM6SPR01MB0047;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39830400003)(396003)(366004)(376002)(189003)(199004)(26005)(102836004)(186003)(446003)(8676002)(53936002)(7736002)(476003)(305945005)(8936002)(36756003)(81156014)(81166006)(66066001)(65806001)(11346002)(71190400001)(71200400001)(65956001)(2616005)(31696002)(316002)(86362001)(105586002)(74482002)(2906002)(31686004)(110136005)(2501003)(6512007)(106356001)(14444005)(97736004)(256004)(52116002)(76176011)(6246003)(53546011)(64126003)(386003)(58126008)(6506007)(65826007)(68736007)(3846002)(6116002)(99286004)(486006)(25786009)(5660300001)(6436002)(229853002)(14454004)(508600001)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6SPR01MB0047;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4KV0K5WVK78BcBh9kSmQIq+f5CQI3dpyi+Hq0RcIsaSo1avKyKEUnJyoDKB3S3/6XksBHALPlkRy2tS8ItFqcnJlIKw6qBil8zvVLhjCJvBvC89BJkYRmFXHWK8pZMo/M9/gsyoQBpY6kuW3XqfRWelgR0o27vdYHyuBc7f/V5WDjRHTLqeI2DXN9TEGFGnSBYeqLMQVDyoHiG3bw1iRIOxEbSftjx/zKHiQ8u/pb5bcXiUmTI7xvQHJ9c7LpNWIjc2EoTajYsQAroTbKMFjjYykUfUOBGKhw66amIdvPnbF+L+/aAPTrW+7aom0vscR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA3B1F688464474AABF0CC5D81CB3628@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: bf483fa5-9247-4852-c436-08d67626d06c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 11:37:18.8881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6SPR01MB0047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMS0wOSAxMToxMiwgRGFuaWVsIFZldHRlciB3cm90ZToNCj4gT24gVHVlLCBKYW4g
MDgsIDIwMTkgYXQgMTI6MzE6MzZQTSArMDAwMCwgUGV0ZXIgUm9zaW4gd3JvdGU6DQo+PiBXaGls
ZSB0cnlpbmcgdG8gdGVtcG9yYXJpbHkgaGlkZSBhIHBsYW5lLCBvbmUgdGhpbmcgdGhhdCB3YXMg
YXR0ZW1wdGVkDQo+PiB3YXMgdG8gY2FsbCAoZnJvbSBsaWJkcm0pDQo+Pg0KPj4gCWRybU1vZGVT
ZXRQbGFuZShmZCwgcGxhbmVfaWQsIGNydGNfaWQsIGZiX2lkLCAwLA0KPj4gCQkJMCwgMCwgMCwg
MCwgMCwgMCwgMCwgMCk7DQo+Pg0KPj4gVGhpcyBjYWxsIGNhdXNlcyBhIHBhaXIgb2YgIkRpdmlz
aW9uIGJ5IHplcm8gaW4ga2VybmVsLiIgbWVzc2FnZXMuIEtpbGwNCj4+IHRob3NlIG1lc3NhZ2Vz
LCBidXQgcHJlc2VydmUgdGhlIGN1cnJlbnQgYmVoYXZpb3VyIHRoYXQgYWxzbyBoYXBwZW4gdG8N
Cj4+IG1ha2UgdGhlIHBsYW5lIGRpc2FwcGVhciB3aXRoIHRoZSBhYm92ZSBjYWxsLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+DQo+PiAtLS0NCj4+
ICBkcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfcGxhbmUuYyB8IDE0ICsr
KysrKysrKystLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+Pg0KPj4gU2lkZSBub3RlLCB3aGVuIGNvbXBhcmluZyB3aXRoIGRybV9hdG9t
aWNfaGVscGVyX2NoZWNrX3BsYW5lX3N0YXRlKCksIEkgZ2V0DQo+PiB0aGUgZmVlbGluZyB0aGF0
IHRoZSBzcmMgcmVjdCBzaG91bGQgYmUgY2xpcHBlZCB0b2dldGhlciB3aXRoIHRoZSBjcnRjIHJl
Y3QNCj4+IGlmL3doZW4gY2xpcHBpbmcgaXMgbmVlZGVkLiBUaGF0IGZ1bmN0aW9uIGNhbGxzIGRy
bV9yZWN0X2NsaXBfc2NhbGVkKCksIGFuZA0KPj4gdGhlIGVxdWl2YWxlbnQgZG9lcyBub3Qgc2Vl
bSB0byBoYXBwZW4gaGVyZS4gU2hvdWxkIGNsaXBwaW5nIGJlIHBlcmZvcm1lZA0KPj4gb24gdGhl
IHNyYyByZWN0Pw0KPiANCj4gQW55IHJlYXNvbnMgYXRtZWwgY2FuJ3Qgc3dpdGNoIG92ZXIgdG8g
dGhhdCBoZWxwZXI/IFdvdWxkIGNvbXB1dGUgYSBuaWNlDQo+IC0+dmlzaWJsZSBzdGF0ZSB2YXJp
YWJsZSBmb3IgeW91IC4uLg0KPiAtRGFuaWVsDQoNCkkgaGF2ZSBub3QgcmVzZWFyY2hlZCB0aGF0
LCBhbmQgYXMgc3RhdGVkIGFib3ZlLCBJIHdhcyBub3Qgc3VyZSBpZiB0aGF0IHdhcyB0aGUNCmNv
cnJlY3QgYXBwcm9hY2ggdG8gYmVnaW4gd2l0aC4gQm9yaXMsIGFueSBpbnNpZ2h0cz8gRG9lcyB0
aGlzIGNvZGUgcHJlZGF0ZSB0aGUNCmhlbHBlciBvciBzb21ldGhpbmc/DQoNCk1heWJlIHRoZXJl
J3Mgc29tZSByZWdpc3RlciBiaXQgdGhhdCBoaWRlcyBhIHBsYW5lIGV4cGxpY2l0bHksIG1hdGNo
aW5nIHRoZQ0KLT52aXNpYmxlIHN0YXRlIHZhcmlhYmxlPyBJIGhhdmVuJ3QgbG9va2VkIGF0IHRo
YXQgZWl0aGVyLi4uDQoNCkNoZWVycywNClBldGVyDQo=
