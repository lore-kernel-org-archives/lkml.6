Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5C7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47FA214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GFyHmHqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfA2IJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:09:53 -0500
Received: from mail-eopbgr740053.outbound.protection.outlook.com ([40.107.74.53]:27758
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727781AbfA2IJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjOA0nRKaUZqa59shphD8+kqEBj/b7FPWV//9bR1ZNY=;
 b=GFyHmHqAQrr5h0BPYNLEzfyScTMCRnYJgJLn1r/7gAupAgJd43cX+bsXKJvGjST5Zee+1K/jRr4NMTt1djg2qKMTZz1U1uij9dlIFx47IBk5hlxw044lHS0sOhmOn9DfnbjKTDO0OgnvEEpXtfe5NN0A22fwcdyODg/qLgvTsVI=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3610.namprd12.prod.outlook.com (20.178.199.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.20; Tue, 29 Jan 2019 08:09:46 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:09:46 +0000
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
Subject: [PATCH] svm: Fix improper check when deactivate AVIC
Thread-Topic: [PATCH] svm: Fix improper check when deactivate AVIC
Thread-Index: AQHUt6n/PbEp8KQZn0iUg2/B2tUkjQ==
Date:   Tue, 29 Jan 2019 08:09:46 +0000
Message-ID: <20190129080913.40998-1-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.121.4.14]
x-clientproxiedby: SG2PR02CA0116.apcprd02.prod.outlook.com
 (2603:1096:4:92::32) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3610;20:oV5P7kp3vevm+ygJpalY4V4bVylbE+ADgh9l+mcLfdKz6vifPouEO8c3OKlSpV01vDegF2/DtiCHOKekxUkpnYl3k2lyuOfTcWHAdFSqmavh9SNDJS9cX0km0EfBRpaOCFXBnk3buwE2KNBJvaEryJJ0y1iuqoKMF/mszrFw0Bmf1pUXehriWT/TwZ3odtJmw72TlqFkkeOhMfXQatGGwsRXh3OOeDIjseQ+fI3L7sZ63XLNxgptR+xMQZthD2o/
x-ms-office365-filtering-correlation-id: debe10c2-69e7-40a8-8198-08d685c121a6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3610;
x-ms-traffictypediagnostic: DM6PR12MB3610:
x-microsoft-antispam-prvs: <DM6PR12MB3610F2E9C62983EC9E30678AF3970@DM6PR12MB3610.namprd12.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39860400002)(199004)(189003)(305945005)(8676002)(81156014)(71200400001)(81166006)(71190400001)(50226002)(7736002)(6116002)(3846002)(256004)(14444005)(8936002)(1076003)(66574012)(2906002)(54906003)(66066001)(52116002)(110136005)(316002)(68736007)(97736004)(386003)(6506007)(99286004)(7416002)(6512007)(102836004)(4326008)(26005)(486006)(476003)(2501003)(2616005)(6486002)(6436002)(186003)(105586002)(72206003)(36756003)(478600001)(53936002)(14454004)(2201001)(106356001)(25786009)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3610;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Akis3geVUYRathRkv8aiOZuACTcrRsXbqFjDijN5hr94aRP4LZZ6f0qnHap8r9MmNDQ3LkIpRQm9A8LWJKFshDNlBXKQid2is+xUcyIve2OQkzOpDTyDUHrRbBJX35UyFoK62Xt/AUaLWhF9jchPQ1tamkSwLMel0RNpJaKZWKsCDWGpvyz0+byKzJb5EhnfzbWoillSFET3sSH3iq7duWRLehZtI5bAK37uIujUio435C3a+gy6uhTKKUIR5+mL8EQ+v2xXZMY+LDy1nGFI6raCmNEjDvY7yBVyi/qLE783h0ygJbnV9jQi0Fg+v5AJ2POD9GLeoltka7VizVgUfM5nn+5EiZVQx9vJsA72nWNeWbZ2vAx86ad45+sl7kn3pw+EONcoBKbQs2JYM7WuyZFfjGnUU39VMzEuLYe+jks=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CFC8CC90DE3B647B9A3F453C0BE0391@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debe10c2-69e7-40a8-8198-08d685c121a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:09:35.4222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGZ1bmN0aW9uIHN2bV9yZWZyZXNoX2FwaWN2X2V4ZWNfY3RybCgpIGFsd2F5cyByZXR1cm5p
bmcgcHJlbWF0dXJlbHkNCmFzIGt2bV92Y3B1X2FwaWN2X2FjdGl2ZSgpIGFsd2F5cyByZXR1cm4g
ZmFsc2Ugd2hlbiBjYWxsaW5nIGZyb20NCnRoZSBmdW5jdGlvbiBhcmNoL3g4Ni9rdm0veDg2LmM6
a3ZtX3ZjcHVfZGVhY3RpdmF0ZV9hcGljdigpLg0KVGhpcyBpcyBiZWNhdXNlIHRoZSBhcGljdl9h
Y3RpdmUgaXMgc2V0IHRvIGZhbHNlIGp1c3QgYmVmb3JlIGNhbGxpbmcNCnJlZnJlc2hfYXBpY3Zf
ZXhlY19jdHJsKCkuDQoNCkFsc28sIHdlIG5lZWQgdG8gbWFyayBWTUNCX0FWSUMgYml0IGFzIGRp
cnR5IGluc3RlYWQgb2YgVk1DQl9JTlRSLg0KDQpTbywgZml4IHN2bV9yZWZyZXNoX2FwaWN2X2V4
ZWNfY3RybCgpIHRvIHByb3Blcmx5IGRlYWN0aXZhdGUgQVZJQy4NCg0KRml4ZXM6IDY3MDM0YmI5
ZGQ1ZSAoJ0tWTTogU1ZNOiBBZGQgaXJxY2hpcF9zcGxpdCgpIGNoZWNrcyBiZWZvcmUgZW5hYmxp
bmcgQVZJQycpDQpDYzogUmFkaW0gS3LEjW3DocWZIDxya3JjbWFyQHJlZGhhdC5jb20+DQpDYzog
UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NClNpZ25lZC1vZmYtYnk6IFN1cmF2
ZWUgU3V0aGlrdWxwYW5pdCA8c3VyYXZlZS5zdXRoaWt1bHBhbml0QGFtZC5jb20+DQotLS0NCiBh
cmNoL3g4Ni9rdm0vc3ZtLmMgfCAyMiArKysrKysrKysrKysrKysrKystLS0tDQogMSBmaWxlIGNo
YW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9rdm0vc3ZtLmMgYi9hcmNoL3g4Ni9rdm0vc3ZtLmMNCmluZGV4IGQzNWM5MDAyZjI4
Mi4uNTliMWY2ODA2MGM3IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva3ZtL3N2bS5jDQorKysgYi9h
cmNoL3g4Ni9rdm0vc3ZtLmMNCkBAIC0zOTAsNiArMzkwLDggQEAgc3RhdGljIGludCBuZXN0ZWRf
c3ZtX3ZtZXhpdChzdHJ1Y3QgdmNwdV9zdm0gKnN2bSk7DQogc3RhdGljIGludCBuZXN0ZWRfc3Zt
X2NoZWNrX2V4Y2VwdGlvbihzdHJ1Y3QgdmNwdV9zdm0gKnN2bSwgdW5zaWduZWQgbnIsDQogCQkJ
CSAgICAgIGJvb2wgaGFzX2Vycm9yX2NvZGUsIHUzMiBlcnJvcl9jb2RlKTsNCiANCitzdGF0aWMg
Ym9vbCBzdm1fZ2V0X2VuYWJsZV9hcGljdihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOw0KKw0KIGVu
dW0gew0KIAlWTUNCX0lOVEVSQ0VQVFMsIC8qIEludGVyY2VwdCB2ZWN0b3JzLCBUU0Mgb2Zmc2V0
LA0KIAkJCSAgICBwYXVzZSBmaWx0ZXIgY291bnQgKi8NCkBAIC00NzgsNiArNDgwLDEyIEBAIHN0
YXRpYyBpbmxpbmUgc3RydWN0IHZjcHVfc3ZtICp0b19zdm0oc3RydWN0IGt2bV92Y3B1ICp2Y3B1
KQ0KIAlyZXR1cm4gY29udGFpbmVyX29mKHZjcHUsIHN0cnVjdCB2Y3B1X3N2bSwgdmNwdSk7DQog
fQ0KIA0KK3N0YXRpYyBib29sIGlzX2F2aWNfYWN0aXZlKHN0cnVjdCB2Y3B1X3N2bSAqc3ZtKQ0K
K3sNCisJcmV0dXJuIChzdm1fZ2V0X2VuYWJsZV9hcGljdigmc3ZtLT52Y3B1KSAmJg0KKwkJc3Zt
LT52bWNiLT5jb250cm9sLmludF9jdGwgJiBBVklDX0VOQUJMRV9NQVNLKTsNCit9DQorDQogc3Rh
dGljIGlubGluZSB2b2lkIGF2aWNfdXBkYXRlX3ZhcGljX2JhcihzdHJ1Y3QgdmNwdV9zdm0gKnN2
bSwgdTY0IGRhdGEpDQogew0KIAlzdm0tPnZtY2ItPmNvbnRyb2wuYXZpY192YXBpY19iYXIgPSBk
YXRhICYgVk1DQl9BVklDX0FQSUNfQkFSX01BU0s7DQpAQCAtNTEwOCwxNyArNTExNiwyMyBAQCBz
dGF0aWMgdm9pZCBzdm1faHdhcGljX2lzcl91cGRhdGUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBp
bnQgbWF4X2lzcikNCiB7DQogfQ0KIA0KLS8qIE5vdGU6IEN1cnJlbnRseSBvbmx5IHVzZWQgYnkg
SHlwZXItVi4gKi8NCi1zdGF0aWMgdm9pZCBzdm1fcmVmcmVzaF9hcGljdl9leGVjX2N0cmwoc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1KQ0KK3N0YXRpYyB2b2lkIHN2bV9kZWFjdGl2YXRlX2F2aWMoc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1KQ0KIHsNCiAJc3RydWN0IHZjcHVfc3ZtICpzdm0gPSB0b19zdm0o
dmNwdSk7DQogCXN0cnVjdCB2bWNiICp2bWNiID0gc3ZtLT52bWNiOw0KIA0KLQlpZiAoIWt2bV92
Y3B1X2FwaWN2X2FjdGl2ZSgmc3ZtLT52Y3B1KSkNCisJaWYgKCFsYXBpY19pbl9rZXJuZWwodmNw
dSkgfHwgIWlzX2F2aWNfYWN0aXZlKHN2bSkpDQogCQlyZXR1cm47DQogDQogCXZtY2ItPmNvbnRy
b2wuaW50X2N0bCAmPSB+QVZJQ19FTkFCTEVfTUFTSzsNCi0JbWFya19kaXJ0eSh2bWNiLCBWTUNC
X0lOVFIpOw0KKwltYXJrX2RpcnR5KHZtY2IsIFZNQ0JfQVZJQyk7DQorfQ0KKw0KKy8qIE5vdGU6
IEN1cnJlbnRseSBvbmx5IHVzZWQgYnkgSHlwZXItVi4gKi8NCitzdGF0aWMgdm9pZCBzdm1fcmVm
cmVzaF9hcGljdl9leGVjX2N0cmwoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KK3sNCisJaWYgKCFr
dm1fdmNwdV9hcGljdl9hY3RpdmUodmNwdSkpDQorCQlzdm1fZGVhY3RpdmF0ZV9hdmljKHZjcHUp
Ow0KIH0NCiANCiBzdGF0aWMgdm9pZCBzdm1fbG9hZF9lb2lfZXhpdG1hcChzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUsIHU2NCAqZW9pX2V4aXRfYml0bWFwKQ0KLS0gDQoyLjE3LjENCg0K
