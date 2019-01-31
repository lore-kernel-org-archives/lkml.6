Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6495C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67135218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gn+LQynX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbfAaQ5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:57:01 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11908 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbfAaQ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:57:00 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5328dc0001>; Thu, 31 Jan 2019 08:57:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 31 Jan 2019 08:56:58 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 31 Jan 2019 08:56:58 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 16:56:58 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.53) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 31 Jan 2019 16:56:58 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3174.namprd12.prod.outlook.com (20.179.92.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Thu, 31 Jan 2019 16:56:56 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 16:56:56 +0000
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
Subject: RE: [PATCH V8 3/5] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V8 3/5] i2c: tegra: Add DMA Support
Thread-Index: AQHUuSyS8D4y2PEYbkigLw9+iOz1C6XJfImAgAADNwCAABXfQA==
Date:   Thu, 31 Jan 2019 16:56:56 +0000
Message-ID: <BYAPR12MB3398CFEE7E912513AE48DD2FC2910@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
 <1548915387-28826-3-git-send-email-skomatineni@nvidia.com>
 <4663c7b9-d306-1cd4-1bdc-f7be84af0667@gmail.com>
 <8a88f8ee-24d3-00ac-f1fa-c43b576ed82c@gmail.com>
In-Reply-To: <8a88f8ee-24d3-00ac-f1fa-c43b576ed82c@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3174;6:uMWM/euWSLC7+gCt082keeE7WXXeFM7bAIkxytHCZJQoLHKFxWggHZhP1QzuFOx4FznSObFMwFo0KeThhnB5o2VO7DGTHsCMHsUGknwG1gztnNRuWwfGLPIgL2Gb57knSIhsK6k7deVplcM5M7Wk3iRF12fd5nrIpqPmgnEKTvJd62/AdmCOnJ+bB1h3DcXorZAqhlkH8fqjJbQHV7hl7wp4Kham2X+fbaT5sQfYl5ANuol0sASau2DMgRV9LOVcE5dYED1CpjdD917sx3Xtr+4LvT9oSm7bvoGpkn/8RTfwNRHp0zsZB8GKAPGVddi6B8BbfBpyyBfvwZard8bYaSQl2Dd7Sa1fxrsxrsvfmPeT1fGN2WDPmNMevFWZLrRnNmeqpvRWq/kFr/Qy5uTvIJbd6fBg2OoF1z4wFj9fbYHASgivKXkGpCMAFMZiwjJcI1u7yWfziQxXfCe9LnVO6w==;5:vubZTLPQgm+gP3Cx2xYax1h/1Vpbbg3sSxLhnAFbVJ+GERwPHs5XD3UOR9xcI8MS90lNGtLZyMWW3f68yaK1Uup8UsebXuCF+8nQQ8dmQ3i2NGBGrsxGXNo/DIgeDsHf6VuVgJLz5CZEu5RGDAEGVkCmdxOm51oCR7XnC5XODeWgHdrk3YmVCXwAOJN3GnpNa+e/Y1vGwwTobQ95IKrG/A==;7:hlRY4+gnjC/h0LNNCXHuniddpzHuyUgdunjp0sW3A0SExjktErqfMyVK65CgFq87WeDMpJKhe/P0hTy2LDcPxrAmBDcbWHoSGNp2IryPtHQfOSP3aSMq46y6I2SCPXpMqxLm7vcoTdflmWJXeU0IcA==
x-ms-office365-filtering-correlation-id: d559486e-793f-4f96-980a-08d6879d1be9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3174;
x-ms-traffictypediagnostic: BYAPR12MB3174:
x-microsoft-antispam-prvs: <BYAPR12MB31744528D4D754C5B04CB400C2910@BYAPR12MB3174.namprd12.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(486006)(6506007)(102836004)(39060400002)(11346002)(33656002)(6636002)(66066001)(186003)(97736004)(4326008)(446003)(26005)(105586002)(2906002)(476003)(106356001)(99286004)(93886005)(6246003)(14454004)(316002)(478600001)(256004)(71200400001)(7696005)(25786009)(110136005)(7736002)(81166006)(6436002)(81156014)(8676002)(55016002)(71190400001)(6116002)(3846002)(53936002)(68736007)(305945005)(229853002)(8936002)(86362001)(4744005)(54906003)(9686003)(74316002)(76176011)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3174;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: euXbPS/W0IM5SFv+2y+/wL8J6JpkEGPCJDYNcaPxw+epXx8dGHrrafCYwFvp2l5yBPjiEglOnIEJ5jz26dnq2jg6LBCdcnwMAz4/VDhJNJrsknsGCYGBKxsnFzDx2C+cfchE9Qg7Wx22N2jqaHZyMWfsLzbaf8cqDT/jOnYISnT9TpCJ7sZ73ztXGncpnGR2B1KBrOlQThKPoeoQgtj32ej4dRgspzwsArfRdBFu0uiFd8yHx0SBAy4Q3PFbZLrCKOWpdlsr4U1DJkS3B66f0Fck4ot0sTJukLtZYpQorM5KxbZ6IMnfhC0yPs1TP9a1RcpSmlwPEQTZzFX3wGALFkhzO2XABlpjWtpesRbtYXJuO7urECAjK347TthGlpH+XTdV8327CAcWgig/5W2EmADy1EXJBOWNM45aLtu/tho=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d559486e-793f-4f96-980a-08d6879d1be9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:56:56.5631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3174
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548953820; bh=ZyZnbuep8DtStIijkl7jsBpPgZxsWCzqO5x6ox+p9aA=;
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
        b=gn+LQynXYdd70J+giD9d2txLT+SYvio3555mcf2i0vH30wwj4QikilHbKTHWFELWY
         YXTchPO08TgvOjMfrlPTiCzbR7t4sfmu5gyA3sSz4ebWH8zf2h7BbET1xBj1xHQH7d
         Um2bIRkubSurKjBTRgklw3hzyNLMEFJQ6gXh3ZaTYCcQLqMU8kyjEuBP9QjhR207nG
         AQ881CqqbDS21S+ZCHrB6lrdqfu+4IsYbyWdXY8j/SSJkiniiyH8tAs0wOS7AB6d8E
         lwMbMZauuow4yWG0qiF8KNLcEzYy2vwq9HDfoMzTgfgs19JCjAj6+Yzxl02IQViFWW
         1b55feC/Ur3ng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4+ICBkcml2ZXJzL2kyYy9idXNzZXMvS2NvbmZpZyAgICAgfCAgIDIgKy0NCj4gPj4gIGRy
