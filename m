Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2565C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A98420850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A98420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeLET5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:57:13 -0500
Received: from foss.arm.com ([217.140.101.70]:34476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbeLET5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:57:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EADC7EBD;
        Wed,  5 Dec 2018 11:57:10 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 950E13F614;
        Wed,  5 Dec 2018 11:57:09 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v2 1/8] dma-debug: Use pr_fmt()
Date:   Wed,  5 Dec 2018 19:56:50 +0000
Message-Id: <38aee876b085dad74bfcb687c90ddd33c2968ac2.1544037783.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
In-Reply-To: <cover.1544037783.git.robin.murphy@arm.com>
References: <cover.1544037783.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pr_fmt() to generate the "DMA-API: " prefix consistently. This
results in it being added to a couple of pr_*() messages which were
missing it before, and for the err_printk() calls moves it to the actual
start of the message instead of somewhere in the middle.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Add Christoph's review tag

 kernel/dma/debug.c | 74 ++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 231ca4628062..91b84140e4a5 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -17,6 +17,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#define pr_fmt(fmt)	"DMA-API: " fmt
+
 #include <linux/sched/task_stack.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-mapping.h>
@@ -234,7 +236,7 @@ static bool driver_filter(struct device *dev)
 		error_count += 1;					\
 		if (driver_filter(dev) &&				\
 		    (show_all_errors || show_num_errors > 0)) {		\
-			WARN(1, "%s %s: " format,			\
+			WARN(1, pr_fmt("%s %s: ") format,		\
 			     dev ? dev_driver_string(dev) : "NULL",	\
 			     dev ? dev_name(dev) : "NULL", ## arg);	\
 			dump_entry_trace(entry);			\
@@ -519,7 +521,7 @@ static void active_cacheline_inc_overlap(phys_addr_t cln)
 	 * prematurely.
 	 */
 	WARN_ONCE(overlap > ACTIVE_CACHELINE_MAX_OVERLAP,
-		  "DMA-API: exceeded %d overlapping mappings of cacheline %pa\n",
+		  pr_fmt("exceeded %d overlapping mappings of cacheline %pa\n"),
 		  ACTIVE_CACHELINE_MAX_OVERLAP, &cln);
 }
 
@@ -614,7 +616,7 @@ void debug_dma_assert_idle(struct page *page)
 
 	cln = to_cacheline_number(entry);
 	err_printk(entry->dev, entry,
-		   "DMA-API: cpu touching an active dma mapped cacheline [cln=%pa]\n",
+		   "cpu touching an active dma mapped cacheline [cln=%pa]\n",
 		   &cln);
 }
 
@@ -634,7 +636,7 @@ static void add_dma_entry(struct dma_debug_entry *entry)
 
 	rc = active_cacheline_insert(entry);
 	if (rc == -ENOMEM) {
-		pr_err("DMA-API: cacheline tracking ENOMEM, dma-debug disabled\n");
+		pr_err("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
 	}
 
@@ -673,7 +675,7 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 	if (list_empty(&free_entries)) {
 		global_disable = true;
 		spin_unlock_irqrestore(&free_entries_lock, flags);
-		pr_err("DMA-API: debugging out of memory - disabling\n");
+		pr_err("debugging out of memory - disabling\n");
 		return NULL;
 	}
 
@@ -777,7 +779,7 @@ static int prealloc_memory(u32 num_entries)
 	num_free_entries = num_entries;
 	min_free_entries = num_entries;
 
-	pr_info("DMA-API: preallocated %d debug entries\n", num_entries);
+	pr_info("preallocated %d debug entries\n", num_entries);
 
 	return 0;
 
@@ -850,7 +852,7 @@ static ssize_t filter_write(struct file *file, const char __user *userbuf,
 		 * switched off.
 		 */
 		if (current_driver_name[0])
-			pr_info("DMA-API: switching off dma-debug driver filter\n");
+			pr_info("switching off dma-debug driver filter\n");
 		current_driver_name[0] = 0;
 		current_driver = NULL;
 		goto out_unlock;
@@ -868,7 +870,7 @@ static ssize_t filter_write(struct file *file, const char __user *userbuf,
 	current_driver_name[i] = 0;
 	current_driver = NULL;
 
-	pr_info("DMA-API: enable driver filter for driver [%s]\n",
+	pr_info("enable driver filter for driver [%s]\n",
 		current_driver_name);
 
 out_unlock:
@@ -887,7 +889,7 @@ static int dma_debug_fs_init(void)
 {
 	dma_debug_dent = debugfs_create_dir("dma-api", NULL);
 	if (!dma_debug_dent) {
-		pr_err("DMA-API: can not create debugfs directory\n");
+		pr_err("can not create debugfs directory\n");
 		return -ENOMEM;
 	}
 
@@ -973,7 +975,7 @@ static int dma_debug_device_change(struct notifier_block *nb, unsigned long acti
 		count = device_dma_allocations(dev, &entry);
 		if (count == 0)
 			break;
-		err_printk(dev, entry, "DMA-API: device driver has pending "
+		err_printk(dev, entry, "device driver has pending "
 				"DMA allocations while released from device "
 				"[count=%d]\n"
 				"One of leaked entries details: "
@@ -1023,14 +1025,14 @@ static int dma_debug_init(void)
 	}
 
 	if (dma_debug_fs_init() != 0) {
-		pr_err("DMA-API: error creating debugfs entries - disabling\n");
+		pr_err("error creating debugfs entries - disabling\n");
 		global_disable = true;
 
 		return 0;
 	}
 
 	if (prealloc_memory(nr_prealloc_entries) != 0) {
-		pr_err("DMA-API: debugging out of memory error - disabled\n");
+		pr_err("debugging out of memory error - disabled\n");
 		global_disable = true;
 
 		return 0;
@@ -1040,7 +1042,7 @@ static int dma_debug_init(void)
 
 	dma_debug_initialized = true;
 
-	pr_info("DMA-API: debugging enabled by kernel config\n");
+	pr_info("debugging enabled by kernel config\n");
 	return 0;
 }
 core_initcall(dma_debug_init);
@@ -1051,7 +1053,7 @@ static __init int dma_debug_cmdline(char *str)
 		return -EINVAL;
 
 	if (strncmp(str, "off", 3) == 0) {
-		pr_info("DMA-API: debugging disabled on kernel command line\n");
+		pr_info("debugging disabled on kernel command line\n");
 		global_disable = true;
 	}
 
@@ -1085,11 +1087,11 @@ static void check_unmap(struct dma_debug_entry *ref)
 
 		if (dma_mapping_error(ref->dev, ref->dev_addr)) {
 			err_printk(ref->dev, NULL,
-				   "DMA-API: device driver tries to free an "
+				   "device driver tries to free an "
 				   "invalid DMA memory address\n");
 		} else {
 			err_printk(ref->dev, NULL,
-				   "DMA-API: device driver tries to free DMA "
+				   "device driver tries to free DMA "
 				   "memory it has not allocated [device "
 				   "address=0x%016llx] [size=%llu bytes]\n",
 				   ref->dev_addr, ref->size);
@@ -1098,7 +1100,7 @@ static void check_unmap(struct dma_debug_entry *ref)
 	}
 
 	if (ref->size != entry->size) {
-		err_printk(ref->dev, entry, "DMA-API: device driver frees "
+		err_printk(ref->dev, entry, "device driver frees "
 			   "DMA memory with different size "
 			   "[device address=0x%016llx] [map size=%llu bytes] "
 			   "[unmap size=%llu bytes]\n",
@@ -1106,7 +1108,7 @@ static void check_unmap(struct dma_debug_entry *ref)
 	}
 
 	if (ref->type != entry->type) {
-		err_printk(ref->dev, entry, "DMA-API: device driver frees "
+		err_printk(ref->dev, entry, "device driver frees "
 			   "DMA memory with wrong function "
 			   "[device address=0x%016llx] [size=%llu bytes] "
 			   "[mapped as %s] [unmapped as %s]\n",
@@ -1114,7 +1116,7 @@ static void check_unmap(struct dma_debug_entry *ref)
 			   type2name[entry->type], type2name[ref->type]);
 	} else if ((entry->type == dma_debug_coherent) &&
 		   (phys_addr(ref) != phys_addr(entry))) {
-		err_printk(ref->dev, entry, "DMA-API: device driver frees "
+		err_printk(ref->dev, entry, "device driver frees "
 			   "DMA memory with different CPU address "
 			   "[device address=0x%016llx] [size=%llu bytes] "
 			   "[cpu alloc address=0x%016llx] "
@@ -1126,7 +1128,7 @@ static void check_unmap(struct dma_debug_entry *ref)
 
 	if (ref->sg_call_ents && ref->type == dma_debug_sg &&
 	    ref->sg_call_ents != entry->sg_call_ents) {
-		err_printk(ref->dev, entry, "DMA-API: device driver frees "
+		err_printk(ref->dev, entry, "device driver frees "
 			   "DMA sg list with different entry count "
 			   "[map count=%d] [unmap count=%d]\n",
 			   entry->sg_call_ents, ref->sg_call_ents);
@@ -1137,7 +1139,7 @@ static void check_unmap(struct dma_debug_entry *ref)
 	 * DMA API don't handle this properly, so check for it here
 	 */
 	if (ref->direction != entry->direction) {
-		err_printk(ref->dev, entry, "DMA-API: device driver frees "
+		err_printk(ref->dev, entry, "device driver frees "
 			   "DMA memory with different direction "
 			   "[device address=0x%016llx] [size=%llu bytes] "
 			   "[mapped with %s] [unmapped with %s]\n",
@@ -1153,7 +1155,7 @@ static void check_unmap(struct dma_debug_entry *ref)
 	 */
 	if (entry->map_err_type == MAP_ERR_NOT_CHECKED) {
 		err_printk(ref->dev, entry,
-			   "DMA-API: device driver failed to check map error"
+			   "device driver failed to check map error"
 			   "[device address=0x%016llx] [size=%llu bytes] "
 			   "[mapped as %s]",
 			   ref->dev_addr, ref->size,
@@ -1178,7 +1180,7 @@ static void check_for_stack(struct device *dev,
 			return;
 		addr = page_address(page) + offset;
 		if (object_is_on_stack(addr))
-			err_printk(dev, NULL, "DMA-API: device driver maps memory from stack [addr=%p]\n", addr);
+			err_printk(dev, NULL, "device driver maps memory from stack [addr=%p]\n", addr);
 	} else {
 		/* Stack is vmalloced. */
 		int i;
@@ -1188,7 +1190,7 @@ static void check_for_stack(struct device *dev,
 				continue;
 
 			addr = (u8 *)current->stack + i * PAGE_SIZE + offset;
-			err_printk(dev, NULL, "DMA-API: device driver maps memory from stack [probable addr=%p]\n", addr);
+			err_printk(dev, NULL, "device driver maps memory from stack [probable addr=%p]\n", addr);
 			break;
 		}
 	}
@@ -1208,7 +1210,7 @@ static void check_for_illegal_area(struct device *dev, void *addr, unsigned long
 {
 	if (overlap(addr, len, _stext, _etext) ||
 	    overlap(addr, len, __start_rodata, __end_rodata))
-		err_printk(dev, NULL, "DMA-API: device driver maps memory from kernel text or rodata [addr=%p] [len=%lu]\n", addr, len);
+		err_printk(dev, NULL, "device driver maps memory from kernel text or rodata [addr=%p] [len=%lu]\n", addr, len);
 }
 
 static void check_sync(struct device *dev,
@@ -1224,7 +1226,7 @@ static void check_sync(struct device *dev,
 	entry = bucket_find_contain(&bucket, ref, &flags);
 
 	if (!entry) {
-		err_printk(dev, NULL, "DMA-API: device driver tries "
+		err_printk(dev, NULL, "device driver tries "
 				"to sync DMA memory it has not allocated "
 				"[device address=0x%016llx] [size=%llu bytes]\n",
 				(unsigned long long)ref->dev_addr, ref->size);
@@ -1232,7 +1234,7 @@ static void check_sync(struct device *dev,
 	}
 
 	if (ref->size > entry->size) {
-		err_printk(dev, entry, "DMA-API: device driver syncs"
+		err_printk(dev, entry, "device driver syncs"
 				" DMA memory outside allocated range "
 				"[device address=0x%016llx] "
 				"[allocation size=%llu bytes] "
@@ -1245,7 +1247,7 @@ static void check_sync(struct device *dev,
 		goto out;
 
 	if (ref->direction != entry->direction) {
-		err_printk(dev, entry, "DMA-API: device driver syncs "
+		err_printk(dev, entry, "device driver syncs "
 				"DMA memory with different direction "
 				"[device address=0x%016llx] [size=%llu bytes] "
 				"[mapped with %s] [synced with %s]\n",
@@ -1256,7 +1258,7 @@ static void check_sync(struct device *dev,
 
 	if (to_cpu && !(entry->direction == DMA_FROM_DEVICE) &&
 		      !(ref->direction == DMA_TO_DEVICE))
-		err_printk(dev, entry, "DMA-API: device driver syncs "
+		err_printk(dev, entry, "device driver syncs "
 				"device read-only DMA memory for cpu "
 				"[device address=0x%016llx] [size=%llu bytes] "
 				"[mapped with %s] [synced with %s]\n",
@@ -1266,7 +1268,7 @@ static void check_sync(struct device *dev,
 
 	if (!to_cpu && !(entry->direction == DMA_TO_DEVICE) &&
 		       !(ref->direction == DMA_FROM_DEVICE))
-		err_printk(dev, entry, "DMA-API: device driver syncs "
+		err_printk(dev, entry, "device driver syncs "
 				"device write-only DMA memory to device "
 				"[device address=0x%016llx] [size=%llu bytes] "
 				"[mapped with %s] [synced with %s]\n",
@@ -1276,7 +1278,7 @@ static void check_sync(struct device *dev,
 
 	if (ref->sg_call_ents && ref->type == dma_debug_sg &&
 	    ref->sg_call_ents != entry->sg_call_ents) {
-		err_printk(ref->dev, entry, "DMA-API: device driver syncs "
+		err_printk(ref->dev, entry, "device driver syncs "
 			   "DMA sg list with different entry count "
 			   "[map count=%d] [sync count=%d]\n",
 			   entry->sg_call_ents, ref->sg_call_ents);
@@ -1297,7 +1299,7 @@ static void check_sg_segment(struct device *dev, struct scatterlist *sg)
 	 * whoever generated the list forgot to check them.
 	 */
 	if (sg->length > max_seg)
-		err_printk(dev, NULL, "DMA-API: mapping sg segment longer than device claims to support [len=%u] [max=%u]\n",
+		err_printk(dev, NULL, "mapping sg segment longer than device claims to support [len=%u] [max=%u]\n",
 			   sg->length, max_seg);
 	/*
 	 * In some cases this could potentially be the DMA API
@@ -1307,7 +1309,7 @@ static void check_sg_segment(struct device *dev, struct scatterlist *sg)
 	start = sg_dma_address(sg);
 	end = start + sg_dma_len(sg) - 1;
 	if ((start ^ end) & ~boundary)
-		err_printk(dev, NULL, "DMA-API: mapping sg segment across boundary [start=0x%016llx] [end=0x%016llx] [boundary=0x%016llx]\n",
+		err_printk(dev, NULL, "mapping sg segment across boundary [start=0x%016llx] [end=0x%016llx] [boundary=0x%016llx]\n",
 			   start, end, boundary);
 #endif
 }
@@ -1319,11 +1321,11 @@ void debug_dma_map_single(struct device *dev, const void *addr,
 		return;
 
 	if (!virt_addr_valid(addr))
-		err_printk(dev, NULL, "DMA-API: device driver maps memory from invalid area [addr=%p] [len=%lu]\n",
+		err_printk(dev, NULL, "device driver maps memory from invalid area [addr=%p] [len=%lu]\n",
 			   addr, len);
 
 	if (is_vmalloc_addr(addr))
-		err_printk(dev, NULL, "DMA-API: device driver maps memory from vmalloc area [addr=%p] [len=%lu]\n",
+		err_printk(dev, NULL, "device driver maps memory from vmalloc area [addr=%p] [len=%lu]\n",
 			   addr, len);
 }
 EXPORT_SYMBOL(debug_dma_map_single);
@@ -1780,7 +1782,7 @@ static int __init dma_debug_driver_setup(char *str)
 	}
 
 	if (current_driver_name[0])
-		pr_info("DMA-API: enable driver filter for driver [%s]\n",
+		pr_info("enable driver filter for driver [%s]\n",
 			current_driver_name);
 
 
-- 
2.19.1.dirty

