Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbeBAG2A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 01:28:00 -0500
Received: from mail-by2nam01on0084.outbound.protection.outlook.com ([104.47.34.84]:26796
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750998AbeBAG16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 01:27:58 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alex.williamson@redhat.com, joro@8bytes.org, jroedel@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v5] vfio/type1: Adopt fast IOTLB flush interface when unmap IOVAs
Date: Thu,  1 Feb 2018 01:27:38 -0500
Message-Id: <1517466458-3523-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [114.109.128.54]
X-ClientProxiedBy: HK2PR04CA0086.apcprd04.prod.outlook.com (10.170.154.158) To
 DM5PR12MB1737.namprd12.prod.outlook.com (10.175.89.142)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9690fec6-1487-4f2e-e3de-08d5693cee90
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1737;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1737;3:JDlpMUKDh3A4iY1+LxubCjENPR0s6LfMLienYOQaTjw9+iRC8fZWe5lIgKcjxJZq9FT8Bzb5K8kqxbojAnwtLmN0e+fSk/L6A4ce7UXpGNmxcDUOGL5aYvBO9EKmxwlWYBiXTQkme3Kduiilvw/wZKOrr2KPx3SKbhQs+CzmTzBYGHEBAB/PEz+XZ1pHUU5t6JpWPl8FGyzgs0e8k/a8uoKLGagUR/ZTxWYkzd5dWn/VzFbRvFmN48uOqUnXg2zW;25:uorai1oBbktzOh8QSRkHfRIVi1g6rhYYbYnLllwxfQstlfYkrnoZptlcCVQ9pGg31YhwdkGcgomYVfM3xuwH43F9m6iv0xperUY/63D5RvxqrWJUzHvW4MHcLRJaUMQTcMHleo2B+H4tGyGfX8AJDjY3XgzLpZcAnGJ4t8X42O2JUYnSGPTFn/fElV0e7gSxp3R07QT5DnmH4JCMMc4D2sC6nvAk/xtqrIGGAEzzNm1PQutT5ZPWJy3Nq/fB1g0LDtQr3GX+hDUXaPqzTg+LCGrEu+p0K0hLpKu5Gusr1P1Chokn3aj/ZhlnLrCkkYN2RkfpUgNr3xjsjt2jHgLbng==;31:KTqSnaOaSVaCKnvVIOHhwAiNgGB/+PCve0jbsmTc6/qkzzzLbFJ/t8h//nQtPR10BLruyBiVyYigRV6LStJp0fW9dyB2hY9kAbr6Hn/eyr2VjaXNPylrwAbFOpimq85ZRNIkt5BOk9Ndq+o3Y84X5TKXBJMxnsqfjOidFUUhqnOZ8NlemZKz6+A4HBuC1m7Ro9Xh/U/GGvOB7RLjyxFYyLcbrfq10rOKX0UamjrqUBk=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1737:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1737;20:MC4fGBYz/fQY7g3lDlHojiBIItBgVgNUkuLg2yLN8EkLPYHEUzYGjYnTViaEBI7OVN6rQ/vmPOZX8RBblXI/XmQ14jo+Z79fAosRqJu6uzCJs354A53uxeQyijK0UHVnlo/8FwvdEV3BHuqm28bqzfDs7cuxaOAw0PbgWMET+Ek6pLxDLBgAM3QxeUmuSApHF90y1Q1iOo1wC73oUOnpxh+aLqhwq/C4vnKkhPxlmMbtWXP7HKNsUQp0M8HcsocEHiNZPiP8wkWPCaANpm5N5cz623+ODCe3EAIibt8obQS+vClhyHF116TcCOxCc7kA95K2lHTvzneO2hBwhEYZ9m/YiQsjwBFvLnB0i8VDrnkb7F7g6TdKpe8GSjvoRypCzWcGSPeFiOJIZb4Xw2PCNXjj4UlKQjUKv0hwWy+6YYNtwdmn00fw2Gq/3iCN1d+SkMNUukij+dVTJWk8jHTKyVj0O4OW5RFFfJ80AJ21nyZT0xY+f2peu7OV3oQGdxCW;4:QfRIz7N6nu648prTOky9HpLfPIo+C7QXvKbmwoTJKtRshR194nL6KowZe6ZCj1AmxkgZW6eKRlnRVH6+LAFyr5iWhmITttVeB7Clw03JC4bKQ2cntjR7PYhkbj1uC3V3FlzkMJR78Q/ZVxc7Yx0P1vkzoix/3jlnJ8xKjXiRUOSJ1p3seiLY5M195akj4U1rPVDTOGzPVVYC8XD2QcsfhUtPJ0nbcg9ZnD11D6Es5JZxvA5UtLdP+l84iPYcaOrtDPC6Y/ubwI4mpPh2eAjRbT3WHW0C6Wx9vRuoybq8/KPGmdj5Jtv/zaKWJjZymVAV
X-Microsoft-Antispam-PRVS: <DM5PR12MB1737DF750B8B059B20401B16F3FA0@DM5PR12MB1737.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1737;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1737;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(366004)(346002)(376002)(396003)(189003)(199004)(81166006)(25786009)(2906002)(386003)(47776003)(305945005)(6666003)(72206003)(478600001)(59450400001)(16586007)(66066001)(7736002)(6506007)(6116002)(3846002)(316002)(4326008)(52116002)(5660300001)(51416003)(4720700003)(186003)(86362001)(68736007)(26005)(53936002)(97736004)(50226002)(6486002)(8936002)(81156014)(6512007)(106356001)(48376002)(105586002)(36756003)(50466002)(6306002)(16526019)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1737;H:ssuthiku-rhel74.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB1737;23:zeO5Ri3GdwdKvowwftb75n0hPA4Uz36xos+eeHDVs?=
 =?us-ascii?Q?vCi3CyZiLm2n+DymNV5GF98JgJl7ePwKB2NMBWVuDyYmX0BlVHUVmZ48DQKe?=
 =?us-ascii?Q?SGZZSuBamoNg6YyPuASrDqlB62oPkx9g94je6TSW1nWHR7XIRf+oAd/tYpGd?=
 =?us-ascii?Q?Ldc9ocJ6Mqz+4rSMSag3c0PkjG4C2ihqPF4BCjK6Y7m0UxpgIgjcS3oJiiFx?=
 =?us-ascii?Q?kiFpf7VVcL4OUPIEDUtpQF218fWdoit9O9Y/wDJfWjGg/oCoSFS9P7sJ+Elw?=
 =?us-ascii?Q?Zjoixd8MvxACVaI7Jj9z8zKGgmYePr9UOn0h+fjWDI3B+3WhB3+XwqtwRHZN?=
 =?us-ascii?Q?uBX44VogcKT5/4RjsTO4zARdBnfBkK1AjJMomnIRfHWODvKud67OErOXqHsZ?=
 =?us-ascii?Q?GiBAoeQKdakKLS1o+h0nXWcQULipMx/npOeK3AI+PpG55nB55JTsJ12/4mru?=
 =?us-ascii?Q?UbwKw/ydFI6UH+w55JhzXI43r+jWNdzOdL4EUyQhzGsS2t0spM5BbupHJ7da?=
 =?us-ascii?Q?XbGRIPC1/nxaghtZH7XnIVoh2zIlbDnskn29ggQW/OFn9MyUXqajbVprSJNe?=
 =?us-ascii?Q?RnQ8A3chiY9y7kLSv/C2n7So15DXWh1+34yOAuBiP0kDN/DFdv1fdYNp+RyC?=
 =?us-ascii?Q?rm/Ua+jb9x1QJEyjuhGMNMKVLELmHX/X2FGeODYhM8NKSKZ9fJcC4zwKGOQL?=
 =?us-ascii?Q?LKgX/hZ5DGwdu9Mz3YFdMk3yGUZixguw/CtKRNDnwDCv4lJprw7ejCPJd5s4?=
 =?us-ascii?Q?k9PYdmPLE8gAAYdVj4HiXOidTCo3RgEl1rXSzPko5IXE49u2gyGfWekFZsjz?=
 =?us-ascii?Q?s7kQAvxVPj2/+vOfAhYfLm1X3kSuvHESsgpGf+GhL/LOEID6xOX7g99jhUg2?=
 =?us-ascii?Q?K/l6b6eqJ6XJtOhx22Nkpqd++1tDwQYdanBc2Oblk2ENzV4Mz7L0r7zL5qt7?=
 =?us-ascii?Q?vf5CUD4Qu5hqpJXWAuNBYNpgZnmnyKa/6kmIVBofB43nGqQ1XBu8Nm1W8XbO?=
 =?us-ascii?Q?R02BhxaDvDJuaJrOrtIbnzp4Zw7x31mMdSURP6cQXxU8Cuo4PiXYsOj3DfwI?=
 =?us-ascii?Q?4/tLsm7wwlSDnnfvzkVZ4MkavHFk3S1KjPbh65Kj/n5Mux+1tXxV4ukA0IJf?=
 =?us-ascii?Q?V0vOR2wn7A=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1737;6:q6/ufsrR+PsOcwtMS6a09lnULCKKm8USC4yGqZk3w3lHt+/iISd+nxtFNOUHiGNTL1m9ZndzH4iGSeATZ/wvpwZAeZQAFZ6dXYgNQiOV65vAlldYr5A+JMLfKn00GZEe4q2H+elLMfvkVCA8M1UGD1gSIYNnZneVDEPmX1f4fffJz1Cv8Jdf+mFP+/q/z9xlFciTqermdGg/tAERg9l9DWhR8icSrxltxSKnsP0fXcVEz5ySJJtXhY5Aq3EVfsLYssUqVQOkA8j8AjL875/mA7PCX9kaVF/aH7klp3I0VEH8+MrJ6miqAtbyW9y3GjdwJUQh/vUiJ+hz8cctmKZ4QOkyxBncknn2ZU9lHlQMhDE=;5:Fbs/X7HqQqn4g89Ed/GJ8WxsE5bMHqwktDkbfZJag5dTbxLRfS6L1AdPR/ewsGmff+XUEuNkn5nnfoKtpO1ALnXcC+vty56T+Da7uyhvXlEizlyt0kCPekmF1ZMTdf/xDL6v1w+3RVQreRqJh0khJTzhIiD8EXmV8GEg6XSiitw=;24:5v7zLO9FRHfWFIaa3889/WiLHcGBktt06pVAP3DfJsta5mfxIk0qxq012Zpb4EPDea+Q3jNkodMIkYCXzqxqLBaAI4FxwSUCey2ynmFwHK8=;7:xpHVfKGCnQrUtWvGqNPy9XlvJyOJgh0PGCswOwfZlEFxDA+VbRfeHtSDM2Ozee0Du7UmsfjXFwlrgerAIFBXMgpOnCoKc/WQYN2MUHbkGaBsojOeogXOSI16oqJW0Ta3YbwJx26OZUwKeryjhzSJDWK7MgkhNpV8ElYY9Uw9j8Vsf1+6t9zqod2PEFlYFtYFJZdHQYli/eT92ksSKgCd2UGsyDFfiMV63fyHTL1OcuLp0BTtYXCgXR8iFKJpJcvn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1737;20:SAMlbgjekszx3ufwl1yHB8SJTZJtxKCWuqUEByZGFTiM8GRoLxtlZRBxW9rHMv+7hREA8MwDzuxYwwngc6UCba4t8PYYn0xi69PaNbBp31EwEN+fp34JlsvVUJNFy7qoSycbmIUMvC7iaC66iS3cAEFJRa/95YgrCWmn7PySLuI2X9HBTmkH0HWciYV1OP8BquYVXRZ4Kp4PkmVvWC3z7lBbHt7OScgVIcP/mx815kxA21FFFWxJmZPU8B7CIcDO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 06:27:54.0314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9690fec6-1487-4f2e-e3de-08d5693cee90
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1737
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VFIO IOMMU type1 currently upmaps IOVA pages synchronously, which requires
IOTLB flushing for every unmapping. This results in large IOTLB flushing
overhead when handling pass-through devices has a large number of mapped
IOVAs. This can be avoided by using the new IOTLB flushing interface.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---

