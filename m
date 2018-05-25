Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968212AbeEYTyP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 15:54:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967859AbeEYTyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 15:54:14 -0400
Date: Fri, 25 May 2018 15:54:10 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Toshi Kani <toshi.kani@hpe.com>, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH 4/7] dm: prevent DAX mounts if not supported
Message-ID: <20180525195410.GA11008@redhat.com>
References: <20180525025518.11405-1-ross.zwisler@linux.intel.com>
 <20180525025518.11405-5-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525025518.11405-5-ross.zwisler@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24 2018 at 10:55pm -0400,
Ross Zwisler <ross.zwisler@linux.intel.com> wrote:

> Currently the code in dm_dax_direct_access() only checks whether the target
> type has a direct_access() operation defined, not whether the underlying
> block devices all support DAX.  This latter property can be seen by looking
> at whether we set the QUEUE_FLAG_DAX request queue flag when creating the
> DM device.
> 
> This is problematic if we have, for example, a dm-linear device made up of
> a PMEM namespace in fsdax mode followed by a ramdisk from BRD.
> QUEUE_FLAG_DAX won't be set on the dm-linear device's request queue, but
> we have a working direct_access() entry point and the first member of the
> dm-linear set *does* support DAX.
> 
> This allows the user to create a filesystem on the dm-linear device, and
> then mount it with DAX.  The filesystem's bdev_dax_supported() test will
> pass because it'll operate on the first member of the dm-linear device,
> which happens to be a fsdax PMEM namespace.
> 
> All DAX I/O will then fail to that dm-linear device because the lack of
> QUEUE_FLAG_DAX prevents fs_dax_get_by_bdev() from working.  This means that
> the struct dax_device isn't ever set in the filesystem, so
> dax_direct_access() will always return -EOPNOTSUPP.
> 
> By failing out of dm_dax_direct_access() if QUEUE_FLAG_DAX isn't set we let
> the filesystem know we don't support DAX at mount time.  The filesystem
> will then silently fall back and remove the dax mount option, causing it to
> work properly.
> 
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> Fixes: commit 545ed20e6df6 ("dm: add infrastructure for DAX support")
> ---
>  drivers/md/dm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 0a7b0107ca78..9728433362d1 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1050,14 +1050,13 @@ static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
>  
>  	if (!ti)
>  		goto out;
> -	if (!ti->type->direct_access)
> +	if (!blk_queue_dax(md->queue))
>  		goto out;
>  	len = max_io_len(sector, ti) / PAGE_SECTORS;
>  	if (len < 1)
>  		goto out;
>  	nr_pages = min(len, nr_pages);
> -	if (ti->type->direct_access)
> -		ret = ti->type->direct_access(ti, pgoff, nr_pages, kaddr, pfn);
> +	ret = ti->type->direct_access(ti, pgoff, nr_pages, kaddr, pfn);

So I followed all the rationale for this patch.  But the last change
doesn't make any sense.  We should still verify that the target has
ti->type->direct_access before calling it.  So please reinstate that
check before calling it.

Thanks,
Mike
