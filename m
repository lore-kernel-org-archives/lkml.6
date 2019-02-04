Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA90C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFDE2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A8px2EP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfBDOmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:42:02 -0500
Received: from mail-eopbgr770048.outbound.protection.outlook.com ([40.107.77.48]:38604
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728788AbfBDOmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAwiw0B9X2/HXSuWRSqkC8AZAyUC/8wLEsYLldE8hi4=;
 b=A8px2EP3IGHxQJIIt9PnVaUsliduhv7IKsqhyll37iQn4RtflhSjoabAz/0l+QUC/nG6ReJFjHiWybah+wHlco8h4+7xSF/wTk18DPvEfoD3EtpthzRCGA83bZYUmUmoMZhtOwL0jdPzf9gcl1ocVMjPjwmZ0IEYQOtHm7CnIuI=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3274.namprd12.prod.outlook.com (20.179.106.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 14:41:58 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1558.026; Mon, 4 Feb 2019
 14:41:58 +0000
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
Subject: [RFC PATCH 1/8] svm: Fix improper check when deactivate AVIC
Thread-Topic: [RFC PATCH 1/8] svm: Fix improper check when deactivate AVIC
Thread-Index: AQHUvJfI6Shdn7859Eac1gOwTJqJGQ==
Date:   Mon, 4 Feb 2019 14:41:58 +0000
Message-ID: <20190204144128.9489-2-suravee.suthikulpanit@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3274;20:g7ZJfwQIhk5xhy/RDWVAevjMjM+hEnmBxTCR06X21aY2TAVj2Dq3A++gCzZBKaQPS5aTDGB+rNTs7qjDVo3cBKzSaWXvbxV0zKyLqLcFOWz2YNZiqIkpfCPlI/32wxetpPlUzHiORiFPy10eBDJhlNlUrjAKqHLCw4WNi53q8yGBl3DGvfMjBKxEtNZy86/IxIycmrEkejqX1/FuHpofaSOykkCULCB3Pb0R4pXALw1gnqeGFHCNPvojmCkjvp83
x-ms-office365-filtering-correlation-id: bde4024f-1bdf-4d44-e158-08d68aaeea89
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3274;
x-ms-traffictypediagnostic: DM6PR12MB3274:
x-microsoft-antispam-prvs: <DM6PR12MB32746C8F4D07E4B27124DAB8F36D0@DM6PR12MB3274.namprd12.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(6116002)(3846002)(105586002)(81166006)(81156014)(6436002)(52116002)(186003)(256004)(217873002)(106356001)(2501003)(8936002)(8676002)(316002)(110136005)(4326008)(99286004)(2201001)(86362001)(72206003)(14454004)(386003)(25786009)(7736002)(305945005)(478600001)(6486002)(54906003)(53936002)(6512007)(50226002)(71190400001)(486006)(66574012)(1076003)(6506007)(97736004)(102836004)(476003)(68736007)(2616005)(11346002)(2906002)(446003)(7416002)(26005)(76176011)(71200400001)(66066001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3274;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zVlFvCBAEx/hNjJ73/21U3mkf/Bo10qGHv5HlrtyQqBcfFII7fAdVkq8cRnSE4ymui3s6bxLjmiPFk8Zsr/6S7goBZgksQFEeD/GpNyFvWmsBBGKLtQHxQE7Uo3vhLpiLXitU1a2dYHZ2HT9GqXsrJpenfBDgGoQOVXTOHZN9eEUZAChxyIge6QZ9Uizs/Pr58QcTuSwAvwC3XdszqKNZ9saDpd+dSgYG4REEPJjjECXTQJOxTbuxuAGxWUuuUZVv5tQGbpmA0h5VeFtdcejwb1SB0RY+nUcOt3AtlSN6u8JVR2BR15QW/p3Iy6IIWkiywScsvtIO6ckMsJTIhJF+AM/tqTXv09bCbZby6sV0erNGNzn00GhtuksSL8tglJMant7dm4IYwOrgWql/WaBTZEzSgBwYT0s4WkoTuYEqSs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <307706FF00CE83449B9E99F131238ACA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde4024f-1bdf-4d44-e158-08d68aaeea89
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 14:41:53.9199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
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
bmcgQVZJQycpDQpDYzogUmFkaW0gS3LEjW3DocWZIDxya3JjbWFyQHJlZGhhdC5jb20+DQpTdWdn
ZXN0ZWQtYnk6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBTdXJhdmVlIFN1dGhpa3VscGFuaXQgPHN1cmF2ZWUuc3V0aGlrdWxwYW5pdEBhbWQuY29t
Pg0KLS0tDQogYXJjaC94ODYva3ZtL3N2bS5jIHwgMTAgKysrKystLS0tLQ0KIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9rdm0vc3ZtLmMgYi9hcmNoL3g4Ni9rdm0vc3ZtLmMNCmluZGV4IGQzNWM5MDAyZjI4Mi4u
NzU1MDhmNjY1YWVmIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva3ZtL3N2bS5jDQorKysgYi9hcmNo
L3g4Ni9rdm0vc3ZtLmMNCkBAIC01MTE0LDExICs1MTE0LDExIEBAIHN0YXRpYyB2b2lkIHN2bV9y
ZWZyZXNoX2FwaWN2X2V4ZWNfY3RybChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQogCXN0cnVjdCB2
Y3B1X3N2bSAqc3ZtID0gdG9fc3ZtKHZjcHUpOw0KIAlzdHJ1Y3Qgdm1jYiAqdm1jYiA9IHN2bS0+
dm1jYjsNCiANCi0JaWYgKCFrdm1fdmNwdV9hcGljdl9hY3RpdmUoJnN2bS0+dmNwdSkpDQotCQly
ZXR1cm47DQotDQotCXZtY2ItPmNvbnRyb2wuaW50X2N0bCAmPSB+QVZJQ19FTkFCTEVfTUFTSzsN
Ci0JbWFya19kaXJ0eSh2bWNiLCBWTUNCX0lOVFIpOw0KKwlpZiAoa3ZtX3ZjcHVfYXBpY3ZfYWN0
aXZlKHZjcHUpKQ0KKwkJdm1jYi0+Y29udHJvbC5pbnRfY3RsIHw9IEFWSUNfRU5BQkxFX01BU0s7
DQorCWVsc2UNCisJCXZtY2ItPmNvbnRyb2wuaW50X2N0bCAmPSB+QVZJQ19FTkFCTEVfTUFTSzsN
CisJbWFya19kaXJ0eSh2bWNiLCBWTUNCX0FWSUMpOw0KIH0NCiANCiBzdGF0aWMgdm9pZCBzdm1f
bG9hZF9lb2lfZXhpdG1hcChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHU2NCAqZW9pX2V4aXRfYml0
bWFwKQ0KLS0gDQoyLjE3LjENCg0K
