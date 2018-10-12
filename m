Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244EAC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46C620868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="T48v13Xo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46C620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbeJLUq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:46:57 -0400
Received: from mail-eopbgr10094.outbound.protection.outlook.com ([40.107.1.94]:20617
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727838AbeJLUq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxMwhiawWUVfz9npo72V7ZyAMlkM69dezPMo+G3sH/U=;
 b=T48v13Xodp6Y42uvcB5DXbFFFETA/h6XSYbPbNWXHMefnj1rRqnQuLqPfLKzZvCj00qzB58r+aMb/Ln2QHHfPyoP8JTmBIjdh0itmQJykMVNjBi7YEEt1BivXi362/Gc/95DdWWv1Ioi+V0VLcX09jm+G0Sdqi+fybSHgiFKvDc=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2654.eurprd05.prod.outlook.com (10.172.13.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Fri, 12 Oct 2018 13:13:43 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa%3]) with mapi id 15.20.1207.029; Fri, 12 Oct 2018
 13:13:43 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "jacopo@jmondi.org" <jacopo@jmondi.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
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
Thread-Index: AQHUYXfqrEv1gpzeHkq8rHWTpzW6GqUaUfKAgAELNICAAA+OgIAAATkAgAAQpICAABU9AIAABAyA
Date:   Fri, 12 Oct 2018 13:13:43 +0000
Message-ID: <1539350021.30485.45.camel@toradex.com>
References: <20180906122436.25610-1-linus.walleij@linaro.org>
         <20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e~cglSx9qcr2394623946eucas1p2y@eucas1p2.samsung.com>
         <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com>
         <c2726f18-f0cd-0d3d-c950-3e7212efd34d@nvidia.com>
         <1539272073.18645.12.camel@toradex.com>
         <CACRpkdYDoFhBJy484Hvf0e+zv51w23hqtBYLFxXsiLmWs63CWw@mail.gmail.com>
         <1539337415.30485.21.camel@toradex.com>
         <c1722bee-230a-d0ad-d2de-790ab1ce9fcf@nvidia.com>
         <20181012104338.GS30658@n2100.armlinux.org.uk>
         <1539344591.30485.28.camel@toradex.com>
         <20181012125911.GT30658@n2100.armlinux.org.uk>
