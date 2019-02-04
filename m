Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC1CC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF752082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xr5GgK1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbfBDOmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:42:39 -0500
Received: from mail-eopbgr740087.outbound.protection.outlook.com ([40.107.74.87]:7040
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730510AbfBDOmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwoRiThCF2Hw1jsq9VZe258OpqUDOkWr2WKJoKILsRs=;
 b=xr5GgK1cVdkr2VeRszz3RH40kbkBwiRDj71LquguUud1x37yuayAOVIGR/WP/WU3B3Y9HZA/ONgnLPZvMiZt1bPR1wuNC6kbWh4/LS4SEBtLlsNCOSi09gMkCswRik4l92cd4XIBR0imzGW3pbFGhi2lbRtfSjgOXqw3wD+fg48=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3082.namprd12.prod.outlook.com (20.178.30.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Mon, 4 Feb 2019 14:42:32 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1558.026; Mon, 4 Feb 2019
 14:42:32 +0000
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
Subject: [RFC PATCH 8/8] svm: Allow AVIC with in-kernel irqchip mode
Thread-Topic: [RFC PATCH 8/8] svm: Allow AVIC with in-kernel irqchip mode
Thread-Index: AQHUvJfczoXgq9UCxES9CxFgBN3rJw==
Date:   Mon, 4 Feb 2019 14:42:32 +0000
Message-ID: <20190204144128.9489-9-suravee.suthikulpanit@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3082;20:qS47NHx6dGqMeCi1xEVzjXQIE8J9+pVKB0+IP708uknFigMm8Gdt4QFOMEGnGABkFZIQy8UrWHBwsQUPFhsyU1WpoFCuI9n5XNsXH1KO3ZN3xbnkI+oBWSXbDQKGaEb0lsyYMkDOWzcBMZGSP7MFxQD/ZDybiuGfMP5Ia9NrQyMrFN2kNyoKNt2/OeaKe17vNuA42By9LOfG0r/HOs7417dyz2Xc5kw8R68VP500MSnEUzz5jrVP9IxKCBmcIxtY
x-ms-office365-filtering-correlation-id: 0a26d67e-f0e4-4339-c104-08d68aaefeb0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3082;
x-ms-traffictypediagnostic: DM6PR12MB3082:
x-microsoft-antispam-prvs: <DM6PR12MB30823068CC8C0CFCAD5FD9D0F36D0@DM6PR12MB3082.namprd12.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(189003)(199004)(105586002)(186003)(6486002)(6512007)(110136005)(97736004)(54906003)(26005)(446003)(52116002)(11346002)(2906002)(4744005)(305945005)(76176011)(106356001)(316002)(36756003)(478600001)(72206003)(8936002)(25786009)(217873002)(66066001)(7416002)(99286004)(4326008)(8676002)(81166006)(3846002)(86362001)(386003)(14454004)(102836004)(6506007)(81156014)(6116002)(14444005)(2501003)(256004)(53936002)(1076003)(68736007)(7736002)(6436002)(2201001)(71190400001)(71200400001)(476003)(486006)(50226002)(66574012)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3082;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IVE4Gj8d6tXWvg4QKoDyV+qye5wZh/lkVNmERRK6GqGKKxEyiSvik5obmO55j1pjuq2w3Ya4EtU+aC1SPeIRu3ek3vUmyrHIYmBJe+MVXjo2zURFXTHEPPrwC8VzVKVcs3fTDXBbv7iCP9FCOvoroyLtfCwy3TLe4bt95v2fRFP3wXpkkxgVwBqJ9qUGj7w3jSbmSJcYat8JjIzCa5UfYwtoZEXg3bf9z9duxGUu4qSFugndPUH5Jp2NSzCYhgl+Hlsai3CGpFSc6w44oVxElKL3H7BETxnrIlb+bjPQu5fiY+QaeHElW/F5PGdLKTX7PRo3vOofow5mCsiu00qB0G1rJXeCp9aqY8LptJ11vj//3Cyxs6n9SM0oqgrzf7EcDYnXbG3nF+Q8sWV2Vb7W88k1QcEvK4I5jtG3jnRLoIg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D5095B0C6F03142B6D5F12E22A36795@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a26d67e-f0e4-4339-c104-08d68aaefeb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 14:42:28.0313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T25jZSB0aGUgSVJRIGFjayBub3RpZmllciBmb3IgaW4ta2VybmVsIFBJVCBpcyBubyBsb25nZXIg
cmVxdWlyZWQNCmFuZCBydW4tdGltZSBBVklDIGFjdGl2YXRlL2RlYWN0aXZhdGUgaXMgc3VwcG9y
dGVkLCB3ZSBjYW4gcmVtb3ZlDQp0aGUga2VybmVsIGlycWNoaXAgc3BsaXQgbW9kZSByZXF1aXJl
bWVudCBmb3IgQVZJQy4NCg0KSGVuY2UsIHJlbW92ZSB0aGUgY2hlY2sgZm9yIGlycWNoaXAgc3Bs
aXQgbW9kZSB3aGVuIGVuYWJsaW5nIEFWSUMuDQoNCkNjOiBSYWRpbSBLcsSNbcOhxZkgPHJrcmNt
YXJAcmVkaGF0LmNvbT4NCkNjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0K
U2lnbmVkLW9mZi1ieTogU3VyYXZlZSBTdXRoaWt1bHBhbml0IDxzdXJhdmVlLnN1dGhpa3VscGFu
aXRAYW1kLmNvbT4NCi0tLQ0KIGFyY2gveDg2L2t2bS9zdm0uYyB8IDIgKy0NCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2t2bS9zdm0uYyBiL2FyY2gveDg2L2t2bS9zdm0uYw0KaW5kZXggNTgwYWI0MGJhMjA3Li4y
NGRmYTZhOTM3MTEgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtLmMNCisrKyBiL2FyY2gv
eDg2L2t2bS9zdm0uYw0KQEAgLTUxNTcsNyArNTE1Nyw3IEBAIHN0YXRpYyB2b2lkIHN2bV9zZXRf
dmlydHVhbF9hcGljX21vZGUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KIA0KIHN0YXRpYyBib29s
IHN2bV9nZXRfZW5hYmxlX2FwaWN2KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCiB7DQotCXJldHVy
biBhdmljICYmIGlycWNoaXBfc3BsaXQodmNwdS0+a3ZtKTsNCisJcmV0dXJuIGF2aWM7DQogfQ0K
IA0KIHN0YXRpYyB2b2lkIHN2bV9od2FwaWNfaXJyX3VwZGF0ZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZj
cHUsIGludCBtYXhfaXJyKQ0KLS0gDQoyLjE3LjENCg0K
