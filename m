Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C9BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B3D20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="l13CZNi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B3D20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409241AbeKWUpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:45:01 -0500
Received: from mail-eopbgr1410132.outbound.protection.outlook.com ([40.107.141.132]:4152
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387971AbeKWUpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXuHeI22PdEHt53uOQw/CMqx+H/mwHgVLgvf+zZ8A9k=;
 b=l13CZNi0XLA0mJBh6fRVWBnNrGO0vlOlSkUNcEvGWjC+uAGQnGdj0nIc8ww8frDBNxEqRd5QqpOaLToQx3Q75j06f8dj994caTUBvbSGvysGiNIw+bbqbOF6aueUpDiU3MpnjTpqWDeER55HulVdK+dqyBScAT3AM+VPZDr+asI=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1738.jpnprd01.prod.outlook.com (52.133.163.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Fri, 23 Nov 2018 10:01:23 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6%5]) with mapi id 15.20.1294.048; Fri, 23 Nov 2018
 10:01:22 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] pinctrl: rzn1: Fix check for used MDIO bus
Thread-Topic: [PATCH] pinctrl: rzn1: Fix check for used MDIO bus
Thread-Index: AQHUgCOKwJ2xop+DoEaLvwVyl7+lsaVdIPwAgAAAkiA=
Date:   Fri, 23 Nov 2018 10:01:22 +0000
Message-ID: <TY1PR01MB1769DE254148618373F2918CF5D40@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181119161838.10610-1-phil.edworthy@renesas.com>
 <CAMuHMdU2ski3S4FhD5kOhtzxvpin8M5MoYwK7X5gqYZ+HoL0DA@mail.gmail.com>
