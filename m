Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbeEGUZX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:25:23 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43287 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeEGUZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:25:22 -0400
X-Google-Smtp-Source: AB8JxZrfyLg4b3jG4bKo4YuoJr6o0UykyFRoKtoiJ4PcahUSUlmUaZDAJ0qLcw+Imz1vFcgDACdnOg==
Date: Mon, 7 May 2018 14:25:17 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com
Subject: Re: [PATCH v2 18/27] coresight: catu: Add support for scatter gather
 tables
Message-ID: <20180507202517.GC32594@xps15>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-19-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525165857-11096-19-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 10:10:48AM +0100, Suzuki K Poulose wrote:
> This patch adds the support for setting up a SG table for use
> by the CATU. We reuse the tmc_sg_table to represent the table/data
> pages, even though the table format is different.
> 
> Similar to ETR SG table, CATU uses a 4KB page size for data buffers
> as well as page tables. All table entries are 64bit wide and have
> the following format:
> 
>         63                      12      1  0
>         x-----------------------------------x
>         |        Address [63-12] | SBZ  | V |
>         x-----------------------------------x
> 
> 	Where [V] ->	 0 - Pointer is invalid
> 			 1 - Pointer is Valid
> 
> CATU uses only first half of the page for data page pointers.
> i.e, single table page will only have 256 page pointers, addressing
> upto 1MB of data. The second half of a table page contains only two
> pointers at the end of the page (i.e, pointers at index 510 and 511),
> which are used as links to the "Previous" and "Next" page tables
> respectively.
> 
> The first table page has an "Invalid" previous pointer and the
> next pointer entry points to the second page table if there is one.
> Similarly the last table page has an "Invalid" next pointer to
> indicate the end of the table chain.
> 
> We create a circular buffer (i.e, first_table[prev] => last_table
> and last_table[next] => first_table) by default and provide
> helpers to make the buffer linear from a given offset. When we
> set the buffer to linear, we also mark the "pointers" in the
> outside the given "range" as invalid. We have to do this only
> for the starting and ending tables, as we disconnect the other
> table by invalidating the links. This will allow the ETR buf to
> be restored from a given offset with any size.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c | 409 +++++++++++++++++++++++++++
>  1 file changed, 409 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index 2cd69a6..4cc2928 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -16,10 +16,419 @@
>  
>  #include "coresight-catu.h"
>  #include "coresight-priv.h"
> +#include "coresight-tmc.h"
>  
>  #define csdev_to_catu_drvdata(csdev)	\
>  	dev_get_drvdata(csdev->dev.parent)
>  
> +/*
> + * CATU uses a page size of 4KB for page tables as well as data pages.
> + * Each 64bit entry in the table has the following format.
> + *
> + *	63			12	1  0
> + *	------------------------------------
> + *	|	 Address [63-12] | SBZ	| V|
> + *	------------------------------------
> + *
> + * Where bit[0] V indicates if the address is valid or not.
> + * Each 4K table pages have upto 256 data page pointers, taking upto 2K
> + * size. There are two Link pointers, pointing to the previous and next
> + * table pages respectively at the end of the 4K page. (i.e, entry 510
> + * and 511).
> + *  E.g, a table of two pages could look like :
> + *
> + *                 Table Page 0               Table Page 1
> + * SLADDR ===> x------------------x  x--> x-----------------x
> + * INADDR    ->|  Page 0      | V |  |    | Page 256    | V | <- INADDR+1M
> + *             |------------------|  |    |-----------------|
> + * INADDR+4K ->|  Page 1      | V |  |    |                 |
> + *             |------------------|  |    |-----------------|
> + *             |  Page 2      | V |  |    |                 |
> + *             |------------------|  |    |-----------------|
> + *             |   ...        | V |  |    |    ...          |
> + *             |------------------|  |    |-----------------|
> + * INADDR+1020K|  Page 255    | V |  |    |   Page 511  | V |
> + * SLADDR+2K==>|------------------|  |    |-----------------|
> + *             |  UNUSED      |   |  |    |                 |
> + *             |------------------|  |    |                 |
> + *             |  UNUSED      |   |  |    |                 |
> + *             |------------------|  |    |                 |
> + *             |    ...       |   |  |    |                 |
> + *             |------------------|  |    |-----------------|
> + *             |   IGNORED    | 0 |  |    | Table Page 0| 1 |
> + *             |------------------|  |    |-----------------|
> + *             |  Table Page 1| 1 |--x    | IGNORED     | 0 |
> + *             x------------------x       x-----------------x
> + * SLADDR+4K==>
> + *
> + * The base input address (used by the ETR, programmed in INADDR_{LO,HI})
> + * must be aligned to 1MB (the size addressable by a single page table).
> + * The CATU maps INADDR{LO:HI} to the first page in the table pointed
> + * to by SLADDR{LO:HI} and so on.
> + *
> + */
> +typedef u64 cate_t;
> +
> +#define CATU_PAGE_SHIFT		12
> +#define CATU_PAGE_SIZE		(1UL << CATU_PAGE_SHIFT)
> +#define CATU_PAGES_PER_SYSPAGE	(PAGE_SIZE / CATU_PAGE_SIZE)
> +
> +/* Page pointers are only allocated in the first 2K half */
> +#define CATU_PTRS_PER_PAGE	((CATU_PAGE_SIZE >> 1) / sizeof(cate_t))
> +#define CATU_PTRS_PER_SYSPAGE	(CATU_PAGES_PER_SYSPAGE * CATU_PTRS_PER_PAGE)
> +#define CATU_LINK_PREV		((CATU_PAGE_SIZE / sizeof(cate_t)) - 2)
> +#define CATU_LINK_NEXT		((CATU_PAGE_SIZE / sizeof(cate_t)) - 1)
> +
> +#define CATU_ADDR_SHIFT		12
> +#define CATU_ADDR_MASK		~(((cate_t)1 << CATU_ADDR_SHIFT) - 1)
> +#define CATU_ENTRY_VALID	((cate_t)0x1)
> +#define CATU_ENTRY_INVALID	((cate_t)0)
> +#define CATU_VALID_ENTRY(addr) \
> +	(((cate_t)(addr) & CATU_ADDR_MASK) | CATU_ENTRY_VALID)
> +#define CATU_ENTRY_ADDR(entry)	((cate_t)(entry) & ~((cate_t)CATU_ENTRY_VALID))
> +
> +/*
> + * Index into the CATU entry pointing to the page within
> + * the table. Each table entry can point to a 4KB page, with
> + * a total of 255 entries in the table adding upto 1MB per table.
> + *
> + * So, bits 19:12 gives you the index of the entry in
> + * the table.
> + */
> +static inline unsigned long catu_offset_to_entry_idx(unsigned long offset)
> +{
> +	return (offset & (SZ_1M - 1)) >> 12;
> +}
> +
> +static inline void catu_update_state(cate_t *catep, int valid)
> +{
> +	*catep &= ~CATU_ENTRY_VALID;
> +	*catep |= valid ? CATU_ENTRY_VALID : CATU_ENTRY_INVALID;
> +}
> +
> +/*
> + * Update the valid bit for a given range of indices [start, end)
> + * in the given table @table.
> + */
> +static inline void catu_update_state_range(cate_t *table, int start,
> +						 int end, int valid)

