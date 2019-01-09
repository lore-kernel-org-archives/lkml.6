Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474D3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE3E21726
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547008689;
	bh=U+qyO39wgIzDxQA8wR8BRzB7fpcIDPP0u0Fq6XIbYlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cXvkao5AoCZBhZ9dbkm9tgbrff0kUeOBu+TGfhwXQNkNF34MkZL/xr64+ONwcUgw4
	 LRplcuo2/JhrvJs51+A6LXhhGkmD/FBI/sPewbjkq0q/GyBgLoQ84LPqsvoFqrhwU8
	 loowIXCTe1IPLb+P8YpnfUyF9xOclgk7l9gmKY9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfAIEiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 23:38:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728112AbfAIEiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 23:38:03 -0500
Received: from localhost (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A71C214C6;
        Wed,  9 Jan 2019 04:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547008682;
        bh=U+qyO39wgIzDxQA8wR8BRzB7fpcIDPP0u0Fq6XIbYlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RYI00qJ0uuB7YDz8DXpCPXJgzBPO0eRPbbfP5IATXP/MDM/U6VchAtEIzb+Mwhtz2
         LQUl5pATtE+90vq2QulQssRDgFt1ctm22lh6ZbI8zBWMVKoRK9VAVg0mEmpM6wooK2
         UXL6ZaCtYd7r8KueyiVhxtOvsWN5HpLZloqetWXA=
Date:   Tue, 8 Jan 2019 20:38:01 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: fix sbi->extent_list corruption issue
Message-ID: <20190109043801.GB55897@jaegeuk-macbookpro.roam.corp.google.com>
References: <1543207640-31033-1-git-send-email-stummala@codeaurora.org>
 <20190104080535.GB8475@codeaurora.org>
 <20190104203329.GA57873@jaegeuk-macbookpro.roam.corp.google.com>
 <0197c64e-6419-db96-d8a9-d17f446aa9c1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0197c64e-6419-db96-d8a9-d17f446aa9c1@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07, Chao Yu wrote:
> On 2019/1/5 4:33, Jaegeuk Kim wrote:
> > On 01/04, Sahitya Tummala wrote:
> >> On Mon, Nov 26, 2018 at 10:17:20AM +0530, Sahitya Tummala wrote:
> >>> When there is a failure in f2fs_fill_super() after/during
> >>> the recovery of fsync'd nodes, it frees the current sbi and
> >>> retries again. This time the mount is successful, but the files
> >>> that got recovered before retry, still holds the extent tree,
> >>> whose extent nodes list is corrupted since sbi and sbi->extent_list
> >>> is freed up. The list_del corruption issue is observed when the
> >>> file system is getting unmounted and when those recoverd files extent
> >>> node is being freed up in the below context.
> >>>
> >>> list_del corruption. prev->next should be fffffff1e1ef5480, but was (null)
> >>> <...>
> >>> kernel BUG at kernel/msm-4.14/lib/list_debug.c:53!
> >>> task: fffffff1f46f2280 task.stack: ffffff8008068000
> >>> lr : __list_del_entry_valid+0x94/0xb4
> >>> pc : __list_del_entry_valid+0x94/0xb4
> >>> <...>
> >>> Call trace:
> >>> __list_del_entry_valid+0x94/0xb4
> >>> __release_extent_node+0xb0/0x114
> >>> __free_extent_tree+0x58/0x7c
> >>> f2fs_shrink_extent_tree+0xdc/0x3b0
> >>> f2fs_leave_shrinker+0x28/0x7c
> >>> f2fs_put_super+0xfc/0x1e0
> >>> generic_shutdown_super+0x70/0xf4
> >>> kill_block_super+0x2c/0x5c
> >>> kill_f2fs_super+0x44/0x50
> >>> deactivate_locked_super+0x60/0x8c
> >>> deactivate_super+0x68/0x74
> >>> cleanup_mnt+0x40/0x78
> >>> __cleanup_mnt+0x1c/0x28
> >>> task_work_run+0x48/0xd0
> >>> do_notify_resume+0x678/0xe98
> >>> work_pending+0x8/0x14
> >>>
> >>> Fix this by cleaning up inodes, extent tree and nodes of those
> >>> recovered files before freeing up sbi and before next retry.
> >>>
> >> Hi Jaegeuk, Chao,
> >>
> >> I have observed another scenario where the similar list corruption issue
> >> can happen with sbi->inode_list as well. If recover_fsync_data()
> >> fails at some point in write_checkpoint() due to some error and if
> >> those recovered inodes are still dirty, then after the mount is
> >> successful, this issue is observed when that dirty inode is under 
> >> writeback.
> > 
> > recover_fsync_data() does iget/iput in pair, and destroy_fsync_dnodes() drops
> > its dirty list and call iput(), when there is an error. So, after then, there'd
> > be no dirty inodes. If there's no error, checkpoint() flushes quota/dentry pages
> > in dirty inodes as well. Can we check where this dirty inode came from?
> 
> I guess it comes from:
> 
> f2fs_recover_fsync_data()
> 
> 	/* Needed for iput() to work correctly and not trash data */
> 	sbi->sb->s_flags |= SB_ACTIVE;
> 
> iput_final()
> 
> 	if (!drop && (sb->s_flags & SB_ACTIVE)) {
> 		inode_add_lru(inode);
> 		spin_unlock(&inode->i_lock);
> 		return;
> 	}
> 
> So dirty data in those inode can be remained after iput(), then meta/node
> can be persisted during next checkpoint, if checkpoint failed due to error,
> dirty inode remain in system. IIUC.


749         err = recover_data(sbi, &inode_list, &tmp_inode_list, &dir_list);
750         if (!err)
751                 f2fs_bug_on(sbi, !list_empty(&inode_list));
752         else {
753                 /* restore s_flags to let iput() trash data */
754                 sbi->sb->s_flags = s_flags;
755         }

We deactivate sb before iput?

> 
> > 
> > Oh, one sceanrio can be an error by f2fs_disable_checkpoint() which will do GC.
> > 
> >>
> >> [   90.400500] list_del corruption. prev->next should be ffffffed1f566208, but was (null)
> >> [   90.675349] Call trace:
> >> [   90.677869]  __list_del_entry_valid+0x94/0xb4
> >> [   90.682351]  remove_dirty_inode+0xac/0x114
> >> [   90.686563]  __f2fs_write_data_pages+0x6a8/0x6c8
> >> [   90.691302]  f2fs_write_data_pages+0x40/0x4c
> >> [   90.695695]  do_writepages+0x80/0xf0
> >> [   90.699372]  __writeback_single_inode+0xdc/0x4ac
> >> [   90.704113]  writeback_sb_inodes+0x280/0x440
> >> [   90.708501]  wb_writeback+0x1b8/0x3d0
> >> [   90.712267]  wb_workfn+0x1a8/0x4d4
> >> [   90.715765]  process_one_work+0x1c0/0x3d4
> >> [   90.719883]  worker_thread+0x224/0x344
> >> [   90.723739]  kthread+0x120/0x130
> >> [   90.727055]  ret_from_fork+0x10/0x18
> >>
> >> I think it is better to cleanup those inodes completely before freeing sbi
> >> and before next retry as done in this patch. Would you like to re-consider
> >> this patch for this new issue?
> > 
> > The patch was merged in mainline already.
> > Could you take a look at this patch?
> > 
> >>From cb1d20e640402beed300c2bdce79311ee8a781ad Mon Sep 17 00:00:00 2001
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > Date: Fri, 4 Jan 2019 12:29:00 -0800
> > Subject: [PATCH] f2fs: sync filesystem after roll-forward recovery
> 
> You mean android kernel mainline?

I meant the previous patch was upstreamed. We need another patch to address this
second issue.

Thanks,

> 
> Thanks,
> 
> > 
> > Some works after roll-forward recovery can get an error which will release
> > all the data structures. Let's flush them in order to make it clean.
> > 
> > One possible corruption came from:
> > 
> > [   90.400500] list_del corruption. prev->next should be ffffffed1f566208, but was (null)
> > [   90.675349] Call trace:
> > [   90.677869]  __list_del_entry_valid+0x94/0xb4
> > [   90.682351]  remove_dirty_inode+0xac/0x114
> > [   90.686563]  __f2fs_write_data_pages+0x6a8/0x6c8
> > [   90.691302]  f2fs_write_data_pages+0x40/0x4c
> > [   90.695695]  do_writepages+0x80/0xf0
> > [   90.699372]  __writeback_single_inode+0xdc/0x4ac
> > [   90.704113]  writeback_sb_inodes+0x280/0x440
> > [   90.708501]  wb_writeback+0x1b8/0x3d0
> > [   90.712267]  wb_workfn+0x1a8/0x4d4
> > [   90.715765]  process_one_work+0x1c0/0x3d4
> > [   90.719883]  worker_thread+0x224/0x344
> > [   90.723739]  kthread+0x120/0x130
> > [   90.727055]  ret_from_fork+0x10/0x18
> > 
> > Reported-by: Sahitya Tummala <stummala@codeaurora.org>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/super.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 547cb7459be7..bb02186293a3 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -3357,7 +3357,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >  	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
> >  		err = f2fs_disable_checkpoint(sbi);
> >  		if (err)
> > -			goto free_meta;
> > +			goto sync_free_meta;
> >  	} else if (is_set_ckpt_flags(sbi, CP_DISABLED_FLAG)) {
> >  		f2fs_enable_checkpoint(sbi);
> >  	}
> > @@ -3370,7 +3370,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >  		/* After POR, we can run background GC thread.*/
> >  		err = f2fs_start_gc_thread(sbi);
> >  		if (err)
> > -			goto free_meta;
> > +			goto sync_free_meta;
> >  	}
> >  	kvfree(options);
> >  
> > @@ -3392,6 +3392,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >  	f2fs_update_time(sbi, REQ_TIME);
> >  	return 0;
> >  
> > +sync_free_meta:
> > +	/* safe to flush all the data */
> > +	sync_filesystem(sbi->sb);
> > +
> >  free_meta:
> >  	/* flush dirty orphan inode objects */
> >  	f2fs_sync_inode_meta(sbi);
> > 
