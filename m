Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754846AbeEAJLs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:11:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44182 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751676AbeEAJLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:11:44 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 14/27] coresight: Add support for TMC ETR SG unit
Date: Tue,  1 May 2018 10:10:44 +0100
Message-Id: <1525165857-11096-15-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for setting up an SG table used by the
TMC ETR inbuilt SG unit. The TMC ETR uses 4K page sized tables
to hold pointers to the 4K data pages with the last entry in a
table pointing to the next table with the entries, by kind of
chaining. The 2 LSBs determine the type of the table entry, to
one of :

 Normal - Points to a 4KB data page.
 Last   - Points to a 4KB data page, but is the last entry in the
          page table.
 Link   - Points to another 4KB table page with pointers to data.

The code takes care of handling the system page size which could
be different than 4K. So we could end up putting multiple ETR
SG tables in a single system page, vice versa for the data pages.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 262 ++++++++++++++++++++++++
 1 file changed, 262 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 57a8fe1..a003cfc 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -23,6 +23,87 @@
 #include "coresight-tmc.h"
 
 /*
+ * The TMC ETR SG has a page size of 4K. The SG table contains pointers
+ * to 4KB buffers. However, the OS may use a PAGE_SIZE different from
+ * 4K (i.e, 16KB or 64KB). This implies that a single OS page could
+ * contain more than one SG buffer and tables.
+ *
+ * A table entry has the following format:
+ *
+ * ---Bit31------------Bit4-------Bit1-----Bit0--
+ * |     Address[39:12]    | SBZ |  Entry Type  |
+ * ----------------------------------------------
+ *
+ * Address: Bits [39:12] of a physical page address. Bits [11:0] are
+ *	    always zero.
+ *
+ * Entry type:
+ *	b00 - Reserved.
+ *	b01 - Last entry in the tables, points to 4K page buffer.
+ *	b10 - Normal entry, points to 4K page buffer.
+ *	b11 - Link. The address points to the base of next table.
+ */
+
+typedef u32 sgte_t;
+
+#define ETR_SG_PAGE_SHIFT		12
+#define ETR_SG_PAGE_SIZE		(1UL << ETR_SG_PAGE_SHIFT)
+#define ETR_SG_PAGES_PER_SYSPAGE	(PAGE_SIZE / ETR_SG_PAGE_SIZE)
+#define ETR_SG_PTRS_PER_PAGE		(ETR_SG_PAGE_SIZE / sizeof(sgte_t))
+#define ETR_SG_PTRS_PER_SYSPAGE		(PAGE_SIZE / sizeof(sgte_t))
+
+#define ETR_SG_ET_MASK			0x3
+#define ETR_SG_ET_LAST			0x1
+#define ETR_SG_ET_NORMAL		0x2
+#define ETR_SG_ET_LINK			0x3
+
+#define ETR_SG_ADDR_SHIFT		4
+
+#define ETR_SG_ENTRY(addr, type) \
+	(sgte_t)((((addr) >> ETR_SG_PAGE_SHIFT) << ETR_SG_ADDR_SHIFT) | \
+		 (type & ETR_SG_ET_MASK))
+
+#define ETR_SG_ADDR(entry) \
+	(((dma_addr_t)(entry) >> ETR_SG_ADDR_SHIFT) << ETR_SG_PAGE_SHIFT)
+#define ETR_SG_ET(entry)		((entry) & ETR_SG_ET_MASK)
+
+/*
+ * struct etr_sg_table : ETR SG Table
+ * @sg_table:		Generic SG Table holding the data/table pages.
+ * @hwaddr:		hwaddress used by the TMC, which is the base
+ *			address of the table.
+ */
+struct etr_sg_table {
+	struct tmc_sg_table	*sg_table;
+	dma_addr_t		hwaddr;
+};
+
+/*
+ * tmc_etr_sg_table_entries: Total number of table entries required to map
+ * @nr_pages system pages.
+ *
+ * We need to map @nr_pages * ETR_SG_PAGES_PER_SYSPAGE data pages.
+ * Each TMC page can map (ETR_SG_PTRS_PER_PAGE - 1) buffer pointers,
+ * with the last entry pointing to another page of table entries.
+ * If we spill over to a new page for mapping 1 entry, we could as
+ * well replace the link entry of the previous page with the last entry.
+ */
+static inline unsigned long __attribute_const__
+tmc_etr_sg_table_entries(int nr_pages)
+{
+	unsigned long nr_sgpages = nr_pages * ETR_SG_PAGES_PER_SYSPAGE;
+	unsigned long nr_sglinks = nr_sgpages / (ETR_SG_PTRS_PER_PAGE - 1);
+	/*
+	 * If we spill over to a new page for 1 entry, we could as well
+	 * make it the LAST entry in the previous page, skipping the Link
+	 * address.
+	 */
+	if (nr_sglinks && (nr_sgpages % (ETR_SG_PTRS_PER_PAGE - 1) < 2))
+		nr_sglinks--;
+	return nr_sgpages + nr_sglinks;
+}
+
+/*
  * tmc_pages_get_offset:  Go through all the pages in the tmc_pages
  * and map the device address @addr to an offset within the virtual
  * contiguous buffer.
@@ -305,6 +386,187 @@ ssize_t tmc_sg_table_get_data(struct tmc_sg_table *sg_table,
 	return len;
 }
 
+#ifdef ETR_SG_DEBUG
+/* Map a dma address to virtual address */
+static unsigned long
+tmc_sg_daddr_to_vaddr(struct tmc_sg_table *sg_table,
+			dma_addr_t addr, bool table)
+{
+	long offset;
+	unsigned long base;
+	struct tmc_pages *tmc_pages;
+
+	if (table) {
+		tmc_pages = &sg_table->table_pages;
+		base = (unsigned long)sg_table->table_vaddr;
+	} else {
+		tmc_pages = &sg_table->data_pages;
+		base = (unsigned long)sg_table->data_vaddr;
+	}
+
+	offset = tmc_pages_get_offset(tmc_pages, addr);
+	if (offset < 0)
+		return 0;
+	return base + offset;
+}
+
+/* Dump the given sg_table */
+static void tmc_etr_sg_table_dump(struct etr_sg_table *etr_table)
+{
+	sgte_t *ptr;
+	int i = 0;
+	dma_addr_t addr;
+	struct tmc_sg_table *sg_table = etr_table->sg_table;
+
+	ptr = (sgte_t *)tmc_sg_daddr_to_vaddr(sg_table,
+					      etr_table->hwaddr, true);
+	while (ptr) {
+		addr = ETR_SG_ADDR(*ptr);
+		switch (ETR_SG_ET(*ptr)) {
+		case ETR_SG_ET_NORMAL:
+			dev_dbg(sg_table->dev,
+				"%05d: %p\t:[N] 0x%llx\n", i, ptr, addr);
+			ptr++;
+			break;
+		case ETR_SG_ET_LINK:
+			dev_dbg(sg_table->dev,
+				"%05d: *** %p\t:{L} 0x%llx ***\n",
+				 i, ptr, addr);
+			ptr = (sgte_t *)tmc_sg_daddr_to_vaddr(sg_table,
+							      addr, true);
+			break;
+		case ETR_SG_ET_LAST:
+			dev_dbg(sg_table->dev,
+				"%05d: ### %p\t:[L] 0x%llx ###\n",
+				 i, ptr, addr);
+			return;
+		default:
+			dev_dbg(sg_table->dev,
+				"%05d: xxx %p\t:[INVALID] 0x%llx xxx\n",
+				 i, ptr, addr);
+			return;
+		}
+		i++;
+	}
+	dev_dbg(sg_table->dev, "******* End of Table *****\n");
+}
+#endif
+
+/*
+ * Populate the SG Table page table entries from table/data
+ * pages allocated. Each Data page has ETR_SG_PAGES_PER_SYSPAGE SG pages.
+ * So does a Table page. So we keep track of indices of the tables
+ * in each system page and move the pointers accordingly.
+ */
+#define INC_IDX_ROUND(idx, size) ((idx) = ((idx) + 1) % (size))
+static void tmc_etr_sg_table_populate(struct etr_sg_table *etr_table)
+{
+	dma_addr_t paddr;
+	int i, type, nr_entries;
+	int tpidx = 0; /* index to the current system table_page */
+	int sgtidx = 0;	/* index to the sg_table within the current syspage */
+	int sgtentry = 0; /* the entry within the sg_table */
+	int dpidx = 0; /* index to the current system data_page */
+	int spidx = 0; /* index to the SG page within the current data page */
+	sgte_t *ptr; /* pointer to the table entry to fill */
+	struct tmc_sg_table *sg_table = etr_table->sg_table;
+	dma_addr_t *table_daddrs = sg_table->table_pages.daddrs;
+	dma_addr_t *data_daddrs = sg_table->data_pages.daddrs;
+
+	nr_entries = tmc_etr_sg_table_entries(sg_table->data_pages.nr_pages);
+	/*
+	 * Use the contiguous virtual address of the table to update entries.
+	 */
+	ptr = sg_table->table_vaddr;
+	/*
+	 * Fill all the entries, except the last entry to avoid special
+	 * checks within the loop.
+	 */
+	for (i = 0; i < nr_entries - 1; i++) {
+		if (sgtentry == ETR_SG_PTRS_PER_PAGE - 1) {
+			/*
+			 * Last entry in a sg_table page is a link address to
+			 * the next table page. If this sg_table is the last
+			 * one in the system page, it links to the first
+			 * sg_table in the next system page. Otherwise, it
+			 * links to the next sg_table page within the system
+			 * page.
+			 */
+			if (sgtidx == ETR_SG_PAGES_PER_SYSPAGE - 1) {
+				paddr = table_daddrs[tpidx + 1];
+			} else {
+				paddr = table_daddrs[tpidx] +
+					(ETR_SG_PAGE_SIZE * (sgtidx + 1));
+			}
+			type = ETR_SG_ET_LINK;
+		} else {
+			/*
+			 * Update the indices to the data_pages to point to the
+			 * next sg_page in the data buffer.
+			 */
+			type = ETR_SG_ET_NORMAL;
+			paddr = data_daddrs[dpidx] + spidx * ETR_SG_PAGE_SIZE;
+			if (!INC_IDX_ROUND(spidx, ETR_SG_PAGES_PER_SYSPAGE))
+				dpidx++;
+		}
+		*ptr++ = ETR_SG_ENTRY(paddr, type);
+		/*
+		 * Move to the next table pointer, moving the table page index
+		 * if necessary
+		 */
+		if (!INC_IDX_ROUND(sgtentry, ETR_SG_PTRS_PER_PAGE)) {
+			if (!INC_IDX_ROUND(sgtidx, ETR_SG_PAGES_PER_SYSPAGE))
+				tpidx++;
+		}
+	}
+
+	/* Set up the last entry, which is always a data pointer */
+	paddr = data_daddrs[dpidx] + spidx * ETR_SG_PAGE_SIZE;
+	*ptr++ = ETR_SG_ENTRY(paddr, ETR_SG_ET_LAST);
+}
+
+/*
+ * tmc_init_etr_sg_table: Allocate a TMC ETR SG table, data buffer of @size and
+ * populate the table.
+ *
+ * @dev		- Device pointer for the TMC
+ * @node	- NUMA node where the memory should be allocated
+ * @size	- Total size of the data buffer
+ * @pages	- Optional list of page virtual address
+ */
+static struct etr_sg_table __maybe_unused *
+tmc_init_etr_sg_table(struct device *dev, int node,
+		  unsigned long size, void **pages)
+{
+	int nr_entries, nr_tpages;
+	int nr_dpages = size >> PAGE_SHIFT;
+	struct tmc_sg_table *sg_table;
+	struct etr_sg_table *etr_table;
+
+	etr_table = kzalloc(sizeof(*etr_table), GFP_KERNEL);
+	if (!etr_table)
+		return ERR_PTR(-ENOMEM);
+	nr_entries = tmc_etr_sg_table_entries(nr_dpages);
+	nr_tpages = DIV_ROUND_UP(nr_entries, ETR_SG_PTRS_PER_SYSPAGE);
+
+	sg_table = tmc_alloc_sg_table(dev, node, nr_tpages, nr_dpages, pages);
+	if (IS_ERR(sg_table)) {
+		kfree(etr_table);
+		return ERR_PTR(PTR_ERR(sg_table));
+	}
+
+	etr_table->sg_table = sg_table;
+	/* TMC should use table base address for DBA */
+	etr_table->hwaddr = sg_table->table_daddr;
+	tmc_etr_sg_table_populate(etr_table);
+	/* Sync the table pages for the HW */
+	tmc_sg_table_sync_table(sg_table);
+#ifdef ETR_SG_DEBUG
+	tmc_etr_sg_table_dump(etr_table);
+#endif
+	return etr_table;
+}
+
 static inline void tmc_etr_enable_catu(struct tmc_drvdata *drvdata)
 {
 	struct coresight_device *catu = tmc_etr_get_catu_device(drvdata);
-- 
2.7.4
