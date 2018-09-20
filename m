Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1EDC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2A221521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CYW7rbn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2A221521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388259AbeITIaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:23 -0400
Received: from mail-dm3nam03on0120.outbound.protection.outlook.com ([104.47.41.120]:36173
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387961AbeITIaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymaq6jYI/BXnqLTgd4GuAvl13KrIu8rC8OBdFeG65Aw=;
 b=CYW7rbn6v2T0n+wlFCLRcj2HrNOaz24iRNApKJeMurJWcx7J2t5aupFzEPeG7qVeHPP6leA8tew5ZfrMjE3YwqPkJ3QICSnU79yZcc4y06Mutr1FQ7IEpm+eSaHJnUHtNIZNLbVXHXOhVEPPR02FNUL2SwZidBIog/IsNmq6HCw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:48:30 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Emily Deng <Emily.Deng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 51/56] drm/amdgpu: Need to set moved to true when
 evict bo
Thread-Topic: [PATCH AUTOSEL 4.18 51/56] drm/amdgpu: Need to set moved to true
 when evict bo
Thread-Index: AQHUUIxaPrAysmi5aEeWsxUg8A4tUA==
Date:   Thu, 20 Sep 2018 02:48:03 +0000
Message-ID: <20180920024716.58490-51-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:LIADBLe4j8LJDnFKmKa04weTby7pNx0zojl8zP9MgR43z6l1skmMiAU8kZRIgiPOsIqyzeHWUe3okB8WpYOLTYWcGXIVaZ9mvpYXePoi9aPQJRqfAASyDimOqvwWqnJiQ3azdpUzAiq7enUQanddPqmiW+brLigOWR9NWocuJaU4ENiQq09kLgUbg2KXX8JreX3HS3+8QEl3JltIAq6JKC9jOM/b195fxLaKks6ji//g3fU2yQW8DkjS5RWU6X9jx+av+WyhRA1WntJQyq9K2RUCgJO83HRPjc67Q+Zck5l4BHgtnswla67MdRUkPFTPBJesf/71JV9bArrN1VtNRD4OLHp6jU+GKyBz/t5MShRT7Bh8W+KeAs/HbBqxANMSx3D1hdajXf+lqpzdAz+ajXJ/qZOyZTR4PH0QUY24r+2xngrK8GIoGI9mGP4ODKzOT6v1XH9WQCZjHOLKia6RCg==;5:aqXXvOEAKYCV+MnLuKWAnTyNZQTiYED66zRaGWOCkhQsloG8/ViA6Al+/3Tb8mkwZ3bCwtp2VWU64esBnAf0sBErjLjdDz7xBsvJAsBZJZx3+/Ri4Gr7+70jhjtloNXrZnlxQYhEzu29mmWkX3SUcDmjW1qmVbAcLnVC0fHgsEo=;7:jGqQq5IN9w75bHOgYK4WPSiXACUiH5YP3f9tcGg6SrT/HyRL9e8WZHuXfTButFcIaWr7cyWt6BXTot2ywlI/IdepWzuNGMwGlAX7D8I2qwgCOn8/v2vFiqaSU94qEz8Mcn1pv/ZgAQTbe2WVy2lNrtflNkBhxORmsgp2UBPkTB+mocKXmGG7S6h6EkxZ6UtH+8/rLsR3q6ohN22a4JiOY7gw/QYJhyhyVq/R60qFHXzOtInlYZs8NSP4rmURgS+o
x-ms-office365-filtering-correlation-id: 9639b722-0531-4abc-f13e-08d61ea38c7d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0119C568177E9D6214FC0A62FB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(76176011)(3846002)(6116002)(25786009)(14454004)(106356001)(99286004)(6666003)(105586002)(102836004)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(66066001)(486006)(476003)(2616005)(10290500003)(11346002)(446003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(14444005)(71190400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: R5Hkn8kjXwG3rDk41B6HVQ703zIUAAzwMtfZTpAuYBV2Aeu+Z2VZXrmMVymhMYt8i0nOGq22yxsxcRvIFnIUFyPtMOgU2DP1ZDhmpXQcy+ktoAnFG4hzaNRJknFPW2w5n29mg8aHSt1WKKwFzBFXXp0z2/G1cdfAJoxxDO2/Lv1lPXqJXlaIZTA3UdQ9xwyr5+kaUxBHUk4rbxRkZbGDUDwE7JIf4QBqFQntI0xphuZ064ePSQOryR5OMngG/h4Yt5ybr11OjU3ZOpL4C49/XITsMl21uwyFvJ2i2DKK1OPQXNMQp0ElmDbMAS2aZUXAN5fjtuR3DR5W4xi9wi67VRcJp6vPZFr5aN1ywYEf/Pk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F313D830C019904AB65E622EA152D0A6@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9639b722-0531-4abc-f13e-08d61ea38c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:03.7573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPg0KDQpbIFVwc3RyZWFtIGNvbW1p
dCA2ZGRkOTc2OWRiNGZjMTFhOThiZDdlNThiZTE3NjRlNDdmZGI4Mzg0IF0NCg0KRml4IHRoZSBW
TUMgcGFnZSBmYXVsdCB3aGVuIHRoZSBydW5uaW5nIHNlcXVlbmNlIGlzIGFzIGJlbG93Og0KMS5h
bWRncHVfZ2VtX2NyZWF0ZV9pb2N0bA0KMi50dG1fYm9fc3dhcG91dC0+YW1kZ3B1X3ZtX2JvX2lu
dmFsaWRhdGUsIGFzIG5vdCBjYWxsZWQNCmFtZGdwdV92bV9ib19iYXNlX2luaXQsIHNvIHdvbid0
IGNhbGxlZA0KbGlzdF9hZGRfdGFpbCgmYmFzZS0+Ym9fbGlzdCwgJmJvLT52YSkuIEV2ZW4gdGhl
IGJvIHdhcyBldmljdGVkLA0KaXQgd29uJ3Qgc2V0IHRoZSBib19iYXNlLT5tb3ZlZC4NCjMuZHJt
X2dlbV9vcGVuX2lvY3RsLT5hbWRncHVfdm1fYm9fYmFzZV9pbml0LCBoZXJlIG9ubHkgY2FsbGVk
DQpsaXN0X21vdmVfdGFpbCgmYmFzZS0+dm1fc3RhdHVzLCAmdm0tPmV2aWN0ZWQpLCBidXQgbm90
IHNldCB0aGUNCmJvX2Jhc2UtPm1vdmVkLg0KNC5hbWRncHVfdm1fYm9fbWFwLT5hbWRncHVfdm1f
Ym9faW5zZXJ0X21hcCwgYXMgdGhlIGJvX2Jhc2UtPm1vdmVkIGlzDQpub3Qgc2V0IHRydWUsIHRo
ZSBmdW5jdGlvbiBhbWRncHVfdm1fYm9faW5zZXJ0X21hcCB3aWxsIGNhbGwNCmxpc3RfbW92ZSgm
Ym9fdmEtPmJhc2Uudm1fc3RhdHVzLCAmdm0tPm1vdmVkKQ0KNS5hbWRncHVfY3NfaW9jdGwgd29u
J3QgdmFsaWRhdGUgdGhlIHN3YXBvdXQgYm8sIGFzIGl0IGlzIG9ubHkgaW4gdGhlDQptb3ZlZCBs
aXN0LCBub3QgaW4gdGhlIGV2aWN0IGxpc3QuIFNvIFZNQyBwYWdlIGZhdWx0IG9jY3Vycy4NCg0K
U2lnbmVkLW9mZi1ieTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPg0KUmV2aWV3ZWQt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NClNpZ25lZC1v
ZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NClNpZ25lZC1v
ZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMSArDQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jDQppbmRleCBiYmQ0ZGFhNGQ4NzAuLmMzMWZmZjMyYTMyMSAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KQEAgLTEyMyw2ICsxMjMsNyBAQCBzdGF0aWMgdm9pZCBh
bWRncHVfdm1fYm9fYmFzZV9pbml0KHN0cnVjdCBhbWRncHVfdm1fYm9fYmFzZSAqYmFzZSwNCiAJ
ICogaXMgdmFsaWRhdGVkIG9uIG5leHQgdm0gdXNlIHRvIGF2b2lkIGZhdWx0Lg0KIAkgKiAqLw0K
IAlsaXN0X21vdmVfdGFpbCgmYmFzZS0+dm1fc3RhdHVzLCAmdm0tPmV2aWN0ZWQpOw0KKwliYXNl
LT5tb3ZlZCA9IHRydWU7DQogfQ0KIA0KIC8qKg0KLS0gDQoyLjE3LjENCg==
