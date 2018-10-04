Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C606BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F99C2087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0LOGyl5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F99C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeJEEfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:35:43 -0400
Received: from mail-eopbgr730041.outbound.protection.outlook.com ([40.107.73.41]:25120
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725997AbeJEEfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbYvstHbBBtFm2nKMD/RgM1zXH9mSzseubDqQzg0p2M=;
 b=0LOGyl5pA7SAflvCekY7RdAhhAE2RDyW53/QuTAAozk4o30HurFReBEZ8UWTUQ4C0hSF1oH3X1XC5TzpgIUc05ZIjP665ksxhqQi795IIvGh3jdLGt1P27B0e18uyzb0YHWBwZBwV4HQK0hGx4ADxylXBcKHjAAMbN2vrhTZkOw=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB2602.namprd12.prod.outlook.com (20.176.116.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Thu, 4 Oct 2018 21:40:23 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7c34:f2e8:a8a9:cab8]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7c34:f2e8:a8a9:cab8%3]) with mapi id 15.20.1185.024; Thu, 4 Oct 2018
 21:40:23 +0000
From:   "Singh, Brijesh" <brijesh.singh@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "# 4 . 14+" <stable@vger.kernel.org>
Subject: [PATCH] iommu/amd: Clear memory encryption mask from physical address
Thread-Topic: [PATCH] iommu/amd: Clear memory encryption mask from physical
 address
Thread-Index: AQHUXCrb10G8bEZUVkePsT0raSnuLQ==
Date:   Thu, 4 Oct 2018 21:40:23 +0000
Message-ID: <1538689210-14524-1-git-send-email-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0023.namprd04.prod.outlook.com
 (2603:10b6:803:21::33) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB2602;20:ZNNlULHxPPyeOBwCaXPNRjJnYrYao53whobPvqv5SBjOqFHLzu6pbYRZI9ldUBko1XqHx67DNttTKz5gHQ3koLeEZHj+v8JxUVWKxR4yllBvvpQF7Yg7YrEWfovH968uW3uLm/REPQg8elYp/GzJe2S6pacLaQ10H2LEGMOqcjHhzImnHztYrbnw70G7LkjHvXFi6tAHQI3dtplo0HRGQ1ZSH48CPv75CIZFfZVBE/Uq4HeaP4yoRoMSglU2FIQk
