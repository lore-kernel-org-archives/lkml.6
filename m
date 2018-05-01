Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755531AbeEAJPE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:15:04 -0400
Received: from foss.arm.com ([217.140.101.70]:44200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754788AbeEAJLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:11:46 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 15/27] coresight: tmc-etr: Make SG table circular
Date: Tue,  1 May 2018 10:10:45 +0100
Message-Id: <1525165857-11096-16-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the ETR SG table Circular buffer so that we could start
at any of the SG pages and use the entire buffer for tracing.
Also support using a partial buffer for tracing (i.e restricting
the size to a requested value) by adjusting the LAST buffer pointer.

This can be achieved by :

1) While building the SG table, allocate an exta entry, which
will be made as a LINK pointer at the very end of the SG table,
i.e, after the LAST buffer entry, to point back to the beginning
of the first table. This will allow us to use the buffer normally
when we start the trace at offset 0 of the buffer, as the LAST
buffer entry hints the TMC-ETR and it automatically wraps to the
offset 0.

2) If we want to start at any other ETR SG page aligned offset,
with a different size than the full buffer size, we could :

 a) Make the page entry at the (offset + new_size) as LAST.
 b) Make the original LAST entry a normal entry.
 c) Use the table pointer to the "new" start offset as the
    base of the table address.

This works fine, as the TMC doesn't mandate that the page table
base address should be 4K page aligned. So we can program the
DBA to point to the entry which points the required SG PAGE.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V1:
 - Add a size parameter, which will be used to limit the
   trace buffer exposed to the ETR. This could prevent the
   ETR from overwriting a shared perf ring buffer area,
   which is being consumed by the userspace.
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 173 +++++++++++++++++++++---
 1 file changed, 154 insertions(+), 19 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index a003cfc..d18043d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -17,6 +17,7 @@
 
 #include <linux/coresight.h>
 #include <linux/dma-mapping.h>
+#include <linux/iommu.h>
 #include <linux/slab.h>
 #include "coresight-catu.h"
 #include "coresight-priv.h"
@@ -72,35 +73,41 @@ typedef u32 sgte_t;
  * @sg_table:		Generic SG Table holding the data/table pages.
  * @hwaddr:		hwaddress used by the TMC, which is the base
  *			address of the table.
