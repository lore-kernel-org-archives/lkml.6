Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E45C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808B12087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="G7ScZgQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbfB0R5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:57:36 -0500
Received: from mail-eopbgr760085.outbound.protection.outlook.com ([40.107.76.85]:25184
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726419AbfB0R5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp0UkGKeiOL6QQn3xLobBFAzUzHCiZVJ6tOoA9a0h7o=;
 b=G7ScZgQ6DJgv4y6wlAP3wBxSXIYPXIoHAFCdC7CdeHwGBdE4IVs1x8QsRQWnkGL4f7rsklK5uB0ZrI4bnl+OzDamKCRkleT/asgSmIb82kmuVjbloJWIjfg1KNMTnR67tPeVZ5itkdzkOtNn76RrIhhNUUmoMFSerZL5pTWfi5I=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4808.namprd05.prod.outlook.com (52.135.235.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.13; Wed, 27 Feb 2019 17:57:32 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5%4]) with mapi id 15.20.1665.012; Wed, 27 Feb 2019
 17:57:32 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/5] x86/percpu: Differentiate this_cpu_{}() and
 __this_cpu_{}()
Thread-Topic: [PATCH 1/5] x86/percpu: Differentiate this_cpu_{}() and
 __this_cpu_{}()
Thread-Index: AQHUzoWLaRk7bgtU4EOfs8jYdQI+faXz0eWAgAAc4YA=
Date:   Wed, 27 Feb 2019 17:57:32 +0000
Message-ID: <06F1CFAA-DD80-4DA7-A97C-E57814149CC4@vmware.com>
References: <20190227101252.413192716@infradead.org>
 <20190227101544.210748832@infradead.org>
 <CAHk-=wiv6dgJDj81wukpJCJBVhAVn-CYJdhj+o8JGN1LfRwb0g@mail.gmail.com>
