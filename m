Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A1AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD7E2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ryJ11lhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbfBFPzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:55:16 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:17924 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfBFPzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:55:15 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5b035e0000>; Wed, 06 Feb 2019 23:55:10 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 07:55:10 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 06 Feb 2019 07:55:10 -0800
Received: from DRBGMAIL103.nvidia.com (10.18.16.22) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 15:55:09 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by DRBGMAIL103.nvidia.com
 (10.18.16.22) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 15:55:08 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.58) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 6 Feb 2019 15:55:08 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2631.namprd12.prod.outlook.com (20.176.255.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 15:55:05 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 15:55:05 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V13 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V13 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvirrRqFd+/7ajEuXA8RvSaEC+KXS3a4AgAAAyeCAAAx6QA==
Date:   Wed, 6 Feb 2019 15:55:04 +0000
Message-ID: <BYAPR12MB33988DCC1F4997AAF2112447C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549464441-1836-1-git-send-email-skomatineni@nvidia.com>
 <1549464441-1836-3-git-send-email-skomatineni@nvidia.com>
 <4ecd3894-a1cb-20dd-8675-26e6e84254e7@gmail.com>
 <BYAPR12MB3398A6C76EC731D259FC3EA4C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB3398A6C76EC731D259FC3EA4C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2631;6:rwvZ4TA3zjbzNcBOzuR2/I0+sbmFwpY745uz0W6yVs/wNoxYJoQQdPlu3Lbx8INKNd7PahP5NRL/o9qZibBpt9ZgWTYLsHiQwISpa2ZC1R41UQKA2j9JWwG4nSXd77meusGHS9L5nX8kPnJ5CttO21S4Ky8G/Je7hQqXe0tiDFlbuhWaLJiLcL+wItbc13iNPuKtp06hQ/k54xiPsIJ/tLyQ6GQ5/D9wR+++1jAiS8bKjOQ7tSWMbZ7MwO3T5yceG3SwMTVD8yz5OuAn06Ped7TLDKUFDqFi7Hei1xp0efInkt4RmnjeoowaKLHzYLJb/otJyWBu5eWOcHdHPdHTayKhVetsNprZsfr89KD8MrtzjvT6FW9vjsd+QgXM3hZ61a4VKE8Ea8OW28httxlYxTnKvEWCq8swJGJp2xoqrY5QyHN4cbJ+auV/6VyUsq0drZvfgo9PbgoQObvSmFyCKA==;5:kZ0MjUFYTqZxdWiqTo68dZyjNKL2yoal9eJk8LduLSxFNhRti7L/rUrZLmjFeMGJ8hFDJibf1hm01aP4mNDYgsrd2r3ir4XSR0V/oei1yzbgVaN2Ux+/5qHJgbm+zZsP9O8G0A57m9Fncvvjn63rwBmqaqKT8my2if+O/g+MWR08JHlQ+UDeiiqHfMeX46027e5S9ilaoSPu5sxrw7ZPZQ==;7:mg+xEOAzFS2bU79kd9PAluoC7EQDOsQMIYs8a9fxganjSj/Xm7ByZoTcrINy796JfXBX/40ebjX5RpY3mvz0XZBPOFagfu8JFzia+shLTVgbX5sE3p+eifXVBgq42qg0ymp+h0gHn82Qm1oSBG+nVw==
x-ms-office365-filtering-correlation-id: ae1bf464-9002-43bb-d376-08d68c4b7624
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2631;
x-ms-traffictypediagnostic: BYAPR12MB2631:
x-microsoft-antispam-prvs: <BYAPR12MB26316803648CA5931E1F24A8C26F0@BYAPR12MB2631.namprd12.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(86362001)(71190400001)(7736002)(81156014)(6116002)(33656002)(106356001)(105586002)(68736007)(446003)(93886005)(6636002)(2906002)(2940100002)(11346002)(476003)(486006)(186003)(97736004)(2501003)(3846002)(229853002)(25786009)(9686003)(55016002)(6306002)(6436002)(66066001)(53376002)(14454004)(478600001)(966005)(53936002)(26005)(102836004)(6506007)(54906003)(110136005)(316002)(99286004)(7696005)(74316002)(6246003)(8676002)(93156006)(305945005)(8936002)(4326008)(81166006)(256004)(71200400001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2631;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sqGU1a7KMX1VuAfyLhVjMaPgjQvzvsV9RTwcpCuPfoyFhEg7N1znkx7Fha4JGgJOxZlPUXmiiyoPXMoqvVP2Ts5dGMiLfUuSYPt42JDP/nDnCNr25dS4HjQc5f7Pz6ea9+zgSy6hhZI+JID/aWReu32QSSl/BpbnQwUQuKMvN6mojXVcDFftl4hs6wc1gxafHuVQLo13Fbe/tuCSr/hqeY09EkMfKXqaI6uKgKy7KVRFcsex0/7d5gCo80xqawbKUrAJh8ZEQBWt266+5KmK8UJJ9ssysRsXb85xMadWZ9SGumSMsRT5P2XFVe0ZvLF4IVdBB85h2CHVZt3wXMD/JPsCgd9TgIyKD8xtcBhG7IweiSyaxXuzzXRiyT72HPQSUHpT7Ebedo92Zic5ikIe+GIkJNX+mDo36AW7ltivK1o=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1bf464-9002-43bb-d376-08d68c4b7624
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 15:55:05.0193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2631
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549468510; bh=r2bAK0U9bv5D82FHRGV3895+pRdICvjMs2P/epL9wqw=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=ryJ11lhfcFW+faJCPgqkbLRCMewx8HIVVeRvZI1VM0Z7f71FrCJFOjAniawGYX1UK
         xOtyimrThNLT+XjO1YWn7UsGNundXqH/h+vnYQJCagiaev88O3bCwPGdmyAxdn4FFG
         XkeDcgeJ2gRwMmqBo233rR0LpxILgnq2VXDVGktb9JArUNYfLVEphSdVeWFLtqSmga
         s4YiCWEO87acwXoJQc/tF24x5+L7qkIyXMQMr/pVZgATdSfhYLOEABUiryvM+7YPpP
         idZ/kYWweWRZL/DQsfTIbyffazJNmEA3CQna5A7WMNLY+hbEkMK9CugXzY984ACUrs
         OsPQwIpML1n2w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gPiBUd28gIjs7IiBhdCB0aGUgZW5kLg0KPiA+DQo+ID4NCj4gPg0KPiA+IEdvb2QgbmV3
czogRFZDIEkyQyB3b3JrcyBub3cgYW5kIHRwczY1ODZ4IHByb2JlcyBmaW5lISA6KSBCYWQgbmV3
czogDQo+ID4gYXRtZWwtdG91Y2ggc3RpbGwgaGFzIHNhbWUgcHJvYmxlbXMgYXMgaW4gVjEyIDoo
DQo+ID4gDQo+ID4gRE1BLW9ubHkgVjEzOiBodHRwOi8vZHBhc3RlLmNvbS8wWEoxWjhHLnR4dA0K
PiANCj4gU3RyYW5nZWx5LCB0aGVyZSBhcmUgbWFueSB0cmFuc2FjdGlvbnMgdG8gdG91Y2ggYW5k
IGFsbCBvZiB0aGVtIGFyZSBnb29kIGV4Y2VwdCBETUEgdGltZW91dCBvbmx5IHdoZW4gcmVhZGlu
ZyBUNDQgYW5kIFQ1IGF0bWVsX214dF90cyAwLTAwNGM6IEZhaWxlZCB0byByZWFkIFQ0NCBhbmQg
VDUgKC0xMTApDQoNClsgICAgMC45MjMxMzhdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHN0YXJ0
aW5nIERNQSBmb3IgbGVuZ3RoOiAxNg0KWyAgICAwLjkyMzE0OF0gdGVncmEtaTJjIDcwMDBjMDAw
LmkyYzogdW5tYXNrZWQgaXJxOiAwYw0KWyAgICAwLjkyMzMzN10gdGVncmEtaTJjIDcwMDBjMDAw
LmkyYzogdHJhbnNmZXIgY29tcGxldGU6IDEwIDAgMA0KWyAgICAwLjkyMzM0N10gdGVncmEtaTJj
IDcwMDBjMDAwLmkyYzogc3RhcnRpbmcgRE1BIGZvciBsZW5ndGg6IDEyDQpbICAgIDAuOTIzMzU1
XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB1bm1hc2tlZCBpcnE6IDBjDQpbICAgIDAuOTM1MDQ4
XSB0ZWdyYS1pMmMgNzAwMGQwMDAuaTJjOiBzdGFydGluZyBETUEgZm9yIGxlbmd0aDogMTYNClsg
ICAgMC45MzUwNThdIHRlZ3JhLWkyYyA3MDAwZDAwMC5pMmM6IHVubWFza2VkIGlycTogMGMNClsg
ICAgMS4wMjg3NTBdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IERNQSB0cmFuc2ZlciB0aW1lb3V0
DQpbICAgIDEuMDI4ODE2XSBhdG1lbF9teHRfdHMgMC0wMDRjOiBfX214dF9yZWFkX3JlZzogaTJj
IHRyYW5zZmVyIGZhaWxlZCAoLTExMCkNCg0KTG9va2luZyBpbnRvIHRpbWVzdGFtcHMgYW5kIHRy
YW5zYWN0aW9ucywgRE1BIHRpbWVvdXRzIGFmdGVyIHN0YXJ0IG9mIERNQSBmb3IgSTJDMSB0byB0
b3VjaCBkdXJpbmcgdGhpcyB0cmFuc2FjdGlvbi4NCldoaWxlIGl0IGlzIHdhaXRpbmcgZm9yIEky
QzEgRE1BIHRyYW5zZmVyLCBsb3RzIG9mIERWQyB0cmFuc2FjdGlvbnMgaGFwcGVuZWQgdGhydSBE
TUEgd2hpY2ggYXJlIHN1Y2Nlc3NmdWwNCg0KV2hhdCBpcyB0aGUgSTJDMSBzcGVlZD8NCkFsc28g
aW5jYXNlIGlmIGRldmljZSBpcyBydW5uaW5nIHNsb3cgZm9yIHNvbWUgcmVhc29uLCBwcm9iYWJs
eSB0aW1lb3V0IHdhcyBub3QgZW5vdWdoIGFzIHRoaXMgcGF0Y2ggc2VyaWVzIGNoYW5nZXMgdGlt
ZW91dCB3aXRoIGJhc2UgMTAwbVMgKyBtc2cgdHJhbnNmZXIgdGltZSBiYXNlZCBvbiB0cmFuc2Zl
ciBzaXplLg0KQ2FuIHlvdSBnaXZlIHF1aWNrIHRyeSB3aXRoIGluY3JlYXNlZCB0aW1lb3V0IGlu
Y2FzZSBpZiBkZXZpY2UgaXMgcnVubmluZyBzbG93Pw0KDQo=
