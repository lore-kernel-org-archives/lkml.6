Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeCPWW7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 18:22:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33224 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeCPWW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 18:22:57 -0400
Date: Fri, 16 Mar 2018 15:22:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: shunki-fujita <shunki-fujita@cybozu.co.jp>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] fs: don't flush pagecache when expanding block device
Message-Id: <20180316152256.2f4883edc3cb6b374bcdd448@linux-foundation.org>
In-Reply-To: <1521183353-144817-1-git-send-email-shunki-fujita@cybozu.co.jp>
References: <1521183353-144817-1-git-send-email-shunki-fujita@cybozu.co.jp>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018 15:55:53 +0900 shunki-fujita <shunki-fujita@cybozu.co.jp> wrote:

> When changing the size of a block device, its all caches are freed.
> It's necessary on shrinking to prevent spurious I/Os to the disappeared region.
> However, on expanding, such kind of I/Os doesn't happen.
> 
> Similar things can be considered for btrfs filesystem resize and resize2fs,
> but they are designed not to cache drops when expanding.
> Therefore this patch removes unnecessary cache drop.

Yes, the patch removes the flush_disk() call when shrinking.  But it
adds additional code which is unchangelogged and uncommented.  What's
happening here?

> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1337,7 +1337,14 @@ void check_disk_size_change(struct gendisk *disk, struct block_device *bdev)
>  		       "%s: detected capacity change from %lld to %lld\n",
>  		       disk->disk_name, bdev_size, disk_size);
>  		i_size_write(bdev->bd_inode, disk_size);
> -		flush_disk(bdev, false);
> +		if (bdev_size > disk_size) {
> +			flush_disk(bdev, false);
> +		} else {
> +			if (!bdev->bd_disk)
> +				return;
> +			if (disk_part_scan_enabled(bdev->bd_disk))
> +				bdev->bd_invalidated = 1;
> +		}
>  	}
>  }

Oh, I see.  It's a copy-n-paste of some mystery uncommented,
lost-in-the-mists-of-time code from flush_disk().  Argh.

The world would be a better place if we could move that bit of code
into a separate function, figure out what it does, document it and call
it from both sites.