In-Reply-To: <20181012125911.GT30658@n2100.armlinux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.155.129.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2654;6:Eo5lusYS0XOzz8SkL3kZQ6Go+SncY8d75k9lx1uNYfbtcADm0HG7ax33cCiIgW8TrP70sJ7NjX3uRp1EZCZXNfaNJiFwlbAwOyJ/LPjAb+tm5u+4g82WFQDq6QswSitv2LNbDCcyMnW0ZqMj2KONxSQUTyS42DUmuVGz4tvunidTnsbBZHyVT+qe6xj0+yuG34tiXruhnJxjGrEa7aJYpTE4bXgNspYcvZUXFbQT1/QXkqwdtyYslKR3I4APR18GmZDbh7N8rz/fwKlsYAVzbacZuThaaBGMveFPLSzmfzG8yGpPSe4nufKMgMM2VetbHvDX0MO3Yd0AgnCKnymimCOtkMNcjAtTWT+ZzhdgnGCwijMjhr8S1iKFdqgjeRUj8kXrhtfETwF5hYttjZs2Krd7yqhDiy3QE1It4ircI6vhQH+cXVL2gReieM8PqPL+9XjidmpJFICHNq58bSLN9g==;5:0xJ2wdxR/RivedMr0H2ixj80Hb4ud/0UDPrR/zec9c3mRD+B0kTHAlO4od4YkCvy/xdbvB8m3d5kd05mAXa36kOcNYdVPm6bR5kOosXbVUa+ZBrSK4r8ZL7ZrWZpndYq8Uvr6EtfvrC4AgimIg0HhCB5cs8+liBPjQTqmff5Jr4=;7:W4o8HtO/MB8EkN5SzYZTrtxDd8T4DEqMCJtYWYsA03Ftifg3RGjU1Szo8a1SDRNn0D4R5bVmI8Twm7mt6toTc0n7gcXkWb7P+66+uz6xKPukKUecjkfwBby3XF4KIjKKPBFg0gnHs31lS7SupeNhJQuUKhgElYOoP4yiTAQBzjhjrBrEsswYKhwJco97tCHsSpQ/KJLB3/5gvcQN4qOfsqjoJldPW/WdUxyxkEPBzW0qFxvDgzSYVVqSnv5Mdy9n
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1ec2645d-79ab-4bd0-9909-08d6304488ed
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2654;
x-ms-traffictypediagnostic: VI1PR0501MB2654:
x-microsoft-antispam-prvs: <VI1PR0501MB26549858E8C1263020A53034FBE20@VI1PR0501MB2654.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991067);SRVR:VI1PR0501MB2654;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2654;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(346002)(396003)(136003)(376002)(366004)(199004)(189003)(71190400001)(103116003)(71200400001)(105586002)(7736002)(186003)(14454004)(93886005)(81166006)(81156014)(4326008)(1730700003)(44832011)(36756003)(39060400002)(6436002)(6246003)(2501003)(6512007)(478600001)(5640700003)(6486002)(7416002)(316002)(2906002)(53936002)(8936002)(5250100002)(3846002)(6116002)(305945005)(26005)(106356001)(8676002)(102836004)(2351001)(229853002)(68736007)(6346003)(6916009)(446003)(76176011)(97736004)(86362001)(66066001)(99286004)(11346002)(25786009)(476003)(54906003)(486006)(256004)(2616005)(5660300001)(2900100001)(6506007)(4001150100001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2654;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-microsoft-antispam-message-info: D9nk/FK3c4idoP5lprGMTHBDrUerfwRDifn0AHCs64aym99dgCWHc8fG+DIaD638+EzvKEA9EqSdE8rsQVmFwUEYbqXr+dcutJrlBQ8wC+ruprRShjdOYL7gtefGn3oiBGeO2Nvx2VDqVBEVAw2+JQEcWVXsfY0Oi0UUwX8Gz5KbKoYkgZWvdBCq7PQYq5rZO1rmMa6Men6Lz1TKfMNlzrzmpOeCvIfaCqaJrOTVZrbt3FOmo0Yc91N1SKpuauFExL/M1UWVwPIjyJB9sZO1NrAkNf9uT0qcyr9XIZWZ9GLPiMHjRGo7EeQVyNbonQFIWbcz7zmemdqu6Zj1paNFQkr1gkQepfxWIQXeg+9VU1A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F22801CE320C904D97148006A4A0711B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec2645d-79ab-4bd0-9909-08d6304488ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 13:13:43.1164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2654
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEwLTEyIGF0IDEzOjU5ICswMTAwLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggd3JvdGU6DQo+IE9uIEZyaSwgT2N0IDEyLCAyMDE4IGF0IDExOjQzOjEzQU0gKzAwMDAsIE1h
cmNlbCBaaXN3aWxlciB3cm90ZToNCj4gPiBJIGRvbid0IHRoaW5rIGl0IGlzIHRoYXQgZmljdGl0
aW91cyBhcyBpdCBtYWtlcyBpdCBjcnlzdGFsIGNsZWFyDQo+ID4gdGhhdA0KPiA+IHRoZXJlIGlz
IHNvbWV0aGluZyBzaGFyZWQgd2l0aCBhbGwgaXRzIHByb3MgYW5kIGNvbnMuIEUuZy4gd2hhdA0K
PiA+IGhhcHBlbnMNCj4gPiBpZiBvbmUgb2YgdGhlbSByZWd1bGF0b3JzIHdhbnRzIHRvIHR1cm4g
b2ZmIHdoaWxlIHRoZSBvdGhlciBvbmUNCj4gPiBzdGlsbA0KPiA+IG5lZWRzIHBvd2VyPyBUaGUg
cmVndWxhciByZWd1bGF0b3IgZGVwZW5kZW5jeSB0cmVlIHdvdWxkIG5pY2VseQ0KPiA+IG1ha2UN
Cj4gPiB0aGlzIGFsbCBjbGVhci4NCj4gDQo+IElmIHlvdSdyZSBpbnRyb2R1Y2luZyBhIHJlZ3Vs
YXRvciB0aGF0IGRvZXNuJ3QgZXhpc3QgaW4gcmVhbGl0eQ0KPiBqdXN0IHRvIGJlIGFibGUgdG8g
c2hhcmUgYSBHUElPIGxpbmUgdGhhdCBpcyB3aXJlZCB0byBzZXZlcmFsDQo+IHJlYWwgcmVndWxh
dG9ycywgdGhlbiBpdCBfaXNfIGZpY3RpY2lvdXMuICBZb3UncmUgbm90IGRlc2NyaWJpbmcNCj4g
dGhlIGhhcmR3YXJlLCB5b3UncmUgZGVzY3JpYmluZyBzb21ldGhpbmcgZWxzZSB0byB3b3JrIGFy
b3VuZCB0aGUNCj4gc2hvcnRjb21pbmdzIG9mIHRoZSBpbXBsZW1lbnRhdGlvbiB0aGF0IGNhbid0
IGNvcGUgd2l0aCBob3cgc3R1ZmYNCj4gaXMgd2lyZWQgdXAgaW4gdGhlIHJlYWwgd29ybGQuICBZ
b3UncmUgbWFraW5nIHRoZSBEVCBkZXNjcmlwdGlvbg0KPiBmaXQgdGhlIHNvZnR3YXJlIGltcGxl
bWVudGF0aW9uLCByYXRoZXIgdGhhbiB0aGUgc29mdHdhcmUNCj4gaW1wbGVtZW50YXRpb24gZml0
IHRoZSByZWFsIHdvcmxkIGhhcmR3YXJlLg0KPiANCj4gSGF2aW5nIGEgc2luZ2xlIEdQSU8gdGhh
dCBjb250cm9scyBtdWx0aXBsZSBzZXBhcmF0ZSByZWd1bGF0b3JzDQo+IHdoaWNoIGhhdmUgZW50
aXJlbHkgc2VwYXJhdGUgc3VwcGxpZXMgb2YgdGhlaXIgb3duIGlzIHZlcnkgY29tbW9uDQo+IGlu
IGVsZWN0cm9uaWNzLg0KDQpTdXJlLCBmaW5lLiBJIHdpbGwgZHJvcCBpdC4gVGhhbmtzIQ==
