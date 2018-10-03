Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBD2C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D213720652
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="dIbmxqsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D213720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeJDCb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:31:29 -0400
Received: from mail-bn3nam01on0083.outbound.protection.outlook.com ([104.47.33.83]:26720
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbeJDCb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hy66Qrcy6GFaXeCo11Mr3PWhN6cuLZVZSe/ojtkRk3A=;
 b=dIbmxqszoU9wEqbARv+wUX9OkkMeJS18Pa4CSspfvv/V2+PTlBmi+ieuFmjY/MKbPZMrDcqSBq5teS9oZPYvjZ7QgnjADr7VEeC3PQ4D6IKreNBLOilVvj3/i1unNL7Z9RBvNmq6PK33K9r+1fwuBOgYVFtvd7djprqI7+Rc8bI=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4038.namprd05.prod.outlook.com (52.135.199.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Wed, 3 Oct 2018 19:41:35 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%3]) with mapi id 15.20.1207.018; Wed, 3 Oct 2018
 19:41:35 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v8 02/10] Makefile: Prepare for using macros for inline
 asm
Thread-Topic: [PATCH v8 02/10] Makefile: Prepare for using macros for inline
 asm
Thread-Index: AQHUT5bXKvBkh+LIPE6RXFqGVNbGXKUCTuyAgACWSoCACCAsgIAC/Z2A
Date:   Wed, 3 Oct 2018 19:41:34 +0000
Message-ID: <B362FFD5-91AA-42ED-8401-9E9E7F6E4375@vmware.com>
References: <20180918212847.199085-1-namit@vmware.com>
 <20180918212847.199085-3-namit@vmware.com>
 <1aa5a1f3-ef3d-5cd3-831c-2202d73d3c9e@rasmusvillemoes.dk>
 <307823F9-DCCF-4384-9FBE-28642FAD6B4E@vmware.com>
 <CAK7LNAT98KZrMLuypS0PZ4jUWC+uRWyYwHPiEJD6LYoYzndJhA@mail.gmail.com>
