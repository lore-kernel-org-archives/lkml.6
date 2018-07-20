Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA263ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5018520661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5018520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeGTUzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:55:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46352 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbeGTUzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:55:53 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5D50FCBE;
        Fri, 20 Jul 2018 20:06:04 +0000 (UTC)
Date:   Fri, 20 Jul 2018 13:06:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+9933e4476f365f5d5a1b@syzkaller.appspotmail.com>,
        linux-mm@kvack.org, mgorman@techsingularity.net,
        Michal Hocko <mhocko@kernel.org>, ak@linux.intel.com,
        jack@suse.cz, jlayton@redhat.com, linux-kernel@vger.kernel.org,
        mawilcox@microsoft.com, syzkaller-bugs@googlegroups.com,
        tim.c.chen@linux.intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: INFO: task hung in generic_file_write_iter
Message-Id: <20180720130602.f3d6dc4c943558875a36cb52@linux-foundation.org>
In-Reply-To: <9b9fcdda-c347-53ee-fdbb-8a7d11cf430e@I-love.SAKURA.ne.jp>
References: <0000000000009ce88d05714242a8@google.com>
        <4b349bff-8ad4-6410-250d-593b13d8d496@I-love.SAKURA.ne.jp>
        <9b9fcdda-c347-53ee-fdbb-8a7d11cf430e@I-love.SAKURA.ne.jp>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 19:36:23 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> > 
> > This report is stalling after mount() completed and process used remap_file_pages().
> > I think that we might need to use debug printk(). But I don't know what to examine.
> > 
> 
> Andrew, can you pick up this debug printk() patch?
> I guess we can get the result within one week.

Sure, let's toss it in -next for a while.

> >From 8f55e00b21fefffbc6abd9085ac503c52a302464 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Fri, 20 Jul 2018 19:29:06 +0900
> Subject: [PATCH] fs/buffer.c: add debug print for __getblk_gfp() stall problem
> 
> Among syzbot's unresolved hung task reports, 18 out of 65 reports contain
> __getblk_gfp() line in the backtrace. Since there is a comment block that
> says that __getblk_gfp() will lock up the machine if try_to_free_buffers()
> attempt from grow_dev_page() is failing, let's start from checking whether
> syzbot is hitting that case. This change will be removed after the bug is
> fixed.

I'm not sure that grow_dev_page() is hanging.  It has often been
suspected, but always is proven innocent.  Lets see.

>
> ...
>
> @@ -978,6 +988,9 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
>  	spin_unlock(&inode->i_mapping->private_lock);
>  done:
>  	ret = (block < end_block) ? 1 : -ENXIO;
> +#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
> +	current->getblk_executed |= 0x08;
> +#endif
>  failed:
>  	unlock_page(page);
>  	put_page(page);
> @@ -1033,6 +1046,12 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)

Something is wrong with your diff(1).  That's grow_dev_page(), not
blkdev_max_block().

>  		return NULL;
>  	}
>  
> +#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
> +	current->getblk_stamp = jiffies;

AFACIT getblk_stamp didn't need to be in the task_struct - it could be
a local.  Doesn't matter much.

> +	current->getblk_executed = 0;
> +	current->getblk_bh_count = 0;
> +	current->getblk_bh_state = 0;
> +#endif
>  	for (;;) {
>  		struct buffer_head *bh;
>  		int ret;
> @@ -1044,6 +1063,18 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
>  		ret = grow_buffers(bdev, block, size, gfp);
>  		if (ret < 0)
>  			return NULL;
> +
> +#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
> +		if (!time_after(jiffies, current->getblk_stamp + 3 * HZ))
> +			continue;
> +		printk(KERN_ERR "%s(%u): getblk(): executed=%x bh_count=%d bh_state=%lx\n",
> +		       current->comm, current->pid, current->getblk_executed,
> +		       current->getblk_bh_count, current->getblk_bh_state);
> +		current->getblk_executed = 0;
> +		current->getblk_bh_count = 0;
> +		current->getblk_bh_state = 0;
> +		current->getblk_stamp = jiffies;
> +#endif
>  	}
>  }
>  
> @@ -3216,6 +3247,11 @@ int sync_dirty_buffer(struct buffer_head *bh)
>   */
>  static inline int buffer_busy(struct buffer_head *bh)
>  {
> +#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
> +	current->getblk_executed |= 0x80;
> +	current->getblk_bh_count = atomic_read(&bh->b_count);
> +	current->getblk_bh_state = bh->b_state;
> +#endif

Some explanation of your design wouldn't have hurt.  What does
getblk_executed do, why were these particular fields chosen?

>  	return atomic_read(&bh->b_count) |
>  		(bh->b_state & ((1 << BH_Dirty) | (1 << BH_Lock)));
>  }
>
> ...
>

