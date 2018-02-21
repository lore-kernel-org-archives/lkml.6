Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeBUHUM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 02:20:12 -0500
Received: from mail-bn3nam01on0081.outbound.protection.outlook.com ([104.47.33.81]:43744
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750738AbeBUHUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 02:20:10 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, jroedel@suse.de, alex.williamson@redhat.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4] iommu/amd: Add support for fast IOTLB flushing
Date: Wed, 21 Feb 2018 14:19:45 +0700
Message-Id: <1519197585-10546-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [114.109.128.54]
X-ClientProxiedBy: HK2PR02CA0204.apcprd02.prod.outlook.com
 (2603:1096:201:20::16) To CY4PR12MB1733.namprd12.prod.outlook.com
 (2603:10b6:903:121::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16e3ab23-6f11-4f9e-d5d4-08d578fb88ae
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1733;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1733;3:EAgVbuymUKTRWMQCdyKPMx0dy1iAYlAt0Bqbttd/Lgx6b/zNZr0uiV2gSl1NQtS00+z4OvkXdys2pzZbDzddeYopYqIS+/ovLMN6IaUiGfX1g4y2q+Qw4z+OCCoQJr+9gjo0a77gAXn2mW9RhmPRa0NXe1QHv14Y6C4xMnFHEcaOwzAqxcHIE6SbGbRuX5pqRftpeP+J4JB/JcMD19lTF16EqDCgk57jLdzCeJrQS7JjhqQQSkxNFj70K9X7bv49;25:f0Pri1WXGYCl+YnqTzY0kOxsgQ6jB5gRyERN684eAoLI1Ez1VYntcIjPCwdjN8At6pGS66g4Hsucwu9dQ+t4bm9UBD2ltdePPnPlO/8Jwggcn8c3ov3EwvsqDInlaTG73pJzCp3lWBzkJ9V5lwqR4xQGm6AQXCtOhMiW96d6PPTfCjF8mrGQUGP5t3F9eOU0BY5Snp3qdvOZngT/xdaNCER33mUD4z8XfRLCQy0L4/CcVEm8SZqXWrYhHvdu+qLhTXCpNF8Tkb8NtRbTPBRBlpRjjOP4OfoZ3UGn6RbHHF4yi8HaKcNE1KOshhdZ86b2pIraEK1lJnC2t42SVQLFEg==;31:74reG2GTVxgcQOKjdOqt3W3WNwYyOkfKo7+k7ckmbXUp5EgP8yVaZf4XJhNsO12kExov3tfQI4pblS30e3B8uC32cgrXQstclXiIQ9H16Lyom/9Qd9M7RfxGbVXpGjYXeE7DDrI+HdxhSfo4kJZ9qLb5ljPCwSxLDr3+SRzfrCUwx5mK+Rq98xpuBcbUYBDnbUKa7bvp0X51+SowfJdPuPrwKA6eEO9xI3RAkePfcg8=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1733:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1733;20:J0uVNsbvWGbsVPDvHEcWREfbfOqslurTdXW70KDcwavZ/EQ+9QUk7t2lesbbfAOgZYhsTPYTmSgRw0FkK0CY6y/0YMvHlm/aYhsn3k4JZsn279WeBPKDV9ZH4TaISw73BbW/UZzrpXqNf+npNknlHV05jW7eDwbse4dtEDMph2JCPBS4B9L1qcYjaNgqgmNsfQRHBZb5cCeZqwqoOOfDb1hvfWZX1x/qIwG3q1GyQeRg10adSa9uvrELUzCP15QNbP0/eCbmCREb26G4Bhk1Y513RXPHvBYY3UFyIEBKg0WWS6BngYHulAEIdHUHZkx01Djsj0eoIk6aXSfWCeT78EwnTkgGOtzrv6Cez0eZPlBUcB1rcyLC2askw5qp0Bj4fPkiyUP7j7E7krqJazOA+dwItP1rRIrOeeYNE65zU86yZqLYtaLD+Ya+ZlRWt5Qc1m6HjHMiEpi2YA6/vQFuvJBGj2Vv10o/DMobA+jnGKEAAPmMlRCREgzlwhxDN9hH;4:tqFWK6sgzQsFdcYDaVfMu/oQP8+8vMj0xONpS9YL5jAiz8xXo1Q1Y90+3tCd6a5rWRlzZfoWwKCNT329o+12+wUR0UM+Pa4qtXXgbRbbt7X5KlkGxOWrT/N774eXzgVUZqfkiWKVsrl3KsCwpXtaMjPCx1Vm1Mzc/xfmeN6mROZP3dsz+5VPxgTupkCB6Quo7n85X3pOoqLxwV2HsbrjDFq1BGX7rSpylq9IURKrqN6hnxuHsXpHSjDIU/bjXifi9BFFAPNgXaPSn+LGPzQPvOn3TUmMlcrlWcBJW7Tzcr9ROdAnRgUNDAaAMtDxtigk
X-Microsoft-Antispam-PRVS: <CY4PR12MB1733B0CD039F328E8BD219EEF3CE0@CY4PR12MB1733.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001064)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231101)(944501161)(10201501046)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR12MB1733;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1733;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39380400002)(39860400002)(396003)(346002)(189003)(199004)(6486002)(47776003)(66066001)(68736007)(97736004)(6512007)(6306002)(4720700003)(53936002)(305945005)(316002)(386003)(36756003)(16586007)(6506007)(59450400001)(26005)(2906002)(48376002)(50466002)(186003)(16526019)(106356001)(7736002)(105586002)(3846002)(6116002)(50226002)(8936002)(81156014)(8676002)(81166006)(5660300001)(86362001)(25786009)(72206003)(4326008)(478600001)(51416003)(52116002)(5890100001)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1733;H:ssuthiku-rhel75-zp.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR12MB1733;23:V9YwG6BlWmJHr7dLQINoXV6yOnnuwPpGThQ2bmuP3?=
 =?us-ascii?Q?wptZ8nBfy9bgg+lBLd/Yiki6PEYjdQYbNj9jAdGpcZb9C+weNtt0ecOE7fY2?=
 =?us-ascii?Q?wkOLji5EU4ySBbaHj/phg8xQutqZnu7AR5ig6CLwg2r1po+Gl3Ko6bReiSf/?=
 =?us-ascii?Q?uQEWZtkUuq5+4JJal2qx6CLqIfJmzGDJt9wB9onld/ZsEq/SUNKO8GtjKi66?=
 =?us-ascii?Q?wKN/LuZvCjFjI5IWr+Bx1CvwV4RnGCneefTmfIAhc1S0/hzow04nsqEc1DSV?=
 =?us-ascii?Q?xXnqi+PVwdZfXansY5Bt7tZLYLBmT4oMhTPbZZxkAUFTe1nW+5OZ05GrYE6J?=
 =?us-ascii?Q?ooBhtrv+6yWKUrfguUPJus0+XTZ7C7SSW/Y7YqlsL7jW4jnNEOfpkjIF/IU+?=
 =?us-ascii?Q?DvA2KeHou8AFpN6eCBffS69D29ihT/nvVsf0zsJonjlIRDAmnqfRnLXcXY+s?=
 =?us-ascii?Q?DXo69TPA+VH14fNEzwmODmb1v2+JSt9nmAhupYw7kjg+ePgSpbAKwmK6xKZI?=
 =?us-ascii?Q?NLRJTQyedmGR1D9OljZMx7clU0CncdipW4D0W8FtJXqQdP5p/lLMW/17ewrV?=
 =?us-ascii?Q?vJ9PsEWfIwjkqTIjlKsjULrEQ5g2/VKntXJoQx4LaljQP/asS0fxpd1Wl3sM?=
 =?us-ascii?Q?/rkPo4EN3YIsr1yTay4MZZTPw/xrcPeYThdovUYc9SyPLleh9YY2Yqh+ptcn?=
 =?us-ascii?Q?/oHstv46rMOHFamLaRRmSBtXus0HPlrDT1P0d6bq9tCpuLYzTnx7b3P0BNPu?=
 =?us-ascii?Q?W6cWAzy24Ne5tOLPg8UYlddxrr2FE2TPlS68kdJokhISFw4REtU0cwOjqzxx?=
 =?us-ascii?Q?lPlYL+1TP78skzkbU2zqCWINue7DBP/C9pVirEiZb3M+PCdELXnxEk9iJfht?=
 =?us-ascii?Q?AGB4yGtgeR2aEU6jgrQkbu+AZK8bEv5STiftG5+vI/I0TC4l82DGlujeA2Km?=
 =?us-ascii?Q?XjESbfmxmKdQDUid1/3CQ3csAwBh3xEZqzzg+VAE99i9aD80RsYSOJiZw1V7?=
 =?us-ascii?Q?/naYf0YqOy/Fb6QghO42jm5rQYTZyfOj8BSSG7Fy+FWUX0plNfgHv3Q3lk+E?=
 =?us-ascii?Q?MdPdVGBr4KXz5X7p8NqyTz+SxEK63thSpEEgy04RYUDTOdqQ+BbhwRUGclGk?=
 =?us-ascii?Q?awKq3PhY4eeMWjgj6qws9EpOJfB3QsiqibFWtTcls7//vzTZK6prQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1733;6:Y0i7jqsxr8UbeP2L+pOZ1xUtsWXEXcSt8Kz20Nv5Qe90wOwdfSjvN98FJWQQvIkHVqFExojo+/tO277Mcb12aQUgZow9UY8Pactlnbo9ya/kTMRRLrRVg1pZkDLKKOMt/c32TJa9zW0CfVPImnrNLeNWIjMz+9QDOcsQgP7pHnH7uK0B2dmNrUg4j9Tt7mhpnovguQBDGVJMj+qyP4MuUdTmMzFVxsS/vwtI9GjkCZ5xcCBgkEHcY+XfTUx7xdVD4VCpRVr5RfYBiy1K0TduzeSGCUdMPWL8quyFKGkt2EQ4FdgeARkMqkknp0BPQUxatnX4UlxZQyhvqUpv/Hc7n/vkfwDN0Oo6if+HyENn73M=;5:gjkjG2KO4NxEv/OB33vZmnI6kBITgU1TSgwWnMY8qDGPKNUOq9W73/rrk6hcRABXvkEbcZcIEO3c8kDcWsWjJgaziR0oc0KAaFWOTESZbdn+64SD9ktM5QxNJQCwCYYzFDvcaDqIIEx27K0WEZCrEDGZCtU8tJVllN83b5hET2o=;24:kVXf04uCHZDRRaYUkuU2iyEBPb7Y+x6fssNXXXJQqgLpUq4gJ1Vm3d4FWPZCd4izjJamtND7kbSGaP/XKpbLm+X9ZNK2W1+pE3eVeMHjFUc=;7:p6CDcjIjtCe1mYPl4yRultClSz+7F0XyyC+obaVoVC4sJ4RIuLX452rMeLLYmQ182KDks5IQVkc3ytaBPy8b+nyEs4mu6ycaOCkidUIbyq/t7uH/EkxhB2hMxMvTnzHXVzm8dbBgN8D37YTxlqIrq8XgyJG7E/oa2G/9BgEEtR+cCS2OShEinnIQoiiJywqDiztAz7Lv/kl3K/BXBLsIqzGO3lxsxEgpg+7cJGKowatiiSPJcmvDyq79A8Qm5EjE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1733;20:hJ98wnPjp1siNmpaiFAfhvxpQY568UGheR/8YVnwSdL0M8WKoRJ/nweFeyVzZHyP1JAXDnhnp7V5g1p8ZrokZitZOUXiIph9tNC8KY/P/rC5eDKT7XRrIqheGuq5hm11AXs8sLVR7VqH1ayY8wCE4hzt9h45YXrOsGZLc2uaZDf2r2rVSNL6+fOWBvE3Qy+J7gKcOcJ0U2bJWnzkzyp9H2uej7Aqx3JZnxInbC3zOydYYas6rj1gsYtRVuKe8/Rn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 07:20:04.6358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e3ab23-6f11-4f9e-d5d4-08d578fb88ae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1733
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since AMD IOMMU driver currently flushes all TLB entries
when page size is more than one, use the same interface
for both iommu_ops.flush_iotlb_all() and iommu_ops.iotlb_sync().

Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
Changes from v3 (https://patchwork.kernel.org/patch/10193235)
 * Change amd_iommu_iotlb_range_add() to no-op and iotlb_sync()
   to full domain flush for now since we currently flush all entries
   when the page size is more than one.
 * Fine-grained invalidation will be introduced in subsequent
   patch series.

 drivers/iommu/amd_iommu.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index fed8059..6061a8d 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3043,9 +3043,6 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 	unmap_size = iommu_unmap_page(domain, iova, page_size);
 	mutex_unlock(&domain->api_lock);
 
-	domain_flush_tlb_pde(domain);
-	domain_flush_complete(domain);
-
 	return unmap_size;
 }
 
@@ -3163,6 +3160,19 @@ static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
 	return dev_data->defer_attach;
 }
 
+static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct protection_domain *dom = to_pdomain(domain);
+
+	domain_flush_tlb_pde(dom);
+	domain_flush_complete(dom);
+}
+
+static void amd_iommu_iotlb_range_add(struct iommu_domain *domain,
+				      unsigned long iova, size_t size)
+{
+}
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
@@ -3181,6 +3191,9 @@ static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
 	.apply_resv_region = amd_iommu_apply_resv_region,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
+	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
+	.iotlb_range_add = amd_iommu_iotlb_range_add,
+	.iotlb_sync = amd_iommu_flush_iotlb_all,
 };
 
 /*****************************************************************************
-- 
1.8.3.1
