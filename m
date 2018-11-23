Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89B2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E56520685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="NwaA1noO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E56520685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503616AbeKWVuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:50:17 -0500
Received: from mail-eopbgr1410095.outbound.protection.outlook.com ([40.107.141.95]:4752
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731891AbeKWVuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q50M5t2rEPED3BL0OLQ401ROkEBQcpBtYlzfbqtQTrI=;
 b=NwaA1noOfmuBa28Mlg6XUI6JBh5v0Vfh0R0+h0cE5Jv4IUnsf3kYkLZNxmrvDsBiFnA4MpfVZ/iJQgyPHSbRQAECXuIZ1vBWIz4o06yuIVb8J4fxBBs3JbGGojBosN8XQxR2RS+UayOwYPXkP8cdM08waJ066WBsRqjde4Ph0uY=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1738.jpnprd01.prod.outlook.com (52.133.163.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Fri, 23 Nov 2018 11:06:22 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6%5]) with mapi id 15.20.1294.048; Fri, 23 Nov 2018
 11:06:22 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] pinctrl: rzn1: Fix check for used MDIO bus
Thread-Topic: [PATCH] pinctrl: rzn1: Fix check for used MDIO bus
Thread-Index: AQHUgCOKwJ2xop+DoEaLvwVyl7+lsaVdIPwAgAAAkiCAAAlFgIAADbMg
Date:   Fri, 23 Nov 2018 11:06:22 +0000
Message-ID: <TY1PR01MB1769EDCA6858BAEA3A18FB0AF5D40@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181119161838.10610-1-phil.edworthy@renesas.com>
 <CAMuHMdU2ski3S4FhD5kOhtzxvpin8M5MoYwK7X5gqYZ+HoL0DA@mail.gmail.com>
 <TY1PR01MB1769DE254148618373F2918CF5D40@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAMuHMdUUjoUmA2R8=PXp-hvYvowb3L-dnP6EDcGkLZJG344Yug@mail.gmail.com>