In-Reply-To: <CAHk-=wiv6dgJDj81wukpJCJBVhAVn-CYJdhj+o8JGN1LfRwb0g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 916b4add-0df6-491c-b67c-08d69cdd0c27
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4808;
x-ms-traffictypediagnostic: BYAPR05MB4808:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4808;20:BBE1EGOFH4yrea4XEe0sMdc5O0golkjK+G1xukjcSdvSp7H3ghULK3lybkJwfQsn2pLn1etSum3yqHilqQRt3P1H+p/Fn5e0d19eQJGqZ5xKyw4qwM49ypvpmpKx/NbApFP2x152ikHUayo0vOPPSQ6XEJ0KGr38er4CGWnEi9Y=
x-microsoft-antispam-prvs: <BYAPR05MB48088A6DF7CF3F460B6A17BCD0740@BYAPR05MB4808.namprd05.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(366004)(396003)(39860400002)(189003)(199004)(486006)(6246003)(68736007)(11346002)(5660300002)(14454004)(4326008)(83716004)(71200400001)(3846002)(97736004)(6116002)(2906002)(186003)(6916009)(446003)(2616005)(26005)(316002)(966005)(478600001)(476003)(305945005)(71190400001)(25786009)(54906003)(256004)(86362001)(5024004)(6512007)(8676002)(53936002)(6306002)(6436002)(6506007)(81156014)(81166006)(229853002)(53546011)(33656002)(99286004)(7736002)(8936002)(82746002)(36756003)(102836004)(66066001)(105586002)(106356001)(76176011)(6486002)(125773002)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4808;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7lbB7/mcaKGgtDoT4gKi9dVeQU/0bdS6TobcpEbRdt8KQTML+S5xIdAzTjyEnyvwDXLWBhbtNWNZCeAXedLKWCPzwEblwoJrSz+9vKFV/IDI1jqZS+H+gBiLiQLk9F5vddwCw2K6fCwfwgExGSZH0CxT4fg+vmnD8DRzO3cAZ53lkFG+m0/xV/2wFTlHamVR/tAVC3GnbCwFWLQ61IVb+XsotvQDrK/Ar0OWwMdCPljbV8SfCUFW4VU+gVS7IdKQhg9rI6vmaUQ7HWWZ8GWWZYNNxHHuqx8CbdxX5Ip8/LC+mzyNVylFnULkJPAWqQK7IlEZN6o3W/LjPSVMzz4e2jncyhtd8JC2+cvw25U7RNi+tOunZn5N7vp5X5lmi2RnkNhk75GvBSunC2kkrkhyCD4R9Jc+2oc2PnbAYVxr7vI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2411DAD708652C4281C7B3A846749A1B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916b4add-0df6-491c-b67c-08d69cdd0c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 17:57:32.3647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4808
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGZWIgMjcsIDIwMTksIGF0IDg6MTQgQU0sIExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0Bs
aW51eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIEZlYiAyNywgMjAxOSBh
dCAyOjE2IEFNIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+
PiBOYWRhdiBBbWl0IHJlcG9ydGVkIHRoYXQgY29tbWl0Og0KPj4gDQo+PiAgYjU5MTY3YWM3YmFm
ICgieDg2L3BlcmNwdTogRml4IHRoaXNfY3B1X3JlYWQoKSIpDQo+PiANCj4+IGFkZGVkIGEgYnVu
Y2ggb2YgY29uc3RyYWludHMgdG8gYWxsIHNvcnRzIG9mIGNvZGU7IGFuZCB3aGlsZSBzb21lIG9m
DQo+PiB0aGF0IHdhcyBjb3JyZWN0IGFuZCBkZXNpcmVkLCBzb21lIG9mIHRoYXQgc2VlbXMgc3Vw
ZXJmbHVvdXMuDQo+IA0KPiBUcml2aWFsIChidXQgZW50aXJlbHkgdW50ZXN0ZWQpIHBhdGNoIGF0
dGFjaGVkLg0KPiANCj4gVGhhdCBzYWlkLCBJIGRpZG4ndCBhY3R1YWxseSBjaGVjayBob3cgaXQg
YWZmZWN0cyBjb2RlIGdlbmVyYXRpb24uDQo+IE5hZGF2LCB3b3VsZCB5b3UgY2hlY2sgdGhlIGNv
ZGUgc2VxdWVuY2VzIHlvdSBvcmlnaW5hbGx5IG5vdGljZWQ/DQoNClRoZSBvcmlnaW5hbCBpc3N1
ZSB3YXMgcmFpc2VkIHdoaWxlIEkgd2FzIGxvb2tpbmcgaW50byBhIGRyb3BwZWQgcGF0Y2ggb2YN
Ck1hdHRoZXcgV2lsY294IHRoYXQgY2F1c2VkIGNvZGUgc2l6ZSBpbmNyZWFzZSBbMV0uIEFzIGEg
cmVzdWx0IEkgbm90aWNlZA0KdGhhdCBQZXRlcuKAmXMgcGF0Y2ggY2F1c2VkIGJpZyBjaGFuZ2Vz
IHRvIHRoZSBnZW5lcmF0ZWQgYXNzZW1ibHkgYWNyb3NzIHRoZQ0Ka2VybmVsIC0gSSBkaWQgbm90
IGhhdmUgYSBzcGVjaWZpYyBzY2VuYXJpbyB0aGF0IEkgY2FyZWQgYWJvdXQuDQoNClRoZSBwYXRj
aCB5b3Ugc2VudCAo4oCcK20vLXZvbGF0aWxl4oCdKSBkb2VzIGluY3JlYXNlIHRoZSBjb2RlIHNp
emUgYnkgMTcyOA0KYnl0ZXMuIEFsdGhvdWdoIGNvZGUgc2l6ZSBpcyBub3QgdGhlIG9ubHkgbWV0
cmljIGZvciDigJxjb2RlIG9wdGltaXphdGlvbuKAnSwNCnRoZSBvcmlnaW5hbCBwYXRjaCBvZiBQ
ZXRlciAo4oCcdm9sYXRpbGXigJ0pIG9ubHkgaW5jcmVhc2VkIHRoZSBjb2RlIHNpemUgYnkgMjAx
DQpieXRlcy4gUGV0ZXLigJlzIG9yaWdpbmFsIGNoYW5nZSBhbHNvIGFmZmVjdGVkIG9ubHkgNzIg
ZnVuY3Rpb25zIHZzIDIyOCB0aGF0DQppbXBhY3RlZCBieSB0aGUgbmV3IHBhdGNoLg0KDQpJ4oCZ
bGwgaGF2ZSBhIGxvb2sgYXQgc29tZSBzcGVjaWZpYyBmdW5jdGlvbiBhc3NlbWJseSwgYnV0IG92
ZXJhbGwsIHRoZSDigJwrbeKAnQ0KYXBwcm9hY2ggbWlnaHQgcHJldmVudCBldmVuIG1vcmUgY29k
ZSBvcHRpbWl6YXRpb25zIHRoYW4gdGhlIOKAnHZvbGF0aWxl4oCdIG9uZS4NCg0KSeKAmWxsIHNl
bmQgYW4gZXhhbXBsZSBvciB0d28gbGF0ZXIuDQoNClJlZ2FyZHMsDQpOYWRhdg0KDQoNClsxXSBo
dHRwczovL21hcmMuaW5mby8/bD1saW51eC1tbSZtPTE1NDM0MTM3MDIxNjY5MyZ3PTINCg0K
