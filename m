Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D53C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3642086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hLCX0F9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfARHl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:41:56 -0500
Received: from mail-eopbgr130085.outbound.protection.outlook.com ([40.107.13.85]:43648
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727300AbfARHl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rATWuc/5ysEeQvqqXuT6R0jeIHrZwri5/uyTrM/iEo=;
 b=hLCX0F9ZpwTZmFVbehxnSHgS7wPr9DqnJXc8xGt23706lOHiUFh8qu4Vt/sBlRcSGwkPVapqXWNik4dIGCC0VC9Kb1AviX2XhakpxfN+f+I1anahKB51jNmpdBHZQ1kd4NRGiNwPnL5LGME333+FA7PcX2oEpoNt5roKYBUjeGE=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 18 Jan 2019 07:41:49 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::6d0a:7236:6fac:6fd6]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::6d0a:7236:6fac:6fd6%3]) with mapi id 15.20.1516.019; Fri, 18 Jan 2019
 07:41:49 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>
Subject: RE: [PATCH] dma: imx-sdma: pass ->dev to dma_alloc_coherent() API
Thread-Topic: [PATCH] dma: imx-sdma: pass ->dev to dma_alloc_coherent() API
Thread-Index: AQHUqbobsjeXIYA2Z066CXfEtEyuRKW0rn+Q
Date:   Fri, 18 Jan 2019 07:41:49 +0000
Message-ID: <VI1PR04MB45432C704ED13C4A3004EE9E899C0@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <20190111142930.21193-1-daniel.baluta@nxp.com>
In-Reply-To: <20190111142930.21193-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4333;6:STOxQaLm1OhslVHBprfQ1QTzLkYEFYvY22W0MfdiHFZe7ioGZkJAADeykAq4k3sPruxbcjIzDJdxfxSfQKUnnbK6PWKqs5AshYPO7/HhBydrLsFSXBOwO/0WWMqjD4oL+l9+87NI9YjyRhbjZVuBN1wVlenNpt6pFobd1LSXrPGiG3xU1XdUW6FuPdK4B6l9dinO644Kc9uySS75/26nrvToplEJJuGt3TXGQVM2z8gh5+xPRyCOAKB8xKCLPTrqswvAsyjFS+cgaff1OAIOlqDrv7bwQ90IHaxO3KefLwGdxiFJRZWar8GqStNZyGk7NErJaGKTPI23mu90lzFTqjRayDiAXMH8b1nCbD5pyNuzz5Mt4bi24EPL52qaDvdzBMREH1GQXta6V4FSVoal6TeRnAA74b7Dd8gLtlvAUW/mkPHON0wwVXYcIw28g2OZTKDajyxKBftxYjDAgJbvAg==;5:7G2tuqrbeH+G9b+J7imax6isMzze9IN6kgE/7AcRdyhZK5kTyTuMgYIMSqaffVX87XPrF2GVw0C8HRqIcXQqEWjx2U123Rg7YCL0hqxneRDGXVDOnbcftVB8TMI+Ik6gIfpqL/jL6dpDk6WL5pP4woJDz1qWcAMnbv7PFrdtVBEnxdmOoUY63TPfe7geblgc6zFO51SZjP0Rs1VBlR/drg==;7:UCyP1wYjs1Rs1mZWwA1NjuCVgkoZxmpPI7y2iVOiew27l03us6qOlu5hob3HEM8BtEN9c0KQYQsoLwvOEGA91JtKbebuuETWUwfs7CqqCUBtt0X5i0QyV0xZAGnQKdzXfUDocYpe1JbsDlAPa3THHQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4e4b7bd8-ba24-4ccd-2a4d-08d67d1867f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4333;
x-ms-traffictypediagnostic: VI1PR04MB4333:
x-microsoft-antispam-prvs: <VI1PR04MB433372BA436CD515F7FAF02C899C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(366004)(376002)(39860400002)(13464003)(199004)(189003)(53546011)(102836004)(6246003)(81166006)(478600001)(105586002)(7696005)(7736002)(186003)(76176011)(106356001)(68736007)(2501003)(305945005)(4326008)(81156014)(8676002)(86362001)(6506007)(26005)(2906002)(8936002)(66066001)(2201001)(110136005)(5660300001)(55016002)(6436002)(3846002)(99286004)(25786009)(97736004)(486006)(14444005)(6116002)(229853002)(9686003)(476003)(71190400001)(446003)(14454004)(11346002)(316002)(71200400001)(33656002)(256004)(54906003)(53936002)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4333;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cAnrI4rApR6826Dzso1dmHvGy+hQSkCD0jsrUscDMFU0BxGlgKirDFOYYZl5ntqs7wwCxLp4QkGWN4oWg7heRGqOtk75nzhHd5nKwOiZzrwTNzZrej9lrtBZEIZpVwjS432MGQ52enqAnzpujRBhQqyyiFi1fxEe2ZqIigIuUbURAM1W1jpt5RgXRFMJf8J9bPpgi5FvvvRk6i+HG8gLiPsGrknU7RTEXHbMAgyAtQpnRYeofp3JE6cWeL8VgWyoLbJYbPJ/4uD9bExX2KlvVpm7rQ2CDz1yEFOkqgwd0aJQSImz3bW7TxzPCW5E9ww8T5W5+Gfs/LoloynQeoxHA20gS2qUeM/ZjFrZPDBxjmbyCRS6XM4yYzWPaSwe+HHA5PKXmRw1ZSaFpSEsMFMRZTRaYBFvL2aT40CgZsiWPak=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4b7bd8-ba24-4ccd-2a4d-08d67d1867f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 07:41:49.4886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4333
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIEJhbHV0YQ0KPiBTZW50OiAyMDE5xOox
1MIxMcjVIDIyOjMwDQo+IFRvOiB2a291bEBrZXJuZWwub3JnOyBkbWFlbmdpbmVAdmdlci5rZXJu
ZWwub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsga2VybmVsQHBl
bmd1dHJvbml4LmRlOw0KPiBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IFMuai4gV2FuZw0KPiA8c2hlbmdqaXUud2FuZ0BueHAuY29tPjsgQW5k
eSBEdWFuIDxmdWdhbmcuZHVhbkBueHAuY29tPjsgUm9iaW4gR29uZw0KPiA8eWliaW4uZ29uZ0Bu
eHAuY29tPjsgRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPg0KPiBTdWJqZWN0
OiBbUEFUQ0hdIGRtYTogaW14LXNkbWE6IHBhc3MgLT5kZXYgdG8gZG1hX2FsbG9jX2NvaGVyZW50
KCkgQVBJDQo+IA0KPiBGcm9tOiBBbmR5IER1YW4gPGZ1Z2FuZy5kdWFuQG54cC5jb20+DQo+IA0K
PiBQYXNzIC0+ZGV2IHRvIGRtYV9hbGxvY19jb2hlcmVudCgpIEFQSS4gV2UgbmVlZCB0aGlzIGJl
Y2FzZQ0KPiBkbWFfYWxsb2NfY29oZXJlbnQoKSBtYWtlcyB1c2Ugb2YgZGV2IHBhcmFtZXRlciBh
bmQgcmVjZWl2aW5nIE5VTEwgd2lsbA0KPiByZXN1bHQgaW4gYSBjcmFzaC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEFuZHkgRHVhbiA8ZnVnYW5nLmR1YW5AbnhwLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZG1hL2lteC1zZG1hLmMgfCAxNSArKysrKysrKy0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9kbWEvaW14LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMgaW5kZXgNCj4gYTJi
MGEwZTcxMTY4Li4yNjEzM2I3OGNlZDggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZG1hL2lteC1z
ZG1hLmMNCj4gKysrIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KPiBAQCAtNjc3LDcgKzY3Nyw3
IEBAIHN0YXRpYyBpbnQgc2RtYV9sb2FkX3NjcmlwdChzdHJ1Y3Qgc2RtYV9lbmdpbmUNCj4gKnNk
bWEsIHZvaWQgKmJ1ZiwgaW50IHNpemUsDQo+ICAJaW50IHJldDsNCj4gIAl1bnNpZ25lZCBsb25n
IGZsYWdzOw0KPiANCj4gLQlidWZfdmlydCA9IGRtYV9hbGxvY19jb2hlcmVudChOVUxMLCBzaXpl
LCAmYnVmX3BoeXMsIEdGUF9LRVJORUwpOw0KPiArCWJ1Zl92aXJ0ID0gZG1hX2FsbG9jX2NvaGVy
ZW50KHNkbWEtPmRldiwgc2l6ZSwgJmJ1Zl9waHlzLA0KPiBHRlBfS0VSTkVMKTsNCj4gIAlpZiAo
IWJ1Zl92aXJ0KSB7DQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiAgCX0NCj4gQEAgLTY5Niw3ICs2
OTYsNyBAQCBzdGF0aWMgaW50IHNkbWFfbG9hZF9zY3JpcHQoc3RydWN0IHNkbWFfZW5naW5lDQo+
ICpzZG1hLCB2b2lkICpidWYsIGludCBzaXplLA0KPiANCj4gIAlzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZzZG1hLT5jaGFubmVsXzBfbG9jaywgZmxhZ3MpOw0KPiANCj4gLQlkbWFfZnJlZV9jb2hl
cmVudChOVUxMLCBzaXplLCBidWZfdmlydCwgYnVmX3BoeXMpOw0KPiArCWRtYV9mcmVlX2NvaGVy
ZW50KHNkbWEtPmRldiwgc2l6ZSwgYnVmX3ZpcnQsIGJ1Zl9waHlzKTsNCj4gDQo+ICAJcmV0dXJu
IHJldDsNCj4gIH0NCj4gQEAgLTExODIsNyArMTE4Miw3IEBAIHN0YXRpYyBpbnQgc2RtYV9yZXF1
ZXN0X2NoYW5uZWwwKHN0cnVjdA0KPiBzZG1hX2VuZ2luZSAqc2RtYSkgIHsNCj4gIAlpbnQgcmV0
ID0gLUVCVVNZOw0KPiANCj4gLQlzZG1hLT5iZDAgPSBkbWFfemFsbG9jX2NvaGVyZW50KE5VTEws
IFBBR0VfU0laRSwgJnNkbWEtPmJkMF9waHlzLA0KPiArCXNkbWEtPmJkMCA9IGRtYV96YWxsb2Nf
Y29oZXJlbnQoc2RtYS0+ZGV2LCBQQUdFX1NJWkUsDQo+ICZzZG1hLT5iZDBfcGh5cywNCj4gIAkJ
CQkJR0ZQX05PV0FJVCk7DQo+ICAJaWYgKCFzZG1hLT5iZDApIHsNCj4gIAkJcmV0ID0gLUVOT01F
TTsNCj4gQEAgLTEyMDUsOCArMTIwNSw4IEBAIHN0YXRpYyBpbnQgc2RtYV9hbGxvY19iZChzdHJ1
Y3Qgc2RtYV9kZXNjICpkZXNjKQ0KPiAgCXUzMiBiZF9zaXplID0gZGVzYy0+bnVtX2JkICogc2l6
ZW9mKHN0cnVjdCBzZG1hX2J1ZmZlcl9kZXNjcmlwdG9yKTsNCj4gIAlpbnQgcmV0ID0gMDsNCj4g
DQo+IC0JZGVzYy0+YmQgPSBkbWFfemFsbG9jX2NvaGVyZW50KE5VTEwsIGJkX3NpemUsICZkZXNj
LT5iZF9waHlzLA0KPiAtCQkJCQlHRlBfTk9XQUlUKTsNCj4gKwlkZXNjLT5iZCA9IGRtYV96YWxs
b2NfY29oZXJlbnQoZGVzYy0+c2RtYWMtPnNkbWEtPmRldiwgYmRfc2l6ZSwNCj4gKwkJCQkgICAg
ICAgJmRlc2MtPmJkX3BoeXMsIEdGUF9OT1dBSVQpOw0KPiAgCWlmICghZGVzYy0+YmQpIHsNCj4g
IAkJcmV0ID0gLUVOT01FTTsNCj4gIAkJZ290byBvdXQ7DQo+IEBAIC0xMjE5LDcgKzEyMTksOCBA
QCBzdGF0aWMgdm9pZCBzZG1hX2ZyZWVfYmQoc3RydWN0IHNkbWFfZGVzYyAqZGVzYykNCj4gew0K
PiAgCXUzMiBiZF9zaXplID0gZGVzYy0+bnVtX2JkICogc2l6ZW9mKHN0cnVjdCBzZG1hX2J1ZmZl
cl9kZXNjcmlwdG9yKTsNCj4gDQo+IC0JZG1hX2ZyZWVfY29oZXJlbnQoTlVMTCwgYmRfc2l6ZSwg
ZGVzYy0+YmQsIGRlc2MtPmJkX3BoeXMpOw0KPiArCWRtYV9mcmVlX2NvaGVyZW50KGRlc2MtPnNk
bWFjLT5zZG1hLT5kZXYsIGJkX3NpemUsIGRlc2MtPmJkLA0KPiArCQkJICBkZXNjLT5iZF9waHlz
KTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgdm9pZCBzZG1hX2Rlc2NfZnJlZShzdHJ1Y3QgdmlydF9k
bWFfZGVzYyAqdmQpIEBAIC0xODQyLDcgKzE4NDMsNw0KPiBAQCBzdGF0aWMgaW50IHNkbWFfaW5p
dChzdHJ1Y3Qgc2RtYV9lbmdpbmUgKnNkbWEpDQo+ICAJLyogQmUgc3VyZSBTRE1BIGhhcyBub3Qg
c3RhcnRlZCB5ZXQgKi8NCj4gIAl3cml0ZWxfcmVsYXhlZCgwLCBzZG1hLT5yZWdzICsgU0RNQV9I
X0MwUFRSKTsNCj4gDQo+IC0Jc2RtYS0+Y2hhbm5lbF9jb250cm9sID0gZG1hX2FsbG9jX2NvaGVy
ZW50KE5VTEwsDQo+ICsJc2RtYS0+Y2hhbm5lbF9jb250cm9sID0gZG1hX2FsbG9jX2NvaGVyZW50
KHNkbWEtPmRldiwNCj4gIAkJCU1BWF9ETUFfQ0hBTk5FTFMgKiBzaXplb2YgKHN0cnVjdCBzZG1h
X2NoYW5uZWxfY29udHJvbCkgKw0KPiAgCQkJc2l6ZW9mKHN0cnVjdCBzZG1hX2NvbnRleHRfZGF0
YSksDQo+ICAJCQkmY2NiX3BoeXMsIEdGUF9LRVJORUwpOw0KPiAtLQ0KPiAyLjE3LjENCg0K