In-Reply-To: <CAK7LNAT98KZrMLuypS0PZ4jUWC+uRWyYwHPiEJD6LYoYzndJhA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4038;20:fQTqCdr4eAeejIgckG0kRmoe/H5WmD/aBwaCAl95MzXxGVvs04iTZ92+Cug+OMfk1i3tZe6qe0/v80vL2VOGbt4mctPeslEw60orRgAhIOv2AI1mWsMYWfrIC9hVVkjlSZ3l5jSms35rXvVlrlU7JdbLgiBgT9UZM5iQCiZq85A=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 88278c47-b16f-455e-d69a-08d629683a4b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4038;
x-ms-traffictypediagnostic: BYAPR05MB4038:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB403878F4808E1767C53EF0FED0E90@BYAPR05MB4038.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:BYAPR05MB4038;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4038;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(6486002)(81166006)(8676002)(93886005)(86362001)(99286004)(229853002)(53546011)(316002)(53936002)(76176011)(81156014)(6436002)(6916009)(446003)(11346002)(7736002)(6512007)(2616005)(14454004)(476003)(305945005)(33656002)(6506007)(105586002)(486006)(26005)(68736007)(102836004)(8936002)(25786009)(36756003)(2906002)(256004)(186003)(7416002)(478600001)(106356001)(4326008)(54906003)(6246003)(5660300001)(66066001)(71200400001)(97736004)(71190400001)(5250100002)(3846002)(6116002)(82746002)(83716004)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4038;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: k20l0CW86ZdomHNsgxhK+UedG5/mxibWPpDqRQls70hfEYrlCd5izqB1aN+PlC+tJE7WVJhz1dhpMiPN7b/+wemUJZ3OcACZOXIpcSCfHGm5i5vxKDxw4JOMNcCib7U/SnI+4WFha9IzUY9soIuEtYvqtvbgCicSTsJtq5CAuUXP5pLiKEvEk+wqhibvDuh3kzFKHP19BIh/33GjWG3iz0jqMOZtWN9OXJ51tWpyzE755fv8LH5iAgkENufNwd5aENIOBUmiXEBWlcgO93YfY/5wpeCo7yyEolzC4A8SJ+dvqtk/p0CPNqMLLgHu2RmjG5p5aMQXX+yHih8BOGqOquGksxIrsc+hDCD/lqgpeEU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BAFD90386788B44B2F5DCDDFF4E84D7@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88278c47-b16f-455e-d69a-08d629683a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 19:41:34.9015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMzowMSBQTSwgTWFzYWhpcm8gWWFtYWRhIDx5YW1hZGEubWFzYWhpcm9Ac29jaW9uZXh0LmNv
bT4gd3JvdGU6DQoNCj4gSGkuDQoNClRoYW5rcyBmb3IgeW91ciByZXBseS4gWW91ciBhZHZpY2Vz
IGFyZSBhbHdheXMgdmFsdWFibGUhDQoNCj4gDQo+IA0KPiANCj4gMjAxOOW5tDnmnIgyN+aXpSjm
nKgpIDI6NTcgTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT46DQo+PiBhdCAxOjU4IEFNLCBS
YXNtdXMgVmlsbGVtb2VzIDxsaW51eEByYXNtdXN2aWxsZW1vZXMuZGs+IHdyb3RlOg0KPj4gDQo+
Pj4gT24gMjAxOC0wOS0xOCAyMzoyOCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+PiANCj4+Pj4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L01ha2VmaWxlIGIvYXJjaC94ODYvTWFrZWZpbGUNCj4+Pj4gaW5k
ZXggOGY2ZTdlYjhhZTlmLi45NDRmYTNiYzkzNzYgMTAwNjQ0DQo+Pj4+IC0tLSBhL2FyY2gveDg2
L01ha2VmaWxlDQo+Pj4+ICsrKyBiL2FyY2gveDg2L01ha2VmaWxlDQo+Pj4+IEBAIC0yMTQsOCAr
MjE0LDggQEAgaWZkZWYgQ09ORklHX1g4Nl82NA0KPj4+PiBLQlVJTERfTERGTEFHUyArPSAkKGNh
bGwgbGQtb3B0aW9uLCAteiBtYXgtcGFnZS1zaXplPTB4MjAwMDAwKQ0KPj4+PiBlbmRpZg0KPj4+
PiANCj4+Pj4gLSMgU3BlZWQgdXAgdGhlIGJ1aWxkDQo+Pj4+IC1LQlVJTERfQ0ZMQUdTICs9IC1w
aXBlDQo+Pj4+ICsjIFdlIGNhbm5vdCB1c2UgLXBpcGUgZmxhZyBzaW5jZSB3ZSBnaXZlIGFuIGFk
ZGl0aW9uYWwgLnMgZmlsZSB0byB0aGUgY29tcGlsZXINCj4+Pj4gKyNLQlVJTERfQ0ZMQUdTICs9
IC1waXBlDQo+Pj4gDQo+Pj4gSXMgdGhpcyByZWFsbHkgbmVjZXNzYXJ5PyBUaGUgZ2FzIG1hbnVh
bCBzYXlzIHRoYXQgb25lIGNhbiB1c2UgLS0gdG8NCj4+PiBuYW1lIHN0ZGluLCB0aG91Z2ggdGhh
dCdzIHByb2JhYmx5IGEgdHlwbyBhbmQgc2hvdWxkIGp1c3QgYmUgLSAuIERvaW5nDQo+Pj4gDQo+
Pj4gZ2NjIC1waXBlIC1XYSxmb28ucyAtV2EsLQ0KPj4gDQo+PiBHb29kIGlkZWEuIEkgZGlkbuKA
mXQgdGhpbmsgb2YgaXQuIFllcywgdGhpcyBjYW4gZG8gdGhlIHRyaWNrLiBJ4oCZbGwgZG8gaXQg
aW4NCj4+IHY5Lg0KPj4gDQo+Pj4gZG9lcyBzZWVtIHRvIHdvcmsgYXMgZXhwZWN0ZWQgKGFuZCB3
b3VsZCBhbHNvIG1ha2UgaXQgcG9zc2libGUgdG8gYXBwZW5kDQo+Pj4gc29tZSAucyBmaWxlIHNo
b3VsZCB0aGF0IGV2ZXIgYmUgcmVxdWlyZWQpLg0KPj4+PiArYXJjaG1hY3JvczoNCj4+Pj4gKyAg
ICAkKFEpJChNQUtFKSAkKGJ1aWxkKT1hcmNoL3g4Ni9rZXJuZWwgYXJjaC94ODYva2VybmVsL21h
Y3Jvcy5zDQo+Pj4+ICsNCj4+Pj4gK0FTTV9NQUNST19GTEFHUyA9IC1XYSxhcmNoL3g4Ni9rZXJu
ZWwvbWFjcm9zLnMNCj4+Pj4gK2V4cG9ydCBBU01fTUFDUk9fRkxBR1MNCj4+Pj4gK0tCVUlMRF9D
RkxBR1MgKz0gJChBU01fTUFDUk9fRkxBR1MpDQo+Pj4gSG93IGRvZXMgdGhpcyBhZmZlY3Qgd2hh
dCBnZXRzIHJlYnVpbHQgd2hlbiBvbmUgb2YgdGhlIGFzbS9mb28uaCBmaWxlcw0KPj4+IGdvaW5n
IGludG8gbWFjcm9zLnMgY2hhbmdlcz8gRG9lcyB0aGF0IGNhdXNlIGEgZ2xvYmFsIHJlYnVpbGQg
YmVjYXVzZQ0KPj4+IGV2ZXJ5dGhpbmcgZGVwZW5kcyBvbiBtYWNyb3Mucywgb3IgZG8gd2Ugc3Rp
bGwgb25seSByZWJ1aWxkIHRoZSBmaWxlcw0KPj4+IHRoYXQgYWN0dWFsbHkgaW5jbHVkZSBhc20v
Zm9vLmg/DQo+PiANCj4+IFRoZXJlIHdpbGwgbm90IGJlIGEgZ2xvYmFsIHJlYnVpbGQuIEFueSBz
b3VyY2UgZmlsZSB0aGF0IHVzZXMgdGhlIGhlYWRlcg0KPj4gZmlsZXMgdGhhdCBhcmUgaW5jbHVk
ZWQgaW4gbWFjcm9zLlMgd2lsbCBiZSByZWJ1aWx0Lg0KPj4gDQo+PiBCdXQgeW91ciBxdWVzdGlv
biBhY3R1YWxseSByYWlzZXMgdHdvIGlzc3VlczoNCj4+IA0KPj4gMS4gSWYgbWFjcm9zLlMgY2hh
bmdlcywgdGhlcmUgKnNob3VsZCogYmUgYSBnbG9iYWwgcmVidWlsZCwNCj4gDQo+IA0KPiBMb29r
aW5nIGF0IHRoaXMgc2VyaWVzLCBJIGNhbiBzZWUgdGhpcyBydWxlOg0KPiAibWFjcm9zIGFuZCBp
bmxpbmUgZnVuY3Rpb25zIHRoYXQgY2FsbHMgdGhlbSBhcmUgcGxhY2VkIGluIHRoZSBzYW1lIGhl
YWRlciIuDQo+IA0KPiANCj4gRm9yIGV4YW1wbGUsDQo+IFJFRkNPVU5UX0NIRUNLX0xFX1pFUk8g
aXMgZGVmaW5lZCBpbiA8YXNtL3JlZmNvdW50Lmg+LA0KPiBhbmQgUkVGQ09VTlRfQ0hFQ0tfTEVf
WkVSTyBpcyBpbnZva2VkIHZpYSByZWZjb3VudF9zdWJfYW5kX3Rlc3QoKSBldGMuDQo+IGluIHRo
ZSBzYW1lIGhlYWRlci4NCj4gDQo+IFRoZXJlZm9yZSwgYWxsIHVzZXJzIG9mIFJFRkNPVU5UX0NI
RUNLX0xFX1pFUk8gbXVzdCBoYXZlIGluY2x1ZGVkDQo+IDxhc20vcmVmY291bnQuaD4NCj4gDQo+
IFRoaXMgbWVhbnMgYWxsIEMgZmlsZXMgdXNpbmcgUkVGQ09VTlRfQ0hFQ0tfTEVfWkVSTw0KPiB3
aWxsIGJlIGFwcHJvcHJpYXRlbHkgcmVjb21waWxlZCBhcyBsb25nIGFzIHRoZSBydWxlIGFib3Zl
IGlzIG9ic2VydmVkLg0KDQpZZXMuIE15IGNvbmNlcm4gaXMgbm90IHdoYXQgaGFwcGVucyBpZiBh
bnkgb2YgdGhlIGZpbGVzIGluY2x1ZGVkIGZyb20NCm1hY3Jvcy5TIGNoYW5nZXMsIGJ1dCB3aGF0
IGhhcHBlbnMgaWYgbWFjcm9zLlMgY2hhbmdlcyAoZS5nLiwgdG8gaW5jbHVkZQ0KYW4gYWRkaXRp
b25hbCBoZWFkZXIpLg0KDQpNYXliZSBJIGNhbiBjcmVhdGUgc29tZSBhcnRpZmljaWFsIGRlcGVu
ZGVuY3kgYmFzZWQgb24gX19BU1NFTUJMWV9fIC4gSeKAmWxsDQpnaXZlIGl0IGFub3RoZXIgdGhv
dWdodC4NCg0KPj4gYW5kIGN1cnJlbnRseQ0KPj4gdGhlcmUgd291bGRu4oCZdCBiZSBvbmUuIERv
IHlvdSBoYXBwZW4gdG8ga25vdyB3aGF0IHdvdWxkIGJlIHRoZSBhcHByb3ByaWF0ZQ0KPj4gd2F5
IHRvIHRyaWdnZXIgb25lPw0KPj4gDQo+PiAyLiBTb21lb25lIG1pZ2h0IG1pc3Rha2VubHkgdXNl
IHRoZSBtYWNyb3MgdGhyb3VnaCBpbmxpbmUgYXNzZW1ibHkgd2l0aG91dA0KPj4gaW5jbHVkaW5n
IHRoZSBoZWFkZXIgZmlsZS4NCj4gDQo+IFJpZ2h0LCBpdCBpcyBwb3NzaWJsZSB0byB1c2UgUkVG
Q09VTlRfQ0hFQ0tfTEVfWkVSTyBkaXJlY3RseS4NCj4gSWYgdGhpcyBoYXBwZW5zLCBteSBhc3N1
bXB0aW9uIGJyZWFrcy4NCj4gDQo+IEl0IHdvdWxkIGJlIHVubGlrZWx5IHRvIGhhcHBlbiwgdGhv
dWdoLi4uDQoNClllcy4gSeKAmWxsIGxldCBpdCBnbyBmb3Igbm93Lg0KDQpUaGFua3MsDQpOYWRh
dg==