Changes from v4 (https://lkml.org/lkml/2018/1/31/153)
 * Change return type from ssize_t back to size_t since we no longer
   changing IOMMU API. Also update error handling logic accordingly.
 * In unmap_unpin_fast(), also sync when failing to allocate entry.
 * Some code restructuring and variable renaming.

 drivers/vfio/vfio_iommu_type1.c | 128 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 117 insertions(+), 11 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index e30e29a..6041530 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -102,6 +102,13 @@ struct vfio_pfn {
 	atomic_t		ref_count;
 };
 
+struct vfio_regions {
+	struct list_head list;
+	dma_addr_t iova;
+	phys_addr_t phys;
+	size_t len;
+};
+
 #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
 					(!list_empty(&iommu->domain_list))
 
@@ -648,11 +655,102 @@ static int vfio_iommu_type1_unpin_pages(void *iommu_data,
 	return i > npage ? npage : (i > 0 ? i : -EINVAL);
 }
 
+static long vfio_sync_unpin(struct vfio_dma *dma, struct vfio_domain *domain,
+				struct list_head *regions)
+{
+	long unlocked = 0;
+	struct vfio_regions *entry, *next;
+
+	iommu_tlb_sync(domain->domain);
+
+	list_for_each_entry_safe(entry, next, regions, list) {
+		unlocked += vfio_unpin_pages_remote(dma,
+						    entry->iova,
+						    entry->phys >> PAGE_SHIFT,
+						    entry->len >> PAGE_SHIFT,
+						    false);
+		list_del(&entry->list);
+		kfree(entry);
+	}
+
+	cond_resched();
+
+	return unlocked;
+}
+
+/*
+ * Generally, VFIO needs to unpin remote pages after each IOTLB flush.
+ * Therefore, when using IOTLB flush sync interface, VFIO need to keep track
+ * of these regions (currently using a list).
+ *
+ * This value specifies maximum number of regions for each IOTLB flush sync.
+ */
+#define VFIO_IOMMU_TLB_SYNC_MAX		512
+
+static size_t unmap_unpin_fast(struct vfio_domain *domain,
+			       struct vfio_dma *dma, dma_addr_t *iova,
+			       size_t len, phys_addr_t phys, long *unlocked,
+			       struct list_head *unmapped_list,
+			       int *unmapped_cnt)
+{
+	size_t unmapped = 0;
+	struct vfio_regions *entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+
+	if (entry) {
+		unmapped = iommu_unmap_fast(domain->domain, *iova, len);
+
+		if (!unmapped) {
+			kfree(entry);
+		} else {
+			iommu_tlb_range_add(domain->domain, *iova, unmapped);
+			entry->iova = *iova;
+			entry->phys = phys;
+			entry->len  = unmapped;
+			list_add_tail(&entry->list, unmapped_list);
+
+			*iova += unmapped;
+			(*unmapped_cnt)++;
+		}
+	}
+
+	/*
+	 * Sync if the number of fast-unmap regions hits the limit
+	 * or in case of errors.
+	 */
+	if (*unmapped_cnt >= VFIO_IOMMU_TLB_SYNC_MAX || !unmapped) {
+		*unlocked += vfio_sync_unpin(dma, domain,
+					     unmapped_list);
+		*unmapped_cnt = 0;
+	}
+
+	return unmapped;
+}
+
+static size_t unmap_unpin_slow(struct vfio_domain *domain,
+			       struct vfio_dma *dma, dma_addr_t *iova,
+			       size_t len, phys_addr_t phys,
+			       long *unlocked)
+{
+	size_t unmapped = iommu_unmap(domain->domain, *iova, len);
+
+	if (unmapped) {
+		*unlocked += vfio_unpin_pages_remote(dma, *iova,
+						     phys >> PAGE_SHIFT,
+						     unmapped >> PAGE_SHIFT,
+						     false);
+		*iova += unmapped;
+		cond_resched();
+	}
+	return unmapped;
+}
+
 static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 			     bool do_accounting)
 {
 	dma_addr_t iova = dma->iova, end = dma->iova + dma->size;
 	struct vfio_domain *domain, *d;
+	struct list_head unmapped_region_list;
+	int unmapped_region_cnt = 0;
 	long unlocked = 0;
 
 	if (!dma->size)
@@ -661,6 +759,8 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu))
 		return 0;
 
