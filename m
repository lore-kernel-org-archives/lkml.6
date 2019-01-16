Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4484DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009EA20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AnX4cgaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbfAPEPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 23:15:14 -0500
Received: from mail-eopbgr770081.outbound.protection.outlook.com ([40.107.77.81]:23236
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728227AbfAPEPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 23:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q09G12z/yscawKRxGj+4zGy1ZGChl3En62aOXCFUZEs=;
 b=AnX4cgajM9F8yvISmmGSGh1NH1yh91DFHhI2yhQJvMI0A705jSFnib71BQ/Lj9kUdxmQg57TvQGwWJXiCEbjH01SsmV+Jv74GiueSl+zZx+MNvNm9mJwVolbixApBC1Rby2+vy0y2vT58mIYidTQULVMwBpF1+UYu4/0r/BaQjY=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3499.namprd12.prod.outlook.com (20.178.199.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Wed, 16 Jan 2019 04:15:10 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 04:15:10 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: [PATCH] iommu/amd: Mark translation invalid during device detach
Thread-Topic: [PATCH] iommu/amd: Mark translation invalid during device detach
Thread-Index: AQHUrVIS1FBDwqbIBkqoC3zkhHCLEQ==
Date:   Wed, 16 Jan 2019 04:15:10 +0000
Message-ID: <20190116041432.3484-1-Suravee.Suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [171.96.72.112]
x-clientproxiedby: SG2PR06CA0210.apcprd06.prod.outlook.com
 (2603:1096:4:68::18) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3499;20:7fT7EElP+XKnh1VG0ucz52Pfe8zUAD7YSGLsx50ux5MnF69dGKcvb+gD48ZL6X/VTNh6Giz+tpFp15T7GG4EseaMrodH4eu2HPVj6LQjCZbyZs05bVu3DzlWM7fH1NSRx2wCyqRccde2I2534r2GM/IcC6asEy7PiX9Gisw2QjMiuMepHjFVeiq5rEcKc2BSxtVF8TZ4Qijh7IZ2juLdy4FwpfpL7HDxxIJLoEZbNtA7O37gdceSOUcTPYId0vqM
x-ms-office365-filtering-correlation-id: a4322319-c27e-4a0f-5f16-08d67b69343d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3499;
x-ms-traffictypediagnostic: DM6PR12MB3499:
x-microsoft-antispam-prvs: <DM6PR12MB3499FCCD5CACC5267FD732D1F3820@DM6PR12MB3499.namprd12.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(8936002)(81156014)(81166006)(8676002)(52116002)(25786009)(478600001)(6436002)(6486002)(2906002)(72206003)(68736007)(97736004)(66066001)(3846002)(6116002)(476003)(486006)(2501003)(2616005)(6506007)(102836004)(50226002)(5660300001)(386003)(86362001)(26005)(14454004)(5024004)(186003)(54906003)(4326008)(105586002)(14444005)(53936002)(316002)(256004)(6512007)(305945005)(99286004)(106356001)(1076003)(71200400001)(71190400001)(36756003)(7736002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3499;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ILdvvT7VI2KAD2lIE2WgRWHZl/jAUjAqbO/MKIUoyZZOUPM5xZ+s8Fb0K3R105Rb35wHZclRSeWk+T21v6Imm4ZF6moKGuaUax32aNLf6e+YmWqVhs9yaA/jxErrm2CU3+5RCtPemfaoa73pz4rBR7/idgkwoqoGTDzoYwHjMyocLzGcmt547jfActoWBJp0+cUF7LC93YWtPqddMZG/D2+oqpT4v8KZBRJAeuBCz4//BIMgwdfUB369eAWNU+sYMr0qRrN4B31a8X1FwVg+NgpuxCZM81Jr5NtQCteW+BU90yN3BR+IMBYQIulpEm8mzHZT3IHrSizfgEIyjoZRZg0L22dd5jTajcWZjycxtJozaGVCfVoXK2n6yAGR8qn/Un7wLAmSF8Dqm50P5Nqnn+MT75tpIm+/BuPhaxoJSSI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4322319-c27e-4a0f-5f16-08d67b69343d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 04:15:07.6004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3499
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

When a device switches domain, IOMMU driver detach device from the old
domain, and attach device to the new domain. During this period
the host table root pointer is not set, which means DMA translation
should be marked as invalid (clear TV bit).

So, clear the TV bit when detach the device. The TV bit will be set
again when attaching device to the new domain.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 87ba23a75b38..525659b88ade 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1956,7 +1956,7 @@ static void set_dte_entry(u16 devid, struct protectio=
n_domain *domain,
 static void clear_dte_entry(u16 devid)
 {
 	/* remove entry from the device table seen by the hardware */
-	amd_iommu_dev_table[devid].data[0]  =3D DTE_FLAG_V | DTE_FLAG_TV;
+	amd_iommu_dev_table[devid].data[0]  =3D DTE_FLAG_V;
 	amd_iommu_dev_table[devid].data[1] &=3D DTE_FLAG_MASK;
=20
 	amd_iommu_apply_erratum_63(devid);
--=20
2.17.1

