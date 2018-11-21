Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46A9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9BC214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rssk0z40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9BC214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbeKVDkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:40:32 -0500
Received: from mail-eopbgr30053.outbound.protection.outlook.com ([40.107.3.53]:64000
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726172AbeKVDkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CxzQmWsIjwwKpBdl4bFR6jr+IlHga+tsugI6ghyIeU=;
 b=rssk0z40ol4ynH8Okv5Dhll5vCh2R4Y2LoTeKjOJCApnYdgdgv4jGkiCqxf2JFBsqZ9Sk+p6gNUGyTAJ6aC3yn5MNbApeS4+Xw5wOhOiPqX5SuLCsQtmqtm9doNfp1ppaHEQX9AzL42lT/KAjeVn4XZZ1yOPvDu2CHsypbAuzQg=
Received: from VI1PR08MB3662.eurprd08.prod.outlook.com (20.177.61.89) by
 VI1PR08MB3837.eurprd08.prod.outlook.com (20.178.15.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Wed, 21 Nov 2018 17:04:57 +0000
Received: from VI1PR08MB3662.eurprd08.prod.outlook.com
 ([fe80::e828:653d:10db:ec36]) by VI1PR08MB3662.eurprd08.prod.outlook.com
 ([fe80::e828:653d:10db:ec36%6]) with mapi id 15.20.1294.045; Wed, 21 Nov 2018
 17:04:57 +0000
From:   Matt Sealey <Matt.Sealey@arm.com>
To:     "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
        Dave Rodgman <dave.rodgman@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        Sonny Rao <sonnyrao@google.com>
Subject: RE: [PATCH 0/6] lib/lzo: performance improvements
Thread-Topic: [PATCH 0/6] lib/lzo: performance improvements
Thread-Index: AQHUgZI88EDtuaHmFU63dmJG+DkKO6VaPZmAgAAjaiA=
Date:   Wed, 21 Nov 2018 17:04:57 +0000
Message-ID: <VI1PR08MB3662267AF55E8D0D9DE57858EEDA0@VI1PR08MB3662.eurprd08.prod.outlook.com>
References: <VI1PR0802MB25289788BFADB136CE08AADA8FDA0@VI1PR0802MB2528.eurprd08.prod.outlook.com>
 <5BF56151.5090201@oberhumer.com>
In-Reply-To: <5BF56151.5090201@oberhumer.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Matt.Sealey@arm.com; 
x-originating-ip: [217.140.111.135]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB3837;6:gHGrj+Bu461Y+4ojGsjPnF/x8tzNOyr1el2PGacxYsMwV0Kyfajw7YbxrECW5iTpbUw9bgM1HXrOUMNmnz1koVvLUkjkHqXyzp0zOPgLQDsqhMU4mniYkMEqgdUHvNqf0j+e5iURido/NSnJN43qdyJMfCWd2qzYJpCKRMRzwULD3nq6EEy7PrI4ocXaWRoBD5gBo+415PDQu9Phk8bbWrFip7XWOhKgNzopp6qu15NUsXaqG3E/YFh31rDY+LWNgT4Qgz94BlqKXnQRbYKdG5oI4MzD97F6FRDYZ20Qmm3xTeDFoQorYt8qh6vnM9ywuZJARpjpm9nsmNpWcmF+jRXEFTy9n2RaXM6bJtXW4MOfaoMFQm5kKNL+B0MN26fdQOUyvOtPdTfY/uO1o6m7fGR+ih4FZlbGnTIY/ydag1yu+1DuwpVb8xxqbh/pEDQpf/NpuvP3kB5OQlwQJUGyLg==;5:TcBCOT0sayIoQH/tevWbVaypUDe9r5OIezC1y8KrQBjVnoiG4Lt7bsx77uF93bVzWyXJMAundQkBI+b1KhIsf7oL6YEGbzs5LK3BOJKZevgyjfK+lojiuyAYGOE6XNc6PXxRlhbKo/xVHRKZqGEVGMWyynZuMNlXWPiu0uzHHaE=;7:/nf4kzRCdwsUK3DVoNP7/X0wm3WGuv8UiLUjxBE5I7VNuml08qDjnAevMTQJaXisU57qWVCzi84ger18HM+4LY7lbDcL3GT8bIwVbOrhNJLpbmgZV1BVcO688t3oXAl3N9dz7AE7SmV6nQWLHTwCvg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 39c0f02c-7e80-4318-4058-08d64fd3773c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3837;
x-ms-traffictypediagnostic: VI1PR08MB3837:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB38372B40FA4ED30514731CB4EEDA0@VI1PR08MB3837.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB3837;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3837;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(366004)(199004)(189003)(186003)(68736007)(102836004)(86362001)(9686003)(486006)(6436002)(99286004)(26005)(6506007)(256004)(14444005)(105586002)(14454004)(11346002)(476003)(7696005)(106356001)(76176011)(2906002)(66066001)(71190400001)(71200400001)(446003)(81166006)(2900100001)(54906003)(8936002)(81156014)(25786009)(4326008)(6246003)(8676002)(3846002)(5660300001)(33656002)(6116002)(316002)(110136005)(2501003)(74316002)(478600001)(72206003)(55016002)(53936002)(97736004)(39060400002)(229853002)(305945005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3837;H:VI1PR08MB3662.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NEFrxLHAkEMIY/yi4FRF3z0AHrIevHsb+/xgHRrQzjTlVKSKfcFMUr+R2Ed3kAp17xLQ/PAYVf24rd526or58wyj4CdjgeW1nhXORvbibj6ILwYtd0kRcdGdjgd/Lc6awxEHAI4M07SbHLRDtkfvRq5axKYcxHHHbwBool2DxMzgqxwTymGTusijHBcWMJQj4CSPuRpyKze0c0nudKsk1DhTtF9tilhD5fmKSlPp8DkcfMVC6N9Sk7usYFcPtfIWWVKGuh7BzzajHGtkDjH2/0l2Kzl6USD9K7i94UyYCtVeCkT4SK0/p2LNbIIXBLfxWc13HDk2eWo7G+Of8VQCcgZAMC+4zNeU5vqCOCKxXrk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c0f02c-7e80-4318-4058-08d64fd3773c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 17:04:57.5604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFya3VzLg0KDQo+IEhpIERhdmUsDQo+IA0KPiB0aGFua3MgZm9yIHlvdXIgcGF0Y2ggc2V0
LiBKdXN0IHNvbWUgaW5pdGlhbCBjb21tZW50czoNCj4gDQo+IA0KPiBJIHRoaW5rIHRoZSB0aHJl
ZSBwYXRjaGVzDQo+IA0KPiAgIFtQQVRDSCAyLzZdIGxpYi9sem86IGVuYWJsZSA2NC1iaXQgQ1Ra
IG9uIEFybQ0KPiAgIFtQQVRDSCAzLzZdIGxpYi9sem86IDY0LWJpdCBDVFogb24gQXJtIGFhcmNo
NjQNCj4gICBbUEFUQ0ggNC82XSBsaWIvbHpvOiBmYXN0IDgtYnl0ZSBjb3B5IG9uIGFybTY0DQo+
IA0KPiBzaG91bGQgYmUgYXBwbGllZCBpbiBhbnkgY2FzZSAtIGNvdWxkIHlvdSBwbGVhc2UgbWFr
ZSBhbiBleHRyYQ0KPiBwdWxsIHJlcXVlc3Qgb3V0IG9mIHRoZXNlIGFuZCB0cnkgdG8gZ2V0IHRo
ZW0gbWVyZ2VkIGFzIGZhc3QNCj4gYXMgcG9zc2libGUuIFRoYW5rcy4NCj4gDQo+IA0KPiBUaGUg
Zmlyc3QgcGF0Y2gNCj4gDQo+ICAgW1BBVENIIDEvNl0gbGliL2x6bzogY2xlYW4tdXAgYnkgaW50
cm9kdWNpbmcgQ09QWTE2DQo+IA0KPiBkb2VzIG5vdCByZWFsbHkgYWZmZWN0IHRoZSByZXN1bHRp
bmcgY29kZSBhdCB0aGUgbW9tZW50LCBidXQgcGxlYXNlDQo+IG5vdGUgdGhhdCBpbiBvbmUgY2Fz
ZSB0aGUgYWN0dWFsIGNvcHkgdW5pdCBpcyBub3QgYWxsb3dlZCB0bw0KPiBiZSBncmVhdGVyIDgg
Ynl0ZXMgKHdoaWNoIG1pZ2h0IGJlIGltcGxpZWQgYnkgdGhlIG5hbWUgIkNPUFkxNiIpLg0KPiBT
byB0aGlzIG5lZWRzIG1vcmUgd29yayBsaWtlIGFuIGV4dHJhIENPUFkxNl9CWV84KCkgbWFjcm8u
DQoNCkkgYWdyZWUgaW4gcHJpbmNpcGxlIGJ1dCBub3QgaW4gcHJhY3RpY2UgOykNCg0KVGhlIG9y
aWdpbmFsIGludGVudCBvZiB0aG9zZSBwYXRjaGVzIHdhcyB0byBhdmFpbCBvdXJzZWx2ZXMgb2YN
Cmtub3duIGFyY2hpdGVjdHVyYWwgZmVhdHVyZXMsIGJ1dCBhbHNvIGdpdmUgdGhlIGNvbXBpbGVy
IGEgaGVscGluZw0KaGFuZCB3aGVyZSBMWk8gaXNuJ3Qgc3VwcG9zZWQgdG8gYmUgdGhhdCBrbm93
bGVkZ2VhYmxlIG9mIHRoZQ0KdW5kZXJseWluZyBwcm9jZXNzb3IgaW1wbGVtZW50YXRpb24uIFRo
ZSBlbmQgcmVzdWx0IGlzIEkgdGhpbmsNCmFuIGFyY2hpdGVjdHVyZSBoYXZpbmcgYSBkaXNjcmV0
ZSAxNi1ieXRlIG1vdmVtZW50IGlzIG1vcmUNCmJlbmVmaWNpYWwgdGhhbiBkaWN0YXRpbmcgaG93
IHRoaW5ncyBhcmUgYmVpbmcgY29waWVkIHVuZGVyIGl0Lg0KDQpXaGF0IGNhbWUgb3V0IGlzIHRo
YXQgdGhlcmUgaXMgYSBkaWZmZXJlbmNlIGluIGNvZGVnZW4gaW4gY29tcHJlc3MNCnZzLiBkZWNv
bXByZXNzIGxpdGVyYWxseSBiZWNhdXNlIG9mIGEgZGlmZmVyZW5jZSBpbiBjb2Rpbmcgc3R5bGU6
DQoNCmRlY29tcHJlc3M6DQoNCkNPUFk4KG9wLCBpcCk7DQpvcCArPSA4Ow0KaXAgKz0gODsNCkNP
UFk4KG9wLCBpcCk7DQpvcCArPSA4Ow0KaXAgKz0gODsNCg0KY29tcHJlc3M6DQoNCkNPUFk4KG9w
LCBpcCk7DQpDT1BZOChvcCs4LCBpcCs4KTsNCmlwICs9IDE2Ow0Kb3AgKz0gMTY7DQoNCkNvbXBp
bGVycyBkbyB2ZXJ5IHdlbGwgd2l0aCB0aGUgbGF0dGVyLCBhbmQgdGVycmlibHkgd2l0aCB0aGUg
Zm9ybWVyLg0KT25jZSBJIGFsaWduZWQgdGhlbSB0byB0aGUgc2FtZSBzZXF1ZW5jZSBJIG5vdGlj
ZWQgdGhlIG9ubHkgdGltZQ0KTFpPIGV2ZXIgZG9lcyA4LWJ5dGUgY29waWVzIGlzIGluIDE2LWJ5
dGUgY2h1bmtzLCBhbmQgdGhpcyBhbGlnbmVkDQp3aXRoIG15IGV4cGVjdGF0aW9uIHRoYXQgb24g
YXJtNjQgTERQL1NUUCB3aXRoIHdyaXRlYmFjayBnZXRzIGl0IGRvbmUNCmluIHR3byBpbnN0cnVj
dGlvbnMuIEkgd2FudCB0byBnbyB0byB0aGVyZSENCg0KQ09QWTE2IGJlaW5nIGRlZmluZWQgYXMg
Q09QWTgsQ09QWTggaXMgYSBsb3cgaGFuZ2luZyBmcnVpdCB0aGF0DQpkb2VzIGltcHJvdmUgY29k
ZWdlbiBvbiBhcm02NCBzbGlnaHRseSAoYmVjYXVzZSBpdCBjbGVhbnMgdGhlDQpkZWNvbXByZXNz
aW9uIGNvZGUgdXApIGFuZCBwZXJmb3JtYW5jZSBldmVuIG1vcmUgc2xpZ2h0bHkgYXMgYQ0KcmVz
dWx0LiANCg0KSnVzdCBmb3IgZWx1Y2lkYXRpb24sIGl0IGdvZXMgZnJvbSAoZGVjb21wcmVzcykN
Cg0KYWRkICAgICB4MCwgeDAsIDE2ICAgICAgLy8gb3AsIG9wLA0KbGRyICAgICB3MiwgW3gxXSAg
ICAgICAgLy8sIE1FTVtiYXNlOiBpaV8xNywgb2Zmc2V0OiAwQl0NCmFkZCAgICAgeDEsIHgxLCAx
NiAgICAgIC8vIGlpLCBpaSwNCmNtcCAgICAgeDAsIHgzICAvLyBvcCwgXzQ5MA0Kc3RyICAgICB3
MiwgW3gwLCAtMTZdICAgLy8gXzg5LCBNRU1bYmFzZTogb3BfOCwgb2Zmc2V0OiAwQl0NCmxkciAg
ICAgdzIsIFt4MSwgLTEyXSAgIC8vLCBNRU1bYmFzZTogaWlfMTcsIG9mZnNldDogNEJdDQpzdHIg
ICAgIHcyLCBbeDAsIC0xMl0gICAvLyBfMTA1LCBNRU1bYmFzZTogb3BfOCwgb2Zmc2V0OiA0Ql0N
CmxkciAgICAgdzIsIFt4MSwgLThdICAgIC8vLCBNRU1bYmFzZTogaWlfMTcsIG9mZnNldDogOEJd
DQpzdHIgICAgIHcyLCBbeDAsIC04XSAgICAvLyBfMTQ1LCBNRU1bYmFzZTogb3BfOCwgb2Zmc2V0
OiA4Ql0NCmxkciAgICAgdzIsIFt4MSwgLTRdICAgIC8vLCBNRU1bYmFzZTogaWlfMTcsIG9mZnNl
dDogMTJCXQ0Kc3RyICAgICB3MiwgW3gwLCAtNF0gICAgLy8gXzE1NiwgTUVNW2Jhc2U6IG9wXzgs
IG9mZnNldDogMTJCXQ0KDQpUbyB0aGlzIChzYW1lIGNvZGUgYXMgY29tcHJlc3MpOg0KDQphZGQg
ICAgIHgwLCB4MCwgMTYgICAgICAvLyBvcCwgb3AsDQpsZHIgICAgIHgyLCBbeDFdICAgICAgICAv
LyBfMTUzLCBNRU1bYmFzZTogaWlfMTcsIG9mZnNldDogMEJdDQphZGQgICAgIHgxLCB4MSwgMTYg
ICAgICAvLyBpaSwgaWksDQpjbXAgICAgIHgwLCB4MyAgLy8gb3AsIF80MTgNCnN0ciAgICAgeDIs
IFt4MCwgLTE2XSAgIC8vIF8xNTMsIE1FTVtiYXNlOiBvcF84LCBvZmZzZXQ6IDBCXQ0KbGRyICAg
ICB4MiwgW3gxLCAtOF0gICAgLy8gXzE4MSwgTUVNW2Jhc2U6IGlpXzE3LCBvZmZzZXQ6IDhCXQ0K
c3RyICAgICB4MiwgW3gwLCAtOF0gICAgLy8gXzE4MSwgTUVNW2Jhc2U6IG9wXzgsIG9mZnNldDog
OEJdDQoNCkJ1dCBpdCdzIGdvaW5nIHRvIHdhbnQgdG8gYmUgdGhpcyB3YXk6DQoNCmxkcCAgICAg
eDIsIHgzLCBbeDFdLCAxNiAgICAgICAgLy8gXzE4MiwgTUVNW2Jhc2U6IGlpXzE3LCBvZmZzZXQ6
IDBCXQ0Kc3RwICAgICB4MiwgeDMsIFt4MF0sIDE2ICAgICAgICAvLyBfMTgyLCBNRU1bYmFzZTog
b3BfOCwgb2Zmc2V0OiAwQl0NCg0KV2hpY2ggaXMgYSBDT1BZMTZfQllfOCBidXQgb25seSBiZWNh
dXNlIG9mIHRoZSBhcmNoaXRlY3R1cmUgcnVsZXMNCm9uIGVsZW1lbnQgc2l6ZXMuLiBDT1BZMTZf
QllfOCBkb2Vzbid0IGZpdCB0aGUgaWRpb20gd2UncmUNCnRyeWluZyB0byBjcmVhdGUuDQoNCkZv
ciBhcm02NCB0aGUgZWFzaWVzdCB3YXkgdG8gZ2V0IExEUC9TVFAgd2l0aCB3cml0ZWJhY2sganVz
dA0KaGFwcGVucyB0byBiZSBhbGxvd2luZyBjb21waWxlcnMgdG8gbGlmdCBtZW1jcHkobyxpLDE2
KSB3aGljaA0KaXMgYWx3YXlzIGdvaW5nIHRvIGJlIGFsaWdubWVudC1zYWZlLCBidXQgdGhpcyBk
b2Vzbid0IGhvbGQgdHJ1ZQ0Kb24gYXJtMzIgb3IgZWxzZXdoZXJlIGFuZCB3ZSd2ZSBub3QgZG9u
ZSBlbm91Z2ggdGVzdGluZyBvbiBvdGhlcg0KYXJjaGVzIGZvciB0aGF0IGNvbmNlcHQgdG8gYmVh
ciBmcnVpdCwgeWV0Lg0KDQpJJ20gY29uZnVzZWQgYnkgdGhlICdvbmUgY2FzZSB0aGUgYWN0dWFs
IGNvcHkgdW5pdCBpcyBub3QgYWxsb3dlZCB0bw0KYmUgZ3JlYXRlciA4IGJ5dGVzJyBzdGF0ZW1l
bnQ6IHRoaXMgaXMgbm90IGV2aWRlbmNlZCBieSB0aGUgbG9vcA0Kc3RydWN0dXJlLiBDT1BZOCBp
cyBvbmx5IGV2ZXIgaW1wbGVtZW50ZWQgaW4gcGFpcnMgaW4gdGhlIGtlcm5lbCAtDQpjYW4geW91
IHBvaW50IG91dCB3aGVyZSB0aGlzIG1pZ2h0IG5vdCBiZSB0aGUgY2FzZSBpbiB0aGUgZnV0dXJl
DQooYW5kIHdoeSB0aGV5IGNvdWxkbid0IHN0aWxsIHVzZSBDT1BZOCBpbiB0aGF0IGNhc2UpPw0K
DQpUYSENCk1hdHQgU2VhbGV5IDxtYXR0LnNlYWxleUBhcm0uY29tPg0KQXJtIFBhcnRuZXIgRW5h
YmxlbWVudCBHcm91cA0KDQo=
