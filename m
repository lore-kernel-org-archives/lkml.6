Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF89EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA02620855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CwfeA0Zf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfBHP6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:58:22 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:38496 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfBHP6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:58:22 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5da71d0000>; Fri, 08 Feb 2019 23:58:21 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 08 Feb 2019 07:58:18 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 08 Feb 2019 07:58:18 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 15:58:17 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.56) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 8 Feb 2019 15:58:17 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3064.namprd12.prod.outlook.com (20.178.54.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Fri, 8 Feb 2019 15:58:13 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 15:58:13 +0000
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
Subject: RE: [PATCH V15 4/6] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V15 4/6] i2c: tegra: Add DMA support
Thread-Index: AQHUvy64ygjLqqj+r0yzTYtI5VJ73KXV2pEAgAAvldCAAARMAIAAAN1w
Date:   Fri, 8 Feb 2019 15:58:13 +0000
Message-ID: <BYAPR12MB339863A43F030013DCA7F548C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549576040-15907-1-git-send-email-skomatineni@nvidia.com>
 <1549576040-15907-4-git-send-email-skomatineni@nvidia.com>
 <7806f2cd-72b4-6ae3-b75f-0fc74fb62b95@gmail.com>
 <BYAPR12MB3398BE6DA6F1E82E5F2525C2C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB3398382FF9052AE466CE29ECC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB3398382FF9052AE466CE29ECC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3064;6:+gXUlD+l+hHaw2/hEk6sS8FNaIwAnBGpwhlVgsBPSa3qtGc+6F72QI2U7iHm3ijXvfGOjDkSKvTojYKakVfG0JRiHa9+Yh9r1KS6T9TVEUFzHTO0gk2Y4gr0eLbGwwoRn51MPBM2Jo2pcY7Ynp6KTW4noAUUfKQTZuclIfsRGOS+5hq7rpGHcwgV3mEkn1g2M4Q1utwN/klL4000D3W7lzrXxdjUMJdPvyw75CnIPxFLcv6qKiYf2MSpQOo5nLjMqb+CptKpmUdAWfiS6kAOB3EC4PCnAmoLgq5HRlnzYx8vUZR2ksKr7iZPjPLvGNCztQg5FTspBONkaQeALfgMNtFxShLYjYkXZ+0ZzJuP0ducHdOYk83LR9+aYX1ZJbdvo+O1pSIdE0W56sbOgbzNbzTqGkcsJXZbj+bX0XskBNWKhsWm6OK+mfHYk8i71Sf6mbEzWQpD3nRyUVmfUIULzA==;5:tm5Alh1SNL9e29Lr87PTAKFy0scC9CF+E40HtW5JN2karBLDe/et734RAtz0fC7EEQMRLc+/RKw6Qo9hAusqZcp+Rq0HPi+D0X/Yu69nnxXfvwXtUwpPAQDmQUS/HAUbd8BL/dA2FFrZVMPngLo1x/gNAXWXcBJwX+XrUo6s2lyoI3DvyzTc4QAd7yO4G1cW/8jNmZ7CeMgibkBy4m7WcQ==;7:D0p0xinU3/FtupxOiX3TOtJSyGBoD9gT1abjAcEU2obVhQFMj1/oBWjwVpGfAOgLLbDrQFzFCxX/PwVoOUtlwhKx33pTTPotz3gNmyQJSXJMhyYlS/ugHw9YjZPzyDUUXQHIFNjG377Q0Wix+1gPnQ==
