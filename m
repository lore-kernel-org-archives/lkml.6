Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeAaJqM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:46:12 -0500
Received: from mail-co1nam03on0076.outbound.protection.outlook.com ([104.47.40.76]:19328
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751435AbeAaJqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:46:07 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alex.williamson@redhat.com, joro@8bytes.org, jroedel@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4] vfio/type1: Adopt fast IOTLB flush interface when unmap IOVAs
Date: Wed, 31 Jan 2018 04:45:46 -0500
Message-Id: <1517391946-7830-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [114.109.128.54]
X-ClientProxiedBy: HK2PR02CA0196.apcprd02.prod.outlook.com (10.171.31.32) To
 CY4PR12MB1733.namprd12.prod.outlook.com (10.175.62.143)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 17451368-67fe-484c-89dd-08d5688f723d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1733;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1733;3:vaS0BdAdsO4oERmTNL0aqSYWioKTqV/FS2Z7H8jFfx0/eo4Z526pLSWh4XPpCuGm+qCjD/y3u8wgSNQCDp0hgZnbHSQdzYKELanzo5G5lJhRCccr7Lwo6xYIK+vByWQ3Skrl5r19kKb9SVacp7o3lj52a8LCeKwp3EtTm0/BuEoZ9mieDoF0FnrOi00YZfEJEZ0MUMZLcVi9jW/Kax4VVChzUku0GhCKU7fo7ovvv54CIqlcihOxWeXqpq7lVrOM;25:Yz3Yzh5OnFDMkwhY8fnhFCoapOSOgX8/twhQDE7fGMldNUvSyBnt6O49XYWeI6t8askIGwdhG7kunNZzhR6O7lMeVkSMIRxB4YA6T85ZMY65qU9V8tBEg1r0pVZisivMxdKexw11NPfpPAnL4LjFkzlk3uxwWFvx3Lgmfs5lOIoac237/tS8tZ+2c7E8Wn+N2vpJF+liyguSj+GvfdlGBl2u/adgGYPV3Qao8bPPEwgVvBwOam87FFxdnL61JJsxZmgG+KUfEp4eOWPECRPGIC70rWlqK1uL0CJ8S4DEpUXk3Eidxc4fADmiJ+Dz5Jwrg2uYsfqerwhXI46iOjUd/A==;31:OFvL8IqGx79h3ZOGAvQs6v/eUJIqPySknnCW205E6uxIwYb/Am2sQnHaaRMYMTXIPg7a0iUy6zH0D12SofKI85uBC64rFHAe8lSaTuAnmH8jYN1dVMH8RYcwOIefyGqQq2LuqnbWP2JH2tTrFr+lcYqtFBotNqtcxzn9w+6cfiIm2eSZxkF0TyHDaNy8OsL5AFL51+qKx6Thxqqx0tvdlBw9lBT2LDo8DkBiKKKbEtg=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1733:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1733;20:ybjvy0pIBFvW/Fm+yhLK5lrLv3FZ4gQV6JCm0mBv+LkfPkb4GThwTvEcOhI2RAZGPyj/03Ov6Kef2I/JYvI6YIOkh+VHd87PY59vL79qRcaZ1C4ZQCxU66nSZtVnLonL3PpWMF95OGeRtmLZx2ushMFT1tis5V6mD0cRaJvvJVY+TaLpa9oZi1lBXiqXcaacHmd7Oz7T6kgUE7YS4qWCOzAbpvhmdNn6qg1Vo41zB09wfFO6uC3auWTwm33YCGbFR/WMbgzCpNq/LtcxGhAm4Itrv8u9ZtR3sqSGEEnuZRRfZGULTA5OWbFg3Ag8anckyItEDFhq3Z17ZrlyW5R0p+SankoO1OpjHBG9G2WoWxclI3NsRPAzdrcAiUiCqQaPPZKUCx6OqACPw2QLExcacgvdTWhgB6YKhgrayn8ElSmlTonYraHwbq8RFr3SaPDSTG4o/LX0b6y+ICodlmJBFzqPEEp3rJ0fLzI5DF6NrzZw3xgTTO01d+N4bPdfugWW;4:teIOB8PRXbAPqi7Qay4JOvqgbFaMVA3CE7KPUvKCGXvOQzJgPGmXrVjviyYRWBcEJ2gm3jos7E3cv3+L5dTcf0xOIvYCOkEKT20GCx7pSgu3V3kkbAo1B8A5VSM1yVioMFhxmbBdvqEpBedtnUbQTkHF6HajzYQx601/RSIAZ4iGAimxarbZffC22lp1sqdPz4IDa8EaSR6F+aWDegoP5QsGKbJEsDBMHSwx+Ym39/HTg2YavhPtai4J+bQgOdPThVatPOBTc+EuYdDrmQxByvDjaLlIDVNfEP9JJx9uYIvf8qEWQeqswiVc5tMa5NMP
