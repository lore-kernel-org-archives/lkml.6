Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A75C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FC020866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfAPSKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:10:17 -0500
Received: from foss.arm.com ([217.140.101.70]:54470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfAPSKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:10:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3330180D;
        Wed, 16 Jan 2019 10:10:16 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 429423F763;
        Wed, 16 Jan 2019 10:10:15 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dma-debug: add dumping facility via debugfs
To:     Corentin Labbe <clabbe@baylibre.com>, hch@lst.de,
        m.szyprowski@samsung.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1547646265-9414-1-git-send-email-clabbe@baylibre.com>
Message-ID: <2f43688f-9c08-a9c4-6175-caa3d2e40261@arm.com>
Date:   Wed, 16 Jan 2019 18:10:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547646265-9414-1-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2019 13:44, Corentin Labbe wrote:
> While debugging a DMA mapping leak, I needed to access
> debug_dma_dump_mappings() but easily from user space.
> 
> This patch adds a /sys/kernel/debug/dma-api/dump file which contain all
> current DMA mapping.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>   kernel/dma/debug.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 23cf5361bcf1..9253382f5729 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -144,6 +144,7 @@ static struct dentry *num_free_entries_dent __read_mostly;
>   static struct dentry *min_free_entries_dent __read_mostly;
>   static struct dentry *nr_total_entries_dent __read_mostly;
>   static struct dentry *filter_dent           __read_mostly;
> +static struct dentry *dump_dent             __read_mostly;
>   
>   /* per-driver filter related state */
>   
> @@ -840,6 +841,47 @@ static const struct file_operations filter_fops = {
>   	.llseek = default_llseek,
>   };
>   
> +static int dump_read(struct seq_file *seq, void *v)
> +{
> +	int idx;
> +
> +	for (idx = 0; idx < HASH_SIZE; idx++) {
> +		struct hash_bucket *bucket = &dma_entry_hash[idx];
> +		struct dma_debug_entry *entry;
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&bucket->lock, flags);
> +
> +		list_for_each_entry(entry, &bucket->list, list) {
> +			seq_printf(seq,
> +				   "%s %s %s idx %d P=%llx N=%lx D=%llx L=%llx %s %s\n",
> +				   dev_name(entry->dev),
> +				   dev_driver_string(entry->dev),
> +				   type2name[entry->type], idx,
> +				   phys_addr(entry), entry->pfn,
> +				   entry->dev_addr, entry->size,
> +				   dir2name[entry->direction],
> +				   maperr2str[entry->map_err_type]);
> +		}
> +
> +		spin_unlock_irqrestore(&bucket->lock, flags);
> +	}
> +	return 0;
> +}

It's a shame that this is pretty much a duplication of 
debug_dma_dump_mappings(), but there seems no straightforward way to 
define one in terms of the other :/

(although given that we'd rather not have that weird external interface 
anyway, maybe "now you can use debugfs instead" might be justification 
enough for cleaning it up...)

> +
> +static int dump_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, dump_read, inode->i_private);
> +}
> +
> +static const struct file_operations dump_fops = {
> +	.owner = THIS_MODULE,
> +	.open = dump_open,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +

DEFINE_SHOW_ATTRIBUTE()?

Robin.

>   static int dma_debug_fs_init(void)
>   {
>   	dma_debug_dent = debugfs_create_dir("dma-api", NULL);
> @@ -894,6 +936,11 @@ static int dma_debug_fs_init(void)
>   	if (!filter_dent)
>   		goto out_err;
>   
> +	dump_dent = debugfs_create_file("dump", 0444,
> +					dma_debug_dent, NULL, &dump_fops);
> +	if (!dump_dent)
> +		goto out_err;
> +
>   	return 0;
>   
>   out_err:
> 
