Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D20FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1125A21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfAVSom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:44:42 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58918 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfAVSom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:44:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0139EBD;
        Tue, 22 Jan 2019 10:44:41 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E94C3F5C1;
        Tue, 22 Jan 2019 10:44:40 -0800 (PST)
Subject: Re: [PATCH] dma: debug: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org,
        Corentin Labbe <clabbe@baylibre.com>
References: <20190122152151.16139-39-gregkh@linuxfoundation.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2b974ef1-4336-8187-cbc5-ba2a14691837@arm.com>
Date:   Tue, 22 Jan 2019 18:44:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190122152151.16139-39-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 22/01/2019 15:21, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Also delete the variables for the file dentries for the debugfs entries
> as they are never used at all once they are created.

Modulo one nit below, I certainly approve of the cleanup :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   kernel/dma/debug.c | 81 ++++++----------------------------------------
>   1 file changed, 10 insertions(+), 71 deletions(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 23cf5361bcf1..2f5fc8b9d39f 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -136,14 +136,6 @@ static u32 nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
>   
>   /* debugfs dentry's for the stuff above */
>   static struct dentry *dma_debug_dent        __read_mostly;

Does this actually need to be at file scope, or could it be punted to a 
local in dma_debug_fs_init() while we're here?

Robin.

> -static struct dentry *global_disable_dent   __read_mostly;
> -static struct dentry *error_count_dent      __read_mostly;
> -static struct dentry *show_all_errors_dent  __read_mostly;
> -static struct dentry *show_num_errors_dent  __read_mostly;
> -static struct dentry *num_free_entries_dent __read_mostly;
> -static struct dentry *min_free_entries_dent __read_mostly;
> -static struct dentry *nr_total_entries_dent __read_mostly;
> -static struct dentry *filter_dent           __read_mostly;
>   
>   /* per-driver filter related state */
>   
> @@ -840,66 +832,18 @@ static const struct file_operations filter_fops = {
>   	.llseek = default_llseek,
>   };
>   
> -static int dma_debug_fs_init(void)
> +static void dma_debug_fs_init(void)
>   {
>   	dma_debug_dent = debugfs_create_dir("dma-api", NULL);
> -	if (!dma_debug_dent) {
> -		pr_err("can not create debugfs directory\n");
> -		return -ENOMEM;
> -	}
> -
> -	global_disable_dent = debugfs_create_bool("disabled", 0444,
> -			dma_debug_dent,
> -			&global_disable);
> -	if (!global_disable_dent)
> -		goto out_err;
> -
> -	error_count_dent = debugfs_create_u32("error_count", 0444,
> -			dma_debug_dent, &error_count);
> -	if (!error_count_dent)
> -		goto out_err;
> -
> -	show_all_errors_dent = debugfs_create_u32("all_errors", 0644,
> -			dma_debug_dent,
> -			&show_all_errors);
> -	if (!show_all_errors_dent)
> -		goto out_err;
> -
> -	show_num_errors_dent = debugfs_create_u32("num_errors", 0644,
> -			dma_debug_dent,
> -			&show_num_errors);
> -	if (!show_num_errors_dent)
> -		goto out_err;
> -
> -	num_free_entries_dent = debugfs_create_u32("num_free_entries", 0444,
> -			dma_debug_dent,
> -			&num_free_entries);
> -	if (!num_free_entries_dent)
> -		goto out_err;
> -
> -	min_free_entries_dent = debugfs_create_u32("min_free_entries", 0444,
> -			dma_debug_dent,
> -			&min_free_entries);
> -	if (!min_free_entries_dent)
> -		goto out_err;
> -
> -	nr_total_entries_dent = debugfs_create_u32("nr_total_entries", 0444,
> -			dma_debug_dent,
> -			&nr_total_entries);
> -	if (!nr_total_entries_dent)
> -		goto out_err;
> -
> -	filter_dent = debugfs_create_file("driver_filter", 0644,
> -					  dma_debug_dent, NULL, &filter_fops);
> -	if (!filter_dent)
> -		goto out_err;
> -
> -	return 0;
>   
> -out_err:
> -	debugfs_remove_recursive(dma_debug_dent);
> -
> -	return -ENOMEM;
> +	debugfs_create_bool("disabled", 0444, dma_debug_dent, &global_disable);
> +	debugfs_create_u32("error_count", 0444, dma_debug_dent, &error_count);
> +	debugfs_create_u32("all_errors", 0644, dma_debug_dent, &show_all_errors);
> +	debugfs_create_u32("num_errors", 0644, dma_debug_dent, &show_num_errors);
> +	debugfs_create_u32("num_free_entries", 0444, dma_debug_dent, &num_free_entries);
> +	debugfs_create_u32("min_free_entries", 0444, dma_debug_dent, &min_free_entries);
> +	debugfs_create_u32("nr_total_entries", 0444, dma_debug_dent, &nr_total_entries);
> +	debugfs_create_file("driver_filter", 0644, dma_debug_dent, NULL, &filter_fops);
>   }
>   
>   static int device_dma_allocations(struct device *dev, struct dma_debug_entry **out_entry)
> @@ -985,12 +929,7 @@ static int dma_debug_init(void)
>   		spin_lock_init(&dma_entry_hash[i].lock);
>   	}
>   
> -	if (dma_debug_fs_init() != 0) {
> -		pr_err("error creating debugfs entries - disabling\n");
> -		global_disable = true;
> -
> -		return 0;
> -	}
> +	dma_debug_fs_init();
>   
>   	nr_pages = DIV_ROUND_UP(nr_prealloc_entries, DMA_DEBUG_DYNAMIC_ENTRIES);
>   	for (i = 0; i < nr_pages; ++i)
> 