X-Microsoft-Antispam-PRVS: <CY4PR12MB173339AF97A028E98B0DA089F3FB0@CY4PR12MB1733.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(3002001)(6055026)(6041288)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR12MB1733;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1733;
X-Forefront-PRVS: 056929CBB8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(366004)(39860400002)(396003)(346002)(189003)(199004)(106356001)(53936002)(36756003)(97736004)(86362001)(52116002)(51416003)(59450400001)(47776003)(316002)(50466002)(6506007)(26005)(4720700003)(386003)(6512007)(6306002)(66066001)(6666003)(4326008)(186003)(8936002)(16526019)(305945005)(7736002)(6486002)(16586007)(25786009)(2906002)(5660300001)(48376002)(81166006)(81156014)(8676002)(478600001)(105586002)(50226002)(3846002)(68736007)(6116002)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1733;H:ssuthiku-rhel74.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR12MB1733;23:ddI6S4wAZ70A0ZjGsCRepXBkzkFc5xjTPF59NzGI2?=
 =?us-ascii?Q?RleR6GFZMEGYgkWsQQfZsVSNvUgTNhWpjek0S3+qA0iLMU3RcfZvFaXs2B2G?=
 =?us-ascii?Q?Vc6XTgElqyZrIsL8JTG6dHgDe7aJzwbHYCYqmdgXZfaZQynBd3sUJKlx3wER?=
 =?us-ascii?Q?fO5fbitbtiPaUVD4V0byqOOUXjudmCPUqYrP7icaWUa+4GkvMqvH+CSxztcA?=
 =?us-ascii?Q?4l/ybz8JQmjB3q15tIVGMz7OkKAynFhQu0p3kf/ma+eq/tIA3VjeUSUBZHw1?=
 =?us-ascii?Q?Up6g7ZcJAK3szCLce1PqLQ+ejACF5OHpBLAhaJcFwnpNth2BokGRAc18trnk?=
 =?us-ascii?Q?BBCA485u2akhPnnHflZLbHulK7HGOm8ygUpAr9hfWeIwS+fUZhtsAmfz7QfP?=
 =?us-ascii?Q?3wXa2rLyt8yBfPKhw7Q7oe34MftJqt/3xkqPyYnwhvfvMyjI5WKM0+by3yta?=
 =?us-ascii?Q?DOdypW9gXizF2rJ+MuXilM9cX0idgTt4deVuqSo/iwyKVnJ41IYeiOP8qmVl?=
 =?us-ascii?Q?NJPlHDQ+DavQfVTdue0b3x7gCqSP1a1c8tutb2s4nYH3nYLgKVKmB4lkY8HT?=
 =?us-ascii?Q?r4b6OOk4rfOcwVzzZpIb4oUJfjb2Hi295Nuoq3WUJhESTb4Ii0k2YACeO3qw?=
 =?us-ascii?Q?f+AyYU1NqaNoP2kwtf0FDkumtC9OtVUGmdtlEkElyBLIWjsDXWEiBdijjHlS?=
 =?us-ascii?Q?ltTJl19E59Q77Q7oYbkSNLlDvNuILpGMYxnaNprFUTY7cEfqx7Q36BPwkS3M?=
 =?us-ascii?Q?NAGam1meqLscsCSLgi8rjN0xjDvNpOiAvnDg93rGlyGa+8kUrS74jZt2vwyw?=
 =?us-ascii?Q?43CsS47wuy4Aqdq1lAgzW54lZzaZG2ITlyawn03rtgnTxXnJeU6Ps8VIvK9S?=
 =?us-ascii?Q?CAhh0vPbSdruQo8UXy8Q4qqh3AwaPtG8sGLjVf6wbQVHXLacoV1Ay2Vg0kUn?=
 =?us-ascii?Q?zptp4EXYw7ZduFQNpfItL8z0IMFU45And90WWh182qdZsSSD2alHePAh7cI8?=
 =?us-ascii?Q?beU7wytncFsQxCM/lfNBPr7IFXSsC7y3xRO85GxjuwtSp+chPT248fd7EMEj?=
 =?us-ascii?Q?HmMzIWCyyIurKNa1s6VdaCce3h2+3rIyri4BtGALP73l6u9WN27po+CuH3Jc?=
 =?us-ascii?Q?oM3CK09IEA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1733;6:Mj7aGCaPQU0lDSf5k7icug2QfjC4ZnF6DQ+N875m5SNXmVW+UP/zy8JF921Rphpe8lU+YDtG+82fH7VoVLGNR8w9MqEJKOsrzkz6NesSuIJdY8YhSr3anQ2CnkwjeMnW1wCpMofuerVmXk9nqKNFRGg6X+XxeeJxxKwiPbh2zTHo0mdxR+cwydWYZHF5ONa3s0wsT4X/y+M6v3RnGodbqxTsBIm4Yti1MCsf7vsuRV+eyXFdwWEuGxhAxG2FZtya9vmJO4Udw57BsH7BjVt8i3gGjT2SR64NeVZz+i+qlptB9ncLHj0yH/6wCjSWowDlJSux8BGZg/+6ti0RNIPc5ecAl01i/4sgiFosWMW1sHs=;5:G11WxP6GwiN3ZaOywtxLz4DntO4og+Bhy+52xhLw8wwDmvRg/K9lnH6UMJAru8NMpgEkKSfexfBK6tJm53RwE569HDwYzy0dynJOGs/yGqjf++GDtvD9oaIPpxp9zNh/VNbAOVkC8JPjNmtgtFijaAPTab8FVzPaQI6iJq90DUQ=;24:rLiZMr9y2lWUoywVTeXLc8Ltk4fA8YrWNKS/j0939mQCafpZ5oxkv3ooMHrfveclwEq3yhT/nMsQM7t8hTw+AERdFub3rTHpN5itHmyY1uc=;7:qkKyc9iueWClx3V9zdCYSz1PehnQ9JOHl6I0qgsk7X3lzKGr2McXG/JSpyboC2RRky3ClIWY4bHonEvXcmMSOsrFtunvYwJugKzx14GZJ8jwiQD0mVUbJISrzBbZ2bfbVY5/87lRHm21LsLZpNcn8NelsWtS9pXM/4rTGtF4DHYwpHonaAt8rnxCQ86O/KkRyUuIRq73wIne4E1DAZYnnDBZN1NWFQtBiaz8jwNxq289oHrUxqVxtACq1KOJN0bA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1733;20:KtdO399vqkNQjOOZ+hTfgse0ZrbVsZNEb+A5SH6QsnuBtJc6MuMdFfxC1lOqd/cv28N1JFOo4TDoGdx0RjjWZK8n1I6FYPIA82jESzyF66KjM1p8C5ceo17KQgwZHkD1uYT35JRtEkkDGsPQqpHpsM5Orz/l4rN8M9U1kY1FjVjHFuvBKeHsifw9Nz+E8rbeAmwYtuQtfGSXJiHw0+g9TrSZ4c6e3PAOMafbaUIg8fG4P0dhLWytXdosVCcDpGwE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2018 09:46:02.6563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17451368-67fe-484c-89dd-08d5688f723d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1733
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, VFIO IOMMU type1 unmaps IOVA pages synchronously, which requires
IOTLB flush for every IOVA unmap. This results in a large number of IOTLB
flushes during initialization of pass-through devices.

