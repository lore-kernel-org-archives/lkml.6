Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFC3C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DA520893
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA9b4pUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61DA520893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeG2ENk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 00:13:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeG2ENk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 00:13:40 -0400
Received: from localhost (c-67-160-202-76.hsd1.ca.comcast.net [67.160.202.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61B0720873;
        Sun, 29 Jul 2018 02:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532832297;
        bh=Ai+ozz8vNnucMy2c4K3OXLfbY9HfwK3i4pJloe/jWI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RA9b4pUwVMZrQc55+rAMUUMKhED/Fw7qn1Vzl6+N3MvXvC8X2CYfeZAMis4ND5U7s
         6mukNpKYO/ldZ1G61Xk5s+hV3QkqBII+uKzuFLH71TK0wA7xE0sx/rvbPgUrJvVAaO
         FlE4HqGtYZlcobWhp9vEumGd1KqQLSOEchZfBaRs=
Date:   Sat, 28 Jul 2018 19:44:56 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Weichao Guo <guoweichao@huawei.com>
Subject: Re: [PATCH 4/4] f2fs: fix to spread clear_cold_data()
Message-ID: <20180729024456.GJ83620@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180727101516.41403-1-yuchao0@huawei.com>
 <20180727101516.41403-4-yuchao0@huawei.com>
 <20180729020013.GG83620@jaegeuk-macbookpro.roam.corp.google.com>
 <b7d39e79-dfb0-17c3-1eee-6afb969008a4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7d39e79-dfb0-17c3-1eee-6afb969008a4@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29, Chao Yu wrote:
> On 2018/7/29 10:00, Jaegeuk Kim wrote:
> > On 07/27, Chao Yu wrote:
> >> We need to drop PG_checked flag on page as well when we clear PG_uptodate
> >> flag, in order to avoid treating the page as GCing one later.
> > 
> > What do you mean "treating the page as GCing one"?
> 
> I mean if PG_checked flag in page is not cleared, allocator will make it goes
> into cold area.
> 
> static int __get_segment_type_6(struct f2fs_io_info *fio)
> ...
> 		if (is_cold_data(fio->page) || file_is_cold(inode))
> 			return CURSEG_COLD_DATA;

This will come only when page is dirty. So, it'd better to clear this in
f2fs_set_data_page_dirty()? set_cold_data() is called after set_page_dirty().

> 
> Thanks,
> 
> > 
> >>
> >> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/data.c    | 8 +++++++-
> >>  fs/f2fs/dir.c     | 1 +
> >>  fs/f2fs/segment.c | 4 +++-
> >>  3 files changed, 11 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >> index a29f3162b887..2817e2f4eb17 100644
> >> --- a/fs/f2fs/data.c
> >> +++ b/fs/f2fs/data.c
> >> @@ -1768,6 +1768,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
> >>  	/* This page is already truncated */
> >>  	if (fio->old_blkaddr == NULL_ADDR) {
> >>  		ClearPageUptodate(page);
> >> +		clear_cold_data(page);
> >>  		goto out_writepage;
> >>  	}
> >>  got_it:
> >> @@ -1943,8 +1944,10 @@ static int __write_data_page(struct page *page, bool *submitted,
> >>  
> >>  out:
> >>  	inode_dec_dirty_pages(inode);
> >> -	if (err)
> >> +	if (err) {
> >>  		ClearPageUptodate(page);
> >> +		clear_cold_data(page);
> >> +	}
> >>  
> >>  	if (wbc->for_reclaim) {
> >>  		f2fs_submit_merged_write_cond(sbi, inode, 0, page->index, DATA);
> >> @@ -2534,6 +2537,8 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
> >>  		}
> >>  	}
> >>  
> >> +	clear_cold_data(page);
> >> +
> >>  	/* This is atomic written page, keep Private */
> >>  	if (IS_ATOMIC_WRITTEN_PAGE(page))
> >>  		return f2fs_drop_inmem_page(inode, page);
> >> @@ -2552,6 +2557,7 @@ int f2fs_release_page(struct page *page, gfp_t wait)
> >>  	if (IS_ATOMIC_WRITTEN_PAGE(page))
> >>  		return 0;
> >>  
> >> +	clear_cold_data(page);
> >>  	set_page_private(page, 0);
> >>  	ClearPagePrivate(page);
> >>  	return 1;
> >> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> >> index 7f955c4e86a4..1e4a4122eb0c 100644
> >> --- a/fs/f2fs/dir.c
> >> +++ b/fs/f2fs/dir.c
> >> @@ -734,6 +734,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
> >>  		clear_page_dirty_for_io(page);
> >>  		ClearPagePrivate(page);
> >>  		ClearPageUptodate(page);
> >> +		clear_cold_data(page);
> >>  		inode_dec_dirty_pages(dir);
> >>  		f2fs_remove_dirty_inode(dir);
> >>  	}
> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >> index 58abbdc53561..4d83961745e6 100644
> >> --- a/fs/f2fs/segment.c
> >> +++ b/fs/f2fs/segment.c
> >> @@ -267,8 +267,10 @@ static int __revoke_inmem_pages(struct inode *inode,
> >>  		}
> >>  next:
> >>  		/* we don't need to invalidate this in the sccessful status */
> >> -		if (drop || recover)
> >> +		if (drop || recover) {
> >>  			ClearPageUptodate(page);
> >> +			clear_cold_data(page);
> >> +		}
> >>  		set_page_private(page, 0);
> >>  		ClearPagePrivate(page);
> >>  		f2fs_put_page(page, 1);
> >> -- 
> >> 2.18.0.rc1
