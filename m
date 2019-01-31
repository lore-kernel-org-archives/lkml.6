Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A96C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A835220869
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="QVdIx704"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbfAaOCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:02:34 -0500
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:20728
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727248AbfAaOCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsEMYPf5L8XGK9pYS1nllgYA2ZWJH9VR0DVtxW/NbQg=;
 b=QVdIx704Z6J2b1nSMdqjivR1m35rGyH5Dv9Uq/r7kKQ96r5F2Ek7LsVSUSGhF0Rc2V/hZ2V0gUr7A6pGF1UxwdxSCJFiPz7q7GuRXVsaJbPrAgP//L8hrfZBGTDPwSAZS1538HU3aZutK4eVUc4fkCzOC5d+VxUjD9Vv6XZXA8o=
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com (20.177.33.25) by
 AM6PR03MB5093.eurprd03.prod.outlook.com (20.178.91.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Thu, 31 Jan 2019 14:02:30 +0000
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7]) by AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7%2]) with mapi id 15.20.1558.023; Thu, 31 Jan 2019
 14:02:30 +0000
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
To:     xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marmarek@invisiblethingslab.com" <marmarek@invisiblethingslab.com>
Subject: [Xen-devel] xen/mem-reservation API and out-of-tree kernel modules
Thread-Topic: [Xen-devel] xen/mem-reservation API and out-of-tree kernel
 modules
