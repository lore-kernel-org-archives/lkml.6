Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0327EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34A0214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IPv12kVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfA2IIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:08:48 -0500
Received: from mail-eopbgr740042.outbound.protection.outlook.com ([40.107.74.42]:42592
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbfA2IIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07oqAg+gDKpknSznhBGguBprEpMiDrPpoFqJ40bP5n8=;
 b=IPv12kVMI57Onsm6r2EMdsjc5vOT2XhhlZSe78UMn7xV2XO6lBC4AFn9OIkmYkSGaZTchi8FkrfWHpZ3pfJ9b7XdEtPe38C+OTP/uQH+ajUx60ty3sk/eYbalinXovEcUNv5wiDOyJaio5qOE/wWLlKR7XQKPEwBwDD8Vln/r7o=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3610.namprd12.prod.outlook.com (20.178.199.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.20; Tue, 29 Jan 2019 08:08:43 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:08:43 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH]  svm: Fix AVIC DFR and LDR handling
Thread-Topic: [PATCH]  svm: Fix AVIC DFR and LDR handling
Thread-Index: AQHUt6nZSHpjO5TYpUuwav6+0LPYQA==
Date:   Tue, 29 Jan 2019 08:08:42 +0000
Message-ID: <20190129080813.40689-1-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.121.4.14]
x-clientproxiedby: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3610;20:WoQ+R6FLejrwnB0XyIK9ASRpOoNFVSxlyEGhUCbo1Ppu1TH+9GqGGCquvNkmrvymj4SPlcdWoDRZNiIqwNZ5LQot2uhlDyqajuij3Tsx9x2EAJgvqdNlB8ZrkyZGuRhQuBB3gt68o/VTiifsQM92gtONNtpeazW0Bx4EMSamCi9Wj1p+hbPEr9CM9pwDdSD610kvKJISzYtaxzjYtAB/RvolB2nBc83I6n43OC/ps88NOdzlz6ZkJVOk34DtOJQj
x-ms-office365-filtering-correlation-id: d5a41b97-b80a-44e1-3ff7-08d685c0fbc6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3610;
x-ms-traffictypediagnostic: DM6PR12MB3610:
x-microsoft-antispam-prvs: <DM6PR12MB36102DA298354DBE6A60E14CF3970@DM6PR12MB3610.namprd12.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39860400002)(199004)(189003)(305945005)(8676002)(81156014)(71200400001)(81166006)(71190400001)(50226002)(7736002)(6116002)(3846002)(256004)(14444005)(217873002)(8936002)(1076003)(66574012)(2906002)(54906003)(66066001)(52116002)(110136005)(316002)(68736007)(97736004)(386003)(6506007)(99286004)(7416002)(6512007)(102836004)(4326008)(26005)(486006)(476003)(2501003)(2616005)(6486002)(6436002)(186003)(105586002)(72206003)(36756003)(478600001)(53936002)(14454004)(2201001)(106356001)(25786009)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3610;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OjpCHd15mnAhmJSCPNBBSqg1aB+snGf4H4soHWi4omp1CdwA8XgWi9oEV5/XLwC2+i8w0lSZS81zsTOs2OBJNK2fQMKwaEn/3qlxYFC2UCYU9/C4S5mj2Abg6+L6qrbusBr62cZqpmNW68+uSln1Dk9knsWfIbchLYPY2XBY2f8Nt1f1+HWVw9jzYvuIVXHGxWD0H0lJiQhHB68UPc2v5B3Yfy4my1rQIwaaqNjhbdCxaVv9HcISz5d6wX0r51un67ajBX5zxviKIRmy9FlTeVXbCVl7Ha+gULaHDnSEces/V7cEQ+MdAcjzlwNR5rmNwsCwHZnSrkIrvRyLsW3+HnKKxkV8dxlI2juFN+HcPjb/76Kadd+b9EKmnGQYoaWUKQPzobZJqoXskmfqQNevjsof2gmEZP7qRd97gU+p6m0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <114CC33A045E884AA8CA38F04DFE5B3C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a41b97-b80a-44e1-3ff7-08d685c0fbc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:08:38.8247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q3VycmVudCBTVk0gQVZJQyBkcml2ZXIgbWFrZXMgdHdvIGluY29ycmVjdCBhc3N1bXB0aW9uczoN
CiAgMS4gQVBJQyBMRFIgcmVnaXN0ZXIgY2Fubm90IGJlIHplcm8NCiAgMi4gQVBJQyBERlIgZm9y
IGFsbCB2Q1BVcyBtdXN0IGJlIHRoZSBzYW1lDQoNCkxEUj0wIG1lYW5zIHRoZSBsb2NhbCBBUElD
IGRvZXMgbm90IHN1cHBvcnQgbG9naWNhbCBkZXN0aW5hdGlvbiBtb2RlLg0KVGhlcmVmb3JlLCB0
aGUgZHJpdmVyIHNob3VsZCBtYXJrIGFueSBwcmV2aW91c2x5IGFzc2lnbmVkIGxvZ2ljYWwgQVBJ
QyBJRA0KdGFibGUgZW50cnkgYXMgaW52YWxpZCwgYW5kIHJldHVybiBzdWNjZXNzLiAgQWxzbywg
REZSIGlzIHNwZWNpZmljIHRvDQphIHBhcnRpY3VsYXIgbG9jYWwgQVBJQywgYW5kIGNhbiBiZSBk
aWZmZXJlbnQgYW1vbmcgYWxsIHZDUFVzDQooYXMgb2JzZXJ2ZWQgb24gV2luZG93cyAxMCkuDQoN
ClRoZXNlIGluY29ycmVjdCBhc3N1bXB0aW9ucyBjYXVzZSBXaW5kb3dzIDEwIGFuZCBGcmVlQlNE
IFZNcyB0byBmYWlsDQp0byBib290IHdpdGggQVZJQyBlbmFibGVkLiBTbywgaW5zdGVhZCBvZiBm
bHVzaCB0aGUgd2hvbGUgbG9naWNhbCBBUElDIElEDQp0YWJsZSwgaGFuZGxlIERGUiBhbmQgTERS
IGZvciBlYWNoIHZDUFUgaW5kZXBlbmRlbnRseS4NCg0KRml4ZXM6IDE4ZjQwYzUzZTEwZiAoJ3N2
bTogQWRkIFZNRVhJVCBoYW5kbGVycyBmb3IgQVZJQycpDQpDYzogUmFkaW0gS3LEjW3DocWZIDxy
a3JjbWFyQHJlZGhhdC5jb20+DQpDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNv
bT4NClJlcG9ydGVkLWJ5OiBKdWxpYW4gU3RlY2tsaW5hIDxqc3RlY2tsaUBhbWF6b24uZGU+DQpT
aWduZWQtb2ZmLWJ5OiBTdXJhdmVlIFN1dGhpa3VscGFuaXQgPHN1cmF2ZWUuc3V0aGlrdWxwYW5p
dEBhbWQuY29tPg0KLS0tDQogYXJjaC94ODYva3ZtL3N2bS5jIHwgNjQgKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNl
cnRpb25zKCspLCAzNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9z
dm0uYyBiL2FyY2gveDg2L2t2bS9zdm0uYw0KaW5kZXggOGEwYzlhMWY2YWM4Li5kMzVjOTAwMmYy
ODIgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtLmMNCisrKyBiL2FyY2gveDg2L2t2bS9z
dm0uYw0KQEAgLTE0NSw3ICsxNDUsNiBAQCBzdHJ1Y3Qga3ZtX3N2bSB7DQogDQogCS8qIFN0cnVj
dCBtZW1iZXJzIGZvciBBVklDICovDQogCXUzMiBhdmljX3ZtX2lkOw0KLQl1MzIgbGRyX21vZGU7
DQogCXN0cnVjdCBwYWdlICphdmljX2xvZ2ljYWxfaWRfdGFibGVfcGFnZTsNCiAJc3RydWN0IHBh
Z2UgKmF2aWNfcGh5c2ljYWxfaWRfdGFibGVfcGFnZTsNCiAJc3RydWN0IGhsaXN0X25vZGUgaG5v
ZGU7DQpAQCAtMjM2LDYgKzIzNSw3IEBAIHN0cnVjdCB2Y3B1X3N2bSB7DQogCWJvb2wgbnJpcHNf
ZW5hYmxlZAk6IDE7DQogDQogCXUzMiBsZHJfcmVnOw0KKwl1MzIgZGZyX3JlZzsNCiAJc3RydWN0
IHBhZ2UgKmF2aWNfYmFja2luZ19wYWdlOw0KIAl1NjQgKmF2aWNfcGh5c2ljYWxfaWRfY2FjaGU7
DQogCWJvb2wgYXZpY19pc19ydW5uaW5nOw0KQEAgLTIxMDYsNiArMjEwNiw3IEBAIHN0YXRpYyBp
bnQgYXZpY19pbml0X3ZjcHUoc3RydWN0IHZjcHVfc3ZtICpzdm0pDQogDQogCUlOSVRfTElTVF9I
RUFEKCZzdm0tPmlyX2xpc3QpOw0KIAlzcGluX2xvY2tfaW5pdCgmc3ZtLT5pcl9saXN0X2xvY2sp
Ow0KKwlzdm0tPmRmcl9yZWcgPSBBUElDX0RGUl9GTEFUOw0KIA0KIAlyZXR1cm4gcmV0Ow0KIH0N
CkBAIC00NTU3LDggKzQ1NTgsNyBAQCBzdGF0aWMgdTMyICphdmljX2dldF9sb2dpY2FsX2lkX2Vu
dHJ5KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdTMyIGxkciwgYm9vbCBmbGF0KQ0KIAlyZXR1cm4g
JmxvZ2ljYWxfYXBpY19pZF90YWJsZVtpbmRleF07DQogfQ0KIA0KLXN0YXRpYyBpbnQgYXZpY19s
ZHJfd3JpdGUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1OCBnX3BoeXNpY2FsX2lkLCB1MzIgbGRy
LA0KLQkJCSAgYm9vbCB2YWxpZCkNCitzdGF0aWMgaW50IGF2aWNfbGRyX3dyaXRlKHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSwgdTggZ19waHlzaWNhbF9pZCwgdTMyIGxkcikNCiB7DQogCWJvb2wgZmxh
dDsNCiAJdTMyICplbnRyeSwgbmV3X2VudHJ5Ow0KQEAgLTQ1NzEsMzEgKzQ1NzEsMzkgQEAgc3Rh
dGljIGludCBhdmljX2xkcl93cml0ZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHU4IGdfcGh5c2lj
YWxfaWQsIHUzMiBsZHIsDQogCW5ld19lbnRyeSA9IFJFQURfT05DRSgqZW50cnkpOw0KIAluZXdf
ZW50cnkgJj0gfkFWSUNfTE9HSUNBTF9JRF9FTlRSWV9HVUVTVF9QSFlTSUNBTF9JRF9NQVNLOw0K
IAluZXdfZW50cnkgfD0gKGdfcGh5c2ljYWxfaWQgJiBBVklDX0xPR0lDQUxfSURfRU5UUllfR1VF
U1RfUEhZU0lDQUxfSURfTUFTSyk7DQotCWlmICh2YWxpZCkNCi0JCW5ld19lbnRyeSB8PSBBVklD
X0xPR0lDQUxfSURfRU5UUllfVkFMSURfTUFTSzsNCi0JZWxzZQ0KLQkJbmV3X2VudHJ5ICY9IH5B
VklDX0xPR0lDQUxfSURfRU5UUllfVkFMSURfTUFTSzsNCisJbmV3X2VudHJ5IHw9IEFWSUNfTE9H
SUNBTF9JRF9FTlRSWV9WQUxJRF9NQVNLOw0KIAlXUklURV9PTkNFKCplbnRyeSwgbmV3X2VudHJ5
KTsNCiANCiAJcmV0dXJuIDA7DQogfQ0KIA0KK3N0YXRpYyB2b2lkIGF2aWNfaW52X2xvZ2ljYWxf
aWRfZW50cnkoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KK3sNCisJc3RydWN0IHZjcHVfc3ZtICpz
dm0gPSB0b19zdm0odmNwdSk7DQorCWJvb2wgZmxhdCA9IHN2bS0+ZGZyX3JlZyA9PSBBUElDX0RG
Ul9GTEFUOw0KKwl1MzIgKmVudHJ5ID0gYXZpY19nZXRfbG9naWNhbF9pZF9lbnRyeSh2Y3B1LCBz
dm0tPmxkcl9yZWcsIGZsYXQpOw0KKw0KKwlpZiAoZW50cnkpDQorCQlXUklURV9PTkNFKCplbnRy
eSwgKHUzMikgfkFWSUNfTE9HSUNBTF9JRF9FTlRSWV9WQUxJRF9NQVNLKTsNCit9DQorDQogc3Rh
dGljIGludCBhdmljX2hhbmRsZV9sZHJfdXBkYXRlKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCiB7
DQotCWludCByZXQ7DQorCWludCByZXQgPSAwOw0KIAlzdHJ1Y3QgdmNwdV9zdm0gKnN2bSA9IHRv
X3N2bSh2Y3B1KTsNCiAJdTMyIGxkciA9IGt2bV9sYXBpY19nZXRfcmVnKHZjcHUtPmFyY2guYXBp
YywgQVBJQ19MRFIpOw0KIA0KLQlpZiAoIWxkcikNCi0JCXJldHVybiAxOw0KKwlpZiAobGRyID09
IHN2bS0+bGRyX3JlZykNCisJCXJldHVybiAwOw0KIA0KLQlyZXQgPSBhdmljX2xkcl93cml0ZSh2
Y3B1LCB2Y3B1LT52Y3B1X2lkLCBsZHIsIHRydWUpOw0KLQlpZiAocmV0ICYmIHN2bS0+bGRyX3Jl
Zykgew0KLQkJYXZpY19sZHJfd3JpdGUodmNwdSwgMCwgc3ZtLT5sZHJfcmVnLCBmYWxzZSk7DQot
CQlzdm0tPmxkcl9yZWcgPSAwOw0KLQl9IGVsc2Ugew0KKwlhdmljX2ludl9sb2dpY2FsX2lkX2Vu
dHJ5KHZjcHUpOw0KKw0KKwlpZiAobGRyKQ0KKwkJcmV0ID0gYXZpY19sZHJfd3JpdGUodmNwdSwg
dmNwdS0+dmNwdV9pZCwgbGRyKTsNCisNCisJaWYgKCFyZXQpDQogCQlzdm0tPmxkcl9yZWcgPSBs
ZHI7DQotCX0NCisNCiAJcmV0dXJuIHJldDsNCiB9DQogDQpAQCAtNDYyOSwyNyArNDYzNywxNiBA
QCBzdGF0aWMgaW50IGF2aWNfaGFuZGxlX2FwaWNfaWRfdXBkYXRlKHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSkNCiAJcmV0dXJuIDA7DQogfQ0KIA0KLXN0YXRpYyBpbnQgYXZpY19oYW5kbGVfZGZyX3Vw
ZGF0ZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQorc3RhdGljIHZvaWQgYXZpY19oYW5kbGVfZGZy
X3VwZGF0ZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQogew0KIAlzdHJ1Y3QgdmNwdV9zdm0gKnN2
bSA9IHRvX3N2bSh2Y3B1KTsNCi0Jc3RydWN0IGt2bV9zdm0gKmt2bV9zdm0gPSB0b19rdm1fc3Zt
KHZjcHUtPmt2bSk7DQogCXUzMiBkZnIgPSBrdm1fbGFwaWNfZ2V0X3JlZyh2Y3B1LT5hcmNoLmFw
aWMsIEFQSUNfREZSKTsNCi0JdTMyIG1vZCA9IChkZnIgPj4gMjgpICYgMHhmOw0KLQ0KLQkvKg0K
LQkgKiBXZSBhc3N1bWUgdGhhdCBhbGwgbG9jYWwgQVBJQ3MgYXJlIHVzaW5nIHRoZSBzYW1lIHR5
cGUuDQotCSAqIElmIHRoaXMgY2hhbmdlcywgd2UgbmVlZCB0byBmbHVzaCB0aGUgQVZJQyBsb2dp
Y2FsDQotCSAqIEFQSUQgaWQgdGFibGUuDQotCSAqLw0KLQlpZiAoa3ZtX3N2bS0+bGRyX21vZGUg
PT0gbW9kKQ0KLQkJcmV0dXJuIDA7DQogDQotCWNsZWFyX3BhZ2UocGFnZV9hZGRyZXNzKGt2bV9z
dm0tPmF2aWNfbG9naWNhbF9pZF90YWJsZV9wYWdlKSk7DQotCWt2bV9zdm0tPmxkcl9tb2RlID0g
bW9kOw0KKwlpZiAoc3ZtLT5kZnJfcmVnID09IGRmcikNCisJCXJldHVybjsNCiANCi0JaWYgKHN2
bS0+bGRyX3JlZykNCi0JCWF2aWNfaGFuZGxlX2xkcl91cGRhdGUodmNwdSk7DQotCXJldHVybiAw
Ow0KKwlhdmljX2ludl9sb2dpY2FsX2lkX2VudHJ5KHZjcHUpOw0KKwlzdm0tPmRmcl9yZWcgPSBk
ZnI7DQogfQ0KIA0KIHN0YXRpYyBpbnQgYXZpY191bmFjY2VsX3RyYXBfd3JpdGUoc3RydWN0IHZj
cHVfc3ZtICpzdm0pDQpAQCAtNjE1NSw4ICs2MTUyLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGF2
aWNfcG9zdF9zdGF0ZV9yZXN0b3JlKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCiB7DQogCWlmIChh
dmljX2hhbmRsZV9hcGljX2lkX3VwZGF0ZSh2Y3B1KSAhPSAwKQ0KIAkJcmV0dXJuOw0KLQlpZiAo
YXZpY19oYW5kbGVfZGZyX3VwZGF0ZSh2Y3B1KSAhPSAwKQ0KLQkJcmV0dXJuOw0KKwlhdmljX2hh
bmRsZV9kZnJfdXBkYXRlKHZjcHUpOw0KIAlhdmljX2hhbmRsZV9sZHJfdXBkYXRlKHZjcHUpOw0K
IH0NCiANCi0tIA0KMi4xNy4xDQoNCg==
