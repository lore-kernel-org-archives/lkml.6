Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbeAaFBj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 00:01:39 -0500
Received: from mail-dm3nam03on0065.outbound.protection.outlook.com ([104.47.41.65]:12560
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750705AbeAaFBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 00:01:37 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, jroedel@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3] iommu/amd: Add support for fast IOTLB flushing
Date: Wed, 31 Jan 2018 00:01:14 -0500
Message-Id: <1517374874-93978-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [114.109.128.54]
X-ClientProxiedBy: HK2PR02CA0161.apcprd02.prod.outlook.com (10.171.30.21) To
 CY4PR12MB1734.namprd12.prod.outlook.com (10.175.62.144)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ccf1091c-18e6-40c6-965e-08d56867b40c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1734;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1734;3:OSnCbdyO8b5uuEVaaTGghBqznNLlNy/IKG+c8EibxVimbig56CiNxG9PQWDY+yNEB7BWzDRVdpN6hocjxFjxi5xojHn1FSi98crXZ5u8FrhiYIvSLTVsH6gstRGYveIngbdgBmrFe6DwwabpyvMksS4afxl8GA7VUKK0O3ieQhZMlmg4zhppJXCM9QpqZXnEFBj2C5zl452jjg2rl2JW+aafdd+PCo19FtijulnuB/9YzQ6KGzm/lBHQEPXZhYmx;25:qEQ0Nw3GHNn5o/UyOI6x+0M1YfYjBD8J3163VX94orDR9mtEntILmG3fU0XIdUUL0xj085QYxJISnGpcUm56RNISJWPCwSr0krjHivdQrV48xph4AQqwceNHxE5fmVW3i2qFWl6hPA3lBnFAhxkrROGuVuY/89ZOMzuuseq0gqvnhrXQqqJQkSY1qnhhaFBsxB4qi2lTA9igwHbDtOGhcy2NufmectbMufUc4tU3HGbe+667hV07qotoZKOQyyfmQJkqpuMZnXZJByIasUCwSZj3tehkkuWmcRE+hGQ8zhXrIrLVBUdoMBTEAyk+AiBSIp/Blc0GwsSCWofZBjr6hw==;31:dYN2M4vXto2X+qCx5QnzgxMEJAA6v4H0uFP62B3r5MMscJ+B56MwD1jbpEoGeMQHfwEAh7tFM6hf2alf9NxHdNSNsqTuNyBuAn+AqKetbi04bAQjN9mR0bnZzKIippNLZ1WpinmAvKyV6cQ17PFeOF8SVUrRZt2fRgr6iX5YxsLFhgvERgyK1jD9vrNkCEsPGLUx0vd6EWgK99O0EMQB9LmdggajJ9938kGMoUwy6LU=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1734:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1734;20:or3DJbWqj4Yt/MdcXlRl+CIgTmppDKO1qFoqKnGege1MSJfDMFPMU+hL6q12j49/vxNheD3BTmSQkg+9R7NO+jUxwKt9XoACr4IglOnh1mGAPBYtU+AvA3K1mM/zCbrO3LX8XJr/6I27Uzz5YEm/mc8ZvEJwUteujOHrhM74bDLrnBUaJ90buRxkuHlFqB/lm5yAGxFxUcmQSdGeb2/vFHNxTHWb52cEeLtJ0RaRI2MpIo6psK8MIBObuYJ7htVdhdyCl8zSnhLGI0OYgjXmdFxUGjc5802+EJwxkgGW0YjjW2SjafZ/ppz2fLrSDUY+s1wqPPtKkzC6rbVOSul0IyGXxFfl3nzueV+gYFiOpLmqL8SW7k5MaGFx/VdL9bxm91FDnUzIB4yMpo0rZ1gNVvxJUshSabKFwO8q3TwVAuOhEBLTc2+KqEdWft5BFCyECpTTN0tYEBDxHRy1c8fXWRjXu23GfbYUExzxf0kX34dfnaV5BYfpjoKP+S4HYfVD;4:cHFqtyzzyDWa2u0ufVqmUP3Zg6f/xXq8YSG9vfgK+F0MA1DacaFWrnYKvs5xWylrewAaS26h0X8xxXZt0N25aBc7l55Dlz3CZnAIZT1IlrQM/gFUvuo/uK5dkrOB16CrLIQ8+2OtxZvr/Gc1xMS4hIqeNonnJqkTpnG4pDTO2IS/NEb3ZkxZmVQ1uGGRvzBE6V2i/23tc3eqpj3nrpk8iupkQA4K0OWmpnMJrW7xA28BbZkIYL6s9d6bCG+QP7+65NdlB1fZ14xoVzqhFLGdYjBAlAeAi1PX/sbfdQU0knUJnJkz/CqYJ/9pxlhgfDHT
