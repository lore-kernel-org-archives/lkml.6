Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648FEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2294020868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="LqA0SqtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2294020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeJLTP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:15:27 -0400
Received: from mail-he1eur01on0095.outbound.protection.outlook.com ([104.47.0.95]:43968
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726917AbeJLTP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Weu9HCvyL3JTFCMm1L5tvYut5aA/BiVYW3Dcfdn9dX8=;
 b=LqA0SqtDTl2XOiDxQwRSAEJrda7K3Y+WS21Ffc0nhFDgawNUdxMLzmziTGPk60R0i/p3KoINM8+tEZKKDVasUFOaoL6CgTo2pUwBGulaeSa3NBeyb06WHnLgI4U6DmA5aXU3s2RBK5U52KvYRDmjOKiZSfMq1oOhCoEXIHa6jLg=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2032.eurprd05.prod.outlook.com (10.167.195.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Fri, 12 Oct 2018 11:43:13 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa%3]) with mapi id 15.20.1207.029; Fri, 12 Oct 2018
 11:43:13 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Thread-Index: AQHUYXfqrEv1gpzeHkq8rHWTpzW6GqUaUfKAgAELNICAAA+OgIAAATkAgAAQpIA=
Date:   Fri, 12 Oct 2018 11:43:13 +0000
Message-ID: <1539344591.30485.28.camel@toradex.com>
References: <CGME20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e@eucas1p2.samsung.com>
         <20180906122436.25610-1-linus.walleij@linaro.org>
         <20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e~cglSx9qcr2394623946eucas1p2y@eucas1p2.samsung.com>
         <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com>
         <c2726f18-f0cd-0d3d-c950-3e7212efd34d@nvidia.com>
         <1539272073.18645.12.camel@toradex.com>
         <CACRpkdYDoFhBJy484Hvf0e+zv51w23hqtBYLFxXsiLmWs63CWw@mail.gmail.com>
         <1539337415.30485.21.camel@toradex.com>
         <c1722bee-230a-d0ad-d2de-790ab1ce9fcf@nvidia.com>
         <20181012104338.GS30658@n2100.armlinux.org.uk>
