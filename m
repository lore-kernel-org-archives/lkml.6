Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE428C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914D02075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="HTEoAy6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914D02075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeJKXCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:02:24 -0400
Received: from mail-eopbgr10132.outbound.protection.outlook.com ([40.107.1.132]:26400
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726562AbeJKXCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUc2AoIZH1OmbMOLTpZLANa0PWQdVxYltYkOQzmPwc8=;
 b=HTEoAy6SQdwn9T3edtL2VIOa1vTHptmmZ/e1DXf9iybd2tmM5ytj3zVu9LGR1cuXXdzpAw6KTxsc97CaYppGyCQZWkm3Pf7L5Y1i0yWROlf8ElCB8gLhp2xae/u9NtsQO4v4p29r+WvHaKvUsM+cZRmkTkxZ4d/ehv6fSLUY91s=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2798.eurprd05.prod.outlook.com (10.172.11.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Thu, 11 Oct 2018 15:34:35 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa%3]) with mapi id 15.20.1207.029; Thu, 11 Oct 2018
 15:34:35 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "jacopo@jmondi.org" <jacopo@jmondi.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
        "shc_work@mail.ru" <shc_work@mail.ru>,
        "haojian.zhuang@gmail.com" <haojian.zhuang@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "zonque@gmail.com" <zonque@gmail.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "philipp.zabel@gmail.com" <philipp.zabel@gmail.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "jmkrzyszt@gmail.com" <jmkrzyszt@gmail.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
Thread-Topic: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
Thread-Index: AQHUYXfqrEv1gpzeHkq8rHWTpzW6Gg==
Date:   Thu, 11 Oct 2018 15:34:35 +0000
Message-ID: <1539272073.18645.12.camel@toradex.com>
References: <CGME20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e@eucas1p2.samsung.com>
         <20180906122436.25610-1-linus.walleij@linaro.org>
         <20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e~cglSx9qcr2394623946eucas1p2y@eucas1p2.samsung.com>
         <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com>
         <c2726f18-f0cd-0d3d-c950-3e7212efd34d@nvidia.com>
