Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50D6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4BA26A10
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="VymKC8zO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4BA26A10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935055AbeFZLyj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:54:39 -0400
Received: from mail-sn1nam02on0044.outbound.protection.outlook.com ([104.47.36.44]:53906
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934962AbeFZLyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRqfKReMd9gX3eMOBTDAXox2waEeOma60rj1oCjkQFo=;
 b=VymKC8zONtCYDzQp93FiPJlKepmb3033dbZhaPciZ1lLBu3hIvXosgI5THZ889/nBaPscNCefbREU+yZbuw359MILYHyMAgBt5BbNfcu2L7Eu+kX3TrtNuPRDwPsbbgIXW2/hPt3/Lojbmev5byjICBc+kuhuWaZV+65YfAHsjk=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB457.namprd06.prod.outlook.com (10.141.196.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Tue, 26 Jun 2018 11:54:33 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::bd6c:9a47:d344:bbc3]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::bd6c:9a47:d344:bbc3%2]) with mapi id 15.20.0884.025; Tue, 26 Jun 2018
 11:54:32 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "hans.ml.holmberg@owltronix.com" <hans.ml.holmberg@owltronix.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH] lightnvm: pblk: assume that chunks are closed on 1.2
 devices
Thread-Topic: [PATCH] lightnvm: pblk: assume that chunks are closed on 1.2
 devices
Thread-Index: AQHUB6z6kgqdJ8jhqk2jGNQq1yO9haRyQ7cAgAAPiQCAABEKgIAADsIAgAADroCAAALPeQ==
Date:   Tue, 26 Jun 2018 11:54:32 +0000
Message-ID: <D165FE85-ED96-4E1E-85C3-D4C0C52B8E24@cnexlabs.com>
References: <1529399189-3239-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <a2bb1959-5244-f8af-b747-6d87e8d456a4@lightnvm.io>
 <1612C143-24C3-4B6F-B745-945EAF684DFC@cnexlabs.com>
 <ed909bcb-8e91-7e6d-521e-b5f36db61efa@lightnvm.io>
 <CANr-nt3Qzp-brMa16NAVa=E6eRCfpNyV44cmRoaxYUV0J7zStA@mail.gmail.com>,<4bcd22df-3899-fc87-d558-27754befae5e@lightnvm.io>