+ * @nr_entries:		Total number of pointers in the table.
+ * @first_entry:	Index to the current "start" of the buffer.
+ * @last_entry:		Index to the last entry of the buffer.
  */
 struct etr_sg_table {
 	struct tmc_sg_table	*sg_table;
 	dma_addr_t		hwaddr;
+	u32			nr_entries;
+	u32			first_entry;
+	u32			last_entry;
 };
 
 /*
  * tmc_etr_sg_table_entries: Total number of table entries required to map
  * @nr_pages system pages.
  *
- * We need to map @nr_pages * ETR_SG_PAGES_PER_SYSPAGE data pages.
+ * We need to map @nr_pages * ETR_SG_PAGES_PER_SYSPAGE data pages and
+ * an additional Link pointer for making it a Circular buffer.
  * Each TMC page can map (ETR_SG_PTRS_PER_PAGE - 1) buffer pointers,
  * with the last entry pointing to another page of table entries.
- * If we spill over to a new page for mapping 1 entry, we could as
- * well replace the link entry of the previous page with the last entry.
+ * If we fill the last table in full with the pointers, (i.e,
+ * nr_sgpages % (ETR_SG_PTRS_PER_PAGE - 1) == 0, we don't have to
+ * allocate another table and use the unused Link entry to make it
+ * circular.
  */
 static inline unsigned long __attribute_const__
 tmc_etr_sg_table_entries(int nr_pages)
 {
 	unsigned long nr_sgpages = nr_pages * ETR_SG_PAGES_PER_SYSPAGE;
 	unsigned long nr_sglinks = nr_sgpages / (ETR_SG_PTRS_PER_PAGE - 1);
-	/*
-	 * If we spill over to a new page for 1 entry, we could as well
-	 * make it the LAST entry in the previous page, skipping the Link
-	 * address.
-	 */
-	if (nr_sglinks && (nr_sgpages % (ETR_SG_PTRS_PER_PAGE - 1) < 2))
+
+	if (nr_sglinks && !(nr_sgpages % (ETR_SG_PTRS_PER_PAGE - 1)))
 		nr_sglinks--;
-	return nr_sgpages + nr_sglinks;
+	/* Add an entry for the circular link */
+	return nr_sgpages + nr_sglinks + 1;
 }
 
 /*
@@ -413,14 +420,22 @@ tmc_sg_daddr_to_vaddr(struct tmc_sg_table *sg_table,
 /* Dump the given sg_table */
 static void tmc_etr_sg_table_dump(struct etr_sg_table *etr_table)
 {
-	sgte_t *ptr;
+	sgte_t *ptr, *start;
 	int i = 0;
 	dma_addr_t addr;
 	struct tmc_sg_table *sg_table = etr_table->sg_table;
 
-	ptr = (sgte_t *)tmc_sg_daddr_to_vaddr(sg_table,
+	start = (sgte_t *)tmc_sg_daddr_to_vaddr(sg_table,
 					      etr_table->hwaddr, true);
-	while (ptr) {
+	if (!start) {
+		dev_dbg(sg_table->dev,
+			"ERROR: Failed to translate table base: 0x%llx\n",
+			 etr_table->hwaddr);
+		return;
+	}
+
+	ptr = start;
+	do {
 		addr = ETR_SG_ADDR(*ptr);
 		switch (ETR_SG_ET(*ptr)) {
 		case ETR_SG_ET_NORMAL:
@@ -434,12 +449,16 @@ static void tmc_etr_sg_table_dump(struct etr_sg_table *etr_table)
 				 i, ptr, addr);
 			ptr = (sgte_t *)tmc_sg_daddr_to_vaddr(sg_table,
 							      addr, true);
+			if (!ptr)
+				dev_dbg(sg_table->dev,
+					"ERROR: Bad Link 0x%llx\n", addr);
 			break;
 		case ETR_SG_ET_LAST:
 			dev_dbg(sg_table->dev,
 				"%05d: ### %p\t:[L] 0x%llx ###\n",
 				 i, ptr, addr);
-			return;
+			ptr++;
+			break;
 		default:
 			dev_dbg(sg_table->dev,
 				"%05d: xxx %p\t:[INVALID] 0x%llx xxx\n",
@@ -447,7 +466,7 @@ static void tmc_etr_sg_table_dump(struct etr_sg_table *etr_table)
 			return;
 		}
 		i++;
-	}
+	} while (ptr && ptr != start);
 	dev_dbg(sg_table->dev, "******* End of Table *****\n");
 }
 #endif
@@ -462,7 +481,7 @@ static void tmc_etr_sg_table_dump(struct etr_sg_table *etr_table)
 static void tmc_etr_sg_table_populate(struct etr_sg_table *etr_table)
 {
 	dma_addr_t paddr;
-	int i, type, nr_entries;
+	int i, type;
 	int tpidx = 0; /* index to the current system table_page */
 	int sgtidx = 0;	/* index to the sg_table within the current syspage */
 	int sgtentry = 0; /* the entry within the sg_table */
@@ -473,16 +492,16 @@ static void tmc_etr_sg_table_populate(struct etr_sg_table *etr_table)
 	dma_addr_t *table_daddrs = sg_table->table_pages.daddrs;
 	dma_addr_t *data_daddrs = sg_table->data_pages.daddrs;
 
-	nr_entries = tmc_etr_sg_table_entries(sg_table->data_pages.nr_pages);
 	/*
 	 * Use the contiguous virtual address of the table to update entries.
 	 */
 	ptr = sg_table->table_vaddr;
 	/*
-	 * Fill all the entries, except the last entry to avoid special
+	 * Fill all the entries, except the last two entries (i.e, the last
+	 * buffer and the circular link back to the base) to avoid special
 	 * checks within the loop.
 	 */
-	for (i = 0; i < nr_entries - 1; i++) {
+	for (i = 0; i < etr_table->nr_entries - 2; i++) {
 		if (sgtentry == ETR_SG_PTRS_PER_PAGE - 1) {
 			/*
 			 * Last entry in a sg_table page is a link address to
@@ -523,6 +542,119 @@ static void tmc_etr_sg_table_populate(struct etr_sg_table *etr_table)
 	/* Set up the last entry, which is always a data pointer */
 	paddr = data_daddrs[dpidx] + spidx * ETR_SG_PAGE_SIZE;
 	*ptr++ = ETR_SG_ENTRY(paddr, ETR_SG_ET_LAST);
+	/* followed by a circular link, back to the start of the table */
+	*ptr++ = ETR_SG_ENTRY(sg_table->table_daddr, ETR_SG_ET_LINK);
+}
+
+/*
+ * tmc_etr_sg_offset_to_table_index : Translate a given data @offset
+ * to the index of the page table "entry" pointing to the "page".
+ * For each (ETR_SG_PTRS_PER_PAGE - 1) sg pages, we add a Link pointer.
+ */
+static inline u32
+tmc_etr_sg_offset_to_table_index(u64 offset)
+{
+	u32 sg_page = offset >> ETR_SG_PAGE_SHIFT;
+
+	return sg_page + sg_page / (u32)(ETR_SG_PTRS_PER_PAGE - 1);
+}
+
+/*
+ * tmc_etr_sg_update_type: Update the type of a given entry in the
+ * table to the requested entry. This is only used for data buffers
+ * to toggle the "NORMAL" vs "LAST" buffer entries.
+ */
+static inline void tmc_etr_sg_update_type(sgte_t *entry, u32 type)
+{
+	WARN_ON(!ETR_SG_ET(*entry) || ETR_SG_ET(*entry) == ETR_SG_ET_LINK);
+	*entry &= ~ETR_SG_ET_MASK;
+	*entry |= type;
+}
+
+/*
+ * tmc_etr_sg_table_index_to_daddr: Return the hardware address to the table
+ * entry @index. Use this address to let the table begin @index.
+ */
+static inline dma_addr_t
+tmc_etr_sg_table_index_to_daddr(struct tmc_sg_table *sg_table, u32 index)
+{
+	u32 sys_page_idx = index / ETR_SG_PTRS_PER_SYSPAGE;
+	u32 sys_page_offset = index % ETR_SG_PTRS_PER_SYSPAGE;
+
+	if (sys_page_idx < sg_table->table_pages.nr_pages)
+		return sg_table->table_pages.daddrs[sys_page_idx] +
+			sizeof(sgte_t) * sys_page_offset;
+	return 0;
+}
+
+/*
+ * tmc_etr_sg_table_rotate : Rotate the SG circular buffer, moving
+ * the "base" to a requested offset and reset the size to @size
+ * We do so by :
+ *
+ * 1) Reset the current LAST buffer.
+ * 2) Update the hwaddr to point to the table pointer for the buffer
+ *    which starts @base_offset.
+ * 2) Mark the page at the base_offset + size as LAST.
+ */
+static int __maybe_unused
+tmc_etr_sg_table_rotate(struct etr_sg_table *etr_table,
+			unsigned long base_offset, unsigned long size)
+{
+	u32 last_entry, first_entry;
+	u64 last_offset;
+	struct tmc_sg_table *sg_table = etr_table->sg_table;
+	sgte_t *table_ptr = sg_table->table_vaddr;
+	ssize_t buf_size = tmc_sg_table_buf_size(sg_table);
+
+	if (size > buf_size || size & (ETR_SG_PAGE_SIZE - 1)) {
+		dev_dbg(sg_table->dev, "unsupported size: %lx\n", size);
+		return -EINVAL;
+	}
+
+	/* Offset should always be SG PAGE_SIZE aligned */
+	if (base_offset & (ETR_SG_PAGE_SIZE - 1)) {
+		dev_dbg(sg_table->dev,
+			"unaligned base offset %lx\n", base_offset);
+		return -EINVAL;
+	}
+	/* Make sure the offsets are within the range */
+	base_offset -= (base_offset > buf_size) ? buf_size : 0;
+	last_offset = base_offset + size;
+	last_offset -= (last_offset > buf_size) ? buf_size : 0;
+
+	first_entry = tmc_etr_sg_offset_to_table_index(base_offset);
+	last_entry = tmc_etr_sg_offset_to_table_index(last_offset);
+
+	/* Reset the current LAST page to NORMAL and set the new LAST page */
+	if (last_entry != etr_table->last_entry) {
+		tmc_etr_sg_update_type(&table_ptr[etr_table->last_entry],
+				       ETR_SG_ET_NORMAL);
+		tmc_etr_sg_update_type(&table_ptr[last_entry], ETR_SG_ET_LAST);
+	}
+
+	etr_table->hwaddr = tmc_etr_sg_table_index_to_daddr(sg_table,
+							    first_entry);
+
+	/*
+	 * We shouldn't be hitting an invalid index, unless something
+	 * seriously wrong.
+	 */
+	if (WARN_ON(!etr_table->hwaddr))
+		return -EINVAL;
+
+	etr_table->first_entry = first_entry;
+	etr_table->last_entry = last_entry;
+	dev_dbg(sg_table->dev,
+		"table rotated to offset %lx, dba: %lx, size: %ldKB\n",
+		base_offset, (unsigned long)etr_table->hwaddr,
+		(unsigned long)(size >> 10));
+	/* Sync the table for device */
+	tmc_sg_table_sync_table(sg_table);
+#ifdef ETR_SG_DEBUG
+	tmc_etr_sg_table_dump(etr_table);
+#endif
+	return 0;
 }
 
 /*
@@ -556,6 +688,9 @@ tmc_init_etr_sg_table(struct device *dev, int node,
 	}
 
 	etr_table->sg_table = sg_table;
+	etr_table->nr_entries = nr_entries;
+	etr_table->first_entry = 0;
+	etr_table->last_entry = nr_entries - 2;
 	/* TMC should use table base address for DBA */
 	etr_table->hwaddr = sg_table->table_daddr;
 	tmc_etr_sg_table_populate(etr_table);
-- 
2.7.4
