Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB23CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679042075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="eAi9n6y5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679042075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeJLRPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:15:32 -0400
Received: from mail-db5eur01on0114.outbound.protection.outlook.com ([104.47.2.114]:60498
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727808AbeJLRPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqDSZ8NtocXkrY1Ff6W8KVlTDpuz1YpZLTFwAQ8NMWA=;
 b=eAi9n6y5lpXHbXvPuibRqSixktW7/q1C0YhQhtR7WduFYok4/EwieYVwaya6f/63Ry3EfgVSmREAsp3rWJEAZzN/VBJ8/5ZrgL/yHJLimZy3/euQhMcKrz6mKGmBuECG3ckVqmR3zH4csJDtUG+v4C+EEOpWiv/XPSG5mDODkoE=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2606.eurprd05.prod.outlook.com (10.168.137.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.28; Fri, 12 Oct 2018 09:43:38 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa%3]) with mapi id 15.20.1207.029; Fri, 12 Oct 2018
 09:43:38 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "jacopo@jmondi.org" <jacopo@jmondi.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
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
Thread-Index: AQHUYXfqrEv1gpzeHkq8rHWTpzW6GqUaUfKAgAELNIA=
Date:   Fri, 12 Oct 2018 09:43:37 +0000
Message-ID: <1539337415.30485.21.camel@toradex.com>
References: <CGME20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e@eucas1p2.samsung.com>
         <20180906122436.25610-1-linus.walleij@linaro.org>
         <20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e~cglSx9qcr2394623946eucas1p2y@eucas1p2.samsung.com>
         <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com>
         <c2726f18-f0cd-0d3d-c950-3e7212efd34d@nvidia.com>
         <1539272073.18645.12.camel@toradex.com>
         <CACRpkdYDoFhBJy484Hvf0e+zv51w23hqtBYLFxXsiLmWs63CWw@mail.gmail.com>
