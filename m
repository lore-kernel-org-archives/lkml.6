Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD89ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D5020867
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gOUwtkut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D5020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387806AbeITI24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:28:56 -0400
Received: from mail-eopbgr700094.outbound.protection.outlook.com ([40.107.70.94]:25376
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387726AbeITI2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urCUYlN7KiyUE8POaXRpJYugTSrnWkjMHAhnYAbxHuI=;
 b=gOUwtkutqmPi3BLmnJG8ppJ0b2wnXny5cIXNJQ/wepxj2DT/FOprFQ68IpytgQUIYT5loNAbhIf9JElFN1l9NEeukY9gDmRfaw6HpcZkhvRlKZWic6myhmxNPNzABjMyEyYHSfq8ox2i7SlcHHxBgcbOZjk95A3HS8hWb0S5Mls=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Emily Deng <Emily.Deng@amd.com>, Monk Liu <Monk.Liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 20/56] amdgpu: fix multi-process hang issue
Thread-Topic: [PATCH AUTOSEL 4.18 20/56] amdgpu: fix multi-process hang issue
Thread-Index: AQHUUIxMbLCoJI1n+ky/5qyoOAG0lg==
Date:   Thu, 20 Sep 2018 02:47:41 +0000
Message-ID: <20180920024716.58490-20-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:QViKT7ZwwJec6Cdcs1vAfNTlynb+SyxM/kDZySTs4q2uRSfdKd9qg0svFAXnSAr8BuljVvghC24h+CHRJyP8pOicXrZbafv/zU5G0kN6QlNdSx0NJ4OOlR1bsrB8H+uXMDmJ/+67VjF1Z6Zt2TE/Agm1OI5bjSB6idSZrWZTqrbht48mJkNewdVJaZaCPL5CHa7bcF3orw/VCYlukRWchH62dsJMps/5lPl6AHiQ4PBoFJIEoDd9L0JFluWlYyKpVWsWJZaeL58apWMxgifG16AvYLIkX0TLHIChpL7ALLd8eYjJxE/Xu6ikiiT9ERfhJP2HXhyCOMcATmvOvKS/NazpTKgG2IA2PJIGg7BxtBpqFznPlouWlmAvnr6CX6jLPpukamvqApWpyQnIrILiUSLF8ElE1tfwcZ6sOh6dCqa9tjfroMZRTGR6CJjGy5bU6rm/ihjZ88QBjH41vwesKg==;5:Uk5ImDnrLVUvzvLiJcb8ymvnL/8a7K6UtLq9Q0Rh2+wGiSlkf+hSsboFs49jxPiWZ/5vUS8VwJhjH2ZCTkQfzg8l5PacGaPH5xEM1D0r2lrXqG2duKG4L6IBJVyeT4y6ZL/FGaqwF3Jfzn9e22AVBgvP4/8HuJnlyxXZDD3BvJ0=;7:Yi/JGPU1kStMJbXICSYEEYlSeag5OWwNG8jSXBka3R++PHH3v9EKCSwJQ/0TtbtNdnM9wl08b7hiRc21tUyasbsZkZWrURGMv6U2G7yJo/e4apv84zyFipr/dbuXEterLnJ/jWBB1xeeLvUpH7wGjqPJ9rBLXToj1uFdQSjVveLQ2bcx3E1vS9cCYMn1MGVUf7t1uZnkN/QnXxggjqCu5Dg946SJV92ivO6Uwgc9XqZ9D1dzZFDdEa6Z+vADtRM5
x-ms-office365-filtering-correlation-id: d8a7a1a4-d1fd-456e-8cc0-08d61ea37081
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB0822140E6F24823FF8363F26FB130@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(10290500003)(6512007)(54906003)(110136005)(2501003)(2900100001)(86612001)(446003)(6116002)(316002)(81156014)(81166006)(1076002)(26005)(8936002)(22452003)(86362001)(2906002)(107886003)(2616005)(486006)(256004)(14444005)(99286004)(66066001)(5660300001)(6506007)(217873002)(5250100002)(102836004)(186003)(3846002)(4326008)(6436002)(11346002)(25786009)(68736007)(71190400001)(71200400001)(8676002)(476003)(6346003)(6486002)(36756003)(14454004)(106356001)(10090500001)(53936002)(305945005)(72206003)(76176011)(7736002)(97736004)(478600001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: BqMd9+wpiWC5+/LE55cIoAmPfJGK4OvBSeJeTT72ICdtWRPtYiagccSkSxyGAwbn/E7i1EQHWM8ZS/uak6kK0B5dI0gjqXL2hSlKGPZnr7pL31+q3+Q8cCLPSSKUAjypWz4X7fhkswEJOACzBfqxTmtCWHAuRPk5zo42bMznJ6ry7m4LrJRGu8kp2yCgL8PQLqM63y3te9UweEfNUo+GMc3J6AAjvQn1a+19+Mc6ppWssk+8aigJoEcUPjh+ZVgqJz8e+nJpl9vZRNjscUAgZ2dNO2mj8YqnRS4/2EXXRPmerJAzGbwJQ3VuIO2WNp6sC6X8KVEXYQSS3lOzaTHkE40FrxvZBuuo8uTnjvMzfiw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9D09AF11FD9154584C9882C121281CC@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a7a1a4-d1fd-456e-8cc0-08d61ea37081
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:41.2888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPg0KDQpbIFVwc3RyZWFtIGNvbW1p
dCAyZjQwYzZlYWM3NGEyYTYwOTIxY2RlYzllOWE4YTU3ZTg4ZTMxNDM0IF0NCg0KU1dERVYtMTQ2
NDk5OiBoYW5nIGR1cmluZyBtdWx0aSB2dWxrYW4gcHJvY2VzcyB0ZXN0aW5nDQoNCmNhdXNlOg0K
dGhlIHNlY29uZCBmcmFtZSdzIFBSRUFNQkxFX0lCIGhhdmUgY2xlYXItc3RhdGUNCmFuZCBMT0FE
IGFjdGlvbnMsIHRob3NlIGFjdGlvbnMgcnVpbiB0aGUgcGlwZWxpbmUNCnRoYXQgaXMgc3RpbGwg
ZG9pbmcgcHJvY2VzcyBpbiB0aGUgcHJldmlvdXMgZnJhbWUncw0Kd29yay1sb2FkIElCLg0KDQpm
aXg6DQpuZWVkIGluc2VydCBwaXBlbGluZSBzeW5jIGlmIGhhdmUgY29udGV4dCBzd2l0Y2ggZm9y
DQpTUklPViAoYmVjYXVzZSBvbmx5IFNSSU9WIHdpbGwgcmVwb3J0IFBSRUVNUFRJT04gZmxhZw0K
dG8gVU1EKQ0KDQpTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4NClNp
Z25lZC1vZmYtYnk6IEVtaWx5IERlbmcgPEVtaWx5LkRlbmdAYW1kLmNvbT4NClJldmlld2VkLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYyB8IDMgKystDQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfaWIuYw0KaW5kZXggN2FhYTI2M2FkOGM3Li42YjVkNGEyMDg2MGQgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYw0KKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMNCkBAIC0xNjQsOCArMTY0LDEw
IEBAIGludCBhbWRncHVfaWJfc2NoZWR1bGUoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCB1bnNp
Z25lZCBudW1faWJzLA0KIAkJcmV0dXJuIHI7DQogCX0NCiANCisJbmVlZF9jdHhfc3dpdGNoID0g
cmluZy0+Y3VycmVudF9jdHggIT0gZmVuY2VfY3R4Ow0KIAlpZiAocmluZy0+ZnVuY3MtPmVtaXRf
cGlwZWxpbmVfc3luYyAmJiBqb2IgJiYNCiAJICAgICgodG1wID0gYW1kZ3B1X3N5bmNfZ2V0X2Zl
bmNlKCZqb2ItPnNjaGVkX3N5bmMsIE5VTEwpKSB8fA0KKwkgICAgIChhbWRncHVfc3Jpb3ZfdmYo
YWRldikgJiYgbmVlZF9jdHhfc3dpdGNoKSB8fA0KIAkgICAgIGFtZGdwdV92bV9uZWVkX3BpcGVs
aW5lX3N5bmMocmluZywgam9iKSkpIHsNCiAJCW5lZWRfcGlwZV9zeW5jID0gdHJ1ZTsNCiAJCWRt
YV9mZW5jZV9wdXQodG1wKTsNCkBAIC0xOTYsNyArMTk4LDYgQEAgaW50IGFtZGdwdV9pYl9zY2hl
ZHVsZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIHVuc2lnbmVkIG51bV9pYnMsDQogCX0NCiAN
CiAJc2tpcF9wcmVhbWJsZSA9IHJpbmctPmN1cnJlbnRfY3R4ID09IGZlbmNlX2N0eDsNCi0JbmVl
ZF9jdHhfc3dpdGNoID0gcmluZy0+Y3VycmVudF9jdHggIT0gZmVuY2VfY3R4Ow0KIAlpZiAoam9i
ICYmIHJpbmctPmZ1bmNzLT5lbWl0X2NudHhjbnRsKSB7DQogCQlpZiAobmVlZF9jdHhfc3dpdGNo
KQ0KIAkJCXN0YXR1cyB8PSBBTURHUFVfSEFWRV9DVFhfU1dJVENIOw0KLS0gDQoyLjE3LjENCg==
