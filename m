Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A15CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A6321872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WqLMPBV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfAXEQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 23:16:48 -0500
Received: from mail-eopbgr730069.outbound.protection.outlook.com ([40.107.73.69]:12256
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726313AbfAXEQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 23:16:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODeludbptiFoQja3ZDWscgXAMDckpyv+Q0Zxcsr9hpU=;
 b=WqLMPBV+gUSIi5gN/Tn2re9jyvW71vfhe6kibbxvKwcs9qaKGHaJpPbbVRzzU54P7l29FM4pzXb+4KtfhY5f/3Hejb2Z0tGSnQXj0LCDWKrUWszPY03z235LS0K64R1KlQQXkzdhI1Q/mQPUrfEhON0LRY8w7lLPI4M9z5S0hc8=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3355.namprd12.prod.outlook.com (20.178.198.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Thu, 24 Jan 2019 04:16:45 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1537.031; Thu, 24 Jan 2019
 04:16:45 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: [PATCH v3] iommu: amd: Fix IOMMU page flush when detach device from a
 domain
Thread-Topic: [PATCH v3] iommu: amd: Fix IOMMU page flush when detach device
 from a domain
Thread-Index: AQHUs5ueti9jdxud0kGP04WcL8K6sA==
Date:   Thu, 24 Jan 2019 04:16:45 +0000
Message-ID: <20190124041619.1974-1-Suravee.Suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [171.96.74.181]
x-clientproxiedby: SG2PR0601CA0019.apcprd06.prod.outlook.com (2603:1096:3::29)
 To DM6PR12MB2844.namprd12.prod.outlook.com (2603:10b6:5:45::32)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3355;20:3lAG62uxdtxOqtgg+bRlxL2sffavVcJblbh0ycoYH5lREhSWqkQ2VvENGXXwVOAEnOT9GXyhhuZ2V8/rAE6s6H6PeTDv/tLYVBBlI+CJsnOWaOF4SMuTRqEUbDzGA1sDUoUKE7OFi/n12YWTkfRzNSlgDWiD0gKxoQ0rcSiDhe7mM9nCAWGC/rmAIoIqy4wf+kBc6OMF7M3fjEFqTjOuLT0zXho89a/JCoxwVGxWxD14IQKleE8+CrarAwM3N27W
x-ms-office365-filtering-correlation-id: 84101a31-1c9b-419c-cb6d-08d681b2c061
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3355;
x-ms-traffictypediagnostic: DM6PR12MB3355:
x-microsoft-antispam-prvs: <DM6PR12MB3355D6E718E1EB7278097E32F39A0@DM6PR12MB3355.namprd12.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(39860400002)(136003)(346002)(189003)(199004)(54906003)(386003)(72206003)(6512007)(6436002)(2501003)(71200400001)(52116002)(53936002)(478600001)(99286004)(102836004)(68736007)(71190400001)(6346003)(14454004)(26005)(6506007)(110136005)(6486002)(316002)(7736002)(186003)(305945005)(8676002)(105586002)(81156014)(81166006)(25786009)(66066001)(106356001)(36756003)(50226002)(2906002)(486006)(14444005)(5024004)(3846002)(256004)(2616005)(476003)(1076003)(86362001)(4326008)(8936002)(6116002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3355;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XfRCeB7D+HYPexMGB2+YM+biFPj/x4zKhDdLbiWrWtIkyJLe/5FzzR01fG2r+GrpPX3EGNhe2tfQ3rtypEXmuINKiG1DXDQqys3t9oxDhKvz0gwM7nblvng/LYksu3xLdgotzSaO5dZriudH4mFhS9oX8CtQUh7qI7EMqfWL+olO83sZZnbnGTfbns7fjZ9U+T7uoDXsCCx7NTBFsdxGbVQ3jr7Q20XrYDAEgzS7Z5UXrEYcggn1cLJZWg2guTIVmHEk3DQyqAhkjxej0eezFK26IKOg6Bmnw6x4tbffFQuR9yZVzavw/MeKs/d8syVb3wMAFHjkqNQdR9EbboWgHNUwOXpf9Pi/ye/dM3Zl3mFFjNKLflwDzdkAxwxWuq7OfqYWT74M4V4DjXpuJwJ06/UPkdRxXKGdZFgoVXWg2qo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84101a31-1c9b-419c-cb6d-08d681b2c061
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 04:16:42.9394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3355
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

Fix this by invalidate IOMMU pages when detach a device, and
before decrementing the per-domain device reference counts.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Suggested-by: Joerg Roedel <joro@8bytes.org>
Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 87ba23a75b38..6cd4a00036c1 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1991,16 +1991,13 @@ static void do_attach(struct iommu_dev_data *dev_da=
ta,
=20
 static void do_detach(struct iommu_dev_data *dev_data)
 {
+	struct protection_domain *domain =3D dev_data->domain;
 	struct amd_iommu *iommu;
 	u16 alias;
=20
 	iommu =3D amd_iommu_rlookup_table[dev_data->devid];
 	alias =3D dev_data->alias;
=20
-	/* decrease reference counters */
-	dev_data->domain->dev_iommu[iommu->index] -=3D 1;
-	dev_data->domain->dev_cnt                 -=3D 1;
-
 	/* Update data structures */
 	dev_data->domain =3D NULL;
 	list_del(&dev_data->list);
@@ -2010,6 +2007,16 @@ static void do_detach(struct iommu_dev_data *dev_dat=
a)
=20
 	/* Flush the DTE entry */
 	device_flush_dte(dev_data);
+
+	/* Flush IOTLB */
+	domain_flush_tlb_pde(domain);
+
+	/* Wait for the flushes to finish */
+	domain_flush_complete(domain);
+
+	/* decrease reference counters - needs to happen after the flushes */
+	domain->dev_iommu[iommu->index] -=3D 1;
+	domain->dev_cnt                 -=3D 1;
 }
=20
 /*
--=20
2.17.1