In-Reply-To: <CACRpkdYDoFhBJy484Hvf0e+zv51w23hqtBYLFxXsiLmWs63CWw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [188.155.129.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2606;6:dvPaHTA1SjCQklCUYZ4DMAP0p1Aqgey6TsvDJ3SUFmwEMWgcnf7KHpVekGjtYVqjJqviIksa1UAyJbIPP7RdjiWiaoffmyzL53Mq/gpAk5bxXKb7BQdrRGXGHH7D1PKBvC6knFDfcKhB4cVQlayiRCZmzAfz9stgHcNyUFi+JTGzs9jnVriJPnTIRBsxCaJC/F+GFZp7bgqaPM7XGt5DTTqC1cHBg31R3k7nvxJjgXYALRQR8/ar7BR7+czKaxWHYUlz8F5q95AVG+Kfmrv7OH8+VZ1AaD/1mRxzqfRH1SvzSql07aX0PKXxAsqeIHtBaJ+GwygYF/uXvLjbMj58rs8VXpId+guAKh7cekPdSWo0LI9ne/0nhzRoTvYkettCmf6BoYNxVlG5Jw6Qv4Zb447ycgyYl3wkOQ4agRMmEkBFI1jsEBymxbPnBDtQloxD4Xl7M5NKS0kAwZzP2GYmrQ==;5:7fBZPKnOEjk8AAzGll7iw8r0mxCemvWEvAXuh8tmQs5O8onfW/V7qE5mYmC6iXnV78A3fHPXAaMYLe/MoySQ2mbU75l1T1tTDpEdIWdi/bA6XNZ/6suvYA881GtsD2FtMxAJPXk9eq5oTtJdGTG1P0kJqiv4HCmw0eHMjXoE4JM=;7:gYYLMxDKXaff8tNb42dxjb26j1dcGHn1tOsM6kqW3ZxaylW61FqgS3/AhDX2zVyEY1eK6acJFAbwU01sq3sEfmUsz5oMnSNu34McczPAA6ze7AZQdcA3XlLo8f+DqT/uPLF6uRJcMF9JgtMiWPBKdNfxfKrdP+AEwmSD1NZLSD5mhCTsyxWx4f6FE1Ic0MjiBs4BDwMbzOg+t+cJltWcQ88illQzoeu5I3VHfCN6L4NFztOn23Re7aOob9NwDhau
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cbe89234-e139-4cb3-342a-08d630272f9b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2606;
x-ms-traffictypediagnostic: VI1PR0501MB2606:
x-microsoft-antispam-prvs: <VI1PR0501MB2606FDA29CF1C1926D83A2B3FBE20@VI1PR0501MB2606.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991067);SRVR:VI1PR0501MB2606;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2606;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39840400004)(376002)(346002)(366004)(189003)(199004)(476003)(486006)(6436002)(11346002)(446003)(5640700003)(53936002)(6916009)(5660300001)(44832011)(2616005)(6306002)(6512007)(81166006)(81156014)(2351001)(66066001)(8676002)(106356001)(105586002)(5250100002)(2501003)(2900100001)(229853002)(97736004)(4001150100001)(6486002)(4326008)(103116003)(8936002)(36756003)(6246003)(966005)(39060400002)(2906002)(7736002)(6116002)(305945005)(71190400001)(71200400001)(99286004)(478600001)(25786009)(53546011)(6506007)(76176011)(26005)(68736007)(3846002)(14454004)(54906003)(186003)(93886005)(256004)(7416002)(86362001)(316002)(102836004)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2606;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4cHfggKomzvf7g8k/WTWSovzGaDaeRPcSwHOf7xAMQsnpDktmflnSQDpsahVym8TvbX8CCETMnEelvI+soNo9S2qvJmzxXYo0Hoe/QONyRZhSHv+xRNCIpxRTj8HmK0n5mnOF/ePUyGY/ELKqYXOfweuHAPJpckA6sBAypk9nfAjf8DfBRRdwB0Nqj6WbUWoy2H5QbSjCVF29ZtJM6FPAkiv7mIF5Ry573uoAa44JHB+DbfZVA3MJW7zXG1N+lxEWp1PPN+OKd0X9ycPobUHi/LKMTIs8RDoZJ2zW0YpuzGnPvGdo5TsJVEUinkuZxqwPw/DkxahYtVwLCtKv5BedwSMFpm9poR0xZUYTiDO9Zg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3140E6B455FBA04390E32157F31E1659@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe89234-e139-4cb3-342a-08d630272f9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 09:43:37.8160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2606
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTEwLTExIGF0IDE5OjQ3ICswMjAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0K
PiBPbiBUaHUsIE9jdCAxMSwgMjAxOCBhdCA1OjM0IFBNIE1hcmNlbCBaaXN3aWxlcg0KPiA8bWFy
Y2VsLnppc3dpbGVyQHRvcmFkZXguY29tPiB3cm90ZToNCj4gDQo+ID4gSSBndWVzcyB0aGF0IGlz
IGFsc28gd2hhdCBicm9rZSBIRE1JIG9uIEFwYWxpcy9Db2xpYnJpIFQzMCBjYXVzaW5nDQo+ID4g
bWUNCj4gPiB0byBzdWJtaXQgYSBmaXggWzFdLiBJIG1heSBhbHNvIGhlbHAgdGVzdGluZy4NCj4g
DQo+IEkgc2VlIHRoZXJlIGFyZSBtYW55IHdheXMgdG8gc2tpbiB0aGlzIGNhdC4NCg0KWWVzLCBh
cyBhIG1hdHRlciBvZiBmYWN0IEkgc2NyZWVuZWQgdGhlIGtlcm5lbCBjb25jZXJuaW5nIHRoaXMg
bXVsdGkNCmdwaW8gc3R1ZmYgYnV0IGNvdWxkIG5vdCBxdWl0ZSBmaW5kIG1hbnkgZXhhbXBsZXMg
YW5kIG5vIG1lbnRpb25pbmcNCmFueXdoZXJlIHdoZXRoZXIgb3Igbm90IHRoaXMgaXMgYWN0dWFs
bHkgYWxsb3dlZC4gU28gSSBraW5kIG9mIGFzc3VtZWQNCnRoYXQgdGhpcyBtYXkganVzdCBub3Qg
cmVhbGx5IGJlIGFsbG93ZWQgYW5kIGNvb2tlZCB1cCBteSBwYXRjaCB3aGljaA0KaXMgYW55d2F5
IGtpbmQgb2YgYSBjbGVhbmVyIHNvbHV0aW9uLiBJIG1lYW4gZXhwbGljaXRseSBtb2RlbGxpbmcg
dGhlDQpHUElPIGludG8gc29tZSBpbnRlcm1lZGlhdGUgcmVndWxhdG9yIHN1cHBseWluZyB0aGUg
b3RoZXJzLg0KDQo+IERvZXMgdGhpcyBwYXRjaCBmaXggdGhpbmdzIGZvciB5b3UgYXMgd2VsbD8N
Cj4gaHR0cHM6Ly9tYXJjLmluZm8vP2w9bGludXgta2VybmVsJm09MTUzOTI2ODU0MzI3MTc2Jnc9
Mg0KDQpZZXMsIGRhLWRhIGFuZCBIRE1JIHdvcmtzIGFnYWluLiBUaGFua3MhDQoNCkkgd2lsbCBz
dGlsbCB0cnkgdG8gZ2V0IG15IG90aGVyIHBhdGNoIGluIGFzIGxpa2UgbWVudGlvbmVkIGFib3Zl
IEkNCmZlZWwgaXQgaXMgYSBjbGVhbmVyIHNvbHV0aW9uIHRvIG91ciByZWd1bGF0b3Igc2V0dXAu
DQoNCkJUVzogSGF2ZSB5b3UgaGVhcmQgb2YgbG9yZSBhcyB3ZWxsPyBJIGJlbGlldmUgaXQgaXMg
dGhlIGJldHRlciBtYWlsaW5nDQpsaXN0IGFyY2hpdmUgYXMgb2YgdG9kYXk6DQoNCmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvMjAxODEwMTExNDM1MzEuNzE5NS0xLWxpbnVzLndhbGxlaWpA
bGluYXJvDQoub3JnLw0KDQo+IFlvdXJzLA0KPiBMaW51cyBXYWxsZWlq
