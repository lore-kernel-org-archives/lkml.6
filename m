Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F8BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60866257FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60866257FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932718AbeFYLXK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:23:10 -0400
Received: from foss.arm.com ([217.140.101.70]:54928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932387AbeFYLXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:23:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C43022D7;
        Mon, 25 Jun 2018 04:23:06 -0700 (PDT)
Received: from localhost.localdomain.com (unknown [10.1.207.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AB79B3F59C;
        Mon, 25 Jun 2018 04:23:04 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        robh@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 5/6] coresight: catu: Add support for scatter gather tables
Date:   Mon, 25 Jun 2018 12:22:12 +0100
Message-Id: <20180625112213.23492-6-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180625112213.23492-1-suzuki.poulose@arm.com>
References: <20180625112213.23492-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the support for setting up a SG table for use
by the CATU. We reuse the tmc_sg_table to represent the table/data
pages, even though the table format is different.

Similar to ETR SG table, CATU uses a 4KB page size for data buffers
as well as page tables. All table entries are 64bit wide and have
the following format:

        63                      12      1  0
        x-----------------------------------x
        |        Address [63-12] | SBZ  | V |
        x-----------------------------------x

	Where [V] ->	 0 - Pointer is invalid
			 1 - Pointer is Valid

CATU uses only first half of the page for data page pointers.
i.e, single table page will only have 256 page pointers, addressing
upto 1MB of data. The second half of a table page contains only two
pointers at the end of the page (i.e, pointers at index 510 and 511),
which are used as links to the "Previous" and "Next" page tables
respectively.

The first table page has an "Invalid" previous pointer and the
next pointer entry points to the second page table if there is one.
Similarly the last table page has an "Invalid" next pointer to
indicate the end of the table chain.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c | 251 +++++++++++++++++++++++++++
 1 file changed, 251 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 9d0cb1f..559d45b 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -16,10 +16,261 @@
 
 #include "coresight-catu.h"
 #include "coresight-priv.h"
+#include "coresight-tmc.h"
 
 #define csdev_to_catu_drvdata(csdev)	\
 	dev_get_drvdata(csdev->dev.parent)
 
+/* Verbose output for CATU table contents */
+#ifdef CATU_DEBUG
+#define catu_dbg(x, ...) dev_dbg(x, __VA_ARGS__)
+#else
+#define catu_dbg(x, ...) do {} while (0)
+#endif
+
+/*
+ * CATU uses a page size of 4KB for page tables as well as data pages.
+ * Each 64bit entry in the table has the following format.
+ *
+ *	63			12	1  0
+ *	------------------------------------
+ *	|	 Address [63-12] | SBZ	| V|
+ *	------------------------------------
+ *
+ * Where bit[0] V indicates if the address is valid or not.
+ * Each 4K table pages have upto 256 data page pointers, taking upto 2K
+ * size. There are two Link pointers, pointing to the previous and next
+ * table pages respectively at the end of the 4K page. (i.e, entry 510
+ * and 511).
+ *  E.g, a table of two pages could look like :
+ *
+ *                 Table Page 0               Table Page 1
+ * SLADDR ===> x------------------x  x--> x-----------------x
+ * INADDR    ->|  Page 0      | V |  |    | Page 256    | V | <- INADDR+1M
+ *             |------------------|  |    |-----------------|
+ * INADDR+4K ->|  Page 1      | V |  |    |                 |
+ *             |------------------|  |    |-----------------|
+ *             |  Page 2      | V |  |    |                 |
+ *             |------------------|  |    |-----------------|
+ *             |   ...        | V |  |    |    ...          |
+ *             |------------------|  |    |-----------------|
+ * INADDR+1020K|  Page 255    | V |  |    |   Page 511  | V |
+ * SLADDR+2K==>|------------------|  |    |-----------------|
+ *             |  UNUSED      |   |  |    |                 |
+ *             |------------------|  |    |                 |
+ *             |  UNUSED      |   |  |    |                 |
+ *             |------------------|  |    |                 |
+ *             |    ...       |   |  |    |                 |
+ *             |------------------|  |    |-----------------|
+ *             |   IGNORED    | 0 |  |    | Table Page 0| 1 |
+ *             |------------------|  |    |-----------------|
+ *             |  Table Page 1| 1 |--x    | IGNORED     | 0 |
+ *             x------------------x       x-----------------x
+ * SLADDR+4K==>
+ *
+ * The base input address (used by the ETR, programmed in INADDR_{LO,HI})
+ * must be aligned to 1MB (the size addressable by a single page table).
+ * The CATU maps INADDR{LO:HI} to the first page in the table pointed
+ * to by SLADDR{LO:HI} and so on.
+ *
+ */
+typedef u64 cate_t;
+
+#define CATU_PAGE_SHIFT		12
+#define CATU_PAGE_SIZE		(1UL << CATU_PAGE_SHIFT)
+#define CATU_PAGES_PER_SYSPAGE	(PAGE_SIZE / CATU_PAGE_SIZE)
+
+/* Page pointers are only allocated in the first 2K half */
+#define CATU_PTRS_PER_PAGE	((CATU_PAGE_SIZE >> 1) / sizeof(cate_t))
+#define CATU_PTRS_PER_SYSPAGE	(CATU_PAGES_PER_SYSPAGE * CATU_PTRS_PER_PAGE)
+#define CATU_LINK_PREV		((CATU_PAGE_SIZE / sizeof(cate_t)) - 2)
+#define CATU_LINK_NEXT		((CATU_PAGE_SIZE / sizeof(cate_t)) - 1)
+
+#define CATU_ADDR_SHIFT		12
+#define CATU_ADDR_MASK		~(((cate_t)1 << CATU_ADDR_SHIFT) - 1)
+#define CATU_ENTRY_VALID	((cate_t)0x1)
+#define CATU_VALID_ENTRY(addr) \
+	(((cate_t)(addr) & CATU_ADDR_MASK) | CATU_ENTRY_VALID)
+#define CATU_ENTRY_ADDR(entry)	((cate_t)(entry) & ~((cate_t)CATU_ENTRY_VALID))
+
+/*
+ * catu_get_table : Retrieve the table pointers for the given @offset
+ * within the buffer. The buffer is wrapped around to a valid offset.
+ *
+ * Returns : The CPU virtual address for the beginning of the table
+ * containing the data page pointer for @offset. If @daddrp is not NULL,
+ * @daddrp points the DMA address of the beginning of the table.
+ */
+static inline cate_t *catu_get_table(struct tmc_sg_table *catu_table,
+				     unsigned long offset,
+				     dma_addr_t *daddrp)
+{
+	unsigned long buf_size = tmc_sg_table_buf_size(catu_table);
+	unsigned int table_nr, pg_idx, pg_offset;
+	struct tmc_pages *table_pages = &catu_table->table_pages;
+	void *ptr;
+
+	/* Make sure offset is within the range */
+	offset %= buf_size;
+
+	/*
+	 * Each table can address 1MB and a single kernel page can
+	 * contain "CATU_PAGES_PER_SYSPAGE" CATU tables.
+	 */
+	table_nr = offset >> 20;
+	/* Find the table page where the table_nr lies in */
+	pg_idx = table_nr / CATU_PAGES_PER_SYSPAGE;
+	pg_offset = (table_nr % CATU_PAGES_PER_SYSPAGE) * CATU_PAGE_SIZE;
+	if (daddrp)
+		*daddrp = table_pages->daddrs[pg_idx] + pg_offset;
+	ptr = page_address(table_pages->pages[pg_idx]);
+	return (cate_t *)((unsigned long)ptr + pg_offset);
+}
+
+#ifdef CATU_DEBUG
+static void catu_dump_table(struct tmc_sg_table *catu_table)
+{
+	int i;
+	cate_t *table;
+	unsigned long table_end, buf_size, offset = 0;
+
+	buf_size = tmc_sg_table_buf_size(catu_table);
+	dev_dbg(catu_table->dev,
+		"Dump table %p, tdaddr: %llx\n",
+		catu_table, catu_table->table_daddr);
+
+	while (offset < buf_size) {
+		table_end = offset + SZ_1M < buf_size ?
+			    offset + SZ_1M : buf_size;
+		table = catu_get_table(catu_table, offset, NULL);
+		for (i = 0; offset < table_end; i++, offset += CATU_PAGE_SIZE)
+			dev_dbg(catu_table->dev, "%d: %llx\n", i, table[i]);
+		dev_dbg(catu_table->dev, "Prev : %llx, Next: %llx\n",
+			table[CATU_LINK_PREV], table[CATU_LINK_NEXT]);
+		dev_dbg(catu_table->dev, "== End of sub-table ===");
+	}
+	dev_dbg(catu_table->dev, "== End of Table ===");
+}
+
+#else
+static inline void catu_dump_table(struct tmc_sg_table *catu_table)
+{
+}
+#endif
+
+static inline cate_t catu_make_entry(dma_addr_t addr)
+{
+	return addr ? CATU_VALID_ENTRY(addr) : 0;
+}
+
+/*
+ * catu_populate_table : Populate the given CATU table.
+ * The table is always populated as a circular table.
+ * i.e, the "prev" link of the "first" table points to the "last"
+ * table and the "next" link of the "last" table points to the
+ * "first" table. The buffer should be made linear by calling
+ * catu_set_table().
+ */
+static void
+catu_populate_table(struct tmc_sg_table *catu_table)
+{
+	int i;
+	int sys_pidx;	/* Index to current system data page */
+	int catu_pidx;	/* Index of CATU page within the system data page */
+	unsigned long offset, buf_size, table_end;
+	dma_addr_t data_daddr;
+	dma_addr_t prev_taddr, next_taddr, cur_taddr;
+	cate_t *table_ptr, *next_table;
+
+	buf_size = tmc_sg_table_buf_size(catu_table);
+	sys_pidx = catu_pidx = 0;
+	offset = 0;
+
+	table_ptr = catu_get_table(catu_table, 0, &cur_taddr);
+	prev_taddr = 0;	/* Prev link for the first table */
+
+	while (offset < buf_size) {
+		/*
+		 * The @offset is always 1M aligned here and we have an
+		 * empty table @table_ptr to fill. Each table can address
+		 * upto 1MB data buffer. The last table may have fewer
+		 * entries if the buffer size is not aligned.
+		 */
+		table_end = (offset + SZ_1M) < buf_size ?
+			    (offset + SZ_1M) : buf_size;
+		for (i = 0; offset < table_end;
+		     i++, offset += CATU_PAGE_SIZE) {
+
+			data_daddr = catu_table->data_pages.daddrs[sys_pidx] +
+				     catu_pidx * CATU_PAGE_SIZE;
+			catu_dbg(catu_table->dev,
+				"[table %5ld:%03d] 0x%llx\n",
+				(offset >> 20), i, data_daddr);
+			table_ptr[i] = catu_make_entry(data_daddr);
+			/* Move the pointers for data pages */
+			catu_pidx = (catu_pidx + 1) % CATU_PAGES_PER_SYSPAGE;
+			if (catu_pidx == 0)
+				sys_pidx++;
+		}
+
+		/*
+		 * If we have finished all the valid entries, fill the rest of
+		 * the table (i.e, last table page) with invalid entries,
+		 * to fail the lookups.
+		 */
+		if (offset == buf_size) {
+			memset(&table_ptr[i], 0,
+			       sizeof(cate_t) * (CATU_PTRS_PER_PAGE - i));
+			next_taddr = 0;
+		} else {
+			next_table = catu_get_table(catu_table,
+						    offset, &next_taddr);
+		}
+
+		table_ptr[CATU_LINK_PREV] = catu_make_entry(prev_taddr);
+		table_ptr[CATU_LINK_NEXT] = catu_make_entry(next_taddr);
+
+		catu_dbg(catu_table->dev,
+			"[table%5ld]: Cur: 0x%llx Prev: 0x%llx, Next: 0x%llx\n",
+			(offset >> 20) - 1,  cur_taddr, prev_taddr, next_taddr);
+
+		/* Update the prev/next addresses */
+		if (next_taddr) {
+			prev_taddr = cur_taddr;
+			cur_taddr = next_taddr;
+			table_ptr = next_table;
+		}
+	}
+
+	/* Sync the table for device */
+	tmc_sg_table_sync_table(catu_table);
+}
+
+static struct tmc_sg_table __maybe_unused *
+catu_init_sg_table(struct device *catu_dev, int node,
+		   ssize_t size, void **pages)
+{
+	int nr_tpages;
+	struct tmc_sg_table *catu_table;
+
+	/*
+	 * Each table can address upto 1MB and we can have
+	 * CATU_PAGES_PER_SYSPAGE tables in a system page.
+	 */
+	nr_tpages = DIV_ROUND_UP(size, SZ_1M) / CATU_PAGES_PER_SYSPAGE;
+	catu_table = tmc_alloc_sg_table(catu_dev, node, nr_tpages,
+					size >> PAGE_SHIFT, pages);
+	if (IS_ERR(catu_table))
+		return catu_table;
+
+	catu_populate_table(catu_table);
+	dev_dbg(catu_dev,
+		"Setup table %p, size %ldKB, %d table pages\n",
+		catu_table, (unsigned long)size >> 10,  nr_tpages);
+	catu_dump_table(catu_table);
+	return catu_table;
+}
+
 coresight_simple_reg32(struct catu_drvdata, devid, CORESIGHT_DEVID);
 coresight_simple_reg32(struct catu_drvdata, control, CATU_CONTROL);
 coresight_simple_reg32(struct catu_drvdata, status, CATU_STATUS);
-- 
2.9.5