X-Microsoft-Antispam-PRVS: <CY4PR12MB173469EB1399D4BE99B7DF3AF3FB0@CY4PR12MB1734.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR12MB1734;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1734;
X-Forefront-PRVS: 056929CBB8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(39380400002)(366004)(199004)(189003)(7736002)(26005)(59450400001)(5890100001)(386003)(50226002)(6506007)(186003)(48376002)(105586002)(86362001)(305945005)(2906002)(4326008)(50466002)(6116002)(16526019)(25786009)(3846002)(53936002)(5660300001)(68736007)(36756003)(51416003)(6512007)(72206003)(97736004)(6666003)(66066001)(4720700003)(478600001)(81166006)(8676002)(81156014)(106356001)(47776003)(16586007)(8936002)(316002)(6486002)(52116002)(6306002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1734;H:ssuthiku-rhel74.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR12MB1734;23:P1B0M0bAyILrFyWZUpBFRo0dfTJPbet2a198O1670?=
 =?us-ascii?Q?H2w/tfB9xCd+HfTkI8h36E90phCWbOO+ky1j0pvRZ8BERKkNdP2IiNcVTD4S?=
 =?us-ascii?Q?XBMONv8i+u280i8qhvU96vd5H6QEoasiYmG7b1BMx3JVCcShuD9gB5v/3ekB?=
 =?us-ascii?Q?BqpIbtTbMCyqWSfG1UdkYo0J32jGstExT4YS8AKgjHsOZLAINz3OiXL4Hl2J?=
 =?us-ascii?Q?A+szGmVLg2Xu8Acv0565TM5IFDQ4t4+ZTPNyGM9LvgGIw+Ldvcexm8TcORrg?=
 =?us-ascii?Q?JdVj9Ooyx8br4rqC5ACHdH3qn/ChjD29XwIqzFIeW03TiJ5rhVvpNXgfBZU9?=
 =?us-ascii?Q?wfB8Hyan9oWe58+ucFHfEe6BBky8Yu7ZLrFNAsYHDM4Glh6gFo8QN161jZzp?=
 =?us-ascii?Q?dpoApY7mGl+NsW4E9bc4jxqvgta9Nu7WzhS1blh6kCy3vMlaV7gtvwfvxPmw?=
 =?us-ascii?Q?Hle2Zt3jJeatmM7e9CDXoaivCNwhNNpmiFF19ioYySkF/YHXUXwXvBDouxJD?=
 =?us-ascii?Q?VXI5FvtrKmjDZCbcmDDRk0bR5v0mKMvaK68KAkY/Hxyas2HD17Fld3DjrE3i?=
 =?us-ascii?Q?A0OxX5EPQB49SVOMuYLjmY0rAA0+JxTedE2eO6N8zoAF5rBenZC1Jh7+uamE?=
 =?us-ascii?Q?r+Em6gQxg0v8PjJia6yIRScotZa5tc/ZzL2TobkrJq1t828Iw/oH/PwxDrlE?=
 =?us-ascii?Q?W/PygcUvvxXOFlkeFbJstegWVjMyNLndBS1ObcSFKSAzzBl4KajDpHJlgsoE?=
 =?us-ascii?Q?FDiGqI+M4tsPRkEaDR7xjBSOqtY4pjqWtYljJXhRM7/hbpFsaM9yTfuImTJE?=
 =?us-ascii?Q?pw3p7/io2WqgUHCzzFyvOZUG99h4zOgLy3YR51DF3FZyzake752vvkuPkYPY?=
 =?us-ascii?Q?crxVt34fL1Lw8qg2tcz7kGgZjiQy9yCb4yuZOOBOXBt6aMydmBg2tHME+3vy?=
 =?us-ascii?Q?VKVF7oLXie6IwU4pCUSxa1AWWE2J1r15HvN9SkqcN2UB3Vy9+zs1anW86zhS?=
 =?us-ascii?Q?Vc5o0sKxnIt3EaQBKvB7VHxq0FHkb/hw93GFO+CZJSB7GfTLARZePPyQ6A7P?=
 =?us-ascii?Q?pwjkSAT3X9BynmVePlJtuP22KxTfYz2vVImCyXFjQuQVmDFb2QYeinI0wVIB?=
 =?us-ascii?Q?iNi112whbns0EfG3GwgIeFSYcOe3MFOFXKxdxj33K6JdQsvGbebYQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1734;6:EMhExZmdGNtOvjCqI1aMctEAvQOQqtmzaFOtp5C7shyiVPCNKlqgsXgTiMzvWNHOLhZw0nHtl7F/K3/W7LmymqIbGkuqNC8yH8BAIjv0X6o1KqsnPxNzTu2TPK625zjhQVH3l0/GyPlu8Cpm5m7SpY8B5gOaqTuDWXjJ7BrEWYvSobWElASJ/PZyEYs/gRIqfcX3zY55uJgKaEtPvRGqO1jm5m5bWI21TVsDi8pp26xna9r6zlYxh+oaebGBnWbmmkQEi8g6T2ftcG0falbmsKIL3cdXH1U5IEVMQoJsjK03y3FlLzhwHB3UHPKMx7/AqePhn3Hzfir8Hke5KL7j3c6FhfqEeHs4n3FQnGaoTP0=;5:DrSn/xlX88xhgnokRB6QebcLe82OUUEG9iYTasmz6JJUor6WfPwj58uNn/sgf5pbg6O55LakAnyOfSW/II4NlOCCwpp4uUdZK/9/hoiNX7PhhTOX0OQkHnGA+ZCQncpdzis+BnrJ7+bmPPGmCZHtK/x42ThPEUou7DbMkJkP/Do=;24:imoGY7fen0FXbVn43QyOzCPATZ3BCgRYgAblk19G5GwHvHhpQ/3574kYc5SVv48FtU3DmT80ZlnBwZ0nN02yi+aP+aR8V3LwxB2OWX12MNM=;7:2My1V+VQkK4lkKMW2tJMrvPuuJ2cFoMGsY85AYatBvYSzYTZRaZoc2ionNGNsOe3kEAIIKKxQKYcSNsDP0EB42dEbm7Y8ng+dtqPahhc5r1vmGtPC07gbaw4BwEsMdFpMSIQjPyI3v/BgMyyz4JCaFo4nfCPtJmWvzSY1RCmet7XdaXGmlzerGMazhMr9WI1tAsJjB/7dHF5ENajwv45CIIWU/cY9gWOjtm8LS5EE86TjzQ1PW9RT2gV3x7qbIDq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1734;20:4L8fa7MGo+FOx3hjA95KEFqHIyscEihhYGpZq+IJASxDUz7JLOrSnIfcot68XXwOpPJpB2FImrT8KwzoQY4bn19YGMmKlCEM9soH6tiM2i38mzQfL8EeDXyCkipbbSGkeG6cIhh4hYk2Ey5gaAYzuYO1AyFAxLsyG42tUb9mKuXzDAzN2GzQtMF8sVPeO5hKS9b6hlyjlm7uhbv6LJE7Mkg78OKg+/9F8tcTs82sQv1jrsZR4PXfs7gfktbVS1l7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2018 05:01:33.5218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf1091c-18e6-40c6-965e-08d56867b40c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1734
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the newly added IOTLB flushing interface for AMD IOMMU.

Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
Changes from v2 (https://lkml.org/lkml/2017/12/27/44)
 * Call domain_flush_complete() after domain_flush_tlb_pde().

 drivers/iommu/amd_iommu.c       | 77 +++++++++++++++++++++++++++++++++++++++--
 drivers/iommu/amd_iommu_init.c  |  7 ++++
 drivers/iommu/amd_iommu_types.h |  7 ++++
 3 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 3609f51..6c7ac3f 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -129,6 +129,12 @@ struct dma_ops_domain {
 static struct iova_domain reserved_iova_ranges;
 static struct lock_class_key reserved_rbtree_key;
 
+struct amd_iommu_flush_entries {
+	struct list_head list;
+	unsigned long iova;
+	size_t size;
+};
+
 /****************************************************************************
  *
  * Helper functions
@@ -3043,9 +3049,6 @@ static ssize_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 	unmap_size = iommu_unmap_page(domain, iova, page_size);
 	mutex_unlock(&domain->api_lock);
 
-	domain_flush_tlb_pde(domain);
-	domain_flush_complete(domain);
-
 	return unmap_size;
 }
 
@@ -3163,6 +3166,71 @@ static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
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
+	struct amd_iommu_flush_entries *entry, *p;
+	unsigned long flags;
+	bool found = false;
+
+	spin_lock_irqsave(&amd_iommu_flush_list_lock, flags);
+	list_for_each_entry(p, &amd_iommu_flush_list, list) {
+		if (iova != p->iova)
+			continue;
+
+		if (size > p->size) {
+			p->size = size;
+			pr_debug("%s: update range: iova=%#lx, size = %#lx\n",
+				 __func__, p->iova, p->size);
+		}
+		found = true;
+		break;
+	}
+
+	if (!found) {
+		entry = kzalloc(sizeof(struct amd_iommu_flush_entries),
+				GFP_KERNEL);
+		if (entry) {
+			pr_debug("%s: new range: iova=%lx, size=%#lx\n",
+				 __func__, iova, size);
+
+			entry->iova = iova;
+			entry->size = size;
+			list_add(&entry->list, &amd_iommu_flush_list);
+		}
+	}
+	spin_unlock_irqrestore(&amd_iommu_flush_list_lock, flags);
+}
+
+static void amd_iommu_iotlb_sync(struct iommu_domain *domain)
+{
+	struct protection_domain *pdom = to_pdomain(domain);
+	struct amd_iommu_flush_entries *entry, *next;
+	unsigned long flags;
+
+	/* Note:
+	 * Currently, IOMMU driver just flushes the whole IO/TLB for
+	 * a given domain. So, just remove entries from the list here.
+	 */
+	spin_lock_irqsave(&amd_iommu_flush_list_lock, flags);
+	list_for_each_entry_safe(entry, next, &amd_iommu_flush_list, list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+	spin_unlock_irqrestore(&amd_iommu_flush_list_lock, flags);
+
+	domain_flush_tlb_pde(pdom);
+	domain_flush_complete(pdom);
+}
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
@@ -3181,6 +3249,9 @@ static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
 	.apply_resv_region = amd_iommu_apply_resv_region,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
+	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
+	.iotlb_range_add = amd_iommu_iotlb_range_add,
+	.iotlb_sync = amd_iommu_iotlb_sync,
 };
 
 /*****************************************************************************
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 6fe2d03..e8f8cee 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -185,6 +185,12 @@ struct ivmd_header {
 bool amd_iommu_force_isolation __read_mostly;
 
 /*
+ * IOTLB flush list
+ */
+LIST_HEAD(amd_iommu_flush_list);
+spinlock_t amd_iommu_flush_list_lock;
+
+/*
  * List of protection domains - used during resume
  */
 LIST_HEAD(amd_iommu_pd_list);
@@ -2490,6 +2496,7 @@ static int __init early_amd_iommu_init(void)
 	__set_bit(0, amd_iommu_pd_alloc_bitmap);
 
 	spin_lock_init(&amd_iommu_pd_lock);
+	spin_lock_init(&amd_iommu_flush_list_lock);
 
 	/*
 	 * now the data structures are allocated and basically initialized
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index f6b24c7..c3f4a7e 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -668,6 +668,13 @@ struct iommu_dev_data {
 extern struct list_head amd_iommu_pd_list;
 
 /*
+ * Declarations for the global flush list to support
+ * iotlb_range_add() and iotlb_sync.
+ */
+extern spinlock_t amd_iommu_flush_list_lock;
+extern struct list_head amd_iommu_flush_list;
+
+/*
  * Structure defining one entry in the device table
  */
 struct dev_table_entry {
-- 
1.8.3.1
