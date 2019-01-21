Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000C8C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F322085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="h+pqO8Ag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfAULn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:43:58 -0500
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:40307
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727679AbfAULn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxSPWgQIVgWDK+bHjxjefH3gVT2Lncrypi+SaiNHW3c=;
 b=h+pqO8AgqjWQfQ/a++yT0ZssPBH3Cc6yb/YQHNH12TP21YkPLkzSudsnxfIBbokmK+vC0/38LNB7gl02PPbq+3klZIkekn8PtOHmdqfb75L7NF8Ze9tF27L/G8/IJPqRmfvoQIlFiz+SLETDH5LJ9W03g4WswFAO+6ZRPP2+ZXA=
Received: from AM6PR08MB3094.eurprd08.prod.outlook.com (52.135.163.155) by
 AM6PR08MB4373.eurprd08.prod.outlook.com (20.179.6.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Mon, 21 Jan 2019 11:43:52 +0000
Received: from AM6PR08MB3094.eurprd08.prod.outlook.com
 ([fe80::d511:d407:282a:7d08]) by AM6PR08MB3094.eurprd08.prod.outlook.com
 ([fe80::d511:d407:282a:7d08%5]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 11:43:52 +0000
From:   Robin Murphy <Robin.Murphy@arm.com>
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
        "dalias@libc.org" <dalias@libc.org>,
        "thomas.petazzoni@free-electrons.com" 
        <thomas.petazzoni@free-electrons.com>,
        "jacopo+renesas@jmondi.org" <jacopo+renesas@jmondi.org>
CC:     "jrdr.linux@gmail.com" <jrdr.linux@gmail.com>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "brajeswar.linux@gmail.com" <brajeswar.linux@gmail.com>
Subject: Re: [PATCH] arch/sh/mm/consistent.c: Use dma_zalloc_coherent
Thread-Topic: [PATCH] arch/sh/mm/consistent.c: Use dma_zalloc_coherent
Thread-Index: AQHUbou2OQd5eLO+WE2RszD6cIOFsqW6IA6A
Date:   Mon, 21 Jan 2019 11:43:51 +0000
Message-ID: <fcbf537f-6e95-0e25-710a-02a3a6e7961a@arm.com>
References: <5bd55e34.1c69fb81.b2503.b6f5@mx.google.com>
In-Reply-To: <5bd55e34.1c69fb81.b2503.b6f5@mx.google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0265.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::13) To AM6PR08MB3094.eurprd08.prod.outlook.com
 (2603:10a6:209:45::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robin.Murphy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR08MB4373;6:NQkG1fvoe4sdfI4zafD2G0/XduH791mmdaXlNOKgvypNrxtJfUXx9Y8CdJokjUeH35wY4MN8w74kc/VvbWGvJmt+Y1vDqPXRWTcYX+QuYYuvihHtRjQWTEMOAy+QlW636CIMzbeW+kLdxNiUJWn744+tvw1eoa9knBuikx0q17wBWPEVh/shXdRt/ZsloQJ/qP405IzzpvJ+4e2vu7WUczW/4PHYh/5eMzrY0Ji0TsFV4UxH5+lCESPRH4zqqn/HivWeb2O8l4ewIaKAPI4cdTLZnPgWVHcJJ9+z3lW/f8OVjNdPuAOvcdOLD2o2X3LE+6DlGBO8+QR0FP6pDKMmxnukLEHwQyMKs74jVTlXgaDqQ0uhMp6STNFYLbVYn+1gBHJ5HEmTH5OqjJpZy2PIrY/ztu17KGeJNCPKqTyY2NBoNc7pjaHugxDdTd1FfoV3WPAR5cvEqmZPzY/rl5KtRw==;5:5daPMo2hvq+XnU0aiXVyYRAvvuhr9VPziFpoibzm+ywZUW3DzoGkU9UxiMkTY0ktTPoetcWcO8nXq96hQqqOnRkQifUz0ebXHf5Uztb7p5Ds3grICQC8C7IAIYg4tNE3/GKCy/4jLL7udDJdy4qc991c0/Kp/lT64DTWH7xw5pPl/zpFiBshCriNQPZ1r1n9KBK7hiPZrXJ4NLlV2La7jQ==;7:XplDUM61ICj457UVGblKvl3cIxqRqe44n2GWWN7mwAPLpG4+bqm8zEmV9Gt3lD/mbVPR+RXo/C3ywfeCkMjYlpivoZ1SGlhamRRtGo+1MqAA9ROIWdlduMT+QdfPRV6CWJo3CXOQX7U5tqsfJkbM5Q==
x-ms-office365-filtering-correlation-id: 345d4400-59e5-4958-9e60-08d67f95b705
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB4373;
x-ms-traffictypediagnostic: AM6PR08MB4373:
x-microsoft-antispam-prvs: <AM6PR08MB437363999202E1BFDDBEE0F1969F0@AM6PR08MB4373.eurprd08.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(366004)(136003)(199004)(40434004)(189003)(2501003)(6116002)(3846002)(6512007)(68736007)(478600001)(72206003)(53936002)(6436002)(39060400002)(4326008)(14454004)(6246003)(25786009)(97736004)(229853002)(81166006)(305945005)(7736002)(8676002)(81156014)(6486002)(8936002)(36756003)(105586002)(64126003)(31686004)(65826007)(446003)(316002)(2616005)(65956001)(476003)(53546011)(186003)(54906003)(110136005)(58126008)(66066001)(65806001)(52116002)(2201001)(76176011)(486006)(386003)(6506007)(71200400001)(71190400001)(256004)(44832011)(14444005)(5024004)(31696002)(86362001)(11346002)(99286004)(106356001)(102836004)(2906002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4373;H:AM6PR08MB3094.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ipl5lQE6+SD6IYsWQHO+2f3S4BBrVfmhb5ZCj4N/jcbhSRg+B+3ZEd5wErMeoNvYFvPjdG6AID8UIIpOOlheB9PWlmTxd3n+Lwy90hQWzkzDyVIcMziacyI+kiiLnY/HKSlvoLVBzvGyymuRyhw1NZVT8rBVliX/PBGGSdTvpq+tXr51guvhV2szVYE60ssUZdI3zkkAHWkzmymrGB9m71k/Fa2+2CtEhco4rYQLVcIhjp9GXjVSJCayP6VhZJuhsAdjUkw0Q6xTuvE0UtIhTtEPwxWHEcD4g/aZj9dafHzrWWnH+aQu31oLHrBBbbBuwP/QOuBAWkkKsonID7hs4OjfaDJSlEPB/nmsRe3anlwYW2OtV1JJnUk5uhgtgOIMOl9Xo4BsOfgekHEkvg34j6X4B5PT8bCeFWTaRLfn98M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5384E50333C6D4B82B317F5DE63A113@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345d4400-59e5-4958-9e60-08d67f95b705
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 11:43:51.3674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjgvMTAvMjAxOCAwNjo1OCwgU2FieWFzYWNoaSBHdXB0YSB3cm90ZToNCj4gUmVwbGFjZWQg
ZG1hX2FsbG9jX2NvaGVyZW50ICsgbWVtc2V0IHdpdGggZG1hX3phbGxvY19jb2hlcmFudA0KDQpQ
bGVhc2UgdGFrZSBhIGxvb2sgYXQgbGludXgtbmV4dCB3aGVyZSB3ZSd2ZSBhbHJlYWR5IHBoYXNl
ZCBvdXQNCmRtYV96YWxsb2NfY29oZXJlbnQoKS4gVGhlIG1lbXNldCgpIHNob3VsZCBzdGlsbCBi
ZSByZWR1bmRhbnQgYW5kIHdvcnRoDQpjbGVhbmluZyB1cCwgdGhvdWdoLg0KDQpUaGFua3MsDQpS
b2Jpbi4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBTYWJ5YXNhY2hpIEd1cHRhIDxzYWJ5YXNhY2hpLmxp
bnV4QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICAgYXJjaC9zaC9tbS9jb25zaXN0ZW50LmMgfCAzICst
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvc2gvbW0vY29uc2lzdGVudC5jIGIvYXJjaC9zaC9tbS9jb25z
aXN0ZW50LmMNCj4gaW5kZXggNzkyZjM2MS4uZmM4ZDIzNSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9z
aC9tbS9jb25zaXN0ZW50LmMNCj4gKysrIGIvYXJjaC9zaC9tbS9jb25zaXN0ZW50LmMNCj4gQEAg
LTUyLDEzICs1MiwxMiBAQCBpbnQgX19pbml0IHBsYXRmb3JtX3Jlc291cmNlX3NldHVwX21lbW9y
eShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiAgIGlmICghbWVtc2l6ZSkNCj4gICBy
ZXR1cm4gMDsNCj4NCj4gLWJ1ZiA9IGRtYV9hbGxvY19jb2hlcmVudCgmcGRldi0+ZGV2LCBtZW1z
aXplLCAmZG1hX2hhbmRsZSwgR0ZQX0tFUk5FTCk7DQo+ICtidWYgPSBkbWFfemFsbG9jX2NvaGVy
ZW50KCZwZGV2LT5kZXYsIG1lbXNpemUsICZkbWFfaGFuZGxlLCBHRlBfS0VSTkVMKTsNCj4gICBp
ZiAoIWJ1Zikgew0KPiAgIHByX3dhcm5pbmcoIiVzOiB1bmFibGUgdG8gYWxsb2NhdGUgbWVtb3J5
XG4iLCBuYW1lKTsNCj4gICByZXR1cm4gLUVOT01FTTsNCj4gICB9DQo+DQo+IC1tZW1zZXQoYnVm
LCAwLCBtZW1zaXplKTsNCj4NCj4gICByLT5mbGFncyA9IElPUkVTT1VSQ0VfTUVNOw0KPiAgIHIt
PnN0YXJ0ID0gZG1hX2hhbmRsZTsNCj4NCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBv
ZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5
IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVu
dCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xv
c2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBv
c2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5r
IHlvdS4NCg==
