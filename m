Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5C0ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C62214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="o170Rw1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C62214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeIQIZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:25:29 -0400
Received: from mail-eopbgr710124.outbound.protection.outlook.com ([40.107.71.124]:62784
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728036AbeIQIZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NAkg5r1JuV+rZjwrcr9qqx2hJCHEkr6pKMtm+F/Zuc=;
 b=o170Rw1m0xuCmUp+s8Va1mp/C7v7CsiVjJoyEmvvooJz87eP3USBgATPTbaTQJJh4s4Dpx5dpBREGELMT6DnnJlLQjZS0q5RT4T8tYo3tRTi0LAc4NDai22lBmM7VtCfC/zieVTafMhe4Ha6mAztHyFpcB9Z5ozHagRSEzzGAWo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:00:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Akinobu Mita <akinobu.mita@gmail.com>,
        =?utf-8?B?U3RlZmFuIEJyw7xucw==?= <stefan.bruens@rwth-aachen.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 002/136] iio: adc: ina2xx: avoid kthread_stop()
 with stale task_struct
Thread-Topic: [PATCH AUTOSEL 4.18 002/136] iio: adc: ina2xx: avoid
 kthread_stop() with stale task_struct
Thread-Index: AQHUTjKM1KENgPTTcEeZrUZcKbHDlQ==
Date:   Mon, 17 Sep 2018 03:00:11 +0000
Message-ID: <20180917030006.245495-2-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:UDZmmTzXt8uY5dSPGbnuSWUDX77zyTu3wIwjm/bJeXcFR3mNqmy1FVr2M7Ac59bq/RedW/5ByWp8+qe6ZXrUw0fq9F7cu4M7vJAKrrqfb2lXdbZlPbTGqzO4slOj8JMzb66vi9CaoXTxA46PVMKoGwFcvcbTJ4hF0W0f5E+PolO2HNiY6MIvURTDecOBmCoUAmspr/cWWsOPqF6L0jP0iR7dBuzTza4pTgqNJLox8C8UeBz8IPH7YXv2jB7xxOD9k9XOvShvUV/GKaXgseZHd+MD6bJuiM+8oEpsiDBIqrgESOPPPpNIlMbeWp+2ipkCVXhBLGSKPmTFlGnJ67Xs8yiZBsqzDD9XOu/EXMvHuMco/THgIjaEmc0sVQMg01lzdsXj6zvYdh4461A9EJwENS9Ox+a1+N45OP57d7uF6EVmzNL9CGyZ1uAG0ZaJtEisfuElbGAvpONMAnrATgufUQ==;5:bUR0zkaNqUqXgSgasgl6fOvO+mHrADl2Oh12Jv8u3VW0Y3oJPLVfc4mcBpwFJoDQEMxrGK/eh9gdbGKYuvNCWN+yumDivAEysUbMRKTL3VjZwPual7dQSmLY5Jf3jZ4CcZRB22ddvfSjKmxuoGSzLC/hXKazzbC4PlXsPgbgG6A=;7:El+lILdM5KoJT8sFOhB4XA+QTdbSwAgsOZ09JPzVDKsSgT9f3HTSCGKe95GH77MEa04va9u/CqKR3V2nDTMkQ9qqSQH/RCU/XVU1lxB5I1aS4HC6xhFUh79X6YoNPSifgf9gatJVMJYOhyad+7j3SbVXG81oSv0f2jK3E8bag9+Tv9gUnP7gBvJOIEGFcIvenjGo4hH6dmsvjZQ+8ubzv4S92UCQR0uLLMbUulqE3Fn/yHeHVCamHaKhyHuS41Za
x-ms-office365-filtering-correlation-id: 05f905ef-fb7a-4ea3-1e45-08d61c49af64
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0134FEC2FED84EDAA387CA5CFB1E0@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(6506007)(10090500001)(14454004)(99286004)(76176011)(68736007)(6512007)(4326008)(25786009)(217873002)(39060400002)(107886003)(72206003)(22452003)(256004)(14444005)(36756003)(54906003)(110136005)(8676002)(6486002)(97736004)(10290500003)(6116002)(11346002)(26005)(7736002)(86612001)(5660300001)(86362001)(53936002)(316002)(486006)(476003)(2900100001)(5250100002)(105586002)(102836004)(305945005)(106356001)(66066001)(81166006)(81156014)(1076002)(2501003)(2906002)(6436002)(8936002)(446003)(478600001)(2616005)(186003)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IdEQYGLN/x4Zix7mKiiXKW+2GpeV+ZFRT7UUaXxACDWtkEA9PtxUnCQjuCQEqFgZ/v35PBngN8JLsgQCx43VmY3XN4pxPinkyvtwbbY6HfRPIVZKtemHzTgIMk0JaloHNY0wkfYRNnR4L7O+0kBtSLwnWo3L+U859fcwPHrVlapilTbrdbfWs8Yr65bFNdKf2MInpEaTtwT4iZ1DuKmEJrHDhpbH7iqsbOxDM5hW4cS9jyJElJ5g/Tf/yQovvdrI1eUICKVx+o1JsrIL0v7i2DZvpaKWYKUbMVzEitPcV+LnTf8zkJWODjWtFls+WhVRcgwyHIyVHkW7Kj3P1UCNBKu7IS7/UDz9cmJsTrBB6uA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AFF7D9FB2738E429709F414F3CFF60C@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f905ef-fb7a-4ea3-1e45-08d61c49af64
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:11.9330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWtpbm9idSBNaXRhIDxha2lub2J1Lm1pdGFAZ21haWwuY29tPg0KDQpbIFVwc3RyZWFt
IGNvbW1pdCA3ZDZjZDIxZDgyYmFjYWIyZDE3ODZmZTVlOTg5ZTQ4MTViNzVkOWEzIF0NCg0KV2hl
biB0aGUgYnVmZmVyIGlzIGVuYWJsZWQgZm9yIGluYTJ4eCBkcml2ZXIsIGEgZGVkaWNhdGVkIGt0
aHJlYWQgaXMNCmludm9rZWQgdG8gY2FwdHVyZSBtZXN1cmVtZW50IGRhdGEuICBXaGVuIHRoZSBi
dWZmZXIgaXMgZGlzYWJsZWQsIHRoZQ0Ka3RocmVhZCBpcyBzdG9wcGVkLg0KDQpIb3dldmVyIGlm
IHRoZSBrdGhyZWFkIGdldHMgcmVnaXN0ZXIgYWNjZXNzIGVycm9ycywgaXQgaW1tZWRpYXRlbHkg
ZXhpdHMNCmFuZCB3aGVuIHRoZSBtYWxmdW5jdGlvbmFsIGJ1ZmZlciBpcyBkaXNhYmxlZCwgdGhl
IHN0YWxlIHRhc2tfc3RydWN0DQpwb2ludGVyIGlzIGFjY2Vzc2VkIGFzIHRoZXJlIGlzIG5vIGt0
aHJlYWQgdG8gYmUgc3RvcHBlZC4NCg0KQSBzaW1pbGFyIGlzc3VlIGluIHRoZSB1c2JpcCBkcml2
ZXIgaXMgcHJldmVudGVkIGJ5IGt0aHJlYWRfZ2V0X3J1biBhbmQNCmt0aHJlYWRfc3RvcF9wdXQg
aGVscGVycyBieSBpbmNyZWFzaW5nIHVzYWdlIGNvdW50IG9mIHRoZSB0YXNrX3N0cnVjdC4NClRo
aXMgY2hhbmdlIGFwcGxpZXMgdGhlIHNhbWUgc29sdXRpb24uDQoNCkNjOiBTdGVmYW4gQnLDvG5z
IDxzdGVmYW4uYnJ1ZW5zQHJ3dGgtYWFjaGVuLmRlPg0KQ2M6IEpvbmF0aGFuIENhbWVyb24gPGpp
YzIzQGtlcm5lbC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBBa2lub2J1IE1pdGEgPGFraW5vYnUubWl0
YUBnbWFpbC5jb20+DQpGaXhlczogYzQzYTEwMmU2N2RiICgiaWlvOiBpbmEyeHg6IGFkZCBzdXBw
b3J0IGZvciBUSSBJTkEyeHggUG93ZXIgTW9uaXRvcnMiKQ0KU2lnbmVkLW9mZi1ieTogSm9uYXRo
YW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPg0KU2lnbmVkLW9mZi1ieTog
U2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJpdmVy
cy9paW8vYWRjL2luYTJ4eC1hZGMuYyB8IDE3ICsrKysrKysrKysrKystLS0tDQogMSBmaWxlIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2lpby9hZGMvaW5hMnh4LWFkYy5jIGIvZHJpdmVycy9paW8vYWRjL2luYTJ4eC1hZGMu
Yw0KaW5kZXggMDYzNWE3OTg2NGJmLi5kMTIzOTYyNDE4N2QgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2lpby9hZGMvaW5hMnh4LWFkYy5jDQorKysgYi9kcml2ZXJzL2lpby9hZGMvaW5hMnh4LWFkYy5j
DQpAQCAtMzAsNiArMzAsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCiAjaW5jbHVk
ZSA8bGludXgvb2ZfZGV2aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KKyNpbmNs
dWRlIDxsaW51eC9zY2hlZC90YXNrLmg+DQogI2luY2x1ZGUgPGxpbnV4L3V0aWxfbWFjcm9zLmg+
DQogDQogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RhdGEvaW5hMnh4Lmg+DQpAQCAtODI2LDYg
KzgyNyw3IEBAIHN0YXRpYyBpbnQgaW5hMnh4X2J1ZmZlcl9lbmFibGUoc3RydWN0IGlpb19kZXYg
KmluZGlvX2RldikNCiB7DQogCXN0cnVjdCBpbmEyeHhfY2hpcF9pbmZvICpjaGlwID0gaWlvX3By
aXYoaW5kaW9fZGV2KTsNCiAJdW5zaWduZWQgaW50IHNhbXBsaW5nX3VzID0gU0FNUExJTkdfUEVS
SU9EKGNoaXApOw0KKwlzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2s7DQogDQogCWRldl9kYmcoJmlu
ZGlvX2Rldi0+ZGV2LCAiRW5hYmxpbmcgYnVmZmVyIHcvIHNjYW5fbWFzayAlMDJ4LCBmcmVxID0g
JWQsIGF2ZyA9JXVcbiIsDQogCQkodW5zaWduZWQgaW50KSgqaW5kaW9fZGV2LT5hY3RpdmVfc2Nh
bl9tYXNrKSwNCkBAIC04MzUsMTEgKzgzNywxNyBAQCBzdGF0aWMgaW50IGluYTJ4eF9idWZmZXJf
ZW5hYmxlKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQogCWRldl9kYmcoJmluZGlvX2Rldi0+
ZGV2LCAiQXN5bmMgcmVhZG91dCBtb2RlOiAlZFxuIiwNCiAJCWNoaXAtPmFsbG93X2FzeW5jX3Jl
YWRvdXQpOw0KIA0KLQljaGlwLT50YXNrID0ga3RocmVhZF9ydW4oaW5hMnh4X2NhcHR1cmVfdGhy
ZWFkLCAodm9pZCAqKWluZGlvX2RldiwNCi0JCQkJICIlczolZC0ldXVzIiwgaW5kaW9fZGV2LT5u
YW1lLCBpbmRpb19kZXYtPmlkLA0KLQkJCQkgc2FtcGxpbmdfdXMpOw0KKwl0YXNrID0ga3RocmVh
ZF9jcmVhdGUoaW5hMnh4X2NhcHR1cmVfdGhyZWFkLCAodm9pZCAqKWluZGlvX2RldiwNCisJCQkg
ICAgICAiJXM6JWQtJXV1cyIsIGluZGlvX2Rldi0+bmFtZSwgaW5kaW9fZGV2LT5pZCwNCisJCQkg
ICAgICBzYW1wbGluZ191cyk7DQorCWlmIChJU19FUlIodGFzaykpDQorCQlyZXR1cm4gUFRSX0VS
Uih0YXNrKTsNCisNCisJZ2V0X3Rhc2tfc3RydWN0KHRhc2spOw0KKwl3YWtlX3VwX3Byb2Nlc3Mo
dGFzayk7DQorCWNoaXAtPnRhc2sgPSB0YXNrOw0KIA0KLQlyZXR1cm4gUFRSX0VSUl9PUl9aRVJP
KGNoaXAtPnRhc2spOw0KKwlyZXR1cm4gMDsNCiB9DQogDQogc3RhdGljIGludCBpbmEyeHhfYnVm
ZmVyX2Rpc2FibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCkBAIC04NDgsNiArODU2LDcg
QEAgc3RhdGljIGludCBpbmEyeHhfYnVmZmVyX2Rpc2FibGUoc3RydWN0IGlpb19kZXYgKmluZGlv
X2RldikNCiANCiAJaWYgKGNoaXAtPnRhc2spIHsNCiAJCWt0aHJlYWRfc3RvcChjaGlwLT50YXNr
KTsNCisJCXB1dF90YXNrX3N0cnVjdChjaGlwLT50YXNrKTsNCiAJCWNoaXAtPnRhc2sgPSBOVUxM
Ow0KIAl9DQogDQotLSANCjIuMTcuMQ0K