In-Reply-To: <c2726f18-f0cd-0d3d-c950-3e7212efd34d@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2798;6:UjNf7SS6j7UYwTdrjpmoS4q75zoQRLluTr7FJxuWiTJ90ye9cXNyZ3Iz8ZaSkGpfBp/dyylrtSPzp2oXhbLuofjkgO9MSlivl/4hrQf5AIKxtyUyM8xvgUKhTAB2LlCu02G0FBxhFQPsn35FkSsdeuNq3I9fkXNT1ohU9V/8Hz4jm6urj4KZNReiue0yn9h8nOjwIDVP4AJiCUtpvsSfGNn104z1CgjYBxau6rq3jp564veRPCB/l57Fh+0bCoWEqEvuxL6rACG92CLeHObgNJ4RqDw0QHyD9NEKCQEiLR4uqSi34tGN6lH44d1F7yK5oYr7+cn6TS9dIfIg7a7rDodhTg/6NSg0aVApKnGOqGqNejk1U1NDloborVoxMvHsyr50Xfl8sEpiNUgkBknVIkZB0BMenHhvxtY3V/ZFZNQc3aL1b983xpsvKpFi8iOGs/z1XJbZKV4zA/g5aQRVFA==;5:a8OBrMXe+h1FSLPsvyQumuVvCxHafGKqaChB94y1EGVIr/vhghMVWUy5bdPsPfD6ts3AhIpzFR828yAbr1NOP/4A7SheVsdzyC1R1ydR94pgvbwwhexPjuR6h3wEols5rfT03ZRqF9cEuZ9wgW9N4cbSpSV+WeMCbKW0MWVkqC4=;7:1TyfZ92YWzVRJzgw0kqI33WQlcELU4oqHPXiyMbYBJBQZSNbmclLryd1X2G5n1n8ne3z99SJ51DxN76kffoac9aTHJAF6paDKQSr0OAqrIRWNUR3z0FjFC5DMN7uh+qvG2uRphCL1GyvrJiR4/uQw8GKPR7w864vmuApQhnmPILqnqISFYC9b2GE+bitS1uHht0sdz3pBd6v2pyDmfZlT8S2JYVhZShu9uWDQ24GoeYjX5jlk4gj1aLyUe1AalHF
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2e4bed1c-b726-4f88-ef5a-08d62f8f0cb6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2798;
x-ms-traffictypediagnostic: VI1PR0501MB2798:
x-microsoft-antispam-prvs: <VI1PR0501MB2798A502478B41195DBEFCD7FBE10@VI1PR0501MB2798.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR0501MB2798;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2798;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(39840400004)(346002)(366004)(189003)(199004)(99286004)(6436002)(7736002)(105586002)(66066001)(305945005)(14454004)(106356001)(8936002)(966005)(478600001)(45080400002)(4001150100001)(6116002)(97736004)(316002)(93886005)(14444005)(256004)(71200400001)(2906002)(5660300001)(71190400001)(3846002)(81166006)(81156014)(68736007)(5250100002)(2900100001)(2501003)(2201001)(575784001)(86362001)(102836004)(53546011)(486006)(6506007)(44832011)(76176011)(446003)(26005)(39060400002)(11346002)(2616005)(25786009)(6306002)(6512007)(103116003)(186003)(36756003)(229853002)(476003)(110136005)(54906003)(53936002)(6486002)(4326008)(7416002)(6246003)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2798;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: flV+6onElLl05Q7sSF2M07QBLbzExgc+G6g+3sPCCo+olZoxr9avdbNwpg4/IFdXp9KusM3lN6kEtf4UedTwhncHsNL3QudPReVDF2EoYxD4Sz3YgFjdaDFkx/M4HY4uMYPG4Km0csMqPv6XMrcMXq9uM+Skkdnc/t6NcVuTc0RtFybSD9JEjeDgh4JeUBKjnB8QwQNNVBX4RaeF0NDt0njweJLlAQsCF3IttM81JriIWxYGHnFpIPcXJtaKY6/OGCL7LjgFSKvgi2bGAtWzmSROvfQ1xMGiTV2XMMlWH+uC8zSD6KlfNxBS9slj/wk2b65arhOgci0XQvsbAZCr5NzWyAKEBbHHaBV3csyITVk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C051AF20545F74E9221CADE5728524A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4bed1c-b726-4f88-ef5a-08d62f8f0cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 15:34:35.7966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2798
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMNCg0KT24gVGh1LCAyMDE4LTEwLTExIGF0IDE2OjAwICswMTAwLCBKb24gSHVudGVy
IHdyb3RlOg0KPiBIaSBMaW51cywNCj4gDQo+IE9uIDExLzEwLzE4IDEwOjI5LCBMaW51cyBXYWxs
ZWlqIHdyb3RlOg0KPiA+IE9uIFRodSwgT2N0IDExLCAyMDE4IGF0IDExOjAxIEFNIE1hcmVrIFN6
eXByb3dza2kNCj4gPiA8bS5zenlwcm93c2tpQHNhbXN1bmcuY29tPiB3cm90ZToNCj4gPiANCj4g
PiA+IEkndmUganVzdCBub3RpY2VkIHRoYXQgdGhpcyBwYXRjaCBjYXVzZXMgcmVncmVzc2lvbiBv
biBTYW1zdW5nDQo+ID4gPiBFeHlub3M0NDEyLWJhc2VkIFRyYXRzMiBib2FyZC4gQ29udmVyc2lv
biB0byBHUElPIGRlc2NyaXB0b3INCj4gPiA+IGJyZWFrcw0KPiA+ID4gb3BlcmF0aW9uIHdoZW4g
cmVndWxhdG9ycyB1c2VkIHNoYXJlZCBHUElPOiAgc2lpOTIzNCBpMmMgZHJpdmVyDQo+ID4gPiBp
cyBub3QgYWJsZSB0byBnZXQgdmNjMzNtaGwgcmVndWxhdG9yIChpdCB1c2VzIHNoYXJlZCBHUElP
IGVuYWJsZQ0KPiA+ID4gbGluZSB3aXRoIHZzaWwxMiByZWd1bGF0b3IpLg0KPiA+IA0KPiA+IFNv
IEkgZ3Vlc3MgdGhpcyBtZWFucyB0aGF0IHRoaXMgcGh5c2ljYWwgR1BJTyBsaW5lIHdpbGwgZW5h
YmxlIHRoZQ0KPiA+IHZjYzMzbWhsIGFuZCB0aGUgdnNpbDEyIHJlZ3VsYXRvcnMgYXQgdGhlIHNh
bWUgdGltZT8NCj4gPiANCj4gPiA+IFRoaXMgaXNzdWUgaGFzIGJlZW4gYWxyZWFkeSBwb2ludGVk
IGluIGNhc2Ugb2YgY29tbWl0czoNCj4gPiA+IDM3ZmEyM2RiY2NiZDk3NjYzYWNjMDg1YmQ3OTI0
NmY0MjdlNjAzYTENCj4gPiA+IGQxZGFlNzJmYWIyYzM3N2ZmNDYzNzQyZWVmZDhhYzBmOWU5OWI3
YjkNCj4gPiA+IGFiNGQxMWUyYzIzMjljZjdjYjdiZTMxZmYyMjQ4OWFhZTRkZWU1ZGMNCj4gPiAN
Cj4gPiBBIGJpZyBzb3JyeSBmb3IgbXkgaWdub3JhbmNlLCBJIGd1ZXNzIHRoZSBpbmZvcm1hdGlv
biBvdmVybG9hZA0KPiA+IG9uIHRoZSBtYWlsaW5nIGxpc3QganVzdCBtYWtlcyBtZSBtaXNzIHRo
ZSBpbXBvcnRhbnQgcG9pbnRzLg0KPiA+IEknbGwgdHJ5IHRvIGJlIGJldHRlciwgc2FkbHkgSSBj
b25zdGFudGx5IGZhaWwgdG8ga2VlcCBldmVyeXRoaW5nDQo+ID4gaW4gbWluZCBhbmQgY29uc3Rh
bnRseSBicmVhayB0aGluZ3MgbGlrZSB0aGlzLg0KPiA+IA0KPiA+ID4gTWF5YmUgaXQgd291bGQg
YmUgYmV0dGVyIHRvIGZpcnN0IHNvbHZlIHRoZSBoYW5kbGluZyBvZiBzaGFyZWQNCj4gPiA+IGVu
YWJsZQ0KPiA+ID4gR1BJTyBpbiB0aGUgZGVzY3JpcHRvci1iYXNlZCBpbnRlcmZhY2UgYmVmb3Jl
IGNvbnZlcnRpbmcgbW9yZQ0KPiA+ID4gcmVndWxhdG9ycw0KPiA+ID4gYW5kIHN0ZXBwaW5nIGlu
dG8gdGhpcyBpc3N1ZSBhZ2Fpbj8NCj4gPiANCj4gPiBJIGFtIHRyeWluZyB0byBzb2x2ZSBpdCwg
YnV0IEkganVzdCBkb24ndCBoYXZlIHN5c3RlbXMgdG8gcmVwcm9kdWNlDQo+ID4gYWxsDQo+ID4g
a2luZHMgb2YgdGhpbmdzLiBJdCdzIGEgYml0IHN0cmVzc2Z1bCBzaW5jZSB0aGlzIGlzIG9uZSBv
ZiB0aG9zZQ0KPiA+IHJ1bnRpbWUNCj4gPiB0aGluZ3MgdGhhdCBpcyBoYXJkIHRvIHRlc3Qgd2hl
biBkZXZpc2luZyBhIHBhdGNoIGZvciBzeXN0ZW1zIEkNCj4gPiBkb24ndA0KPiA+IGhhdmUuDQo+
IA0KPiBUaGlzIGFsc28gYXBwZWFycyB0byBiZSBjYXVzaW5nIGEgcmVncmVzc2lvbiBvbiB0aGUg
VGVncmExMjQgSmV0c29uDQo+IFRLMQ0KPiB0aGF0IGFsc28gdXNlcyBhIHNoYXJlZCBHUElPIGZv
ciB0d28gcmVndWxhdG9ycy4gVGhlIDJuZCByZWd1bGF0b3INCj4gdGhhdA0KPiB1c2VzIHRoZSBH
UElPIG5vdyBmYWlscyB0byBwcm9iZSBbMF0gLi4uDQo+IA0KPiBbICAgIDAuNjgwMDIxXSArNVZf
U0FUQTogc3VwcGxpZWQgYnkgKzVWX1NZUw0KPiBbICAgIDAuNjgzOTY0XSByZWctZml4ZWQtdm9s
dGFnZTogcHJvYmUgb2YgcmVndWxhdG9yczpyZWd1bGF0b3JAMTQNCj4gZmFpbGVkIHdpdGggZXJy
b3IgLTE2DQo+IA0KPiBOb3Qgc3VyZSBpZiB5b3UgaGF2ZSBvbmUgb2YgdGhlc2UsIGJ1dCBvdGhl
cndpc2UgSSBjYW4gaGVscCB0ZXN0Lg0KDQpJIGd1ZXNzIHRoYXQgaXMgYWxzbyB3aGF0IGJyb2tl
IEhETUkgb24gQXBhbGlzL0NvbGlicmkgVDMwIGNhdXNpbmcgbWUNCnRvIHN1Ym1pdCBhIGZpeCBb
MV0uIEkgbWF5IGFsc28gaGVscCB0ZXN0aW5nLg0KDQpCVFc6IElzIGl0IG9ubHkgbWUgb3IgaXMg
dG9kYXkncyAtbmV4dCBjb21wbGV0ZWx5IGJyb2tlbiBub3c/DQoNClsgICAgMC42OTEyNThdIFVu
YWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdA0KdmlydHVh
bCBhZGRyZXNzIDAwMDAwMWY4DQpbICAgIDAuNjk5NzA0XSBwZ2QgPSAocHRydmFsKQ0KWyAgICAw
LjcwMjUxNV0gWzAwMDAwMWY4XSAqcGdkPTAwMDAwMDAwDQpbICAgIDAuNzA2MjM2XSBJbnRlcm5h
bCBlcnJvcjogT29wczogNSBbIzFdIFBSRUVNUFQgU01QIEFSTQ0KWyAgICAwLjcxMTc0OV0gTW9k
dWxlcyBsaW5rZWQgaW46DQpbICAgIDAuNzE0OTMwXSBDUFU6IDAgUElEOiAxIENvbW06IHN3YXBw
ZXIvMCBOb3QgdGFpbnRlZCA0LjE5LjAtcmM3LQ0KbmV4dC0yMDE4MTAxMS1kaXJ0eSAjMw0KWyAg
ICAwLjcyMzI0NV0gSGFyZHdhcmUgbmFtZTogTlZJRElBIFRlZ3JhIFNvQyAoRmxhdHRlbmVkIERl
dmljZSBUcmVlKQ0KWyAgICAwLjcyOTc2NV0gUEMgaXMgYXQgZ3Bpb2RfaG9nKzB4MmMvMHgxNTAN
ClsgICAgMC43MzM5MzNdIExSIGlzIGF0IG9mX2dwaW9jaGlwX2FkZCsweDM0Yy8weDUxMA0KDQpU
aGlzIGhhcyBiZWVuIG9ic2VydmVkIG9uIEFwYWxpcyBUSzEuDQoNCj4gQ2hlZXJzDQo+IEpvbg0K
PiANCj4gWzBdIGh0dHBzOi8vc3RvcmFnZS5rZXJuZWxjaS5vcmcvbmV4dC9tYXN0ZXIvbmV4dC0y
MDE4MTAxMS9hcm0vdGVncmFfDQo+IGRlZmNvbmZpZy9sYWItYmF5bGlicmUtc2VhdHRsZS9ib290
LXRlZ3JhMTI0LWpldHNvbi10azEuaHRtbCANCg0KQ2hlZXJzDQoNCk1hcmNlbA0KDQpbMV0gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE4MTAwOTE1MjUyMy4zNzcxLTQtbWFyY2VsQHpp
c3dpbGVyLmNvbQ==