aXZlcnMvaTJjL2J1c3Nlcy9pMmMtdGVncmEuYyB8IDM2MiANCj4gPj4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gPj4gIDIgZmlsZXMgY2hhbmdlZCwgMzM5IGlu
c2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IFRlZ3JhMjAgY3Jhc2hlcyBi
ZWNhdXNlIG9mIHRoaXMgcGF0Y2g6DQo+ID4gDQo+IFtzbmlwXQ0KPiA+IDw0PlsgICAgMy4zOTU5
MTVdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiA+IDwyPlsgICAgMy4z
OTU5MTldIGtlcm5lbCBCVUcgYXQgZHJpdmVycy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jOjgxMCEN
Cj4gVGhlIEJVRyBsaW5lIGlzIGZyb206DQo+DQo+CWlmIChzdGF0dXMgJiBJMkNfSU5UX1BBQ0tF
VF9YRkVSX0NPTVBMRVRFKSB7DQo+CQlpZiAoaTJjX2Rldi0+aXNfY3Vycl9kbWFfeGZlcikNCj4J
CQlpMmNfZGV2LT5tc2dfYnVmX3JlbWFpbmluZyA9IDA7DQo+CQlCVUdfT04oaTJjX2Rldi0+bXNn
X2J1Zl9yZW1haW5pbmcpOw0KPgkJY29tcGxldGUoJmkyY19kZXYtPm1zZ19jb21wbGV0ZSk7DQo+
CX0NCj4NCkJVR19PTiBsaW5lIGlzIG5vdCBwYXJ0IG9mIHRoaXMgY2hhbmdlLiBJdCB3YXMgYWxy
ZWFkeSB0aGVyZSBpbiBleGlzdGluZyBkcml2ZXIuDQpCYXNlZCBvbiBsb2csIEkgc2VlIERNQSB0
cmFuc2ZlciBpcyBkb25lIGZvciAyMjQgYnl0ZXMgZm9sbG93ZWQgYnkgMSBzdWNjZXNzZnVsIFBJ
TyB0cmFuc2ZlciBhbmQgdGhlbiBvbiBuZXh0IFBJTyB0cmFuc2ZlciBpdCByZWNlaXZlZCBwYWNr
ZXQgeGZlciBjb21wbGV0ZSBpbnRlcnJ1cHQgd2l0aCBpbmNvbXBsZXRlIHRyYW5zZmVyIGJ5dGVz
IGFuZCB0aGF0IHdoZXJlIGl0IGhpdCBCVUdfT04gY29uZGl0aW9uLg0KDQoNCg==
