Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbeEDRfM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:35:12 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35025 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeEDRfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:35:11 -0400
X-Google-Smtp-Source: AB8JxZprJ+Q7f/rzooD4Xelrj8ASpdq86ypqoZ+H7rYgO4mooKDwWrjdOgvY45y2hmDw49gaq47usA==
Date: Fri, 4 May 2018 11:35:07 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com,
        Mathieu Poirier <matheiu.poirier@linaro.org>
Subject: Re: [PATCH v2 13/27] coresight: Add generic TMC sg table framework
Message-ID: <20180504173507.GA5981@xps15>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-14-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525165857-11096-14-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 10:10:43AM +0100, Suzuki K Poulose wrote:
> This patch introduces a generic sg table data structure and
> associated operations. An SG table can be used to map a set
> of Data pages where the trace data could be stored by the TMC
> ETR. The information about the data pages could be stored in
> different formats, depending on the type of the underlying
> SG mechanism (e.g, TMC ETR SG vs Coresight CATU). The generic
> structure provides book keeping of the pages used for the data
> as well as the table contents. The table should be filled by
> the user of the infrastructure.
> 
> A table can be created by specifying the number of data pages
> as well as the number of table pages required to hold the
> pointers, where the latter could be different for different
> types of tables. The pages are mapped in the appropriate dma
> data direction mode (i.e, DMA_TO_DEVICE for table pages
> and DMA_FROM_DEVICE for data pages).  The framework can optionally
> accept a set of allocated data pages (e.g, perf ring buffer) and
> map them accordingly. The table and data pages are vmap'ed to allow
> easier access by the drivers. The framework also provides helpers to
> sync the data written to the pages with appropriate directions.
> 
> This will be later used by the TMC ETR SG unit and CATU.
> 
> Cc: Mathieu Poirier <matheiu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 284 ++++++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-tmc.h     |  50 +++++
>  2 files changed, 334 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 7af72d7..57a8fe1 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -17,10 +17,294 @@
>  
>  #include <linux/coresight.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/slab.h>
>  #include "coresight-catu.h"
>  #include "coresight-priv.h"
>  #include "coresight-tmc.h"
>  
> +/*
> + * tmc_pages_get_offset:  Go through all the pages in the tmc_pages
> + * and map the device address @addr to an offset within the virtual
> + * contiguous buffer.
> + */
> +static long
> +tmc_pages_get_offset(struct tmc_pages *tmc_pages, dma_addr_t addr)
> +{
> +	int i;
> +	dma_addr_t page_start;
> +
> +	for (i = 0; i < tmc_pages->nr_pages; i++) {
> +		page_start = tmc_pages->daddrs[i];
> +		if (addr >= page_start && addr < (page_start + PAGE_SIZE))
> +			return i * PAGE_SIZE + (addr - page_start);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +/*
> + * tmc_pages_free : Unmap and free the pages used by tmc_pages.
> + */
> +static void tmc_pages_free(struct tmc_pages *tmc_pages,
> +			   struct device *dev, enum dma_data_direction dir)
> +{
> +	int i;
> +
> +	for (i = 0; i < tmc_pages->nr_pages; i++) {
> +		if (tmc_pages->daddrs && tmc_pages->daddrs[i])
> +			dma_unmap_page(dev, tmc_pages->daddrs[i],
> +					 PAGE_SIZE, dir);
> +		if (tmc_pages->pages && tmc_pages->pages[i])
> +			__free_page(tmc_pages->pages[i]);

I think it's worth adding a comment saying that because of the page count, pages
given to the infracstructure (rather than allocated) won't be free'ed by
__free_page().

> +	}
> +
> +	kfree(tmc_pages->pages);
> +	kfree(tmc_pages->daddrs);
> +	tmc_pages->pages = NULL;
> +	tmc_pages->daddrs = NULL;
> +	tmc_pages->nr_pages = 0;
> +}
> +
> +/*
> + * tmc_pages_alloc : Allocate and map pages for a given @tmc_pages.
> + * If @pages is not NULL, the list of page virtual addresses are
> + * used as the data pages. The pages are then dma_map'ed for @dev
> + * with dma_direction @dir.
> + *
> + * Returns 0 upon success, else the error number.
> + */
> +static int tmc_pages_alloc(struct tmc_pages *tmc_pages,
> +			   struct device *dev, int node,
> +			   enum dma_data_direction dir, void **pages)
> +{
> +	int i, nr_pages;
> +	dma_addr_t paddr;
> +	struct page *page;
> +
> +	nr_pages = tmc_pages->nr_pages;
> +	tmc_pages->daddrs = kcalloc(nr_pages, sizeof(*tmc_pages->daddrs),
> +					 GFP_KERNEL);
> +	if (!tmc_pages->daddrs)
> +		return -ENOMEM;
> +	tmc_pages->pages = kcalloc(nr_pages, sizeof(*tmc_pages->pages),
> +					 GFP_KERNEL);
> +	if (!tmc_pages->pages) {
> +		kfree(tmc_pages->daddrs);
> +		tmc_pages->daddrs = NULL;
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		if (pages && pages[i]) {
> +			page = virt_to_page(pages[i]);
> +			get_page(page);
> +		} else {
> +			page = alloc_pages_node(node,
> +						GFP_KERNEL | __GFP_ZERO, 0);
> +		}
> +		paddr = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
> +		if (dma_mapping_error(dev, paddr))
> +			goto err;
> +		tmc_pages->daddrs[i] = paddr;
> +		tmc_pages->pages[i] = page;
> +	}
> +	return 0;
> +err:
> +	tmc_pages_free(tmc_pages, dev, dir);
> +	return -ENOMEM;
> +}
> +
> +static inline dma_addr_t tmc_sg_table_base_paddr(struct tmc_sg_table *sg_table)
> +{
> +	if (WARN_ON(!sg_table->data_pages.pages[0]))
> +		return 0;
> +	return sg_table->table_daddr;
> +}
> +
> +static inline void *tmc_sg_table_base_vaddr(struct tmc_sg_table *sg_table)
> +{
> +	if (WARN_ON(!sg_table->data_pages.pages[0]))
> +		return NULL;
> +	return sg_table->table_vaddr;
> +}
> +
> +static inline void *
> +tmc_sg_table_data_vaddr(struct tmc_sg_table *sg_table)
> +{
> +	if (WARN_ON(!sg_table->data_pages.nr_pages))
> +		return 0;
> +	return sg_table->data_vaddr;
> +}
> +
> +static inline long
> +tmc_sg_get_data_page_offset(struct tmc_sg_table *sg_table, dma_addr_t addr)
> +{
> +	return tmc_pages_get_offset(&sg_table->data_pages, addr);
> +}
> +
> +static inline void tmc_free_table_pages(struct tmc_sg_table *sg_table)
> +{
> +	if (sg_table->table_vaddr)
> +		vunmap(sg_table->table_vaddr);
> +	tmc_pages_free(&sg_table->table_pages, sg_table->dev, DMA_TO_DEVICE);
> +}
> +
> +static void tmc_free_data_pages(struct tmc_sg_table *sg_table)
> +{
> +	if (sg_table->data_vaddr)
> +		vunmap(sg_table->data_vaddr);
> +	tmc_pages_free(&sg_table->data_pages, sg_table->dev, DMA_FROM_DEVICE);
> +}
> +
> +void tmc_free_sg_table(struct tmc_sg_table *sg_table)
> +{
> +	tmc_free_table_pages(sg_table);
> +	tmc_free_data_pages(sg_table);
> +}
> +
> +/*
> + * Alloc pages for the table. Since this will be used by the device,
> + * allocate the pages closer to the device (i.e, dev_to_node(dev)
> + * rather than the CPU node).
> + */
> +static int tmc_alloc_table_pages(struct tmc_sg_table *sg_table)
> +{
> +	int rc;
> +	struct tmc_pages *table_pages = &sg_table->table_pages;
> +
> +	rc = tmc_pages_alloc(table_pages, sg_table->dev,
> +			     dev_to_node(sg_table->dev),
> +			     DMA_TO_DEVICE, NULL);
> +	if (rc)
> +		return rc;
> +	sg_table->table_vaddr = vmap(table_pages->pages,
> +				     table_pages->nr_pages,
> +				     VM_MAP,
> +				     PAGE_KERNEL);
> +	if (!sg_table->table_vaddr)
> +		rc = -ENOMEM;
> +	else
> +		sg_table->table_daddr = table_pages->daddrs[0];
> +	return rc;
> +}
> +
> +static int tmc_alloc_data_pages(struct tmc_sg_table *sg_table, void **pages)
> +{
> +	int rc;
> +
> +	/* Allocate data pages on the node requested by the caller */
> +	rc = tmc_pages_alloc(&sg_table->data_pages,
> +			     sg_table->dev, sg_table->node,
> +			     DMA_FROM_DEVICE, pages);
> +	if (!rc) {
> +		sg_table->data_vaddr = vmap(sg_table->data_pages.pages,
> +					   sg_table->data_pages.nr_pages,
> +					   VM_MAP,
> +					   PAGE_KERNEL);

Indentation.

> +		if (!sg_table->data_vaddr)
> +			rc = -ENOMEM;
> +	}
> +	return rc;
> +}
> +
> +/*
> + * tmc_alloc_sg_table: Allocate and setup dma pages for the TMC SG table
> + * and data buffers. TMC writes to the data buffers and reads from the SG
> + * Table pages.
> + *
> + * @dev		- Device to which page should be DMA mapped.
> + * @node	- Numa node for mem allocations
> + * @nr_tpages	- Number of pages for the table entries.
> + * @nr_dpages	- Number of pages for Data buffer.
> + * @pages	- Optional list of virtual address of pages.
> + */
> +struct tmc_sg_table *tmc_alloc_sg_table(struct device *dev,
> +					int node,
> +					int nr_tpages,
> +					int nr_dpages,
> +					void **pages)
> +{
> +	long rc;
> +	struct tmc_sg_table *sg_table;
> +
> +	sg_table = kzalloc(sizeof(*sg_table), GFP_KERNEL);
> +	if (!sg_table)
> +		return ERR_PTR(-ENOMEM);
> +	sg_table->data_pages.nr_pages = nr_dpages;
> +	sg_table->table_pages.nr_pages = nr_tpages;
> +	sg_table->node = node;
> +	sg_table->dev = dev;
> +
> +	rc  = tmc_alloc_data_pages(sg_table, pages);
> +	if (!rc)
> +		rc = tmc_alloc_table_pages(sg_table);
> +	if (rc) {
> +		tmc_free_sg_table(sg_table);
> +		kfree(sg_table);
> +		return ERR_PTR(rc);
> +	}
> +
> +	return sg_table;
> +}
> +
> +/*
> + * tmc_sg_table_sync_data_range: Sync the data buffer written
> + * by the device from @offset upto a @size bytes.
> + */
> +void tmc_sg_table_sync_data_range(struct tmc_sg_table *table,
> +				  u64 offset, u64 size)
> +{
> +	int i, index, start;
> +	int npages = DIV_ROUND_UP(size, PAGE_SIZE);
> +	struct device *dev = table->dev;
> +	struct tmc_pages *data = &table->data_pages;
> +
> +	start = offset >> PAGE_SHIFT;
> +	for (i = start; i < (start + npages); i++) {
> +		index = i % data->nr_pages;
> +		dma_sync_single_for_cpu(dev, data->daddrs[index],
> +					PAGE_SIZE, DMA_FROM_DEVICE);
> +	}
> +}
> +
> +/* tmc_sg_sync_table: Sync the page table */
> +void tmc_sg_table_sync_table(struct tmc_sg_table *sg_table)
> +{
> +	int i;
> +	struct device *dev = sg_table->dev;
> +	struct tmc_pages *table_pages = &sg_table->table_pages;
> +
> +	for (i = 0; i < table_pages->nr_pages; i++)
> +		dma_sync_single_for_device(dev, table_pages->daddrs[i],
> +					   PAGE_SIZE, DMA_TO_DEVICE);
> +}
> +
> +/*
> + * tmc_sg_table_get_data: Get the buffer pointer for data @offset
> + * in the SG buffer. The @bufpp is updated to point to the buffer.
> + * Returns :
> + *	the length of linear data available at @offset.
> + *	or
> + *	<= 0 if no data is available.
> + */
> +ssize_t tmc_sg_table_get_data(struct tmc_sg_table *sg_table,
> +				u64 offset, size_t len, char **bufpp)

Indentation

> +{
> +	size_t size;
> +	int pg_idx = offset >> PAGE_SHIFT;
> +	int pg_offset = offset & (PAGE_SIZE - 1);
> +	struct tmc_pages *data_pages = &sg_table->data_pages;
> +
> +	size = tmc_sg_table_buf_size(sg_table);
> +	if (offset >= size)
> +		return -EINVAL;

        /* Make sure we don't go beyond the page array */

> +	len = (len < (size - offset)) ? len : size - offset;

        /* Respect page boundaries */

> +	len = (len < (PAGE_SIZE - pg_offset)) ? len : (PAGE_SIZE - pg_offset);
> +	if (len > 0)
> +		*bufpp = page_address(data_pages->pages[pg_idx]) + pg_offset;
> +	return len;
> +}
> +
>  static inline void tmc_etr_enable_catu(struct tmc_drvdata *drvdata)
>  {
>  	struct coresight_device *catu = tmc_etr_get_catu_device(drvdata);
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 9cbc4d5..74d8f24 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -19,6 +19,7 @@
>  #define _CORESIGHT_TMC_H
>  
>  #include <linux/miscdevice.h>
> +#include <linux/dma-mapping.h>

Alphabetial order.

>  #include "coresight-catu.h"
>  
>  #define TMC_RSZ			0x004
> @@ -172,6 +173,38 @@ struct tmc_drvdata {
>  	u32			etr_caps;
>  };
>  
> +/**
> + * struct tmc_pages - Collection of pages used for SG.
> + * @nr_pages:		Number of pages in the list.
> + * @daddrs:		Array of DMA'able page address.
> + * @pages:		Array pages for the buffer.
> + */
> +struct tmc_pages {
> +	int nr_pages;
> +	dma_addr_t	*daddrs;
> +	struct page	**pages;
> +};
> +
> +/*
> + * struct tmc_sg_table - Generic SG table for TMC
> + * @dev:		Device for DMA allocations
> + * @table_vaddr:	Contiguous Virtual address for PageTable
> + * @data_vaddr:		Contiguous Virtual address for Data Buffer
> + * @table_daddr:	DMA address of the PageTable base
> + * @node:		Node for Page allocations
> + * @table_pages:	List of pages & dma address for Table
> + * @data_pages:		List of pages & dma address for Data
> + */
> +struct tmc_sg_table {
> +	struct device *dev;
> +	void *table_vaddr;
> +	void *data_vaddr;
> +	dma_addr_t table_daddr;
> +	int node;
> +	struct tmc_pages table_pages;
> +	struct tmc_pages data_pages;
> +};
> +
>  /* Generic functions */
>  void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
>  void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
> @@ -253,4 +286,21 @@ tmc_etr_get_catu_device(struct tmc_drvdata *drvdata)
>  	return NULL;
>  }
>  
> +struct tmc_sg_table *tmc_alloc_sg_table(struct device *dev,
> +					int node,
> +					int nr_tpages,
> +					int nr_dpages,
> +					void **pages);
> +void tmc_free_sg_table(struct tmc_sg_table *sg_table);
> +void tmc_sg_table_sync_table(struct tmc_sg_table *sg_table);
> +void tmc_sg_table_sync_data_range(struct tmc_sg_table *table,
> +				  u64 offset, u64 size);
> +ssize_t tmc_sg_table_get_data(struct tmc_sg_table *sg_table,
> +			      u64 offset, size_t len, char **bufpp);
> +static inline unsigned long
> +tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
> +{
> +	return sg_table->data_pages.nr_pages << PAGE_SHIFT;
> +}
> +
>  #endif
> -- 
> 2.7.4
> 
