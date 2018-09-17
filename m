Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794BCECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB512147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="P1RzcE6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB512147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbeIQIZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:25:27 -0400
Received: from mail-eopbgr710124.outbound.protection.outlook.com ([40.107.71.124]:62784
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728034AbeIQIZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhJD6nvzdMY0Jeqf6ayNDrzcHW14Uxcl7O2huKciT3E=;
 b=P1RzcE6rm+7v67hRhKeVVi8EtBQeaTEjU9iRItvfuk25i0+IA5l2lgLGt/hrwPnuUclj4b5bj1wH8Xr5uo6FEFKqFrShSkl56aYXQwHoH+eIkcWnqLtX1cqqzTkMb87tg9MKthLax2+fRM+yvYK3jM/aQuVCfO9yHx/6D/9Vx8E=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:00:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stafford Horne <shorne@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 001/136] crypto: skcipher - Fix
 -Wstringop-truncation warnings
Thread-Topic: [PATCH AUTOSEL 4.18 001/136] crypto: skcipher - Fix
 -Wstringop-truncation warnings
Thread-Index: AQHUTjKMsr4kIiuRRkyiW0tk0mhhgg==
Date:   Mon, 17 Sep 2018 03:00:10 +0000
Message-ID: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:Py7EstJSZ4N2wRP6AV+g6560j6pTf7wB3wyXd41URTB9LnTYhfdZ2OVSJ/1X6GBy8bT+5ZCb/Uo3qhA7T+2iKqWSdPCJjR+UXFGjaAqG1x1eQhSct+cM5HKPJCPTymWVgRx3qGoVCX2IDCV+baap05+xn2DBS0hcHjgXSf08J6ZgUZzruPOW1E4O3+81T2VL5zh86fNZBTLHU7C3gvjGy2Lsl50Rxe1Im1vpzV60LOpkgfQPrYg2rfO9R5gj8MUdS/qU25Qc8wYwRIaz2R5gHeCV3K8HpxBoVFPydaX8+6EBAchUqic1QBZhm9gFDlBAb4UrTetGLagGRRA7KxOA5ASmLtYoL+kd0sWozwlBMMEhUIc0I+qtcf6QigFKRYBN4REu3FR/B9z+IOalP6RvlLTckRla3EDFsPZZGm0gZQ8NjkYDH/sMehM2yEsxO7j2ew/K0zvBOCiZqhBD+Gdf+A==;5:dPf57XsDmMygYBpTsD0OxPhG37Uo27WKOCK977VYCnK4u/k8IaIt2Fe8wq0TM/4By9TvCSQ3E5RXokE+Jnmj3xPtHkwnqEMRzRperbUdjfc3PPi8867mcMSxEHIch1FDkU7H56UkkkvhltJBqrAW5A4JzvZL+7dbtcK0i3zOQ6A=;7:R1GvOR9Fct3UaFj/gmKzdQWxSo3g01d8AEkjJnwnmJHecEKPQQuCjDzEtk1dHdxct019032W53h1X9eVG//K28OGxjzSY/MWjwYvYu6MLqYVE9F/INqufzZE2nE3AYZvpILvJXrNLJSYQP4qRxpL6mBNgzZsSNZ8HHAJ9W3q5vrEjqagYD0oBFIHPVDTBhEIYwkRpgB8cuFuI4G4QWDhfl2n0CGd9xDTegxXlAyeVpx6CvM5oJJO7T1mzSiqnSLf
x-ms-office365-filtering-correlation-id: 1153d08f-2563-4f72-fd5a-08d61c49aee0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0134A9E38A045ECF0B9128ACFB1E0@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211171220733660)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(6506007)(10090500001)(14454004)(99286004)(68736007)(6512007)(4326008)(25786009)(217873002)(39060400002)(107886003)(72206003)(22452003)(256004)(14444005)(36756003)(54906003)(110136005)(8676002)(6486002)(97736004)(10290500003)(6116002)(26005)(7736002)(86612001)(5660300001)(86362001)(53936002)(316002)(486006)(476003)(2900100001)(5250100002)(105586002)(102836004)(305945005)(106356001)(66066001)(81166006)(81156014)(1076002)(2501003)(2906002)(6436002)(8936002)(478600001)(2616005)(186003)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dTEL1DCP4JkWlsBPkOAd3E9/fuP45Si20jMU8628t1QKHFA5+kg1BFAA8ZYlsyL+bj/wP/8+DaRCRbFLIj3mMMbpK3PxhwADOni2/BmXFsQUBGuhshj0o5xfxf8HGHxn7nWGPzJoq8g58rvG/OPlRZfYRKb6bG3jry+pyY9H9R3Gdz180uDEjdoWnI4WBTohDF/az63LK20q91K5OVVu2WNU6FqndAJ65jkfdtQn9rbGd9uLIZwboVjXrhl0paFktcqsoOOsrRcnrquWpiS7ZKM2lGUX/xn7xTLHAOCBEF/XNON7ZrJM5IPrtPmVMppu0ydx8WrfGo1cl00zs4bP+X4mJK5XMee8XiEN09kI5/Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <872E98DEAD4FFF4CAB09DF52E22281E6@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1153d08f-2563-4f72-fd5a-08d61c49aee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:11.0424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3RhZmZvcmQgSG9ybmUgPHNob3JuZUBnbWFpbC5jb20+DQoNClsgVXBzdHJlYW0gY29t
bWl0IGNlZmQ3NjlmZDAxOTJjODRkNjM4ZjY2ZGEyMDI0NTllZDhhZDYzYmEgXQ0KDQpBcyBvZiBH
Q0MgOS4wLjAgdGhlIGJ1aWxkIGlzIHJlcG9ydGluZyB3YXJuaW5ncyBsaWtlOg0KDQogICAgY3J5
cHRvL2FibGtjaXBoZXIuYzogSW4gZnVuY3Rpb24g4oCYY3J5cHRvX2FibGtjaXBoZXJfcmVwb3J0
4oCZOg0KICAgIGNyeXB0by9hYmxrY2lwaGVyLmM6Mzc0OjI6IHdhcm5pbmc6IOKAmHN0cm5jcHni
gJkgc3BlY2lmaWVkIGJvdW5kIDY0IGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV3N0cmluZ29w
LXRydW5jYXRpb25dDQogICAgICBzdHJuY3B5KHJibGtjaXBoZXIuZ2VuaXYsIGFsZy0+Y3JhX2Fi
bGtjaXBoZXIuZ2VuaXYgPzogIjxkZWZhdWx0PiIsDQogICAgICBefn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQogICAgICAg
c2l6ZW9mKHJibGtjaXBoZXIuZ2VuaXYpKTsNCiAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+DQoNClRoaXMgbWVhbnMgdGhlIHN0cm55Y3B5IG1pZ2h0IGNyZWF0ZSBhIG5vbiBudWxsIHRl
cm1pbmF0ZWQgc3RyaW5nLiAgRml4IHRoaXMgYnkNCmV4cGxpY2l0bHkgcGVyZm9ybWluZyAnXDAn
IHRlcm1pbmF0aW9uLg0KDQpDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZz4NCkNjOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KQ2M6IE1heCBG
aWxpcHBvdiA8amNtdmJrYmNAZ21haWwuY29tPg0KQ2M6IEVyaWMgQmlnZ2VycyA8ZWJpZ2dlcnMz
QGdtYWlsLmNvbT4NCkNjOiBOaWNrIERlc2F1bG5pZXJzIDxuaWNrLmRlc2F1bG5pZXJzQGdtYWls
LmNvbT4NClNpZ25lZC1vZmYtYnk6IFN0YWZmb3JkIEhvcm5lIDxzaG9ybmVAZ21haWwuY29tPg0K
U2lnbmVkLW9mZi1ieTogSGVyYmVydCBYdSA8aGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1Pg0K
U2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29t
Pg0KLS0tDQogY3J5cHRvL2FibGtjaXBoZXIuYyB8IDIgKysNCiBjcnlwdG8vYmxrY2lwaGVyLmMg
IHwgMSArDQogMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBh
L2NyeXB0by9hYmxrY2lwaGVyLmMgYi9jcnlwdG8vYWJsa2NpcGhlci5jDQppbmRleCA0ZWU3YzA0
MWJiODIuLjg4ODJlOTBlODY4ZSAxMDA2NDQNCi0tLSBhL2NyeXB0by9hYmxrY2lwaGVyLmMNCisr
KyBiL2NyeXB0by9hYmxrY2lwaGVyLmMNCkBAIC0zNjgsNiArMzY4LDcgQEAgc3RhdGljIGludCBj
cnlwdG9fYWJsa2NpcGhlcl9yZXBvcnQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IGNyeXB0
b19hbGcgKmFsZykNCiAJc3RybmNweShyYmxrY2lwaGVyLnR5cGUsICJhYmxrY2lwaGVyIiwgc2l6
ZW9mKHJibGtjaXBoZXIudHlwZSkpOw0KIAlzdHJuY3B5KHJibGtjaXBoZXIuZ2VuaXYsIGFsZy0+
Y3JhX2FibGtjaXBoZXIuZ2VuaXYgPzogIjxkZWZhdWx0PiIsDQogCQlzaXplb2YocmJsa2NpcGhl
ci5nZW5pdikpOw0KKwlyYmxrY2lwaGVyLmdlbml2W3NpemVvZihyYmxrY2lwaGVyLmdlbml2KSAt
IDFdID0gJ1wwJzsNCiANCiAJcmJsa2NpcGhlci5ibG9ja3NpemUgPSBhbGctPmNyYV9ibG9ja3Np
emU7DQogCXJibGtjaXBoZXIubWluX2tleXNpemUgPSBhbGctPmNyYV9hYmxrY2lwaGVyLm1pbl9r
ZXlzaXplOw0KQEAgLTQ0Miw2ICs0NDMsNyBAQCBzdGF0aWMgaW50IGNyeXB0b19naXZjaXBoZXJf
cmVwb3J0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBjcnlwdG9fYWxnICphbGcpDQogCXN0
cm5jcHkocmJsa2NpcGhlci50eXBlLCAiZ2l2Y2lwaGVyIiwgc2l6ZW9mKHJibGtjaXBoZXIudHlw
ZSkpOw0KIAlzdHJuY3B5KHJibGtjaXBoZXIuZ2VuaXYsIGFsZy0+Y3JhX2FibGtjaXBoZXIuZ2Vu
aXYgPzogIjxidWlsdC1pbj4iLA0KIAkJc2l6ZW9mKHJibGtjaXBoZXIuZ2VuaXYpKTsNCisJcmJs
a2NpcGhlci5nZW5pdltzaXplb2YocmJsa2NpcGhlci5nZW5pdikgLSAxXSA9ICdcMCc7DQogDQog
CXJibGtjaXBoZXIuYmxvY2tzaXplID0gYWxnLT5jcmFfYmxvY2tzaXplOw0KIAlyYmxrY2lwaGVy
Lm1pbl9rZXlzaXplID0gYWxnLT5jcmFfYWJsa2NpcGhlci5taW5fa2V5c2l6ZTsNCmRpZmYgLS1n
aXQgYS9jcnlwdG8vYmxrY2lwaGVyLmMgYi9jcnlwdG8vYmxrY2lwaGVyLmMNCmluZGV4IDc3YjVm
YTI5M2Y2Ni4uZjkzYWJmMTNiNWQ0IDEwMDY0NA0KLS0tIGEvY3J5cHRvL2Jsa2NpcGhlci5jDQor
KysgYi9jcnlwdG8vYmxrY2lwaGVyLmMNCkBAIC01MTAsNiArNTEwLDcgQEAgc3RhdGljIGludCBj
cnlwdG9fYmxrY2lwaGVyX3JlcG9ydChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgY3J5cHRv
X2FsZyAqYWxnKQ0KIAlzdHJuY3B5KHJibGtjaXBoZXIudHlwZSwgImJsa2NpcGhlciIsIHNpemVv
ZihyYmxrY2lwaGVyLnR5cGUpKTsNCiAJc3RybmNweShyYmxrY2lwaGVyLmdlbml2LCBhbGctPmNy
YV9ibGtjaXBoZXIuZ2VuaXYgPzogIjxkZWZhdWx0PiIsDQogCQlzaXplb2YocmJsa2NpcGhlci5n
ZW5pdikpOw0KKwlyYmxrY2lwaGVyLmdlbml2W3NpemVvZihyYmxrY2lwaGVyLmdlbml2KSAtIDFd
ID0gJ1wwJzsNCiANCiAJcmJsa2NpcGhlci5ibG9ja3NpemUgPSBhbGctPmNyYV9ibG9ja3NpemU7
DQogCXJibGtjaXBoZXIubWluX2tleXNpemUgPSBhbGctPmNyYV9ibGtjaXBoZXIubWluX2tleXNp
emU7DQotLSANCjIuMTcuMQ0K