x-ms-office365-filtering-correlation-id: d1bc9e7b-38dc-411c-34d9-08d68dde3b56
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3064;
x-ms-traffictypediagnostic: BYAPR12MB3064:
x-microsoft-antispam-prvs: <BYAPR12MB3064083963FA711AC53E381EC2690@BYAPR12MB3064.namprd12.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(366004)(376002)(136003)(199004)(189003)(8676002)(305945005)(93156006)(53936002)(71200400001)(105586002)(71190400001)(106356001)(66066001)(7736002)(8936002)(93886005)(33656002)(14454004)(74316002)(81156014)(6436002)(2906002)(81166006)(14444005)(256004)(9686003)(6636002)(2940100002)(68736007)(76176011)(2501003)(7696005)(229853002)(486006)(99286004)(25786009)(4326008)(11346002)(6506007)(102836004)(86362001)(3846002)(476003)(446003)(6116002)(316002)(54906003)(6246003)(97736004)(26005)(110136005)(186003)(55016002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3064;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5Iw26ada9i4xrd3aBiIOFlLiYtSmAlxJ26t0lbFIoYbuEV+XKEsXEbvBDVpsoYGOa3/bMhIk+nEsUNMBPlciQvDgfR5Fg+hGL5N/pzVfGH8qOcum7xZU/32myxc+SU28hYA673CJuOO1yXcXD74EkwjWbnyO3C/1TO3pzje9c+LGIY1Y/gu7V8qK5Sbn8uadUI38xtpMfR/BYIH0MtLUe0i7gdz9tW0Sc1v6PV912OgCW6MTI4FiEbsMpolnPClkYAEnr2RLK0JcoRoSZwhJ8Lky8IsM7XPyreW66v5BIbdi8joUULpLPda/VfMgk8qc01z5jYhphXv08u4Nxe/mlSCAhZ4pIrBjh8/qHIuEde8LjHBYTe6sqyViU3NHQUF9CZSPnGIYb05JmKkS++AWFtUXwzKLcj44SZ/RyXLBe0I=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bc9e7b-38dc-411c-34d9-08d68dde3b56
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 15:58:13.5103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3064
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549641501; bh=/88oILZnGMBpGJYa9K5ZOguO9MqtnosnEOtliaOHK+o=;
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
        b=CwfeA0ZfbOZvigwnV3MO8Dqv2MDLllwli2Sn7NRInF3uoSjgCSh2Pd6Z0LTbpb46l
         NIFZVonuP9flDLDhiC6KZ/uAZfZzIb1D57PI11QKIlUmx51kDGDexjojeYLfazX1WK
         sczSAeYg5xaA07V4UwB+4zCLIppLby5OIRo2LT2W4tZLyKpKjxli00KNAAiepv2u2j
         mb+S0g6KemwER69haJV2Z5Mv/36b2a68uLgXA59/+WDSGX+NBBUKwiYCiYgh9Vlxm2
         Z2h7ihozetedLmqmqKzPgbv1heu1sVspA1uA6mfN1xGin1EoAsLAO+lAPppsLLVKO/
         mb5DHVMVG843Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gPiBQbGVhc2UgdXNlICJyZWxlYXNlX2RtYToiIHZhcmlhbnQgdGhhdCBJIHN1Z2dlc3Rl
ZCBpbiB0aGUgY29tbWVudCB0byB2MTQgYmVjYXVzZToNCj4gPiA+DQo+ID4gMSkgSXQncyBqdXN0
IGEgZ29vZCAoYW5kIGNvbW1vbi1zdHlsZSBpbiBrZXJuZWwpIHRvbmUgdG8gdW53aW5kIGVycm9y
cyBoYW5kbGluZyBpbiB0aGUgb3Bwb3NpdGUgb3JkZXIsIGl0IG1ha2VzIGNvZGUgbW9yZSBzdHJh
aWdodCBmb3J3YXJkIGFuZCBoZWxwcyB0byBhdm9pZCBzaWxseSBtaXN0YWtlcy4NCj4gPg0KPiA+
IDIpIEl0IGtlZXBzIHRoZSBjdXJyZW50IGNvZGUgY29uc2lzdGVudCBpbiByZWdhcmRzIHRvIHBy
b2JlIGVycm9yLWhhbmRsaW5nLg0KPiA+DQo+DQo+IENhbiBtb3ZlIHRlZ3JhX2kyY19yZWxlYXNl
X2RtYSB1bmRlciB0aGUgc2FtZSBkaXNhYmxlX2Rpdl9jbGsgbGFiZWwgYmVmb3JlIGNsa19kaXNh
YmxlDQo+DQo+IE9yZGVyIGluIHByb2JlIGlzDQoJY2xrX3ByZXBhcmUNCglpMmNfcnVudGltZV9y
ZXN1bWUNCgljbGtfZW5hYmxlIGluIGNhc2Ugb2YgbXVsdGltYXN0ZXIgbW9kZQ0KCWkyY19pbml0
X2RtYQ0KPg0KPiB1bndpbmRpbmcgc2hvdWxkIGJlIG9yZGVyIGlzDQoJcmVsZWFzZV9kbWENCglk
aXNhYmxlX2Rpdl9jbGsNCglkaXNhYmxlX3JwbQ0KCXVucHJlcGFyZWQNCj4NCj4gUHJvYmUgZmFp
bHVyZSBmcm9tIHRlZ3JhX2kyY19pbml0X2RtYSwgdGVncmFfaTJjX2luaXQsIGRldm1fcmVxdWVz
dF9pcnEsIGkyY19hZGRfbnVtYmVyZWRfYWRhcHRlciBhbGwgb2YgdGhlbSBwZXJmb3JtIGdvdG8g
ZGlzYWJsZV9kaXZfY2xrDQo+DQo+IEkgY2FuIGFkZCB0ZWdyYV9pMmNfcmVsZWFzZV9kbWEgYmVm
b3JlIHBlcmZvcm1pbmcgY2xvY2sgZGlzYWJsZSB1bmRlciBzYW1lIGRpc2FibGVfZGl2X2NsayBz
byBhbGwgZXhpc3RpbmcgZGlzYWJsZV9kaXZfY2xrIGxhYmVscyByZW1haW4gc2FtZS4NCj4gT3Ro
ZXJ3aXNlIGFkZGluZyBuZXcgbGFiZWwgcmVsZWFzZV9kbWEgY2F1c2VzIGFsbCBnb3RvIGRpc2Fi
bGVfZGl2X2NsayBzdGF0ZW1lbnQgYWxzbyB0byBiZSBjaGFuZ2VkIGJ1dCBpdHMgc2FtZSBhcyBh
ZGRpbmcgcmVsZWFzZV9kbWEgdW5kZXIgZGlzYWJsZV9kaXZfY2xrIGFib3ZlIHRoZSBjbGtfZGlz
YWJsZS4NCj4NCg0KT0ssIHBsZWFzZSBpZ25vcmUgYWJvdmUuIHdpbGwgYWRkIHJlbGVhc2VfZG1h
IHRvIHNob3cgZXhwbGljaXRseSBmb3IgcmVhZGFiaWxpdHkuDQpXaXRoIHJlbGVhc2VfZG1hIGFs
bCBlcnJvciBoYW5kbGVycyBwZXJmb3JtaW5nIGRpc2FibGVfY2xrX2RpdiBuZWVkIHRvIGdvIHRo
cnUgcmVsZWFzZSBkbWEgYW5kIGRpc2FibGVfY2xrX2RpdiBsYWJlbCBpcyBub3QgbmVlZGVkLg0K
U28gaGF2aW5nIHJlbGVhc2UgZG1hIHVuZGVyIGRpc2FibGVfY2xrIGJlZm9yZSBjbGtfZGlzYWJs
ZSBmdW5jdGlvbiBpcyBhbHNvIHNhbWUuIA0KDQpQbGVhc2UgY29uZmlybSBpZiB0aGlzIGlzIG9r
IHRvIHVzZSBzYW1lIGRpc2FibGVfZGl2X2NsayBvciBkbyB5b3UgcHJlZmVyIHJlbGVhc2VfZG1h
IGxhYmVsIHJlbW92aW5nIGRpc2FibGVfZGl2X2Nsaw0KDQoNCj4gPiA+ICANCj4gPiA+ICBkaXNh
YmxlX3JwbToNCj4gPiA+ICAJcG1fcnVudGltZV9kaXNhYmxlKCZwZGV2LT5kZXYpOw0KPiA+DQo+
ID4NCj4gPiBbc25pcF0NCj4gPg0KPiA+IFBsZWFzZSBhbHNvIGFkZHJlc3MgbXkgY29tbWVudCB0
byB0aGUgImZpeCBtYXhpbXVtIHRyYW5zZmVyIHNpemUiIHBhdGNoLiBBbmQgcGxlYXNlIGFkZCBX
b2xmcmFtIFNhbmcgdG8gdGhlIENDIGxpc3QuDQo+ID4NCj4gPiBMb29rcyBsaWtlIHYxNiBzaG91
bGQgYmUgdGhlIGZpbmFsLCBzbyB3aXRoIGV2ZXJ5dGhpbmcgYmVpbmcgYWRkcmVzc2VkOg0KPiA+
DQo+ID4gUmV2aWV3ZWQtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT4NCj4g
PiBUZXN0ZWQtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT4NCg0KDQo=