Thread-Index: AQHUuW2awNkJGzJtBUW2HZJ5omKh0Q==
Date:   Thu, 31 Jan 2019 14:02:30 +0000
Message-ID: <f3ca533d-7f51-c59e-6a96-4e1fba687c8f@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
x-originating-ip: [85.223.209.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR03MB5093;6:SCNOw+w9OOYhRpfU8uNSoX8DzuQXntx8cznQ8bor9fH/aD3ZqnY2pdCFKIfYHqtvzEwZzCZ+IRZFWeNOD3TwfHjdYM+bQ+7vuYKqbotiYF783a/CnbXhiamuiRdHSE0S3BC9bV34Cm+ztBxt/xtsq2ZUo+NbcbyhCZSqC2DiD6Rzf+HsLESWxQbaE5n/JPyj/7MxlKh8j4iy8wWuBpKJ9s+r37lEVwalr8fpJKjgzFRHT/b20QxAaIF/gBh6PVICtsQq3tlHrFlqYAsjhxd1wwg67XLXpph4RFNTGTjyMXkm1ntfQc6giVmiGBRr/eQCcXFlO5tEt8wjgRUaSNGpfva22BKq43HoU1CO44iLEPm4KiIfOne/7AJM+bhvDcm0ICfvRIa6/jCcGkKz6K+JMBJgPAapKCAIJbfRiWhLw3U9h+P3KvH6QVn1zxkcx3ooF1ikkEl/EJxFfstOIQLAmg==;5:dJeP5SpBdZTZ9QHmz4zcQhbh7cB32uIm5fh1ZRZxb9sYqmg18p1vtRhYsShfUlli9qK3xGyR/dK6H3jViEzBQrJ6dcqEINx+V+B9Dl99SuJsi4tQCuYcYr/8zgZzcrUiVr1ra6eDZsCnpQ2uJZNp1/ObIL+iFatfVliAdrAKiktNKgBzjlmalUk9SRaE6mWDEH9KxlkuFh/BxSHDQRgHCQ==;7:Uuht6mwyx2UbqkPA5DdmggQexpIC1AWCtQnPpE9CtyclPsv4kdRjF5clgfeMnGHI0iWTpinsIWO+7QNa38IgW2wZ4cqqbAL35hUBqr0IlrbZF3c6i2Th9lDyUmYA8YYlw154Xza5hF0JrpJju/uXqQ==
x-ms-office365-filtering-correlation-id: 0651ab84-efc9-4179-d866-08d68784bd58
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM6PR03MB5093;
x-ms-traffictypediagnostic: AM6PR03MB5093:
x-microsoft-antispam-prvs: <AM6PR03MB5093DACC71C796527A237829E7910@AM6PR03MB5093.eurprd03.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(376002)(39860400002)(199004)(189003)(478600001)(97736004)(316002)(72206003)(25786009)(14454004)(31686004)(105586002)(36756003)(966005)(31696002)(80792005)(8936002)(106356001)(554214002)(2906002)(66066001)(110136005)(2501003)(81156014)(8676002)(81166006)(256004)(86362001)(2201001)(7736002)(14444005)(305945005)(102836004)(26005)(186003)(71190400001)(55236004)(6436002)(6506007)(6116002)(99286004)(2616005)(476003)(486006)(68736007)(6486002)(53936002)(3846002)(6512007)(6306002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB5093;H:AM6PR03MB4327.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A9qM+Xovdbue8vsEFDfyO9oLn4TulVu86O2y+cD8jXrA9o4JzHrkvrRGx5VlmhCRWMOvhkMiFIBwoRt4PV0WmjQm6kYvk5zgHwhh3g0e7e/c0WSQSZ4zFlYRg4uDzlhckri8Q3HbXdIm/xF8r6Fux8vtPwSzszsoXhbtvvSaTYT+wnMVyoXSZR41ORl31M9KgiRSsXeO6nD3Dl2pogOHv11sw/8HJRHEVNmkjIW4vGpvNzh2xAL6rX4ardmdEbQ9Uc4idQh9aoGE9r2ywSn5jxTzWTG6MpNc1lwBwjkZcGensMUDJ/uC0icVuLslZzx4wyXDTUL1+Y8FQD/0kUS9s4zOhZ3DW8SdRzsDfnPOKUzXgj8sC3V6YissHkbuowbcKKUmqALTJKw8DnJcokO471rD8HPb6G44nNOkZ41V+4g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D456D1D2F1A6B1488E9B9C1523D6E918@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0651ab84-efc9-4179-d866-08d68784bd58
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 14:02:30.0715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCkkgYW0gd29ya2luZyBvbiBwb3J0aW5nIGFuIG91dC1vZi10cmVlIGtlcm5lbCBk
cml2ZXIgdG8gdGhlIGtlcm5lbA0KNS4wIGFuZCB0aGF0IGRyaXZlciB1c2VzIGZ1bmN0aW9uYWxp
dHkgcHJvdmlkZWQgYnkgDQpkcml2ZXJzL3hlbi9tZW0tcmVzZXJ2YXRpb24uYw0KbW9kdWxlLsKg
IFNpbmNlIGNvbW1pdCBbMV0gaXQgaXMgbm90IHBvc3NpYmxlIHRvIGJ1aWxkIGEga2VybmVsIG1v
ZHVsZQ0Kd2hpY2ggdXNlcyBtZW0tcmVzZXJ2YXRpb24gQVBJIGFzIHhlbl9zY3J1Yl9wYWdlcyB2
YXJpYWJsZSwgd2hpY2ggaXMgDQpjaGVja2VkIGluDQp4ZW5tZW1fcmVzZXJ2YXRpb25fc2NydWJf
cGFnZSwgYmVjYW1lIGEga2VybmVsIG1vZHVsZSBwYXJhbWV0ZXIgYW5kIGlzIA0Kbm93IG9ubHkN
CmFjY2Vzc2libGUgZm9yIGJ1aWx0LWluIG1vZHVsZXM6DQoNCnN0YXRpYyBpbmxpbmUgdm9pZCB4
ZW5tZW1fcmVzZXJ2YXRpb25fc2NydWJfcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSkNCl5eXl5eXl5e
Xl5eXl4NCnsNCiDCoMKgwqAgaWYgKHhlbl9zY3J1Yl9wYWdlcykNCiDCoMKgwqDCoMKgwqDCoCBe
Xl5eXl5eXl5eXl5eXl4NCiDCoMKgwqAgwqDCoMKgIGNsZWFyX2hpZ2hwYWdlKHBhZ2UpOw0KfQ0K
DQpUaGlzIHJlc3VsdHMgaW4gbGluay10aW1lIHdhcm5pbmc6DQoNCiDCoMKgwqAgV0FSTklORzog
Inhlbl9zY3J1Yl9wYWdlcyIgW3lvdXJtb2R1bGUua29dIHVuZGVmaW5lZCENCg0KYW5kIHRodXMg
bm90IGFsbG93aW5nIHRoZSBtb2R1bGUgdG8gcnVuLiBBdCB0aGUgbW9tZW50IEkgY2FuIG9ubHkg
c2VlIGEgDQpwb3NzaWJsZSBmaXgNCmZvciB0aGlzIGJ5IG1ha2luZyB0aGUgZm9sbG93aW5nIGNo
YW5nZToNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL21lbS1yZXNlcnZhdGlvbi5jIGIvZHJp
dmVycy94ZW4vbWVtLXJlc2VydmF0aW9uLmMNCmluZGV4IDM3ODJjZjA3MDMzOC4uODVmZWNmZWM1
MGUxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy94ZW4vbWVtLXJlc2VydmF0aW9uLmMNCisrKyBiL2Ry
aXZlcnMveGVuL21lbS1yZXNlcnZhdGlvbi5jDQpAQCAtMTgsNiArMTgsNyBAQA0KDQogwqBib29s
IF9fcmVhZF9tb3N0bHkgeGVuX3NjcnViX3BhZ2VzID0gDQpJU19FTkFCTEVEKENPTkZJR19YRU5f
U0NSVUJfUEFHRVNfREVGQVVMVCk7DQogwqBjb3JlX3BhcmFtKHhlbl9zY3J1Yl9wYWdlcywgeGVu
X3NjcnViX3BhZ2VzLCBib29sLCAwKTsNCitFWFBPUlRfU1lNQk9MKHhlbl9zY3J1Yl9wYWdlcyk7
DQoNCmJ1dCB0aGlzIGxvb2tzIGEgYml0IHVudXN1YWwgZm9yIHRoZSBrZXJuZWw/DQoNCkkgYW0g
bG9va2luZyBmb3IgY29tbXVuaXR5IGFkdmljZSBoZXJlIGFuZCBoZWxwDQoNClRoYW5rIHlvdSwN
Ck9sZWtzYW5kcg0KDQpbMV0gDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD0xOTdlY2IzODAyYzA0NDk5
ZDhmZjRmOGNiMjhmNmVmYTAwODA2N2RiDQo=
