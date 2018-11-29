Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD970C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5066120989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="doXT0wgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5066120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbeK3DzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:55:22 -0500
Received: from mail-eopbgr130087.outbound.protection.outlook.com ([40.107.13.87]:27232
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729515AbeK3DzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nO9jzFrv0u4OBBLdk2NE28KSrH48jwGDhAPzJ7zGu2U=;
 b=doXT0wgNr3mQZEETK9HqolcYUk23PX0VVKEodXUcP3VSnSlQbZG+SzAyu3i3fZcEAtRIxhMXJ7orWNcLRn5LMSv11vOULWaVIHzb3FkZieDOKUiPOqICU74layt7fLs1GjrOMVoS4wFFb3B/0exy+YqYuYhr/gE/QKwtq8Sq06I=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2446.eurprd08.prod.outlook.com (10.175.26.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Thu, 29 Nov 2018 16:49:18 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1382.017; Thu, 29 Nov
 2018 16:49:18 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>, Yueyi Li <liyueyi@live.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "w@1wt.eu" <w@1wt.eu>,
        "donb@securitymouse.com" <donb@securitymouse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "markus@oberhumer.com" <markus@oberhumer.com>
CC:     nd <nd@arm.com>
Subject: Re: [PATCH v2] lzo: fix ip overrun during compress.
Thread-Topic: [PATCH v2] lzo: fix ip overrun during compress.
Thread-Index: AQHUhuxfhCM/itRkZUmE23ES7mjh0qVlNWoAgAHDqgA=
Date:   Thu, 29 Nov 2018 16:49:18 +0000
Message-ID: <c03227b3-1c79-d214-5880-19f2f1ea0491@arm.com>
References: <BLUPR13MB0289EFEB79833470EE62F48EDFD10@BLUPR13MB0289.namprd13.prod.outlook.com>
 <20181128135242.gy3avmbp2pdmjaka@twin.jikos.cz>
In-Reply-To: <20181128135242.gy3avmbp2pdmjaka@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::16) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2446;6:4XCri+AmasNoxZbzU9IN/PWPGoxvoxtvj3mEAYsm2tStNwvhBOr6KdM+7cebIhOVCbn1wNrz8G+KgfZn5T7oHTz3DHNkVZYp2Vt3cznSTga0TnlcVEcJh27Z2/92oPOmumUXE7xKtzRe9dMCVJzrh7XZtVf/qRwct2oXWKLJ6RT8GwG8UD9w4jf1QMaLQVmEgSD92LQh8vP3JXvFXnP/90zVwIvbwyVyDU/K3nc0DQZ5wdITLcBZxSCrRCrVJSA1HiikHwQWcoIsL2TeYDzcjXZGt39vZuT5cI9XOPBfMfLTyG49IyonxO4uCreeLMOG4oEaJXOlmQWmNyL1mTF0/dsmSzt1ItxLdVLjJRcTB1opiBGcOhPQktCS/cQQhpQLPFfCxtJ4OKExE3p5IwJ+Dj7Pyu1+2Ow7l6hPDsdJ6rV5/qjL6ihQrcRfs4wzHys2HfcBM+FYd36pgdAzbZwfEQ==;5:x5qrFQqcV23DtE8LWWO3Y0ixs4o3Cj5E17NNbTgRgVS/j97paGpuDxkMhZPJjnS3V68DsoUgmns1WQSGfcEUl/Gfk0F/4XrklWnYif2eEiOxgEh6iI1x3f0M8Zwv6bj1ehaAP2AHvLSdFGV2zkszlt+62U2Mv9wfZPljYjoNL2o=;7:Iu+zi2Ux3zcIHNRb5OLgZFamiUwfXHcXksML+29O3blxBUfMMLqSINeGyLue3lNATQMrAu0q2Sa6GACQL5ukJBAKWFwA3QspsQoYFo2fqwJExa1otEpgCFBqYeIYgA1PSF3UMecHvQnNTeCTf7KYVw==
x-ms-office365-filtering-correlation-id: bbe30369-7c9f-4c1f-a3d4-08d6561a9a50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2446;
x-ms-traffictypediagnostic: VI1PR0802MB2446:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB24467A1410083823FD46283B8FD20@VI1PR0802MB2446.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231453)(999002)(944501410)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2446;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2446;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(81156014)(97736004)(81166006)(229853002)(8936002)(478600001)(6116002)(66066001)(110136005)(316002)(3846002)(36756003)(8676002)(7736002)(5660300001)(2906002)(305945005)(31696002)(39060400002)(476003)(446003)(486006)(11346002)(44832011)(53936002)(2201001)(52116002)(4326008)(2616005)(6246003)(14454004)(68736007)(105586002)(6506007)(26005)(53546011)(106356001)(102836004)(76176011)(99286004)(386003)(71200400001)(31686004)(86362001)(6512007)(256004)(6486002)(186003)(71190400001)(2501003)(6436002)(25786009)(781001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2446;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4jDcbwwhmE0t0r0S7V370MF5tY5TwF2J/NV0PCcYeoBcjOwgEHwRtdOQEmzqrQgXvLZPXJfVfDX77XxZ7wQsmumceq9aZtk7xbN85QQ5IoIyoRghM3Zt0jhMa7qPzZAqhvvgsCLFDWXjUfDr8snTn8kzbKbOZbwDJoiUn1BVfIRGqWeRn3wEOsy15ZK/7jJZtRYIT805R7cV9qFSib/ANnp8v0qKCpizdYgBIGY5H7tiv3uQpVKo0ZR1p68VpOqGTBe/oAPpx38KFwsTcvWNSow3iOCvgdakUnmFY89JeC9dQsvlxuKBw1vqWURUWGpMlcPDk3Cky0LO1Tn37bJUMW9435c9GjZ5ZM6DbaaXP4k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBA9F03B121630469136589A7BAD7E37@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe30369-7c9f-4c1f-a3d4-08d6561a9a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 16:49:18.2042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2446
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjgvMTEvMjAxOCAxOjUyIHBtLCBEYXZpZCBTdGVyYmEgd3JvdGU6DQoNCj4gVGhlIGZpeCBp
cyBhZGRpbmcgYSBmZXcgYnJhbmNoZXMgdG8gY29kZSB0aGF0J3Mgc3VwcG9zZWQgdG8gYmUgYXMg
ZmFzdA0KPiBhcyBwb3NzaWJsZS4gVGhlIGJyYW5jaGVzIHdvdWxkIGJlIGV2YWx1YXRlZCBhbGwg
dGhlIHRpbWUgd2hpbGUNCj4gcHJvdGVjdGluZyBhZ2FpbnN0IG9uZSBzaWdubGUgYmFkIHBhZ2Ug
YWRkcmVzcy4gVGhpcyBkb2VzIG5vdCBsb29rIGxpa2UNCj4gYSBnb29kIHBlcmZvcm1hbmNlIHRy
YWRlb2ZmLg0KDQpBcyBhbiBhbHRlcm5hdGl2ZSwgZm9yIGFsbCBidXQgdGhlIGZpcnN0IGNhc2Us
IGluc3RlYWQgb2Y6DQoNCmlmICh1bmxpa2VseShPVkVSRkxPV19BRERfQ0hFQ0soaXAsIG1fbGVu
KSB8fCAoaXAgKyBtX2xlbiA+PSBpcF9lbmQpKSkNCg0KSSdkIHN1Z2dlc3Qgd2UgZG86DQoNCmlm
ICh1bmxpa2VseSgoaXBfZW5kIC0gaXApIDw9IG1fbGVuKSkNCg0Kd2hpY2ggd2lsbCBiZSBhYm91
dCBhcyBlZmZpY2llbnQgYXMgd2hhdCdzIGN1cnJlbnRseSB0aGVyZSwgYnV0IGRvZXNuJ3QgDQpo
YXZlIGlzc3VlcyB3aXRoIG92ZXJmbG93Lg0KDQpEYXZlDQo=
