Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CD2C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D352064D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Se/F0hQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D352064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbeJAHPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:34 -0400
Received: from mail-by2nam01on0090.outbound.protection.outlook.com ([104.47.34.90]:27744
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729720AbeJAHPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JV9egLkDaucVSF8d6nRkqJlXgESxlFu+NZ1XOqczeY=;
 b=Se/F0hQ7t1AdmfCckFwCc/04PnmkVjRtnfdaKBWgUoxiSUOHX3792S4SYqtfYpniLbgxN0q/vvyDeTEEC3wzZA9al5NYGDvAS1ZfGVnO6dQCqQohtNDBfuawbDDUBezNCpg4FMK+0FRLBPzKFKyvzVlRAP990odIDB7japwSwCU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0854.namprd21.prod.outlook.com (10.173.192.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.4; Mon, 1 Oct 2018 00:40:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 30/37] drm/amdgpu: fix error handling in
 amdgpu_cs_user_fence_chunk
Thread-Topic: [PATCH AUTOSEL 4.14 30/37] drm/amdgpu: fix error handling in
 amdgpu_cs_user_fence_chunk
Thread-Index: AQHUWR8sqjIZ6ddtXke3mS72GbveUQ==
Date:   Mon, 1 Oct 2018 00:39:11 +0000
Message-ID: <20181001003850.147107-30-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0854;6:5Sq1ORKXK2NRcg05zvROGWcNunuAQVRpLkD412j8i4T5VHHLf0g1dAROJNOwNRCRDMqWlxa5ZDJlhsi/tEPRjred9KAHww/qxGIC0Fq1RpTTGUsJe+WxMurn6P/Xfidt2PFCnqqFOAOQWfR9rJ7a9DZQezSjtMbLKVGsAkPH0QxQFPRvTjXMRSoTz8c7oc7sLqoKTAwk8cTKVySyZHKOOGVqvx5jh+FLC4YWnGIqKyCDWpfCe9JMbFSx1yeeVqEThRxSnXI7o825U+YEVS4QP1ojMXsfbU/6P/8XndcDEpT1L6IYvb3cj7tS1XWjOBvqG9CwiQDr8wm3swrI4vhWIvlgZU92GHvlUvZVJ47kTiRFdQ0bR68E+Pve4ZNnuCTZhdZ9Cg2aVrMri0tNyyXCpoPdM5kqBvlu9Ru9palNSmYs5RhMIqtPV+mbLWzKNoG0FMdkYjDTadycUTYBkyxs1A==;5:F2z05paQNOr/OeQgZ4kd9sgP0FHhNGc/6TSX+tHyu1lOIx8skOaCefwX+ejlSuVpkG1/WW5RP7zh+OJEyabBTswReyMNatMLDA3NKrYD0Hdug860OVd8s0q1NKBZ1PMJL+2+qQYqsI9S83w0CGIntSavMYX0ZrxNLACZOx+f/gg=;7:4CSkiOR05caIH4jRFdLdGpT8tYXWcXqHPJtdrrrSl+KXF6hdDPWKEoxFa6jDygYVdMX5mg/jex51jGJmzFJB2dyTTV0ZVLQjfx/W16LjVo5P40cMsoH/kSrSmqtxQUHTd2vmad6gJ3K/C+wjyvpelEV+yjoqr5LlejJVXaCRkcpbLbMPYTEAhLrbbzhDvHOGoU1bCq5hKibFjdDGSvLd33+s7E48Ufvh2OrqCo4Jl1Thucn7I99deI0iUby3x5lI
x-ms-office365-filtering-correlation-id: c82482f2-12db-4559-f358-08d627367633
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0854;
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-microsoft-antispam-prvs: <CY4PR21MB08540A5B0DC14CB776857653FBEF0@CY4PR21MB0854.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0854;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0854;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(3846002)(217873002)(5250100002)(1076002)(71200400001)(97736004)(71190400001)(76176011)(6506007)(99286004)(36756003)(6346003)(26005)(2906002)(446003)(86362001)(11346002)(476003)(102836004)(2616005)(14454004)(2501003)(10090500001)(14444005)(107886003)(4326008)(22452003)(486006)(316002)(34290500001)(186003)(256004)(66066001)(86612001)(305945005)(25786009)(2900100001)(6486002)(106356001)(7736002)(6512007)(53936002)(81166006)(81156014)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(10290500003)(6436002)(478600001)(72206003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0854;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: vJ/S1bsCh3/0y6/Ngdvs7mTeUTF0D2M3Puecs/FyDeUVuCDPy0tl6AjbNtaWTlS2yiT6/ZDRKsOR7NKJBbZardzIodqyhjzjzzl1xsjUQlRoVuhDXuWehwSvCz0JV8ahSzJZd7qLWvvAUGypFZuMMuLpwGEHuMDZr2FBoQIqElhhZE3F8yhkcXLKo9YPmHWXWBYx+4LndwwlNm7+OHDN3X0VVuZJeZ7wzPrAoUPxZu5oClSXkMT/HFDE0UV5H/3Fig1WWUGKJ2fEuzUVAFFpRTTRW65pzZhgQ/hRpGssPuRd9WAi7HIq3DquD+mcsQTg1PkD76IHl5rT/gLi99/pDg2V7RVQsmdsO1Ofk7HK8GY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CA8383B4EE9D84EA93CA2F6DEF9DB78@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82482f2-12db-4559-f358-08d627367633
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:11.8047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
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
eCA1Zjg5MmFkNjQ3NmUuLjQ0YWE1OGFiNTVkMCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfY3MuYw0KQEAgLTM3LDYgKzM3LDcgQEAgc3RhdGljIGludCBhbWRncHVfY3NfdXNl
cl9mZW5jZV9jaHVuayhzdHJ1Y3QgYW1kZ3B1X2NzX3BhcnNlciAqcCwNCiB7DQogCXN0cnVjdCBk
cm1fZ2VtX29iamVjdCAqZ29iajsNCiAJdW5zaWduZWQgbG9uZyBzaXplOw0KKwlpbnQgcjsNCiAN
CiAJZ29iaiA9IGRybV9nZW1fb2JqZWN0X2xvb2t1cChwLT5maWxwLCBkYXRhLT5oYW5kbGUpOw0K
IAlpZiAoZ29iaiA9PSBOVUxMKQ0KQEAgLTQ4LDIwICs0OSwyNiBAQCBzdGF0aWMgaW50IGFtZGdw
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