x-ms-office365-filtering-correlation-id: d21d1808-a1bd-48b9-d735-08d62a41fd34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2602;
x-ms-traffictypediagnostic: DM6PR12MB2602:
x-microsoft-antispam-prvs: <DM6PR12MB2602248DC8E5AB6DEEC755E9E5EA0@DM6PR12MB2602.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(146099531331640)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302091)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:DM6PR12MB2602;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2602;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(366004)(199004)(189003)(110136005)(99286004)(26005)(54906003)(81156014)(6486002)(6506007)(81166006)(68736007)(386003)(102836004)(478600001)(52116002)(8676002)(14444005)(53936002)(6512007)(71190400001)(66574009)(86362001)(575784001)(1857600001)(256004)(186003)(36756003)(2616005)(71200400001)(6116002)(2906002)(3846002)(8936002)(5660300001)(476003)(2501003)(97736004)(7736002)(5250100002)(486006)(106356001)(14454004)(2900100001)(66066001)(105586002)(316002)(25786009)(4326008)(6436002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2602;H:DM6PR12MB2682.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +DCuYfDFPq/A9wc/7TpI+YuhuoMwNWAHprywmEa+mzH71PW9a6Qkn8Yp+fJXFclcyiYufymskAEapKaOXK37DBjgluSy0pH+zHHfCunT1RBIkDSmvrnA2Xr+5V6HkO/naiekcw0sbUKns0R38KL0neJZGMTY7jEt9YH73a68H7d499ayVQ6Wi+e0t6LqacF/w887NLw8yacADCw7eSqxuKdVHYLcV9XShXWHHXFq0uEfpzg1pPGiJjbUwi7pMqUGCwk8F2eKr2KbfEF1BDs8a9EUMJJIYSqtFLQk7l3vFIfl6cDT2To93t2pfqT8oQaOMDcNoy/2VZQW+DOGB3hw6y4qOtUbEWDDSXDh2d+M4PY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B679516497FEB45AC5FE7EE73D29D08@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21d1808-a1bd-48b9-d735-08d62a41fd34
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 21:40:23.5017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2602
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qm9yaXMgT3N0cm92c2t5IHJlcG9ydGVkIGEgbWVtb3J5IGxlYWsgd2l0aCBkZXZpY2UgcGFzc3Ro
cm91Z2ggd2hlbiBTTUUNCmlzIGFjdGl2ZS4NCg0KVGhlIFZGSU8gZHJpdmVyIHVzZXMgaW9tbXVf
aW92YV90b19waHlzKCkgdG8gZ2V0IHRoZSBwaHlzaWNhbCBhZGRyZXNzIGZvcg0KYW4gaW92YS4g
VGhpcyBwaHlzaWNhbCBhZGRyZXNzIGlzIGxhdGVyIHBhc3NlZCBpbnRvIHZmaW9fdW5tYXBfdW5w
aW4oKSB0bw0KdW5waW4gdGhlIG1lbW9yeS4gVGhlIHZmaW9fdW5tYXBfdW5waW4oKSB1c2VzIHBm
bl92YWxpZCgpIGJlZm9yZSB1bnBpbm5pbmcNCnRoZSBtZW1vcnkuIFRoZSBwZm5fdmFsaWQoKSBj
aGVjayB3YXMgZmFpbGluZyBiZWNhdXNlIGVuY3J5cHRpb24gbWFzayB3YXMNCnBhcnQgb2YgdGhl
IHBoeXNpY2FsIGFkZHJlc3MgcmV0dXJuZWQuIFRoaXMgcmVzdWx0ZWQgaW4gdGhlIG1lbW9yeSBu
b3QNCmJlaW5nIHVucGlubmVkIGFuZCB0aGVyZWZvcmUgbGVha2VkIGFmdGVyIHRoZSBndWVzdCB0
ZXJtaW5hdGVzLg0KDQpUaGUgbWVtb3J5IGVuY3J5cHRpb24gbWFzayBtdXN0IGJlIGNsZWFyZWQg
ZnJvbSB0aGUgcGh5c2ljYWwgYWRkcmVzcyBpbg0KaW9tbXVfaW92YV90b19waHlzKCkuDQoNCkZp
eGVzOiAyNTQzYTc4NmFhMjUgKCJpb21tdS9hbWQ6IEFsbG93IHRoZSBBTUQgSU9NTVUgdG8gd29y
ayB3aXRoIG1lbW9yeSBlbmNyeXB0aW9uIikNClJlcG9ydGVkLWJ5OiBCb3JpcyBPc3Ryb3Zza3kg
PGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPg0KQ2M6IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxl
bmRhY2t5QGFtZC5jb20+DQpDYzogSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+DQpDYzog
PGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnPg0KQ2M6IEJvcmlzbGF2IFBldGtvdiA8
YnBAc3VzZS5kZT4NCkNjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KQ2M6
IFJhZGltIEtyxI1tw6HFmSA8cmtyY21hckByZWRoYXQuY29tPg0KQ2M6IGt2bUB2Z2VyLmtlcm5l
bC5vcmcNCkNjOiBCb3JpcyBPc3Ryb3Zza3kgPGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPg0K
Q2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIDQuMTQrDQpTaWduZWQtb2ZmLWJ5OiBCcmlq
ZXNoIFNpbmdoIDxicmlqZXNoLnNpbmdoQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L2Ft
ZF9pb21tdS5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYyBiL2RyaXZl
cnMvaW9tbXUvYW1kX2lvbW11LmMNCmluZGV4IDczZTQ3ZDkuLmJlZTBkZmIgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L2FtZF9pb21t
dS5jDQpAQCAtMzA2OSw3ICszMDY5LDcgQEAgc3RhdGljIHBoeXNfYWRkcl90IGFtZF9pb21tdV9p
b3ZhX3RvX3BoeXMoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tLA0KIAkJcmV0dXJuIDA7DQogDQog
CW9mZnNldF9tYXNrID0gcHRlX3Bnc2l6ZSAtIDE7DQotCV9fcHRlCSAgICA9ICpwdGUgJiBQTV9B
RERSX01BU0s7DQorCV9fcHRlCSAgICA9IF9fc21lX2NscigqcHRlICYgUE1fQUREUl9NQVNLKTsN
CiANCiAJcmV0dXJuIChfX3B0ZSAmIH5vZmZzZXRfbWFzaykgfCAoaW92YSAmIG9mZnNldF9tYXNr
KTsNCiB9DQotLSANCjIuNy40DQoNCg==
