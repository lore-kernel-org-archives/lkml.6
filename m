Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A19BECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB50D208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EO10syi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB50D208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbeIQI2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:50 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:50080
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729065AbeIQI2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKM1/2Vvh0x+gCeI0/5ZlUJC3jOgA7CPEFkMIrD1rEE=;
 b=EO10syi4/C/G26idIkk5x07vZweQiZvUJmFjH6Z08wp3IDkYd4lP8jlB2G1KILs/5MLEXNvMsNFdsE1l6orv6rbUxLAJfA6ltn0c3m/ggd5AU6KcP+EAivkv1GIUuWKlg383bftFZ0epMUvRYR6ZZoq18g18Vz32zH7CMeVa4UU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Akinobu Mita <akinobu.mita@gmail.com>,
        =?utf-8?B?U3RlZmFuIEJyw7xucw==?= <stefan.bruens@rwth-aachen.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 02/87] iio: adc: ina2xx: avoid kthread_stop()
 with stale task_struct
Thread-Topic: [PATCH AUTOSEL 4.14 02/87] iio: adc: ina2xx: avoid
 kthread_stop() with stale task_struct
Thread-Index: AQHUTjLcLbEZf+7HI0GCxtS8VvDmGw==
Date:   Mon, 17 Sep 2018 03:02:25 +0000
Message-ID: <20180917030220.245686-2-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:i5ZZgIRcEKxiIiCvHLSoklsxRnjyoSptc9+CuYNdnJC4SAdKvo4SXNNXBgU+sZFaSeZb2lvu3WJMZULJI1xNoNJL2/4GVs5urW2aRymo3e64+1Xjr7Yce4EP1lRPDOQB/8NJzzZHJWWU/md54+wtINvg5HEN8gnm6zEMxMaTSoteOeiAQUHOwsx98PIwDRTpzWLS3QADhVPzlTpOjd6n7TKdYppXuNYAp1pFn3LfhfZ6k3YCxc9VpX19sMjZfK3e5A74VmtqFiTTkgH7zFZ/GCTYxhvH5gbJJqpcpN8RRd40EnlZDvS4sdUSeGzIX7UXj0Ws8+5m/bYLdloOsvbEBud/3c7F4TpgJRccDeXxLPi46gWWOPaMy6e6nrQ5o1vjlNayM8l3Ajxrj7rGSl9hAiLe7akcNXgU9hsGsoG0Tmm/KnIzPwfsVxEkbuphkG2KvcN3NN9JjhDYiWfjqCKRTw==;5:LdFJw7O6GVTr+5wxPXlCaRLkO4TQ+gjNeehs5nPVSZ4+YIl3LuOU+MlMvowIl3msyGRLzU2NBx1p5467xNFYBqSvP9yYmX+1QecbU0S/72agD7WtfHdx0/NxHQ1H1XuIvnISlWyhRg9b1no9KsYffxyRWHlr+s+pEPzWhB+9c+g=;7:e/Umt/BwqhZf31BzH4NlcadEYIO9Ms8J63ASSZiLTLcsHKDiHv1A5ztJXR8XPgS/nMBxmfs2mzELpHj5KhZ6GQ0R0VmzGVprfozMrnWMSYtOxNGxAtGrngk8VFxVRoekjXwYYfQf9pHl0oiA5cPy9mMlTk6SjdAYidKJygO+sSH5VKFUbtlvEW45O2l0gaKSY+XnQJXsG+L6zIPECUkdHjH5E92G5nl6qzm/TURjJNTQ0FTUE6El39zIg9LF+qL/
x-ms-office365-filtering-correlation-id: 6c9bc6f3-e473-4e18-8799-08d61c4a2421
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855BBF99C237B8D747A9906FB1E0@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(99286004)(7736002)(110136005)(54906003)(97736004)(5660300001)(66066001)(446003)(72206003)(76176011)(86362001)(86612001)(81166006)(81156014)(2906002)(478600001)(305945005)(68736007)(105586002)(2616005)(106356001)(476003)(11346002)(22452003)(6486002)(10090500001)(10290500003)(8676002)(39060400002)(36756003)(6346003)(6116002)(6506007)(3846002)(102836004)(107886003)(6512007)(1076002)(25786009)(217873002)(4326008)(14454004)(26005)(256004)(14444005)(486006)(186003)(316002)(2900100001)(8936002)(53936002)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 4jCS1zwclY25BsqjGhbqS5fTlXInLasXnwKKQRS4NYG2vJS8RF2P9cwsi7VwJsm15MSRvbXotkMcISGqlCghL0ezekEQES7F8agJ6vui7YP/dWSefaDwe4CETYSsNo2FHsF0fKCi79zCQMzYRwC4H1X20bWquwQtekAkZEIBSwRCWxykvQ4gRhsLfWayOfhA/hXhYLQzrOsLqqdBGX+bCwTyBy76TNueTi7hsUYxUZYQKSc4YqQUuB+4FdWUs2CHq5ptq0wmS7YBomyTu2Mh0rbQB5NRteZEjp0qQaLvgjBxT9vxAjEITjGXDy8jUgkEIIGyi43iV2ATxamkxsBp2VUpNLIQ7A96ldlRXTiw1vk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F057780952CBF94ABB1ADDA6228BD903@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9bc6f3-e473-4e18-8799-08d61c4a2421
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:25.5564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
Yw0KaW5kZXggNTlmOTliM2ExODBkLi5kNWI5ZjgzMWViYTcgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2lpby9hZGMvaW5hMnh4LWFkYy5jDQorKysgYi9kcml2ZXJzL2lpby9hZGMvaW5hMnh4LWFkYy5j
DQpAQCAtMzAsNiArMzAsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCiAjaW5jbHVk
ZSA8bGludXgvb2ZfZGV2aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KKyNpbmNs
dWRlIDxsaW51eC9zY2hlZC90YXNrLmg+DQogI2luY2x1ZGUgPGxpbnV4L3V0aWxfbWFjcm9zLmg+
DQogDQogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RhdGEvaW5hMnh4Lmg+DQpAQCAtNzAxLDYg
KzcwMiw3IEBAIHN0YXRpYyBpbnQgaW5hMnh4X2J1ZmZlcl9lbmFibGUoc3RydWN0IGlpb19kZXYg
KmluZGlvX2RldikNCiB7DQogCXN0cnVjdCBpbmEyeHhfY2hpcF9pbmZvICpjaGlwID0gaWlvX3By
aXYoaW5kaW9fZGV2KTsNCiAJdW5zaWduZWQgaW50IHNhbXBsaW5nX3VzID0gU0FNUExJTkdfUEVS
SU9EKGNoaXApOw0KKwlzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2s7DQogDQogCWRldl9kYmcoJmlu
ZGlvX2Rldi0+ZGV2LCAiRW5hYmxpbmcgYnVmZmVyIHcvIHNjYW5fbWFzayAlMDJ4LCBmcmVxID0g
JWQsIGF2ZyA9JXVcbiIsDQogCQkodW5zaWduZWQgaW50KSgqaW5kaW9fZGV2LT5hY3RpdmVfc2Nh
bl9tYXNrKSwNCkBAIC03MTAsMTEgKzcxMiwxNyBAQCBzdGF0aWMgaW50IGluYTJ4eF9idWZmZXJf
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
ZmVyX2Rpc2FibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCkBAIC03MjMsNiArNzMxLDcg
QEAgc3RhdGljIGludCBpbmEyeHhfYnVmZmVyX2Rpc2FibGUoc3RydWN0IGlpb19kZXYgKmluZGlv
X2RldikNCiANCiAJaWYgKGNoaXAtPnRhc2spIHsNCiAJCWt0aHJlYWRfc3RvcChjaGlwLT50YXNr
KTsNCisJCXB1dF90YXNrX3N0cnVjdChjaGlwLT50YXNrKTsNCiAJCWNoaXAtPnRhc2sgPSBOVUxM
Ow0KIAl9DQogDQotLSANCjIuMTcuMQ0K
