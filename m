Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F85C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BE120666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="G5NFlOjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BE120666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbeJAHOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:30 -0400
Received: from mail-eopbgr680112.outbound.protection.outlook.com ([40.107.68.112]:63837
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729265AbeJAHO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQO8hH9Op4KdZswGOokUdFxJrnsTJ4WqNZQ7cB8GTN0=;
 b=G5NFlOjyFLMkpvJ5oQtz9thgYTwhKIW1brLwcLJwN8BlrJD2G/h/vzLdXoYGYTPvcuWeK6PzCyppPY8e6AfCO0Fro0wcRnwNa8CjjohVF6rh6ZJvPT2iJk4JuZc2Bba9OyLblYA9k+6qMpPC0AnIl8xLW4cuDRiaSV6vjqTFBA4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:39:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 56/65] drm/amdgpu: fix error handling in
 amdgpu_cs_user_fence_chunk
Thread-Topic: [PATCH AUTOSEL 4.18 56/65] drm/amdgpu: fix error handling in
 amdgpu_cs_user_fence_chunk
Thread-Index: AQHUWR8Xou0cJhyfXU6hH3jRTjU1Ww==
Date:   Mon, 1 Oct 2018 00:38:36 +0000
Message-ID: <20181001003754.146961-56-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:7S4fJpqG0g0qcCEVlRAmFrgC19MC7c0RHX2rNAY3nGJpIkFyyvwZIqmm8PYwP6WoCLjl7iMFhgLXS46WemEVMEB6RxhDn64LehnQtFEv8fchyEcTu7H+/NfZhg8T4Qtl1e0EznZKt/spFbaMMPhvc8osFJNYdkg2CyuKx7GQ6zTkZjufosIin71fOyRarAZeZG2nq+IQBkLPgWX2NktzwuG0UhjZ0DJL1FvlIcxNh0UR5OqkDq1f9BAEOhuC6Ag6uCAxIfsa5ksySJhxx4tfbwzu1M73tFMI+GUhFsYyq8wuKttMWAtNIo8GFN3hf1YP73TaWsvTbdzcOxhwm7YlK5WgxNmj41FWQokrL4+uX5WbxK9w1x/RXeRHVHw+i3bOgg2n9Xg2Lu78b1GdYYH38RPDNRvas0Nw62wxSJJj80h7d5OZE01AtGLwlLprLEfSksawXAINl6qJcOcksWVZFA==;5:IFouNZC44lueu1wIodqf4Dq6penxdBbStVrZ5+O0QetLZvJaK9z4AN3PAA/J5GrNwiir51bUGbnXeBNook38JUyPgNx/ZEr7iNBXv9TPfMDwHF0SZLY9qPIsY3tDqccLlMjWcRsrxw+zNNttpozQQX6swKvD32O836S4aDCn+RI=;7:a6JbvVuY7m6WY6cbyifkc0oxnWsZmr2W7/Da1DIgczcKh/OLg2n9nLVGiXKr+I6ZrL8Aa57XxVtnbTX7yGnNQ+vzKX/Gdne8dXZ0UV49qONohO4rK4rwFw8Rl1UJ7iZdVHWKl7S7nfmORihvCgEDssDfniQHLa1dZvw6BNqc6Aei2rOmyRPOsXdJfSllAJaYnUNQ6drY8SyVdPkURZyXiqusRmowcBkm1UINJIFypQlaPk8FcC/j4JF8SsG6VMpw
x-ms-office365-filtering-correlation-id: a6de4500-1d49-4a95-e78f-08d627364a35
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB082436C96F5798776B91AFAEFBEF0@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(256004)(99286004)(86612001)(22452003)(2906002)(25786009)(2900100001)(8936002)(14454004)(5250100002)(36756003)(10290500003)(76176011)(2501003)(478600001)(316002)(68736007)(8676002)(72206003)(305945005)(81156014)(6506007)(110136005)(54906003)(7736002)(10090500001)(81166006)(107886003)(66066001)(486006)(86362001)(6486002)(105586002)(11346002)(476003)(446003)(2616005)(53936002)(4326008)(1076002)(6512007)(217873002)(6116002)(3846002)(6436002)(97736004)(34290500001)(102836004)(6666003)(5660300001)(14444005)(26005)(71200400001)(71190400001)(186003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6nG0cEZJ9TGO3U9Ty3qkobrEkvNLQhV+GxZuJn6hkGhUGgoV3k0QRTz07psKF/C8pW7cx3nvG81E63SyNn1yIt4f4r9IjyGQlIlERQ73nBLicp44urcSabdG9zgEIFEh9o0OKu3OuEIir3xVkQbKj8h95SklKD5vPNFZj0Y6Eqm+gEoMv6G9yem6pXkZyaAm8YB2nAX6UTrJzVh/h+Cw2sG5yH0B8gbmdAxDmXp6dPVIWOrOgziN8YIhZ/5G68z6nqgdAL2/yJgT5E8SamRRTLGA+LqMKl388RdICL0M8YBSHq3m8jA9ycXGv/IDqA+qqwbr/mYFaU4SvYUx3E/8r+KM4f788wPVMiGC0WOIB0E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C4398F80C7DCD449B0B953295DBE3AE@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6de4500-1d49-4a95-e78f-08d627364a35
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:36.6566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KDQpbIFVw
c3RyZWFtIGNvbW1pdCAwMTY1ZGU5ODMyNzJkMWZhZTA4MDllZDlkYjQ3YzQ2YTQxMjI3OWJjIF0N
Cg0KU2xvd2x5IGxlYWtpbmcgbWVtb3J5IG9uZSBwYWdlIGF0IGEgdGltZSA6KQ0KDQpTaWduZWQt
b2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQpSZXZp
ZXdlZC1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+DQpT
aWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQpT
aWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+
DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyB8IDIzICsrKysr
KysrKysrKysrKy0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfY3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jDQppbmRl
eCA1YTE5NmVjNDliZTguLjY2ZTFiNjAwOTNmZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfY3MuYw0KQEAgLTM4LDYgKzM4LDcgQEAgc3RhdGljIGludCBhbWRncHVfY3NfdXNl
cl9mZW5jZV9jaHVuayhzdHJ1Y3QgYW1kZ3B1X2NzX3BhcnNlciAqcCwNCiB7DQogCXN0cnVjdCBk
cm1fZ2VtX29iamVjdCAqZ29iajsNCiAJdW5zaWduZWQgbG9uZyBzaXplOw0KKwlpbnQgcjsNCiAN
CiAJZ29iaiA9IGRybV9nZW1fb2JqZWN0X2xvb2t1cChwLT5maWxwLCBkYXRhLT5oYW5kbGUpOw0K
IAlpZiAoZ29iaiA9PSBOVUxMKQ0KQEAgLTQ5LDIwICs1MCwyNiBAQCBzdGF0aWMgaW50IGFtZGdw
dV9jc191c2VyX2ZlbmNlX2NodW5rKHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwLA0KIAlwLT51
Zl9lbnRyeS50di5zaGFyZWQgPSB0cnVlOw0KIAlwLT51Zl9lbnRyeS51c2VyX3BhZ2VzID0gTlVM
TDsNCiANCi0Jc2l6ZSA9IGFtZGdwdV9ib19zaXplKHAtPnVmX2VudHJ5LnJvYmopOw0KLQlpZiAo
c2l6ZSAhPSBQQUdFX1NJWkUgfHwgKGRhdGEtPm9mZnNldCArIDgpID4gc2l6ZSkNCi0JCXJldHVy
biAtRUlOVkFMOw0KLQ0KLQkqb2Zmc2V0ID0gZGF0YS0+b2Zmc2V0Ow0KLQ0KIAlkcm1fZ2VtX29i
amVjdF9wdXRfdW5sb2NrZWQoZ29iaik7DQogDQorCXNpemUgPSBhbWRncHVfYm9fc2l6ZShwLT51
Zl9lbnRyeS5yb2JqKTsNCisJaWYgKHNpemUgIT0gUEFHRV9TSVpFIHx8IChkYXRhLT5vZmZzZXQg
KyA4KSA+IHNpemUpIHsNCisJCXIgPSAtRUlOVkFMOw0KKwkJZ290byBlcnJvcl91bnJlZjsNCisJ
fQ0KKw0KIAlpZiAoYW1kZ3B1X3R0bV90dF9nZXRfdXNlcm1tKHAtPnVmX2VudHJ5LnJvYmotPnRi
by50dG0pKSB7DQotCQlhbWRncHVfYm9fdW5yZWYoJnAtPnVmX2VudHJ5LnJvYmopOw0KLQkJcmV0
dXJuIC1FSU5WQUw7DQorCQlyID0gLUVJTlZBTDsNCisJCWdvdG8gZXJyb3JfdW5yZWY7DQogCX0N
CiANCisJKm9mZnNldCA9IGRhdGEtPm9mZnNldDsNCisNCiAJcmV0dXJuIDA7DQorDQorZXJyb3Jf
dW5yZWY6DQorCWFtZGdwdV9ib191bnJlZigmcC0+dWZfZW50cnkucm9iaik7DQorCXJldHVybiBy
Ow0KIH0NCiANCiBzdGF0aWMgaW50IGFtZGdwdV9jc19wYXJzZXJfaW5pdChzdHJ1Y3QgYW1kZ3B1
X2NzX3BhcnNlciAqcCwgdm9pZCAqZGF0YSkNCi0tIA0KMi4xNy4xDQo=