In-Reply-To: <4bcd22df-3899-fc87-d558-27754befae5e@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [2a02:aa7:4606:d0cf:f933:6bbe:6c67:de3d]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB457;7:lww0sVEhZJZu2AVuKN8QB448Ta7xFGH746A/k9ZcU1xGsFBG7IYybc5xifOF/etKPmTYW1DORTlx7zOOA8WFqGJHU+LIM+KRrZzM3LIMmK/Q2D7Gv0E6INM2ePHUxSH7+WJnRYnmXL1pdc/OkmP21/MmV2cavZa2HNqQYyQkqpQLg9e5TplPjd3sPVXvKT6zy8U6yKoR6PPHhw3bG9LgKEjUOb9jnbs20vbVKBNYQYsJ4R6/BAPOczCE43ud9UZ1
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(346002)(39840400004)(136003)(396003)(376002)(199004)(189003)(316002)(6436002)(5250100002)(6512007)(2900100001)(82746002)(6486002)(102836004)(53546011)(25786009)(6506007)(4326008)(186003)(83716003)(99286004)(14444005)(93886005)(46003)(76176011)(36756003)(229853002)(86362001)(54906003)(478600001)(97736004)(81166006)(105586002)(14454004)(8676002)(6116002)(81156014)(8936002)(68736007)(305945005)(7736002)(107886003)(6916009)(5660300001)(6246003)(2906002)(106356001)(53936002)(476003)(446003)(2616005)(33656002)(486006)(256004)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB457;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: c4f5baf3-729e-4eda-2954-08d5db5b94a7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR06MB457;
x-ms-traffictypediagnostic: CO2PR06MB457:
x-microsoft-antispam-prvs: <CO2PR06MB4573E025E21D55979960B39BA490@CO2PR06MB457.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB457;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB457;
x-forefront-prvs: 071518EF63
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XZK+KJrw8+VphISfp/TcUG6HXAAQPaBRxt76pa6pGmSwM3BVEfSqbuhKMJyPO1J3F5V+QFfHwZAu0WVYUybZ4heKRDWMZXiPK2xIU6dhahbGEADt3jAtwYIty1yDW01tuy5N5rBAIumN1Fs+73AmsSwOiqKtQmQqMiWChLLCrkfwzX/HV23edIvOQ/ee2sjuRXG0gw1xAJPYSMwUOPXbXO8YiMO2+Echu/WHANYH4RcETPeO/VIN/z+3lvG+BQwLg/aB87WviuP0589Ry2DOGuAWYMMR/aSJWiKG187ayMSm98lrIvV6T1av9g2f4pR1PjZjuwxaSMnSxe+cE6DTaM5h/mdQCu5uw5JenUjKOTQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f5baf3-729e-4eda-2954-08d5db5b94a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2018 11:54:32.3331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIDI2IEp1biAyMDE4LCBhdCAxMy40NCwgTWF0aWFzIEJqw7hybGluZyA8bWJAbGlnaHRu
dm0uaW8+IHdyb3RlOg0KPiANCj4+IE9uIDA2LzI2LzIwMTggMDE6MzEgUE0sIEhhbnMgSG9sbWJl
cmcgd3JvdGU6DQo+Pj4gT24gVHVlLCBKdW4gMjYsIDIwMTggYXQgMTozOCBQTSwgTWF0aWFzIEJq
w7hybGluZyA8bWJAbGlnaHRudm0uaW8+IHdyb3RlOg0KPj4+PiBPbiAwNi8yNi8yMDE4IDExOjM3
IEFNLCBKYXZpZXIgR29uemFsZXogd3JvdGU6DQo+Pj4+IA0KPj4+PiANCj4+Pj4gDQo+Pj4+PiBP
biAyNiBKdW4gMjAxOCwgYXQgMTAuNDEsIE1hdGlhcyBCasO4cmxpbmcgPG1iQGxpZ2h0bnZtLmlv
PiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gT24gMDYvMTkvMjAxOCAxMTowNiBBTSwgSGFucyBIb2xt
YmVyZyB3cm90ZToNCj4+Pj4+PiANCj4+Pj4+PiBGcm9tOiBIYW5zIEhvbG1iZXJnIDxoYW5zLmhv
bG1iZXJnQGNuZXhsYWJzLmNvbT4NCj4+Pj4+PiBXZSBjYW4ndCBrbm93IGlmIGEgYmxvY2sgaXMg
Y2xvc2VkIG9yIG5vdCBvbiAxLjIgZGV2aWNlcywgc28gYXNzdW1lDQo+Pj4+Pj4gY2xvc2VkIHN0
YXRlIHRvIG1ha2Ugc3VyZSB0aGF0IGJsb2NrcyBhcmUgZXJhc2VkIGJlZm9yZSB3cml0aW5nLg0K
Pj4+Pj4+IEZpeGVzOiAzMmVmOTQxMmMxMTQgKCJsaWdodG52bTogcGJsazogaW1wbGVtZW50IGdl
dCBsb2cgcmVwb3J0IGNodW5rIikNCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBIYW5zIEhvbG1iZXJn
IDxoYW5zLmhvbG1iZXJnQGNuZXhsYWJzLmNvbT4NCj4+Pj4+PiAtLS0NCj4+Pj4+PiBUaGlzIHBh
dGNoIGFwcGxpZXMgb246DQo+Pj4+Pj4gc3NoOi8vZ2l0aHViLmNvbS9PcGVuQ2hhbm5lbFNTRC9s
aW51eCBicmFuY2ggZm9yLTQuMTkvY29yZQ0KPj4+Pj4+ICAgZHJpdmVycy9saWdodG52bS9wYmxr
LWluaXQuYyB8IDUgKysrLS0NCj4+Pj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbGlnaHRudm0v
cGJsay1pbml0LmMgYi9kcml2ZXJzL2xpZ2h0bnZtL3BibGstaW5pdC5jDQo+Pj4+Pj4gaW5kZXgg
YWEyNDI2NC4uM2I4YWE0YSAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2xpZ2h0bnZtL3Bi
bGstaW5pdC5jDQo+Pj4+Pj4gKysrIGIvZHJpdmVycy9saWdodG52bS9wYmxrLWluaXQuYw0KPj4+
Pj4+IEBAIC03MTcsMTAgKzcxNywxMSBAQCBzdGF0aWMgaW50IHBibGtfc2V0dXBfbGluZV9tZXRh
XzEyKHN0cnVjdCBwYmxrDQo+Pj4+Pj4gKnBibGssIHN0cnVjdCBwYmxrX2xpbmUgKmxpbmUsDQo+
Pj4+Pj4gICAgICAgICAgICAgICAgIC8qDQo+Pj4+Pj4gICAgICAgICAgICAgICAgICAqIEluIDEu
MiBzcGVjLiBjaHVuayBzdGF0ZSBpcyBub3QgcGVyc2lzdGVkIGJ5IHRoZQ0KPj4+Pj4+IGRldmlj
ZS4gVGh1cw0KPj4+Pj4+IC0gICAgICAgICAgICAgICAgKiBzb21lIG9mIHRoZSB2YWx1ZXMgYXJl
IHJlc2V0IGVhY2ggdGltZSBwYmxrIGlzDQo+Pj4+Pj4gaW5zdGFudGlhdGVkLg0KPj4+Pj4+ICsg
ICAgICAgICAgICAgICAgKiBzb21lIG9mIHRoZSB2YWx1ZXMgYXJlIHJlc2V0IGVhY2ggdGltZSBw
YmxrIGlzDQo+Pj4+Pj4gaW5zdGFudGlhdGVkLA0KPj4+Pj4+ICsgICAgICAgICAgICAgICAgKiBz
byB3ZSBoYXZlIHRvIGFzc3VtZSB0aGF0IHRoZSBibG9jayBpcyBjbG9zZWQuDQo+Pj4+Pj4gICAg
ICAgICAgICAgICAgICAqLw0KPj4+Pj4+ICAgICAgICAgICAgICAgICBpZiAobHVuX2JiX21ldGFb
bGluZS0+aWRdID09IE5WTV9CTEtfVF9GUkVFKQ0KPj4+Pj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgIGNodW5rLT5zdGF0ZSA9ICBOVk1fQ0hLX1NUX0ZSRUU7DQo+Pj4+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgY2h1bmstPnN0YXRlID0gIE5WTV9DSEtfU1RfQ0xPU0VEOw0KPj4+Pj4+ICAg
ICAgICAgICAgICAgICBlbHNlDQo+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgY2h1bmst
PnN0YXRlID0gTlZNX0NIS19TVF9PRkZMSU5FOw0KPj4+Pj4+IA0KPj4+Pj4gDQo+Pj4+PiBwYmxr
IHNob3VsZCBzY2FuIChvciB0aGUgbGlnaHRudm0gc3Vic3lzdGVtKSB0aGUgYmxvY2tzIGZvciB0
aGVpcg0KPj4+Pj4gc3RhdGUsIHN1Y2ggdGhhdCBpdCBkb2Vzbid0IGhhdmUgdG8gcmVpbml0aWFs
aXplIGEgZnVsbCBkcml2ZSBpZiBpdCBpcw0KPj4+Pj4gYWxyZWFkeSBpbiBhIGNsb3NlZCBzdGF0
ZS4gSWYgbWFya2luZyBjbG9zZWQsIGl0IGRvZXMgYSBmdWxsIGVyYXNlDQo+Pj4+PiBjeWNsZSBv
biBpbml0aWFsaXphdGlvbiwgd2hpY2ggc2hvdWxkIGJlIGF2b2lkZWQgc2luY2UgaXQgaXMgYSBs
aW1pdGVkDQo+Pj4+PiByZXNvdXJjZS4NCj4+Pj4gDQo+Pj4+IA0KPj4+PiBJbiAxLjIgdGhlcmUg
aXMgbm8gc3VjaCBzdGF0ZSB1bmZvcnR1bmF0ZWx5LiBIb3dldmVyLCBwYmxrIHdpbGwgbmV2ZXIN
Cj4+Pj4gYXR0ZW1wdCB0byByZWluaXRpYWxpemUgdGhlIHdob2xlIGRyaXZlIC0gbWV0YWRhdGEg
Zm9yIGNsb3NlZCBibG9ja3MNCj4+Pj4gd2lsbCBiZSByZWNvdmVyZWQgYW5kIG9ubHkgdGhvc2Ug
Z29pbmcgdG8gR0Mgd2lsbCBiZSBlcmFzZWQgYmVmb3JlDQo+Pj4+IHVzYWdlLiBJbiBmYWN0LCBh
IGZ1bGwgY2xvc2UgZHJpdmUgaXMgdGhlIHN0YXRlIHBibGsgZXhwZWN0cy4NCj4+Pj4gDQo+Pj4+
IFRoaXMgcGF0Y2ggb25seSBhZmZlY3RzICJ1bmtub3duIGJsb2NrcyIsIHRodXMgdGhlIG9ubHkg
Y2FzZSBpbiB3aGljaA0KPj4+PiBwYmxrIHdvdWxkIGF0dGVtcHQgdG8gZG91YmxlIGVyYXNlIGlz
IHdoZW4gYmxvY2tzIGhhdmUgYmVlbiBwcmUtZXJhc2VkDQo+Pj4+IChlLmcuLCBmYWN0b3J5IG9y
IHRocm91Z2ggbGlibGlnaHRudm0pLiBBZnRlciBhbiBlcmFzZSByb3VuZCB0aG91Z2gsDQo+Pj4+
IHBibGsgd2lsbCBvbmx5IGVyYXNlIHByZS11c2FnZS4gT25lIHRoaW5nIHdlIGNvdWxkIGRvIGlz
IGF0dGVtcHRpbmcgdG8NCj4+Pj4gcmVhZCB0aGUgZmlyc3QgcGFnZSBvZiB0aGVzZSB1bmtub3du
IGJsb2NrcyBhbmQgbWFyayB0aGVtIGFzIGZyZWUgaWYNCj4+Pj4gImVtcHR5IHBhZ2UiIGlzIHJl
dHVybmVkLiBJcyB0aGlzIHdoYXQgeW91IG1lYW4/DQo+Pj4gDQo+Pj4gDQo+Pj4gWWVzLCB0aGF0
IGlzIHdoYXQgSSBtZWFuLg0KPj4+IA0KPj4+IE5vdGUgdGhhdCB0aGlzIGNhbiBiZQ0KPj4+PiAN
Cj4+Pj4gY29zdGx5IG9uIGxhcmdlIGRyaXZlczsgdGhpcyBpcyB0aGUgcmVhc29uIHdlIHJldHVy
bmVkIHRvIHRoZSBwcmUtMi4wDQo+Pj4+IGJlaGF2aW91ciB3aXRoIHRoaXMgcGF0Y2guIFdlIGFy
ZSBpbXBsZW1lbnRpbmcgYSBsb2cgdGhhdCwgYW1vbmcgb3RoZXINCj4+Pj4gdGhpbmdzLCBrZWVw
cyB0aGUgc3RhdGUgc28gdGhhdCBwYmxrIGNhbiBoYXZlIGFuIGFjY3VyYXRlIHN0YXRlIGZvciB0
aGUNCj4+Pj4gY2FzZXMgdGhpcyBjYW4gYmUgYSBwcm9ibGVtLg0KPj4+IA0KPj4+IA0KPj4+IFll
cCwgaXQgd2lsbCB0YWtlIHNvbWUgdGltZS4gR29vZCB0byBoZWFyIHdpdGggdGhlIGxvZy4NCj4+
IFVudGlsIHdlIGhhdmUgYSBsb2cgaW4gcGxhY2UsIHRoaXMgcGF0Y2ggdW5icmVha3MgMS4yIHN1
cHBvcnQgYW5kIGhhcw0KPj4gbm8gbmVnYXRpdmUgaW1wYWN0IG9uIHBlcmZvcm1hbmNlIChhcyBj
b21wYXJlZCB0byBwcmUgMi4wIHN1cHBvcnQpLCBzbw0KPj4gcGxlYXNlIGNvbnNpZGVyIGl0IGZv
ciB0aGUgbmV4dCB3aW5kb3cuDQo+PiBUaGUgY3VycmVudCBzdGF0ZSBpcyB0aGF0IGlmIGEgcGJs
ayBpbnN0YW5jZSBpcyBjcmVhdGVkIG9uIGEgMS4yIGRpc2sNCj4+IHdpdGggd3JpdHRlbiBibG9j
a3MsIHdyaXRlcyB3aWxsIGZhaWwuDQo+PiAgLyBIYW5zDQo+IA0KPiBUaGUgbmVnYXRpdmUgaW1w
YWN0IGlzIHRoYXQgYWxsIGJsb2NrcyBhcmUgZXJhc2VkLCBldmVuIGlmIHRoZXkgYXJlIGluIGZy
ZWUgc3RhdGUuIFRoaXMgaXMgYSBzaG93c3RvcHBlci4gV2UgY2Fubm90IHRocm93IG91dCAxL1gg
b2YgdGhlIGxpZmV0aW1lIG9mIHRoZSBkcml2ZSBvbiBlYWNoIGluaXRpYWxpemF0aW9uLiBUaGUg
MS4yIHNwZWMgaXMgbWFkZSBzdWNoIHRoYXQgYSBzY2FuIGNhbiByZWNvdmVyIHRoZSBibG9jayBz
dGF0ZSBhY2N1cmF0ZWx5Lg0KDQpUaGlzIGZpeGVzIHBhdGNoIHJldHVybnMgdG8gdGhlIG9yaWdp
bmFsIGJlaGF2aW9yLCBzbyBpdOKAmXMgbm90IGludHJvZHVjaW5nIGEgd29yc2UgYmVoYXZpb3Ig
dGhhbiBiZWZvcmUgMi4wLiBCdXQgeW914oCZcmUgcmlnaHQsIGl0IGlzIG5vdCB0aGUgd2F5IGl0
IHNob3VsZCBiZS4gDQoNCkNhbiB5b3UgY29uc2lkZXIgdGFraW5nIHRoaXMgYXMgYSBmaXggZm9y
IDQuMTggdG8gYXZvaWQgd3JpdGVzIGZhaWxpbmcgb24gMS4yIGRldmljZXMgYW5kIEkgcHJvbWlz
ZSB0byBzZW5kIGEgcGF0Y2ggdGhpcyB3ZWVrIHRvIGltcGxlbWVudCB0aGUgc3RhdGUgYmFzZWQg
b24gcmVhZHM/IFRoaXMgbmV3IHBhdGNoIHdvdWxkIGJlIGZvciA0LjE5LiANCg0KSmF2aWVy
