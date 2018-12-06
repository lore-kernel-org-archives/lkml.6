Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9794C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF8920659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dgMKxAJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF8920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbeLFQWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:22:33 -0500
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:47436
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbeLFQWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUjd9r/yEgI6v2xpZ15UCR/ySzU46u4Vv6mb4DkNb2M=;
 b=dgMKxAJIp6Ik1FUJQf9eV7LfRHYX5JkbK3TvQL8Bq6WsiOi4cItyXJF4HOyl70aFKvNtrRYNA9Wlal/NyWnrfPp3N/clNDdg9sq3kWkwcfFzUGP35tvJ7lJDzHzzLQlTIlpG0K/jBfAMqyRguVaJ14pJN19pMLIGGn1XuvsizIo=
Received: from VI1PR08MB3662.eurprd08.prod.outlook.com (20.177.61.89) by
 VI1PR08MB4127.eurprd08.prod.outlook.com (20.178.204.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Thu, 6 Dec 2018 16:22:27 +0000
Received: from VI1PR08MB3662.eurprd08.prod.outlook.com
 ([fe80::3c3d:3849:d7b5:29e0]) by VI1PR08MB3662.eurprd08.prod.outlook.com
 ([fe80::3c3d:3849:d7b5:29e0%3]) with mapi id 15.20.1382.020; Thu, 6 Dec 2018
 16:22:27 +0000
From:   Matt Sealey <Matt.Sealey@arm.com>
To:     "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
        Dave Rodgman <dave.rodgman@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        nd <nd@arm.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: RE: [PATCH v4 0/7] lib/lzo: performance improvements
Thread-Topic: [PATCH v4 0/7] lib/lzo: performance improvements
Thread-Index: AQHUiLiqITo/LLyl1EWjCUTAJp49+6Vx5IUAgAAHBBA=
Date:   Thu, 6 Dec 2018 16:22:27 +0000
Message-ID: <VI1PR08MB3662EA5B9E00BB59AF471CB1EEA90@VI1PR08MB3662.eurprd08.prod.outlook.com>
References: <20181130142600.13782-1-dave.rodgman@arm.com>
 <5C09448C.8010506@oberhumer.com>
In-Reply-To: <5C09448C.8010506@oberhumer.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Matt.Sealey@arm.com; 
x-originating-ip: [217.140.111.135]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB4127;6:3YBB583J7G93SIKbIvMmuP1c5z9RJ428A1sbgLGRl48pNKft6xY3RTH7CtCT+mLchX18IQPt28fd2Jkl7mlNx+D/ZvcxxXIoa7yQhwFlHXba40w9ZPjymIbnbMb+e2dMIRMVQUdBBR7+xhIEDsFF8bLRq+Q/ypQwDNU03B9A9Q5Hr7Ybet/2PmUbuQE6ucW+soE57ympWFhr6wTAuZZ8Yxo0qCoMZZ2+mzy+T4rPtLdxFuEoMtLDhoGumQlo5LqhbB9i8UIgalOEW6ECy9k/dkRp5KuY67lbdVRPeS7zjaaweaTO9kn/svwAFRg1uNXyA3AnsihE6xlCRoQgY1/+qtUN0y45xPj3mqfKb4BRN4wb+y/Ms+8j2FW9NZCCfsc20d/OdCnGymcfw+TuQGnXsoToZwqBsiPkg7RrU7Mg5AWouqhJ9E5fOKv7LwLtkm7M9KsnOb9bN1hOj/krGaWnbA==;5:SCz8WBu25GRO0LTxMHlfW7JMY+rmZUkksSmFJpMDG+AZKCGOS5OyBj41vWokUuhvejb/3sKoJ7/ds5RXMMTQR74wiXnGab5ajLffdZS5v/UkxoYCxuLCd87+FDnbBWOGHdHOFVdwfLw15txeh/WeiHDISTuEx1HI8p1TbEhsSp0=;7:5aLRtBFfDhGMXbLRzFIsojvFv8Jxn4nr8DRV51qWkmACXZMhfjJ0QEjrz/qIlsxw8aUoT/QnBNFrYQTYRGwd2LinYbX6WM6jz+ZvB1KvB3ChztoJY+AQHVCTbGDksS3pH9nLDkXgxICawbRAp0z1TQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 661afb2c-9238-41ff-ec09-08d65b970359
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB4127;
x-ms-traffictypediagnostic: VI1PR08MB4127:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB412732FD3112131ECE3FB558EEA90@VI1PR08MB4127.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB4127;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB4127;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(106356001)(8676002)(14444005)(81156014)(81166006)(256004)(8936002)(486006)(55016002)(68736007)(11346002)(446003)(478600001)(7416002)(9686003)(476003)(53936002)(25786009)(305945005)(105586002)(74316002)(7736002)(6246003)(2906002)(33656002)(86362001)(72206003)(6436002)(5660300001)(99286004)(39060400002)(7696005)(54906003)(2501003)(110136005)(4326008)(66066001)(6506007)(97736004)(26005)(71190400001)(6116002)(102836004)(229853002)(316002)(186003)(76176011)(2201001)(14454004)(71200400001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4127;H:VI1PR08MB3662.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: f9V/2P1UEo0AINmj8e3ISxNK8t7wz0OmYlBW5NS5V8O9bl8XKCZD/CYY5E8ffZYgUuioQl40UrAeTxWwa2LRJkq5zxsyvGYclpje/BiH5nWiVpybuzSb455QSdPFthA/MWdKBdlUmUHOI5Dxqx3FQ0FGY4GApLIwqJnZAEzvi1ZtJd6JrRWgYU8lG+OF+hAPHRFcxQ0dcQJPPNGUBXnPmbth7OXKKYpORbFjmrfosvi+l09yLN8kSl9xTCbqdqqjzm2QhpNULEIqgEjjXsBlkqOjNQGDWBmeTrhuui5Be3eKxz9r2yvpX0z73nXQZ9yW+5ymDxLfHVUgzzsSx4q/c5JVLD6KgxiKqQewAAgzvzg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661afb2c-9238-41ff-ec09-08d65b970359
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 16:22:27.2486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWFya3VzLA0KDQo+IFJlcXVlc3QgMiAtIGFkZCBDT1BZMTY7ICpOT1QqIGFja2VkIGJ5IG1lDQo+
IA0KPiAgIFtQQVRDSCAyLzhdIGxpYi9sem86IGNsZWFuLXVwIGJ5IGludHJvZHVjaW5nIENPUFkx
Ng0KPiANCj4gaXMgc3RpbGwgbm90IGNvcnJlY3QgYmVjYXVzZSBvZiBwb3NzaWJsZSBvdmVybGFw
cGluZyBjb3BpZXMuIEknbGwNCj4gYWRkcmVzcyB0aGlzIG9uIHRoZSB3ZWVrZW5kLg0KDQpDYW4g
eW91IGdpdmUgYSBzeW5kcm9tZSBhcyB0byB3aHkNCg0Kew0KCUNPUFk4KG9wLCBpcCk7DQoJQ09Q
WTgob3ArOCxpcCs4KTsNCglpcCs9MTY7DQoJb3ArPTE2Ow0KfQ0KDQpvcg0KDQp7IA0KCUNPUFk4
KG9wLCBpcCk7DQoJaXArPTg7DQoJb3ArPTg7DQoJQ09QWTgob3AsIGlwKTsNCglpcCs9ODsNCglv
cCs9ODsNCn0NCg0KdnMuDQoNCiNkZWZpbmUgQ09QWTE2KGRzdCxzcmMpIENPUFk4KGRzdCxzcmMp
OyBDT1BZOChkc3QrOCxzcmMrOCkNCg0Kew0KCUNPUFkxNihvcCwgaXApOw0KCWlwKz0xNjsNCglv
cCs9MTY7DQp9DQoNCi4uIGNhdXNlcyAib3ZlcmxhcHBpbmcgY29waWVzIj8NCg0KQ09QWTggd2Fz
IG9ubHkgZXZlciB1c2VkIGluIHBhaXJzIGFzIGFib3ZlIGFuZCB0aGUgc2Vjb25kIG1ldGhvZA0K
YnJva2UgY29tcGlsZXIgb3B0aW1pemVycyBzaW5jZSBpdCBhZGRzIGFuIGFydGlmaWNpYWwgYmFy
cmllcg0KYmV0d2VlbiB0aGUgdHdvIGdyb3Vwcy4gVGhlIG9ubHkgZGlmZmVyZW5jZSB3YXMgdGhh
dCBkZWNvbXByZXNzDQphbmQgY29tcHJlc3MgaGFkIHRoZSBwb2ludGVyIGluY3JlbWVudHMgc3By
ZWFkIG91dC4gSWYgd2UgbmVlZA0KdG8gZml4IHRoYXQgdGhlbiB0aGF0J3MgYSBnb29kIHJlYXNv
biwgYnV0IHlvdXIgcmVhc29uaW5nIGNvbnRpbnVlcw0KdG8gZWx1ZGUgbWUuDQoNCkkgY2FuIHJl
ZmFjdG9yIHRoZSBwYXRjaCB0byBhbGlnbiB0aGUgc2Vjb25kIG1ldGhvZCB3aXRoIHRoZSBmaXJz
dA0KYW5kIG1ha2UgY29tcHJlc3MgYW5kIGRlY29tcHJlc3MgZ2V0IHRoZSBzYW1lIGNvZGVnZW4s
IHdoaWNoIGlzDQpmdW5jdGlvbmFsbHkgaWRlbnRpY2FsIHRvIHRoZSBDT1BZMTYgcGF0Y2gsIGJ1
dCB0aGF0IHdvdWxkIHNlZW0gdG8NCmluIHlvdXIgb3BpbmlvbiBiZSB0aGUgd2hvbGUgcHJvYmxl
bS4uDQoNCkknbGwgc2VlIHdoYXQgeW91J3ZlIGdvdCBhZnRlciB0aGUgd2Vla2VuZCA7RA0KDQpU
YQ0KTWF0dCBTZWFsZXkNCg==