This can be avoided using the asynchronous (fast) IOTLB flush interface.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---

Changes from v3 (https://lkml.org/lkml/2018/1/21/244)
 * Refactor the code to unmap_unpin_fast() and unmap_unpin_slow()
   to improve code readability.
 * Fix logic in vfio_unmap_unpin() to fallback to unmap_unpin_slow()
   only for the failing iova unmapping, and continue the next unmapping
   with the unmap_unpin_fast(). (per Alex)
 * Fix error handling in case of failing to do fast unmapping to warn
   only once.
 * Remove reference to GPU in the commit message.

 drivers/vfio/vfio_iommu_type1.c | 127 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 116 insertions(+), 11 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c580518..bec8512 100644
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
 
@@ -479,6 +486,29 @@ static long vfio_unpin_pages_remote(struct vfio_dma *dma, dma_addr_t iova,
 	return unlocked;
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
 static int vfio_pin_page_external(struct vfio_dma *dma, unsigned long vaddr,
 				  unsigned long *pfn_base, bool do_accounting)
 {
@@ -648,12 +678,78 @@ static int vfio_iommu_type1_unpin_pages(void *iommu_data,
 	return i > npage ? npage : (i > 0 ? i : -EINVAL);
 }
 
+static ssize_t unmap_unpin_slow(struct vfio_domain *domain,
+				struct vfio_dma *dma, dma_addr_t *iova,
+				size_t len, phys_addr_t phys,
+				long *unlocked)
+{
+	ssize_t unmapped = iommu_unmap(domain->domain, *iova, len);
+
+	if (unmapped <= 0)
+		return unmapped;
+
+	*unlocked += vfio_unpin_pages_remote(dma, *iova,
+					     phys >> PAGE_SHIFT,
+					     unmapped >> PAGE_SHIFT,
+					     false);
+	*iova += unmapped;
+	cond_resched();
+	return unmapped;
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
+static ssize_t unmap_unpin_fast(struct vfio_domain *domain,
+				struct vfio_dma *dma, dma_addr_t *iova,
+				size_t len, phys_addr_t phys,
+				struct list_head *unmapped_regions,
+				long *unlocked, int *cnt)
+{
+	struct vfio_regions *entry;
+	ssize_t unmapped;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	unmapped = iommu_unmap_fast(domain->domain, *iova, len);
+	if (unmapped <= 0) {
+		kfree(entry);
+	} else {
+		iommu_tlb_range_add(domain->domain, *iova, unmapped);
+		entry->iova = *iova;
+		entry->phys = phys;
+		entry->len  = unmapped;
+		list_add_tail(&entry->list, unmapped_regions);
+
+		*iova += unmapped;
+		(*cnt)++;
+	}
+
+	if (*cnt >= VFIO_IOMMU_TLB_SYNC_MAX || unmapped <= 0) {
+		*unlocked += vfio_sync_unpin(dma, domain,
+					     unmapped_regions);
+		*cnt = 0;
+	}
+
+	return unmapped;
+}
+
 static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 			     bool do_accounting)
 {
 	dma_addr_t iova = dma->iova, end = dma->iova + dma->size;
 	struct vfio_domain *domain, *d;
+	struct list_head unmapped_regions;
 	long unlocked = 0;
+	int cnt = 0;
 
 	if (!dma->size)
 		return 0;
@@ -661,6 +757,8 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu))
 		return 0;
 
+	INIT_LIST_HEAD(&unmapped_regions);
+
 	/*
 	 * We use the IOMMU to track the physical addresses, otherwise we'd
 	 * need a much more complicated tracking system.  Unfortunately that
@@ -699,20 +797,27 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 				break;
 		}
 
-		unmapped = iommu_unmap(domain->domain, iova, len);
-		if (WARN_ON(unmapped <= 0))
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
+		 * sync upto the current point, and switch to slow unmap/unpin
+		 * path.
+		 */
+		unmapped = unmap_unpin_fast(domain, dma, &iova, len, phys,
+					    &unmapped_regions, &unlocked,
+					    &cnt);
+		if (unmapped <= 0) {
+			unmapped = unmap_unpin_slow(domain, dma, &iova, len,
+						    phys, &unlocked);
+			if (WARN_ON(unmapped <= 0))
+				break;
+		}
 	}
 
 	dma->iommu_mapped = false;
+
+	if (cnt)
+		unlocked += vfio_sync_unpin(dma, domain, &unmapped_regions);
+
 	if (do_accounting) {
 		vfio_lock_acct(dma->task, -unlocked, NULL);
 		return 0;
-- 
1.8.3.1