In-Reply-To: <CAMuHMdU2ski3S4FhD5kOhtzxvpin8M5MoYwK7X5gqYZ+HoL0DA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1738;20:N/J12mcnsXd2g/RpCuNBVKZADHgHg+nVGwyCeoAnow1kCSOt08hHazK0a3yhd8pfCW3jfqvUwBUABFNmPC3t0WIFlYawWkBRoe5y60PPqP7Pbw8m4Wlu4vKZ3Y7eK40n7wLCREOTEuw1Sl1mDZPgL1tcGAasTzB3JNwcX0o2MbE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7b434929-0c98-4708-ed38-08d6512a9fb6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1738;
x-ms-traffictypediagnostic: TY1PR01MB1738:
x-microsoft-antispam-prvs: <TY1PR01MB17388DEA5607DB4C13C8FC1BF5D40@TY1PR01MB1738.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1738;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1738;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(346002)(396003)(39850400004)(189003)(199004)(97736004)(5660300001)(4326008)(229853002)(6436002)(6916009)(33656002)(7736002)(305945005)(74316002)(6246003)(53936002)(478600001)(55016002)(25786009)(2900100001)(105586002)(106356001)(9686003)(14454004)(66066001)(6116002)(316002)(486006)(44832011)(7696005)(3846002)(446003)(476003)(11346002)(53546011)(68736007)(8936002)(81156014)(8676002)(54906003)(81166006)(99286004)(102836004)(76176011)(6506007)(26005)(71200400001)(71190400001)(14444005)(256004)(186003)(86362001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1738;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vBnR0Gq6dh5kAZwgKt53NWbrGSicr4lfXXXTSpA7tVFj7Mqjvc4Wrh/N0XNFcMOZBPxYvo9PdQDZcjF/pQ2WIDLV2+HkCskwhVodEzo7eWj9LcZ1KZYjtmx/pgGKOD6KWQJGZOPWi+9u6gRijidpMFJFLikQ645IVb+b6PDbJGK+n2powWu4BOCNtaq140wtQC4EfJLoXVb5m9uPtdHzi7E7vWErGo4ApsdFT+LIUYZQlkw/LC+bPIBiR+67ypFw7Bq1U1dF4dayMfbfZDJNEDoqdWquyPqwC9SZANKTMOfC4Hlz2nAHyW2+QUFzLeCjYIE3aFKkyErFAqL+qqFLbNNp9A56oOQmyekPTsTLcAk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b434929-0c98-4708-ed38-08d6512a9fb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 10:01:22.4752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDIzIE5vdmVtYmVyIDIwMTggMDk6NDEgR2VlcnQgVXl0dGVyaG9ldmVu
IHdyb3RlOg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBwaW5jdHJsOiByem4xOiBGaXggY2hlY2sg
Zm9yIHVzZWQgTURJTyBidXMNCj4gT24gTW9uLCBOb3YgMTksIDIwMTggYXQgNToxOCBQTSBQaGls
IEVkd29ydGh5IHdyb3RlOg0KPiA+IFRoaXMgZml4ZXMgdGhlIGNoZWNrIGZvciB1bnVzZWQgbWRp
byBidXMgc2V0dGluZyBhbmQgdGhlIGZvbGxvd2luZw0KPiA+IHN0YXRpYyBjaGVja2VyIHdhcm5p
bmc6DQo+ID4gIGRyaXZlcnMvcGluY3RybC9waW5jdHJsLXJ6bjEuYzoxOTggcnpuMV9waW5jdHJs
X21kaW9fc2VsZWN0KCkNCj4gPiAgd2FybjogYWx3YXlzIHRydWUgY29uZGl0aW9uICcoaXBjdGwt
Pm1kaW9fZnVuY1ttZGlvXSA+PSAwKSA9PiAoMC11MzJtYXgNCj4gPj0gMCknDQo+ID4NCj4gPiBJ
dCBhbHNvIGZpeGVzIHRoZSByZXR1cm4gdmFyIHdoZW4gY2FsbGluZyBvZl9nZXRfY2hpbGRfY291
bnQoKQ0KPiANCj4gSSB0aGluayB0aGlzIHNob3VsZCBiZSBhIHNlcGFyYXRlIHBhdGNoLg0KT2ss
IEknbGwgc3BsaXQgdGhlbS4NCg0KDQo+ID4gUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGRh
bi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaGlsIEVkd29ydGh5
IDxwaGlsLmVkd29ydGh5QHJlbmVzYXMuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5
dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+IA0KPiBCVFcsIEkgaGF2ZSBh
IHF1ZXN0aW9uIGFib3V0IHJ6bjFfcGluY3RybF9tZGlvX3NlbGVjdCgpOg0KPiANCj4gc3RhdGlj
IHZvaWQgcnpuMV9waW5jdHJsX21kaW9fc2VsZWN0KHN0cnVjdCByem4xX3BpbmN0cmwgKmlwY3Rs
LCBpbnQgbWRpbywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHUzMiBm
dW5jKSB7DQo+ICAgICAgICAgaWYgKGlwY3RsLT5tZGlvX2Z1bmNbbWRpb10gPj0gMCAmJiBpcGN0
bC0+bWRpb19mdW5jW21kaW9dICE9IGZ1bmMpDQo+ICAgICAgICAgICAgICAgICBkZXZfd2Fybihp
cGN0bC0+ZGV2LCAiY29uZmxpY3Rpbmcgc2V0dGluZyBmb3IgbWRpbyVkIVxuIiwgbWRpbyk7DQo+
ICAgICAgICAgaXBjdGwtPm1kaW9fZnVuY1ttZGlvXSA9IGZ1bmM7DQo+IA0KPiAgICAgICAgIGRl
dl9kYmcoaXBjdGwtPmRldiwgInNldHRpbmcgbWRpbyVkIHRvICV1XG4iLCBtZGlvLCBmdW5jKTsN
Cj4gDQo+ICAgICAgICAgd3JpdGVsKGZ1bmMsICZpcGN0bC0+bGV2Mi0+bDJfbWRpb1ttZGlvXSk7
IH0NCj4gDQo+IFRoZSBjaGVjayB3YXJucyB0aGUgdXNlciBpZiBpdCBvdmVycmlkZXMgYW4gYWxy
ZWFkeSBpbml0aWFsaXplZCBNRElPIGZ1bmN0aW9uDQo+IHdpdGggYSBkaWZmZXJlbnQgdmFsdWUu
DQo+IEhvd2V2ZXIsIHRoZXJlIGlzIG5vIG1ldGhvZCB0byB1bmluaXRpYWxpemUgKHJlc2V0IHRv
IC0xKSBtZGlvX2Z1bmNbXSwgdG8NCj4gYXZvaWQgZ2V0dGluZyB0aGUgd2FybmluZy4NCj4gDQo+
IEZvciBhIHVzZSBjYXNlLCBJIHdhcyB0aGlua2luZyBhYm91dCBhIERUIG92ZXJsYXkgdGhhdCB3
b3VsZCBjYXVzZSB0aGUgTURJTw0KPiBmdW5jdGlvbiB0byBiZSBpbml0aWFsaXplZCBvbiBsb2Fk
aW5nLCBhbmQgbmVlZHMgdG8gdW5pbml0aWFsaXplIHRoZSBNRElPDQo+IGZ1bmN0aW9uIG9uIHJl
bW92aW5nLg0KPiANCj4gUGVyaGFwcyB0aGF0IGlzIHZlcnkgdW5saWtlbHkgb3IgZXZlbiBpbXBv
c3NpYmxlLCBnaXZlbiB0aGUgZnVuY3Rpb24gb2YgdGhlDQo+IHBpbnMgY29udHJvbGxlZCBieSB0
aGUgTURJTyBmdW5jdGlvbj8NCkkgaGFkbid0IGNvbnNpZGVyZWQgdGhhdCBEVCBvdmVybGF5IHBv
c3NpYmlsaXR5Li4uDQpTaW5jZSB0aGlzIE1ESU8gbXV4aW5nIHNlbGVjdHMgb25lIG9mIHNldmVy
YWwgZGlmZmVyZW50IElQIGJsb2NrcyBhcyB0aGUNCk1ESU8gbWFzdGVyLCBJIGd1ZXNzIGl0IGNv
dWxkIGhhcHBlbi4gSG93ZXZlciwgdGhpcyBpcyBwcmV0dHkgdW5saWtlbHkhDQoNCkkgY2FuJ3Qg
c2VlIGFueSB3YXkgdmlhIHRoZSBwaW5jdHJsX29wcyBvciBwaW5jb25mX29wcyB0byAndW5kbycg
YSBwaW4NCnNldHRpbmcsIGhvdyB3b3VsZCB0aGlzIHdvcms/DQpJZiBhIERUIG92ZXJsYXkgY2F1
c2VzIHJlbW92ZSgpIHRoZW4gcHJvYmUoKSB0byBiZSBjYWxsZWQgYWdhaW4sIHRoZSBkcml2ZXIN
CnJlc2V0cyBtZGlvX2Z1bmNbXSBpbiBwcm9iZSgpLCBzbyBpdCdsbCB3b3JrLg0KDQpUaGFua3Mh
DQpQaGlsDQo=
