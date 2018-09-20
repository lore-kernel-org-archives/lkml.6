Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A84ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151E821521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="guzikolQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151E821521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388758AbeITIfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:35:32 -0400
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:36192
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388261AbeITIaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEcaPNVSQ+/RrtlRFSQmfzNeRHQoo8rri1W6yefBC/c=;
 b=guzikolQaD4upl1PltLhhpiwQ3DDGQotIJwfINpP77nyjJsbhWBlLY5rBSJIQ46El52TD/3BjWu8O56nqVmYU5Qe5a+Ag1MPfVQVsrH0qrtPOx1wr4SA0lQl7hHviqbC27S8KoLGOt+YSqHboEXlpT2CyAgpENM9ntvLspoO3BA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:49:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Rex Zhu <Rex.Zhu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 18/25] drm/amdgpu: Update power state at the end
 of smu hw_init.
Thread-Topic: [PATCH AUTOSEL 4.14 18/25] drm/amdgpu: Update power state at the
 end of smu hw_init.
Thread-Index: AQHUUIxoJ+9C1/T99UC9E9oRxHW9kA==
Date:   Thu, 20 Sep 2018 02:48:28 +0000
Message-ID: <20180920024810.58594-18-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:5q0nHw+67QJFh2YKmDAl96z8+xj9Ckuoon20pONxhT7gxUyny9yqJaHZuhAPSj0vrVSgmz9wWTlVRtxiup3xCLoUtgWzuQR4Y4b5KEer5Unc1zLqiJ72r6D32Mxflikj4NzF+DT4/fLmfDHfMAnl0Fq5VFnE3Wjo7xQcH1X7v/YIyYzotL9QuWnTS7gJ28S1T5K7zbGWhwRNOnhECbdu8rxKHlc1ujSAUWxnJ+aZ2d6GnpSQc+2e0mmCcGC1cBzae+UjTfdv7O+hNhT9K1PYULNrMTVns0le7oI9sGWi/VVXxdWCKaHlpV9cIU6NKsm//v1B1TNbdLY3jJZsY/uTm+B5sAGkI/NL9c3Pccfc/kTK79pzsYEgmK5TkXfKFaBLB+05y2AUQUaJOWeev5uweF3TY/xvPy+/2MmjBwTxvAJ0NjcMn/aO1F9yk/3HpkgzVHVz8iXnZAskyKn5TXlZrw==;5:ufWnytHxjWSbLqtzaROmABkpXZymeqKBecbidHyLW03xJY7cJ9v8UtifA25iJCx/moTxPmi9SS+GorFcWayFi3viETjE1SW/M8KTdq03KPinP1Swy1psispSbAxvuK3ybiidzdAnoxuV82H+PgH94IQJgccuCt9AgfwT+9g8bnk=;7:d+ltpujjza8rHZGxS2wpK1qt3I/Pb+DZBLE7Y4glHVEpYcc+Dpo2SB1G7zSIR2N6W3ZguouJbmbJ6ExwsuunOd5FywHRW6vIaf5h5tX4NO1JpvTnLLzwtvFBggoYDbJaD3PsBsHTS6PV+Slbyr1q7K6OCkSgaHJo2qWt7ins8NbwVlJaMJ1qvYnlbSjzE4SBwoIM8Azgc5V1+oEi415ZAuPBWQMi87/AoHsWUCvDASHXh6uwNN5qo2BDKeWvHxDm
x-ms-office365-filtering-correlation-id: ec9c5799-e43b-4ad2-d0f7-08d61ea3a813
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0744771FC76B6F166AD9EFD8FB130@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(15650500001)(6436002)(10090500001)(110136005)(217873002)(54906003)(6512007)(53936002)(68736007)(5660300001)(14444005)(256004)(6666003)(71190400001)(6486002)(316002)(446003)(11346002)(105586002)(476003)(106356001)(478600001)(2616005)(2906002)(186003)(25786009)(10290500003)(486006)(71200400001)(72206003)(66066001)(4326008)(14454004)(22452003)(36756003)(102836004)(86612001)(97736004)(8676002)(305945005)(7736002)(1076002)(86362001)(575784001)(81156014)(26005)(76176011)(6506007)(5250100002)(107886003)(2900100001)(99286004)(3846002)(2501003)(81166006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JArcUW6p1XJfCF/wZai9gkmc5gktDgcK9t5qgrgNPwM09rm2hCWMV2j3jnqQr/r/90DEUsdvvO6lTG0aHVADFSAJ9QSukUb1AMjdJz4qppWdQyWhEul3RO67KrRctlMKfZeuZODSKmwc2wvg396uZUhCiRXyPIavoVBbQ/YpjmmeJp7c+nm9Gyf8TzXBaaHlTyKvdGqZ8vWtZExXOF7eojqmjFQWR0DOpWXzg6h/R6gZjjUHMi9h2cHHdvraa2zroySjWuUD58/d4BHLHFAdFJgMxSBKpK2JpkJeLck7Wm1EnX75P2tdfj+LAGs36S9GGdjytfMK1gXhp01GAnJ7t5VkgP90qJJ/Ey100Q9QqlY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <77F3DDD819C7EF4794FE3481B86227A7@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9c5799-e43b-4ad2-d0f7-08d61ea3a813
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:28.2726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPg0KDQpbIFVwc3RyZWFtIGNvbW1pdCAyYWI0
ZDBlNzQyNTZmYzQ5YjdiMjcwZjYzYzFkMWU0N2MyNDU1YWJjIF0NCg0KRm9yIFNJL0t2LCB0aGUg
cG93ZXIgc3RhdGUgaXMgbWFuYWdlZCBieSBmdW5jdGlvbg0KYW1kZ3B1X3BtX2NvbXB1dGVfY2xv
Y2tzLg0KDQp3aGVuIGRwbSBlbmFibGVkLCB3ZSBzaG91bGQgY2FsbCBhbWRncHVfcG1fY29tcHV0
ZV9jbG9ja3MNCnRvIHVwZGF0ZSBjdXJyZW50IHBvd2VyIHN0YXRlIGluc3RhbmQgb2Ygc2V0IGJv
b3Qgc3RhdGUuDQoNCnRoaXMgY2hhbmdlIGNhbiBmaXggdGhlIG9vcHMgd2hlbiBrZmQgZHJpdmVy
IHdhcyBlbmFibGVkIG9uIEt2Lg0KDQpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPg0KVGVzdGVkLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRh
ZW56ZXJAYW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6IFJleCBaaHUgPFJleC5aaHVAYW1kLmNvbT4N
ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4N
ClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNv
bT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2t2X2RwbS5jIHwgNCArLS0tDQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMgfCAzICstLQ0KIDIgZmlsZXMgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUva3ZfZHBtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9rdl9kcG0uYw0KaW5kZXggM2JiZjJjY2ZjYTg5Li5jNzYwNzNiNDIyZDYgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9rdl9kcG0uYw0KKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUva3ZfZHBtLmMNCkBAIC0xMzUyLDggKzEzNTIsNiBAQCBzdGF0aWMg
aW50IGt2X2RwbV9lbmFibGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogCQlyZXR1cm4g
cmV0Ow0KIAl9DQogDQotCWt2X3VwZGF0ZV9jdXJyZW50X3BzKGFkZXYsIGFkZXYtPnBtLmRwbS5i
b290X3BzKTsNCi0NCiAJaWYgKGFkZXYtPmlycS5pbnN0YWxsZWQgJiYNCiAJICAgIGFtZGdwdV9p
c19pbnRlcm5hbF90aGVybWFsX3NlbnNvcihhZGV2LT5wbS5pbnRfdGhlcm1hbF90eXBlKSkgew0K
IAkJcmV0ID0ga3Zfc2V0X3RoZXJtYWxfdGVtcGVyYXR1cmVfcmFuZ2UoYWRldiwgS1ZfVEVNUF9S
QU5HRV9NSU4sIEtWX1RFTVBfUkFOR0VfTUFYKTsNCkBAIC0zMDU0LDcgKzMwNTIsNyBAQCBzdGF0
aWMgaW50IGt2X2RwbV9od19pbml0KHZvaWQgKmhhbmRsZSkNCiAJZWxzZQ0KIAkJYWRldi0+cG0u
ZHBtX2VuYWJsZWQgPSB0cnVlOw0KIAltdXRleF91bmxvY2soJmFkZXYtPnBtLm11dGV4KTsNCi0N
CisJYW1kZ3B1X3BtX2NvbXB1dGVfY2xvY2tzKGFkZXYpOw0KIAlyZXR1cm4gcmV0Ow0KIH0NCiAN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jDQppbmRleCA2ZjFkZWExNTdhNzcuLjU1NjEz
ZjQyNTkzMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5j
DQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYw0KQEAgLTY4ODQsNyAr
Njg4NCw2IEBAIHN0YXRpYyBpbnQgc2lfZHBtX2VuYWJsZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikNCiANCiAJc2lfZW5hYmxlX2F1dG9fdGhyb3R0bGVfc291cmNlKGFkZXYsIEFNREdQVV9E
UE1fQVVUT19USFJPVFRMRV9TUkNfVEhFUk1BTCwgdHJ1ZSk7DQogCXNpX3RoZXJtYWxfc3RhcnRf
dGhlcm1hbF9jb250cm9sbGVyKGFkZXYpOw0KLQluaV91cGRhdGVfY3VycmVudF9wcyhhZGV2LCBi
b290X3BzKTsNCiANCiAJcmV0dXJuIDA7DQogfQ0KQEAgLTc3NTgsNyArNzc1Nyw3IEBAIHN0YXRp
YyBpbnQgc2lfZHBtX2h3X2luaXQodm9pZCAqaGFuZGxlKQ0KIAllbHNlDQogCQlhZGV2LT5wbS5k
cG1fZW5hYmxlZCA9IHRydWU7DQogCW11dGV4X3VubG9jaygmYWRldi0+cG0ubXV0ZXgpOw0KLQ0K
KwlhbWRncHVfcG1fY29tcHV0ZV9jbG9ja3MoYWRldik7DQogCXJldHVybiByZXQ7DQogfQ0KIA0K
LS0gDQoyLjE3LjENCg==