Indentation

> +{
> +	int i;
> +	cate_t *pentry = &table[start];
> +	cate_t state = valid ? CATU_ENTRY_VALID : CATU_ENTRY_INVALID;
> +
> +	/* Limit the "end" to maximum range */
> +	if (end > CATU_PTRS_PER_PAGE)
> +		end = CATU_PTRS_PER_PAGE;
> +
> +	for (i = start; i < end; i++, pentry++) {
> +		*pentry &= ~(cate_t)CATU_ENTRY_VALID;
> +		*pentry |= state;
> +	}
> +}
> +
> +/*
> + * Update valid bit for all entries in the range [start, end)
> + */
> +static inline void
> +catu_table_update_offset_range(cate_t *table,
> +			       unsigned long start,
> +			       unsigned long end,
> +			       int valid)
> +{
> +	catu_update_state_range(table,
> +				catu_offset_to_entry_idx(start),
> +				catu_offset_to_entry_idx(end),
> +				valid);
> +}
> +
> +static inline void catu_table_update_prev(cate_t *table, int valid)
> +{
> +	catu_update_state(&table[CATU_LINK_PREV], valid);
> +}
> +
> +static inline void catu_table_update_next(cate_t *table, int valid)
> +{
> +	catu_update_state(&table[CATU_LINK_NEXT], valid);
> +}
> +
> +/*
> + * catu_get_table : Retrieve the table pointers for the given @offset
> + * within the buffer. The buffer is wrapped around to a valid offset.
> + *
> + * Returns : The CPU virtual address for the beginning of the table
> + * containing the data page pointer for @offset. If @daddrp is not NULL,
> + * @daddrp points the DMA address of the beginning of the table.
> + */
> +static inline cate_t *catu_get_table(struct tmc_sg_table *catu_table,
> +				     unsigned long offset,
> +				     dma_addr_t *daddrp)
> +{
> +	unsigned long buf_size = tmc_sg_table_buf_size(catu_table);
> +	unsigned int table_nr, pg_idx, pg_offset;
> +	struct tmc_pages *table_pages = &catu_table->table_pages;
> +	void *ptr;
> +
> +	/* Make sure offset is within the range */
> +	offset %= buf_size;
> +
> +	/*
> +	 * Each table can address 1MB and a single kernel page can
> +	 * contain "CATU_PAGES_PER_SYSPAGE" CATU tables.
> +	 */
> +	table_nr = offset >> 20;
> +	/* Find the table page where the table_nr lies in */
> +	pg_idx = table_nr / CATU_PAGES_PER_SYSPAGE;
> +	pg_offset = (table_nr % CATU_PAGES_PER_SYSPAGE) * CATU_PAGE_SIZE;
> +	if (daddrp)
> +		*daddrp = table_pages->daddrs[pg_idx] + pg_offset;
> +	ptr = page_address(table_pages->pages[pg_idx]);
> +	return (cate_t *)((unsigned long)ptr + pg_offset);
> +}
> +
> +#ifdef CATU_DEBUG
> +static void catu_dump_table(struct tmc_sg_table *catu_table)
> +{
> +	int i;
> +	cate_t *table;
> +	unsigned long table_end, buf_size, offset = 0;
> +
> +	buf_size = tmc_sg_table_buf_size(catu_table);
> +	dev_dbg(catu_table->dev,
> +		"Dump table %p, tdaddr: %llx\n",
> +		catu_table, catu_table->table_daddr);
> +
> +	while (offset < buf_size) {
> +		table_end = offset + SZ_1M < buf_size ?
> +			    offset + SZ_1M : buf_size;
> +		table = catu_get_table(catu_table, offset, NULL);
> +		for (i = 0; offset < table_end; i++, offset += CATU_PAGE_SIZE)
> +			dev_dbg(catu_table->dev, "%d: %llx\n", i, table[i]);
> +		dev_dbg(catu_table->dev, "Prev : %llx, Next: %llx\n",
> +			table[CATU_LINK_PREV], table[CATU_LINK_NEXT]);
> +		dev_dbg(catu_table->dev, "== End of sub-table ===");
> +	}
> +	dev_dbg(catu_table->dev, "== End of Table ===");
> +}
> +
> +#else
> +static inline void catu_dump_table(struct tmc_sg_table *catu_table)
> +{
> +}
> +#endif

