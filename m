Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3149C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0155218FD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbfABR0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 12:26:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:51144 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729131AbfABR0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 12:26:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35FB5AE58;
        Wed,  2 Jan 2019 17:26:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 32CC31E1588; Wed,  2 Jan 2019 18:26:36 +0100 (CET)
Date:   Wed, 2 Jan 2019 18:26:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+9933e4476f365f5d5a1b@syzkaller.appspotmail.com>,
        linux-mm@kvack.org, mgorman@techsingularity.net,
        Michal Hocko <mhocko@kernel.org>, ak@linux.intel.com,
        jlayton@redhat.com, linux-kernel@vger.kernel.org,
        mawilcox@microsoft.com, syzkaller-bugs@googlegroups.com,
        tim.c.chen@linux.intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: INFO: task hung in generic_file_write_iter
Message-ID: <20190102172636.GA29127@quack2.suse.cz>
References: <0000000000009ce88d05714242a8@google.com>
 <4b349bff-8ad4-6410-250d-593b13d8d496@I-love.SAKURA.ne.jp>
 <9b9fcdda-c347-53ee-fdbb-8a7d11cf430e@I-love.SAKURA.ne.jp>
 <20180720130602.f3d6dc4c943558875a36cb52@linux-foundation.org>
 <a2df1f24-f649-f5d8-0b2d-66d45b6cb61f@i-love.sakura.ne.jp>
 <20180806100928.x7anab3c3y5q4ssa@quack2.suse.cz>
 <e8a23623-feaf-7730-5492-b329cb0daa21@i-love.sakura.ne.jp>
 <20190102144015.GA23089@quack2.suse.cz>
 <275523c6-f750-44c2-a8a4-f3825eeab788@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <275523c6-f750-44c2-a8a4-f3825eeab788@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-01-19 01:07:25, Tetsuo Handa wrote:
> On 2019/01/02 23:40, Jan Kara wrote:
> > I had a look into this and the only good explanation for this I have is
> > that sb->s_blocksize is different from (1 << sb->s_bdev->bd_inode->i_blkbits).
> > If that would happen, we'd get exactly the behavior syzkaller observes
> > because grow_buffers() would populate different page than
> > __find_get_block() then looks up.
> > 
> > However I don't see how that's possible since the filesystem has the block
> > device open exclusively and blkdev_bszset() makes sure we also have
> > exclusive access to the block device before changing the block device size.
> > So changing block device block size after filesystem gets access to the
> > device should be impossible. 
> > 
> > Anyway, could you perhaps add to your debug patch a dump of 'size' passed
> > to __getblk_slow() and bdev->bd_inode->i_blkbits? That should tell us
> > whether my theory is right or not. Thanks!
> > 
> 
> OK. Andrew, will you add (or fold into) this change?
> 
> From e6f334380ad2c87457bfc2a4058316c47f75824a Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Thu, 3 Jan 2019 01:03:35 +0900
> Subject: [PATCH] fs/buffer.c: dump more info for __getblk_gfp() stall problem
> 
> We need to dump more variables on top of
> "fs/buffer.c: add debug print for __getblk_gfp() stall problem".
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Jan Kara <jack@suse.cz>
> ---
>  fs/buffer.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 580fda0..a50acac 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1066,9 +1066,14 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
>  #ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
>  		if (!time_after(jiffies, current->getblk_stamp + 3 * HZ))
>  			continue;
> -		printk(KERN_ERR "%s(%u): getblk(): executed=%x bh_count=%d bh_state=%lx\n",
> +		printk(KERN_ERR "%s(%u): getblk(): executed=%x bh_count=%d bh_state=%lx "
> +		       "bdev_super_blocksize=%lu size=%u "
> +		       "bdev_super_blocksize_bits=%u bdev_inode_blkbits=%u\n",
>  		       current->comm, current->pid, current->getblk_executed,
> -		       current->getblk_bh_count, current->getblk_bh_state);
> +		       current->getblk_bh_count, current->getblk_bh_state,
> +		       bdev->bd_super->s_blocksize, size,
> +		       bdev->bd_super->s_blocksize_bits,
> +		       bdev->bd_inode->i_blkbits);

Well, bd_super may be NULL if there's no filesystem mounted so it would be
safer to check for this rather than blindly dereferencing it... Otherwise
the change looks good to me.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