+	INIT_LIST_HEAD(&unmapped_region_list);
+
 	/*
 	 * We use the IOMMU to track the physical addresses, otherwise we'd
 	 * need a much more complicated tracking system.  Unfortunately that
@@ -698,20 +798,26 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 				break;
 		}
 
-		unmapped = iommu_unmap(domain->domain, iova, len);
-		if (WARN_ON(!unmapped))
-			break;
-
-		unlocked += vfio_unpin_pages_remote(dma, iova,
-						    phys >> PAGE_SHIFT,
-						    unmapped >> PAGE_SHIFT,
-						    false);
-		iova += unmapped;
-
-		cond_resched();
+		/*
+		 * First, try to use fast unmap/unpin. In case of failure,
+		 * switch to slow unmap/unpin path.
+		 */
+		unmapped = unmap_unpin_fast(domain, dma, &iova, len, phys,
+					    &unlocked, &unmapped_region_list,
+					    &unmapped_region_cnt);
+		if (!unmapped) {
+			unmapped = unmap_unpin_slow(domain, dma, &iova, len,
+						    phys, &unlocked);
+			if (WARN_ON(!unmapped))
+				break;
+		}
 	}
 
 	dma->iommu_mapped = false;
+
+	if (unmapped_region_cnt)
+		unlocked += vfio_sync_unpin(dma, domain, &unmapped_region_list);
+
 	if (do_accounting) {
 		vfio_lock_acct(dma->task, -unlocked, NULL);
 		return 0;
-- 
1.8.3.1
