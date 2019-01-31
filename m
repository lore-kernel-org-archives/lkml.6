Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59FDC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697992087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="ZR5eaPYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387415AbfAaNN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:13:27 -0500
Received: from mail-eopbgr60102.outbound.protection.outlook.com ([40.107.6.102]:63024
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727202AbfAaNN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK5tZy1W9j3mtA/lZUtoYYOLJszdB6vdOOVsSgZgaXM=;
 b=ZR5eaPYSqWtKUS82So+RNVB/oVDcv2ozHOvx16d4JvrNa/Qc+2eOz6ZcFW78aJV9P4+iWk5nt9k279vwiYsecY+1gECsL+RouquZRklB3Ts98jpMLCPK6b/XTgeZZeFo6ieLLpfa25pl4m/jGQtqX+x62hQ6GGSksV2nwZXP/Fg=
Received: from VI1PR0201MB2112.eurprd02.prod.outlook.com (10.169.131.25) by
 VI1PR0201MB2096.eurprd02.prod.outlook.com (10.169.131.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Thu, 31 Jan 2019 13:13:22 +0000
Received: from VI1PR0201MB2112.eurprd02.prod.outlook.com
 ([fe80::515d:5c88:762f:9d37]) by VI1PR0201MB2112.eurprd02.prod.outlook.com
 ([fe80::515d:5c88:762f:9d37%6]) with mapi id 15.20.1558.025; Thu, 31 Jan 2019
 13:13:22 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Boris Brezillon <bbrezillon@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Thread-Topic: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Thread-Index: AQHUqPaeuHFV8522kE2kP/gCblgMKKXC4lQAgAaZNoA=
Date:   Thu, 31 Jan 2019 13:13:22 +0000
Message-ID: <d2e24b73-dee1-b31a-dc87-02d2e75b6dd2@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190127092709.3863c954@bbrezillon>
In-Reply-To: <20190127092709.3863c954@bbrezillon>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0176.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::24) To VI1PR0201MB2112.eurprd02.prod.outlook.com
 (2603:10a6:800:24::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0201MB2096;6:jcy4lA4Tiqjq/84J+7VKG4aUVjaP2R0fArkDQvvEhfkv3N2OpSDXqvfGzXcdyHeU3evOQL79HnKl5ab0u0BCdyPPGYLBI1yynC9rd5+YDBCMvu5MpQwP/89psxvyVy/t1I79THOYEg25QTkcLZI+oqWcGij7SNNfSK4Q8WxJiQdvOMUfVe87IlHqeJZcPaS16zCTa6AQX90w+LrXdhkowX8+lFeB2lqFLRALEVhaJY0gnhSh9AmVVtTTEt3wMvPRW57U+XX2PdJuU2x3NBsOU6xff7JUS0xfRTtH5SMRTnYx//ko38CYPRTHcUHzBj/DkrxrHzssZsd3cNGnjXMdjelCltmtM09FLUlphkbipegnLcr2YliMBUATxwdNCt+xJaMF8LR9V788LRhmGsPYWvBHM4Pnkcfl257OtHuWUycAP7RQ6yBgsNnTdRTn0P2LOt68RPEwazfuJSeCZzkWBQ==;5:B+GGnEbRt5wfKX3YvpEyLZKkjnZFZfHtLQZzZ5tKDXeloy4zCPfWCP5s4l7RzShIBUcqu5PvyyVtzbOaroOVqOhyp6iViUjKjFLkhNeVOfrgA+Z1rhmRLTHpVyUTuY0pX5z6kDYjWcUMKj2U8JlM9FamvA4E15L4Qt5zgJnq0Qek54xL6BH/SHG0m3zB3oBE2QsWjq8LgVPHLNabP2Th0A==;7:MSCth/pKLz73+sFpuibJ0S4ge5R44OyqzIwXO+7IAODx0TF0438Bp6aZxftoAHEm+DRIZk0JfsciNheug8rEUTh4kTGoKv3URH+sYas8MjZCM4Abo1UNV6x57z66f2NtDoS5y+LMaqnvR0dd/QGm2A==
x-ms-office365-filtering-correlation-id: 751f425e-42b2-49f3-9d92-08d6877de004
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2096;
x-ms-traffictypediagnostic: VI1PR0201MB2096:
x-microsoft-antispam-prvs: <VI1PR0201MB209656A70ED2E398CF228202BC910@VI1PR0201MB2096.eurprd02.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(136003)(39830400003)(396003)(189003)(199004)(6506007)(2906002)(2616005)(3846002)(74482002)(6116002)(6246003)(14454004)(6916009)(11346002)(105586002)(71200400001)(106356001)(6486002)(486006)(36756003)(229853002)(446003)(86362001)(31686004)(476003)(6512007)(31696002)(97736004)(71190400001)(6436002)(7736002)(8936002)(66066001)(65806001)(53936002)(4326008)(64126003)(256004)(53546011)(8676002)(305945005)(386003)(52116002)(316002)(54906003)(58126008)(81166006)(81156014)(99286004)(68736007)(102836004)(26005)(25786009)(65826007)(14444005)(76176011)(65956001)(508600001)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2096;H:VI1PR0201MB2112.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SWQdR8/hQu0KFEYnaBJ08G67Tk3YTyD9UoqALH4uifpKZju9gfQU7PJT0g7XB8FbrVNSBdfZIor2scbc33Vv4h6ky2ok4CIkhQwCqqwAtR8acw4QiCLSSMJnHAr/W/wvUhygqiIE5ZlY93hXWaHSN0bYMpPReMKoF8oPF2xIxmJ8UkzF/wv5zBhIHqMg6U9LGWFS4UvZlImetimjY23VYDHkmSy9d2dg9Sv4efq6TSjGzwooPf+cSagEw+HrBr4181CZtDNeLt0sbtX8XvossYSQ2Ecj4diHL+lZrKD8loccqc5cD+c5IuKmJngHDq7vkSi9s5txG0rj335J9utpd+lHbJomgVzpXr/Pb4uXBtzZOM7ueNg04UrPH1y/q23M5+1bemJhBaWSEgtNAIONnaT+iKfv/k7jsIJnswqG4Lw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FF5C38029451345A2864983E6C4930F@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 751f425e-42b2-49f3-9d92-08d6877de004
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 13:13:21.2470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMS0yNyAwOToyNywgQm9yaXMgQnJlemlsbG9uIHdyb3RlOg0KPiBPbiBUaHUsIDEw
IEphbiAyMDE5IDE1OjEwOjI4ICswMDAwDQo+IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+
IHdyb3RlOg0KPiANCj4+IEhpIQ0KPj4NCj4+IEkgZm91bmQgYW4gdW5mb3J0dW5hdGUgaXNzdWUg
d2hpbGUgcmVjb2RpbmcgcGxhbmUgaGFuZGxpbmcgdG8gdXNlDQo+PiBkcm1fYXRvbWljX2hlbHBl
cl9jaGVja19wbGFuZV9zdGF0ZSgpLiBUaGUgZHJpdmVyIHJvdGF0ZXMgY2xvY2t3aXNlLA0KPj4g
d2hpY2ggaXMgbm90IGNvcnJlY3QuIEkgc2ltcGx5IGZpeGVkIGl0IChwYXRjaCAxLzQpLCBidXQg
bWF5YmUgdGhhdA0KPj4gd2lsbCBjYXVzZSByZWdyZXNzaW9ucyBmb3IgdW5zdXNwZWN0aW5nIHVz
ZXJzIHdobyBzaW1wbHkgYXNzdW1lZA0KPj4gdGhhdCB0aGUgY2xvY2t3aXNlIHJvdGF0aW9uIHdh
cyBjb3JyZWN0PyBJIGRvbid0IGtub3cgd2hhdCB0byBkbw0KPj4gYWJvdXQgdGhhdD8gQWRkaW5n
IGFuIG9wdGlvbiB0byBnZXQgdGhlIG9sZCBicm9rZW4gYmVoYXZpb3Igc2VlbXMNCj4+IHVzZWxl
c3MsIHdvdWxkbid0IGl0IGJlIGp1c3QgYXMgZWFzeSB0byBqdXN0IGZpeCB3aGF0ZXZlciBhcHAg
dG8NCj4+IHJvdGF0ZSB0aGUgb3RoZXIgd2F5IGluc3RlYWQgb2YgYWRkaW5nIGFuIG9wdGlvbiBz
b21ld2hlcmU/DQo+Pg0KPj4gSSBoYXZlIG9ubHkgdGVzdGVkIHRoaXMgc2VyaWVzIG9uIHNhbWE1
ZDMsIGJ1dCBJIGRpZCBjaGVjayB0aGUgZG9jcw0KPj4gZm9yIHZhcmlvdXMgb3RoZXIgY2hpcHMg
KHNhbWE1ZDIsIHNhbWE1ZDQsIHNhbTluMTIsIHNhbTlnMTUsIHNhbTlnMzUNCj4+IGFuZCBzYW05
eDM1KSBzdXBwb3J0ZWQgYnkgdGhlIGRyaXZlciAocmVsZXZhbnQgdG8gcGF0Y2ggNC80KS4NCj4+
DQo+PiBDaGVlcnMsDQo+PiBQZXRlcg0KPj4NCj4+IFBldGVyIFJvc2luICg0KToNCj4+ICAgZHJt
L2F0bWVsLWhsY2RjOiByb3RhdGUgcGxhbmVzIGNvdW50ZXJjbG9ja3dpc2UNCj4+ICAgZHJtL2F0
bWVsLWhsY2RjOiBkbyBub3Qgc3dhcCB3L2ggb2YgdGhlIGNydGMgd2hlbiBhIHBsYW5lIGlzIHJv
dGF0ZWQNCj4+ICAgZHJtL2F0bWVsLWhsY2RjOiBmaXggY2xpcHBpbmcgb2YgcGxhbmVzDQo+IA0K
PiBRdWV1ZWQgcGF0Y2hlcyAxLTMgdG8gZHJtLW1pc2MtbmV4dC4NCg0KR3JlYXQsIHRoYW5rcy4N
Cg0KPj4gICBkcm0vYXRtZWwtaGxjZGM6IGRvIG5vdCBpbW1lZGlhdGVseSBkaXNhYmxlIHBsYW5l
cywgd2FpdCBmb3IgbmV4dA0KPj4gICAgIGZyYW1lDQo+IA0KPiBTdGlsbCB3YWl0aW5nIGZvciBO
aWNvbGFzIGZlZWRiYWNrIG9uIHRoaXMgb25lLg0KDQpbQWRkaW5nIGJhY2sgTmljb2xhcywgaGUg
c2VlbXMgdG8gaGF2ZSBnb25lIG1pc3NpbmcgZnJvbSB0aGUgbGlzdA0KcmVjaXBpZW50cy5dDQoN
CkkgaGF2ZSBkb25lIHNvbWUgdGVzdGluZyBvZiB0aGF0IHBhdGNoIGFuZCBmb3IgbWUgaXQncyBh
IGRlZmluaXRlDQppbXByb3ZlbWVudC4gVGhlIHRlc3QgSSBkaWQgd2FzIHJlbW92aW5nIGEgd2hp
dGUgcGxhbmUgZnJvbSBhIHdoaXRlDQpiYWNrZ3JvdW5kLiBXaXRob3V0IHRoZSBwYXRjaCwgdGhl
IGRyaXZlciB3aWxsIG91dHB1dCBibGFjayB3aGVyZQ0KdGhlIHBsYW5lIHdhcyBmb3IgdGhlIGN1
cnJlbnQgZnJhbWUgKHNpbmNlIHRoZSBkcml2ZXIgZG9lcyB0aGF0DQpkaXNjLWFyZWEgdGhpbmcg
Zm9yIHRoZSBsYXJnZXN0IGhpZGRlbiBwYXJ0IG9mIHRoZSBiYWNrZ3JvdW5kKS4NCldpdGggdGhl
IHBhdGNoLCBJIGdldCBubyB2aXN1YWwgZ2xpdGNoZXMgd2hlbiByZW1vdmluZyBhIHBsYW5lLg0K
DQpJIHVzZSBhIHBsYW5lIHRvIHNjcm9sbCBhIHRleHQsIGFuZCBpZiB5b3Uga25vdyB3aGF0IHRv
IGxvb2sgZm9yLA0KdGhlIGJsYWNrIHJlY3RhbmdsZSB0aGF0IGZsaWNrZXJzIGJ5IGFzIHRoZSBw
bGFuZSB3aXRoIHRoZSBzY3JvbGxpbmcNCnRleHQgaXMgcmVtb3ZlZCBpcyBsaXR0bGUgYml0IGRp
c3R1cmJpbmcuIE5vdCBhIHNpZ25pZmljYW50IHByb2JsZW0sDQphbmQgbWF5YmUgb25seSBnZWVr
cyBub3RpY2UgaXQsIGJ1dCBzdGlsbC4uLg0KDQpKdXN0IHdhbnRlZCB0byBzYXkgdGhhdCB0aGUg
cmVzdWx0aW5nICJibGFjayBob2xlIiBtZW50aW9uZWQgaW4gdGhlDQpvdGhlciB0aHJlYWQgcmVh
bGx5IGRvZXMgZXhpc3QgYW5kIHRoYXQgdGhlIHBhdGNoIG1heSBtYWtlIHNlbnNlDQpiZXlvbmQg
dGhlIGZhY3QgdGhhdCBpdCByZW1vdmVzIHVzYWdlIG9mIHVuZG9jdW1lbnRlZCBmZWF0dXJlcy4N
Cg0KSSBoYXZlIG5vdCBzZWVuIGFueSBiYWQgc2lkZSBlZmZlY3RzIGZybyB0aGUgcGF0Y2gsIGJ1
dCBhZG1pdHRlZGx5DQpteSB0ZXN0aW5nIHdhcyB2ZXJ5IGxpbWl0ZWQgYW5kIEkgZGlkIG5vdCB0
cnkgdG8gcmVtb3ZlIHRoZSBwbGFuZQ0Kd2hpbGUgZG9pbmcgb3RoZXIgc3R1ZmYgd2l0aCB0aGUg
ZHJpdmVyLiBTbywgdGhlcmUgbWlnaHQgc3RpbGwgYmUNCnJlYXNvbnMgZm9yIHJlbW92aW5nIHBs
YW5lcyBpbW1lZGlhdGVseS4uLg0KDQpDaGVlcnMsDQpQZXRlcg0K
