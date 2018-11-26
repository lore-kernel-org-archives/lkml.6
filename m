Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1584C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2D9208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2D9208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeK0How (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:44:52 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37778 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeK0How (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:44:52 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9289AB0A;
        Mon, 26 Nov 2018 20:49:30 +0000 (UTC)
Date:   Mon, 26 Nov 2018 12:49:28 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] zram: fix lockdep warning of free block handling
Message-Id: <20181126124928.8fbbf01966b741ac79a3d003@linux-foundation.org>
In-Reply-To: <20181126082813.81977-2-minchan@kernel.org>
References: <20181126082813.81977-1-minchan@kernel.org>
        <20181126082813.81977-2-minchan@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 17:28:07 +0900 Minchan Kim <minchan@kernel.org> wrote:

> 
> ...
>
> With writeback feature, zram_slot_free_notify could be called
> in softirq context by end_swap_bio_read. However, bitmap_lock
> is not aware of that so lockdep yell out. Thanks.
> 
> The problem is not only bitmap_lock but it is also zram_slot_lock
> so straightforward solution would disable irq on zram_slot_lock
> which covers every bitmap_lock, too.
> Although duration disabling the irq is short in many places
> zram_slot_lock is used, a place(ie, decompress) is not fast
> enough to hold irqlock on relying on compression algorithm
> so it's not a option.
> 
> The approach in this patch is just "best effort", not guarantee
> "freeing orphan zpage". If the zram_slot_lock contention may happen,
> kernel couldn't free the zpage until it recycles the block. However,
> such contention between zram_slot_free_notify and other places to
> hold zram_slot_lock should be very rare in real practice.
> To see how often it happens, this patch adds new debug stat
> "miss_free".
> 
> It also adds irq lock in get/put_block_bdev to prevent deadlock
> lockdep reported. The reason I used irq disable rather than bottom
> half is swap_slot_free_notify could be called with irq disabled
> so it breaks local_bh_enable's rule. The irqlock works on only
> writebacked zram slot entry so it should be not frequent lock.
> 
> Cc: stable@vger.kernel.org # 4.14+
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  drivers/block/zram/zram_drv.c | 56 +++++++++++++++++++++++++----------
>  drivers/block/zram/zram_drv.h |  1 +
>  2 files changed, 42 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 4879595200e1..472027eaed60 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -53,6 +53,11 @@ static size_t huge_class_size;
>  
>  static void zram_free_page(struct zram *zram, size_t index);
>  
> +static int zram_slot_trylock(struct zram *zram, u32 index)
> +{
> +	return bit_spin_trylock(ZRAM_LOCK, &zram->table[index].value);
> +}
> +
>  static void zram_slot_lock(struct zram *zram, u32 index)
>  {
>  	bit_spin_lock(ZRAM_LOCK, &zram->table[index].value);
> @@ -443,29 +448,45 @@ static ssize_t backing_dev_store(struct device *dev,
>  
>  static unsigned long get_entry_bdev(struct zram *zram)
>  {
> -	unsigned long entry;
> +	unsigned long blk_idx;
> +	unsigned long ret = 0;
>  
> -	spin_lock(&zram->bitmap_lock);
>  	/* skip 0 bit to confuse zram.handle = 0 */
> -	entry = find_next_zero_bit(zram->bitmap, zram->nr_pages, 1);
> -	if (entry == zram->nr_pages) {
> -		spin_unlock(&zram->bitmap_lock);
> -		return 0;
> +	blk_idx = find_next_zero_bit(zram->bitmap, zram->nr_pages, 1);
> +	if (blk_idx == zram->nr_pages)
> +		goto retry;
> +
> +	spin_lock_irq(&zram->bitmap_lock);
> +	if (test_bit(blk_idx, zram->bitmap)) {
> +		spin_unlock_irq(&zram->bitmap_lock);
> +		goto retry;
>  	}
>  
> -	set_bit(entry, zram->bitmap);
> -	spin_unlock(&zram->bitmap_lock);
> +	set_bit(blk_idx, zram->bitmap);

Here we could do

	if (test_and_set_bit(...)) {
		spin_unlock(...);
		goto retry;

But it's weird to take the spinlock on behalf of bitops which are
already atomic!

It seems rather suspicious to me.  Why are we doing this?

> +	ret = blk_idx;
> +	goto out;
> +retry:
> +	spin_lock_irq(&zram->bitmap_lock);
> +	blk_idx = find_next_zero_bit(zram->bitmap, zram->nr_pages, 1);
> +	if (blk_idx == zram->nr_pages)
> +		goto out;
> +
> +	set_bit(blk_idx, zram->bitmap);
> +	ret = blk_idx;
> +out:
> +	spin_unlock_irq(&zram->bitmap_lock);
>  
> -	return entry;
> +	return ret;
>  }
>  
>  static void put_entry_bdev(struct zram *zram, unsigned long entry)
>  {
>  	int was_set;
> +	unsigned long flags;
>  
> -	spin_lock(&zram->bitmap_lock);
> +	spin_lock_irqsave(&zram->bitmap_lock, flags);
>  	was_set = test_and_clear_bit(entry, zram->bitmap);
> -	spin_unlock(&zram->bitmap_lock);
> +	spin_unlock_irqrestore(&zram->bitmap_lock, flags);

Here's another one.  Surely that locking is unnecessary.

>  	WARN_ON_ONCE(!was_set);
>  }
>  

