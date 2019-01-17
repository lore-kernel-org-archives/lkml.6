Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D505C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B932320855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h894TA//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfAQLrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:47:41 -0500
Received: from mail-eopbgr730087.outbound.protection.outlook.com ([40.107.73.87]:5363
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbfAQLrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pItHEkGyIIyAwVayZDZqHtDjpORukdahsGJYf0ekpDU=;
 b=h894TA//Xy1LscMZ+8qK3q1HgdHRR9FfzqBG/1H1UhUrhu+hXvPjqUb0MEIck1ubMEXgzkrFcYIndM4szYLWoQo80TLO96reFXVjQ8mB0ENcI723zu9WTYWowFkyj41eQjGOSUdR110owe2qcKY/4IlT9btcDeEQ6Fb2E+OH38Y=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB2619.namprd12.prod.outlook.com (20.176.116.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Thu, 17 Jan 2019 11:47:36 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1516.019; Thu, 17 Jan 2019
 11:47:35 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: [PATCH v2] iommu/amd: Fix IOMMU page flush when detach all devices
 from a domain
Thread-Topic: [PATCH v2] iommu/amd: Fix IOMMU page flush when detach all
 devices from a domain
Thread-Index: AQHUrlpwnx8bCgNNzkO0cNUxOunOMQ==
Date:   Thu, 17 Jan 2019 11:47:35 +0000
Message-ID: <20190117114714.126410-1-Suravee.Suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.121.4.136]
x-clientproxiedby: SG2PR06CA0208.apcprd06.prod.outlook.com
 (2603:1096:4:68::16) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB2619;20:Wa8ejE15O6YjxUGRKsxwX1YCuA7TRCEAreQzULrHKk7dPLzRsYtj7YkFISez4C1l4xgLpQ3H0acs1Cb6pIvqaRiyoxWKB+lH9qrcaj3j+csspeeMbljWj+/tHGZJfBbG/GTJAcMGyM9BNmBW+nPErPDYXqlOQA1HoAtEPY5KZx+cvC5zQSbg8KSZcypFJJrxbIlxle+A4PqKatdlodvVCvMWaqFTLUZlXB5SvE3Eu5PANKySTH4Gd4HKC+uyw1kS
x-ms-office365-filtering-correlation-id: 724c8a50-8028-4622-650e-08d67c7192d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2619;
x-ms-traffictypediagnostic: DM6PR12MB2619:
x-microsoft-antispam-prvs: <DM6PR12MB2619F222EC32F5FE19D55AE7F3830@DM6PR12MB2619.namprd12.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(136003)(376002)(189003)(199004)(66066001)(36756003)(99286004)(81166006)(81156014)(8676002)(7736002)(6436002)(106356001)(8936002)(105586002)(305945005)(1076003)(2616005)(2906002)(476003)(50226002)(6512007)(486006)(53936002)(6486002)(4326008)(6506007)(25786009)(26005)(186003)(14454004)(68736007)(478600001)(386003)(102836004)(5660300001)(71200400001)(316002)(97736004)(256004)(72206003)(5024004)(14444005)(71190400001)(86362001)(54906003)(110136005)(2501003)(52116002)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2619;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: erEsdnKenTGaQVrm7ZwuRJhxv8ulVLQYlvJEbaNTiJ6jPuMoWzI1UHagkoeqcoVqfiR8kEQORCzjpBSHHZg+RFhADJxsPEJ8eR5epNHgYcnmr5Ronjsa4cW9X7oOophhy/gAR/hfuLXTK37PUuG0cjeM4iaLZXJdsbzWV9IRgC7EcpbnyfmSJMvIDiF6Aaq7CD/r9Xnvp/zu27gg02l0Kkj1wb6PMphDEmatg1z392Zli2azyFKr/0Y/2iimKl1JRzWdR9InCNHZ4ieuTdjFB15xoVzh/vWAbIc1KSRcyf9eoUt89i5UdUbXdlxJgfmaNKX3laOfV50wvu51EgfbNooFCdUjIdaLoyYpBMq0iuE67XZwB3SmOajIAIre8OV0XngfcgF0LV+x2jusrHcXo5Ahl3JOpdbKGa2N4y98rPY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724c8a50-8028-4622-650e-08d67c7192d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 11:47:33.4744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2619
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