In-Reply-To: <20181012104338.GS30658@n2100.armlinux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [188.155.129.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2032;6:W4e++kMn86x1zzIPWc9NxI6jgcv6vtLvzTw1m3QRxhSLp6h9oROVGjnzRK4jDtijzXa2HVXiuIIVD/zqaDBb6VFZ7QW5X6zAK1qf7h+6eyEj519c1dFGcLvKTh0ip5FcHwpNGLUVfLB/sCR3GqGrgYxsDc1wWXS/hA/+ArUa8nUDxxrQ3p+qSphOBe7n6uvOgeWsNvScftOIRydSVAoBGEkMo7g2yftCuyUgBYq+h66/Pjn1YbrhY6BkFf7GDFc+jquarjG012+HB1M0eUN1PLT950LauIbJEWtyXvy20ymBclM7vve2w5EhMvdzf2pyQnCYZwa7T1EBk0Nx/SvEQaA/+6xdeI6fN0iNG3TDt17+yIeIftSNVXCS3vcdMQE5wP9GaUcvuhOxBXOq5T/vQIRWnWEVHVFV67XjHLXGdtIMWQA/zlkWQ9Nc937P/Bk3vTzO20aR7R2d6GlAUyWbCw==;5:OrW6fyopFzuuFXo4eN4IBpkWq6q3yAPCixDQRl1yPKHT+QxB9mP6fWLQY7DWnOVGYmUlEj8MZhXhN3EuIs7FDpgkwVg6QWAR2czlRidMk+IlAt0QOIGxUW9/0Qk//d5kRT/DX1AE8f5AyNt4gHhnX/DUS3mpUl6eYRWtWoItibs=;7:8DF2bucp1RuwIE6OS8iczyYHuwjPYWYiwlxJs1KmSBuLzIhDWUgGY/nsLLwBYr/eeDz2VrZ4fVc894v017OfcQVl61LwtCcsMcWOA2XsV5G7+r/iH8KgKfhaGibdvhgL78LIleRe1zz6HXMziR8RudWxudK1RrZI2NairDURW5jNJgqpe9RSLt2OHmj8FT3IKL6/aGboudWfGssfO4aR78hH9r+Sv4mkJiomAdajFe5CrHo0LhNPoDnDMjuz35/q
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ea133863-431b-482b-5a9a-08d63037e4ca
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2032;
x-ms-traffictypediagnostic: VI1PR0501MB2032:
x-microsoft-antispam-prvs: <VI1PR0501MB2032BC18FFF521A2A84EEECCFBE20@VI1PR0501MB2032.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);SRVR:VI1PR0501MB2032;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2032;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(366004)(39840400004)(199004)(189003)(4326008)(2616005)(11346002)(26005)(186003)(102836004)(66066001)(97736004)(44832011)(4001150100001)(476003)(2900100001)(446003)(71190400001)(6246003)(71200400001)(39060400002)(486006)(86362001)(6486002)(229853002)(68736007)(256004)(8936002)(7416002)(6436002)(316002)(103116003)(81166006)(3846002)(6116002)(8676002)(478600001)(6506007)(305945005)(54906003)(110136005)(99286004)(7736002)(5660300001)(6512007)(2501003)(5250100002)(53936002)(76176011)(93886005)(25786009)(36756003)(2906002)(81156014)(106356001)(14454004)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2032;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jjqeKio1IB/0tHOOe0OWcKEC3MbLhL4F9DwPEjyPGS1Gd58v6FCtvHZFL+hmMvzZnTtQX60q0idOqFr3Hf/AMeGOwIKmM2YTFStsaqQm65wBvfLcRYaBz8JcIkE+bJ+Qhjh3vByts9kJJKQMOs6EAuatOBP/nProXt08TXwxqYe02javy2xgebuc+VuftYtHtETOGiQO4n+wcOgW1G4ByerY2FYyhZMynm3xJyP+99D09oF+FN/Xx16GPe5nsI5EhYt88OyaF/zlFWqUqJCKYX+X7HznuD76e6fWaBp42jsTjePqxeI/iEGDZrImvz4ZQnW1ZzdXnYtLjnyHEUbJk0vs2RQNBX9eIomOrtqBSfA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BD4B64D1813F245BE7182715121AD89@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea133863-431b-482b-5a9a-08d63037e4ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 11:43:13.8004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEwLTEyIGF0IDExOjQzICswMTAwLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggd3JvdGU6DQo+IE9uIEZyaSwgT2N0IDEyLCAyMDE4IGF0IDExOjM5OjE1QU0gKzAxMDAsIEpv
biBIdW50ZXIgd3JvdGU6DQo+ID4gV2UgaGFkIHRoZSBzYW1lIHNpdHVhdGlvbiBmb3IgVGVncmEx
MjQgSmV0c29uIFRLMSBidXQgSSBkb24ndCB0aGluaw0KPiA+IHRoYXQNCj4gPiBhZGRpbmcgYSBw
c2V1ZG8gaW50ZXJtZWRpYXRlIHJlZ3VsYXRvciBpcyBjbGVhbmVyLiBJZiB0aGUgR1BJTw0KPiA+
IGNvbnRyb2xzDQo+ID4gbW9yZSB0aGFuIG9uZSByZWd1bGF0b3IsIEkgZG9uJ3Qgc2VlIHdoeSBp
cyBpdCBuZWNlc3NhcnkgdG8gY2hhbmdlDQo+ID4gdGhlDQo+ID4gRFQuIFRoZXJlIGFyZSBzZXZl
cmFsIG90aGVyIHBlb3BsZSByZXBvcnRpbmcgdGhlIHNhbWUgcHJvYmxlbSB3aXRoDQo+ID4gdmFy
aW91cyBkaWZmZXJlbnQgYm9hcmRzLiBTbyB0aGlzIGRvZXMgc2VlbSB0byBiZSBhIGNvbW1vbiB1
c2FnZS4NCj4gDQo+IEdpdmVuIHRoYXQgRFQgZGVzY3JpYmVzIHRoZSBoYXJkd2FyZSwgbm90IHRo
ZSBzb2Z0d2FyZQ0KPiBpbXBsZW1lbnRhdGlvbiwNCj4gaXQgbXVzdCBub3QgY2hhbmdlIGp1c3Qg
YmVjYXVzZSB3ZSBtb3ZlIGZyb20gR1BJTyBudW1iZXJzIHRvIEdQSU8NCj4gZGVzY3JpcHRvcnMu
DQoNClllcywgdGhhdCBJIGRvIGFncmVlLiBIb3dldmVyLCBsaWtlIG1lbnRpb25lZCBiZWZvcmUg
b24gcXVpY2sgZ2xhbmNlIEkNCnJlYWxseSBjb3VsZCBub3QgZmluZCBhbnkgZG9jdW1lbnRhdGlv
biBhYm91dCB0aGlzICJHUElPIHNoYXJpbmciIGJlaW5nDQphbGxvd2VkIG9yIG5vdC4NCg0KPiBU
aGUgZXhpc3RpbmcgRFQgZGVzY3JpcHRpb24gaXMgcmVhc29uYWJsZSwgYW5kIGludHJvZHVjaW5n
IGZpY3RpY2lvdXMNCj4gcmVndWxhdG9ycyBpbiBEVCB0byB3b3JrIGFyb3VuZCB0aGUgaW1wbGVt
ZW50YXRpb24gaXMgbm90IHJlYXNvbmFibGUuDQoNCkkgZG9uJ3QgdGhpbmsgaXQgaXMgdGhhdCBm
aWN0aXRpb3VzIGFzIGl0IG1ha2VzIGl0IGNyeXN0YWwgY2xlYXIgdGhhdA0KdGhlcmUgaXMgc29t
ZXRoaW5nIHNoYXJlZCB3aXRoIGFsbCBpdHMgcHJvcyBhbmQgY29ucy4gRS5nLiB3aGF0IGhhcHBl
bnMNCmlmIG9uZSBvZiB0aGVtIHJlZ3VsYXRvcnMgd2FudHMgdG8gdHVybiBvZmYgd2hpbGUgdGhl
IG90aGVyIG9uZSBzdGlsbA0KbmVlZHMgcG93ZXI/IFRoZSByZWd1bGFyIHJlZ3VsYXRvciBkZXBl
bmRlbmN5IHRyZWUgd291bGQgbmljZWx5IG1ha2UNCnRoaXMgYWxsIGNsZWFyLg==
