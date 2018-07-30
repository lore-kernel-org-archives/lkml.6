Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D7EC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 01:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8BC20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 01:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhfRzcAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8BC20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbeG3DKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 23:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728628AbeG3DKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 23:10:52 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09FBE20873;
        Mon, 30 Jul 2018 01:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532914697;
        bh=Cke4JUXL27dk3AQKmfLNhnABuTQubcUwRqeJsBMqEiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UhfRzcAjxldv9iSFm6U6a/9Irh34x79TWF2wcBNPJwszFbQFXPBeDb8aqPBBeP4P/
         XbMLcMOFxuOl0w87kkkd0b4aTZJjtSHC8ovqxFa8sztmgRiI1uDb2siTDXGGLFY5pg
         9jtfW4p+73qZ4BZoW/em8fg65vURszllijDwgTqM=
Date:   Sun, 29 Jul 2018 18:38:16 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid race between zero_range and
 background GC
Message-ID: <20180730013816.GA15708@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180726104536.114340-1-yuchao0@huawei.com>
 <20180727102916.GI16155@jaegeuk-macbookpro.roam.corp.google.com>
 <10d7814b-06d0-6751-ca56-85e7c8b92a27@kernel.org>
 <20180729020254.GH83620@jaegeuk-macbookpro.roam.corp.google.com>
 <6d86bad1-52fa-2309-9403-47490345e372@kernel.org>
 <20180729025930.GA95148@jaegeuk-macbookpro.roam.corp.google.com>
 <d6e6a1c0-c56a-aac8-a210-945cce17f5b3@kernel.org>
 <20180729051459.GB97518@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729051459.GB97518@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/28, Jaegeuk Kim wrote:
> On 07/29, Chao Yu wrote:
> > On 2018/7/29 10:59, Jaegeuk Kim wrote:
> > > On 07/29, Chao Yu wrote:
> > >> On 2018/7/29 10:02, Jaegeuk Kim wrote:
> > >>> On 07/27, Chao Yu wrote:
> > >>>> On 2018/7/27 18:29, Jaegeuk Kim wrote:
> > >>>>> On 07/26, Chao Yu wrote:
> > >>>>>> Thread A				Background GC
> > >>>>>> - f2fs_zero_range
> > >>>>>>  - truncate_pagecache_range
> > >>>>>> 					- gc_data_segment
> > >>>>>> 					 - get_read_data_page
> > >>>>>> 					  - move_data_page
> > >>>>>> 					   - set_page_dirty
> > >>>>>> 					   - set_cold_data
> > >>>>>>  - f2fs_do_zero_range
> > >>>>>>   - dn->data_blkaddr = NEW_ADDR;
> > >>>>>>   - f2fs_set_data_blkaddr
> > >>>>>>
> > >>>>>> Actually, we don't need to set dirty & checked flag on the page, since
> > >>>>>> all valid data in the page should be zeroed by zero_range().
> > >>>>>
> > >>>>> But, it doesn't matter too much, right?
> > >>>>
> > >>>> No, if the dirtied page is writebacked after f2fs_do_zero_range(), result of
> > >>>> zero_range() should be wrong, as zeroed page contains valid user data.
> > >>>
> > >>> How about truncating page caches after block address change or doing it twice
> > >>> before and after?
> > >>
> > >> Thread A				Background GC
> > >> - f2fs_zero_range
> > >>  - truncate_pagecache_range
> > >> 					- gc_data_segment
> > >> 					 - get_read_data_page
> > >> 					  - move_data_page
> > >> 					   - set_page_dirty
> > >> 					   - set_cold_data
> > >>  - f2fs_do_zero_range
> > >>   - dn->data_blkaddr = NEW_ADDR;
> > >>   - f2fs_set_data_blkaddr
> > >> 					bdi-flusher
> > >> 					- __write_data_page
> > >> 					 - f2fs_update_data_blkaddr
> > >> 					 : data_blkaddr has been updated here.
> > >>  - truncate_pagecache_range
> > >>  : data & dnode has been writebacked before page cache truncation?
> > >>
> > >> How about this case?
> > > 
> > > So, truncating pages under dnode lock can address it?
> > 
> > Normally, our lock dependency is
> > 
> > ->writepage()
> > lock data page -> lock dnode page
> > 
> > here
> > lock dnode page -> truncate_pagecache_range::lock data page
> > 
> > Will easily cause deadlock?
> 
> Yeah. Can we add an inode flag to bypass GC in this case, then?

Hmm, BTW, how about using i_gc_rwsem[WRITE] in a very narrow scope?

for (index = pg_start; index < pg_end;) {
	f2fs_lock_op();
	down_write(i_gc_rwsem[WRITE]);
	truncate_page_cache_range(index, index + 4k);
	f2fs_do_zero_range(&dn, index, end);
	up_write(i_gc_rwsem[WRITE]);
	f2fs_unlock_op();
	f2fs_balance_fs();
}

> 
> > 
> > Thanks,
> > 
> > > 
> > >>
> > >> Thanks,
> > >>
> > >>>
> > >>>>
> > >>>>>
> > >>>>>> Use i_gc_rwsem[WRITE] to avoid such race condition.
> > >>>>>
> > >>>>> Hope to avoid abusing i_gc_rwsem[] tho.
> > >>>>
> > >>>> Agreed, let's try avoiding until we have to use it.
> > >>>>
> > >>>> Thanks,
> > >>>>
> > >>>>>
> > >>>>>>
> > >>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > >>>>>> ---
> > >>>>>>  fs/f2fs/file.c | 2 ++
> > >>>>>>  1 file changed, 2 insertions(+)
> > >>>>>>
> > >>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > >>>>>> index 267ec3794e1e..7bd2412a8c37 100644
> > >>>>>> --- a/fs/f2fs/file.c
> > >>>>>> +++ b/fs/f2fs/file.c
> > >>>>>> @@ -1309,6 +1309,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
> > >>>>>>  	if (ret)
> > >>>>>>  		return ret;
> > >>>>>>  
> > >>>>>> +	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > >>>>>>  	down_write(&F2FS_I(inode)->i_mmap_sem);
> > >>>>>>  	ret = filemap_write_and_wait_range(mapping, offset, offset + len - 1);
> > >>>>>>  	if (ret)
> > >>>>>> @@ -1389,6 +1390,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
> > >>>>>>  	}
> > >>>>>>  out_sem:
> > >>>>>>  	up_write(&F2FS_I(inode)->i_mmap_sem);
> > >>>>>> +	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > >>>>>>  
> > >>>>>>  	return ret;
> > >>>>>>  }
> > >>>>>> -- 
> > >>>>>> 2.18.0.rc1
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