Fix this by introducing IOMMU domain states attached, detached,
and free. Then only issuing the IOMMU pages invalidate command when
domain is in attached and detached states.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu.c       | 25 ++++++++++++++++++++-----
 drivers/iommu/amd_iommu_types.h |  8 +++++++-
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 525659b88ade..1c64a26c50fb 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1248,7 +1248,14 @@ static void __domain_flush_pages(struct protection_d=
omain *domain,
 	build_inv_iommu_pages(&cmd, address, size, domain->id, pde);
=20
 	for (i =3D 0; i < amd_iommu_get_num_iommus(); ++i) {
-		if (!domain->dev_iommu[i])
+		/*
+		 * We issue the command only when the domain is
+		 * in ATTACHED and DETACHED state. This is required
+		 * since VFIO detaches all devices from the group
+		 * before invalidating IOMMU pages. Please see
+		 * vfio_iommu_type1_detach_group().
+		 */
+		if (domain->dev_iommu[i] =3D=3D IOMMU_DOMAIN_STATE_FREE)
 			continue;
=20
 		/*
@@ -1292,7 +1299,8 @@ static void domain_flush_complete(struct protection_d=
omain *domain)
 	int i;
=20
 	for (i =3D 0; i < amd_iommu_get_num_iommus(); ++i) {
-		if (domain && !domain->dev_iommu[i])
+		if (domain &&
+		    domain->dev_iommu[i] < IOMMU_DOMAIN_STATE_ATTACHED)
 			continue;
=20
 		/*
@@ -1978,8 +1986,11 @@ static void do_attach(struct iommu_dev_data *dev_dat=
a,
 	list_add(&dev_data->list, &domain->dev_list);
=20
 	/* Do reference counting */
-	domain->dev_iommu[iommu->index] +=3D 1;
-	domain->dev_cnt                 +=3D 1;
+	if (domain->dev_iommu[iommu->index] < IOMMU_DOMAIN_STATE_ATTACHED)
+		domain->dev_iommu[iommu->index] =3D IOMMU_DOMAIN_STATE_ATTACHED;
+	else
+		domain->dev_iommu[iommu->index] +=3D 1;
+	domain->dev_cnt +=3D 1;
=20
 	/* Update device table */
 	set_dte_entry(dev_data->devid, domain, ats, dev_data->iommu_v2);
@@ -2904,6 +2915,7 @@ static int protection_domain_init(struct protection_d=
omain *domain)
=20
 static struct protection_domain *protection_domain_alloc(void)
 {
+	int i;
 	struct protection_domain *domain;
=20
 	domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
@@ -2915,6 +2927,9 @@ static struct protection_domain *protection_domain_al=
loc(void)
=20
 	add_domain_to_list(domain);
=20
+	for (i =3D 0; i < MAX_IOMMUS; i++)
+		domain->dev_iommu[i] =3D IOMMU_DOMAIN_STATE_FREE;
+
 	return domain;
=20
 out_err:
@@ -3364,7 +3379,7 @@ static int __flush_pasid(struct protection_domain *do=
main, int pasid,
 	 * prevent device TLB refill from IOMMU TLB
 	 */
 	for (i =3D 0; i < amd_iommu_get_num_iommus(); ++i) {
-		if (domain->dev_iommu[i] =3D=3D 0)
+		if (domain->dev_iommu[i] < IOMMU_DOMAIN_STATE_ATTACHED)
 			continue;
=20
 		ret =3D iommu_queue_command(amd_iommus[i], &cmd);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_type=
s.h
index eae0741f72dc..6d17cdcfa306 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -461,6 +461,12 @@ struct amd_irte_ops;
=20
 #define AMD_IOMMU_FLAG_TRANS_PRE_ENABLED      (1 << 0)
=20
+enum IOMMU_DOMAIN_STATES {
+	IOMMU_DOMAIN_STATE_FREE =3D -1,
+	IOMMU_DOMAIN_STATE_DETTACHED,
+	IOMMU_DOMAIN_STATE_ATTACHED
+};
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
@@ -480,7 +486,7 @@ struct protection_domain {
 	unsigned long flags;	/* flags to find out type of domain */
 	bool updated;		/* complete domain flush required */
 	unsigned dev_cnt;	/* devices assigned to this domain */
-	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
+	int dev_iommu[MAX_IOMMUS]; /* per-IOMMU domain state and reference count =
*/
 };
=20
 /*
--=20
2.17.1

