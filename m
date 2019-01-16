Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF8CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7594920840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="5lNuHH9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbfAPEQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 23:16:28 -0500
Received: from mail-eopbgr710063.outbound.protection.outlook.com ([40.107.71.63]:21271
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728227AbfAPEQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 23:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+QTe1n9Lkd3bIDHtPhSq4qNxySzxRDB3EGB9trOPQw=;
 b=5lNuHH9gdnETlcWdaSM+LrlKAil4RPzeMvlxrDDZxd5iwQk2/+z4DmCz080HlaCSAkaC67Xm6RfR1LyS9Lf/qocMukMHM0tyWJ1D/kims119q27aDbNn6mP7m/w//VpSsxstliBu44k5Fo6rMSjKac8D/tC2ibmkAgQyyLvqUjY=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3499.namprd12.prod.outlook.com (20.178.199.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Wed, 16 Jan 2019 04:16:26 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 04:16:26 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices from
 a domain
Thread-Topic: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices
 from a domain
Thread-Index: AQHUrVI/ylqJsNQGs0C49TFTH04R5A==
Date:   Wed, 16 Jan 2019 04:16:25 +0000
Message-ID: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [171.96.72.112]
x-clientproxiedby: SG2PR04CA0195.apcprd04.prod.outlook.com
 (2603:1096:4:14::33) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3499;20:LgoefaXq+XMZAu4UafGennPx1rJ8AQ3YidA9rAUVqifdE91cmU7WFbCUlqe+pse1bcuIF7yiUPj7HMow6XddJ/xuEx+BQpQOGfQYbWRIsRH46N3LUvfZ32o/hD1Ebb4pTTkdHgJ705f2Q7qg23bink2CMw6K8t1m7WT/FpfYEBLjcqTow5rp/lr6qzg7lNbMbU7irOtfJwPHKwRpX3yIcAiD/LYG+GvWvAMB4e2xRt17bNF9gJEVZmAMWy+DvZuI
x-ms-office365-filtering-correlation-id: da32c627-3d06-4032-82ff-08d67b696179
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3499;
x-ms-traffictypediagnostic: DM6PR12MB3499:
x-microsoft-antispam-prvs: <DM6PR12MB3499606CE84A6E2C7DB70B32F3820@DM6PR12MB3499.namprd12.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(8936002)(81156014)(81166006)(8676002)(52116002)(25786009)(478600001)(6436002)(6486002)(2906002)(72206003)(68736007)(97736004)(66066001)(3846002)(6116002)(476003)(486006)(2501003)(2616005)(6506007)(102836004)(50226002)(5660300001)(386003)(86362001)(26005)(14454004)(5024004)(186003)(54906003)(4326008)(105586002)(14444005)(53936002)(316002)(256004)(6512007)(305945005)(99286004)(106356001)(1076003)(71200400001)(71190400001)(36756003)(7736002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3499;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N8jgjJi4bCw6+t8LrR380XY/EDD4SPOIN+LYO6gWoCJDdfC8cp8HJ23miZ1NXMennWrkWLiz0ABVQOLJ93s16sUSVS6icJrH/1Plf05Aiae/Xp++6zyB7F8lbsZBESW9PERPHFWzhAMaEKs9Uk8sCGo5pwqd6ie4S56Mpfn82uSFjl5NyV14UBAm1L5ntJil9HUbsEEy9BfQczAwk6KEDXWvC0K6xhUxDoLxHgYESdji7/8ejgbAVHXrMOG+aIKxMcbPFTJ3UDt9KcEbXF/rR8a+v97flg/oSeJTMZjCpJ7Fm8fYWJ8jz1WDW8AFruJkvi/OsUhLciwPKRPNrhercvRVb2lyd7lu2gz+2W6Oc8Tfd6hPim666y4f/V1WdewHT0BcUvOxS9D4qy5hpf8yKL6wZtZp3EOsee8q1Bn2e30=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da32c627-3d06-4032-82ff-08d67b696179
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 04:16:23.5076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3499
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

When a VM is terminated, the VFIO driver detaches all pass-through
devices from VFIO domain by clearing domain id and page table root
pointer from each device table entry (DTE), and then invalidates
the DTE. Then, the VFIO driver unmap pages and invalidate IOMMU pages.

Currently, the IOMMU driver keeps track of which IOMMU and how many
devices are attached to the domain. When invalidate IOMMU pages,
the driver checks if the IOMMU is still attached to the domain before
issuing the invalidate page command.

However, since VFIO has already detached all devices from the domain,
the subsequent INVALIDATE_IOMMU_PAGES commands are being skipped as
there is no IOMMU attached to the domain. This results in data
corruption and could cause the PCI device to end up in indeterministic
state.

Fix this by always issuing the IOMMU pages invalidate command when
device count is zero, which is the case when detaching all the devices
from the domain.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 525659b88ade..ab31ba75da1b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1248,7 +1248,13 @@ static void __domain_flush_pages(struct protection_d=
omain *domain,
 	build_inv_iommu_pages(&cmd, address, size, domain->id, pde);
=20
 	for (i =3D 0; i < amd_iommu_get_num_iommus(); ++i) {
-		if (!domain->dev_iommu[i])
+		/*
+		 * The dev_cnt is zero when all devices are detached
+		 * from the domain. This is the case when VFIO detaches
+		 * all devices from the group before flushing IOMMU pages.
+		 * So, always issue the flush command.
+		 */
+		if (domain->dev_cnt && !domain->dev_iommu[i])
 			continue;
=20
 		/*
--=20
2.17.1