In-Reply-To: <CAMuHMdUUjoUmA2R8=PXp-hvYvowb3L-dnP6EDcGkLZJG344Yug@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1738;20:2ye4bRY19COsVYIRfIQ8CXKsquYdqt6HaI/qPS8o6U6rZHRdfBYOTRU17aRUTO7Kyw2gyj5iSp7e1J+itYy7F1FovJZ9YDyKUB6pDcNsOzw6hGFK469gHPPqUgGt4sgNFcdKh3Uu5B9DeaEgp0U7ovMymDvctgzRu8SKRTNOGpA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 58430bca-a50b-4420-02fa-08d65133b42e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1738;
x-ms-traffictypediagnostic: TY1PR01MB1738:
x-microsoft-antispam-prvs: <TY1PR01MB1738C8D53DC161DFEF195C67F5D40@TY1PR01MB1738.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1738;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1738;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(39840400004)(396003)(346002)(189003)(199004)(97736004)(5660300001)(4326008)(229853002)(6436002)(6916009)(74316002)(7736002)(305945005)(6246003)(53936002)(478600001)(55016002)(25786009)(33656002)(2900100001)(105586002)(9686003)(106356001)(14454004)(66066001)(6116002)(316002)(53546011)(44832011)(7696005)(486006)(446003)(3846002)(11346002)(476003)(68736007)(8936002)(81156014)(93886005)(8676002)(54906003)(81166006)(99286004)(102836004)(76176011)(6506007)(26005)(71200400001)(71190400001)(14444005)(256004)(86362001)(186003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1738;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: d7/HGCDZfYkh9F+INpM2WQtYhopErBoJPWPDLFknG1srHkO7iBiPFJEuhxWA4CNcHEn7CNa6KON5f+1ySgSonYIZjz7moqJKSRb6R3VWk+CZBW6JqMnrpxJFxM5IMe7KZAYLfQuNhy8eYss5Pkwi4draQ9YgAIp/yFJAyQ6rjb6dFMIL5cT9iIsqSULJ25QuMvpMPRrdiFeWspzakE7Fl4rxpDtSifMa+8P3SdVjX6ZlwjgRhbfU7TucehmIzwhmI8YHdXz/8dwW0oTmMFhxivns0ggr2a35QuFhy431gHY5VydrLGmIniwXK98dUmxCrw3EqIfOj9eeR+UWZ7LKAic38Z5Zld9SxRle8N7XoGM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58430bca-a50b-4420-02fa-08d65133b42e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 11:06:22.5098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDIzIE5vdmVtYmVyIDIwMTggMTA6MTYgR2VlcnQgVXl0dGVyaG9ldmVu
IHdyb3RlOg0KPiBPbiBGcmksIE5vdiAyMywgMjAxOCBhdCAxMTowNyBBTSBQaGlsIEVkd29ydGh5
IHdyb3RlOg0KPiA+IE9uIDIzIE5vdmVtYmVyIDIwMTggMDk6NDEgR2VlcnQgVXl0dGVyaG9ldmVu
IHdyb3RlOg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gcGluY3RybDogcnpuMTogRml4IGNo
ZWNrIGZvciB1c2VkIE1ESU8gYnVzIE9uDQo+ID4gPiBNb24sIE5vdiAxOSwgMjAxOCBhdCA1OjE4
IFBNIFBoaWwgRWR3b3J0aHkgd3JvdGU6DQo+ID4gPiA+IFRoaXMgZml4ZXMgdGhlIGNoZWNrIGZv
ciB1bnVzZWQgbWRpbyBidXMgc2V0dGluZyBhbmQgdGhlIGZvbGxvd2luZw0KPiA+ID4gPnN0YXRp
YyBjaGVja2VyIHdhcm5pbmc6DQo+ID4gPiA+ICBkcml2ZXJzL3BpbmN0cmwvcGluY3RybC1yem4x
LmM6MTk4IHJ6bjFfcGluY3RybF9tZGlvX3NlbGVjdCgpDQo+ID4gPiA+ICB3YXJuOiBhbHdheXMg
dHJ1ZSBjb25kaXRpb24gJyhpcGN0bC0+bWRpb19mdW5jW21kaW9dID49IDApID0+DQo+ID4gPiA+
KDAtdTMybWF4ID0gMCknDQo+ID4gPiA+DQo+ID4gPiA+IEl0IGFsc28gZml4ZXMgdGhlIHJldHVy
biB2YXIgd2hlbiBjYWxsaW5nIG9mX2dldF9jaGlsZF9jb3VudCgpDQo+ID4gPg0KPiA+ID4gSSB0
aGluayB0aGlzIHNob3VsZCBiZSBhIHNlcGFyYXRlIHBhdGNoLg0KPiA+IE9rLCBJJ2xsIHNwbGl0
IHRoZW0uDQo+IA0KPiBUaGFua3MhDQo+IA0KPiA+ID4gQlRXLCBJIGhhdmUgYSBxdWVzdGlvbiBh
Ym91dCByem4xX3BpbmN0cmxfbWRpb19zZWxlY3QoKToNCj4gPiA+DQo+ID4gPiBzdGF0aWMgdm9p
ZCByem4xX3BpbmN0cmxfbWRpb19zZWxlY3Qoc3RydWN0IHJ6bjFfcGluY3RybCAqaXBjdGwsIGlu
dCBtZGlvLA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHUzMiBm
dW5jKSB7DQo+ID4gPiAgICAgICAgIGlmIChpcGN0bC0+bWRpb19mdW5jW21kaW9dID49IDAgJiYg
aXBjdGwtPm1kaW9fZnVuY1ttZGlvXSAhPSBmdW5jKQ0KPiA+ID4gICAgICAgICAgICAgICAgIGRl
dl93YXJuKGlwY3RsLT5kZXYsICJjb25mbGljdGluZyBzZXR0aW5nIGZvciBtZGlvJWQhXG4iLCBt
ZGlvKTsNCj4gPiA+ICAgICAgICAgaXBjdGwtPm1kaW9fZnVuY1ttZGlvXSA9IGZ1bmM7DQo+ID4g
Pg0KPiA+ID4gICAgICAgICBkZXZfZGJnKGlwY3RsLT5kZXYsICJzZXR0aW5nIG1kaW8lZCB0byAl
dVxuIiwgbWRpbywgZnVuYyk7DQo+ID4gPg0KPiA+ID4gICAgICAgICB3cml0ZWwoZnVuYywgJmlw
Y3RsLT5sZXYyLT5sMl9tZGlvW21kaW9dKTsgfQ0KPiA+ID4NCj4gPiA+IFRoZSBjaGVjayB3YXJu
cyB0aGUgdXNlciBpZiBpdCBvdmVycmlkZXMgYW4gYWxyZWFkeSBpbml0aWFsaXplZCBNRElPDQo+
ID4gPiBmdW5jdGlvbiB3aXRoIGEgZGlmZmVyZW50IHZhbHVlLg0KPiA+ID4gSG93ZXZlciwgdGhl
cmUgaXMgbm8gbWV0aG9kIHRvIHVuaW5pdGlhbGl6ZSAocmVzZXQgdG8gLTEpDQo+ID4gPiBtZGlv
X2Z1bmNbXSwgdG8gYXZvaWQgZ2V0dGluZyB0aGUgd2FybmluZy4NCj4gPiA+DQo+ID4gPiBGb3Ig
YSB1c2UgY2FzZSwgSSB3YXMgdGhpbmtpbmcgYWJvdXQgYSBEVCBvdmVybGF5IHRoYXQgd291bGQg
Y2F1c2UNCj4gPiA+IHRoZSBNRElPIGZ1bmN0aW9uIHRvIGJlIGluaXRpYWxpemVkIG9uIGxvYWRp
bmcsIGFuZCBuZWVkcyB0bw0KPiA+ID4gdW5pbml0aWFsaXplIHRoZSBNRElPIGZ1bmN0aW9uIG9u
IHJlbW92aW5nLg0KPiA+ID4NCj4gPiA+IFBlcmhhcHMgdGhhdCBpcyB2ZXJ5IHVubGlrZWx5IG9y
IGV2ZW4gaW1wb3NzaWJsZSwgZ2l2ZW4gdGhlIGZ1bmN0aW9uDQo+ID4gPiBvZiB0aGUgcGlucyBj
b250cm9sbGVkIGJ5IHRoZSBNRElPIGZ1bmN0aW9uPw0KPiA+IEkgaGFkbid0IGNvbnNpZGVyZWQg
dGhhdCBEVCBvdmVybGF5IHBvc3NpYmlsaXR5Li4uDQo+ID4gU2luY2UgdGhpcyBNRElPIG11eGlu
ZyBzZWxlY3RzIG9uZSBvZiBzZXZlcmFsIGRpZmZlcmVudCBJUCBibG9ja3MgYXMNCj4gPiB0aGUg
TURJTyBtYXN0ZXIsIEkgZ3Vlc3MgaXQgY291bGQgaGFwcGVuLiBIb3dldmVyLCB0aGlzIGlzIHBy
ZXR0eSB1bmxpa2VseSENCj4gPg0KPiA+IEkgY2FuJ3Qgc2VlIGFueSB3YXkgdmlhIHRoZSBwaW5j
dHJsX29wcyBvciBwaW5jb25mX29wcyB0byAndW5kbycgYSBwaW4NCj4gPiBzZXR0aW5nLCBob3cg
d291bGQgdGhpcyB3b3JrPw0KPiANCj4gQWN0dWFsbHkgdGhlIHBpbmN0cmwgY29yZSB3b3VsZG4n
dCB1bmRvIHRoZSBjb25maWd1cmF0aW9uIG9uIERUIG92ZXJsYXkNCj4gdW5sb2FkLCBidXQgd291
bGQganVzdCBkbyB0aGUgbmV3IGNvbmZpZ3VyYXRpb24gd2hlbiBsb2FkaW5nIHRoZSBuZXcgRFQN
Cj4gb3ZlcmxheS4NCj4gSGVuY2UgdGhhdCB3b3VsZCBwcmludCB0aGUgd2FybmluZywgYnV0IHdv
cmsgcmVnYXJkbGVzcy4NCj4gT25seSBmb3IgR1BJT3MgdGhlcmUgd291bGQgYmUgYW4gdW5kbyBz
dGVwIChmcmVlaW5nIHRoZSByZXF1ZXN0ZWQgR1BJTykuDQo+IA0KPiA+IElmIGEgRFQgb3Zlcmxh
eSBjYXVzZXMgcmVtb3ZlKCkgdGhlbiBwcm9iZSgpIHRvIGJlIGNhbGxlZCBhZ2FpbiwgdGhlDQo+
ID4gZHJpdmVyIHJlc2V0cyBtZGlvX2Z1bmNbXSBpbiBwcm9iZSgpLCBzbyBpdCdsbCB3b3JrLg0K
PiANCj4gVHlwaWNhbGx5IGEgRFQgb3ZlcmxheSB3b3VsZCBvbmx5IGNvbnRyb2wgSS9PIGRldmlj
ZXMsIG5vdCB0aGUgYWN0dWFsIHBpbmN0cmwNCj4gZGV2aWNlLCBzbyB0aGUgcGluIGNvbnRyb2xs
ZXIgZHJpdmVyJ3MgLnByb2JlKCkgd291bGRuJ3QgYmUgY2FsbGVkLg0KPiANCj4gQnV0IEkgYWdy
ZWUgaXQncyB1bmxpa2VseSBhbmQgcmFyZSwgYW5kIHdvdWxkIHN0aWxsIHdvcmsuIEFuZCBwcm9i
YWJseSB5b3UgZG8NCj4gd2FudCB0byBrZWVwIHRoZSB3YXJuaW5nLiAgRFQgb3ZlcmxheXMgYXJl
IHN0aWxsIGV4cGVyaW1lbnRhbCwgYXMgdGhlcmUncyBubw0KPiB1cHN0cmVhbSBzdXBwb3J0IGZv
ciBsb2FkaW5nIGEgcmFuZG9tIERUIG92ZXJsYXkgYXQgcnVudGltZS4NCg0KT2ssIEknbGwgbGVh
dmUgaXQgYXMgaXQgaXMgdGhlbi4gSWYgaXQgZXZlciBiZWNvbWVzIGFuIGlzc3VlLCB3ZSBjYW4g
bG9vayBhZ2Fpbi4NCg0KVGhhbmtzDQpQaGlsDQoNCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVy
aG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51
eC0NCj4gbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNo
bmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFs
a2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcg
bGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRv
cnZhbGRzDQo=
