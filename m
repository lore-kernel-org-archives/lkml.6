Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC723ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555FA20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jatdVvi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555FA20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387994AbeGWNAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387830AbeGWNAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:00:18 -0400
Received: from localhost (unknown [14.52.27.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09A5520856;
        Mon, 23 Jul 2018 11:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532347165;
        bh=mz5YcZOrWidr+UzqGR94FSNJMm9iyWoE4P0FkipPs7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jatdVvi/+1a4hnjXy+hl6vDDADFtgztJNjIsnTIs1yMzDMHJOLWVV/bq4FJQhplED
         18aNPYUK5ArHZO+uExOZii2XN6XR2nuGsyYTOzOGADHqGI+2Q6/8w6rs2U8/flBeA4
         nITPT6bTbzRnteZw9m/rk8irBFsf1C2i6qdohkyg=
Date:   Mon, 23 Jul 2018 20:59:18 +0900
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/3] f2fs: keep meta pages in cp_error state
Message-ID: <20180723115918.GC16679@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180715011112.11475-1-jaegeuk@kernel.org>
 <20180715011112.11475-2-jaegeuk@kernel.org>
 <75771f42-d3ab-73d4-8cd8-98ee7d26a49b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75771f42-d3ab-73d4-8cd8-98ee7d26a49b@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16, Chao Yu wrote:
> On 2018/7/15 9:11, Jaegeuk Kim wrote:
> > It turns out losing meta pages in shutdown period makes f2fs very unstable
> > so that I could see many unexpected error conditions.
> > 
> > Let's keep meta pages for fault injection and sudden power-off tests.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/checkpoint.c | 28 +++++++++++++---------------
> >  1 file changed, 13 insertions(+), 15 deletions(-)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 9f1c96caebda..37ec0f16448e 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -242,11 +242,8 @@ static int __f2fs_write_meta_page(struct page *page,
> >  
> >  	trace_f2fs_writepage(page, META);
> >  
> > -	if (unlikely(f2fs_cp_error(sbi))) {
> > -		dec_page_count(sbi, F2FS_DIRTY_META);
> > -		unlock_page(page);
> > -		return 0;
> > -	}
> > +	if (unlikely(f2fs_cp_error(sbi)))
> > +		goto redirty_out;
> >  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
> >  		goto redirty_out;
> >  	if (wbc->for_reclaim && page->index < GET_SUM_BLOCK(sbi, 0))
> > @@ -1129,6 +1126,9 @@ static void wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
> >  		if (!get_pages(sbi, F2FS_WB_CP_DATA))
> >  			break;
> >  
> > +		if (unlikely(f2fs_cp_error(sbi)))
> > +			break;
> > +
> >  		io_schedule_timeout(5*HZ);
> >  	}
> >  	finish_wait(&sbi->cp_wait, &wait);
> > @@ -1202,8 +1202,12 @@ static void commit_checkpoint(struct f2fs_sb_info *sbi,
> >  
> >  	/* writeout cp pack 2 page */
> >  	err = __f2fs_write_meta_page(page, &wbc, FS_CP_META_IO);
> > -	f2fs_bug_on(sbi, err);
> > +	if (unlikely(err && f2fs_cp_error(sbi))) {
> > +		f2fs_put_page(page, 1);
> > +		return;
> > +	}
> >  
> > +	f2fs_bug_on(sbi, err);
> >  	f2fs_put_page(page, 0);
> >  
> >  	/* submit checkpoint (with barrier if NOBARRIER is not set) */
> > @@ -1229,7 +1233,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >  	while (get_pages(sbi, F2FS_DIRTY_META)) {
> >  		f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
> >  		if (unlikely(f2fs_cp_error(sbi)))
> > -			return -EIO;
> > +			break;
> >  	}
> >  
> >  	/*
> > @@ -1309,7 +1313,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >  			f2fs_sync_meta_pages(sbi, META, LONG_MAX,
> >  							FS_CP_META_IO);
> >  			if (unlikely(f2fs_cp_error(sbi)))
> > -				return -EIO;
> > +				break;
> >  		}
> >  	}
> >  
> > @@ -1350,9 +1354,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >  	/* wait for previous submitted meta pages writeback */
> >  	wait_on_all_pages_writeback(sbi);
> >  
> > -	if (unlikely(f2fs_cp_error(sbi)))
> > -		return -EIO;
> > -
> >  	/* flush all device cache */
> >  	err = f2fs_flush_device_cache(sbi);
> >  	if (err)
> > @@ -1364,9 +1365,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >  
> >  	f2fs_release_ino_entry(sbi, false);
> >  
> > -	if (unlikely(f2fs_cp_error(sbi)))
> > -		return -EIO;
> > -
> >  	clear_sbi_flag(sbi, SBI_IS_DIRTY);
> >  	clear_sbi_flag(sbi, SBI_NEED_CP);
> >  	__set_cp_next_pack(sbi);
> > @@ -1381,7 +1379,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >  
> >  	f2fs_bug_on(sbi, get_pages(sbi, F2FS_DIRTY_DENTS));
> >  
> > -	return 0;
> > +	return unlikely(f2fs_cp_error(sbi));
> 
> return unlikely(f2fs_cp_error(sbi)) ? -EIO : 0;
> 

Done.

> >  }
> >  
> >  /*
> > 