I think this approach is better than peppering the code with #ifdefs as it was
done for ETR.  Please fix that to replicate what you've done here.

> +
> +/*
> + * catu_update_table: Update the start and end tables for the
> + * region [base, base + size) to, validate/invalidate the pointers
> + * outside the area.
> + *
> + * CATU expects the table base address (SLADDR) aligned to 4K.
> + * If the @base is not aligned to 1MB, we should mark all the
> + * pointers in the start table before @base "INVALID".
> + * Similarly all pointers in the last table beyond (@base + @size)
> + * should be marked INVALID.
> + * The table page containinig the "base" is marked first (by
> + * marking the previous link INVALID) and the table page
> + * containing "base + size" is marked last (by marking next
> + * link INVALID).
> + * By default we have to update the state of pointers
> + * for offsets in the range :
> + *    Start table: [0, ALIGN_DOWN(base))
> + *    End table  : [ALIGN(end + 1), SZ_1M)
> + * But, if we the buffer wraps around and ends in the same table
> + * as the "base", (i,e this should be :
> + *         [ALIGN(end + 1), base)
> + *
> + * Returns the dma_address for the start_table, which can be set as
> + * SLADDR.
> + */
> +static dma_addr_t catu_update_table(struct tmc_sg_table *catu_table,
> +				    u64 base, u64 size, int valid)
> +{
> +	cate_t *start_table, *end_table;
> +	dma_addr_t taddr;
> +	u64 buf_size, end = base + size - 1;
> +	unsigned int start_off = 0;	/* Offset to begin in start_table */
> +	unsigned int end_off = SZ_1M;	/* Offset to end in the end_table */
> +
> +	buf_size = tmc_sg_table_buf_size(catu_table);
> +	if (end > buf_size)
> +		end -= buf_size;
> +
> +	/* Get both the virtual and the DMA address of the first table */
> +	start_table = catu_get_table(catu_table, base, &taddr);
> +	end_table = catu_get_table(catu_table, end, NULL);
> +
> +	/* Update the "PREV" link for the starting table */
> +	catu_table_update_prev(start_table, valid);
> +
> +	/* Update the "NEXT" link only if this is not the start_table */
> +	if (end_table != start_table) {
> +		catu_table_update_next(end_table, valid);
> +	} else if (end < base) {
> +		/*
> +		 * If the buffer has wrapped around and we have got the
> +		 * "end" before "base" in the same table, we need to be
> +		 * extra careful. We only need to invalidate the ptrs
> +		 * in between the "end" and "base".
> +		 */
> +		start_off = ALIGN(end, CATU_PAGE_SIZE);
> +		end_off = 0;
> +	}
> +
> +	/* Update the pointers in the starting table before the "base" */
> +	catu_table_update_offset_range(start_table,
> +				       start_off,
> +				       base,
> +				       valid);
> +	if (end_off)
> +		catu_table_update_offset_range(end_table,
> +					       end,
> +					       end_off,
> +					       valid);
> +
> +	catu_dump_table(catu_table);
> +	return taddr;
> +}
> +
> +/*
> + * catu_set_table : Set the buffer to act as linear buffer
> + * from @base of @size.
> + *
> + * Returns : The DMA address for the table containing base.
> + * This can then be programmed into SLADDR.
> + */
> +static dma_addr_t
> +catu_set_table(struct tmc_sg_table *catu_table, u64 base, u64 size)
> +{
> +	/* Make all the entries outside this range invalid */
> +	dma_addr_t sladdr =  catu_update_table(catu_table, base, size, 0);
> +	/* Sync the changes to memory for CATU */
> +	tmc_sg_table_sync_table(catu_table);
> +	return sladdr;
> +}
> +
> +static void __maybe_unused
> +catu_reset_table(struct tmc_sg_table *catu_table, u64 base, u64 size)
> +{
> +	/* Make all the entries outside this range valid */
> +	(void)catu_update_table(catu_table, base, size, 1);
> +}
> +
> +/*
> + * catu_populate_table : Populate the given CATU table.
> + * The table is always populated as a circular table.
> + * i.e, the "prev" link of the "first" table points to the "last"
> + * table and the "next" link of the "last" table points to the
> + * "first" table. The buffer should be made linear by calling
> + * catu_set_table().
> + */
> +static void
> +catu_populate_table(struct tmc_sg_table *catu_table)
> +{
> +	int i, dpidx, s_dpidx;
> +	unsigned long offset, buf_size, last_offset;
> +	dma_addr_t data_daddr;
> +	dma_addr_t prev_taddr, next_taddr, cur_taddr;
> +	cate_t *table_ptr, *next_table;
> +
> +	buf_size = tmc_sg_table_buf_size(catu_table);
> +	dpidx = s_dpidx = 0;
> +	offset = 0;
> +
> +	table_ptr = catu_get_table(catu_table, 0, &cur_taddr);
> +	/*
> +	 * Use the address of the "last" table as the "prev" link
> +	 * for the first table.
> +	 */
> +	(void)catu_get_table(catu_table, buf_size - 1, &prev_taddr);
> +
> +	while (offset < buf_size) {
> +		/*
> +		 * The @offset is always 1M aligned here and we have an
> +		 * empty table @table_ptr to fill. Each table can address
> +		 * upto 1MB data buffer. The last table may have fewer
> +		 * entries if the buffer size is not aligned.
> +		 */
> +		last_offset = (offset + SZ_1M) < buf_size ?
> +			      (offset + SZ_1M) : buf_size;
> +		for (i = 0; offset < last_offset; i++) {
> +
> +			data_daddr = catu_table->data_pages.daddrs[dpidx] +
> +				     s_dpidx * CATU_PAGE_SIZE;
> +#ifdef CATU_DEBUG
> +			dev_dbg(catu_table->dev,
> +				"[table %5d:%03d] 0x%llx\n",
> +				(offset >> 20), i, data_daddr);
> +#endif

I'm not a fan of adding #ifdefs in the code like this.  I think it is better to
have a wrapper (that resolves to nothing if CATU_DEBUG is not defined) and
handle the output in there. 

> +			table_ptr[i] = CATU_VALID_ENTRY(data_daddr);
> +			offset += CATU_PAGE_SIZE;
> +			/* Move the pointers for data pages */
> +			s_dpidx = (s_dpidx + 1) % CATU_PAGES_PER_SYSPAGE;
> +			if (s_dpidx == 0)
> +				dpidx++;
> +		}
> +
> +		/*
> +		 * If we have finished all the valid entries, fill the rest of
> +		 * the table (i.e, last table page) with invalid entries,
> +		 * to fail the lookups.
> +		 */
> +		if (offset == buf_size)
> +			catu_table_update_offset_range(table_ptr,
> +						       offset - 1, SZ_1M, 0);
> +
> +		/*
> +		 * Find the next table by looking up the table that contains
> +		 * @offset. For the last table, this will return the very
> +		 * first table (as the offset == buf_size, and thus returns
> +		 * the table for offset = 0.)
> +		 */
> +		next_table = catu_get_table(catu_table, offset, &next_taddr);
> +		table_ptr[CATU_LINK_PREV] = CATU_VALID_ENTRY(prev_taddr);
> +		table_ptr[CATU_LINK_NEXT] = CATU_VALID_ENTRY(next_taddr);
> +
> +#ifdef CATU_DEBUG
> +		dev_dbg(catu_table->dev,
> +			"[table%5d]: Cur: 0x%llx Prev: 0x%llx, Next: 0x%llx\n",
> +			(offset >> 20) - 1,  cur_taddr, prev_taddr, next_taddr);
> +#endif
> +
> +		/* Update the prev/next addresses */
> +		prev_taddr = cur_taddr;
> +		cur_taddr = next_taddr;
> +		table_ptr = next_table;
> +	}
> +}
> +
> +static struct tmc_sg_table __maybe_unused *
> +catu_init_sg_table(struct device *catu_dev, int node,
> +		   ssize_t size, void **pages)
> +{
> +	int nr_tpages;
> +	struct tmc_sg_table *catu_table;
> +
> +	/*
> +	 * Each table can address upto 1MB and we can have
> +	 * CATU_PAGES_PER_SYSPAGE tables in a system page.
> +	 */
> +	nr_tpages = DIV_ROUND_UP(size, SZ_1M) / CATU_PAGES_PER_SYSPAGE;
> +	catu_table = tmc_alloc_sg_table(catu_dev, node, nr_tpages,
> +					size >> PAGE_SHIFT, pages);
> +	if (IS_ERR(catu_table))
> +		return catu_table;
> +
> +	catu_populate_table(catu_table);
> +	/* Make the buf linear from offset 0 */
> +	(void)catu_set_table(catu_table, 0, size);
> +
> +	dev_dbg(catu_dev,
> +		"Setup table %p, size %ldKB, %d table pages\n",
> +		catu_table, (unsigned long)size >> 10,  nr_tpages);

I think this should also be wrapped in a special output debug function.

> +	catu_dump_table(catu_table);
> +	return catu_table;
> +}
> +
>  coresight_simple_reg32(struct catu_drvdata, control, CATU_CONTROL);
>  coresight_simple_reg32(struct catu_drvdata, status, CATU_STATUS);
>  coresight_simple_reg32(struct catu_drvdata, mode, CATU_MODE);
> -- 
> 2.7.4
> 
