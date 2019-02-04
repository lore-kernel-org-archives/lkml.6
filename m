Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E58C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853D02082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CJN5DXbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbfBDOmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:42:22 -0500
Received: from mail-eopbgr730048.outbound.protection.outlook.com ([40.107.73.48]:44640
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730351AbfBDOmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/mEMkIMUzSuAncXeOsajO6PHRRXHlsGy9/0QH0Rpzc=;
 b=CJN5DXbrB8LzSGKXHqrDqJNfnLxAPbXkaM3y89TPcwzo41Gfl2mIRWXEiymGU3dane2smRTCh6a7zTpbbrFFrSxofLslk5h5HrF07L7eqJ0qyvP8T3UFqc5wJA6cwg9uZL7SWWX35vRtowH4YPMnuKkSOpmKm/qgiZCE3/6SFso=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3274.namprd12.prod.outlook.com (20.179.106.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 14:42:18 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1558.026; Mon, 4 Feb 2019
 14:42:18 +0000
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
        "jsteckli@amazon.de" <jsteckli@amazon.de>,
        "sironi@amazon.de" <sironi@amazon.de>,
        "wawei@amazon.de" <wawei@amazon.de>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [RFC PATCH 5/8] svm: Add support for APIC_ACCESS_PAGE_PRIVATE_MEMSLOT
 setup/destroy
Thread-Topic: [RFC PATCH 5/8] svm: Add support for
 APIC_ACCESS_PAGE_PRIVATE_MEMSLOT setup/destroy
Thread-Index: AQHUvJfTbslfMQjezUease4SwgfLDQ==
Date:   Mon, 4 Feb 2019 14:42:17 +0000
Message-ID: <20190204144128.9489-6-suravee.suthikulpanit@amd.com>
References: <20190204144128.9489-1-suravee.suthikulpanit@amd.com>
In-Reply-To: <20190204144128.9489-1-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [61.90.26.242]
x-clientproxiedby: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3274;20:YOzzGf7seV8LYEqUr3NQ+3MGk670VV1cBs/tBhAzK1MW0r3EegGBYMhkEKL94PgwmROM4lpdr5i5hv1vBBXaGOnpIeW+CNRaDHZW75FG0fnlF7H6ZbWtKPCO7b/L+9jOIxaMkzxI1JZVpMspHHkU66krpB0Ui/pxvMcFwm64lQrKgmqSJ++hG/7XU2ImsFV6Dexl1CpCkx+lagJnux5xMFb69tEWSeNFVBw3NxhG4svTaptpb9JA9KnK92vt8TFy
x-ms-office365-filtering-correlation-id: 3777f836-3b33-4280-d25e-08d68aaef611
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3274;
x-ms-traffictypediagnostic: DM6PR12MB3274:
x-microsoft-antispam-prvs: <DM6PR12MB3274922E14CDE42DFBA92225F36D0@DM6PR12MB3274.namprd12.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(6116002)(3846002)(105586002)(81166006)(81156014)(6436002)(52116002)(186003)(256004)(14444005)(217873002)(106356001)(2501003)(8936002)(8676002)(316002)(110136005)(4326008)(99286004)(2201001)(86362001)(72206003)(14454004)(386003)(25786009)(7736002)(305945005)(478600001)(6486002)(54906003)(53936002)(6512007)(50226002)(71190400001)(486006)(66574012)(1076003)(6506007)(97736004)(102836004)(476003)(68736007)(2616005)(11346002)(2906002)(446003)(7416002)(26005)(76176011)(71200400001)(66066001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3274;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VDhNuyANdAMZdwEASnXswLuF8/u9DQ/sPhumsaK9dC7y0kCGPZYgGiuFdx9G12s9YUEHN+imcnznxb7wpdcvVpHnmffgkWQC9t2Vs2e/FLDVuxz2W7853Bfq4rvqIJKPWrdM+5DOtBwYdFGo7VigKUECQhXquxgAJGqiC/OkBIh6rOCmmWZQdmkLl3GyQudF2orssyXyrn4/jtLypsA5N0PX1E0J6Tt0P0m5ui2cVZyGa4EL6LTdME7v3H8Jib9iF579yEh3TdJALMShlg3qCYnAuquEjrxxi+4rPx+l7BJuoo0+k9Rp7v8OJFZ5l/bEGn4nIhu2I9/ckc+eHne1enh2fLAMFcAueGMyh8ShYamsYO2NPe6l4Qd3cf4znPZ05ptm/d2ozGgtEq556MIC5k43aCN8+3ag+TZMQH8kEtA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD6BFBF3EF0DF943835D96498FB7052B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3777f836-3b33-4280-d25e-08d68aaef611
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 14:42:13.5690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWN0aXZhdGUvZGVhY3RpdmF0ZSBBVklDIHJlcXVpcmVzIHNldHRpbmcvdW5zZXR0aW5nIHRoZSBt
ZW1vcnkgcmVnaW9uIHVzZWQNCmZvciBBUElDX0FDQ0VTU19QQUdFX1BSSVZBVEVfTUVNU0xPVC4g
U28sIHJlLWZhY3RvciBhdmljX2luaXRfYWNjZXNzX3BhZ2UoKQ0KdG8gYXZpY19zZXR1cF9hY2Nl
c3NfcGFnZSgpIGFuZCBhZGQgc3JjdV9yZWFkX2xvY2svdW5sb2NrLCB3aGljaCBhcmUgbmVlZGVk
DQp0byBhbGxvdyB0aGlzIGZ1bmN0aW9uIHRvIGJlIGNhbGxlZCBkdXJpbmcgcnVuLXRpbWUuDQoN
CkFsc28sIGludHJvZHVjZSBhdmljX2Rlc3Ryb3lfYWNjZXNzX3BhZ2UoKSB0byB1bnNldCB0aGUg
cGFnZSB3aGVuDQpkZWFjdGl2YXRlIEFWSUMuDQoNCkNjOiBQYW9sbyBCb256aW5pIDxwYm9uemlu
aUByZWRoYXQuY29tPg0KQ2M6IFJhZGltIEtyxI1tw6HFmSA8cmtyY21hckByZWRoYXQuY29tPg0K
U2lnbmVkLW9mZi1ieTogU3VyYXZlZSBTdXRoaWt1bHBhbml0IDxzdXJhdmVlLnN1dGhpa3VscGFu
aXRAYW1kLmNvbT4NCi0tLQ0KIGFyY2gveDg2L2t2bS9zdm0uYyB8IDI4ICsrKysrKysrKysrKysr
KysrKysrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9zdm0uYyBiL2FyY2gveDg2L2t2
bS9zdm0uYw0KaW5kZXggYzMzZjAyYjRhMTllLi5hMjNiMWU3N2FjYjYgMTAwNjQ0DQotLS0gYS9h
cmNoL3g4Ni9rdm0vc3ZtLmMNCisrKyBiL2FyY2gveDg2L2t2bS9zdm0uYw0KQEAgLTE2NTgsNyAr
MTY1OCw3IEBAIHN0YXRpYyB1NjQgKmF2aWNfZ2V0X3BoeXNpY2FsX2lkX2VudHJ5KHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSwNCiAgKiBmaWVsZCBvZiB0aGUgVk1DQi4gVGhlcmVmb3JlLCB3ZSBzZXQg
dXAgdGhlDQogICogQVBJQ19BQ0NFU1NfUEFHRV9QUklWQVRFX01FTVNMT1QgKDRLQikgaGVyZS4N
CiAgKi8NCi1zdGF0aWMgaW50IGF2aWNfaW5pdF9hY2Nlc3NfcGFnZShzdHJ1Y3Qga3ZtX3ZjcHUg
KnZjcHUpDQorc3RhdGljIGludCBhdmljX3NldHVwX2FjY2Vzc19wYWdlKHN0cnVjdCBrdm1fdmNw
dSAqdmNwdSwgYm9vbCBpbml0KQ0KIHsNCiAJc3RydWN0IGt2bSAqa3ZtID0gdmNwdS0+a3ZtOw0K
IAlpbnQgcmV0ID0gMDsNCkBAIC0xNjY3LDEwICsxNjY3LDE0IEBAIHN0YXRpYyBpbnQgYXZpY19p
bml0X2FjY2Vzc19wYWdlKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCiAJaWYgKGt2bS0+YXJjaC5h
cGljX2FjY2Vzc19wYWdlX2RvbmUpDQogCQlnb3RvIG91dDsNCiANCisJaWYgKCFpbml0KQ0KKwkJ
c3JjdV9yZWFkX3VubG9jaygma3ZtLT5zcmN1LCB2Y3B1LT5zcmN1X2lkeCk7DQogCXJldCA9IF9f
eDg2X3NldF9tZW1vcnlfcmVnaW9uKGt2bSwNCiAJCQkJICAgICAgQVBJQ19BQ0NFU1NfUEFHRV9Q
UklWQVRFX01FTVNMT1QsDQogCQkJCSAgICAgIEFQSUNfREVGQVVMVF9QSFlTX0JBU0UsDQogCQkJ
CSAgICAgIFBBR0VfU0laRSk7DQorCWlmICghaW5pdCkNCisJCXZjcHUtPnNyY3VfaWR4ID0gc3Jj
dV9yZWFkX2xvY2soJmt2bS0+c3JjdSk7DQogCWlmIChyZXQpDQogCQlnb3RvIG91dDsNCiANCkBA
IC0xNjgwLDYgKzE2ODQsMjYgQEAgc3RhdGljIGludCBhdmljX2luaXRfYWNjZXNzX3BhZ2Uoc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1KQ0KIAlyZXR1cm4gcmV0Ow0KIH0NCiANCitzdGF0aWMgdm9pZCBh
dmljX2Rlc3Ryb3lfYWNjZXNzX3BhZ2Uoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KK3sNCisJc3Ry
dWN0IGt2bSAqa3ZtID0gdmNwdS0+a3ZtOw0KKw0KKwltdXRleF9sb2NrKCZrdm0tPnNsb3RzX2xv
Y2spOw0KKw0KKwlpZiAoIWt2bS0+YXJjaC5hcGljX2FjY2Vzc19wYWdlX2RvbmUpDQorCQlnb3Rv
IG91dDsNCisNCisJc3JjdV9yZWFkX3VubG9jaygma3ZtLT5zcmN1LCB2Y3B1LT5zcmN1X2lkeCk7
DQorCV9feDg2X3NldF9tZW1vcnlfcmVnaW9uKGt2bSwNCisJCQkJQVBJQ19BQ0NFU1NfUEFHRV9Q
UklWQVRFX01FTVNMT1QsDQorCQkJCUFQSUNfREVGQVVMVF9QSFlTX0JBU0UsDQorCQkJCTApOw0K
Kwl2Y3B1LT5zcmN1X2lkeCA9IHNyY3VfcmVhZF9sb2NrKCZrdm0tPnNyY3UpOw0KKwlrdm0tPmFy
Y2guYXBpY19hY2Nlc3NfcGFnZV9kb25lID0gZmFsc2U7DQorb3V0Og0KKwltdXRleF91bmxvY2so
Jmt2bS0+c2xvdHNfbG9jayk7DQorfQ0KKw0KIHN0YXRpYyBpbnQgYXZpY19pbml0X2JhY2tpbmdf
cGFnZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQogew0KIAlpbnQgcmV0Ow0KQEAgLTE2ODcsNyAr
MTcxMSw3IEBAIHN0YXRpYyBpbnQgYXZpY19pbml0X2JhY2tpbmdfcGFnZShzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUpDQogCWludCBpZCA9IHZjcHUtPnZjcHVfaWQ7DQogCXN0cnVjdCB2Y3B1X3N2bSAq
c3ZtID0gdG9fc3ZtKHZjcHUpOw0KIA0KLQlyZXQgPSBhdmljX2luaXRfYWNjZXNzX3BhZ2UodmNw
dSk7DQorCXJldCA9IGF2aWNfc2V0dXBfYWNjZXNzX3BhZ2UodmNwdSwgdHJ1ZSk7DQogCWlmIChy
ZXQpDQogCQlyZXR1cm4gcmV0Ow0KIA0KLS0gDQoyLjE3LjENCg0K
